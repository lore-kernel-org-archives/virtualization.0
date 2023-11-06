Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38BA7C4167D
	for <virtualization@archiver.kernel.org>; Mon,  6 Nov 2023 07:14:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id E76F9822A3;
	Mon,  6 Nov 2023 07:14:14 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org E76F9822A3
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Pdvq3G9o
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id T9y1KjLiwrww; Mon,  6 Nov 2023 07:14:14 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 6F81F8229E;
	Mon,  6 Nov 2023 07:14:13 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 6F81F8229E
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 585CEC0071;
	Mon,  6 Nov 2023 07:14:13 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 315B3C008C
 for <virtualization@lists.linux-foundation.org>;
 Mon,  6 Nov 2023 07:14:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id E9D45610CF
 for <virtualization@lists.linux-foundation.org>;
 Mon,  6 Nov 2023 07:14:11 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org E9D45610CF
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=Pdvq3G9o
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 0ABcAfyUw2XN
 for <virtualization@lists.linux-foundation.org>;
 Mon,  6 Nov 2023 07:14:11 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 4D9F2610CE
 for <virtualization@lists.linux-foundation.org>;
 Mon,  6 Nov 2023 07:14:11 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 4D9F2610CE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1699254851; x=1730790851;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=JXrcRndberQgWoGawVfq93WylWTuPjjrsB1zsCyDKUk=;
 b=Pdvq3G9oshsK/10S7GAfl+yak1B80KtayzriiEpXy+JD8IR8QmZarkj+
 1GooCPhIB0OoS04T0mB9PgJoaiPGjdxWCEoT714ujaABCR369/0Evj3Ot
 A6MnCHgwx0t3GrcK330ROjNsjD6c7fYeT6XIxmiz/1CrjRZARBWjWCC/F
 Mrmk/5YXn9vRQkQodY26VRH2ASWb085Jw5ywtk4u4mFouRIHK8XED0xkC
 Dt+Llx2haVlsbuGO4C1kRhn6iHg96ZfjGrNc8EjSupLwBZJE+ZgCSDE2C
 +jShQeNsmNGjCh/oAOKLYu4UIjZm22lBTFQFWAToT7oxcPkCyI+jVCdXH Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10885"; a="10759077"
X-IronPort-AV: E=Sophos;i="6.03,280,1694761200"; d="scan'208";a="10759077"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
 by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Nov 2023 23:14:11 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10885"; a="1093690912"
X-IronPort-AV: E=Sophos;i="6.03,280,1694761200"; d="scan'208";a="1093690912"
Received: from sqa-gate.sh.intel.com (HELO localhost.localdomain)
 ([10.239.48.212])
 by fmsmga005.fm.intel.com with ESMTP; 05 Nov 2023 23:14:07 -0800
From: Tina Zhang <tina.zhang@intel.com>
To: Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Kevin Tian <kevin.tian@intel.com>, Lu Baolu <baolu.lu@linux.intel.com>,
 joro@8bytes.org, will@kernel.org, Yi Liu <yi.l.liu@intel.com>
Subject: [RFC PATCH 5/5] iommu/virtio-iommu: Support attaching VT-d IO pgtable
Date: Mon,  6 Nov 2023 02:12:26 -0500
Message-Id: <20231106071226.9656-6-tina.zhang@intel.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20231106071226.9656-1-tina.zhang@intel.com>
References: <20231106071226.9656-1-tina.zhang@intel.com>
MIME-Version: 1.0
Cc: iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org
X-BeenThere: virtualization@lists.linux-foundation.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: Linux virtualization <virtualization.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>, 
 <mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>, 
 <mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

Add VT-d IO page table support to ATTACH_TABLE request.

Signed-off-by: Tina Zhang <tina.zhang@intel.com>
---
 drivers/iommu/virtio-iommu.c      | 23 +++++++++++++++++++++++
 include/uapi/linux/virtio_iommu.h | 26 ++++++++++++++++++++++++++
 2 files changed, 49 insertions(+)

diff --git a/drivers/iommu/virtio-iommu.c b/drivers/iommu/virtio-iommu.c
index b1ceaac974e2..b02eeb1d27a4 100644
--- a/drivers/iommu/virtio-iommu.c
+++ b/drivers/iommu/virtio-iommu.c
@@ -991,12 +991,25 @@ static int viommu_attach_pgtable(struct viommu_domain *vdomain,
 	};
 
 	/* TODO: bypass flag? */
+	if (vdomain->bypass == true)
+		return 0;
 
 	switch (fmt) {
 	case VIRT_IO_PGTABLE:
 		req.format = cpu_to_le16(VIRTIO_IOMMU_FORMAT_PGTF_VIRT);
 		req.pgd = cpu_to_le64((u64)cfg->virt.pgd);
 		break;
+	case INTEL_IOMMU: {
+		struct virtio_iommu_req_attach_pgt_vtd *vtd_req =
+			(struct virtio_iommu_req_attach_pgt_vtd *)&req;
+
+		vtd_req->format = cpu_to_le16(VIRTIO_IOMMU_FORMAT_PGTF_VTD);
+		vtd_req->pgd = cpu_to_le64((u64)cfg->virt.pgd);
+		vtd_req->addr_width = cpu_to_le32(cfg->oas);
+		vtd_req->pasid = IOMMU_NO_PASID;
+		break;
+	}
+
 	default:
 		return -EINVAL;
 	};
@@ -1034,6 +1047,16 @@ static int viommu_setup_pgtable(struct viommu_domain *vdomain,
 	case VIRTIO_IOMMU_FORMAT_PGTF_VIRT:
 		fmt = VIRT_IO_PGTABLE;
 		break;
+	case VIRTIO_IOMMU_FORMAT_PGTF_VTD:
+	{
+		struct virtio_iommu_probe_pgt_vtd *vtd_desc =
+			(struct virtio_iommu_probe_pgt_vtd *)desc;
+
+		cfg.vtd_cfg.cap_reg = le64_to_cpu(vtd_desc->cap_reg);
+		cfg.vtd_cfg.ecap_reg = le64_to_cpu(vtd_desc->ecap_reg);
+		fmt = INTEL_IOMMU;
+		break;
+	}
 	default:
 		dev_warn(vdev->dev, "unsupported page table format 0x%x\n",
 			 le16_to_cpu(desc->format));
diff --git a/include/uapi/linux/virtio_iommu.h b/include/uapi/linux/virtio_iommu.h
index 656be1f3d926..17e0d5fcdd54 100644
--- a/include/uapi/linux/virtio_iommu.h
+++ b/include/uapi/linux/virtio_iommu.h
@@ -139,6 +139,22 @@ struct virtio_iommu_req_attach_pgt_virt {
 	struct virtio_iommu_req_tail		tail;
 };
 
+/* Vt-d I/O Page Table Descriptor */
+struct virtio_iommu_req_attach_pgt_vtd {
+	struct virtio_iommu_req_head		head;
+	__le32					domain;
+	__le32					endpoint;
+	__le32					flags;
+	__le16					format;
+	__u8					reserved[2];
+	__le32					pasid;
+	__le64					pgd;
+	__le64                                  fl_flags;
+	__le32                                  addr_width;
+	__u8					reserved2[36];
+	struct virtio_iommu_req_tail		tail;
+};
+
 #define VIRTIO_IOMMU_MAP_F_READ			(1 << 0)
 #define VIRTIO_IOMMU_MAP_F_WRITE		(1 << 1)
 #define VIRTIO_IOMMU_MAP_F_MMIO			(1 << 2)
@@ -224,6 +240,8 @@ struct virtio_iommu_probe_pasid_size {
 #define VIRTIO_IOMMU_FORMAT_PSTF_ARM_SMMU_V3	2
 /* Virt I/O page table format */
 #define VIRTIO_IOMMU_FORMAT_PGTF_VIRT		3
+/* VT-d I/O page table format */
+#define VIRTIO_IOMMU_FORMAT_PGTF_VTD		4
 
 struct virtio_iommu_probe_table_format {
 	struct virtio_iommu_probe_property	head;
@@ -231,6 +249,14 @@ struct virtio_iommu_probe_table_format {
 	__u8					reserved[2];
 };
 
+struct virtio_iommu_probe_pgt_vtd {
+	struct virtio_iommu_probe_property	head;
+	__le16					format;
+	__u8					reserved[2];
+	__le64					cap_reg;
+	__le64					ecap_reg;
+};
+
 struct virtio_iommu_req_probe {
 	struct virtio_iommu_req_head		head;
 	__le32					endpoint;
-- 
2.39.3

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
