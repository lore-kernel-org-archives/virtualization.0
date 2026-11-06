Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.48.34
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793953624;
	b=u+MzsiDVvs5GcoWG0ZWYrflu+WcU0/Da5UKHGIazAYRAQLype60oO+0Uf/FFmIfBiYHF
	 xuQb2t8nebh8ViT/Bbhq3PIiB+E5V5gFls/dUiInMPuAqw7WJNG7HFzG9GC7ic6RMPH3s
	 iwklwb1NKiVGfb7SKM8QLRtpE1bvHRq9zSoOF//Z2DciRL5F4xm9fkrdz/bB8yrlcboAY
	 45qMMDCbN2nYf6dYvvKF4OVMqiDMoFdBYaysY8hr8Q3sq1/Bt/9+Q/zThIku68n2WBqi5
	 BslpLhWVJNEnnaBhehYDIgbDQr26Qsx9pSgolmlPvEHp8R9OfwfMkd6XBuYDzcLPxKQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793953624;
	h=DMARC-Filter:DKIM-Signature:Received:Received:
	 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
	 From:To:CC:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type:X-Originating-IP:
	 X-ClientProxiedBy:X-EOPAttributedMessage:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-Id:
	 X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=pGmFB007Frp/MntR5Tn+q3d6/whdgWsjzPHSyUBhalo=;
	b=kaRFRVYfxWPxYsmi8bBIn14ZzZ46LZDB4JZRdAU5JCd1eQlus6dH/bsjlSpf7WsJVg5I
	 dl3y66dhlshro1XQTb2xCyhWQCmyPFLim8fLvnLVBiMKrdwfP2Przaby8/Pi4rjwW+AU5
	 ocl19ggVGqu28SJ6lsrW+HjCekw5e1emSjhYRZPmgqRjI4+5qL6fS4JgpfbbiKYqmDqbR
	 smVzBhrONI/TcAiO39cGJt7q2PxhVoat5I1TYA06v0ihmoiBqjzZT1VdyZamlSKwpjz43
	 06hFta9PFtnnDrwGZtYqwX5Px+h01LMZJtp80QEfPBPieVDmu7oxrGs6HJuPXLfvNeA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=RcoKxpYJ;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.48.34
Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012034.outbound.protection.outlook.com [52.101.48.34])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53815606A336
	for <virtualization@lists.linux.dev>; Fri,  6 Nov 2026 08:27:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 53815606A336
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=RcoKxpYJ
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OSvlZOEWOT5rIzKxaJf7vyCmyP3dOHGjqTk/rRPT+8/mBaRxjrQAptbOeU8woOzOmDrhjD0FPE0B/JJ5nF7AWT1qdZjen23pct2X6cFu+XhOW9o0EoMexgOCsrZL+wX0VtH6e2jbRLmh1gX8cuYfnogz6OqlMRPD8BBUF2+3hG6l5NbyrWB6FN/7s+FNKFwzB/WVI5NOeDWfH8ag4r7x2HLsft50v8UceDUduiF06/Llki0ELN0lIQ6QE4T07lFfPcrb72yxQTM/g/SX2+1h9hju7N0z4fFAr0fMRnkyDml/sqp77IE8A2/nx9MlyOzE0f7Zbr7ABu4UrDSOoPl1Iw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pGmFB007Frp/MntR5Tn+q3d6/whdgWsjzPHSyUBhalo=;
 b=BNQbXuexS6O9cN/0zs8+fgRGOrKZGRyUoiDQj3J7AzOmt32ufzCE5BqlSHnILcN1ywHvvI3VoRCziPjk3ux3F7JzdzmOvvz04kx0hnkPT50/eLBPAY/QC1w5DqJDXy1eKt0FR0+oS/FpuwMzvrAAi1i1nD3JOtbC8GygzILG9r0GNkL4LUwAF5V5aUOW+dwbXLVKqjgqRmqyCkRyBhFaIBoMoVlObzaNFEsHUkYKecjBc/QH3OtWiA9v5cFRA2EbMqrqDVNpPPSU3V0IMpLMSQSvhpizaazdTu8x24nuB6ZNZHUv21PRi5NxBowv0Lrb0SN+iJV8FmcAduzwAROowg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=collabora.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pGmFB007Frp/MntR5Tn+q3d6/whdgWsjzPHSyUBhalo=;
 b=RcoKxpYJTNw/Zys8/mR9jtrq2lRM+5uRZbD7jag7F1/cXmj+FkY/QlRM+j5F7MWVnIiVzjAWV7TUOjqSF5tCIZ6CC14VOCIpG1h0J8wmz7Iqn6EtjtZpzrq6W13955aGeSgyZagv/ohzBa1SZjF7IjfZs0QadfnMFw8kEk6Z4Ss=
Received: from MW4PR04CA0305.namprd04.prod.outlook.com (2603:10b6:303:82::10)
 by PH7PR12MB7356.namprd12.prod.outlook.com (2603:10b6:510:20f::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.11; Fri, 6 Nov
 2026 08:26:53 +0000
Received: from CO1PEPF0001885D.namprd02.prod.outlook.com
 (2603:10b6:303:82:cafe::a4) by MW4PR04CA0305.outlook.office365.com
 (2603:10b6:303:82::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.592.10 via Frontend Transport; Fri, 6
 Nov 2026 08:26:53 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CO1PEPF0001885D.mail.protection.outlook.com (10.167.249.246) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Fri, 6 Nov 2026 08:26:53 +0000
Received: from honglei-remote.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Fri, 6 Nov
 2026 02:26:47 -0600
From: Honglei Huang <honghuan@amd.com>
To: Dmitry Osipenko <dmitry.osipenko@collabora.com>, Akihiko Odaki
	<odaki@rsg.ci.i.u-tokyo.ac.jp>, David Airlie <airlied@redhat.com>, "Gerd
 Hoffmann" <kraxel@redhat.com>
CC: Gurchetan Singh <gurchetansingh@chromium.org>, Chia-I Wu
	<olvaffe@gmail.com>, Ray Huang <Ray.Huang@amd.com>,
	<dri-devel@lists.freedesktop.org>, <virtualization@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, Honglei Huang <honghuan@amd.com>
Subject: [RFC PATCH v10 3/4] drm/virtio: implement userptr resource support
Date: Fri, 6 Nov 2026 16:26:24 +0800
Message-ID: <20261106082625.812860-4-honghuan@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261106082625.812860-1-honghuan@amd.com>
References: <20261106082625.812860-1-honghuan@amd.com>
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF0001885D:EE_|PH7PR12MB7356:EE_
X-MS-Office365-Filtering-Correlation-Id: 2a0baa31-dd5b-4af5-ac2d-08df3bdfb681
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|23010399003|1800799024|36860700016|82310400026|260925022911599003|260925021911599003|260925021311599003|5023799004|11063799006|56012099006|261022105027099003|261022075727099003|261021123027099003|261021121427099003|261009223327099003|261009223027099003|261009221727099003|261009221227099003|261009220027099003|261102130727099003|261102123227099003|261026121527099003|261026140227099003|261028144727099003|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	Lnd8rfqYAjMj8kvYR75LQ1TdvLnq27Qqmnur4+HZNUMvKvs2bPVlN3TKQTl0ayI5PTlzZqXm2jZ+UTFAkdvAlcib7U5NjKmmgf5KmHN/Dfj+gxh2BYCeGe51qsN/0kBIV+eFqOSAwJNrzxCN06zpCSfyNrv3mCwSFnRINa5T9z62CKaQF5SFQBHJpXRIWROZMcpUr6PTVB498dn0FfKg0t9oACL33vHqP5eLbW6JdbwhJXnG66t3R4YtRm8V7KDaG3pJnqTI+kNzBRDMTwS+NR4tWYCcsJTWoz4gPSoqAauTmbBNpL7AkCCs6K/Ys2zDEHJRcCpCGw8QtH2DD4YJUaZBnISzZmJMUojU7WkR35eRJLHCdyMUvoPC61oKThfdlAE1yWS0HcSinSGYme3yy5Fn8dfPAyF9rd/Fb6gPfJ7ok76ZB/jzSsm3vtpysSptbD0edzQ8CgCELv5Ic8rItLiOJIkiUclvqKgH8W1HtN091qOkcGrXs/7xuZkjUc00kPnWi20j7rX47tgfpB0xxkbvYQo1IsYnWjosybAx6hlin3Bjl1XFlWDg73etR39V+FK0dp4lUaEzAb0WuubYFYs5dIiNW2T8R1zoTL1qrrcE8voT89/g7l4rSHy3ee6QDpGrWQUZEarbkcMSz8FBjCcrJYiE/qkPdNk7/dTgmU6tjE4Qy5/xHpaMIkjt39arokf0pH/Tor+QAXQNOfXkJw==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(23010399003)(1800799024)(36860700016)(82310400026)(260925022911599003)(260925021911599003)(260925021311599003)(5023799004)(11063799006)(56012099006)(261022105027099003)(261022075727099003)(261021123027099003)(261021121427099003)(261009223327099003)(261009223027099003)(261009221727099003)(261009221227099003)(261009220027099003)(261102130727099003)(261102123227099003)(261026121527099003)(261026140227099003)(261028144727099003)(10067099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	y3tQQQOCi8Fs9dP8eeNqSIbQDxLYs3zOnvD2hikXh+sadsHQUSmU3b/H1klZTOmjbEyR52oX+myO0cxSPvrD7E9XgypJedUz4Xtgv5HjSL8y33nWIwJY1pTprQ4jghNovYH8MgEg7mcDWO/Jay2yOjt/ieNl+ogTJqvP2fvIjbImS40m4W99sZlKnDO+uP9dZ6c1+/Jq3fhq3fI776wVsVDJhLvzn3AUduL+CGIYyT8NuCrVbumqRsFqUPj1RDoBWUAK0coqiNTZRIuqxEMsHqAFS8yAqZXiUdKP7YU9f9phpcJvWhnk/S3/rqRzFJje1OeQRMQ7pafSP5gJIhQS2Q6V+nXV/jZGiasCxhuflu2Ap5BGOnqBKlnE+yQLEHR82icCgIBnfA4Yy0MBR8C0NyynNTQU/dgoegJvOeJTxayCxg28U0waeULJAC3Ecr/T
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2026 08:26:53.4235
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a0baa31-dd5b-4af5-ac2d-08df3bdfb681
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF0001885D.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7356

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

Map with DMA_ATTR_REQUIRE_COHERENT at create time, on hibernation
restore, and on unmap.

Signed-off-by: Honglei Huang <honghuan@amd.com>
---
 drivers/gpu/drm/virtio/Makefile          |   3 +-
 drivers/gpu/drm/virtio/virtgpu_drv.h     |  42 +++
 drivers/gpu/drm/virtio/virtgpu_object.c  |  22 ++
 drivers/gpu/drm/virtio/virtgpu_userptr.c | 350 +++++++++++++++++++++++
 4 files changed, 416 insertions(+), 1 deletion(-)
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
index 9df4c71173..a29429b415 100644
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
+	/* Protects @pages, @sgt and @dma_mapped. */
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
@@ -562,4 +594,14 @@ void virtio_gpu_vram_map_deferred(struct virtio_gpu_object_vram *vram);
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
index 0000000000..b860693255
--- /dev/null
+++ b/drivers/gpu/drm/virtio/virtgpu_userptr.c
@@ -0,0 +1,350 @@
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
+					  userptr->dma_dir,
+					  DMA_ATTR_REQUIRE_COHERENT);
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
+		dma_unmap_sgtable(dev, userptr->sgt, userptr->dma_dir,
+				  DMA_ATTR_REQUIRE_COHERENT);
+		userptr->dma_mapped = false;
+
+		ret = dma_map_sgtable(dev, userptr->sgt, userptr->dma_dir,
+				      DMA_ATTR_REQUIRE_COHERENT);
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
+	if (new_pinned > lock_limit && !capable(CAP_IPC_LOCK)) {
+		atomic64_sub(userptr->npages, &mm->pinned_vm);
+		mmdrop(mm);
+		ret = -ENOMEM;
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
+				      dir, DMA_ATTR_REQUIRE_COHERENT);
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

