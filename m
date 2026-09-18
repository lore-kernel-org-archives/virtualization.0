Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012024.outbound.protection.outlook.com [52.101.48.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A65EB44331B
	for <virtualization@lists.linux.dev>; Fri, 18 Sep 2026 10:00:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.24
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789725622; cv=fail; b=py49YS8PdE9UVNb+Aqi/SpxY19Jsog0j2H1BZdGJJKA66bDWe9bwYuXa7BxqOB7oZN7pZXiNDxyIdLBazNCB1Do2syH9uo+rIIWpwIIEOe/Ipyo49oludY1BLta6gG+5XFs9mge3T8rCxs4BQkPBDhYUkugBDjSIfGOQaMrbfg8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789725622; c=relaxed/simple;
	bh=6Xi89yuvrMcVQ5IzCBQZNmNAC4wA0JVRe9NFPpPFoTs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=okNTLeMwmvDk24cTOikHulyeI2zeQRlaIKvinCnBN0OYtNM9mXOFFk8rDwexSE8s2/TZgr+AzoFRDGZ63L73HntgQ4WcdruFbfqsguz6NWDLwZyvvoeZbFbDjjUCIkvHZP4Ll9OXn3Yrah8hJWvNPpge7aQbqfqE+6kZnKrnyJA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=XDUfxeTb; arc=fail smtp.client-ip=52.101.48.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="XDUfxeTb"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kiw1biidVUMEmzSHtd2jpkSMtT7KVFkhk4g02pwlpHiZFLTqtknOgZOWa4sU5xCEBKKhss5yS45pDJOeVg6+E4S6HYRbAOM4v+wqdEXOgn/RQKIL7lvz30HdwE7XppofM1JBR+LlMa54u4Vvb5aXCCacOU3hlypZLh8jfIiRUVzEYVClmz7PAJ565g5fZZ1r5/wNFGVqpiV4OAaEMniTCEAidSfJIkQCc17bpMmrNbczI9nKVHaTl/l5htDyeoJ/vfqMnyveM3q5DBWxfFmW0zFUQotogkyUHuCKWdTxh7VZqR4/ZodirFXyC1wgaqu6+2yCx4Sed8L+Cu99LbLiwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LvN1AE5Z77dbmuNDT/vjJgGQibFC/Ec4CfAnevGbQuI=;
 b=B/rES07Fl4gDUSQykt/CjiTfSKPdt18EaDsbhwGm5iYoJn9c4p22UX0FygWRc0BAvL4xo4QuxFtXubJhbg50lwvoM0R4GMViPb8q3ZZPw6bByLcBBWnb48Ak8352u3gjBwEJ5ESQmk4aY/+FgD1Xmchgl2PuGhnU3dDR15XMUONNlNPcmP9rwOp7BOH/pxILME4r+ah48r7tdnPCAr3EuX/GRG9+MWt0dkKlLfzO2szv5FnKj7WMAJ+HRH72vMSMgCEsiEEJGCUYgMhndys27LgIkd3GXVXo3lh48xvvCgFeUwdZDWbk03SgLvklq4IrelodoZpUX29L2mEuXS2B9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=collabora.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LvN1AE5Z77dbmuNDT/vjJgGQibFC/Ec4CfAnevGbQuI=;
 b=XDUfxeTbuOP+AwsSHm53DDpwoU481uefxMrKe0YTrr0tCfaY0pdndED/JZ44UH3cCDp5+jMIL/9OCOQHD7BYYH/rVuxf1WvhcnXy3XnUjnsekvW2MCSVmZsm7KWObFhjxcLL66gs/vSv7qRGxh5f05BxKzyF+vKBM+w0NL9VIf0=
Received: from SJ0PR05CA0085.namprd05.prod.outlook.com (2603:10b6:a03:332::30)
 by CH3PR12MB9147.namprd12.prod.outlook.com (2603:10b6:610:19a::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.13; Fri, 18 Sep
 2026 10:00:04 +0000
Received: from SJ1PEPF000037A1.namprd04.prod.outlook.com
 (2603:10b6:a03:332:cafe::52) by SJ0PR05CA0085.outlook.office365.com
 (2603:10b6:a03:332::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.406.6 via Frontend Transport; Fri, 18
 Sep 2026 10:00:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF000037A1.mail.protection.outlook.com (10.167.244.133) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.451.8 via Frontend Transport; Fri, 18 Sep 2026 10:00:03 +0000
Received: from honglei-remote.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Fri, 18 Sep
 2026 04:59:59 -0500
From: Honglei Huang <honghuan@amd.com>
To: Dmitry Osipenko <dmitry.osipenko@collabora.com>, Akihiko Odaki
	<odaki@rsg.ci.i.u-tokyo.ac.jp>, David Airlie <airlied@redhat.com>, "Gerd
 Hoffmann" <kraxel@redhat.com>
CC: Gurchetan Singh <gurchetansingh@chromium.org>, Chia-I Wu
	<olvaffe@gmail.com>, Ray Huang <Ray.Huang@amd.com>,
	<dri-devel@lists.freedesktop.org>, <virtualization@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, Honglei Huang <honghuan@amd.com>
Subject: [PATCH v8 3/4] drm/virtio: implement userptr support for zero-copy memory access
Date: Fri, 18 Sep 2026 17:59:39 +0800
Message-ID: <20260918095940.2253018-4-honghuan@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260918095940.2253018-1-honghuan@amd.com>
References: <20260918095940.2253018-1-honghuan@amd.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000037A1:EE_|CH3PR12MB9147:EE_
X-MS-Office365-Filtering-Correlation-Id: d7a76291-6910-47a8-4d9a-08df156b9c72
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|23010399003|376014|82310400026|1800799024|10067099003|56012099006|5023799004|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	DnjQlys41Wx/JMt7yqnNYYT1O9HA6AGVmj5bpYBq0eBCtqM5sh4yhOLC+H/eE9L0uK03PN659uD+QMYi0oi8MBTOrJmYcgUaul768JojzR0G/tDxrydh5Id++YGeO301SPyM7rORx2FA1vq8+ra5R6qTOC1LHxYRhtE2x7F7FTg4W4GFmPOet8cjIF8DUjKsMeAaiE4uv38jahsSx0j2Y64isGHo3VOrfRRU/vLay1sPTYgjzRVagbud9InqeGuf3Cwkro+e7sqxsl9e3kxY+5KJ2XhAwH01nHkcr5EbQeDZdy6WBtJvYcCx/Y8pxVpnQ+tKRcVhmx2DrQ4UozCEPzomy2yyjFwk2e7TyCOiCj27jZXXtN0Ytvu7TY0VqHdbnwaNllJIxTHGMs8xIqHMT6kAP/jhz0VRPV5yZ1A/YbZvitckp8pQ4yVDtAvEX7d6pMo3j+sfs0EOuXvj5SGTeEykgbPwwutZ+K+8C2HuvBNsufCKgaUSNZj9rVDpThoj6JJ75n1FhtP2feC9O3JfiN0KBze+Jjm3wt9JI6SG9py/OOEgeNMvMUbxhFupGQkrcMgtYTXOxs+EOqz5h9Qfhpy1pPUV8Dwpm+tnL55zNdA2QcScqrhgpCmPv7mHTwk+MX3nZ4eAEuXkvSsdDk9OLVlcmRcYNdryCjz84maTLAI3EPjaREcMxnXLSFvGNuGwsKkyo6UYW0Lie+a7A0Nl2w==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(23010399003)(376014)(82310400026)(1800799024)(10067099003)(56012099006)(5023799004)(11063799006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	GRbTpREDbUx0cFPONQi2RsWc5Fv77tsOdymhgonP0/Zv/uKSjkllHXyA4dSx337n9iyC0XATVzDr4DmHXQBemWCefZ6Xs9/h0n7UrVbfG8JAOK10UjjSLel8bO/L9uL7Ib9jdhwT5sogySZh9EP0y+15cw5Ujd1XJJSjqP5GvN4lVwlPwGl8yKCiJiSjevpf/e5W0p67HH17j8P8tZqetJPyPpdHVOyExW3/J2DCrTavgLnE2BHQbvrX+nXBi5yFyiko8AqdGM92mbiqyEfyei4Rn7q80s8YgcQwRLmbdnB1hffdc6Q1Par1wYSIhT7wRWP0hAuQn64UY757UaA/j53uHQAIZRtLvUHPfBIIE434010gEtEpgpSrg7kWCeA4VoMKKPEiuEGThfeH5HeO/hB1IwYANo3Ct6QIs5lwzL0pYR/hqMlnMLcXXzbyDcE9
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2026 10:00:03.9232
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d7a76291-6910-47a8-4d9a-08df156b9c72
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF000037A1.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9147

Add userptr blob objects so the guest kernel can pin an existing
userspace mapping and advertise it as CREATE_BLOB backing entries.

- New virtio_gpu_object_userptr type for userptr resources
- Pin pages with pin_user_pages_fast() and FOLL_LONGTERM
- Omit FOLL_WRITE when VIRTGPU_BLOB_FLAG_USE_READONLY is set
- Charge FOLL_LONGTERM pins against RLIMIT_MEMLOCK
- DMA-map the scatterlist only when virtio_gpu_use_dma_api() is
  required; use DMA_TO_DEVICE for USE_READONLY blobs
- Sync userptr SG for the device on TRANSFER_TO_HOST
- Mark writable pages dirty when unpinning
- Keep pages pinned until RESOURCE_UNREF is queued; drop them from
  cleanup_object() on the unref response or on create failure
- Clear userptr->pages on pin failure to avoid double-free on cleanup
- Reject unaligned or overflowing userptr ranges at create time
- Disallow PRIME export of userptr objects
- Save CREATE_BLOB params and restore userptr resources after
  hibernation without using the shmem restore path

Signed-off-by: Honglei Huang <honghuan@amd.com>
---
 drivers/gpu/drm/virtio/Makefile          |   3 +-
 drivers/gpu/drm/virtio/virtgpu_drv.h     |  43 +++
 drivers/gpu/drm/virtio/virtgpu_object.c  |  22 ++
 drivers/gpu/drm/virtio/virtgpu_userptr.c | 365 +++++++++++++++++++++++
 drivers/gpu/drm/virtio/virtgpu_vq.c      |  33 +-
 5 files changed, 456 insertions(+), 10 deletions(-)
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
index 9df4c71173..e0941cc187 100644
--- a/drivers/gpu/drm/virtio/virtgpu_drv.h
+++ b/drivers/gpu/drm/virtio/virtgpu_drv.h
@@ -105,6 +105,7 @@ struct virtio_gpu_object_params {
 	uint32_t blob_flags;
 	uint64_t blob_id;
 	uint32_t blob_hints;
+	uint64_t userptr;
 };
 
 struct virtio_gpu_object {
@@ -138,12 +139,42 @@ struct virtio_gpu_object_vram {
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
+	/* Protects pages and sgt. */
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
@@ -284,6 +315,7 @@ struct virtio_gpu_device {
 	bool has_host_visible;
 	bool has_context_init;
 	bool has_blob_alignment;
+	bool has_blob_readonly;
 	bool hibernated;
 	struct virtio_shm_region host_visible_region;
 	struct drm_mm host_visible_mm;
@@ -562,4 +594,15 @@ void virtio_gpu_vram_map_deferred(struct virtio_gpu_object_vram *vram);
 int virtio_gpu_execbuffer_ioctl(struct drm_device *dev, void *data,
 				struct drm_file *file);
 
+/* virtgpu_userptr.c */
+int virtio_gpu_userptr_create(struct virtio_gpu_device *vgdev,
+			      struct drm_file *file,
+			      struct virtio_gpu_object_params *params,
+			      struct virtio_gpu_object **bo_ptr);
+bool virtio_gpu_is_userptr(struct virtio_gpu_object *bo);
+void virtio_gpu_userptr_dma_sync_for_device(struct virtio_gpu_object *bo);
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
index 0000000000..ccfd96844e
--- /dev/null
+++ b/drivers/gpu/drm/virtio/virtgpu_userptr.c
@@ -0,0 +1,365 @@
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
+	 * Keep pages pinned until RESOURCE_UNREF completes. The response
+	 * callback calls virtio_gpu_cleanup_object(), which drops them.
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
+void virtio_gpu_userptr_dma_sync_for_device(struct virtio_gpu_object *bo)
+{
+	struct virtio_gpu_object_userptr *userptr = to_virtio_gpu_userptr(bo);
+	struct device *dev;
+
+	if (!userptr->dma_mapped)
+		return;
+
+	dev = drm_dev_dma_dev(userptr->base.base.base.dev);
+	dma_sync_sgtable_for_device(dev, userptr->sgt, DMA_TO_DEVICE);
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
+	 * Allocate the resource id before GEM init so a failure here can
+	 * unwind with a plain kfree and does not need a special id=0 guard
+	 * in the shared resource_id_put helper.
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
+	/*
+	 * Match shmem blobs: only DMA-map when the virtio DMA API is in
+	 * use. Mapping unconditionally can create SWIOTLB bounce buffers
+	 * that get copied back over guest pages on unmap even though the
+	 * host was given sg_phys() addresses.
+	 */
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
diff --git a/drivers/gpu/drm/virtio/virtgpu_vq.c b/drivers/gpu/drm/virtio/virtgpu_vq.c
index c02c03c10d..dcbd7bb7a6 100644
--- a/drivers/gpu/drm/virtio/virtgpu_vq.c
+++ b/drivers/gpu/drm/virtio/virtgpu_vq.c
@@ -781,9 +781,14 @@ int virtio_gpu_panic_cmd_transfer_to_host_2d(struct virtio_gpu_device *vgdev,
 	struct virtio_gpu_vbuffer *vbuf;
 	bool use_dma_api = virtio_gpu_use_dma_api(vgdev->vdev);
 
-	if (virtio_gpu_is_shmem(bo) && use_dma_api)
-		dma_sync_sgtable_for_device(vgdev->vdev->dev.parent,
-					    bo->base.sgt, DMA_TO_DEVICE);
+	if (use_dma_api) {
+		if (virtio_gpu_is_shmem(bo))
+			dma_sync_sgtable_for_device(vgdev->vdev->dev.parent,
+						    bo->base.sgt,
+						    DMA_TO_DEVICE);
+		else if (virtio_gpu_is_userptr(bo))
+			virtio_gpu_userptr_dma_sync_for_device(bo);
+	}
 
 	cmd_p = virtio_gpu_panic_alloc_cmd_resp(vgdev, &vbuf, sizeof(*cmd_p));
 	memset(cmd_p, 0, sizeof(*cmd_p));
@@ -812,9 +817,14 @@ void virtio_gpu_cmd_transfer_to_host_2d(struct virtio_gpu_device *vgdev,
 	struct virtio_gpu_vbuffer *vbuf;
 	bool use_dma_api = virtio_gpu_use_dma_api(vgdev->vdev);
 
-	if (virtio_gpu_is_shmem(bo) && use_dma_api)
-		dma_sync_sgtable_for_device(vgdev->vdev->dev.parent,
-					    bo->base.sgt, DMA_TO_DEVICE);
+	if (use_dma_api) {
+		if (virtio_gpu_is_shmem(bo))
+			dma_sync_sgtable_for_device(vgdev->vdev->dev.parent,
+						    bo->base.sgt,
+						    DMA_TO_DEVICE);
+		else if (virtio_gpu_is_userptr(bo))
+			virtio_gpu_userptr_dma_sync_for_device(bo);
+	}
 
 	cmd_p = virtio_gpu_alloc_cmd(vgdev, &vbuf, sizeof(*cmd_p));
 	memset(cmd_p, 0, sizeof(*cmd_p));
@@ -1245,9 +1255,14 @@ void virtio_gpu_cmd_transfer_to_host_3d(struct virtio_gpu_device *vgdev,
 	struct virtio_gpu_vbuffer *vbuf;
 	bool use_dma_api = virtio_gpu_use_dma_api(vgdev->vdev);
 
-	if (virtio_gpu_is_shmem(bo) && use_dma_api)
-		dma_sync_sgtable_for_device(vgdev->vdev->dev.parent,
-					    bo->base.sgt, DMA_TO_DEVICE);
+	if (use_dma_api) {
+		if (virtio_gpu_is_shmem(bo))
+			dma_sync_sgtable_for_device(vgdev->vdev->dev.parent,
+						    bo->base.sgt,
+						    DMA_TO_DEVICE);
+		else if (virtio_gpu_is_userptr(bo))
+			virtio_gpu_userptr_dma_sync_for_device(bo);
+	}
 
 	cmd_p = virtio_gpu_alloc_cmd(vgdev, &vbuf, sizeof(*cmd_p));
 	memset(cmd_p, 0, sizeof(*cmd_p));
-- 
2.34.1

