From: Heinz Graalfs <graalfs@linux.vnet.ibm.com>
Subject: [PATCH V2 RFC 7/9] virtio_console: verify if queue is broken after
	virtqueue_get_buf()
Date: Thu, 24 Oct 2013 17:23:18 +0200
Message-ID: <1382628200-42956-8-git-send-email-graalfs@linux.vnet.ibm.com>
References: <1382628200-42956-1-git-send-email-graalfs@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1382628200-42956-1-git-send-email-graalfs@linux.vnet.ibm.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: rusty@rustcorp.com.au, mst@redhat.com, virtualization@lists.linux-foundation.org
Cc: borntraeger@de.ibm.com
List-Id: virtualization@lists.linuxfoundation.org

If virtqueue_get_buf() returns with a NULL pointer it should be verified
if the virtqueue is broken, in order to avoid loop calling cpu_relax().

Signed-off-by: Heinz Graalfs <graalfs@linux.vnet.ibm.com>
---
 drivers/char/virtio_console.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/char/virtio_console.c b/drivers/char/virtio_console.c
index 1b456fe..9dce2f0 100644
--- a/drivers/char/virtio_console.c
+++ b/drivers/char/virtio_console.c
@@ -574,7 +574,8 @@ static ssize_t __send_control_msg(struct ports_device *portdev, u32 port_id,
 	spin_lock(&portdev->c_ovq_lock);
 	if (virtqueue_add_outbuf(vq, sg, 1, &cpkt, GFP_ATOMIC) == 0) {
 		virtqueue_kick(vq);
-		while (!virtqueue_get_buf(vq, &len))
+		while (!virtqueue_get_buf(vq, &len)
+			&& !virtqueue_is_broken(vq))
 			cpu_relax();
 	}
 	spin_unlock(&portdev->c_ovq_lock);
@@ -647,7 +648,8 @@ static ssize_t __send_to_port(struct port *port, struct scatterlist *sg,
 	 * we need to kmalloc a GFP_ATOMIC buffer each time the
 	 * console driver writes something out.
 	 */
-	while (!virtqueue_get_buf(out_vq, &len))
+	while (!virtqueue_get_buf(out_vq, &len)
+		&& !virtqueue_is_broken(out_vq))
 		cpu_relax();
 done:
 	spin_unlock_irqrestore(&port->outvq_lock, flags);
-- 
1.8.3.1
