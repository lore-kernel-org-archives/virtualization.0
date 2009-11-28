From: Amit Shah <amit.shah@redhat.com>
Subject: [PATCH 06/28] virtio: console: use vdev->priv to avoid accessing
	global var.
Date: Sat, 28 Nov 2009 12:20:29 +0530
Message-ID: <1259391051-7752-7-git-send-email-amit.shah@redhat.com>
References: <1259391051-7752-1-git-send-email-amit.shah@redhat.com>
	<1259391051-7752-2-git-send-email-amit.shah@redhat.com>
	<1259391051-7752-3-git-send-email-amit.shah@redhat.com>
	<1259391051-7752-4-git-send-email-amit.shah@redhat.com>
	<1259391051-7752-5-git-send-email-amit.shah@redhat.com>
	<1259391051-7752-6-git-send-email-amit.shah@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1259391051-7752-6-git-send-email-amit.shah@redhat.com>
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

From: Rusty Russell <rusty@rustcorp.com.au>

Part of removing our "one console" assumptions, use vdev->priv to point
to the port (currently == the global console).

Signed-off-by: Rusty Russell <rusty@rustcorp.com.au>
Signed-off-by: Amit Shah <amit.shah@redhat.com>
---
 drivers/char/virtio_console.c |   10 ++++++++--
 1 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/char/virtio_console.c b/drivers/char/virtio_console.c
index 99d9927..2bbdbf5 100644
--- a/drivers/char/virtio_console.c
+++ b/drivers/char/virtio_console.c
@@ -128,6 +128,7 @@ static int get_chars(u32 vtermno, char *buf, int count)
  */
 static void virtcons_apply_config(struct virtio_device *dev)
 {
+	struct port *port = dev->priv;
 	struct winsize ws;
 
 	if (virtio_has_feature(dev, VIRTIO_CONSOLE_F_SIZE)) {
@@ -137,7 +138,7 @@ static void virtcons_apply_config(struct virtio_device *dev)
 		dev->config->get(dev,
 				 offsetof(struct virtio_console_config, rows),
 				 &ws.ws_row, sizeof(u16));
-		hvc_resize(console.hvc, ws);
+		hvc_resize(port->hvc, ws);
 	}
 }
 
@@ -160,7 +161,9 @@ static void notifier_del_vio(struct hvc_struct *hp, int data)
 
 static void hvc_handle_input(struct virtqueue *vq)
 {
-	if (hvc_poll(console.hvc))
+	struct port *port = vq->vdev->priv;
+
+	if (hvc_poll(port->hvc))
 		hvc_kick();
 }
 
@@ -213,7 +216,10 @@ static int __devinit virtcons_probe(struct virtio_device *vdev)
 			 "Multiple virtio-console devices not supported yet\n");
 		return -EEXIST;
 	}
+
+	/* Attach this port to this virtio_device, and vice-versa. */
 	port->vdev = vdev;
+	vdev->priv = port;
 
 	/* This is the scratch page we use to receive console input */
 	port->used_len = 0;
-- 
1.6.2.5
