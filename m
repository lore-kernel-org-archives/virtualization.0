Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E1BE48BD5C
	for <virtualization@lists.linux.dev>; Tue,  5 May 2026 17:39:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.153.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778002762; cv=none; b=mU0Wqxp8dIXeo/z48/IN6+UxBIJsnCoFGbjgYdqYnKVPjT3YSi8PjbHKqrOP4Bq4oBtvU/A5TlpmjOqfUXSf/0aGVMLAKx1uMNkyV5CWFUJJZ0W/YLUZkMNccV5I6b7xE9mHN0MJHNfr79RZ0JhitLF2+LciKFwNuMiYV0uLlSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778002762; c=relaxed/simple;
	bh=U9AZqRqsPkBEbLgz08qAx/7KNRXfInRn/Yp7MxLBCbk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CAPc8c0PMhuU/nPJQxe3zuw7Z7+4eY5wUeo8sx6AELZoXsMtbPnq70CZA4e2f/+sqO1RKv4sZgrPtqXIzu4jRbB11Wd3hK5Y9Xl9bTWCBMq/FiiTVhZQnMyCO7JdDpplTmo+JJLDsf4cqOyHa9eqqkDtkPEKTSxit8yRlbB945E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=GGr7++A8; arc=none smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="GGr7++A8"
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 645EFpeA3475823;
	Tue, 5 May 2026 10:39:17 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2025-q2;
	 bh=uh/fqGrNa5e0eFsOnebd5OIY5cvCMtHB5nxwnWVPhv8=; b=GGr7++A8eaag
	bPEWiB1rUuHM2UXtPUJe8A7RnxJ0xj/zZVZY0HThM/tBQrdTf84i8I0IGdkY8wQb
	4vrlLtzKfCHrvFU1iGSHLjyRGnCNqiYrz7jYvWIsymzpgU4Ke9hJqbIBm3fh9+PT
	1f/unDIB9ftHcroUImMojhqrfHkag6ZFOwUBMseOcWE4YAf/qIeJujpSJBk1RNlG
	IK9BrJSewaiJ0S0mZjDzHny+Lhplw+7Ki8+ULVb0J9ObsIXl9Ss8HGyy1ZjxCNAJ
	Nj/l3Z1AVorMw+9TC4aZAWcwvexrdBO8pjxhUKqDFJvzmrVapRgvOYvnsXTorE/0
	sI2G1iFibA==
Received: from maileast.thefacebook.com ([163.114.135.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4dwf0da7en-5
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Tue, 05 May 2026 10:39:17 -0700 (PDT)
Received: from localhost (2620:10d:c0a8:1b::2d) by mail.thefacebook.com
 (2620:10d:c0a9:6f::237c) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.37; Tue, 5 May
 2026 17:39:07 +0000
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
Subject: [PATCH v4 2/3] vfio/pci: Check BAR resources before exporting a DMABUF
Date: Tue, 5 May 2026 10:38:30 -0700
Message-ID: <20260505173835.2324179-3-mattev@meta.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260505173835.2324179-1-mattev@meta.com>
References: <20260505173835.2324179-1-mattev@meta.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Authority-Analysis: v=2.4 cv=Y7LIdBeN c=1 sm=1 tr=0 ts=69fa2b45 cx=c_pps
 a=MfjaFnPeirRr97d5FC5oHw==:117 a=MfjaFnPeirRr97d5FC5oHw==:17
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=7x6HtfJdh03M6CCDgxCd:22
 a=xtH7KyWI9dI7BmFOsl-x:22 a=VabnemYjAAAA:8 a=Cv6RvFvLZYHFA_XSKfkA:9
 a=gKebqoRLp9LExxC7YDUY:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA1MDE3MSBTYWx0ZWRfX3fLIfbWENDof
 m8sQu9kI4FPzR81dqAI671KOuotCmCluSrwAtTOCjxgZsbZaTrrmdW2G3znMQ9ZEdNh7dzv1Swd
 31/zsgHNi38VOomhYZnZRzKco2eQeZzfahbu6nVgv8DHJXBtWnhvgMuJ7lkQf5bdmeo5RsmauvE
 6EpvchfRzBOXi9G616LHH1N1M3Dif43TIS2unx4k9b3HkBX/GqTFL91PwLUzfe8jdx+gJigcQkr
 W2txnyT/+LV8OeaG3slLsZbELo1Ek9iLyxf7KCa47R6hXLnNpz5LQz4izSOf3Pa1HIzJL6DlX6O
 Apb8JGjoPcWtJOF2bT6LmmxDR9y61QasAJkY2pr0rz4MBr8pXdHDGEt2YAg65OdPNPbmhCtqRa7
 CYlrzwjqmp3JiBWsS0b14hB6yiMpeWsroJ+v6iANLNagw5tGRocn2h9//i+FYOScW/626Hr5RL8
 XSiS1Gu3GdycgV2k12w==
X-Proofpoint-ORIG-GUID: K9nT45ckwPQPQtlToE3rEdpGmMpP9lEr
X-Proofpoint-GUID: K9nT45ckwPQPQtlToE3rEdpGmMpP9lEr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-05_02,2026-04-30_02,2025-10-01_01

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

