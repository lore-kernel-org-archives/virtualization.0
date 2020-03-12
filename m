From: Hui Zhu <teawater@gmail.com>
Subject: [RFC for QEMU] virtio-balloon: Add option thp-order to set VIRTIO_BALLOON_F_THP_ORDER
Date: Thu, 12 Mar 2020 15:49:55 +0800
Message-ID: <1583999395-9131-2-git-send-email-teawater@gmail.com>
References: <1583999395-9131-1-git-send-email-teawater@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1583999395-9131-1-git-send-email-teawater@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: mst@redhat.com, jasowang@redhat.com, akpm@linux-foundation.org, pagupta@redhat.com, mojha@codeaurora.org, david@redhat.com, namit@vmware.com, virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org, qemu-devel@nongnu.org
Cc: Hui Zhu <teawater@gmail.com>, Hui Zhu <teawaterz@linux.alibaba.com>
List-Id: virtualization@lists.linuxfoundation.org

If the guest kernel has many fragmentation pages, use virtio_balloon
will split THP of QEMU when it calls MADV_DONTNEED madvise to release
the balloon pages.
Set option thp-order to on will open flags VIRTIO_BALLOON_F_THP_ORDER.
It will set balloon size to THP size to handle the THP split issue.

Signed-off-by: Hui Zhu <teawaterz@linux.alibaba.com>
---
 hw/virtio/virtio-balloon.c                      | 67 ++++++++++++++++---------
 include/standard-headers/linux/virtio_balloon.h |  4 ++
 2 files changed, 47 insertions(+), 24 deletions(-)

diff --git a/hw/virtio/virtio-balloon.c b/hw/virtio/virtio-balloon.c
index a4729f7..cfe86b0 100644
--- a/hw/virtio/virtio-balloon.c
+++ b/hw/virtio/virtio-balloon.c
@@ -340,37 +340,49 @@ static void virtio_balloon_handle_output(VirtIODevice *vdev, VirtQueue *vq)
         while (iov_to_buf(elem->out_sg, elem->out_num, offset, &pfn, 4) == 4) {
             unsigned int p = virtio_ldl_p(vdev, &pfn);
             hwaddr pa;
+            size_t handle_size = BALLOON_PAGE_SIZE;
 
             pa = (hwaddr) p << VIRTIO_BALLOON_PFN_SHIFT;
             offset += 4;
 
-            section = memory_region_find(get_system_memory(), pa,
-                                         BALLOON_PAGE_SIZE);
-            if (!section.mr) {
-                trace_virtio_balloon_bad_addr(pa);
-                continue;
-            }
-            if (!memory_region_is_ram(section.mr) ||
-                memory_region_is_rom(section.mr) ||
-                memory_region_is_romd(section.mr)) {
-                trace_virtio_balloon_bad_addr(pa);
-                memory_region_unref(section.mr);
-                continue;
-            }
+            if (virtio_has_feature(s->host_features,
+                                   VIRTIO_BALLOON_F_THP_ORDER))
+                handle_size = BALLOON_PAGE_SIZE << VIRTIO_BALLOON_THP_ORDER;
+
+            while (handle_size > 0) {
+                section = memory_region_find(get_system_memory(), pa,
+                                             BALLOON_PAGE_SIZE);
+                if (!section.mr) {
+                    trace_virtio_balloon_bad_addr(pa);
+                    continue;
+                }
+                if (!memory_region_is_ram(section.mr) ||
+                    memory_region_is_rom(section.mr) ||
+                    memory_region_is_romd(section.mr)) {
+                    trace_virtio_balloon_bad_addr(pa);
+                    memory_region_unref(section.mr);
+                    continue;
+                }
 
-            trace_virtio_balloon_handle_output(memory_region_name(section.mr),
-                                               pa);
-            if (!qemu_balloon_is_inhibited()) {
-                if (vq == s->ivq) {
-                    balloon_inflate_page(s, section.mr,
-                                         section.offset_within_region, &pbp);
-                } else if (vq == s->dvq) {
-                    balloon_deflate_page(s, section.mr, section.offset_within_region);
-                } else {
-                    g_assert_not_reached();
+                trace_virtio_balloon_handle_output(memory_region_name(section.mr),
+                                                   pa);
+                if (!qemu_balloon_is_inhibited()) {
+                    if (vq == s->ivq) {
+                        balloon_inflate_page(s, section.mr,
+                                             section.offset_within_region,
+                                             &pbp);
+                    } else if (vq == s->dvq) {
+                        balloon_deflate_page(s, section.mr,
+                                             section.offset_within_region);
+                    } else {
+                        g_assert_not_reached();
+                    }
                 }
+                memory_region_unref(section.mr);
+
+                pa += BALLOON_PAGE_SIZE;
+                handle_size -= BALLOON_PAGE_SIZE;
             }
-            memory_region_unref(section.mr);
         }
 
         virtqueue_push(vq, elem, offset);
@@ -693,6 +705,8 @@ static void virtio_balloon_set_config(VirtIODevice *vdev,
 
     memcpy(&config, config_data, virtio_balloon_config_size(dev));
     dev->actual = le32_to_cpu(config.actual);
+    if (virtio_has_feature(vdev->host_features, VIRTIO_BALLOON_F_THP_ORDER))
+        dev->actual <<= VIRTIO_BALLOON_THP_ORDER;
     if (dev->actual != oldactual) {
         qapi_event_send_balloon_change(vm_ram_size -
                         ((ram_addr_t) dev->actual << VIRTIO_BALLOON_PFN_SHIFT));
@@ -728,6 +742,9 @@ static void virtio_balloon_to_target(void *opaque, ram_addr_t target)
     }
     if (target) {
         dev->num_pages = (vm_ram_size - target) >> VIRTIO_BALLOON_PFN_SHIFT;
+        if (virtio_has_feature(dev->host_features,
+                               VIRTIO_BALLOON_F_THP_ORDER))
+            dev->num_pages >>= VIRTIO_BALLOON_THP_ORDER;
         virtio_notify_config(vdev);
     }
     trace_virtio_balloon_to_target(target, dev->num_pages);
@@ -916,6 +933,8 @@ static Property virtio_balloon_properties[] = {
                     VIRTIO_BALLOON_F_DEFLATE_ON_OOM, false),
     DEFINE_PROP_BIT("free-page-hint", VirtIOBalloon, host_features,
                     VIRTIO_BALLOON_F_FREE_PAGE_HINT, false),
+    DEFINE_PROP_BIT("thp-order", VirtIOBalloon, host_features,
+                    VIRTIO_BALLOON_F_THP_ORDER, false),
     /* QEMU 4.0 accidentally changed the config size even when free-page-hint
      * is disabled, resulting in QEMU 3.1 migration incompatibility.  This
      * property retains this quirk for QEMU 4.1 machine types.
diff --git a/include/standard-headers/linux/virtio_balloon.h b/include/standard-headers/linux/virtio_balloon.h
index 9375ca2..f54d613 100644
--- a/include/standard-headers/linux/virtio_balloon.h
+++ b/include/standard-headers/linux/virtio_balloon.h
@@ -36,10 +36,14 @@
 #define VIRTIO_BALLOON_F_DEFLATE_ON_OOM	2 /* Deflate balloon on OOM */
 #define VIRTIO_BALLOON_F_FREE_PAGE_HINT	3 /* VQ to report free pages */
 #define VIRTIO_BALLOON_F_PAGE_POISON	4 /* Guest is using page poisoning */
+#define VIRTIO_BALLOON_F_THP_ORDER	5 /* Set balloon page order to thp order */
 
 /* Size of a PFN in the balloon interface. */
 #define VIRTIO_BALLOON_PFN_SHIFT 12
 
+/* The order of the balloon page */
+#define VIRTIO_BALLOON_THP_ORDER 9
+
 #define VIRTIO_BALLOON_CMD_ID_STOP	0
 #define VIRTIO_BALLOON_CMD_ID_DONE	1
 struct virtio_balloon_config {
-- 
2.7.4
