From: Amit Shah <amit.shah@redhat.com>
Subject: [PATCH 6/7] virtio: console: Don't always create a port 0 if using
	multiport
Date: Tue, 23 Mar 2010 14:27:59 +0530
Message-ID: <1269334680-1369-7-git-send-email-amit.shah@redhat.com>
References: <1269334680-1369-1-git-send-email-amit.shah@redhat.com>
	<1269334680-1369-2-git-send-email-amit.shah@redhat.com>
	<1269334680-1369-3-git-send-email-amit.shah@redhat.com>
	<1269334680-1369-4-git-send-email-amit.shah@redhat.com>
	<1269334680-1369-5-git-send-email-amit.shah@redhat.com>
	<1269334680-1369-6-git-send-email-amit.shah@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1269334680-1369-6-git-send-email-amit.shah@redhat.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: virtualization@lists.linux-foundation.org
Cc: Amit Shah <amit.shah@redhat.com>, mst@redhat.com
List-Id: virtualization@lists.linuxfoundation.org

If we're using multiport, there's no point in always creating a console
port. Create the console port only if the host doesn't support
multiport.

Signed-off-by: Amit Shah <amit.shah@redhat.com>
---
 drivers/char/virtio_console.c |   23 ++++++++---------------
 1 files changed, 8 insertions(+), 15 deletions(-)

diff --git a/drivers/char/virtio_console.c b/drivers/char/virtio_console.c
index 8b67ff1..55de0b5 100644
--- a/drivers/char/virtio_console.c
+++ b/drivers/char/virtio_console.c
@@ -1044,14 +1044,8 @@ static void handle_control_message(struct ports_device *portdev,
 	switch (cpkt->event) {
 	case VIRTIO_CONSOLE_PORT_ADD:
 		if (port) {
-			/*
-			 * This can happen for port 0: we have to
-			 * create a console port during probe() as was
-			 * the behaviour before the MULTIPORT feature.
-			 * On a newer host, when the host tells us
-			 * that a port 0 is available, we should just
-			 * say we have the port all set up.
-			 */
+			dev_dbg(&portdev->vdev->dev,
+				"Port %u already added\n", port->id);
 			send_control_msg(port, VIRTIO_CONSOLE_PORT_READY, 1);
 			break;
 		}
@@ -1395,15 +1389,14 @@ static int __devinit virtcons_probe(struct virtio_device *vdev)
 			err = -ENOMEM;
 			goto free_vqs;
 		}
-
+	} else {
+		/*
+		 * If we're running on an older host, we always want
+		 * to create a console port.
+		 */
+		add_port(portdev, 0);
 	}
 
-	/*
-	 * For backward compatibility: if we're running on an older
-	 * host, we always want to create a console port.
-	 */
-	add_port(portdev, 0);
-
 	/* Start using the new console output. */
 	early_put_chars = NULL;
 
-- 
1.6.2.5
