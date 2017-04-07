From: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
Subject: [RFC PATCH kvmtool 04/15] Add a simple IOMMU
Date: Fri,  7 Apr 2017 20:24:44 +0100
Message-ID: <20170407192455.26814-5-jean-philippe.brucker__9429.53584385595$1491593132$gmane$org@arm.com>
References: <20170407191747.26618-1-jean-philippe.brucker@arm.com>
	<20170407192455.26814-1-jean-philippe.brucker@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20170407192455.26814-1-jean-philippe.brucker@arm.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: iommu@lists.linux-foundation.org, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org, virtio-dev@lists.oasis-open.org
Cc: cdall@linaro.org, lorenzo.pieralisi@arm.com, mst@redhat.com, marc.zyngier@arm.com, joro@8bytes.org, will.deacon@arm.com, robin.murphy@arm.com
List-Id: virtualization@lists.linuxfoundation.org

Add a rb-tree based IOMMU with support for map, unmap and access
operations. It will be used to store mappings for virtio devices and MSI
doorbells. If needed, it could also be extended with a TLB implementation.

Signed-off-by: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
---
 Makefile            |   1 +
 include/kvm/iommu.h |   9 +++
 iommu.c             | 162 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 172 insertions(+)
 create mode 100644 iommu.c

diff --git a/Makefile b/Makefile
index 67953870..0c369206 100644
--- a/Makefile
+++ b/Makefile
@@ -73,6 +73,7 @@ OBJS	+= disk/blk.o
 OBJS	+= disk/qcow.o
 OBJS	+= disk/raw.o
 OBJS	+= ioeventfd.o
+OBJS	+= iommu.o
 OBJS	+= net/uip/core.o
 OBJS	+= net/uip/arp.o
 OBJS	+= net/uip/icmp.o
diff --git a/include/kvm/iommu.h b/include/kvm/iommu.h
index 925e1993..4164ba20 100644
--- a/include/kvm/iommu.h
+++ b/include/kvm/iommu.h
@@ -61,4 +61,13 @@ static inline struct device_header *iommu_get_device(u32 device_id)
 	return device__find_dev(bus, dev_num);
 }
 
+void *iommu_alloc_address_space(struct device_header *dev);
+void iommu_free_address_space(void *address_space);
+
+int iommu_map(void *address_space, u64 virt_addr, u64 phys_addr, u64 size,
+	      int prot);
+int iommu_unmap(void *address_space, u64 virt_addr, u64 size, int flags);
+u64 iommu_access(void *address_space, u64 addr, size_t size, size_t *out_size,
+		 int prot);
+
 #endif /* KVM_IOMMU_H */
diff --git a/iommu.c b/iommu.c
new file mode 100644
index 00000000..0a662404
--- /dev/null
+++ b/iommu.c
@@ -0,0 +1,162 @@
+/*
+ * Implement basic IOMMU operations - map, unmap and translate
+ */
+#include <errno.h>
+
+#include "kvm/iommu.h"
+#include "kvm/kvm.h"
+#include "kvm/mutex.h"
+#include "kvm/rbtree-interval.h"
+
+struct iommu_mapping {
+	struct rb_int_node	iova_range;
+	u64			phys;
+	int			prot;
+};
+
+struct iommu_ioas {
+	struct rb_root		mappings;
+	struct mutex		mutex;
+};
+
+void *iommu_alloc_address_space(struct device_header *unused)
+{
+	struct iommu_ioas *ioas = calloc(1, sizeof(*ioas));
+
+	if (!ioas)
+		return NULL;
+
+	ioas->mappings = (struct rb_root)RB_ROOT;
+	mutex_init(&ioas->mutex);
+
+	return ioas;
+}
+
+void iommu_free_address_space(void *address_space)
+{
+	struct iommu_ioas *ioas = address_space;
+	struct rb_int_node *int_node;
+	struct rb_node *node, *next;
+	struct iommu_mapping *map;
+
+        /* Postorder allows to free leaves first. */
+	node = rb_first_postorder(&ioas->mappings);
+	while (node) {
+		next = rb_next_postorder(node);
+
+		int_node = rb_int(node);
+		map = container_of(int_node, struct iommu_mapping, iova_range);
+		free(map);
+
+		node = next;
+	}
+
+	free(ioas);
+}
+
+int iommu_map(void *address_space, u64 virt_addr, u64 phys_addr,
+	      u64 size, int prot)
+{
+	struct iommu_ioas *ioas = address_space;
+	struct iommu_mapping *map;
+
+	if (!ioas)
+		return -ENODEV;
+
+	map = malloc(sizeof(struct iommu_mapping));
+	if (!map)
+		return -ENOMEM;
+
+	map->phys = phys_addr;
+	map->iova_range = RB_INT_INIT(virt_addr, virt_addr + size - 1);
+	map->prot = prot;
+
+	mutex_lock(&ioas->mutex);
+	rb_int_insert(&ioas->mappings, &map->iova_range);
+	mutex_unlock(&ioas->mutex);
+
+	return 0;
+}
+
+int iommu_unmap(void *address_space, u64 virt_addr, u64 size, int flags)
+{
+	int ret = 0;
+	struct rb_int_node *node;
+	struct iommu_mapping *map;
+	struct iommu_ioas *ioas = address_space;
+
+	if (!ioas)
+		return -ENODEV;
+
+	mutex_lock(&ioas->mutex);
+	node = rb_int_search_single(&ioas->mappings, virt_addr);
+	while (node && size) {
+		struct rb_node *next = rb_next(&node->node);
+		size_t node_size = node->high - node->low + 1;
+		map = container_of(node, struct iommu_mapping, iova_range);
+
+		if (node_size > size) {
+			pr_debug("cannot split mapping");
+			ret = -EINVAL;
+			break;
+		}
+
+		size -= node_size;
+		virt_addr += node_size;
+
+		rb_erase(&node->node, &ioas->mappings);
+		free(map);
+		node = next ? container_of(next, struct rb_int_node, node) : NULL;
+	}
+
+	if (size && !ret) {
+		pr_debug("mapping not found");
+		ret = -ENXIO;
+	}
+	mutex_unlock(&ioas->mutex);
+
+	return ret;
+}
+
+/*
+ * Translate a virtual address into a physical one. Perform an access of @size
+ * bytes with protection @prot. If @addr isn't mapped in @address_space, return
+ * 0. If the permissions of the mapping don't match, return 0. If the access
+ * range specified by (addr, size) spans over multiple mappings, only access the
+ * first mapping and return the accessed size in @out_size. It is up to the
+ * caller to complete the access by calling the function again on the remaining
+ * range. Subsequent accesses are not guaranteed to succeed.
+ */
+u64 iommu_access(void *address_space, u64 addr, size_t size, size_t *out_size,
+		 int prot)
+{
+	struct iommu_ioas *ioas = address_space;
+	struct iommu_mapping *map;
+	struct rb_int_node *node;
+	u64 out_addr = 0;
+
+	mutex_lock(&ioas->mutex);
+	node = rb_int_search_single(&ioas->mappings, addr);
+	if (!node) {
+		pr_err("fault at IOVA %#llx %zu", addr, size);
+		errno = EFAULT;
+		goto out_unlock; /* Segv incomming */
+	}
+
+	map = container_of(node, struct iommu_mapping, iova_range);
+	if (prot & ~map->prot) {
+		pr_err("permission fault at IOVA %#llx", addr);
+		errno = EPERM;
+		goto out_unlock;
+	}
+
+	out_addr = map->phys + (addr - node->low);
+	*out_size = min_t(size_t, node->high - addr + 1, size);
+
+	pr_debug("access %llx %zu/%zu %x -> %#llx", addr, *out_size, size,
+		 prot, out_addr);
+out_unlock:
+	mutex_unlock(&ioas->mutex);
+
+	return out_addr;
+}
-- 
2.12.1
