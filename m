From: Amit Shah <amit.shah@redhat.com>
Subject: [PATCH 6/6] virtio: console: Remove hot-unplug control message
Date: Fri, 19 Mar 2010 17:36:48 +0530
Message-ID: <1269000408-29962-7-git-send-email-amit.shah@redhat.com>
References: <1269000408-29962-1-git-send-email-amit.shah@redhat.com>
	<1269000408-29962-2-git-send-email-amit.shah@redhat.com>
	<1269000408-29962-3-git-send-email-amit.shah@redhat.com>
	<1269000408-29962-4-git-send-email-amit.shah@redhat.com>
	<1269000408-29962-5-git-send-email-amit.shah@redhat.com>
	<1269000408-29962-6-git-send-email-amit.shah@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1269000408-29962-6-git-send-email-amit.shah@redhat.com>
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
Cc: Amit Shah <amit.shah@redhat.com>, quintela@redhat.com, mst@redhat.com
List-Id: virtualization@lists.linuxfoundation.org

Now that we handle port hot-unplug via config updates, remove the
control message that was created.

Signed-off-by: Amit Shah <amit.shah@redhat.com>
---
 drivers/char/virtio_console.c  |   26 --------------------------
 include/linux/virtio_console.h |    1 -
 2 files changed, 0 insertions(+), 27 deletions(-)

diff --git a/drivers/char/virtio_console.c b/drivers/char/virtio_console.c
index 06ca95c..a810099 100644
--- a/drivers/char/virtio_console.c
+++ b/drivers/char/virtio_console.c
@@ -964,32 +964,6 @@ static void handle_control_message(struct ports_device *portdev,
 			kobject_uevent(&port->dev->kobj, KOBJ_CHANGE);
 		}
 		break;
-	case VIRTIO_CONSOLE_PORT_REMOVE:
-		/*
-		 * Hot unplug the port.  We don't decrement nr_ports
-		 * since we don't want to deal with extra complexities
-		 * of using the lowest-available port id: We can just
-		 * pick up the nr_ports number as the id and not have
-		 * userspace send it to us.  This helps us in two
-		 * ways:
-		 *
-		 * - We don't need to have a 'port_id' field in the
-		 *   config space when a port is hot-added.  This is a
-		 *   good thing as we might queue up multiple hotplug
-		 *   requests issued in our workqueue.
-		 *
-		 * - Another way to deal with this would have been to
-		 *   use a bitmap of the active ports and select the
-		 *   lowest non-active port from that map.  That
-		 *   bloats the already tight config space and we
-		 *   would end up artificially limiting the
-		 *   max. number of ports to sizeof(bitmap).  Right
-		 *   now we can support 2^32 ports (as the port id is
-		 *   stored in a u32 type).
-		 *
-		 */
-		remove_port(port);
-		break;
 	}
 }
 
diff --git a/include/linux/virtio_console.h b/include/linux/virtio_console.h
index 287ee44..eaaf04b 100644
--- a/include/linux/virtio_console.h
+++ b/include/linux/virtio_console.h
@@ -49,7 +49,6 @@ struct virtio_console_control {
 #define VIRTIO_CONSOLE_RESIZE		2
 #define VIRTIO_CONSOLE_PORT_OPEN	3
 #define VIRTIO_CONSOLE_PORT_NAME	4
-#define VIRTIO_CONSOLE_PORT_REMOVE	5
 
 #ifdef __KERNEL__
 int __init virtio_cons_early_init(int (*put_chars)(u32, const char *, int));
-- 
1.6.2.5
