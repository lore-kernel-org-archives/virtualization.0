From: Amit Shah <amit.shah@redhat.com>
Subject: [PATCH 07/15] virtio_console: config: Prepare for handling multiple
	ports and hotplug
Date: Tue, 10 Nov 2009 15:11:33 +0530
Message-ID: <1257846101-23258-8-git-send-email-amit.shah@redhat.com>
References: <1257846101-23258-1-git-send-email-amit.shah@redhat.com>
	<1257846101-23258-2-git-send-email-amit.shah@redhat.com>
	<1257846101-23258-3-git-send-email-amit.shah@redhat.com>
	<1257846101-23258-4-git-send-email-amit.shah@redhat.com>
	<1257846101-23258-5-git-send-email-amit.shah@redhat.com>
	<1257846101-23258-6-git-send-email-amit.shah@redhat.com>
	<1257846101-23258-7-git-send-email-amit.shah@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1257846101-23258-7-git-send-email-amit.shah@redhat.com>
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

The config_changed function works on the assumption of there
being only one port and no hotplugging of ports.

Abstract away the call to apply_config in a function call so
that we can handle multiple ports later.

Signed-off-by: Amit Shah <amit.shah@redhat.com>
---
 drivers/char/virtio_console.c |    8 +++++++-
 1 files changed, 7 insertions(+), 1 deletions(-)

diff --git a/drivers/char/virtio_console.c b/drivers/char/virtio_console.c
index cc720d3..e97188e 100644
--- a/drivers/char/virtio_console.c
+++ b/drivers/char/virtio_console.c
@@ -415,6 +415,12 @@ static void tx_intr(struct virtqueue *vq)
 	schedule_work(&virtconsole.tx_work);
 }
 
+static void config_intr(struct virtio_device *vdev)
+{
+	/* Handle console size changes */
+	virtcons_apply_config(vdev);
+}
+
 /*D:370 Once we're further in boot, we get probed like any other virtio device.
  * At this stage we set up the output virtqueue.
  *
@@ -505,7 +511,7 @@ static struct virtio_driver virtio_console = {
 	.driver.owner =	THIS_MODULE,
 	.id_table =	id_table,
 	.probe =	virtcons_probe,
-	.config_changed = virtcons_apply_config,
+	.config_changed = config_intr,
 };
 
 static int __init init(void)
-- 
1.6.2.5
