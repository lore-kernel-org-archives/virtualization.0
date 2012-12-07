From: Amit Shah <amit.shah@redhat.com>
Subject: [PATCH 1/1] virtio: console: virtqueue_add_buf() no longer returns > 0
Date: Fri,  7 Dec 2012 11:34:38 +0530
Message-ID: <bf1c3e0818294901d36b0882d1506c22b6733973.1354859479.git.amit.shah@redhat.com>
References: <cover.1354859479.git.amit.shah@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <cover.1354859479.git.amit.shah@redhat.com>
In-Reply-To: <cover.1354859479.git.amit.shah@redhat.com>
References: <cover.1354859479.git.amit.shah@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: Amit Shah <amit.shah@redhat.com>, #@mail.linuxfoundation.org, Virtualization List <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

From: Rusty Russell <rusty@rustcorp.com.au>

We simplified virtqueue_add_buf(), make it clear in the callers.  Use
the newly-exposed vq->num_free in the two places that used the previous
+ve return value.

Signed-off-by: Rusty Russell <rusty@rustcorp.com.au>
Signed-off-by: Amit Shah <amit.shah@redhat.com> # Update add_inbuf()
---
 drivers/char/virtio_console.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/char/virtio_console.c b/drivers/char/virtio_console.c
index 8ab9c3d..6a36994 100644
--- a/drivers/char/virtio_console.c
+++ b/drivers/char/virtio_console.c
@@ -396,6 +396,8 @@ static int add_inbuf(struct virtqueue *vq, struct port_buffer *buf)
 
 	ret = virtqueue_add_buf(vq, sg, 0, 1, buf, GFP_ATOMIC);
 	virtqueue_kick(vq);
+	if (!ret)
+		ret = vq->num_free;
 	return ret;
 }
 
@@ -459,7 +461,7 @@ static ssize_t __send_control_msg(struct ports_device *portdev, u32 port_id,
 	vq = portdev->c_ovq;
 
 	sg_init_one(sg, &cpkt, sizeof(cpkt));
-	if (virtqueue_add_buf(vq, sg, 1, 0, &cpkt, GFP_ATOMIC) >= 0) {
+	if (virtqueue_add_buf(vq, sg, 1, 0, &cpkt, GFP_ATOMIC) == 0) {
 		virtqueue_kick(vq);
 		while (!virtqueue_get_buf(vq, &len))
 			cpu_relax();
@@ -524,7 +526,7 @@ static ssize_t __send_to_port(struct port *port, struct scatterlist *sg,
 			      struct buffer_token *tok, bool nonblock)
 {
 	struct virtqueue *out_vq;
-	ssize_t ret;
+	int err;
 	unsigned long flags;
 	unsigned int len;
 
@@ -534,17 +536,17 @@ static ssize_t __send_to_port(struct port *port, struct scatterlist *sg,
 
 	reclaim_consumed_buffers(port);
 
-	ret = virtqueue_add_buf(out_vq, sg, nents, 0, tok, GFP_ATOMIC);
+	err = virtqueue_add_buf(out_vq, sg, nents, 0, tok, GFP_ATOMIC);
 
 	/* Tell Host to go! */
 	virtqueue_kick(out_vq);
 
-	if (ret < 0) {
+	if (err) {
 		in_count = 0;
 		goto done;
 	}
 
-	if (ret == 0)
+	if (out_vq->num_free == 0)
 		port->outvq_full = true;
 
 	if (nonblock)
-- 
1.8.0.1
