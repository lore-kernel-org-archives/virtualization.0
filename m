From: Liang Li <liang.z.li@intel.com>
Subject: [PATCH v3 kernel 7/7] virtio-balloon: tell host vm's unused page info
Date: Mon,  8 Aug 2016 14:35:34 +0800
Message-ID: <1470638134-24149-8-git-send-email-liang.z.li__11229.72389353$1470638682$gmane$org@intel.com>
References: <1470638134-24149-1-git-send-email-liang.z.li@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1470638134-24149-1-git-send-email-liang.z.li@intel.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: linux-kernel@vger.kernel.org
Cc: virtio-dev@lists.oasis-open.org, kvm@vger.kernel.org, Amit Shah <amit.shah@redhat.com>, Liang Li <liang.z.li@intel.com>, dave.hansen@intel.com, qemu-devel@nongnu.org, virtualization@lists.linux-foundation.org, linux-mm@kvack.org, "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, dgilbert@redhat.com
List-Id: virtualization@lists.linuxfoundation.org

Support the request for vm's unused page information, response with
a page bitmap. QEMU can make use of this bitmap and the dirty page
logging mechanism to skip the transportation of these unused pages,
this is very helpful to speed up the live migration process.

Signed-off-by: Liang Li <liang.z.li@intel.com>
Cc: Michael S. Tsirkin <mst@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Cornelia Huck <cornelia.huck@de.ibm.com>
Cc: Amit Shah <amit.shah@redhat.com>
Cc: Dave Hansen <dave.hansen@intel.com>
---
 drivers/virtio/virtio_balloon.c | 143 +++++++++++++++++++++++++++++++++++++---
 1 file changed, 134 insertions(+), 9 deletions(-)

diff --git a/drivers/virtio/virtio_balloon.c b/drivers/virtio/virtio_balloon.c
index c31839c..f10bb8b 100644
--- a/drivers/virtio/virtio_balloon.c
+++ b/drivers/virtio/virtio_balloon.c
@@ -56,7 +56,7 @@ static struct vfsmount *balloon_mnt;
 
 struct virtio_balloon {
 	struct virtio_device *vdev;
-	struct virtqueue *inflate_vq, *deflate_vq, *stats_vq;
+	struct virtqueue *inflate_vq, *deflate_vq, *stats_vq, *misc_vq;
 
 	/* The balloon servicing is delegated to a freezable workqueue. */
 	struct work_struct update_balloon_stats_work;
@@ -78,6 +78,8 @@ struct virtio_balloon {
 	unsigned int nr_page_bmap;
 	/* Used to record the processed pfn range */
 	unsigned long min_pfn, max_pfn, start_pfn, end_pfn;
+	/* Request header */
+	struct balloon_req_hdr req_hdr;
 	/*
 	 * The pages we've told the Host we're not using are enqueued
 	 * at vb_dev_info->pages list.
@@ -423,6 +425,78 @@ static void update_balloon_stats(struct virtio_balloon *vb)
 				pages_to_bytes(available));
 }
 
+static void send_unused_pages_info(struct virtio_balloon *vb,
+				unsigned long req_id)
+{
+	struct scatterlist sg_in, sg_out[BALLOON_BMAP_COUNT + 1];
+	unsigned long pfn = 0, bmap_len, pfn_limit, last_pfn, nr_pfn;
+	struct virtqueue *vq = vb->misc_vq;
+	struct balloon_bmap_hdr *hdr = vb->bmap_hdr;
+	int ret = 1, nr_buf, used_nr_bmap = 0, i;
+
+	if (virtio_has_feature(vb->vdev, VIRTIO_BALLOON_F_PAGE_BITMAP) &&
+		vb->nr_page_bmap == 1)
+		extend_page_bitmap(vb);
+
+	pfn_limit = PFNS_PER_BMAP * vb->nr_page_bmap;
+	mutex_lock(&vb->balloon_lock);
+	last_pfn = get_max_pfn();
+
+	while (ret) {
+		clear_page_bitmap(vb);
+		ret = get_unused_pages(pfn, pfn + pfn_limit, vb->page_bitmap,
+			 PFNS_PER_BMAP, vb->nr_page_bmap);
+		if (ret < 0)
+			break;
+		hdr->cmd = cpu_to_virtio16(vb->vdev, BALLOON_GET_UNUSED_PAGES);
+		hdr->page_shift = cpu_to_virtio16(vb->vdev, PAGE_SHIFT);
+		hdr->req_id = cpu_to_virtio64(vb->vdev, req_id);
+		hdr->start_pfn = cpu_to_virtio64(vb->vdev, pfn);
+		bmap_len = BALLOON_BMAP_SIZE * vb->nr_page_bmap;
+
+		if (!ret) {
+			hdr->flag = cpu_to_virtio16(vb->vdev,
+						 BALLOON_FLAG_DONE);
+			nr_pfn = last_pfn - pfn;
+			used_nr_bmap = nr_pfn / PFNS_PER_BMAP;
+			if (nr_pfn % PFNS_PER_BMAP)
+				used_nr_bmap++;
+			bmap_len = nr_pfn / BITS_PER_BYTE;
+		} else {
+			hdr->flag = cpu_to_virtio16(vb->vdev,
+							BALLOON_FLAG_CONT);
+			used_nr_bmap = vb->nr_page_bmap;
+		}
+		hdr->bmap_len = cpu_to_virtio64(vb->vdev, bmap_len);
+		nr_buf = used_nr_bmap + 1;
+		sg_init_table(sg_out, nr_buf);
+		sg_set_buf(&sg_out[0], hdr, sizeof(struct balloon_bmap_hdr));
+		for (i = 0; i < used_nr_bmap; i++) {
+			unsigned int buf_len = BALLOON_BMAP_SIZE;
+
+			if (i + 1 == used_nr_bmap)
+				buf_len = bmap_len - BALLOON_BMAP_SIZE * i;
+			sg_set_buf(&sg_out[i + 1], vb->page_bitmap[i], buf_len);
+		}
+
+		while (vq->num_free < nr_buf)
+			msleep(2);
+		if (virtqueue_add_outbuf(vq, sg_out, nr_buf, vb,
+				 GFP_KERNEL) == 0) {
+			virtqueue_kick(vq);
+			while (!virtqueue_get_buf(vq, &i)
+				&& !virtqueue_is_broken(vq))
+				cpu_relax();
+		}
+		pfn += pfn_limit;
+	}
+
+	mutex_unlock(&vb->balloon_lock);
+	sg_init_one(&sg_in, &vb->req_hdr, sizeof(vb->req_hdr));
+	virtqueue_add_inbuf(vq, &sg_in, 1, &vb->req_hdr, GFP_KERNEL);
+	virtqueue_kick(vq);
+}
+
 /*
  * While most virtqueues communicate guest-initiated requests to the hypervisor,
  * the stats queue operates in reverse.  The driver initializes the virtqueue
@@ -563,18 +637,56 @@ static void update_balloon_size_func(struct work_struct *work)
 		queue_work(system_freezable_wq, work);
 }
 
+static void misc_handle_rq(struct virtio_balloon *vb)
+{
+	struct balloon_req_hdr *ptr_hdr;
+	unsigned int len;
+
+	ptr_hdr = virtqueue_get_buf(vb->misc_vq, &len);
+	if (!ptr_hdr || len != sizeof(vb->req_hdr))
+		return;
+
+	switch (ptr_hdr->cmd) {
+	case BALLOON_GET_UNUSED_PAGES:
+		send_unused_pages_info(vb, ptr_hdr->param);
+		break;
+	default:
+		break;
+	}
+}
+
+static void misc_request(struct virtqueue *vq)
+{
+	struct virtio_balloon *vb = vq->vdev->priv;
+
+	misc_handle_rq(vb);
+}
+
 static int init_vqs(struct virtio_balloon *vb)
 {
-	struct virtqueue *vqs[3];
-	vq_callback_t *callbacks[] = { balloon_ack, balloon_ack, stats_request };
-	static const char * const names[] = { "inflate", "deflate", "stats" };
+	struct virtqueue *vqs[4];
+	vq_callback_t *callbacks[] = { balloon_ack, balloon_ack,
+					 stats_request, misc_request };
+	static const char * const names[] = { "inflate", "deflate", "stats",
+						 "misc" };
 	int err, nvqs;
 
 	/*
 	 * We expect two virtqueues: inflate and deflate, and
 	 * optionally stat.
 	 */
-	nvqs = virtio_has_feature(vb->vdev, VIRTIO_BALLOON_F_STATS_VQ) ? 3 : 2;
+	if (virtio_has_feature(vb->vdev, VIRTIO_BALLOON_F_MISC_VQ))
+		nvqs = 4;
+	else if (virtio_has_feature(vb->vdev, VIRTIO_BALLOON_F_STATS_VQ))
+		nvqs = 3;
+	else
+		nvqs = 2;
+
+	if (!virtio_has_feature(vb->vdev, VIRTIO_BALLOON_F_STATS_VQ)) {
+		__virtio_clear_bit(vb->vdev, VIRTIO_BALLOON_F_PAGE_BITMAP);
+		__virtio_clear_bit(vb->vdev, VIRTIO_BALLOON_F_MISC_VQ);
+	}
+
 	err = vb->vdev->config->find_vqs(vb->vdev, nvqs, vqs, callbacks, names);
 	if (err)
 		return err;
@@ -595,6 +707,16 @@ static int init_vqs(struct virtio_balloon *vb)
 			BUG();
 		virtqueue_kick(vb->stats_vq);
 	}
+	if (virtio_has_feature(vb->vdev, VIRTIO_BALLOON_F_MISC_VQ)) {
+		struct scatterlist sg_in;
+
+		vb->misc_vq = vqs[3];
+		sg_init_one(&sg_in, &vb->req_hdr, sizeof(vb->req_hdr));
+		if (virtqueue_add_inbuf(vb->misc_vq, &sg_in, 1,
+		    &vb->req_hdr, GFP_KERNEL) < 0)
+			BUG();
+		virtqueue_kick(vb->misc_vq);
+	}
 	return 0;
 }
 
@@ -703,13 +825,15 @@ static int virtballoon_probe(struct virtio_device *vdev)
 	vb->num_pages = 0;
 	vb->bmap_hdr = kzalloc(sizeof(struct balloon_bmap_hdr), GFP_KERNEL);
 	/* Clear the feature bit if memory allocation fails */
-	if (!vb->bmap_hdr)
+	if (!vb->bmap_hdr) {
 		__virtio_clear_bit(vdev, VIRTIO_BALLOON_F_PAGE_BITMAP);
-	else {
+		__virtio_clear_bit(vdev, VIRTIO_BALLOON_F_MISC_VQ);
+	} else {
 		vb->page_bitmap[0] = kmalloc(BALLOON_BMAP_SIZE, GFP_KERNEL);
-		if (!vb->page_bitmap[0])
+		if (!vb->page_bitmap[0]) {
 			__virtio_clear_bit(vdev, VIRTIO_BALLOON_F_PAGE_BITMAP);
-		else
+			__virtio_clear_bit(vdev, VIRTIO_BALLOON_F_MISC_VQ);
+		} else
 			vb->nr_page_bmap = 1;
 	}
 	mutex_init(&vb->balloon_lock);
@@ -832,6 +956,7 @@ static unsigned int features[] = {
 	VIRTIO_BALLOON_F_STATS_VQ,
 	VIRTIO_BALLOON_F_DEFLATE_ON_OOM,
 	VIRTIO_BALLOON_F_PAGE_BITMAP,
+	VIRTIO_BALLOON_F_MISC_VQ,
 };
 
 static struct virtio_driver virtio_balloon_driver = {
-- 
1.8.3.1
