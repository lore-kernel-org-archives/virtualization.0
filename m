Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C1582367CF
	for <virtualization@lists.linux.dev>; Wed, 15 Apr 2026 18:15:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.153.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776276949; cv=none; b=KRZVFIJP0Iea3W3FiWXzwkVhL0iA8obGGDOCY8+w8oR2K+mO2SDh3fwNsZ/toZjDLyDoR3HgC/BGYiTYvVl5eHektdBmsNDBPiFkc21uL1q8xSXf8LN5JzbwC7+mMREqJYvtjgyHiZ8ZKr2CdKUBl7p32wBds/5NYcHRkgoFDck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776276949; c=relaxed/simple;
	bh=9nJzwFXYXqdBdfxos7E2lzUNb/mwU+rQgpf6MgkOjbo=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Avnh7EraZUd8lLLM8Ybw85hXCYJX8kSdhEgpui6ap8aLj9g7D/ZWQDlE/x0enDl/Snzq7bdR+hapmdEBeSvzTB2V7Lz1iZ6KGWVeXYOZDUnJ17h0Khnv9aFyNOTgjypQiThXPQnI5TZTR1jGIgmImJOfPvmAsBVxK9DUeJ+w7PA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=f3g0hOQe; arc=none smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="f3g0hOQe"
Received: from pps.filterd (m0528005.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63F6Hxmc3772462;
	Wed, 15 Apr 2026 11:15:43 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=s2048-2025-q2; bh=8bgcvKjIdrV23RvSPQ
	yh9ajPyzn8ykMFAHnEekB0cQU=; b=f3g0hOQeTzPDeGDSbneJd9+YAWKfPpVfKu
	nhhwTDgOf46IN4Cle8D3L0Fspwnlhtv/ZevBrTHLaAxxUumooxjXiHDp3fSunnLq
	KLntTAOOt0HWO1VIrvNxDPyL+H/E8+M+LtlNpr+VLezHaDWI64UZGsY9iwI2nP2c
	EwNA28Ci01PT8P/FX3IcRRMvY8B32Yy9pL1bcAPJGT4wwOy0PBX2CyGseyNTSVkT
	boPDVI7HLX40pZ2CV7gQ5TP7vqW1tPKPmgh/1Up/2pmFWKn43oB9MRJkBt+UoMv4
	dLymBr7QLTasXHiu2TdV3xqGxeOCeKvyH86aJx2/z3gSMJ7qvRXQ==
Received: from mail.thefacebook.com ([163.114.134.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4dh84w5ad1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Wed, 15 Apr 2026 11:15:43 -0700 (PDT)
Received: from localhost (2620:10d:c085:108::150d) by mail.thefacebook.com
 (2620:10d:c08b:78::c78f) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.37; Wed, 15 Apr
 2026 18:15:42 +0000
From: Matt Evans <mattev@meta.com>
To: Alex Williamson <alex@shazbot.org>, Ankit Agrawal <ankita@nvidia.com>,
        Jason Gunthorpe <jgg@ziepe.ca>, Yishai Hadas <yishaih@nvidia.com>,
        Shameer
 Kolothum <skolothumtho@nvidia.com>,
        Kevin Tian <kevin.tian@intel.com>
CC: Alistair Popple <apopple@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
        Vivek Kasireddy <vivek.kasireddy@intel.com>,
        Kees Cook <kees@kernel.org>, Zhi
 Wang <zhiw@nvidia.com>,
        Peter Xu <peterx@redhat.com>, Alexey Kardashevskiy
	<aik@ozlabs.ru>,
        Eric Auger <eric.auger@redhat.com>, <kvm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <virtualization@lists.linux.dev>
Subject: [PATCH 1/2] vfio/pci: Set up VFIO barmap before creating a DMABUF
Date: Wed, 15 Apr 2026 11:14:22 -0700
Message-ID: <20260415181423.1008458-1-mattev@meta.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDE1MDE3MCBTYWx0ZWRfX8UrqErrmhMFT
 dQQkNuaZzVod2WXrLrUAtFi3R+1oZgTmlEx05FCQmYg5At3cmKRKAGpAJJCYCQ3Jc707spmM7R3
 F5StWVoye0QBKeZF0U41tB5WRH/ahy7J8wHX6UtZn/NHmKftbbZqLOKXwzUA7v5P6551YEwnNda
 53djGsd6NhMmdv3CCDsl0uSO9518ujrEFT/eyMOQXBXHbUdJ3QMKibzxPNRK8RUyJPlB3kictOO
 pb1JrQZR1NZi/0BXMuBHO31q7gktfDJQKh9omZqfYNKaP2Ut2NKF0EyqbksR9OMhUefuw+uStOg
 380fpbiREpuLkzSf/PMTnAqI/FRtve4pc5632F8jOEgX415tk0/QoTKhTfKLdr1zIdxpEhKR6Bl
 tCfV+JtFGp0EL4h4CNYrBTOnm+UOn5O7FC4dXviztXjRV3aoiJ6MTgVhQ3ixgVosiR2L2Ae20j0
 WZldSvrq+WlBaBVsGgg==
X-Proofpoint-ORIG-GUID: clRI_3kHylAE62rh2pqBRz5km45dHr8x
X-Proofpoint-GUID: clRI_3kHylAE62rh2pqBRz5km45dHr8x
X-Authority-Analysis: v=2.4 cv=cf7iaHDM c=1 sm=1 tr=0 ts=69dfd5cf cx=c_pps
 a=CB4LiSf2rd0gKozIdrpkBw==:117 a=CB4LiSf2rd0gKozIdrpkBw==:17
 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22 a=7x6HtfJdh03M6CCDgxCd:22
 a=jCddH8ec0KUNCymVuxII:22 a=VabnemYjAAAA:8 a=DkskzI1_-XwU4soQF-MA:9
 a=gKebqoRLp9LExxC7YDUY:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-15_01,2026-04-13_04,2025-10-01_01

A DMABUF exports access to BAR resources which need to be requested
before the DMABUF is handed out.  Usually the resources are requested
when setting up the barmap when the VFIO device fd is mmap()ed, but
there's no guarantee that's done before a DMABUF is created.

Set up the barmap (and so request resources) in the DMABUF-creation
path.

Fixes: 5d74781ebc86c ("vfio/pci: Add dma-buf export support for MMIO regions")
Signed-off-by: Matt Evans <mattev@meta.com>
---
 drivers/vfio/pci/vfio_pci_dmabuf.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/vfio/pci/vfio_pci_dmabuf.c b/drivers/vfio/pci/vfio_pci_dmabuf.c
index 4ccaf3531e02..fefe7cf4256b 100644
--- a/drivers/vfio/pci/vfio_pci_dmabuf.c
+++ b/drivers/vfio/pci/vfio_pci_dmabuf.c
@@ -272,6 +272,15 @@ int vfio_pci_core_feature_dma_buf(struct vfio_pci_core_device *vdev, u32 flags,
 		goto err_free_priv;
 	}
 
+	/*
+	 * See comment in vfio_pci_core_mmap(); ensure PCI regions
+	 * were requested before returning DMABUFs that reference
+	 * them.  Barmap setup does this:
+	 */
+	ret = vfio_pci_core_setup_barmap(vdev, get_dma_buf.region_index);
+	if (ret)
+		goto err_free_phys;
+
 	priv->vdev = vdev;
 	priv->nr_ranges = get_dma_buf.nr_ranges;
 	priv->size = length;
-- 
2.47.3

