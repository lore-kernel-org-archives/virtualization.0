From: Amit Shah <amit.shah@redhat.com>
Subject: [PATCH 10/28] virtio: console: ensure console size is updated on hvc
	open
Date: Sat, 28 Nov 2009 12:20:33 +0530
Message-ID: <1259391051-7752-11-git-send-email-amit.shah@redhat.com>
References: <1259391051-7752-1-git-send-email-amit.shah@redhat.com>
	<1259391051-7752-2-git-send-email-amit.shah@redhat.com>
	<1259391051-7752-3-git-send-email-amit.shah@redhat.com>
	<1259391051-7752-4-git-send-email-amit.shah@redhat.com>
	<1259391051-7752-5-git-send-email-amit.shah@redhat.com>
	<1259391051-7752-6-git-send-email-amit.shah@redhat.com>
	<1259391051-7752-7-git-send-email-amit.shah@redhat.com>
	<1259391051-7752-8-git-send-email-amit.shah@redhat.com>
	<1259391051-7752-9-git-send-email-amit.shah@redhat.com>
	<1259391051-7752-10-git-send-email-amit.shah@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1259391051-7752-10-git-send-email-amit.shah@redhat.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: rusty@rustcorp.com.au
Cc: Amit Shah <amit.shah@redhat.com>, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

When multiple console support is added, ensure each port's size gets
updated when a new one is opened via hvc.

Signed-off-by: Amit Shah <amit.shah@redhat.com>
---
 drivers/char/virtio_console.c |   33 +++++++++++++++++----------------
 1 files changed, 17 insertions(+), 16 deletions(-)

diff --git a/drivers/char/virtio_console.c b/drivers/char/virtio_console.c
index d4e2327..5a3d5df 100644
--- a/drivers/char/virtio_console.c
+++ b/drivers/char/virtio_console.c
@@ -201,27 +201,28 @@ static int get_chars(u32 vtermno, char *buf, int count)
 	return count;
 }
 
-/*
- * virtio console configuration. This supports:
- * - console resize
- */
-static void virtcons_apply_config(struct virtio_device *dev)
+static void resize_console(struct port *port)
 {
+	struct virtio_device *vdev;
 	struct winsize ws;
 
-	if (virtio_has_feature(dev, VIRTIO_CONSOLE_F_SIZE)) {
-		dev->config->get(dev,
-				 offsetof(struct virtio_console_config, cols),
-				 &ws.ws_col, sizeof(u16));
-		dev->config->get(dev,
-				 offsetof(struct virtio_console_config, rows),
-				 &ws.ws_row, sizeof(u16));
-		/* This is the pre-multiport style: we use control messages
-		 * these days which specify the port.  So this means port 0. */
-		hvc_resize(find_port_by_vtermno(0)->hvc, ws);
+	vdev = port->portdev->vdev;
+	if (virtio_has_feature(vdev, VIRTIO_CONSOLE_F_SIZE)) {
+		vdev->config->get(vdev,
+				  offsetof(struct virtio_console_config, cols),
+				  &ws.ws_col, sizeof(u16));
+		vdev->config->get(vdev,
+				  offsetof(struct virtio_console_config, rows),
+				  &ws.ws_row, sizeof(u16));
+		hvc_resize(port->hvc, ws);
 	}
 }
 
+static void virtcons_apply_config(struct virtio_device *vdev)
+{
+	resize_console(find_port_by_vtermno(0));
+}
+
 /* We set the configuration at this point, since we now have a tty */
 static int notifier_add_vio(struct hvc_struct *hp, int data)
 {
@@ -232,7 +233,7 @@ static int notifier_add_vio(struct hvc_struct *hp, int data)
 		return -EINVAL;
 
 	hp->irq_requested = 1;
-	virtcons_apply_config(port->portdev->vdev);
+	resize_console(port);
 
 	return 0;
 }
-- 
1.6.2.5
