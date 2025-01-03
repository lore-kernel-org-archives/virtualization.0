Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD97D1F943E
	for <virtualization@lists.linux.dev>; Fri,  3 Jan 2025 15:34:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735918466; cv=none; b=Lxctxe5vZIjDqqOj3JMDthy5FQNU7W1qezMJeUA8gwXxRzXX+S17bSqaULULkzlFofRuCOMkBn2hWiSYtSKvyEdidtC1DxmZYLkU1qcKWv5nw9JWftuxGof3f1Q7UnMP3oGRGRU0BaalAsN1TvRmUcuoObYa2Cg/iewr6r8bTjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735918466; c=relaxed/simple;
	bh=xn2XnoUAxGF5fBnToEc+sCRPvs/J4TDnuN6ThnJK9Hk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dORa47TG+Vc1GnQaH2KptzlGlaFQDYN6ZXJ9PpQU5GmtywfwAiQDokAY/Z6eMeDcTEgJPTLZYiXiqPjKAkf8WknCj7dnr36KxacZwHYuv2YFJWQr6FR5ZBOfk0lqzCe/0GeHIiAZozk+N/kAtKyUbxfCkHGiehKEL/o+KzgkAvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=KV71urnf; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="KV71urnf"
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 503ESK5n009438;
	Fri, 3 Jan 2025 07:34:13 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pfpt0220; bh=A
	bKFL/+fmQrsnry2qS4aKNUsFVS8dVADonreXKEs4hY=; b=KV71urnfXwpvVXGb3
	Yk1ADowiPcapwmjM4pWhXasENbcYhEvgMrjn3cr4vC5lyIBEjnEHQIHZt8Rb5jUw
	0YqzuJvkbcY18y5ivOkDTDg8j+GhLVnepD/CGzey/nwqh4mVOhwt67245U+28ahP
	jMhy56jmSeng/es7RoqGLWUYi6rkFwLjOuCJdM5b/zZ2G4cK8T2wrSpW09llW2jw
	cPpBA7uTpbZITeicVJ3boGE3AupM6U/X36PtG46e4kL+VFSqNoqKk4wJVu7VLARg
	0+ZUvIQfSUM/B49A86JOhcjCwOTWoY+qTHRtRlAp2TCF/tXuu/ryo80P7sN15syj
	+pjtQ==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 43xhp7g3ep-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 03 Jan 2025 07:34:12 -0800 (PST)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Fri, 3 Jan 2025 07:34:11 -0800
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Fri, 3 Jan 2025 07:34:11 -0800
Received: from localhost.localdomain (unknown [10.28.34.29])
	by maili.marvell.com (Postfix) with ESMTP id 8D99B3F704A;
	Fri,  3 Jan 2025 07:34:07 -0800 (PST)
From: Shijith Thotton <sthotton@marvell.com>
To: <jasowang@redhat.com>, <mst@redhat.com>, <virtualization@lists.linux.dev>
CC: Shijith Thotton <sthotton@marvell.com>, <dan.carpenter@linaro.org>,
        <eperezma@redhat.com>, <jerinj@marvell.com>,
        <linux-kernel@vger.kernel.org>, <ndabilpuram@marvell.com>,
        <schalla@marvell.com>, <skoteshwar@marvell.com>,
        <vattunuru@marvell.com>, <xuanzhuo@linux.alibaba.com>
Subject: [PATCH v5 3/4] virtio-pci: define type and header for PCI vendor data
Date: Fri, 3 Jan 2025 21:01:36 +0530
Message-ID: <20250103153226.1933479-3-sthotton@marvell.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250103153226.1933479-1-sthotton@marvell.com>
References: <20250103153226.1933479-1-sthotton@marvell.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: Fzos-ymnLcTpsnDGZqIaP39FLUSKW1tO
X-Proofpoint-GUID: Fzos-ymnLcTpsnDGZqIaP39FLUSKW1tO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01

Added macro definition for VIRTIO_PCI_CAP_VENDOR_CFG to identify the PCI
vendor data type in the virtio_pci_cap structure. Defined a new struct
virtio_pci_vndr_data for the vendor data capability header as per the
specification.

Acked-by: Jason Wang <jasowang@redhat.com>
Signed-off-by: Shijith Thotton <sthotton@marvell.com>
---
 include/uapi/linux/virtio_pci.h | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/include/uapi/linux/virtio_pci.h b/include/uapi/linux/virtio_pci.h
index 1beb317df1b9..8549d4571257 100644
--- a/include/uapi/linux/virtio_pci.h
+++ b/include/uapi/linux/virtio_pci.h
@@ -116,6 +116,8 @@
 #define VIRTIO_PCI_CAP_PCI_CFG		5
 /* Additional shared memory capability */
 #define VIRTIO_PCI_CAP_SHARED_MEMORY_CFG 8
+/* PCI vendor data configuration */
+#define VIRTIO_PCI_CAP_VENDOR_CFG	9
 
 /* This is the PCI capability header: */
 struct virtio_pci_cap {
@@ -130,6 +132,18 @@ struct virtio_pci_cap {
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

