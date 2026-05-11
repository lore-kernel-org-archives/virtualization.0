Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01B033D47A8
	for <virtualization@lists.linux.dev>; Mon, 11 May 2026 14:59:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.153.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778511545; cv=none; b=c1kYT6y8lNmHrgUUFrMcGljdXDu7fqRvjtvs9e8kfPdYRlOIvUvYqEUgpYml3HfcgIBaW2ndYF3L79pyuChBVyLFFr8/8VEX/JzBt/zyby9iUPe5PeKTRVwFWSixHQ3/udfl5vIPk47ovPh+MjYXh2jIbVWVTzsGjtCfPAqo/AQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778511545; c=relaxed/simple;
	bh=U9AZqRqsPkBEbLgz08qAx/7KNRXfInRn/Yp7MxLBCbk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pN6FBDPZkX0sTePHWSmkccrtY0FuWkG8TdO/ZysqP84YwdyWDnb/ICYdAyr7bwXVe1y250utH3o5Pla/6hRZW7txyXw+6lq6Pnhawr2mXeg1SCBofwxpVK3LqS8Sireqhqu2TFehO5b1sM27ZZo6T/0AM0Y3RmpgMX3DNLfDUVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=RZm17Ewj; arc=none smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="RZm17Ewj"
Received: from pps.filterd (m0528005.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64BEvmxK1589792;
	Mon, 11 May 2026 07:58:59 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2025-q2;
	 bh=uh/fqGrNa5e0eFsOnebd5OIY5cvCMtHB5nxwnWVPhv8=; b=RZm17EwjpwXF
	La+Y9Mb0BuSpfGYTD/xW7FQ8JpNw3MGnOiI5PHg8jYM9/g3VsHkPD3OumppdeXSe
	EKAoe8J8dfy2cOnPfrMXQLj0TuZ6tDmsMT4oDQEMcs4ygm3vsr+6MhMGId1IV6ax
	r8g5dok0rPLU6r4UKxUz61YmZ7DDnuAFHBW4/5KRc0hvm1o/NUurUfDgTjEo509e
	DZGhmrBBtBK1QyLPT38Ahv6hZcL1mL5PVlMo1uECXg6pnbc8FVL2zIb1IOn4XXT6
	0VjfxDVYyKbGFP8w0HoR4qL+H9wuUrlLYbF5/nPeDb2doxOszDcWSQKORtJIbKoS
	AVuV5+vWZQ==
Received: from mail.thefacebook.com ([163.114.134.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4e2pgjeeqy-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Mon, 11 May 2026 07:58:59 -0700 (PDT)
Received: from localhost (2620:10d:c085:108::150d) by mail.thefacebook.com
 (2620:10d:c08b:78::2ac9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.37; Mon, 11 May
 2026 14:58:57 +0000
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
Subject: [PATCH v5 2/3] vfio/pci: Check BAR resources before exporting a DMABUF
Date: Mon, 11 May 2026 07:58:24 -0700
Message-ID: <20260511145829.2993601-3-mattev@meta.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260511145829.2993601-1-mattev@meta.com>
References: <20260511145829.2993601-1-mattev@meta.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: 54RNRLnUF1lY6K1K7ltrdrM5EUzRPpFp
X-Proofpoint-ORIG-GUID: 54RNRLnUF1lY6K1K7ltrdrM5EUzRPpFp
X-Authority-Analysis: v=2.4 cv=G8Qs1dk5 c=1 sm=1 tr=0 ts=6a01eeb3 cx=c_pps
 a=CB4LiSf2rd0gKozIdrpkBw==:117 a=CB4LiSf2rd0gKozIdrpkBw==:17
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=7x6HtfJdh03M6CCDgxCd:22
 a=jCddH8ec0KUNCymVuxII:22 a=VabnemYjAAAA:8 a=Cv6RvFvLZYHFA_XSKfkA:9
 a=gKebqoRLp9LExxC7YDUY:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTExMDE2NCBTYWx0ZWRfX974LmLLfTcX7
 QvvMuVNyXjUc5yVyQ/+Yi30yqdEC/pLWLbfi7cy+HgjiWK9bEirZZ3iTEs1vvp3RqIMDscXOW2a
 oLywU98esJolfZx0+/rW4gN0yVJRP3rAOTC2Q87OqqYA0eAwXIWMW9VGRgQoTuRVVZTs2dWGOso
 0B0GSof2mvglRFZ1aKDDZGHW6PPm1ipU7efScTFXfkvnDGaYjinGuXWip+mww6aRy8pKjZNjil7
 ljNbmcmt78rJVtlK0xoftAITcaiiK9qswKOSBtRNxxapJJVNwKu0l1IFu6flje7TR1nIt7lHqlc
 JZAPZoeDGWgGmRD2XFUOjm4bdFCaNLa/eaADVBO4nVs4firugFzWPEtwJSs3/Ugy3VfSNhP23OP
 w3lhwXYtZ6DrlebtXoK/V6kM68XM9A0QgDkYgl58PmhB8OSYvAYdEM7LUj5byKDy6HHQK76rcE9
 neVPe/K7r5bXkk4mvtQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-11_04,2026-05-08_02,2025-10-01_01

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
index f87fd32e4a01..69a5c2d511e6 100644
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
+	    vfio_pci_core_setup_barmap(vdev, get_dma_buf.region_index))
 		return -ENODEV;
 
 	dma_ranges = memdup_array_user(&arg->dma_ranges, get_dma_buf.nr_ranges,
-- 
2.47.3

