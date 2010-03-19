From: Amit Shah <amit.shah@redhat.com>
Subject: [PATCH 1/6] virtio: console: Generate a kobject CHANGE event on
	adding 'name' attribute
Date: Fri, 19 Mar 2010 17:36:43 +0530
Message-ID: <1269000408-29962-2-git-send-email-amit.shah@redhat.com>
References: <1269000408-29962-1-git-send-email-amit.shah@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1269000408-29962-1-git-send-email-amit.shah@redhat.com>
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

When the host lets us know what 'name' a port is assigned, we create the
sysfs 'name' attribute. Generate a 'change' event after this so that
udev wakes up and acts on the rules for virtio-ports (currently there's
only one rule that creates a symlink from the 'name' to the actual char
device).

Signed-off-by: Amit Shah <amit.shah@redhat.com>
---
 drivers/char/virtio_console.c |   11 +++++++++--
 1 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/char/virtio_console.c b/drivers/char/virtio_console.c
index f404ccf..67b474b 100644
--- a/drivers/char/virtio_console.c
+++ b/drivers/char/virtio_console.c
@@ -947,11 +947,18 @@ static void handle_control_message(struct ports_device *portdev,
 		 */
 		err = sysfs_create_group(&port->dev->kobj,
 					 &port_attribute_group);
-		if (err)
+		if (err) {
 			dev_err(port->dev,
 				"Error %d creating sysfs device attributes\n",
 				err);
-
+		} else {
+			/*
+			 * Generate a udev event so that appropriate
+			 * symlinks can be created based on udev
+			 * rules.
+			 */
+			kobject_uevent(&port->dev->kobj, KOBJ_CHANGE);
+		}
 		break;
 	case VIRTIO_CONSOLE_PORT_REMOVE:
 		/*
-- 
1.6.2.5
