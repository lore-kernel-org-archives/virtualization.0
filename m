From: Jan Kiszka <jan.kiszka@web.de>
Subject: [PATCH] tools/virtio: Fix build
Date: Sun, 13 Oct 2019 11:03:30 +0200
Message-ID: <4b686914-075b-a0a9-c97b-9def82ee0336__49966.0782910482$1570957937$gmane$org@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Language: en-US
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: virtualization@lists.linuxfoundation.org

From: Jan Kiszka <jan.kiszka@siemens.com>

Various changes in the recent kernel versions broke the build due to
missing function and header stubs.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 tools/virtio/crypto/hash.h       | 0
 tools/virtio/linux/dma-mapping.h | 2 ++
 tools/virtio/linux/kernel.h      | 2 ++
 3 files changed, 4 insertions(+)
 create mode 100644 tools/virtio/crypto/hash.h

diff --git a/tools/virtio/crypto/hash.h b/tools/virtio/crypto/hash.h
new file mode 100644
index 000000000000..e69de29bb2d1
diff --git a/tools/virtio/linux/dma-mapping.h b/tools/virtio/linux/dma-mapping.h
index f91aeb5fe571..db96cb4bf877 100644
--- a/tools/virtio/linux/dma-mapping.h
+++ b/tools/virtio/linux/dma-mapping.h
@@ -29,4 +29,6 @@ enum dma_data_direction {
 #define dma_unmap_single(...) do { } while (0)
 #define dma_unmap_page(...) do { } while (0)

+#define dma_max_mapping_size(d)	0
+
 #endif
diff --git a/tools/virtio/linux/kernel.h b/tools/virtio/linux/kernel.h
index 6683b4a70b05..ccf321173210 100644
--- a/tools/virtio/linux/kernel.h
+++ b/tools/virtio/linux/kernel.h
@@ -141,4 +141,6 @@ static inline void free_page(unsigned long addr)
 #define list_for_each_entry(a, b, c) while (0)
 /* end of stubs */

+#define xen_domain() 0
+
 #endif /* KERNEL_H */
--
2.16.4
