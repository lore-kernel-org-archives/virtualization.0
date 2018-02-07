From: Wei Wang <wei.w.wang@intel.com>
Subject: [PATCH v27 4/4] virtio-balloon: VIRTIO_BALLOON_F_PAGE_POISON
Date: Wed,  7 Feb 2018 14:54:31 +0800
Message-ID: <1517986471-15185-5-git-send-email-wei.w.wang__26968.9572196969$1517987594$gmane$org@intel.com>
References: <1517986471-15185-1-git-send-email-wei.w.wang@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1517986471-15185-1-git-send-email-wei.w.wang@intel.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: virtio-dev@lists.oasis-open.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, kvm@vger.kernel.org, linux-mm@kvack.org, mst@redhat.com, mhocko@kernel.org, akpm@linux-foundation.org
Cc: yang.zhang.wz@gmail.com, riel@redhat.com, quan.xu0@gmail.com, liliang.opensource@gmail.com, huangzhichao@huawei.com, pbonzini@redhat.com, nilal@redhat.com
List-Id: virtualization@lists.linuxfoundation.org

The VIRTIO_BALLOON_F_PAGE_POISON feature bit is used to indicate if the
guest is using page poisoning. Guest writes to the poison_val config
field to tell host about the page poisoning value in use.

Signed-off-by: Wei Wang <wei.w.wang@intel.com>
Suggested-by: Michael S. Tsirkin <mst@redhat.com>
Cc: Michael S. Tsirkin <mst@redhat.com>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
---
 drivers/virtio/virtio_balloon.c     | 10 ++++++++++
 include/uapi/linux/virtio_balloon.h |  3 +++
 2 files changed, 13 insertions(+)

diff --git a/drivers/virtio/virtio_balloon.c b/drivers/virtio/virtio_balloon.c
index 39ecce3..76b4853 100644
--- a/drivers/virtio/virtio_balloon.c
+++ b/drivers/virtio/virtio_balloon.c
@@ -685,6 +685,7 @@ static struct file_system_type balloon_fs = {
 static int virtballoon_probe(struct virtio_device *vdev)
 {
 	struct virtio_balloon *vb;
+	__u32 poison_val;
 	int err;
 
 	if (!vdev->config->get) {
@@ -728,6 +729,11 @@ static int virtballoon_probe(struct virtio_device *vdev)
 			goto out_del_vqs;
 		}
 		INIT_WORK(&vb->report_free_page_work, report_free_page_func);
+		if (virtio_has_feature(vdev, VIRTIO_BALLOON_F_PAGE_POISON)) {
+			memset(&poison_val, PAGE_POISON, sizeof(poison_val));
+			virtio_cwrite(vb->vdev, struct virtio_balloon_config,
+				      poison_val, &poison_val);
+		}
 	}
 
 	vb->nb.notifier_call = virtballoon_oom_notify;
@@ -846,6 +852,9 @@ static int virtballoon_restore(struct virtio_device *vdev)
 
 static int virtballoon_validate(struct virtio_device *vdev)
 {
+	if (!page_poisoning_enabled())
+		__virtio_clear_bit(vdev, VIRTIO_BALLOON_F_PAGE_POISON);
+
 	__virtio_clear_bit(vdev, VIRTIO_F_IOMMU_PLATFORM);
 	return 0;
 }
@@ -855,6 +864,7 @@ static unsigned int features[] = {
 	VIRTIO_BALLOON_F_STATS_VQ,
 	VIRTIO_BALLOON_F_DEFLATE_ON_OOM,
 	VIRTIO_BALLOON_F_FREE_PAGE_HINT,
+	VIRTIO_BALLOON_F_PAGE_POISON,
 };
 
 static struct virtio_driver virtio_balloon_driver = {
diff --git a/include/uapi/linux/virtio_balloon.h b/include/uapi/linux/virtio_balloon.h
index 0c654db..3f97067 100644
--- a/include/uapi/linux/virtio_balloon.h
+++ b/include/uapi/linux/virtio_balloon.h
@@ -35,6 +35,7 @@
 #define VIRTIO_BALLOON_F_STATS_VQ	1 /* Memory Stats virtqueue */
 #define VIRTIO_BALLOON_F_DEFLATE_ON_OOM	2 /* Deflate balloon on OOM */
 #define VIRTIO_BALLOON_F_FREE_PAGE_HINT	3 /* VQ to report free pages */
+#define VIRTIO_BALLOON_F_PAGE_POISON	4 /* Guest is using page poisoning */
 
 /* Size of a PFN in the balloon interface. */
 #define VIRTIO_BALLOON_PFN_SHIFT 12
@@ -47,6 +48,8 @@ struct virtio_balloon_config {
 	__u32 actual;
 	/* Free page report command id, readonly by guest */
 	__u32 free_page_report_cmd_id;
+	/* Stores PAGE_POISON if page poisoning is in use */
+	__u32 poison_val;
 };
 
 #define VIRTIO_BALLOON_S_SWAP_IN  0   /* Amount of memory swapped in */
-- 
2.7.4
