From: David Stevens <dlstevens@us.ibm.com>
Subject: [RFC][ PATCH 0/3] vhost-net: Add mergeable RX buffer support to vhost-net
Date: Tue, 2 Mar 2010 16:20:03 -0800
Message-ID: <OF8B8E9FD7.1F227ED3-ON882576DA.008312B5-882576DB.0001D5AB@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Return-path: <netdev-owner@vger.kernel.org>
Sender: netdev-owner@vger.kernel.org
To: mst@redhat.com, rusty@rustcorp.com.au
Cc: netdev@vger.kernel.org, kvm@vger.kernel.org, virtualization@lists.osdl.org
List-Id: virtualization@lists.linuxfoundation.org

These patches add support for mergeable receive buffers to
vhost-net, allowing it to use multiple virtio buffer heads for a single
receive packet.
                                        +-DLS


Signed-off-by: David L Stevens <dlstevens@us.ibm.com>
