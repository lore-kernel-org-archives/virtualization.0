From: Cornelia Huck <cornelia.huck@de.ibm.com>
Subject: [PATCH RFC v5 19/19] virtio-blk: revision specific feature bits
Date: Tue,  2 Dec 2014 14:00:27 +0100
Message-ID: <1417525227-14051-20-git-send-email-cornelia.huck__11683.1150641248$1417525466$gmane$org@de.ibm.com>
References: <1417525227-14051-1-git-send-email-cornelia.huck@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1417525227-14051-1-git-send-email-cornelia.huck@de.ibm.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: virtualization@lists.linux-foundation.org, qemu-devel@nongnu.org, kvm@vger.kernel.org
Cc: thuth@linux.vnet.ibm.com, mst@redhat.com
List-Id: virtualization@lists.linuxfoundation.org

Wire up virtio-blk to provide different feature bit sets depending
on whether legacy or v1.0 has been requested.

Note that VERSION_1 is still disabled due to missing ANY_LAYOUT support.

Signed-off-by: Cornelia Huck <cornelia.huck@de.ibm.com>
---
 hw/block/virtio-blk.c |   19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/hw/block/virtio-blk.c b/hw/block/virtio-blk.c
index 9cfae66..fdc236a 100644
--- a/hw/block/virtio-blk.c
+++ b/hw/block/virtio-blk.c
@@ -587,6 +587,24 @@ static uint64_t virtio_blk_get_features(VirtIODevice *vdev, uint64_t features)
     return features;
 }
 
+static uint64_t virtio_blk_get_features_rev(VirtIODevice *vdev,
+                                            uint64_t features,
+                                            unsigned int revision)
+{
+    if (revision == 0) {
+        /* legacy */
+        virtio_clear_feature(&features, VIRTIO_F_VERSION_1);
+        return virtio_blk_get_features(vdev, features);
+    }
+    /* virtio 1.0 or later */
+    virtio_clear_feature(&features, VIRTIO_BLK_F_SCSI);
+    virtio_clear_feature(&features, VIRTIO_BLK_F_CONFIG_WCE);
+    virtio_clear_feature(&features, VIRTIO_BLK_F_WCE);
+    /* we're still missing ANY_LAYOUT */
+    /* virtio_add_feature(&features, VIRTIO_F_VERSION_1); */
+    return features;
+}
+
 static void virtio_blk_set_status(VirtIODevice *vdev, uint8_t status)
 {
     VirtIOBlock *s = VIRTIO_BLK(vdev);
@@ -821,6 +839,7 @@ static void virtio_blk_class_init(ObjectClass *klass, void *data)
     vdc->get_config = virtio_blk_update_config;
     vdc->set_config = virtio_blk_set_config;
     vdc->get_features = virtio_blk_get_features;
+    vdc->get_features_rev = virtio_blk_get_features_rev;
     vdc->set_status = virtio_blk_set_status;
     vdc->reset = virtio_blk_reset;
     vdc->save = virtio_blk_save_device;
-- 
1.7.9.5
