From: zhenwei pi <pizhenwei@bytedance.com>
Subject: [PATCH] virtio_console: remove vq buf while unpluging port
Date: Sun,  5 May 2019 09:53:42 +0800
Message-ID: <1557021222-5133-1-git-send-email-pizhenwei__43337.4490983383$1558282756$gmane$org@bytedance.com>
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
To: amit@kernel.org, arnd@arndb.de, gregkh@linuxfoundation.org
Cc: linux-kernel@vger.kernel.org, pizhenwei@bytedance.com, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

A bug can be easily reproduced:
Host# cat guest-agent.xml
<channel type="unix">
  <source mode="bind" path="/var/lib/libvirt/qemu/stretch.agent"/>
  <target type="virtio" name="org.qemu.guest_agent.0" state="connected"/>
</channel>
Host# virsh attach-device instance guest-agent.xml
Host# virsh detach-device instance guest-agent.xml
Host# virsh attach-device instance guest-agent.xml

and guest report: virtio-ports vport0p1: Error allocating inbufs

The reason is that the port is unplugged and the vq buf still remained.
So, fix two cases in this patch:
1, fix memory leak with attach-device/detach-device.
2, fix logic bug with attach-device/detach-device/attach-device.

Signed-off-by: zhenwei pi <pizhenwei@bytedance.com>
---
 drivers/char/virtio_console.c | 21 +++++++++++++++------
 1 file changed, 15 insertions(+), 6 deletions(-)

diff --git a/drivers/char/virtio_console.c b/drivers/char/virtio_console.c
index fbeb719..f6e37f4 100644
--- a/drivers/char/virtio_console.c
+++ b/drivers/char/virtio_console.c
@@ -251,6 +251,7 @@ struct port {
 
 /* This is the very early arch-specified put chars function. */
 static int (*early_put_chars)(u32, const char *, int);
+static void remove_vq(struct virtqueue *vq);
 
 static struct port *find_port_by_vtermno(u32 vtermno)
 {
@@ -1550,6 +1551,9 @@ static void unplug_port(struct port *port)
 	}
 
 	remove_port_data(port);
+	spin_lock_irq(&port->inbuf_lock);
+	remove_vq(port->in_vq);
+	spin_unlock_irq(&port->inbuf_lock);
 
 	/*
 	 * We should just assume the device itself has gone off --
@@ -1945,17 +1949,22 @@ static const struct file_operations portdev_fops = {
 	.owner = THIS_MODULE,
 };
 
+static void remove_vq(struct virtqueue *vq)
+{
+	struct port_buffer *buf;
+
+	flush_bufs(vq, true);
+	while ((buf = virtqueue_detach_unused_buf(vq)))
+		free_buf(buf, true);
+}
+
 static void remove_vqs(struct ports_device *portdev)
 {
 	struct virtqueue *vq;
 
-	virtio_device_for_each_vq(portdev->vdev, vq) {
-		struct port_buffer *buf;
+	virtio_device_for_each_vq(portdev->vdev, vq)
+		remove_vq(vq);
 
-		flush_bufs(vq, true);
-		while ((buf = virtqueue_detach_unused_buf(vq)))
-			free_buf(buf, true);
-	}
 	portdev->vdev->config->del_vqs(portdev->vdev);
 	kfree(portdev->in_vqs);
 	kfree(portdev->out_vqs);
-- 
2.7.4
