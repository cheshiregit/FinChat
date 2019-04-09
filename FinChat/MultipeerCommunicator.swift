//
//  MultipeerCommunicator.swift
//  FinChat
//
//  Created by Roman Nordshtrem on 19/03/2019.
//  Copyright © 2019 Роман Нордштрем. All rights reserved.
//

import Foundation
import MultipeerConnectivity

protocol CommunicatorDelegate: class {
    // discovering
    func didFoundUser(userID: String, userName: String?)
    func didLostUser(userID: String)

    // errors
    func failedToStartBrowsingForUsers(error: Error)
    func failtedToStartAdvertising(error: Error)

    // messages
    func didReceiveMessage(text: String, fromUser: String, toUser: String)
}

protocol Communicator {

    func sendMessage(string: String, to userID: String, completionHandler: ((_ success: Bool, _ error: Error?) -> Void)?)
    var delegate: CommunicatorDelegate? {get set}
    var online: Bool {get set}
}

class MultipeerCommunicator: NSObject, Communicator {

    weak var delegate: CommunicatorDelegate?

    var online: Bool

    let myPeerID: MCPeerID
    let serviceType = "tinkoff-chat"
    var advertiser: MCNearbyServiceAdvertiser?
    var browser: MCNearbyServiceBrowser?
    var sessions: [String: MCSession] = [:]

    override init() {
        guard let peerId = UIDevice.current.identifierForVendor else {
            fatalError("Error")
        }
        self.myPeerID = MCPeerID(displayName: peerId.uuidString)
        self.online = true
        self.advertiser = MCNearbyServiceAdvertiser(peer: myPeerID, discoveryInfo: ["userName": "Roman"], serviceType: serviceType)
        self.browser = MCNearbyServiceBrowser(peer: myPeerID, serviceType: serviceType)

        super.init()
        self.advertiser?.delegate = self
        self.advertiser?.startAdvertisingPeer()
        print("startAdvertisingPeer")
        self.browser?.delegate = self
        self.browser?.startBrowsingForPeers()
    }

    func sendMessage(string: String, to userID: String, completionHandler: ((Bool, Error?) -> Void)?) {
        if let session = sessions[userID] {

            let message = [
                "eventType": "TextMessage",
                "messageId": self.generateMessageID(),
                "text": string
            ]

            do {
                let data = try JSONSerialization.data(withJSONObject: message, options: [])
                try session.send(data, toPeers: session.connectedPeers, with: .reliable)
                completionHandler?(true, nil)
            } catch {
                print("message not sending: \(error)")
                completionHandler?(false, error )
            }
        }
    }

    func generateMessageID() -> String {
        let string = "\(arc4random_uniform(UINT32_MAX)) + \(Date.timeIntervalSinceReferenceDate) + \(arc4random_uniform(UINT32_MAX))"
            .data(using: .utf8)?.base64EncodedString()
        return string!
    }

    func getSession(displayName: String) -> MCSession? {
        var session = self.sessions[displayName]

        if let session = session {
            return session
        } else {
            session = MCSession(peer: self.myPeerID, securityIdentity: nil, encryptionPreference: .none)
            session?.delegate = self
            self.sessions[displayName] = session
            return session
        }
    }
}

// MARK: - MCNearbyServiceAdvertiserDelegate
extension MultipeerCommunicator: MCNearbyServiceAdvertiserDelegate {

    func advertiser(_ advertiser: MCNearbyServiceAdvertiser, didNotStartAdvertisingPeer error: Error) {
        print("didNotStartAdvertisingPeer")
        self.delegate?.failtedToStartAdvertising(error: error)
        self.online = false
    }

    func advertiser(_ advertiser: MCNearbyServiceAdvertiser, didReceiveInvitationFromPeer peerID: MCPeerID,
                    withContext context: Data?, invitationHandler: @escaping (Bool, MCSession?) -> Void) {
        if let session = self.getSession(displayName: peerID.displayName) {
            if session.connectedPeers.contains(peerID) {
                invitationHandler(true, session)
            }
        }
    }
}

// MARK: - MCNearbyServiceBrowserDelegate
extension MultipeerCommunicator: MCNearbyServiceBrowserDelegate {

    func browser(_ browser: MCNearbyServiceBrowser, didNotStartBrowsingForPeers error: Error) {
        print("didNotStartBrowsingForPeers")
        self.delegate?.failedToStartBrowsingForUsers(error: error)
        self.online = false
    }

    func browser(_ browser: MCNearbyServiceBrowser, lostPeer peerID: MCPeerID) {
        sessions.removeValue(forKey: peerID.displayName)
        self.delegate?.didLostUser(userID: peerID.displayName)
    }

    func browser(_ browser: MCNearbyServiceBrowser, foundPeer peerID: MCPeerID, withDiscoveryInfo info: [String: String]?) {
        if let session = self.getSession(displayName: peerID.displayName) {
            if !session.connectedPeers.contains(peerID) {
                browser.invitePeer(peerID, to: session, withContext: nil, timeout: 10)
                self.delegate?.didFoundUser(userID: peerID.displayName, userName: info?["userName"] ?? "Unidentified user")
            }
        }
    }
}

// MARK: - MCSessionDelegate
extension MultipeerCommunicator: MCSessionDelegate {

    func session(_ session: MCSession, didReceive stream: InputStream, withName streamName: String, fromPeer peerID: MCPeerID) {
    }

    func session(_ session: MCSession, didStartReceivingResourceWithName resourceName: String, fromPeer peerID: MCPeerID, with progress: Progress) {
    }

    func session(_ session: MCSession, didFinishReceivingResourceWithName resourceName: String, fromPeer peerID: MCPeerID,
                 at localURL: URL?, withError error: Error?) {
    }

    func session(_ session: MCSession, peer peerID: MCPeerID, didChange state: MCSessionState) {
        switch state {
        case .connected:
            print("\(peerID) connected")
        case .notConnected:
            print("\(peerID) notConnected")
        default:
            break
        }
    }

    func session(_ session: MCSession, didReceive data: Data, fromPeer peerID: MCPeerID) {
        print("didReceive data")
        do {
            let jsonMessage = try JSONSerialization.jsonObject(with: data, options: []) as? [String: String]
            guard let message = jsonMessage else {
                print("Json Error")
                return
            }
            if let message = message["text"] {
                self.delegate?.didReceiveMessage(text: message, fromUser: peerID.displayName, toUser: myPeerID.displayName)
            }
        } catch {
            print(error)
        }
    }
}
