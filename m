From: Amit Shah <amit.shah@redhat.com>
Subject: [PATCH 03/11] virtio: console: Let host know of port or device add
	failures
Date: Thu,  8 Apr 2010 20:19:32 +0530
Message-ID: <1270738180-21170-4-git-send-email-amit.shah@redhat.com>
References: <1270738180-21170-1-git-send-email-amit.shah@redhat.com>
	<1270738180-21170-2-git-send-email-amit.shah@redhat.com>
	<1270738180-21170-3-git-send-email-amit.shah@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1270738180-21170-3-git-send-email-amit.shah@redhat.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Virtualization List <virtualization@lists.linux-foundation.org>
Cc: Amit Shah <amit.shah@redhat.com>, Juan Quintela <quintela@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

The host may want to know and let management apps notify of port or
device add failures. Send a control message saying the device or port is
not ready in this case.

Signed-off-by: Amit Shah <amit.shah@redhat.com>
---
 drivers/char/virtio_console.c  |    5 +++++
 include/linux/virtio_console.h |    3 +++
 2 files changed, 8 insertions(+), 0 deletions(-)

diff --git a/drivers/char/virtio_console.c b/drivers/char/virtio_console.c
index cfd6aa9..5aa1891 100644
--- a/drivers/char/virtio_console.c
+++ b/drivers/char/virtio_console.c
@@ -1210,6 +1210,8 @@ free_cdev:
 free_port:
 	kfree(port);
 fail:
+	/* The host might want to notify management sw about port add failure */
+	send_control_msg(port, VIRTIO_CONSOLE_PORT_READY, 0);
 	return err;
 }
 
@@ -1488,6 +1490,9 @@ free_chrdev:
 free:
 	kfree(portdev);
 fail:
+	/* The host might want to notify mgmt sw about device add failure */
+	__send_control_msg(portdev, VIRTIO_CONSOLE_BAD_ID,
+			   VIRTIO_CONSOLE_DEVICE_READY, 0);
 	return err;
 }
 
diff --git a/include/linux/virtio_console.h b/include/linux/virtio_console.h
index ae4f039..0157361 100644
--- a/include/linux/virtio_console.h
+++ b/include/linux/virtio_console.h
@@ -14,6 +14,8 @@
 #define VIRTIO_CONSOLE_F_SIZE	0	/* Does host provide console size? */
 #define VIRTIO_CONSOLE_F_MULTIPORT 1	/* Does host provide multiple ports? */
 
+#define VIRTIO_CONSOLE_BAD_ID		(~(u32)0)
+
 struct virtio_console_config {
 	/* colums of the screens */
 	__u16 cols;
@@ -42,6 +44,7 @@ struct virtio_console_control {
 #define VIRTIO_CONSOLE_PORT_OPEN	3
 #define VIRTIO_CONSOLE_PORT_NAME	4
 #define VIRTIO_CONSOLE_PORT_REMOVE	5
+#define VIRTIO_CONSOLE_DEVICE_READY	6
 
 #ifdef __KERNEL__
 int __init virtio_cons_early_init(int (*put_chars)(u32, const char *, int));
-- 
1.6.2.5
