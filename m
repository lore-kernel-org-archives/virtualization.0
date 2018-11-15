From: jiangyiwen <jiangyiwen@huawei.com>
Subject: [RFC] Discuss about an new idea "Vsock over Virtio-net"
Date: Thu, 15 Nov 2018 11:56:03 +0800
Message-ID: <5BECEE53.7090408@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: stefanha@redhat.com, stefanha@gmail.com, Jason Wang <jasowang@redhat.com>, mst@redhat.com
Cc: netdev@vger.kernel.org, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

Hi Stefan, Michael, Jason and everyone,

Several days ago, I discussed with jason about "Vsock over Virtio-net".
This idea has two advantages:
First, it can use many great features of virtio-net, like batching,
mergeable rx buffer and multiqueue, etc.
Second, it can reduce many duplicate codes and make it easy to be
maintained.

Before the implement, I want to discuss with everyone again, and
want to know everyone's suggestions.

After the discussion, based on this point I will try to implement
this idea, but I am not familiar with the virtio-net, that is a
pity. :(

-------------------------Simple idea------------------------------

1. The packet layout will become as follows:

+---------------------------------+
|        Virtio-net header        |
|(struct virtio_net_hdr_mrg_rxbuf)|
+---------------------------------+
|          Vsock header           |
|    (struct virtio_vsock_hdr)    |
+---------------------------------+
|             payload             |
|      (until end of packet)      |
+---------------------------------+

2. The Guest->Host basic code flow as follow:
                            +------------+
                            |   Client   |
                            +------------+
                                  |
                                  |
+------------------------------------------------------------------+
|VSOCK Core Module                                                 |
|ops->sendmsg; (vsock_stream_sendmsg)                              |
|  -> alloc_skb; /* it will packet a skb buffer, and include vsock |
|                 * hdr and payload */                             |
|  -> dev_queue_xmit(); /* it will call start_xmit(virtio-net.c) */|
|vsock hdr and payload, and then call                              |
+------------------------------------------------------------------+
                                  |
                                  |
+------------------------------------------------------------------+
|Virtio-net Module                                                 |
|start_xmit                                                        |
|  -> add virtio_net_hdr and pack sg in ring desc, notify Host     |
+------------------------------------------------------------------+
                                  |
                                  |
+------------------------------------------------------------------+
|Vhost-net Module                                                  |
|handle_tx                                                         |
|  -> get tx buffer, skip virtio_net_hdr and call Vsock function.  |
| /* This point has some differences, vhost-net use ->sendmsg to   |
|  * forward information, however vsock only need to notify server |
|  * that data ready. */                                           |
+------------------------------------------------------------------+
                                  |
                                  |
+------------------------------------------------------------------+
|VSOCK Core Module                                                 |
|alloc_pkt, copy skb data to pkt.                                  |
|add pkt to rx_queue and notify server to get data.                |
+------------------------------------------------------------------+

3. To Host->Guest
I have a problem and difficult, mainly I know about virtio-net a little),
because I have been doing work related with storage and file system.

The problem as follows:
we should monitor all of socket of vsock in handle_rx, when there are
data coming, and copy data to vq desc. Vhost-net use ->recvmsg to
get data, it is different with socket. To vsock, I think host will
not call ->recvmsg when it need to send message to guest. To net,
vhost-net only as forwarding layer.
