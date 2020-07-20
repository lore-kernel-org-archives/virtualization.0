From: Eli Cohen <eli@mellanox.com>
Subject: [PATCH V2 vhost next 09/10] vdpa/mlx5: Add shared memory registration code
Date: Mon, 20 Jul 2020 10:14:15 +0300
Message-ID: <20200720071416.32112-10-eli@mellanox.com>
References: <20200720071416.32112-1-eli@mellanox.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200720071416.32112-1-eli@mellanox.com>
Sender: linux-kernel-owner@vger.kernel.org
To: mst@redhat.com, jasowang@redhat.com, virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Cc: shahafs@mellanox.com, saeedm@mellanox.com, parav@mellanox.com, Eli Cohen <eli@mellanox.com>
List-Id: virtualization@lists.linuxfoundation.org

Add code to support registering address space region for the device. The
virtio driver can run as either:
1. Guest virtio driver
2. Userspace virtio driver on the host
3. Kernel virtio driver on the host

In any case a memory key object is required to provide access to memory
for the device.

This code will be shared by network or block driver implementations.

Reviewed-by: Parav Pandit <parav@mellanox.com>
Signed-off-by: Eli Cohen <eli@mellanox.com>
---
V0 -> V2:
1. Improve changelog
2. Fix static checker warning

 drivers/vdpa/mlx5/Makefile         |   2 +-
 drivers/vdpa/mlx5/core/Makefile    |   1 -
 drivers/vdpa/mlx5/core/mlx5_vdpa.h |  34 +++
 drivers/vdpa/mlx5/core/mr.c        | 473 +++++++++++++++++++++++++++++
 drivers/vdpa/mlx5/core/resources.c |   3 +
 5 files changed, 511 insertions(+), 2 deletions(-)
 delete mode 100644 drivers/vdpa/mlx5/core/Makefile
 create mode 100644 drivers/vdpa/mlx5/core/mr.c

diff --git a/drivers/vdpa/mlx5/Makefile b/drivers/vdpa/mlx5/Makefile
index d552abb1d126..b347c62032ea 100644
--- a/drivers/vdpa/mlx5/Makefile
+++ b/drivers/vdpa/mlx5/Makefile
@@ -1 +1 @@
-obj-$(CONFIG_MLX5_VDPA) += core/resources.o
+obj-$(CONFIG_MLX5_VDPA) += core/resources.o core/mr.o
diff --git a/drivers/vdpa/mlx5/core/Makefile b/drivers/vdpa/mlx5/core/Makefile
deleted file mode 100644
index 7070f8c8680d..000000000000
--- a/drivers/vdpa/mlx5/core/Makefile
+++ /dev/null
@@ -1 +0,0 @@
-obj-y += resources.o
diff --git a/drivers/vdpa/mlx5/core/mlx5_vdpa.h b/drivers/vdpa/mlx5/core/mlx5_vdpa.h
index f3571c8b257e..5c92a576edae 100644
--- a/drivers/vdpa/mlx5/core/mlx5_vdpa.h
+++ b/drivers/vdpa/mlx5/core/mlx5_vdpa.h
@@ -7,6 +7,31 @@
 #include <linux/vdpa.h>
 #include <linux/mlx5/driver.h>
 
+struct mlx5_vdpa_direct_mr {
+	u64 start;
+	u64 end;
+	u32 perm;
+	struct mlx5_core_mkey mr;
+	struct sg_table sg_head;
+	int log_size;
+	int nsg;
+	struct list_head list;
+	u64 offset;
+};
+
+struct mlx5_vdpa_mr {
+	struct mlx5_core_mkey mkey;
+
+	/* list of direct MRs descendants of this indirect mr */
+	struct list_head head;
+	unsigned long num_directs;
+	unsigned long num_klms;
+	bool initialized;
+
+	/* serialize mkey creation and destruction */
+	struct mutex mkey_mtx;
+};
+
 struct mlx5_vdpa_resources {
 	u32 pdn;
 	struct mlx5_uars_page *uar;
@@ -26,6 +51,8 @@ struct mlx5_vdpa_dev {
 	u8 status;
 	u32 max_vqs;
 	u32 generation;
+
+	struct mlx5_vdpa_mr mr;
 };
 
 int mlx5_vdpa_alloc_pd(struct mlx5_vdpa_dev *dev, u32 *pdn, u16 uid);
@@ -41,6 +68,13 @@ int mlx5_vdpa_alloc_transport_domain(struct mlx5_vdpa_dev *mvdev, u32 *tdn);
 void mlx5_vdpa_dealloc_transport_domain(struct mlx5_vdpa_dev *mvdev, u32 tdn);
 int mlx5_vdpa_alloc_resources(struct mlx5_vdpa_dev *mvdev);
 void mlx5_vdpa_free_resources(struct mlx5_vdpa_dev *mvdev);
+int mlx5_vdpa_create_mkey(struct mlx5_vdpa_dev *mvdev, struct mlx5_core_mkey *mkey, u32 *in,
+			  int inlen);
+int mlx5_vdpa_destroy_mkey(struct mlx5_vdpa_dev *mvdev, struct mlx5_core_mkey *mkey);
+int mlx5_vdpa_handle_set_map(struct mlx5_vdpa_dev *mvdev, struct vhost_iotlb *iotlb,
+			     bool *change_map);
+int mlx5_vdpa_create_mr(struct mlx5_vdpa_dev *mvdev, struct vhost_iotlb *iotlb);
+void mlx5_vdpa_destroy_mr(struct mlx5_vdpa_dev *mvdev);
 
 #define mlx5_vdpa_warn(__dev, format, ...)                                                         \
 	dev_warn((__dev)->mdev->device, "%s:%d:(pid %d) warning: " format, __func__, __LINE__,     \
diff --git a/drivers/vdpa/mlx5/core/mr.c b/drivers/vdpa/mlx5/core/mr.c
new file mode 100644
index 000000000000..975aa45fd78b
--- /dev/null
+++ b/drivers/vdpa/mlx5/core/mr.c
@@ -0,0 +1,473 @@
+// SPDX-License-Identifier: GPL-2.0 OR Linux-OpenIB
+/* Copyright (c) 2020 Mellanox Technologies Ltd. */
+
+#include <linux/vdpa.h>
+#include <linux/gcd.h>
+#include <linux/string.h>
+#include <linux/mlx5/qp.h>
+#include "mlx5_vdpa.h"
+
+static int get_octo_len(u64 len, int page_shift)
+{
+	u64 page_size = 1ULL << page_shift;
+	int npages;
+
+	npages = ALIGN(len, page_size) >> page_shift;
+	return (npages + 1) / 2;
+}
+
+static void fill_sg(struct mlx5_vdpa_direct_mr *mr, void *in)
+{
+	struct scatterlist *sg;
+	__be64 *pas;
+	int i;
+
+	pas = MLX5_ADDR_OF(create_mkey_in, in, klm_pas_mtt);
+	for_each_sg(mr->sg_head.sgl, sg, mr->nsg, i)
+		(*pas) = cpu_to_be64(sg_dma_address(sg));
+}
+
+static void mlx5_set_access_mode(void *mkc, int mode)
+{
+	MLX5_SET(mkc, mkc, access_mode_1_0, mode & 0x3);
+	MLX5_SET(mkc, mkc, access_mode_4_2, mode >> 2);
+}
+
+static void populate_mtts(struct mlx5_vdpa_direct_mr *mr, __be64 *mtt)
+{
+	struct scatterlist *sg;
+	int i;
+
+	for_each_sg(mr->sg_head.sgl, sg, mr->nsg, i)
+		mtt[i] = cpu_to_be64(sg_dma_address(sg));
+}
+
+static int create_direct_mr(struct mlx5_vdpa_dev *mvdev, struct mlx5_vdpa_direct_mr *mr)
+{
+	int inlen;
+	void *mkc;
+	void *in;
+	int err;
+
+	inlen = MLX5_ST_SZ_BYTES(create_mkey_in) + roundup(MLX5_ST_SZ_BYTES(mtt) * mr->nsg, 16);
+	in = kvzalloc(inlen, GFP_KERNEL);
+	if (!in)
+		return -ENOMEM;
+
+	MLX5_SET(create_mkey_in, in, uid, mvdev->res.uid);
+	fill_sg(mr, in);
+	mkc = MLX5_ADDR_OF(create_mkey_in, in, memory_key_mkey_entry);
+	MLX5_SET(mkc, mkc, lw, !!(mr->perm & VHOST_MAP_WO));
+	MLX5_SET(mkc, mkc, lr, !!(mr->perm & VHOST_MAP_RO));
+	mlx5_set_access_mode(mkc, MLX5_MKC_ACCESS_MODE_MTT);
+	MLX5_SET(mkc, mkc, qpn, 0xffffff);
+	MLX5_SET(mkc, mkc, pd, mvdev->res.pdn);
+	MLX5_SET64(mkc, mkc, start_addr, mr->offset);
+	MLX5_SET64(mkc, mkc, len, mr->end - mr->start);
+	MLX5_SET(mkc, mkc, log_page_size, mr->log_size);
+	MLX5_SET(mkc, mkc, translations_octword_size,
+		 get_octo_len(mr->end - mr->start, mr->log_size));
+	MLX5_SET(create_mkey_in, in, translations_octword_actual_size,
+		 get_octo_len(mr->end - mr->start, mr->log_size));
+	populate_mtts(mr, MLX5_ADDR_OF(create_mkey_in, in, klm_pas_mtt));
+	err = mlx5_vdpa_create_mkey(mvdev, &mr->mr, in, inlen);
+	kvfree(in);
+	if (err) {
+		mlx5_vdpa_warn(mvdev, "Failed to create direct MR\n");
+		return err;
+	}
+
+	return 0;
+}
+
+static void destroy_direct_mr(struct mlx5_vdpa_dev *mvdev, struct mlx5_vdpa_direct_mr *mr)
+{
+	mlx5_vdpa_destroy_mkey(mvdev, &mr->mr);
+}
+
+static u64 map_start(struct vhost_iotlb_map *map, struct mlx5_vdpa_direct_mr *mr)
+{
+	return max_t(u64, map->start, mr->start);
+}
+
+static u64 map_end(struct vhost_iotlb_map *map, struct mlx5_vdpa_direct_mr *mr)
+{
+	return min_t(u64, map->last + 1, mr->end);
+}
+
+static u64 maplen(struct vhost_iotlb_map *map, struct mlx5_vdpa_direct_mr *mr)
+{
+	return map_end(map, mr) - map_start(map, mr);
+}
+
+#define MLX5_VDPA_INVALID_START_ADDR ((u64)-1)
+#define MLX5_VDPA_INVALID_LEN ((u64)-1)
+
+static u64 indir_start_addr(struct mlx5_vdpa_mr *mkey)
+{
+	struct mlx5_vdpa_direct_mr *s;
+
+	s = list_first_entry_or_null(&mkey->head, struct mlx5_vdpa_direct_mr, list);
+	if (!s)
+		return MLX5_VDPA_INVALID_START_ADDR;
+
+	return s->start;
+}
+
+static u64 indir_len(struct mlx5_vdpa_mr *mkey)
+{
+	struct mlx5_vdpa_direct_mr *s;
+	struct mlx5_vdpa_direct_mr *e;
+
+	s = list_first_entry_or_null(&mkey->head, struct mlx5_vdpa_direct_mr, list);
+	if (!s)
+		return MLX5_VDPA_INVALID_LEN;
+
+	e = list_last_entry(&mkey->head, struct mlx5_vdpa_direct_mr, list);
+
+	return e->end - s->start;
+}
+
+#define MAX_KLM_SIZE 0x40000000
+
+static u32 klm_bcount(u64 size)
+{
+	return (u32)size;
+}
+
+static void fill_indir(struct mlx5_vdpa_dev *mvdev, struct mlx5_vdpa_mr *mkey, void *in)
+{
+	struct mlx5_vdpa_direct_mr *dmr;
+	struct mlx5_klm *klmarr;
+	struct mlx5_klm *klm;
+	bool first = true;
+	u64 preve;
+	int i;
+
+	klmarr = MLX5_ADDR_OF(create_mkey_in, in, klm_pas_mtt);
+	i = 0;
+	list_for_each_entry(dmr, &mkey->head, list) {
+again:
+		klm = &klmarr[i++];
+		if (first) {
+			preve = dmr->start;
+			first = false;
+		}
+
+		if (preve == dmr->start) {
+			klm->key = cpu_to_be32(dmr->mr.key);
+			klm->bcount = cpu_to_be32(klm_bcount(dmr->end - dmr->start));
+			preve = dmr->end;
+		} else {
+			klm->key = cpu_to_be32(mvdev->res.null_mkey);
+			klm->bcount = cpu_to_be32(klm_bcount(dmr->start - preve));
+			preve = dmr->start;
+			goto again;
+		}
+	}
+}
+
+static int klm_byte_size(int nklms)
+{
+	return 16 * ALIGN(nklms, 4);
+}
+
+static int create_indirect_key(struct mlx5_vdpa_dev *mvdev, struct mlx5_vdpa_mr *mr)
+{
+	int inlen;
+	void *mkc;
+	void *in;
+	int err;
+	u64 start;
+	u64 len;
+
+	start = indir_start_addr(mr);
+	len = indir_len(mr);
+	if (start == MLX5_VDPA_INVALID_START_ADDR || len == MLX5_VDPA_INVALID_LEN)
+		return -EINVAL;
+
+	inlen = MLX5_ST_SZ_BYTES(create_mkey_in) + klm_byte_size(mr->num_klms);
+	in = kzalloc(inlen, GFP_KERNEL);
+	if (!in)
+		return -ENOMEM;
+
+	MLX5_SET(create_mkey_in, in, uid, mvdev->res.uid);
+	mkc = MLX5_ADDR_OF(create_mkey_in, in, memory_key_mkey_entry);
+	MLX5_SET(mkc, mkc, lw, 1);
+	MLX5_SET(mkc, mkc, lr, 1);
+	mlx5_set_access_mode(mkc, MLX5_MKC_ACCESS_MODE_KLMS);
+	MLX5_SET(mkc, mkc, qpn, 0xffffff);
+	MLX5_SET(mkc, mkc, pd, mvdev->res.pdn);
+	MLX5_SET64(mkc, mkc, start_addr, start);
+	MLX5_SET64(mkc, mkc, len, len);
+	MLX5_SET(mkc, mkc, translations_octword_size, klm_byte_size(mr->num_klms) / 16);
+	MLX5_SET(create_mkey_in, in, translations_octword_actual_size, mr->num_klms);
+	fill_indir(mvdev, mr, in);
+	err = mlx5_vdpa_create_mkey(mvdev, &mr->mkey, in, inlen);
+	kfree(in);
+	return err;
+}
+
+static void destroy_indirect_key(struct mlx5_vdpa_dev *mvdev, struct mlx5_vdpa_mr *mkey)
+{
+	mlx5_vdpa_destroy_mkey(mvdev, &mkey->mkey);
+}
+
+static int map_direct_mr(struct mlx5_vdpa_dev *mvdev, struct mlx5_vdpa_direct_mr *mr,
+			 struct vhost_iotlb *iotlb)
+{
+	struct vhost_iotlb_map *map;
+	unsigned long lgcd = 0;
+	int log_entity_size;
+	unsigned long size;
+	u64 start = 0;
+	int err;
+	struct page *pg;
+	unsigned int nsg;
+	int sglen;
+	u64 pa;
+	u64 paend;
+	struct scatterlist *sg;
+	struct device *dma = mvdev->mdev->device;
+	int ret;
+
+	for (map = vhost_iotlb_itree_first(iotlb, mr->start, mr->end - 1);
+	     map; map = vhost_iotlb_itree_next(map, start, mr->end - 1)) {
+		size = maplen(map, mr);
+		lgcd = gcd(lgcd, size);
+		start += size;
+	}
+	log_entity_size = ilog2(lgcd);
+
+	sglen = 1 << log_entity_size;
+	nsg = DIV_ROUND_UP(mr->end - mr->start, sglen);
+
+	err = sg_alloc_table(&mr->sg_head, nsg, GFP_KERNEL);
+	if (err)
+		return err;
+
+	sg = mr->sg_head.sgl;
+	for (map = vhost_iotlb_itree_first(iotlb, mr->start, mr->end - 1);
+	     map; map = vhost_iotlb_itree_next(map, mr->start, mr->end - 1)) {
+		paend = map->addr + maplen(map, mr);
+		for (pa = map->addr; pa < paend; pa += sglen) {
+			pg = pfn_to_page(__phys_to_pfn(pa));
+			if (!sg) {
+				mlx5_vdpa_warn(mvdev, "sg null. start 0x%llx, end 0x%llx\n",
+					       map->start, map->last + 1);
+				err = -ENOMEM;
+				goto err_map;
+			}
+			sg_set_page(sg, pg, sglen, 0);
+			sg = sg_next(sg);
+			if (!sg)
+				goto done;
+		}
+	}
+done:
+	mr->log_size = log_entity_size;
+	mr->nsg = nsg;
+	ret = dma_map_sg_attrs(dma, mr->sg_head.sgl, mr->nsg, DMA_BIDIRECTIONAL, 0);
+	if (!ret)
+		goto err_map;
+
+	err = create_direct_mr(mvdev, mr);
+	if (err)
+		goto err_direct;
+
+	return 0;
+
+err_direct:
+	dma_unmap_sg_attrs(dma, mr->sg_head.sgl, mr->nsg, DMA_BIDIRECTIONAL, 0);
+err_map:
+	sg_free_table(&mr->sg_head);
+	return err;
+}
+
+static void unmap_direct_mr(struct mlx5_vdpa_dev *mvdev, struct mlx5_vdpa_direct_mr *mr)
+{
+	struct device *dma = mvdev->mdev->device;
+
+	destroy_direct_mr(mvdev, mr);
+	dma_unmap_sg_attrs(dma, mr->sg_head.sgl, mr->nsg, DMA_BIDIRECTIONAL, 0);
+	sg_free_table(&mr->sg_head);
+}
+
+static int add_direct_chain(struct mlx5_vdpa_dev *mvdev, u64 start, u64 size, u8 perm,
+			    struct vhost_iotlb *iotlb)
+{
+	struct mlx5_vdpa_mr *mr = &mvdev->mr;
+	struct mlx5_vdpa_direct_mr *dmr;
+	struct mlx5_vdpa_direct_mr *n;
+	LIST_HEAD(tmp);
+	u64 st;
+	u64 sz;
+	int err;
+	int i = 0;
+
+	st = start;
+	while (size) {
+		sz = (u32)min_t(u64, MAX_KLM_SIZE, size);
+		dmr = kzalloc(sizeof(*dmr), GFP_KERNEL);
+		if (!dmr)
+			goto err_alloc;
+
+		dmr->start = st;
+		dmr->end = st + sz;
+		dmr->perm = perm;
+		err = map_direct_mr(mvdev, dmr, iotlb);
+		if (err) {
+			kfree(dmr);
+			goto err_alloc;
+		}
+
+		list_add_tail(&dmr->list, &tmp);
+		size -= sz;
+		mr->num_directs++;
+		mr->num_klms++;
+		st += sz;
+		i++;
+	}
+	list_splice_tail(&tmp, &mr->head);
+	return 0;
+
+err_alloc:
+	list_for_each_entry_safe(dmr, n, &mr->head, list) {
+		list_del_init(&dmr->list);
+		unmap_direct_mr(mvdev, dmr);
+		kfree(dmr);
+	}
+	return err;
+}
+
+/* The iotlb pointer contains a list of maps. Go over the maps, possibly
+ * merging mergeable maps, and create direct memory keys that provide the
+ * device access to memory. The direct mkeys are then referred to by the
+ * indirect memory key that provides access to the enitre address space given
+ * by iotlb.
+ */
+static int _mlx5_vdpa_create_mr(struct mlx5_vdpa_dev *mvdev, struct vhost_iotlb *iotlb)
+{
+	struct mlx5_vdpa_mr *mr = &mvdev->mr;
+	struct mlx5_vdpa_direct_mr *dmr;
+	struct mlx5_vdpa_direct_mr *n;
+	struct vhost_iotlb_map *map;
+	u32 pperm = U16_MAX;
+	u64 last = U64_MAX;
+	u64 ps = U64_MAX;
+	u64 pe = U64_MAX;
+	u64 start = 0;
+	int err = 0;
+	int nnuls;
+
+	if (mr->initialized)
+		return 0;
+
+	INIT_LIST_HEAD(&mr->head);
+	for (map = vhost_iotlb_itree_first(iotlb, start, last); map;
+	     map = vhost_iotlb_itree_next(map, start, last)) {
+		start = map->start;
+		if (pe == map->start && pperm == map->perm) {
+			pe = map->last + 1;
+		} else {
+			if (ps != U64_MAX) {
+				if (pe < map->start) {
+					/* We have a hole in the map. Check how
+					 * many null keys are required to fill it.
+					 */
+					nnuls = DIV_ROUND_UP(map->start - pe, MAX_KLM_SIZE);
+					mr->num_klms += nnuls;
+				}
+				err = add_direct_chain(mvdev, ps, pe - ps, pperm, iotlb);
+				if (err)
+					goto err_chain;
+			}
+			ps = map->start;
+			pe = map->last + 1;
+			pperm = map->perm;
+		}
+	}
+	err = add_direct_chain(mvdev, ps, pe - ps, pperm, iotlb);
+	if (err)
+		goto err_chain;
+
+	/* Create the memory key that defines the guests's address space. This
+	 * memory key refers to the direct keys that contain the MTT
+	 * translations
+	 */
+	err = create_indirect_key(mvdev, mr);
+	if (err)
+		goto err_chain;
+
+	mr->initialized = true;
+	return 0;
+
+err_chain:
+	list_for_each_entry_safe_reverse(dmr, n, &mr->head, list) {
+		list_del_init(&dmr->list);
+		unmap_direct_mr(mvdev, dmr);
+		kfree(dmr);
+	}
+	return err;
+}
+
+int mlx5_vdpa_create_mr(struct mlx5_vdpa_dev *mvdev, struct vhost_iotlb *iotlb)
+{
+	struct mlx5_vdpa_mr *mr = &mvdev->mr;
+	int err;
+
+	mutex_lock(&mr->mkey_mtx);
+	err = _mlx5_vdpa_create_mr(mvdev, iotlb);
+	mutex_unlock(&mr->mkey_mtx);
+	return err;
+}
+
+void mlx5_vdpa_destroy_mr(struct mlx5_vdpa_dev *mvdev)
+{
+	struct mlx5_vdpa_mr *mr = &mvdev->mr;
+	struct mlx5_vdpa_direct_mr *dmr;
+	struct mlx5_vdpa_direct_mr *n;
+
+	mutex_lock(&mr->mkey_mtx);
+	if (!mr->initialized)
+		goto out;
+
+	destroy_indirect_key(mvdev, mr);
+	list_for_each_entry_safe_reverse(dmr, n, &mr->head, list) {
+		list_del_init(&dmr->list);
+		unmap_direct_mr(mvdev, dmr);
+		kfree(dmr);
+	}
+	memset(mr, 0, sizeof(*mr));
+	mr->initialized = false;
+out:
+	mutex_unlock(&mr->mkey_mtx);
+}
+
+static bool map_empty(struct vhost_iotlb *iotlb)
+{
+	return !vhost_iotlb_itree_first(iotlb, 0, U64_MAX);
+}
+
+int mlx5_vdpa_handle_set_map(struct mlx5_vdpa_dev *mvdev, struct vhost_iotlb *iotlb,
+			     bool *change_map)
+{
+	struct mlx5_vdpa_mr *mr = &mvdev->mr;
+	int err;
+
+	*change_map = false;
+	if (map_empty(iotlb)) {
+		mlx5_vdpa_destroy_mr(mvdev);
+		return 0;
+	}
+	mutex_lock(&mr->mkey_mtx);
+	if (mr->initialized) {
+		mlx5_vdpa_info(mvdev, "memory map update\n");
+		*change_map = true;
+	}
+	if (!*change_map)
+		err = _mlx5_vdpa_create_mr(mvdev, iotlb);
+	mutex_unlock(&mr->mkey_mtx);
+
+	return err;
+}
diff --git a/drivers/vdpa/mlx5/core/resources.c b/drivers/vdpa/mlx5/core/resources.c
index 6c6552b7e9b5..96e6421c5d1c 100644
--- a/drivers/vdpa/mlx5/core/resources.c
+++ b/drivers/vdpa/mlx5/core/resources.c
@@ -227,6 +227,7 @@ int mlx5_vdpa_alloc_resources(struct mlx5_vdpa_dev *mvdev)
 		mlx5_vdpa_warn(mvdev, "resources already allocated\n");
 		return -EINVAL;
 	}
+	mutex_init(&mvdev->mr.mkey_mtx);
 	res->uar = mlx5_get_uars_page(mdev);
 	if (IS_ERR(res->uar)) {
 		err = PTR_ERR(res->uar);
@@ -262,6 +263,7 @@ int mlx5_vdpa_alloc_resources(struct mlx5_vdpa_dev *mvdev)
 err_uctx:
 	mlx5_put_uars_page(mdev, res->uar);
 err_uars:
+	mutex_destroy(&mvdev->mr.mkey_mtx);
 	return err;
 }
 
@@ -277,5 +279,6 @@ void mlx5_vdpa_free_resources(struct mlx5_vdpa_dev *mvdev)
 	dealloc_pd(mvdev, res->pdn, res->uid);
 	destroy_uctx(mvdev, res->uid);
 	mlx5_put_uars_page(mvdev->mdev, res->uar);
+	mutex_destroy(&mvdev->mr.mkey_mtx);
 	res->valid = false;
 }
-- 
2.26.0
