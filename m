From: Hui Zhu <teawater@gmail.com>
Subject: [PATCH for QEMU v2] virtio-balloon: Add option cont-pages to set VIRTIO_BALLOON_VQ_INFLATE_CONT
Date: Mon, 23 Mar 2020 00:04:57 +0800
Message-ID: <1584893097-12317-2-git-send-email-teawater@gmail.com>
References: <1584893097-12317-1-git-send-email-teawater@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1584893097-12317-1-git-send-email-teawater@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: mst@redhat.com, jasowang@redhat.com, akpm@linux-foundation.org, mojha@codeaurora.org, pagupta@redhat.com, aquini@redhat.com, namit@vmware.com, david@redhat.com, virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, qemu-devel@nongnu.org
Cc: Hui Zhu <teawater@gmail.com>, Hui Zhu <teawaterz@linux.alibaba.com>
List-Id: virtualization@lists.linuxfoundation.org

If the guest kernel has many fragmentation pages, use virtio_balloon
will split THP of QEMU when it calls MADV_DONTNEED madvise to release
the balloon pages.
Set option cont-pages to on will open flags VIRTIO_BALLOON_VQ_INFLATE_CONT
and set continuous pages order to THP order.
Then It will get continuous pages PFN from VQ icvq use use madvise
MADV_DONTNEED release the THP page.
This will handle the THP split issue.

Signed-off-by: Hui Zhu <teawaterz@linux.alibaba.com>
---
 hw/virtio/virtio-balloon.c                      | 32 +++++++++++++++++++++----
 include/hw/virtio/virtio-balloon.h              |  4 +++-
 include/standard-headers/linux/virtio_balloon.h |  4 ++++
 3 files changed, 35 insertions(+), 5 deletions(-)

diff --git a/hw/virtio/virtio-balloon.c b/hw/virtio/virtio-balloon.c
index a4729f7..88bdaca 100644
--- a/hw/virtio/virtio-balloon.c
+++ b/hw/virtio/virtio-balloon.c
@@ -34,6 +34,7 @@
 #include "hw/virtio/virtio-access.h"
 
 #define BALLOON_PAGE_SIZE  (1 << VIRTIO_BALLOON_PFN_SHIFT)
+#define CONT_PAGES_ORDER   9
 
 typedef struct PartiallyBalloonedPage {
     ram_addr_t base_gpa;
@@ -65,7 +66,8 @@ static bool virtio_balloon_pbp_matches(PartiallyBalloonedPage *pbp,
 
 static void balloon_inflate_page(VirtIOBalloon *balloon,
                                  MemoryRegion *mr, hwaddr mr_offset,
-                                 PartiallyBalloonedPage *pbp)
+                                 PartiallyBalloonedPage *pbp, 
+                                 bool is_cont_pages)
 {
     void *addr = memory_region_get_ram_ptr(mr) + mr_offset;
     ram_addr_t rb_offset, rb_aligned_offset, base_gpa;
@@ -76,6 +78,13 @@ static void balloon_inflate_page(VirtIOBalloon *balloon,
     /* XXX is there a better way to get to the RAMBlock than via a
      * host address? */
     rb = qemu_ram_block_from_host(addr, false, &rb_offset);
+
+    if (is_cont_pages) {
+        ram_block_discard_range(rb, rb_offset,
+                                BALLOON_PAGE_SIZE << CONT_PAGES_ORDER);
+        return;
+    }
+
     rb_page_size = qemu_ram_pagesize(rb);
 
     if (rb_page_size == BALLOON_PAGE_SIZE) {
@@ -361,9 +370,10 @@ static void virtio_balloon_handle_output(VirtIODevice *vdev, VirtQueue *vq)
             trace_virtio_balloon_handle_output(memory_region_name(section.mr),
                                                pa);
             if (!qemu_balloon_is_inhibited()) {
-                if (vq == s->ivq) {
+                if (vq == s->ivq || vq == s->icvq) {
                     balloon_inflate_page(s, section.mr,
-                                         section.offset_within_region, &pbp);
+                                         section.offset_within_region, &pbp,
+                                         vq == s->icvq);
                 } else if (vq == s->dvq) {
                     balloon_deflate_page(s, section.mr, section.offset_within_region);
                 } else {
@@ -618,9 +628,12 @@ static size_t virtio_balloon_config_size(VirtIOBalloon *s)
     if (s->qemu_4_0_config_size) {
         return sizeof(struct virtio_balloon_config);
     }
-    if (virtio_has_feature(features, VIRTIO_BALLOON_F_PAGE_POISON)) {
+    if (virtio_has_feature(s->host_features, VIRTIO_BALLOON_F_CONT_PAGES)) {
         return sizeof(struct virtio_balloon_config);
     }
+    if (virtio_has_feature(features, VIRTIO_BALLOON_F_PAGE_POISON)) {
+        return offsetof(struct virtio_balloon_config, pages_order);
+    }
     if (virtio_has_feature(features, VIRTIO_BALLOON_F_FREE_PAGE_HINT)) {
         return offsetof(struct virtio_balloon_config, poison_val);
     }
@@ -646,6 +659,10 @@ static void virtio_balloon_get_config(VirtIODevice *vdev, uint8_t *config_data)
                        cpu_to_le32(VIRTIO_BALLOON_CMD_ID_DONE);
     }
 
+    if (virtio_has_feature(dev->host_features, VIRTIO_BALLOON_F_CONT_PAGES)) {
+        config.pages_order = cpu_to_le32(CONT_PAGES_ORDER);
+    }
+
     trace_virtio_balloon_get_config(config.num_pages, config.actual);
     memcpy(config_data, &config, virtio_balloon_config_size(dev));
 }
@@ -816,6 +833,11 @@ static void virtio_balloon_device_realize(DeviceState *dev, Error **errp)
             virtio_error(vdev, "iothread is missing");
         }
     }
+
+    if (virtio_has_feature(s->host_features, VIRTIO_BALLOON_F_CONT_PAGES)) {
+        s->icvq = virtio_add_queue(vdev, 128, virtio_balloon_handle_output);
+    }
+
     reset_stats(s);
 }
 
@@ -916,6 +938,8 @@ static Property virtio_balloon_properties[] = {
                     VIRTIO_BALLOON_F_DEFLATE_ON_OOM, false),
     DEFINE_PROP_BIT("free-page-hint", VirtIOBalloon, host_features,
                     VIRTIO_BALLOON_F_FREE_PAGE_HINT, false),
+    DEFINE_PROP_BIT("cont-pages", VirtIOBalloon, host_features,
+                    VIRTIO_BALLOON_F_CONT_PAGES, false),
     /* QEMU 4.0 accidentally changed the config size even when free-page-hint
      * is disabled, resulting in QEMU 3.1 migration incompatibility.  This
      * property retains this quirk for QEMU 4.1 machine types.
diff --git a/include/hw/virtio/virtio-balloon.h b/include/hw/virtio/virtio-balloon.h
index d1c968d..61d2419 100644
--- a/include/hw/virtio/virtio-balloon.h
+++ b/include/hw/virtio/virtio-balloon.h
@@ -42,7 +42,7 @@ enum virtio_balloon_free_page_report_status {
 
 typedef struct VirtIOBalloon {
     VirtIODevice parent_obj;
-    VirtQueue *ivq, *dvq, *svq, *free_page_vq;
+    VirtQueue *ivq, *dvq, *svq, *free_page_vq, *icvq;
     uint32_t free_page_report_status;
     uint32_t num_pages;
     uint32_t actual;
@@ -70,6 +70,8 @@ typedef struct VirtIOBalloon {
     uint32_t host_features;
 
     bool qemu_4_0_config_size;
+
+    uint32_t pages_order;
 } VirtIOBalloon;
 
 #endif
diff --git a/include/standard-headers/linux/virtio_balloon.h b/include/standard-headers/linux/virtio_balloon.h
index 9375ca2..ee18be7 100644
--- a/include/standard-headers/linux/virtio_balloon.h
+++ b/include/standard-headers/linux/virtio_balloon.h
@@ -36,6 +36,8 @@
 #define VIRTIO_BALLOON_F_DEFLATE_ON_OOM	2 /* Deflate balloon on OOM */
 #define VIRTIO_BALLOON_F_FREE_PAGE_HINT	3 /* VQ to report free pages */
 #define VIRTIO_BALLOON_F_PAGE_POISON	4 /* Guest is using page poisoning */
+#define VIRTIO_BALLOON_F_CONT_PAGES	5 /* VQ to report continuous pages */
+
 
 /* Size of a PFN in the balloon interface. */
 #define VIRTIO_BALLOON_PFN_SHIFT 12
@@ -51,6 +53,8 @@ struct virtio_balloon_config {
 	uint32_t free_page_report_cmd_id;
 	/* Stores PAGE_POISON if page poisoning is in use */
 	uint32_t poison_val;
+	/* Pages order if VIRTIO_BALLOON_F_CONT_PAGES is set */
+	uint32_t pages_order;
 };
 
 #define VIRTIO_BALLOON_S_SWAP_IN  0   /* Amount of memory swapped in */
-- 
2.7.4
