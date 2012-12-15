From: Alexey Zaytsev <alexey.zaytsev@gmail.com>
Subject: [PATCH 1/2] Auto-fix lines after 67023431
Date: Sat, 15 Dec 2012 23:32:10 +0200
Message-ID: <1355607131-17698-1-git-send-email-alexey.zaytsev@gmail.com>
References: <CAJSP0QUEwmd3ZPpzPFO6AN+gqUqD4bCfZwyTo0StwQzoB7+VgA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <CAJSP0QUEwmd3ZPpzPFO6AN+gqUqD4bCfZwyTo0StwQzoB7+VgA@mail.gmail.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Linux Virtualization <virtualization@lists.linux-foundation.org>
Cc: "Michael S. Tsirkin" <mst@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

Looks like commit 67023431 was partially hand-edited, so lyx changes some
lines automatically.

Signed-off-by: Alexey Zaytsev <alexey.zaytsev@gmail.com>

---
 virtio-spec.lyx |   31 +++++++++++++++----------------
 1 file changed, 15 insertions(+), 16 deletions(-)

diff --git a/virtio-spec.lyx b/virtio-spec.lyx
index 6c09180..a20aa77 100644
--- a/virtio-spec.lyx
+++ b/virtio-spec.lyx
@@ -4570,14 +4570,14 @@ status
 
 \change_inserted 1986246365 1354531717
 Only receiveq0, transmitq0 and controlq are used by default.
- To use more queues driver must negotiate the VIRTIO_NET_F_MQ feature;
- initialize up to 
+ To use more queues driver must negotiate the VIRTIO_NET_F_MQ feature; initializ
+e up to 
 \emph on
 max_virtqueue_pairs
 \emph default
- of each of transmit and receive queues; execute_VIRTIO_NET_CTRL_MQ_VQ_PAIRS_SE
-T command specifying the number of the transmit and receive queues that
- is going to be used and wait until the device consumes the controlq buffer
+ of each of transmit and receive queues; execute_VIRTIO_NET_CTRL_MQ_VQ_PAIRS_SET
+ command specifying the number of the transmit and receive queues that is
+ going to be used and wait until the device consumes the controlq buffer
  and acks this command.
 \change_unchanged
 
@@ -5008,8 +5008,8 @@ struct virtio_net_hdr
 \begin_layout Standard
 
 \change_inserted 1986246365 1353594638
-If VIRTIO_NET_F_MQ is negotiated, each of receiveq0...receiveqN that will
- be used should be populated with receive buffers.
+If VIRTIO_NET_F_MQ is negotiated, each of receiveq0...receiveqN that will be
+ used should be populated with receive buffers.
 \change_unchanged
 
 \end_layout
@@ -5453,9 +5453,9 @@ Automatic receive steering in multiqueue mode
 \begin_layout Standard
 
 \change_inserted 1986246365 1354528882
-If the driver negotiates the VIRTIO_NET_F_MQ feature bit (depends on VIRTIO_NET
-_F_CTRL_VQ), it can transmit outgoing packets on one of the multiple transmitq0..t
-ransmitqN and ask the device to queue incoming packets into one the multiple
+If the driver negotiates the VIRTIO_NET_F_MQ feature bit (depends on VIRTIO_NET_
+F_CTRL_VQ), it can transmit outgoing packets on one of the multiple transmitq0..tr
+ansmitqN and ask the device to queue incoming packets into one the multiple
  receiveq0..receiveqN depending on the packet flow.
 \change_unchanged
 
@@ -5532,9 +5532,9 @@ struct virtio_net_ctrl_mq {
 
 \change_inserted 1986246365 1354531492
 Multiqueue is disabled by default.
- Driver enables multiqueue by executing the VIRTIO_NET_CTRL_MQ_VQ_PAIRS_SET command,
- specifying the number of the transmit and receive queues that will be used;
- thus transmitq0..transmitqn and receiveq0..receiveqn where 
+ Driver enables multiqueue by executing the VIRTIO_NET_CTRL_MQ_VQ_PAIRS_SET
+ command, specifying the number of the transmit and receive queues that
+ will be used; thus transmitq0..transmitqn and receiveq0..receiveqn where 
 \emph on
 n=virtqueue_pairs-1
 \emph default
@@ -5554,9 +5554,8 @@ max_virtqueue_pairs
 \begin_layout Standard
 
 \change_inserted 1986246365 1353595328
-When multiqueue is enabled, device uses automatic receive
-steering based on packet flow.
-Programming of the receive steering classificator is implicit.
+When multiqueue is enabled, device uses automatic receivesteering based
+ on packet flow.Programming of the receive steering classificator is implicit.
  Transmitting a packet of a specific flow on transmitqX will cause incoming
  packets for this flow to be steered to receiveqX.
  For uni-directional protocols, or where no packets have been transmitted
-- 
1.7.10.4
