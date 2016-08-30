From: Andy Lutomirski <luto@kernel.org>
Subject: [PATCH] virtio_console: Stop doing DMA on the stack
Date: Tue, 30 Aug 2016 08:04:15 -0700
Message-ID: <0afe68f9b4be6c95af9e7672b07acd0274c26dfe.1472569320.git.luto@kernel.org>
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
To: x86@kernel.org, Amit Shah <amit.shah@redhat.com>, virtualization@lists.linux-foundation.org
Cc: linux-kernel@vger.kernel.org, Andy Lutomirski <luto@kernel.org>, "Michael S. Tsirkin" <mst@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

virtio_console uses a small DMA buffer for control requests.  Move
that buffer into heap memory.

Doing virtio DMA on the stack is normally okay on non-DMA-API virtio
systems (which is currently most of them), but it breaks completely
if the stack is virtually mapped.

Tested by typing both directions using picocom aimed at /dev/hvc0.

Signed-off-by: Andy Lutomirski <luto@kernel.org>
---

Hi all-

This is currently broken in tip:x86/asm.  If you (Amit) like this patch,
would it make sense for Ingo to add it to -tip?

Thanks,
Andy

 drivers/char/virtio_console.c | 23 +++++++++++++++--------
 1 file changed, 15 insertions(+), 8 deletions(-)

diff --git a/drivers/char/virtio_console.c b/drivers/char/virtio_console.c
index d2406fe25533..5da47e26a012 100644
--- a/drivers/char/virtio_console.c
+++ b/drivers/char/virtio_console.c
@@ -165,6 +165,12 @@ struct ports_device {
 	 */
 	struct virtqueue *c_ivq, *c_ovq;
 
+	/*
+	 * A control packet buffer for guest->host requests, protected
+	 * by c_ovq_lock.
+	 */
+	struct virtio_console_control cpkt;
+
 	/* Array of per-port IO virtqueues */
 	struct virtqueue **in_vqs, **out_vqs;
 
@@ -560,28 +566,29 @@ static ssize_t __send_control_msg(struct ports_device *portdev, u32 port_id,
 				  unsigned int event, unsigned int value)
 {
 	struct scatterlist sg[1];
-	struct virtio_console_control cpkt;
 	struct virtqueue *vq;
 	unsigned int len;
 
 	if (!use_multiport(portdev))
 		return 0;
 
-	cpkt.id = cpu_to_virtio32(portdev->vdev, port_id);
-	cpkt.event = cpu_to_virtio16(portdev->vdev, event);
-	cpkt.value = cpu_to_virtio16(portdev->vdev, value);
-
 	vq = portdev->c_ovq;
 
-	sg_init_one(sg, &cpkt, sizeof(cpkt));
-
 	spin_lock(&portdev->c_ovq_lock);
-	if (virtqueue_add_outbuf(vq, sg, 1, &cpkt, GFP_ATOMIC) == 0) {
+
+	portdev->cpkt.id = cpu_to_virtio32(portdev->vdev, port_id);
+	portdev->cpkt.event = cpu_to_virtio16(portdev->vdev, event);
+	portdev->cpkt.value = cpu_to_virtio16(portdev->vdev, value);
+
+	sg_init_one(sg, &portdev->cpkt, sizeof(struct virtio_console_control));
+
+	if (virtqueue_add_outbuf(vq, sg, 1, &portdev->cpkt, GFP_ATOMIC) == 0) {
 		virtqueue_kick(vq);
 		while (!virtqueue_get_buf(vq, &len)
 			&& !virtqueue_is_broken(vq))
 			cpu_relax();
 	}
+
 	spin_unlock(&portdev->c_ovq_lock);
 	return 0;
 }
-- 
2.7.4
