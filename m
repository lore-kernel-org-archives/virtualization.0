Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010062.outbound.protection.outlook.com [52.101.193.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 094AB4582CC
	for <virtualization@lists.linux.dev>; Thu, 24 Sep 2026 09:56:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790243802; cv=fail; b=guzvHrwez7/Kd9tFNFpQA2HXkhaCOaN5GynMF7iFosTBBt0/wyALY3UFIi+WWkCGIk9p4/dZ+BHRUEZMM0YatW053twsrvhozjkKtkIXNXrlPGoZ5a92716bvnWMs9GlmhXc/vEDGH7fUl6+S+fez7lGnCpKdc96iBiM5gyE3oA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790243802; c=relaxed/simple;
	bh=hamllfA1YIhjdue/JHFo+Xfevyk8zFuNKIRg8pDZCT4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TH8Nv6DGhk/4dK2BVY1XRe5VdTNGr3caGE66cQob+qR0PT8Tua1L9iYsx6LggpJQBHxNgQCx48Z0S+XRvAZATfudDNvyGf8heriUlb0LnArEavf10b/SOHTV+MthnpYOeGc+j/+YOXY1nGCGQI/YUirjQXWH2anXRWvwbpiGODM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=YIOzqhjI; arc=fail smtp.client-ip=52.101.193.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="YIOzqhjI"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pkYcnrodL0nceCq37iOGRKtbcB8HtqhSJvP77ynw2YpL38iesOcxFAfpku5sUNI6bH2o5AlCdXczmWkmb0NWih9F3lFEOHb5MEkVUTxX/OMjN1JTJn9rsErwGANjomA0OJChc1cmcQWLEkQFZRJXrdHPFRLA56gS/MwcVRkrzESIBzs6WPG3ALZsIhIMyQRR9sk1jkagf2X8m80wcgsVarK0Jx+0GyNlBcoCZrqjmRinen5GX2GEEuMQW6Amwq+kn1AKx1wD7OsEi3Qp6DPtUVmWuD4lPjY+EYvq21HZu8aCABpFHEHphDqkkI5p7ik7LtSSH06VrShCI5G24f4Pcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZiPFaNpVhLGI3b1AKIDtO6WaGTQPRSbnvLMOn/QRO7E=;
 b=jJJwyN5bAcdwMvtRrBPAcWiCClYYRYVLoPC3BHzRVq/eQJI500FeE/viCaT0HbrmwZ2LbIxPVJJlIURqUhE99NgJ/WjRtVZzwYZHLKXyl3BEikQc4uS0iul5B/NPQJvdhguJK5HUbMPPfeM0zIgUQPsjsjb0lmQzJOwAKqbuDog0GsdoRkaMhtFcnTfNJGiQeHqtrwp5Om5iI5nJ1GC7uIEyKncuz/jz9ZUg/EQPH2gbsHhqV+NJda8DFhFq9vUJhbWBAn4qxWYzR+sm1W2shJehj1ga/Ki0yixyLYN8l713piqnhAjIrcITxi3kbmhaaWTVmdv0ymmGvWPqjv3KwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=collabora.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZiPFaNpVhLGI3b1AKIDtO6WaGTQPRSbnvLMOn/QRO7E=;
 b=YIOzqhjIxlnwD1WemQ+agYkwJSJC4JUfSjxE5ZQQkGzlYw6gnaBeuBPFQ8HdrdZQsl4a7EHF30CggTdEsskCtB1I2DQ13HDZNbJP3b7ebqnGjRZZnbUDTsNZLH1loC427wyU3WODPBPAooeuIb9A1XwuavQvMpAm3flMEVyPKNU=
Received: from CH0P223CA0005.NAMP223.PROD.OUTLOOK.COM (2603:10b6:610:116::16)
 by CY5PR12MB6346.namprd12.prod.outlook.com (2603:10b6:930:21::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.18; Thu, 24 Sep
 2026 09:56:21 +0000
Received: from CH1PEPF0000AD81.namprd04.prod.outlook.com
 (2603:10b6:610:116:cafe::6d) by CH0P223CA0005.outlook.office365.com
 (2603:10b6:610:116::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.451.18 via Frontend Transport; Thu,
 24 Sep 2026 09:56:21 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH1PEPF0000AD81.mail.protection.outlook.com (10.167.244.89) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.451.8 via Frontend Transport; Thu, 24 Sep 2026 09:56:20 +0000
Received: from honglei-remote.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Thu, 24 Sep
 2026 04:56:17 -0500
From: Honglei Huang <honghuan@amd.com>
To: <dmitry.osipenko@collabora.com>, <odaki@rsg.ci.i.u-tokyo.ac.jp>,
	<airlied@redhat.com>, <kraxel@redhat.com>
CC: <gurchetansingh@chromium.org>, <olvaffe@gmail.com>, <Ray.Huang@amd.com>,
	<dri-devel@lists.freedesktop.org>, <virtualization@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, Honglei Huang <honghuan@amd.com>
Subject: [RFC PATCH v9 3/4] drm/virtio: implement userptr resource support
Date: Thu, 24 Sep 2026 17:55:55 +0800
Message-ID: <20260924095556.1326164-4-honghuan@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260924095556.1326164-1-honghuan@amd.com>
References: <20260924095556.1326164-1-honghuan@amd.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD81:EE_|CY5PR12MB6346:EE_
X-MS-Office365-Filtering-Correlation-Id: 9b097448-1d66-491f-867e-08df1a221607
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|1800799024|82310400026|376014|23010399003|10067099003|5023799004|11063799006|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	KocPP0YOIG7GPumT33cjM5HPg1U9GYHaqnT3Xfo9zq92rOnb611XSVG20B2/FTK2LoEZPvTzBxovbDfYT4KgGM8VwvZuUFHhirXDVKVSnHAujj/xiGrCYmu/34ne+7ew5E7w/tdNA1UhDrbmEYEqI+s2chGLQs1p3q3OH5Y781RY+bDBesqaMA9uCEwwvk23NnofhVEwYs3dOe2u7c0o84WxMd2p+yr+8rgD4rWCO2LlbO/5e9WDZ0gpXTSng+gpgMyLcKC1Y1aOA5vcnZSbF/Y+hMngjyDC+4vWd6lXSCSM9sQ3cxk0M1FO125yyKgO0OI5/sMan20qt7FRG5tgesvGh7I9wsj59xfrmClEiCjmJDo438EfjT9Q3//cLuHEqStWfhgBPdZa51S1J0y4C96KOgdwrsKub+Y9RJvE/IT/41+8Bay2fIdvxOcWbC6Jbsix+Jwuh/Mo54jX/ReY6oUhhL2T7YciQfcyyK0exlDwf9beolj2NJXkSoi7jl1MDEtMhEyno2HIbiFqGFGGyiMP2RCYwKrtFTb/bBRNNw6PYHGKtac+L9MplGwkUw9hJ2n5/BDrsNoMdYsdq72az1Xg2DtazjdRZXMyh/rBW2IIlnlE6nG/gGF0JIR0mlsJRe5MQ1YSrcn/GKmtqsvvPvcFwU9jtQKqSt/psUESuOCjQu9fyqqOG4PK1/jT4aQzweI6a/CqDL6JzuXJwsFtbQ==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(1800799024)(82310400026)(376014)(23010399003)(10067099003)(5023799004)(11063799006)(56012099006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	qzX7tVbWNOsP88hkCGJohj4dOpMEToqa1CdRkbqpHBV0aIJg0KyVyHRHuTlJKrTo4QpfP4o69HpP6E7YuCJzE3HhWuQob+v2M/evmfyMnN2uy9N7NwzHLb0pitthu8Rx885Kvoz8Mm757+v1nlxjSxjDBXjPVVvML2ZpzJG+zqOzqfpuKeLFIie+ETSUo5CWmzGj12BNBBcKby5/YbX2rF026LM9tjXvIk0BDx2CSN3lEOFhYSHcCIFV1UpTGUzpkiqrIJ5mcq+sLaLq/7JJmJXym8yQpYyvM252fASnggg1/Rlc5B+HDDN+vtWcfwBw1hHX3fDkbjZkxAo902XoGmkCKnQ380dHf3wA195rj2ejd1QWK4gALsXkJeEu9UHklKO+VgotFihjrvhLyMrDV5EHT+bfNvDOu3cIkuUWbbfqU3Yl6vziZZc2TljdNouG
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2026 09:56:20.9854
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b097448-1d66-491f-867e-08df1a221607
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000AD81.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6346

Add userptr blob objects so the guest kernel can pin an existing
userspace mapping and advertise it as CREATE_BLOB backing entries.

- New virtio_gpu_object_userptr type for userptr resources
- Pin pages with pin_user_pages_fast() and FOLL_LONGTERM
- Omit FOLL_WRITE when VIRTGPU_BLOB_FLAG_USE_READONLY is set
- Charge FOLL_LONGTERM pins against RLIMIT_MEMLOCK
- DMA-map the scatterlist only when virtio_gpu_use_dma_api() is
  required; use DMA_TO_DEVICE for USE_READONLY blobs
- Mark writable pages dirty when unpinning
- Keep pages pinned until RESOURCE_UNREF is queued; drop them from
  cleanup_object() on the unref response or on create failure
- Clear userptr->pages on pin failure to avoid double-free on cleanup
- Reject unaligned or overflowing userptr ranges at create time
- Disallow PRIME export of userptr objects
- Save CREATE_BLOB params and restore userptr resources after
  hibernation without using the shmem restore path

The hibernation restore path maps with the same attrs and direction
used at create time, as documented next to the call. Like shmem
blobs, the DMA API can still bounce through a buffer there. This
design only avoids a second guest side shmem allocation and memcpy,
nothing more.

Signed-off-by: Honglei Huang <honghuan@amd.com>
---
 drivers/gpu/drm/virtio/Makefile          |   3 +-
 drivers/gpu/drm/virtio/virtgpu_drv.h     |  41 +++
 drivers/gpu/drm/virtio/virtgpu_object.c  |  22 ++
 drivers/gpu/drm/virtio/virtgpu_userptr.c | 348 +++++++++++++++++++++++
 4 files changed, 413 insertions(+), 1 deletion(-)
 create mode 100644 drivers/gpu/drm/virtio/virtgpu_userptr.c

diff --git a/drivers/gpu/drm/virtio/Makefile b/drivers/gpu/drm/virtio/Makefile
index d2e1788a82..fe7332a621 100644
--- a/drivers/gpu/drm/virtio/Makefile
+++ b/drivers/gpu/drm/virtio/Makefile
@@ -6,6 +6,7 @@
 virtio-gpu-y := virtgpu_drv.o virtgpu_kms.o virtgpu_gem.o virtgpu_vram.o \
 	virtgpu_display.o virtgpu_vq.o \
 	virtgpu_fence.o virtgpu_object.o virtgpu_debugfs.o virtgpu_plane.o \
-	virtgpu_ioctl.o virtgpu_prime.o virtgpu_trace_points.o virtgpu_submit.o
+	virtgpu_ioctl.o virtgpu_prime.o virtgpu_trace_points.o virtgpu_submit.o \
+	virtgpu_userptr.o
 
 obj-$(CONFIG_DRM_VIRTIO_GPU) += virtio-gpu.o
diff --git a/drivers/gpu/drm/virtio/virtgpu_drv.h b/drivers/gpu/drm/virtio/virtgpu_drv.h
index 9df4c71173..b58e5afe8f 100644
--- a/drivers/gpu/drm/virtio/virtgpu_drv.h
+++ b/drivers/gpu/drm/virtio/virtgpu_drv.h
@@ -105,6 +105,7 @@ struct virtio_gpu_object_params {
 	uint32_t blob_flags;
 	uint64_t blob_id;
 	uint32_t blob_hints;
+	uint64_t userptr;
 };
 
 struct virtio_gpu_object {
@@ -138,12 +139,41 @@ struct virtio_gpu_object_vram {
 	struct drm_mm_node vram_node;
 };
 
+struct virtio_gpu_object_userptr;
+
+struct virtio_gpu_object_userptr_ops {
+	int (*get_pages)(struct virtio_gpu_object_userptr *userptr);
+	void (*put_pages)(struct virtio_gpu_object_userptr *userptr);
+};
+
+struct virtio_gpu_object_userptr {
+	struct virtio_gpu_object base;
+	const struct virtio_gpu_object_userptr_ops *ops;
+	struct mutex lock;
+
+	uint64_t start;
+	uint32_t npages;
+	uint32_t bo_handle;
+	uint32_t flags;
+
+	struct virtio_gpu_device *vgdev;
+	struct drm_file *file;
+	struct page **pages;
+	struct sg_table *sgt;
+	bool dma_mapped;
+	enum dma_data_direction dma_dir;
+	struct mm_struct *mm;
+};
+
 #define to_virtio_gpu_shmem(virtio_gpu_object) \
 	container_of((virtio_gpu_object), struct virtio_gpu_object_shmem, base)
 
 #define to_virtio_gpu_vram(virtio_gpu_object) \
 	container_of((virtio_gpu_object), struct virtio_gpu_object_vram, base)
 
+#define to_virtio_gpu_userptr(virtio_gpu_object) \
+	container_of((virtio_gpu_object), struct virtio_gpu_object_userptr, base)
+
 struct virtio_gpu_object_array {
 	struct ww_acquire_ctx ticket;
 	struct list_head next;
@@ -284,6 +314,7 @@ struct virtio_gpu_device {
 	bool has_host_visible;
 	bool has_context_init;
 	bool has_blob_alignment;
+	bool has_blob_readonly;
 	bool hibernated;
 	struct virtio_shm_region host_visible_region;
 	struct drm_mm host_visible_mm;
@@ -562,4 +593,14 @@ void virtio_gpu_vram_map_deferred(struct virtio_gpu_object_vram *vram);
 int virtio_gpu_execbuffer_ioctl(struct drm_device *dev, void *data,
 				struct drm_file *file);
 
+/* virtgpu_userptr.c */
+int virtio_gpu_userptr_create(struct virtio_gpu_device *vgdev,
+			      struct drm_file *file,
+			      struct virtio_gpu_object_params *params,
+			      struct virtio_gpu_object **bo_ptr);
+bool virtio_gpu_is_userptr(struct virtio_gpu_object *bo);
+int virtio_gpu_userptr_restore(struct virtio_gpu_device *vgdev,
+			       struct virtio_gpu_object *bo,
+			       struct virtio_gpu_mem_entry **ents,
+			       unsigned int *nents);
 #endif
diff --git a/drivers/gpu/drm/virtio/virtgpu_object.c b/drivers/gpu/drm/virtio/virtgpu_object.c
index 49899485be..ab21494b1c 100644
--- a/drivers/gpu/drm/virtio/virtgpu_object.c
+++ b/drivers/gpu/drm/virtio/virtgpu_object.c
@@ -91,6 +91,16 @@ void virtio_gpu_cleanup_object(struct virtio_gpu_object *bo)
 		drm_gem_free_mmap_offset(&vram->base.base.base);
 		drm_gem_object_release(&vram->base.base.base);
 		kfree(vram);
+	} else if (virtio_gpu_is_userptr(bo)) {
+		struct virtio_gpu_object_userptr *userptr =
+			to_virtio_gpu_userptr(bo);
+
+		mutex_lock(&userptr->lock);
+		userptr->ops->put_pages(userptr);
+		mutex_unlock(&userptr->lock);
+		mutex_destroy(&userptr->lock);
+		drm_gem_object_release(&userptr->base.base.base);
+		kfree(userptr);
 	} else {
 		drm_gem_object_release(&bo->base.base);
 		kfree(bo);
@@ -316,6 +326,18 @@ int virtio_gpu_object_restore_all(struct virtio_gpu_device *vgdev)
 			continue;
 		}
 
+		if (virtio_gpu_is_userptr(bo)) {
+			ret = virtio_gpu_userptr_restore(vgdev, bo, &ents,
+							 &nents);
+			if (ret)
+				break;
+
+			virtio_gpu_cmd_resource_create_blob(vgdev, bo,
+							    &bo->params,
+							    ents, nents);
+			continue;
+		}
+
 		if (bo->params.blob || bo->attached) {
 			ret = virtio_gpu_object_shmem_init(vgdev, bo, &ents,
 							   &nents);
diff --git a/drivers/gpu/drm/virtio/virtgpu_userptr.c b/drivers/gpu/drm/virtio/virtgpu_userptr.c
new file mode 100644
index 0000000000..4fb367d0d6
--- /dev/null
+++ b/drivers/gpu/drm/virtio/virtgpu_userptr.c
@@ -0,0 +1,348 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <linux/dma-mapping.h>
+#include <linux/limits.h>
+#include <linux/mm.h>
+#include <linux/overflow.h>
+#include <linux/pid.h>
+#include <linux/sched/mm.h>
+#include <linux/sched/signal.h>
+#include <linux/vmalloc.h>
+
+#include "virtgpu_drv.h"
+#include <drm/drm_gem.h>
+
+static void virtio_gpu_userptr_free(struct drm_gem_object *obj)
+{
+	struct virtio_gpu_object *bo = gem_to_virtio_gpu_obj(obj);
+	struct virtio_gpu_device *vgdev = obj->dev->dev_private;
+
+	/*
+	 * Pages stay pinned until RESOURCE_UNREF finishes. Its callback
+	 * calls virtio_gpu_cleanup_object to drop them.
+	 */
+	if (bo->created) {
+		virtio_gpu_remove_from_restore_list(bo);
+		virtio_gpu_cmd_unref_resource(vgdev, bo, false);
+		virtio_gpu_notify(vgdev);
+		return;
+	}
+
+	virtio_gpu_cleanup_object(bo);
+}
+
+static struct dma_buf *
+virtio_gpu_userptr_prime_export(struct drm_gem_object *obj, int flags)
+{
+	return ERR_PTR(-EINVAL);
+}
+
+static const struct drm_gem_object_funcs virtio_gpu_userptr_funcs = {
+	.open = virtio_gpu_gem_object_open,
+	.close = virtio_gpu_gem_object_close,
+	.free = virtio_gpu_userptr_free,
+	.export = virtio_gpu_userptr_prime_export,
+};
+
+bool virtio_gpu_is_userptr(struct virtio_gpu_object *bo)
+{
+	return bo->base.base.funcs == &virtio_gpu_userptr_funcs;
+}
+
+static int
+virtio_gpu_userptr_get_pages(struct virtio_gpu_object_userptr *userptr)
+{
+	unsigned int flag = FOLL_LONGTERM;
+	unsigned int num_pages, pinned = 0;
+	int ret = 0;
+
+	if (userptr->pages)
+		return 0;
+
+	userptr->pages = kvmalloc_array(userptr->npages, sizeof(struct page *),
+					GFP_KERNEL);
+	if (!userptr->pages)
+		return -ENOMEM;
+
+	if (!(userptr->flags & VIRTGPU_BLOB_FLAG_USE_READONLY))
+		flag |= FOLL_WRITE;
+
+	do {
+		num_pages = userptr->npages - pinned;
+
+		ret = pin_user_pages_fast(userptr->start + pinned * PAGE_SIZE,
+					  num_pages, flag,
+					  userptr->pages + pinned);
+
+		if (ret < 0) {
+			if (pinned)
+				unpin_user_pages(userptr->pages, pinned);
+			kvfree(userptr->pages);
+			userptr->pages = NULL;
+			return ret;
+		}
+
+		pinned += ret;
+
+	} while (pinned < userptr->npages);
+
+	return 0;
+}
+
+static void
+virtio_gpu_userptr_unaccount(struct virtio_gpu_object_userptr *userptr)
+{
+	if (!userptr->mm)
+		return;
+
+	atomic64_sub(userptr->npages, &userptr->mm->pinned_vm);
+	mmdrop(userptr->mm);
+	userptr->mm = NULL;
+}
+
+static void
+virtio_gpu_userptr_put_pages(struct virtio_gpu_object_userptr *userptr)
+{
+	struct drm_device *dev = userptr->base.base.base.dev;
+
+	if (userptr->sgt) {
+		if (userptr->dma_mapped)
+			dma_unmap_sgtable(drm_dev_dma_dev(dev), userptr->sgt,
+					  userptr->dma_dir, 0);
+		userptr->dma_mapped = false;
+		sg_free_table(userptr->sgt);
+		kfree(userptr->sgt);
+		userptr->sgt = NULL;
+	}
+
+	if (userptr->pages) {
+		bool dirty = !(userptr->flags & VIRTGPU_BLOB_FLAG_USE_READONLY);
+
+		unpin_user_pages_dirty_lock(userptr->pages, userptr->npages,
+					    dirty);
+		kvfree(userptr->pages);
+		userptr->pages = NULL;
+	}
+
+	virtio_gpu_userptr_unaccount(userptr);
+}
+
+static int
+virtio_gpu_userptr_get_entries(struct virtio_gpu_device *vgdev,
+			       struct virtio_gpu_object_userptr *userptr,
+			       struct virtio_gpu_mem_entry **ents,
+			       unsigned int *nents)
+{
+	bool use_dma_api = virtio_gpu_use_dma_api(vgdev->vdev);
+	struct scatterlist *sg;
+	unsigned int count;
+	int si;
+
+	count = use_dma_api ? userptr->sgt->nents : userptr->sgt->orig_nents;
+	if (!count)
+		return -EINVAL;
+
+	*ents = kvmalloc_array(count, sizeof(**ents), GFP_KERNEL);
+	if (!*ents)
+		return -ENOMEM;
+
+	if (use_dma_api) {
+		for_each_sgtable_dma_sg(userptr->sgt, sg, si) {
+			(*ents)[si].addr = cpu_to_le64(sg_dma_address(sg));
+			(*ents)[si].length = cpu_to_le32(sg_dma_len(sg));
+			(*ents)[si].padding = 0;
+		}
+	} else {
+		for_each_sgtable_sg(userptr->sgt, sg, si) {
+			(*ents)[si].addr = cpu_to_le64(sg_phys(sg));
+			(*ents)[si].length = cpu_to_le32(sg->length);
+			(*ents)[si].padding = 0;
+		}
+	}
+
+	*nents = count;
+	return 0;
+}
+
+int virtio_gpu_userptr_restore(struct virtio_gpu_device *vgdev,
+			       struct virtio_gpu_object *bo,
+			       struct virtio_gpu_mem_entry **ents,
+			       unsigned int *nents)
+{
+	struct virtio_gpu_object_userptr *userptr = to_virtio_gpu_userptr(bo);
+	int ret;
+
+	mutex_lock(&userptr->lock);
+	if (!userptr->sgt || !userptr->pages) {
+		mutex_unlock(&userptr->lock);
+		return -EINVAL;
+	}
+
+	if (userptr->dma_mapped) {
+		struct device *dev = drm_dev_dma_dev(vgdev->ddev);
+
+		dma_unmap_sgtable(dev, userptr->sgt, userptr->dma_dir, 0);
+		userptr->dma_mapped = false;
+
+		ret = dma_map_sgtable(dev, userptr->sgt, userptr->dma_dir, 0);
+		if (ret) {
+			mutex_unlock(&userptr->lock);
+			return ret;
+		}
+		userptr->dma_mapped = true;
+	}
+
+	ret = virtio_gpu_userptr_get_entries(vgdev, userptr, ents, nents);
+	mutex_unlock(&userptr->lock);
+	return ret;
+}
+
+static int
+virtio_gpu_userptr_init(struct drm_device *dev, struct drm_file *file,
+			struct virtio_gpu_object_userptr *userptr,
+			struct virtio_gpu_object_params *params,
+			const struct virtio_gpu_object_userptr_ops *ops)
+{
+	struct drm_gem_object *obj;
+	int ret;
+
+	userptr->start = params->userptr;
+	userptr->npages = params->size >> PAGE_SHIFT;
+	userptr->flags = params->blob_flags;
+
+	mutex_init(&userptr->lock);
+	userptr->vgdev = dev->dev_private;
+	userptr->file = file;
+	userptr->ops = ops;
+
+	/*
+	 * Get the resource id before GEM init, so a failed call here
+	 * just needs a plain kfree and no special id zero check in the
+	 * shared resource_id_put helper.
+	 */
+	ret = virtio_gpu_resource_id_get(userptr->vgdev,
+					 &userptr->base.hw_res_handle);
+	if (ret) {
+		mutex_destroy(&userptr->lock);
+		return ret;
+	}
+
+	obj = &userptr->base.base.base;
+	obj->funcs = &virtio_gpu_userptr_funcs;
+
+	drm_gem_private_object_init(dev, obj, params->size);
+	INIT_LIST_HEAD(&userptr->base.restore_node);
+
+	return 0;
+}
+
+static const struct virtio_gpu_object_userptr_ops virtio_gpu_userptr_ops = {
+	.get_pages = virtio_gpu_userptr_get_pages,
+	.put_pages = virtio_gpu_userptr_put_pages,
+};
+
+int virtio_gpu_userptr_create(struct virtio_gpu_device *vgdev,
+			      struct drm_file *file,
+			      struct virtio_gpu_object_params *params,
+			      struct virtio_gpu_object **bo_ptr)
+{
+	struct virtio_gpu_object_userptr *userptr;
+	struct virtio_gpu_mem_entry *ents = NULL;
+	struct sg_table *sgt;
+	struct mm_struct *mm;
+	unsigned long lock_limit;
+	unsigned long start;
+	unsigned long end;
+	s64 new_pinned;
+	unsigned int nents;
+	int ret;
+
+	*bo_ptr = NULL;
+
+	if (!params->size || !IS_ALIGNED(params->size, PAGE_SIZE) ||
+	    params->userptr != (unsigned long)params->userptr)
+		return -EINVAL;
+
+	start = params->userptr;
+	if (!IS_ALIGNED(start, PAGE_SIZE) ||
+	    check_add_overflow(start, (unsigned long)params->size, &end))
+		return -EINVAL;
+
+	if (!can_do_mlock())
+		return -EPERM;
+
+	if (params->size >> PAGE_SHIFT > INT_MAX)
+		return -E2BIG;
+
+	if (!access_ok((void __user *)start, params->size))
+		return -EFAULT;
+
+	userptr = kzalloc_obj(*userptr);
+	if (!userptr)
+		return -ENOMEM;
+
+	ret = virtio_gpu_userptr_init(vgdev->ddev, file, userptr, params,
+				      &virtio_gpu_userptr_ops);
+	if (ret) {
+		kfree(userptr);
+		return ret;
+	}
+
+	mm = current->mm;
+	mmgrab(mm);
+	lock_limit = rlimit(RLIMIT_MEMLOCK) >> PAGE_SHIFT;
+	new_pinned = atomic64_add_return(userptr->npages, &mm->pinned_vm);
+	if (new_pinned < 0 ||
+	    (new_pinned > lock_limit && !capable(CAP_IPC_LOCK))) {
+		atomic64_sub(userptr->npages, &mm->pinned_vm);
+		mmdrop(mm);
+		ret = new_pinned < 0 ? -EOVERFLOW : -ENOMEM;
+		goto err_cleanup;
+	}
+	userptr->mm = mm;
+
+	mutex_lock(&userptr->lock);
+	ret = userptr->ops->get_pages(userptr);
+	mutex_unlock(&userptr->lock);
+	if (ret)
+		goto err_cleanup;
+
+	sgt = drm_prime_pages_to_sg(vgdev->ddev, userptr->pages,
+				    userptr->npages);
+	if (IS_ERR(sgt)) {
+		ret = PTR_ERR(sgt);
+		goto err_cleanup;
+	}
+
+	userptr->sgt = sgt;
+
+	if (virtio_gpu_use_dma_api(vgdev->vdev)) {
+		enum dma_data_direction dir =
+			(userptr->flags & VIRTGPU_BLOB_FLAG_USE_READONLY) ?
+			DMA_TO_DEVICE : DMA_BIDIRECTIONAL;
+
+		ret = dma_map_sgtable(drm_dev_dma_dev(vgdev->ddev), sgt,
+				      dir, 0);
+		if (ret)
+			goto err_cleanup;
+
+		userptr->dma_dir = dir;
+		userptr->dma_mapped = true;
+	}
+
+	ret = virtio_gpu_userptr_get_entries(vgdev, userptr, &ents, &nents);
+	if (ret)
+		goto err_cleanup;
+
+	virtio_gpu_cmd_resource_create_blob(vgdev, &userptr->base, params, ents,
+					    nents);
+
+	userptr->base.params = *params;
+	virtio_gpu_add_object_to_restore_list(vgdev, &userptr->base);
+
+	*bo_ptr = &userptr->base;
+	return 0;
+
+err_cleanup:
+	virtio_gpu_cleanup_object(&userptr->base);
+	return ret;
+}
-- 
2.34.1

