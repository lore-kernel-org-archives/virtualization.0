From: Dor Laor <dor.laor@gmail.com>
Subject: [PATCH] virtio_net tx performance fix
Date: Mon, 28 Jan 2008 02:13:44 +0200
Message-ID: <1201479224.3047.37.camel__41611.735095694$1201479421$gmane$org@localhost.localdomain>
Reply-To: dor.laor@qumranet.com
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-1QR0LBtRKc/Zc5Nzqh1U"
Return-path: <virtualization-bounces@lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Rusty Russell <rusty@rustcorp.com.au>, Anthony Liguori <aliguori@us.ibm.com>, kvm-devel <kvm-devel@lists.sourceforge.net>, virtualization@lists.linux-foundation.
List-Id: virtualization@lists.linuxfoundation.org


--=-1QR0LBtRKc/Zc5Nzqh1U
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

From f582caf612b446e42f1e80d5ef12c5b7322efd03 Mon Sep 17 00:00:00 2001
From: Dor Laor <dor.laor@qumranet.com>
Date: Mon, 28 Jan 2008 02:09:48 +0200
Subject: [PATCH] virtio_net tx performance fix

There was a problem with the location of the notify call in
add_buff function:
When VRING_USED_F_NO_NOTIFY is set, the host does not kick the
guest when packets were transmitted, as a result the guest runs
out of tx buffers sometimes. This is fine but the problem lies
when add_buf fails, it called notify and the host sends all the
pending tx pkts. When enable_cb was called, more_used(vq) returned
false so eventually the skb was dropped.

Moving notify from add_buf to enable_cb fixes this flow problem.
The tx performance boosted from 220Mbps to 850Mbps.

Signed-off-by: Dor Laor <dor.laor@qumranet.com>
---
 drivers/virtio/virtio_ring.c |    3 +--
 1 files changed, 1 insertions(+), 2 deletions(-)

diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
index 3a28c13..592bbc9 100644
--- a/drivers/virtio/virtio_ring.c
+++ b/drivers/virtio/virtio_ring.c
@@ -87,8 +87,6 @@ static int vring_add_buf(struct virtqueue *_vq,
 	if (vq->num_free < out + in) {
 		pr_debug("Can't add buf len %i - avail = %i\n",
 			 out + in, vq->num_free);
-		/* We notify *even if* VRING_USED_F_NO_NOTIFY is set here. */
-		vq->notify(&vq->vq);
 		END_USE(vq);
 		return -ENOSPC;
 	}
@@ -232,6 +230,7 @@ static bool vring_enable_cb(struct virtqueue *_vq)
 	vq->vring.avail->flags &= ~VRING_AVAIL_F_NO_INTERRUPT;
 	mb();
 	if (unlikely(more_used(vq))) {
+		vq->notify(&vq->vq);
 		vq->vring.avail->flags |= VRING_AVAIL_F_NO_INTERRUPT;
 		END_USE(vq);
 		return false;
-- 
1.5.3.7



--=-1QR0LBtRKc/Zc5Nzqh1U
Content-Disposition: attachment;
	filename=0001-virtio_net-tx-performance-fix.patch
Content-Type: application/mbox; name=0001-virtio_net-tx-performance-fix.patch
Content-Transfer-Encoding: 7bit

From f582caf612b446e42f1e80d5ef12c5b7322efd03 Mon Sep 17 00:00:00 2001
From: Dor Laor <dor.laor@qumranet.com>
Date: Mon, 28 Jan 2008 02:09:48 +0200
Subject: [PATCH] virtio_net tx performance fix

There was a problem with the location of the notify call in
add_buff function:
When VRING_USED_F_NO_NOTIFY is set, the host does not kick the
guest when packets were transmited, as a result the guest runs
out of tx buffers sometimes. This is fine but the problem lies
when add_buf fails, it called notify and the host sends all the
pending tx pkts. When enable_cb was called, more_used(vq) returned
false so eventually the skb was droped.

Moving notify from add_buf to enable_cb fixes this flow problem.
The tx performance boosted from 220Mbps to 850Mbps.

Signed-off-by: Dor Laor <dor.laor@qumranet.com>
---
 drivers/virtio/virtio_ring.c |    3 +--
 1 files changed, 1 insertions(+), 2 deletions(-)

diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
index 3a28c13..592bbc9 100644
--- a/drivers/virtio/virtio_ring.c
+++ b/drivers/virtio/virtio_ring.c
@@ -87,8 +87,6 @@ static int vring_add_buf(struct virtqueue *_vq,
 	if (vq->num_free < out + in) {
 		pr_debug("Can't add buf len %i - avail = %i\n",
 			 out + in, vq->num_free);
-		/* We notify *even if* VRING_USED_F_NO_NOTIFY is set here. */
-		vq->notify(&vq->vq);
 		END_USE(vq);
 		return -ENOSPC;
 	}
@@ -232,6 +230,7 @@ static bool vring_enable_cb(struct virtqueue *_vq)
 	vq->vring.avail->flags &= ~VRING_AVAIL_F_NO_INTERRUPT;
 	mb();
 	if (unlikely(more_used(vq))) {
+		vq->notify(&vq->vq);
 		vq->vring.avail->flags |= VRING_AVAIL_F_NO_INTERRUPT;
 		END_USE(vq);
 		return false;
-- 
1.5.3.7


--=-1QR0LBtRKc/Zc5Nzqh1U
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linux-foundation.org/mailman/listinfo/virtualization
--=-1QR0LBtRKc/Zc5Nzqh1U--
