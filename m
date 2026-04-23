Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEA912D8DC3
	for <virtualization@lists.linux.dev>; Thu, 23 Apr 2026 18:25:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.153.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776968749; cv=none; b=n+XUCvICTMbEBDLrCqBmVRKaDeITAGPnshKMnaocmWnriZ30LXAmHViRg01RJ9++2dRoic8nQpxhA0xQzz1MFNVGEzAsVyPmYe34PmafVud9h7CIoJ19VYmvsCPoo5XQDl0XPyPpvqcFqU7t7xRypuSB+rl8xuxDpUcYBjuPEpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776968749; c=relaxed/simple;
	bh=MWaaLFpeeq2xR+LuBLxRO6gRPD9oLC6FHTF40PcVw54=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=g1bZzTi1odDdkDTn3Q76OyJoVU5LVeRtkYIE//XAlo6yMYLN/p7PwlBnYathqCdXKJKnXXcqIuNdkqkd/+XUCf2zV+PZzSXMwAE5YgpVC4w++TbMeWO6j9G3nLmPFXXtJklM8hHNuRqp4UV54lQUKlCpj61D4qccSwlU7dZFx+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=JWriJUtS; arc=none smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="JWriJUtS"
Received: from pps.filterd (m0528004.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63NH8rSA2691363;
	Thu, 23 Apr 2026 11:25:43 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2025-q2;
	 bh=qNvhzshz8buvBXe3D62FiCWxbKMg+r/IzqcfUklWZZI=; b=JWriJUtSYhRI
	4sCVTTHNUZikVtRmVGYxClueIfqRNLBaQ4P+8BqVXQ+Vc2K+jcyza6TGJdw8BCs4
	xJssA1l9uG1VQL+WOJ4LexuBzR183VGvi5XO88QO8p+0Tq+vwmyz1AmOm7n01oJX
	Sf+CejS2VTL0c8tXUlsLelm57SF3L1CEQcqkm0zkD7j3BOJJZV/NbRIog19B5ma3
	c9onP5c0gQ6ZqQmGu8GuPPJJJW+RPRMz3puKNG/VtFGMO4/t1YcC5wbh4OXdnJ7v
	Nr/jCStwpyDTsMbrom+hbNzBVXsLHKgiW9w0SiT74+Zs74KhJTX0jyTIx8xijaC8
	gUcVn0MMSA==
Received: from mail.thefacebook.com ([163.114.134.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4dpepdpn0x-4
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Thu, 23 Apr 2026 11:25:43 -0700 (PDT)
Received: from localhost (2620:10d:c085:108::150d) by mail.thefacebook.com
 (2620:10d:c08b:78::2ac9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.37; Thu, 23 Apr
 2026 18:25:42 +0000
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
Subject: [PATCH v2 3/3] vfio/pci: Check BAR resources before exporting a DMABUF
Date: Thu, 23 Apr 2026 11:25:09 -0700
Message-ID: <20260423182517.2286030-4-mattev@meta.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260423182517.2286030-1-mattev@meta.com>
References: <20260423182517.2286030-1-mattev@meta.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: DBnoXmXyPEWZwTE6BsYpZQC0OyYVgKN_
X-Authority-Analysis: v=2.4 cv=Ov9/DS/t c=1 sm=1 tr=0 ts=69ea6427 cx=c_pps
 a=CB4LiSf2rd0gKozIdrpkBw==:117 a=CB4LiSf2rd0gKozIdrpkBw==:17
 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22 a=7x6HtfJdh03M6CCDgxCd:22
 a=GbPsI2Ihf5RTnMjR_gZv:22 a=VabnemYjAAAA:8 a=Cv6RvFvLZYHFA_XSKfkA:9
 a=gKebqoRLp9LExxC7YDUY:22
X-Proofpoint-ORIG-GUID: DBnoXmXyPEWZwTE6BsYpZQC0OyYVgKN_
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDIzMDE3OSBTYWx0ZWRfXws+yqIy52B/s
 toydUSzGVhd/VMlBo1hHPKnuv9QS0zBbMLpvXpKXZ/tUWykUW1N0f99zFm40eBNJR8VjSt4wUGM
 uCygZr8WJ0SZozFfsJqVCiFYbS0Q8dJoBInHFLRQf1ikFSYz0RLxIO67HJN/989fQLKCACZv/Us
 Ap+AuSGWc2JOP3TrdKmLsUqP2IX0BMTZ+f47m77Mk0/h2lpTTzFR0jGBcZ0FgPb+gV8N+82wgjg
 oDcn3WWb9iSJwab0zYA/6rdFrgw+gAI8t7/YC1YZkOmoVFRn8gV6lQp5z8eVZQY5n73PNUIaFHP
 owuWWQAAeoKvN4XO2oP+FBYmxt2Qg5LsLPUH0LHmmhKrZwBD7ylxuBDEotyhdsveaPXD2hiyLes
 QDYvxJGh84SHA2H0nZthEjdCh135gZcF5dosr0vS0iuGUWUfw4vsY/dTXsrs9siUIO8Wq3Mh8Xd
 AX0e6sbBM/ZjPR+zORg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-23_03,2026-04-21_02,2025-10-01_01

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
index f87fd32e4a01..9139198ae270 100644
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
+	    vfio_pci_core_check_bar_rsrc(vdev, get_dma_buf.region_index) != 0)
 		return -ENODEV;
 
 	dma_ranges = memdup_array_user(&arg->dma_ranges, get_dma_buf.nr_ranges,
-- 
2.47.3

