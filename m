From: Amit Shah <amit.shah@redhat.com>
Subject: [PATCH 2/4] virtio: console: Annotate virtcons_remove with __devexit_p
Date: Thu, 26 Aug 2010 10:34:06 +0530
Message-ID: <f5ebecbcedd69e45c5a60ee0e5c5ffe02e52b333.1282798831.git.amit.shah@redhat.com>
References: <cover.1282798831.git.amit.shah@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <cover.1282798831.git.amit.shah@redhat.com>
In-Reply-To: <cover.1282798831.git.amit.shah@redhat.com>
References: <cover.1282798831.git.amit.shah@redhat.com>
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

virtcons_remove is called on device unplug. Mark with __devexit_p.

Signed-off-by: Amit Shah <amit.shah@redhat.com>
---
 drivers/char/virtio_console.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/char/virtio_console.c b/drivers/char/virtio_console.c
index 92ae3f8..a34f40e 100644
--- a/drivers/char/virtio_console.c
+++ b/drivers/char/virtio_console.c
@@ -1585,7 +1585,7 @@ fail:
 	return err;
 }
 
-static void virtcons_remove(struct virtio_device *vdev)
+static void __devexit virtcons_remove(struct virtio_device *vdev)
 {
 	struct ports_device *portdev;
 	struct port *port, *port2;
@@ -1631,7 +1631,7 @@ static struct virtio_driver virtio_console = {
 	.driver.owner =	THIS_MODULE,
 	.id_table =	id_table,
 	.probe =	virtcons_probe,
-	.remove =	virtcons_remove,
+	.remove =	__devexit_p(virtcons_remove),
 	.config_changed = config_intr,
 };
 
-- 
1.7.2.2
