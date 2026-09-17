Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11011041.outbound.protection.outlook.com [52.101.57.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CBFE4A99AB
	for <virtualization@lists.linux.dev>; Thu, 17 Sep 2026 10:26:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.57.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789640777; cv=fail; b=m9tuj+jsCGoWiorRqixtvVzNsNMLgTYoyRymESC33SOI8e6N5Ecxmofrzq9swlyLKJt7ik4aN10W0+xMtKmuHe/ABve5pnrnUmI36lGq1US6sudNzz645ForiMKELRtukkan4WoxqGSp+l548RArw52qc208ac4HJKRoiGub4B4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789640777; c=relaxed/simple;
	bh=cpO977Lsjf52ZbWXy8vU0oPwwGPeD/UHmjs2aqiGE64=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sLcLgKX1d0U6fJwu2IyhezuApkZGNuR1h0sY+zQybZFTiJBcoYJC9nCMgOUWGqejqzO8B7N9Zd2hUu/hsLHvUOoPPwxb1uoFMIwr+bEuLmSJKslgyLZePCNOJtg5qMqWpRM3SjqLtE8nrfJD/uR1XuLVfENJvw4PMNiTcfmnC4I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=sBofMKNu; arc=fail smtp.client-ip=52.101.57.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="sBofMKNu"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ev5q39HLbK1o4QfFsNaWBhdzLqGL7zOWalHrH6m/VQ1lWwszlcZ/VMQcbvCWeUk/vR8FqOVobwpYZZtnOYCbQ1C4xqnTn44dHpiyFWwSokVSgxSpXLUCWU4w+xlWWTdVK5h2nlh2VHDVIw7mW6q3aDZJQ2nAaTJCXuTC6A4vUaIln4gG9KLw7GC4RWhRqz5W//ALy3O6xAQKhrogsW5i2GZJaRyqPA0Du6Df1vEaCDH7SJ4GpTw+R/uneGnnaefvtepBDjxklxtS53BRhlP9yqc6F6POZJj8zKk2JnEVa5L6dLe3lNbBXBk/9UJVbYQFTyA8tJmekAmQNNOLP1eCRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K4N87s/23l2j/QffvfZM+GvGx5ESPKK97hg95UzC4nY=;
 b=eXDXd8OxKZ2mSA9tWoraBWdIMB1mJeOwh/tjQ85aMN2InqcLjdYmliv3jQGCJmutRYN4q9+X6S1iOTE2ITdhncbog4kOF78AJ6Ab6tpNHkldoQ/k5Eu611SDGa6tMmUncT08/OFgWZrfhdfZAi/LFZTVhuTvRzjFDdpseeRrYmKJygW8ho1PGOLB9SC4C54SmX1qklcs5pkiG43Arbt9q4fT62A4Fu1o0c+mKMG86VFKq3ntZhGyYyO2+fSF0WS9qpzTmbT6N+JEhH26I3KVAQlREQbdNe7nsCM7O7THYnW8hS268KRy7BlWfdcgfhVsWExo1XyikYB9KDxTwKG3eg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=collabora.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K4N87s/23l2j/QffvfZM+GvGx5ESPKK97hg95UzC4nY=;
 b=sBofMKNuW8gK8fTwTJ5qxHI4NRW3eHNgDcyAAJ3h4PWM2oO/a9ar0wxfZMm4IwAH8fPpbpnB6qwgRCGfxtflWUgaoR/UiF7M8MdgLCpfg5m3l3qSIo2ne3WJzrkjlmgb6nkAjdDEDzc779M0JVvGIX5Er2WMyoRPBzu78ScrLn0=
Received: from CP5P284CA0232.BRAP284.PROD.OUTLOOK.COM (2603:10d6:103:22e::10)
 by BN7PPF9E4583E15.namprd12.prod.outlook.com (2603:10b6:40f:fc02::6dc) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.12; Thu, 17 Sep
 2026 10:26:03 +0000
Received: from BN7PEPF000000AA.namprd05.prod.outlook.com
 (2603:10d6:103:22e:cafe::32) by CP5P284CA0232.outlook.office365.com
 (2603:10d6:103:22e::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.428.12 via Frontend Transport; Thu,
 17 Sep 2026 10:26:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN7PEPF000000AA.mail.protection.outlook.com (10.167.245.234) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.451.8 via Frontend Transport; Thu, 17 Sep 2026 10:26:02 +0000
Received: from honglei-remote.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Thu, 17 Sep
 2026 05:25:59 -0500
From: Honglei Huang <honghuan@amd.com>
To: Dmitry Osipenko <dmitry.osipenko@collabora.com>, Akihiko Odaki
	<odaki@rsg.ci.i.u-tokyo.ac.jp>, David Airlie <airlied@redhat.com>, "Gerd
 Hoffmann" <kraxel@redhat.com>
CC: Gurchetan Singh <gurchetansingh@chromium.org>, Chia-I Wu
	<olvaffe@gmail.com>, Ray Huang <Ray.Huang@amd.com>,
	<dri-devel@lists.freedesktop.org>, <virtualization@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH v6 3/4] drm/virtio: implement userptr support for zero-copy memory access
Date: Thu, 17 Sep 2026 18:25:39 +0800
Message-ID: <20260917102540.1312102-4-honghuan@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260917102540.1312102-1-honghuan@amd.com>
References: <20260917102540.1312102-1-honghuan@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN7PEPF000000AA:EE_|BN7PPF9E4583E15:EE_
X-MS-Office365-Filtering-Correlation-Id: cd7a3f42-b019-49ab-333c-08df14a61338
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700016|23010399003|376014|1800799024|56012099006|10067099003|5023799004|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	qcVxuKr4vVJsOTZw+b4aIrK7JVZgiFUZde28Fq+ZpfZnjlTjQs4xP9qu/iIflibDbNTKX8NYGmqkgYwFhezoqiG67g14LNuRLYi7YQyc9ME7Y8efUc20MS37BTYEtN6SAnQd/HpIvgOylUr1sRGELUdAOxM3jQKAgbHm3zQOE069ttyCJDaSbpQK4cdDLyNXwDABmR6B7nhtScHkr84DhBUt1FoIebDwZCB4OjIeuO+DNIZc2EQJgYSuxhkZmpgjLHg12X/H7LDT4/s0CHSMcYE/t2aWs6TUglzs7P6MyRllwaFr93ol1qBlet7xOXivXSqNtWZ1j4ZQ9cglQn99raOVqsQfYrcQ3qR8TYblZgrhZ7eZ7T1d0hNeThumIs6jslnkd0cwyHhkla8Kal+UrDWDEKCQlOEW0Wn3Km93PjOKTE0mZu+mZZcIp+ZpfheUGG5Li1gSt1QG9AILRynHRSp4TBgc1Pf8qucLhbn1/FhHk+v3LCRYqOUIswlP72IwbNZ4mE2f+49XdJpJmBWmS/02BwnfnYuJcEAkWyQC8OqXO4FQVuuMkuUsJf3Yq1Pfvr/2TgVYXVp1NKLE014C5oyRKtXCd3nDLn5Q03UYgNXDrgM2RFpSSYqzsgo3Dfwa+ugOFUmaU0BTBNwk3g2KvU+VODACb15b6BDLQ2SdZ+zIUicQv0K7clX/UCUaMejTCTH1dK3omEraE5e995UCKA==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700016)(23010399003)(376014)(1800799024)(56012099006)(10067099003)(5023799004)(11063799006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	Djmez3Y/Z1U01oECcZaOs8Q1xaCcBa2vfXGy5mjXIp8/C+BI9MYSHmSNTXCIjJef+cW7fyHE7T8dupJKOhv/Fdns5MG1/FZlvZQMPhfPs6qN6y7lIR98z2mU32XmTuYcaPYQt8Iia3r1vWjlAbkBT7PuSyZHtFI1BDBrPVh9BX0aT/7CyhBGG/cz8jJ3oK1Paehc7xM1ffus+JA5Al+OZ4+vQCGqkPxMat4IcgmjPSEqTs2O0QL4+QNXfHpSznE44R/jtjt2z1s3NqdfUKpkHLcl8nhzlVXg0IpJDdr9dwLxB5hkxkEwQ6Dae423GfPoJMOCxGXCl/fkdEQ8Ia9qwkbwOXwRaBnCUclkPitlg/TXSLj6vuaR/mA/GUFz2MGZFAtxETKf7rWB0KylFVW+NGWxb2h2e22yokEN1ufNXu7u3UA/xx0Tb0OljZ2Xibyi
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2026 10:26:02.9085
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cd7a3f42-b019-49ab-333c-08df14a61338
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN7PEPF000000AA.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PPF9E4583E15

From: Honglei Huang <Honglei1.Huang@amd.com>

Add userptr blob objects so the guest kernel can pin an existing
userspace mapping and advertise it as CREATE_BLOB backing entries.

- New virtio_gpu_object_userptr type for userptr resources
- Pin pages with pin_user_pages_fast() and FOLL_LONGTERM
- Charge FOLL_LONGTERM pins against RLIMIT_MEMLOCK
- DMA-map the scatterlist and pass DMA addresses when the virtio
  DMA API is required
- Keep pages pinned until RESOURCE_UNREF is queued; drop them from
  cleanup_object() on the unref response or on create failure
- Reject unaligned or overflowing userptr ranges at create time
- Return a fresh SG table from PRIME export

Signed-off-by: Honglei Huang <Honglei1.Huang@amd.com>
---
 drivers/gpu/drm/virtio/Makefile          |   3 +-
 drivers/gpu/drm/virtio/virtgpu_drv.h     |  36 +++
 drivers/gpu/drm/virtio/virtgpu_object.c  |  10 +
 drivers/gpu/drm/virtio/virtgpu_userptr.c | 323 +++++++++++++++++++++++
 4 files changed, 371 insertions(+), 1 deletion(-)
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
index 9df4c71173..42869b7d57 100644
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
@@ -562,4 +592,10 @@ void virtio_gpu_vram_map_deferred(struct virtio_gpu_object_vram *vram);
 int virtio_gpu_execbuffer_ioctl(struct drm_device *dev, void *data,
 				struct drm_file *file);
 
+/* virtgpu_userptr.c */
+int virtio_gpu_userptr_create(struct virtio_gpu_device *vgdev,
+			      struct drm_file *file,
+			      struct virtio_gpu_object_params *params,
+			      struct virtio_gpu_object **bo_ptr);
+bool virtio_gpu_is_userptr(struct virtio_gpu_object *bo);
 #endif
diff --git a/drivers/gpu/drm/virtio/virtgpu_object.c b/drivers/gpu/drm/virtio/virtgpu_object.c
index 49899485be..5c40f5a034 100644
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
diff --git a/drivers/gpu/drm/virtio/virtgpu_userptr.c b/drivers/gpu/drm/virtio/virtgpu_userptr.c
new file mode 100644
index 0000000000..7879735e63
--- /dev/null
+++ b/drivers/gpu/drm/virtio/virtgpu_userptr.c
@@ -0,0 +1,323 @@
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
+#include <drm/drm_prime.h>
+
+static struct sg_table *
+virtio_gpu_userptr_get_sg_table(struct drm_gem_object *obj);
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
+static const struct drm_gem_object_funcs virtio_gpu_userptr_funcs = {
+	.open = virtio_gpu_gem_object_open,
+	.close = virtio_gpu_gem_object_close,
+	.free = virtio_gpu_userptr_free,
+	.export = virtgpu_gem_prime_export,
+	.get_sg_table = virtio_gpu_userptr_get_sg_table,
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
+	if (!(userptr->flags & VIRTGPU_BLOB_FLAG_USERPTR_RDONLY))
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
+					  DMA_BIDIRECTIONAL, 0);
+		userptr->dma_mapped = false;
+		sg_free_table(userptr->sgt);
+		kfree(userptr->sgt);
+		userptr->sgt = NULL;
+	}
+
+	if (userptr->pages) {
+		unpin_user_pages(userptr->pages, userptr->npages);
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
+static struct sg_table *
+virtio_gpu_userptr_get_sg_table(struct drm_gem_object *obj)
+{
+	struct virtio_gpu_object *bo = gem_to_virtio_gpu_obj(obj);
+	struct virtio_gpu_object_userptr *userptr = to_virtio_gpu_userptr(bo);
+	int ret;
+
+	mutex_lock(&userptr->lock);
+	if (!userptr->pages) {
+		ret = userptr->ops->get_pages(userptr);
+		if (ret) {
+			mutex_unlock(&userptr->lock);
+			return ERR_PTR(ret);
+		}
+	}
+	mutex_unlock(&userptr->lock);
+
+	/* PRIME takes ownership of the returned table. */
+	return drm_prime_pages_to_sg(obj->dev, userptr->pages, userptr->npages);
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
+	ret = dma_map_sgtable(drm_dev_dma_dev(vgdev->ddev), sgt,
+			      DMA_BIDIRECTIONAL, 0);
+	if (ret) {
+		sg_free_table(sgt);
+		kfree(sgt);
+		goto err_cleanup;
+	}
+
+	userptr->sgt = sgt;
+	userptr->dma_mapped = true;
+
+	ret = virtio_gpu_userptr_get_entries(vgdev, userptr, &ents, &nents);
+	if (ret)
+		goto err_cleanup;
+
+	virtio_gpu_cmd_resource_create_blob(vgdev, &userptr->base, params, ents,
+					    nents);
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

