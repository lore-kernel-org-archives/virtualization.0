From: Rusty Russell <rusty@rustcorp.com.au>
Subject: [PATCH 5/8] virtio: console: use vdev->priv to avoid accessing global
	var.
Date: Tue, 10 Nov 2009 16:57:30 +1030
Message-ID: <33058.9863042862$1257834688@news.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
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
To: virtualization@linux-foundation.org
Cc: Amit Shah <amit.shah@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org


Part of removing our "one console" assumptions, use vdev->priv to point
to the port (currently == the global console).

Signed-off-by: Rusty Russell <rusty@rustcorp.com.au>
---
 drivers/char/virtio_console.c |    9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/char/virtio_console.c b/drivers/char/virtio_console.c
--- a/drivers/char/virtio_console.c
+++ b/drivers/char/virtio_console.c
@@ -122,6 +122,7 @@ static int get_chars(u32 vtermno, char *
  */
 static void virtcons_apply_config(struct virtio_device *dev)
 {
+	struct port *port = dev->priv;
 	struct winsize ws;
 
 	if (virtio_has_feature(dev, VIRTIO_CONSOLE_F_SIZE)) {
@@ -131,7 +132,7 @@ static void virtcons_apply_config(struct
 		dev->config->get(dev,
 				 offsetof(struct virtio_console_config, rows),
 				 &ws.ws_row, sizeof(u16));
-		hvc_resize(console.hvc, ws);
+		hvc_resize(port->hvc, ws);
 	}
 }
 
@@ -154,7 +155,9 @@ static void notifier_del_vio(struct hvc_
 
 static void hvc_handle_input(struct virtqueue *vq)
 {
-	if (hvc_poll(console.hvc))
+	struct port *port = vq->vdev->priv;
+
+	if (hvc_poll(port->hvc))
 		hvc_kick();
 }
 
@@ -194,7 +197,9 @@ static int __devinit virtcons_probe(stru
 	int err;
 	struct port *port = &console;
 
+	/* Attach this port to this virtio_device, and vice-versa. */
 	port->vdev = vdev;
+	vdev->priv = port;
 
 	/* This is the scratch page we use to receive console input */
 	port->used_len = 0;
