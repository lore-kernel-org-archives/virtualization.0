From: Aaron Lu <aaron.lu@intel.com>
Subject: [PATCH 2/2] virtio: pm: use CONFIG_PM_SLEEP instead of CONFIG_PM
Date: Fri,  6 Sep 2013 16:20:07 +0800
Message-ID: <1378455607-32459-3-git-send-email-aaron.lu__25199.2041631185$1378506988$gmane$org@intel.com>
References: <1378455607-32459-1-git-send-email-aaron.lu@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1378455607-32459-1-git-send-email-aaron.lu@intel.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Amit Shah <amit.shah@redhat.com>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, linux-pm@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

The freeze and restore functions defined in virtio drivers are used
for suspend and hibernate, so CONFIG_PM_SLEEP is more appropriate than
CONFIG_PM. This patch replace all CONFIG_PM with CONFIG_PM_SLEEP for
virtio drivers that implement freeze and restore callbacks.

Signed-off-by: Aaron Lu <aaron.lu@intel.com>
---
 drivers/block/virtio_blk.c          | 4 ++--
 drivers/char/hw_random/virtio-rng.c | 4 ++--
 drivers/char/virtio_console.c       | 4 ++--
 drivers/net/virtio_net.c            | 4 ++--
 drivers/scsi/virtio_scsi.c          | 4 ++--
 drivers/virtio/virtio_balloon.c     | 4 ++--
 6 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
index 5cdf88b..89245b5 100644
--- a/drivers/block/virtio_blk.c
+++ b/drivers/block/virtio_blk.c
@@ -899,7 +899,7 @@ static void virtblk_remove(struct virtio_device *vdev)
 		ida_simple_remove(&vd_index_ida, index);
 }
 
-#ifdef CONFIG_PM
+#ifdef CONFIG_PM_SLEEP
 static int virtblk_freeze(struct virtio_device *vdev)
 {
 	struct virtio_blk *vblk = vdev->priv;
@@ -959,7 +959,7 @@ static struct virtio_driver virtio_blk = {
 	.probe			= virtblk_probe,
 	.remove			= virtblk_remove,
 	.config_changed		= virtblk_config_changed,
-#ifdef CONFIG_PM
+#ifdef CONFIG_PM_SLEEP
 	.freeze			= virtblk_freeze,
 	.restore		= virtblk_restore,
 #endif
diff --git a/drivers/char/hw_random/virtio-rng.c b/drivers/char/hw_random/virtio-rng.c
index ef46a9c..c12398d 100644
--- a/drivers/char/hw_random/virtio-rng.c
+++ b/drivers/char/hw_random/virtio-rng.c
@@ -133,7 +133,7 @@ static void virtrng_remove(struct virtio_device *vdev)
 	remove_common(vdev);
 }
 
-#ifdef CONFIG_PM
+#ifdef CONFIG_PM_SLEEP
 static int virtrng_freeze(struct virtio_device *vdev)
 {
 	remove_common(vdev);
@@ -157,7 +157,7 @@ static struct virtio_driver virtio_rng_driver = {
 	.id_table =	id_table,
 	.probe =	virtrng_probe,
 	.remove =	virtrng_remove,
-#ifdef CONFIG_PM
+#ifdef CONFIG_PM_SLEEP
 	.freeze =	virtrng_freeze,
 	.restore =	virtrng_restore,
 #endif
diff --git a/drivers/char/virtio_console.c b/drivers/char/virtio_console.c
index fc45567..2e96246 100644
--- a/drivers/char/virtio_console.c
+++ b/drivers/char/virtio_console.c
@@ -2135,7 +2135,7 @@ static struct virtio_device_id rproc_serial_id_table[] = {
 static unsigned int rproc_serial_features[] = {
 };
 
-#ifdef CONFIG_PM
+#ifdef CONFIG_PM_SLEEP
 static int virtcons_freeze(struct virtio_device *vdev)
 {
 	struct ports_device *portdev;
@@ -2213,7 +2213,7 @@ static struct virtio_driver virtio_console = {
 	.probe =	virtcons_probe,
 	.remove =	virtcons_remove,
 	.config_changed = config_intr,
-#ifdef CONFIG_PM
+#ifdef CONFIG_PM_SLEEP
 	.freeze =	virtcons_freeze,
 	.restore =	virtcons_restore,
 #endif
diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index defec2b..2ad3d96 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -1683,7 +1683,7 @@ static void virtnet_remove(struct virtio_device *vdev)
 	free_netdev(vi->dev);
 }
 
-#ifdef CONFIG_PM
+#ifdef CONFIG_PM_SLEEP
 static int virtnet_freeze(struct virtio_device *vdev)
 {
 	struct virtnet_info *vi = vdev->priv;
@@ -1766,7 +1766,7 @@ static struct virtio_driver virtio_net_driver = {
 	.probe =	virtnet_probe,
 	.remove =	virtnet_remove,
 	.config_changed = virtnet_config_changed,
-#ifdef CONFIG_PM
+#ifdef CONFIG_PM_SLEEP
 	.freeze =	virtnet_freeze,
 	.restore =	virtnet_restore,
 #endif
diff --git a/drivers/scsi/virtio_scsi.c b/drivers/scsi/virtio_scsi.c
index 74b88ef..2a11039 100644
--- a/drivers/scsi/virtio_scsi.c
+++ b/drivers/scsi/virtio_scsi.c
@@ -954,7 +954,7 @@ static void virtscsi_remove(struct virtio_device *vdev)
 	scsi_host_put(shost);
 }
 
-#ifdef CONFIG_PM
+#ifdef CONFIG_PM_SLEEP
 static int virtscsi_freeze(struct virtio_device *vdev)
 {
 	virtscsi_remove_vqs(vdev);
@@ -988,7 +988,7 @@ static struct virtio_driver virtio_scsi_driver = {
 	.id_table = id_table,
 	.probe = virtscsi_probe,
 	.scan = virtscsi_scan,
-#ifdef CONFIG_PM
+#ifdef CONFIG_PM_SLEEP
 	.freeze = virtscsi_freeze,
 	.restore = virtscsi_restore,
 #endif
diff --git a/drivers/virtio/virtio_balloon.c b/drivers/virtio/virtio_balloon.c
index 1f572c0..d6f6816 100644
--- a/drivers/virtio/virtio_balloon.c
+++ b/drivers/virtio/virtio_balloon.c
@@ -513,7 +513,7 @@ static void virtballoon_remove(struct virtio_device *vdev)
 	kfree(vb);
 }
 
-#ifdef CONFIG_PM
+#ifdef CONFIG_PM_SLEEP
 static int virtballoon_freeze(struct virtio_device *vdev)
 {
 	struct virtio_balloon *vb = vdev->priv;
@@ -556,7 +556,7 @@ static struct virtio_driver virtio_balloon_driver = {
 	.probe =	virtballoon_probe,
 	.remove =	virtballoon_remove,
 	.config_changed = virtballoon_changed,
-#ifdef CONFIG_PM
+#ifdef CONFIG_PM_SLEEP
 	.freeze	=	virtballoon_freeze,
 	.restore =	virtballoon_restore,
 #endif
-- 
1.8.4.12.g2ea3df6
