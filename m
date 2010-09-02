From: Amit Shah <amit.shah@redhat.com>
Subject: [PATCH 02/14] virtio: console: Remove control vq data only if using
	multiport support
Date: Thu,  2 Sep 2010 18:11:41 +0530
Message-ID: <c7259c88e3dc036806629cd31f08e8b54fa1c345.1283430900.git.amit.shah@redhat.com>
References: <cover.1283430900.git.amit.shah@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <cover.1283430900.git.amit.shah@redhat.com>
In-Reply-To: <cover.1283430900.git.amit.shah@redhat.com>
References: <cover.1283430900.git.amit.shah@redhat.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: Amit Shah <amit.shah@redhat.com>, Virtualization List <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

If a portdev isn't using multiport support, it won't have any control vq
data to remove.

Signed-off-by: Amit Shah <amit.shah@redhat.com>
---
 drivers/char/virtio_console.c |   15 +++++++++------
 1 files changed, 9 insertions(+), 6 deletions(-)

diff --git a/drivers/char/virtio_console.c b/drivers/char/virtio_console.c
index 32267d4..0f115b4 100644
--- a/drivers/char/virtio_console.c
+++ b/drivers/char/virtio_console.c
@@ -1585,8 +1585,6 @@ static void virtcons_remove(struct virtio_device *vdev)
 {
 	struct ports_device *portdev;
 	struct port *port, *port2;
-	struct port_buffer *buf;
-	unsigned int len;
 
 	portdev = vdev->priv;
 
@@ -1600,11 +1598,16 @@ static void virtcons_remove(struct virtio_device *vdev)
 
 	unregister_chrdev(portdev->chr_major, "virtio-portsdev");
 
-	while ((buf = virtqueue_get_buf(portdev->c_ivq, &len)))
-		free_buf(buf);
+	if (use_multiport(portdev)) {
+		struct port_buffer *buf;
+		unsigned int len;
 
-	while ((buf = virtqueue_detach_unused_buf(portdev->c_ivq)))
-		free_buf(buf);
+		while ((buf = virtqueue_get_buf(portdev->c_ivq, &len)))
+			free_buf(buf);
+
+		while ((buf = virtqueue_detach_unused_buf(portdev->c_ivq)))
+			free_buf(buf);
+	}
 
 	vdev->config->del_vqs(vdev);
 	kfree(portdev->in_vqs);
-- 
1.7.2.2
