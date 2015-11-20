From: Ming Lin <mlin@kernel.org>
Subject: [RFC PATCH 8/9] nvme-vhost: add vhost memory helpers
Date: Thu, 19 Nov 2015 16:21:07 -0800
Message-ID: <1447978868-17138-9-git-send-email-mlin@kernel.org>
References: <1447978868-17138-1-git-send-email-mlin@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1447978868-17138-1-git-send-email-mlin@kernel.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: linux-nvme@lists.infradead.org
Cc: Ming Lin <ming.l@ssi.samsung.com>, qemu-devel@nongnu.org, virtualization@lists.linux-foundation.org, Christoph Hellwig <hch@lst.de>
List-Id: virtualization@lists.linuxfoundation.org

From: Ming Lin <ming.l@ssi.samsung.com>

This borrows code from Hannes Reinecke's rts-megasas.

Cc: Hannes Reinecke <hare@suse.de>
Signed-off-by: Ming Lin <ming.l@ssi.samsung.com>
---
 drivers/nvme/target/vhost.c | 108 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 108 insertions(+)

diff --git a/drivers/nvme/target/vhost.c b/drivers/nvme/target/vhost.c
index 04ed0bc..6847c86 100644
--- a/drivers/nvme/target/vhost.c
+++ b/drivers/nvme/target/vhost.c
@@ -5,6 +5,7 @@
 #include <linux/miscdevice.h>
 #include <linux/mutex.h>
 #include <linux/file.h>
+#include <linux/highmem.h>
 #include "../../vhost/vhost.h"
 #include "nvmet.h"
 
@@ -95,6 +96,113 @@ struct nvmet_vhost_ctrl {
 	u32 page_size;
 };
 
+const struct vhost_memory_region *
+find_region(struct vhost_dev *hba, __u64 addr, __u32 len)
+{
+	struct vhost_memory *mem;
+	struct vhost_memory_region *reg;
+	int i;
+
+	if (!hba->memory)
+		return NULL;
+
+	mem = hba->memory;
+	/* linear search is not brilliant, but we really have on the order of 6
+	 * regions in practice */
+	for (i = 0; i < mem->nregions; ++i) {
+		reg = mem->regions + i;
+		if (reg->guest_phys_addr <= addr &&
+		    reg->guest_phys_addr + reg->memory_size - 1 >= addr)
+			return reg;
+	}
+	return NULL;
+}
+
+static bool check_region_boundary(const struct vhost_memory_region *reg,
+				  uint64_t addr, size_t len)
+{
+	unsigned long max_size;
+
+	max_size = reg->memory_size - addr + reg->guest_phys_addr;
+	return (max_size < len);
+}
+
+static void __user *map_to_region(const struct vhost_memory_region *reg,
+				   uint64_t addr)
+{
+	return (void __user *)(unsigned long)
+		(reg->userspace_addr + addr - reg->guest_phys_addr);
+}
+
+static void __user *map_guest_to_host(struct vhost_dev *dev,
+				       uint64_t addr, int size)
+{
+	const struct vhost_memory_region *reg = NULL;
+
+	reg = find_region(dev, addr, size);
+	if (unlikely(!reg))
+		return ERR_PTR(-EPERM);
+
+	if (unlikely(check_region_boundary(reg, addr, size)))
+		return ERR_PTR(-EFAULT);
+
+	return map_to_region(reg, addr);
+}
+
+static int nvmet_vhost_rw(struct vhost_dev *dev, u64 guest_pa,
+		void *buf, uint32_t size, int write)
+{
+	void __user *host_user_va;
+	void *host_kernel_va;
+	struct page *page;
+	uintptr_t offset;
+	int ret;
+
+	host_user_va = map_guest_to_host(dev, guest_pa, size);
+	if (unlikely(!host_user_va)) {
+		pr_warn("cannot map guest addr %p, error %ld\n",
+			(void *)guest_pa, PTR_ERR(host_user_va));
+		return -EINVAL;
+	}
+
+	ret = get_user_pages(current, dev->mm,
+				(unsigned long)host_user_va, 1,
+				false, 0, &page, NULL);
+	if (unlikely(ret != 1)) {
+		pr_warn("get_user_pages fail!!!\n");
+		return -EINVAL;
+	}
+
+	host_kernel_va = kmap(page);
+	if (unlikely(!host_kernel_va)) {
+		pr_warn("kmap fail!!!\n");
+		put_page(page);
+		return -EINVAL;
+	}
+
+	offset = (uintptr_t)host_user_va & ~PAGE_MASK;
+	if (write)
+		memcpy(host_kernel_va + offset, buf, size);
+	else
+		memcpy(buf, host_kernel_va + offset, size);
+	kunmap(host_kernel_va);
+	put_page(page);
+
+	return 0;
+}
+
+int nvmet_vhost_read(struct vhost_dev *dev, u64 guest_pa,
+		void *buf, uint32_t size)
+{
+	return nvmet_vhost_rw(dev, guest_pa, buf, size, 0);
+}
+
+int nvmet_vhost_write(struct vhost_dev *dev, u64 guest_pa,
+		void *buf, uint32_t size)
+{
+	return nvmet_vhost_rw(dev, guest_pa, buf, size, 1);
+}
+
 #define sq_to_vsq(sq) container_of(sq, struct nvmet_vhost_sq, sq)
 #define cq_to_vcq(cq) container_of(cq, struct nvmet_vhost_cq, cq)
 
-- 
1.9.1
