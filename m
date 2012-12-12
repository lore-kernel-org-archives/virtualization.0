From: Alexey Zaytsev <alexey.zaytsev@gmail.com>
Subject: [PATCH] virtio-spec: Document VIRTIO_BLK_T_GET_ID.
Date: Wed, 12 Dec 2012 15:11:17 +0200
Message-ID: <1355317877-22426-1-git-send-email-alexey.zaytsev@gmail.com>
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
To: virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

Signed-off-by: Alexey Zaytsev <alexey.zaytsev@gmail.com>
---

Hi.

This feature has been around for a couple of years, probably time to document it.
Lyx cleaned up some lines I did not touch, is this ok?

 virtio-spec.lyx |   73 ++++++++++++++++++++++++++++++++++++++++++-------------
 1 file changed, 56 insertions(+), 17 deletions(-)

diff --git a/virtio-spec.lyx b/virtio-spec.lyx
index 6c09180..3fe3d0f 100644
--- a/virtio-spec.lyx
+++ b/virtio-spec.lyx
@@ -59,6 +59,7 @@
 \author -608949062 "Rusty Russell,,," 
 \author -385801441 "Cornelia Huck" cornelia.huck@de.ibm.com
 \author 1531152142 "Paolo Bonzini,,," 
+\author 1717892615 "Alexey Zaytsev,,," 
 \author 1986246365 "Michael S. Tsirkin" 
 \end_header
 
@@ -4570,14 +4571,14 @@ status
 
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
 
@@ -5008,8 +5009,8 @@ struct virtio_net_hdr
 \begin_layout Standard
 
 \change_inserted 1986246365 1353594638
-If VIRTIO_NET_F_MQ is negotiated, each of receiveq0...receiveqN that will
- be used should be populated with receive buffers.
+If VIRTIO_NET_F_MQ is negotiated, each of receiveq0...receiveqN that will be
+ used should be populated with receive buffers.
 \change_unchanged
 
 \end_layout
@@ -5453,9 +5454,9 @@ Automatic receive steering in multiqueue mode
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
 
@@ -5532,9 +5533,9 @@ struct virtio_net_ctrl_mq {
 
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
@@ -5554,9 +5555,8 @@ max_virtqueue_pairs
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
@@ -6162,7 +6162,11 @@ the SCSI_CMD and SCSI_CMD_OUT types are equivalent, the device does not
 
 \end_inset
 
-) or a flush (VIRTIO_BLK_T_FLUSH or VIRTIO_BLK_T_FLUSH_OUT
+)
+\change_inserted 1717892615 1355313186
+, device ID (serial number) inquiry (VIRTIO_BLK_T_GET_ID)
+\change_unchanged
+ or a flush (VIRTIO_BLK_T_FLUSH or VIRTIO_BLK_T_FLUSH_OUT
 \begin_inset Foot
 status open
 
@@ -6193,6 +6197,19 @@ status open
 
 \begin_layout Plain Layout
 
+\change_inserted 1717892615 1355312081
+
+#define VIRTIO_BLK_ID_BYTES       20
+\end_layout
+
+\begin_layout Plain Layout
+
+\change_inserted 1717892615 1355310507
+
+\end_layout
+
+\begin_layout Plain Layout
+
 #define VIRTIO_BLK_T_IN           0
 \end_layout
 
@@ -6219,6 +6236,17 @@ status open
 \begin_layout Plain Layout
 
 #define VIRTIO_BLK_T_FLUSH_OUT    5
+\change_inserted 1717892615 1355310422
+
+\end_layout
+
+\begin_layout Plain Layout
+
+\change_inserted 1717892615 1355310087
+
+#define VIRTIO_BLK_T_GET_ID       8
+\change_unchanged
+
 \end_layout
 
 \begin_layout Plain Layout
@@ -6348,6 +6376,17 @@ status open
 \end_layout
 
 \begin_layout Standard
+
+\change_inserted 1717892615 1355312551
+When VIRTIO_BLK_T_GET_ID is issued, the device identifier, up to 20 bytes,
+ is written to the buffer.
+ The identifier should be interpreted as an ascii string.
+ It is terminated with 
+\backslash
+0, unless it is exactly 20 bytes long.
+\end_layout
+
+\begin_layout Standard
 Historically, devices assumed that the fields 
 \emph on
 type
-- 
1.7.10.4
