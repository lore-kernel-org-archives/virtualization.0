Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1CBD3A7855
	for <virtualization@lists.linux.dev>; Thu, 30 Apr 2026 10:04:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.145.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777543445; cv=none; b=E1LjpFZUkIV1ASzLDP9DLRR+L9ALeUecXQbqp1YdHdcRqU/aWr+YLtY1bEyHiZE97UuVgjgEenTCjftxWX9wv7kui+qWcJ1FBzTgUkhDGt5OzAO1dOE6yJom4CCbiO4ZbVXIva+wZf8sXQPd10fHjeLaYybRpvA64dSP4ihK1zY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777543445; c=relaxed/simple;
	bh=1iGbaAKSe1uA8apN3oBgpPr44XSzoe6+bbAM3hi0qYE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PiiFIhMMVubDd0ozk/RbwHs51y/luckwM7t9GlYrRC62J7wkdMDdFn77PD6IH2ZDnEwJFpe+NV2Lq+ZiQB8Gk8rG3/fe7cD58nGyZ3FSNeGi7uoDMIvbz9u6eq7PPVjQmr2VwSWro0cR9HFIWn+5729Uc63C7cUZHvLrAoaDPxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=YmBIXFu/; arc=none smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="YmBIXFu/"
Received: from pps.filterd (m0528008.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63TFMHjB2529526;
	Thu, 30 Apr 2026 03:03:59 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2025-q2;
	 bh=6y5xPQjarSGEV+y856igX3W4+XZQDOVNzN2cIpOJfv4=; b=YmBIXFu/IBR/
	7U9n6cx/6lzIOIF9Bq+sFDB+sjrjMre5w5UsIE7qQEESry1Zo/JPjrQMSrDp1och
	U+vVtBsL2TDi7IvsBW7Q/4fGOyioQeBDRFgtgCejh0ePq2/SCoa0if5eZOk6d7xo
	3uZe9hdtuoEopKZrMUTwFtrak/dytZwSEvchkv1IALZQDM6afLJFQ0wuvHhZPl82
	sahH2gV/k8ZaAwXm63hdGjezAaQ58bJ2JE22aQQSypW0B+SvBDhNWfAlXqv0Fw08
	WqWeuIcFSo6ia099tq8NW4UL59LQwcNv0YShjpMU8t8ca3wpSDlMoJbUd0qDaqAj
	IpYU1Me6pg==
Received: from maileast.thefacebook.com ([163.114.135.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4dty68g8dj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Thu, 30 Apr 2026 03:03:58 -0700 (PDT)
Received: from localhost (2620:10d:c0a8:fe::f072) by mail.thefacebook.com
 (2620:10d:c0a9:6f::237c) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.37; Thu, 30 Apr
 2026 10:03:57 +0000
From: Matt Evans <mattev@meta.com>
To: Alex Williamson <alex@shazbot.org>, Kevin Tian <kevin.tian@intel.com>,
        Jason Gunthorpe <jgg@ziepe.ca>, Ankit Agrawal <ankita@nvidia.com>,
        Alistair
 Popple <apopple@nvidia.com>,
        Leon Romanovsky <leon@kernel.org>, Kees Cook
	<kees@kernel.org>,
        Shameer Kolothum <skolothumtho@nvidia.com>,
        Yishai Hadas
	<yishaih@nvidia.com>
CC: Alexey Kardashevskiy <aik@ozlabs.ru>, Eric Auger <eric.auger@redhat.com>,
        Peter Xu <peterx@redhat.com>,
        Vivek Kasireddy <vivek.kasireddy@intel.com>,
        Zhi Wang <zhiw@nvidia.com>, <kvm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <virtualization@lists.linux.dev>
Subject: [PATCH v3 3/3] vfio/pci: Check BAR resources before exporting a DMABUF
Date: Thu, 30 Apr 2026 03:03:22 -0700
Message-ID: <20260430100340.2787446-4-mattev@meta.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260430100340.2787446-1-mattev@meta.com>
References: <20260430100340.2787446-1-mattev@meta.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: 7W9HOYZL-GCC9RGL966pvYUOVVUmgvqi
X-Proofpoint-GUID: 7W9HOYZL-GCC9RGL966pvYUOVVUmgvqi
X-Authority-Analysis: v=2.4 cv=XbS5Co55 c=1 sm=1 tr=0 ts=69f3290e cx=c_pps
 a=MfjaFnPeirRr97d5FC5oHw==:117 a=MfjaFnPeirRr97d5FC5oHw==:17
 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22 a=7x6HtfJdh03M6CCDgxCd:22
 a=_1IyUuN4QrATX339ibzo:22 a=VabnemYjAAAA:8 a=Cv6RvFvLZYHFA_XSKfkA:9
 a=gKebqoRLp9LExxC7YDUY:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDMwMDEwMCBTYWx0ZWRfXynVzco6fl7gu
 wiT2yo6NFZ9QmshXN4+CLCYKen/PaeJSZYMkyXikY0l2EtSKlS363sibRcBth/exSEILPw3pC2Q
 bkvOgn9x5EpqTPdBCsfNTdQyKkTE6v5JUuUgt9bnv5TJs++jeiiIYeLGehoeGeV+urSeYsF6JXO
 51Uab29yej9alCiKeD20g9ufhovywPsIyGJVjvtVBvIOOPUrGxIifenjOTYsLCD4Oacsin/xJqo
 DWyE93ZbJEY75KxvjM4uee61WO5XCnDgU69VOehZYGyi7038Cf9DnYkl3M8hMI4L4RFCDZi3shF
 1M69nhaHiQiDKrQWaDd3R7QtRtT6m9tEEkf6n5Lu0w88YylKKa3fUHrPKqY5RlwZMrIa/xGI9md
 AOpMZOC5V89GZ8xKptzn6vijFTb8V5q+yXozCa9VZKiA4wc4+A/rk928IPQBQpA4BR3RjPo309O
 ni1+ZHCZIvGbjrQeOVw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-30_03,2026-04-28_01,2025-10-01_01

A DMABUF exports access to BAR resources and, although they are
requested at startup time, we need to ensure they really were reserved
before exporting.  Otherwise, it's possible to access unreserved
resources through the export.

Add a check to the DMABUF-creation path.

Fixes: 5d74781ebc86c ("vfio/pci: Add dma-buf export support for MMIO regions")
Signed-off-by: Matt Evans <mattev@meta.com>
---
 drivers/vfio/pci/vfio_pci_dmabuf.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/vfio/pci/vfio_pci_dmabuf.c b/drivers/vfio/pci/vfio_pci_dmabuf.c
index f87fd32e4a01..3bc7d850e258 100644
--- a/drivers/vfio/pci/vfio_pci_dmabuf.c
+++ b/drivers/vfio/pci/vfio_pci_dmabuf.c
@@ -244,9 +244,11 @@ int vfio_pci_core_feature_dma_buf(struct vfio_pci_core_device *vdev, u32 flags,
 		return -EINVAL;
 
 	/*
-	 * For PCI the region_index is the BAR number like everything else.
+	 * For PCI the region_index is the BAR number like everything
+	 * else.  Check that PCI resources have been claimed for it.
 	 */
-	if (get_dma_buf.region_index >= VFIO_PCI_ROM_REGION_INDEX)
+	if (get_dma_buf.region_index >= VFIO_PCI_ROM_REGION_INDEX ||
+	    !IS_ERR(vfio_pci_core_get_iomap(vdev, get_dma_buf.region_index)))
 		return -ENODEV;
 
 	dma_ranges = memdup_array_user(&arg->dma_ranges, get_dma_buf.nr_ranges,
-- 
2.47.3

