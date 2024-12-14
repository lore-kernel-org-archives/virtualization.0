Received: from mx0a-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A0A31474DA
	for <virtualization@lists.linux.dev>; Sat, 14 Dec 2024 07:12:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734160346; cv=none; b=RNixuKXCBv4A1+EfrZbHr5uM4pAWoYqCfxHrLdKwNKKBq4lAniUDo/M1kFwVk2XmBT1cEaymhEhJK3DthwBNMkzFSMeTRIy3pfSn7+7MzCqhjUX6LVgtxcRD5cdNAR2xbUix+QC7eFHMJ6fnx4epv7a7Uw3s30S8cfKfP7lvhHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734160346; c=relaxed/simple;
	bh=Ez13Kjp/L9qNV3BdePMl6QoKVEsXkDnV2UMb/Ltp2Jw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nqTNh/fBxR0SCWFl80wtyWScoec6VLMgrRS83v1eQ0DehttGZR6A3cGnsSnIbMLiESZFVmP4yMNcfAofXCJtTKEi/MafhtmXuCV3WOFRcPO1LLHCB4d+zQNQ6KnA1v11d79ZorxD71OHOGc1NeYFFkBmN8IK2xJuwIHGY0LP5IE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=Y801rhnU; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="Y801rhnU"
Received: from pps.filterd (m0431384.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BE6w9vr001670;
	Fri, 13 Dec 2024 23:12:17 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pfpt0220; bh=T
	VJVwveGkARNTy76ixv6f9ER/XHuBSXiqQd8oSqG+kg=; b=Y801rhnUTRQ+AdrTn
	LqfC7apLrPx1Lyxl7XR2PnOlTKBRZAIhPDgmLZJxgOGk8GKG3WbSo+ViLRjnD8St
	oSdAB/QAZKsAIz2CMgolW2QEi/9dyV49ukIE7ErPvN1xENGB+MyI+h7+/I9ACWnN
	+bxKF5vaGv+tyBzPZU+SsqqFdC3SXdWhFcNIxYHMHV88h6B5mTY1QkuYWPCM7Vn2
	Pg8DDTn/SlusrUhZJ1qaNRb6YDQV86EsBMELsDhyGWbUtkx2NT/Z9fmH2GTZK6bn
	75j+K7ZsL51S4SzNmuONSJaxbWKhst/XYr4+wlK6nPPqO6en6QER06SSYyQyKcE7
	G492g==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 43h2y8g9t0-3
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 13 Dec 2024 23:12:17 -0800 (PST)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Fri, 13 Dec 2024 23:12:08 -0800
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Fri, 13 Dec 2024 23:12:08 -0800
Received: from localhost.localdomain (unknown [10.28.34.29])
	by maili.marvell.com (Postfix) with ESMTP id 54CB43F704C;
	Fri, 13 Dec 2024 23:12:05 -0800 (PST)
From: Shijith Thotton <sthotton@marvell.com>
To: <virtualization@lists.linux.dev>, <mst@redhat.com>, <jasowang@redhat.com>,
        <dan.carpenter@linaro.org>
CC: Shijith Thotton <sthotton@marvell.com>, <schalla@marvell.com>,
        <vattunuru@marvell.com>, <ndabilpuram@marvell.com>,
        <jerinj@marvell.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
        =?UTF-8?q?Eugenio=20P=C3=A9rez?=
	<eperezma@redhat.com>,
        open list <linux-kernel@vger.kernel.org>
Subject: [PATCH v4 3/4] virtio-pci: define type and header for PCI vendor data
Date: Sat, 14 Dec 2024 12:36:06 +0530
Message-ID: <20241214070835.568818-3-sthotton@marvell.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241214070835.568818-1-sthotton@marvell.com>
References: <20241214070835.568818-1-sthotton@marvell.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: SciZh_vIe-G5eMmQyKLBaRSCgMqW4yuI
X-Proofpoint-ORIG-GUID: SciZh_vIe-G5eMmQyKLBaRSCgMqW4yuI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.687,Hydra:6.0.235,FMLib:17.0.607.475
 definitions=2020-10-13_15,2020-10-13_02,2020-04-07_01

Added macro definition for VIRTIO_PCI_CAP_VENDOR_CFG to identify the PCI
vendor data type in the virtio_pci_cap structure. Defined a new struct
virtio_pci_vndr_data for the vendor data capability header as per the
specification.

Signed-off-by: Shijith Thotton <sthotton@marvell.com>
---
 include/uapi/linux/virtio_pci.h | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/include/uapi/linux/virtio_pci.h b/include/uapi/linux/virtio_pci.h
index a8208492e822..20b4cd401887 100644
--- a/include/uapi/linux/virtio_pci.h
+++ b/include/uapi/linux/virtio_pci.h
@@ -115,6 +115,8 @@
 #define VIRTIO_PCI_CAP_PCI_CFG		5
 /* Additional shared memory capability */
 #define VIRTIO_PCI_CAP_SHARED_MEMORY_CFG 8
+/* PCI vendor data configuration */
+#define VIRTIO_PCI_CAP_VENDOR_CFG	9
 
 /* This is the PCI capability header: */
 struct virtio_pci_cap {
@@ -129,6 +131,18 @@ struct virtio_pci_cap {
 	__le32 length;		/* Length of the structure, in bytes. */
 };
 
+/* This is the PCI vendor data capability header: */
+struct virtio_pci_vndr_data {
+	__u8 cap_vndr;		/* Generic PCI field: PCI_CAP_ID_VNDR */
+	__u8 cap_next;		/* Generic PCI field: next ptr. */
+	__u8 cap_len;		/* Generic PCI field: capability length */
+	__u8 cfg_type;		/* Identifies the structure. */
+	__u16 vendor_id;	/* Identifies the vendor-specific format. */
+	/* For Vendor Definition */
+	/* Pads structure to a multiple of 4 bytes */
+	/* Reads must not have side effects */
+};
+
 struct virtio_pci_cap64 {
 	struct virtio_pci_cap cap;
 	__le32 offset_hi;             /* Most sig 32 bits of offset */
-- 
2.25.1

