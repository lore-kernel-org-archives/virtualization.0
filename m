Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 413F531A046
	for <virtualization@lists.linux.dev>; Tue, 21 Apr 2026 17:41:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.145.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776793316; cv=none; b=kGFBP6VXlEQYrLpV/B5CNGvtXHwx9iok7UzjOriDY8GrLpgAMPxymmtduS7LktzCYqTbG+bAGXkskbTvCYzqh4vw8joey02pxyeyIxpBTE0yjqHKK0Y2MPFDjtd2GStPvTwdWmjtOLfA5xB3YDE+gMweG93VLSoycbgHyHpbLN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776793316; c=relaxed/simple;
	bh=xUPasgzAbSUFDqqGtA58yvPl7VH549yECNW2GD83JH0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tn80NWCFY/0MdVGXcG7HD3dfpfyA0eApuKS+0Ig9kj6dJVcGGbL6kby4PCSIhiq+NOfr7scrWzR1my98MONygC9pbkarKAtGyc7aO8mjRlnfCsyyVpPWQAgHW35MX+3aAYMcUxvFtYtt7ovOhExwuDniwsMPxKE2Pohkk2rEU9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=nXmLfUQc; arc=none smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="nXmLfUQc"
Received: from pps.filterd (m0528008.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63L3inl52484155;
	Tue, 21 Apr 2026 10:41:52 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2025-q2;
	 bh=J4MxSxqjSZPP1i+2/Eh5i040MZ0tJP6IK9L1r31WPfU=; b=nXmLfUQcFem6
	/9d7jdznV8p+KtlSszaJ2CRp4NKw5beyHbwhRIfkkcIywBpIiTgYEp+KYnGsnO/1
	s3ANoLTmfQQLecg2VKti4djgBkhrOU01okwBl4D81HEX/XmHwBn4fFYNSEOw0Mp6
	eDKHWFdDsNAIZMnpttKSOEMg2stId4r40z6rASahl/u5+u4n7sveBy65PEZR5Ku5
	UJFaSoK64e7YPLW0X+908pOFeq7kXvGl6wH9NUc0QAdvFYIp8+fixUG2BAV4caaU
	lywhj5xBPxZMuTzqbCTy0baE46ak99I7BgGdyxTCJvTM4tfJVc2XDGZUy7RjYUuN
	e0pfIdMq+Q==
Received: from maileast.thefacebook.com ([163.114.135.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4dmxjgwr56-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Tue, 21 Apr 2026 10:41:51 -0700 (PDT)
Received: from localhost (2620:10d:c0a8:fe::f072) by mail.thefacebook.com
 (2620:10d:c0a9:6f::8fd4) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.37; Tue, 21 Apr
 2026 17:41:50 +0000
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
Subject: [PATCH 1/2] vfio/pci: Set up barmap in vfio_pci_core_enable()
Date: Tue, 21 Apr 2026 10:41:40 -0700
Message-ID: <20260421174143.3883579-2-mattev@meta.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260421174143.3883579-1-mattev@meta.com>
References: <20260421174143.3883579-1-mattev@meta.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: QWD-JWFoEOpiUsH1febIw1I4o5c29Ogq
X-Authority-Analysis: v=2.4 cv=WsIb99fv c=1 sm=1 tr=0 ts=69e7b6df cx=c_pps
 a=MfjaFnPeirRr97d5FC5oHw==:117 a=MfjaFnPeirRr97d5FC5oHw==:17
 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22 a=7x6HtfJdh03M6CCDgxCd:22
 a=_1IyUuN4QrATX339ibzo:22 a=VabnemYjAAAA:8 a=Vr1h0zdZU8zjlzJ6jfEA:9
 a=gKebqoRLp9LExxC7YDUY:22
X-Proofpoint-GUID: QWD-JWFoEOpiUsH1febIw1I4o5c29Ogq
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDIxMDE3NiBTYWx0ZWRfX4NTpRM+Jwe1L
 sXtuswAjloPwjuIloKMv7vV+H7vprk+w6AtiDiTfvuPCnwzi9AhK0zPQLNrojWxYaVzNyYpg2dE
 gH21JoxBD1mnRUnnWDcIgH/7YLkt9tiEfifXrm2uYVUIbdBTPDp40hcKKkdUKC39fUA49u+pAyr
 MiE0D2nklv3Kzo9D+z8a3KDIFO7i43mNKTErxBSaMNTIVzol+/NT6WuMz5uqtQxxJJIM24SOHHf
 RsomlAlhU2vilUAUHe1ho7oTdtEb34mSxq0Vd6nuXsmiFVpSHoKha64V0us4xrvjJMcKJjfv0EV
 cZhxWixRdISWmsjqftcfh/a1P7W9oBU43Uzcyh9ReX4gJdvjH4bYKm4UBqtLvPoucxgqR85hw3V
 fkJCWPhkpVUSmNUJON4HNaJSJFOHxef8LJtN398/YGVlsuHwDjJjwWgs1vnk3w5etMyWVjV95NV
 J6KJ+Xz3UB54fGIH4Sw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-21_03,2026-04-21_02,2025-10-01_01

The previous lazy-setup of the barmaps provided opportunities to
forget to do it (for example, DMABUF export).  Since all users will
ultimately require BAR resources to have been requested, request them
in vfio_pci_core_enable.

Existing calls to vfio_pci_core_setup_barmap() are now benign, but
remain because some callers use it to validate a BAR index.  This
fixes at least the case where DMABUF export could succeed before
resources were requested.

This keeps resource request and ioremap() done at the same time, but
in future the ioremap() could be done on-demand (not all VFIO users
need it).

Fixes: 7f5764e179c6 ("vfio: use vfio_pci_core_setup_barmap to map bar in mmap")
Fixes: 0d77ed3589ac0 ("vfio/pci: Pull BAR mapping setup from read-write path")
Signed-off-by: Matt Evans <mattev@meta.com>
---
 drivers/vfio/pci/vfio_pci_core.c | 63 +++++++++++++++++++++++++++-----
 drivers/vfio/pci/vfio_pci_rdwr.c | 25 +++----------
 2 files changed, 60 insertions(+), 28 deletions(-)

diff --git a/drivers/vfio/pci/vfio_pci_core.c b/drivers/vfio/pci/vfio_pci_core.c
index 3f8d093aacf8..4a314213f3ae 100644
--- a/drivers/vfio/pci/vfio_pci_core.c
+++ b/drivers/vfio/pci/vfio_pci_core.c
@@ -482,6 +482,55 @@ static int vfio_pci_core_runtime_resume(struct device *dev)
 }
 #endif /* CONFIG_PM */
 
+static void __vfio_pci_core_unmap_bars(struct vfio_pci_core_device *vdev)
+{
+	struct pci_dev *pdev = vdev->pdev;
+	int i;
+
+	for (i = 0; i < PCI_STD_NUM_BARS; i++) {
+		int bar = i + PCI_STD_RESOURCES;
+
+		if (!vdev->barmap[i])
+			continue;
+		pci_iounmap(pdev, vdev->barmap[bar]);
+		pci_release_selected_regions(pdev, 1 << bar);
+		vdev->barmap[bar] = NULL;
+	}
+}
+
+static int __vfio_pci_core_map_bars(struct vfio_pci_core_device *vdev)
+{
+	struct pci_dev *pdev = vdev->pdev;
+	int ret = 0;
+	int i;
+
+	/* Eager-request BAR resources (and iomap) */
+	for (i = 0; i < PCI_STD_NUM_BARS; i++) {
+		int bar = i + PCI_STD_RESOURCES;
+		void __iomem *io;
+
+		if (pci_resource_len(pdev, i) == 0)
+			continue;
+
+		ret = pci_request_selected_regions(pdev, 1 << bar, "vfio");
+		if (ret)
+			goto err_free_barmap;
+
+		io = pci_iomap(pdev, bar, 0);
+		if (!io) {
+			pci_release_selected_regions(pdev, 1 << bar);
+			ret = -ENOMEM;
+			goto err_free_barmap;
+		}
+		vdev->barmap[bar] = io;
+	}
+	return 0;
+
+err_free_barmap:
+	__vfio_pci_core_unmap_bars(vdev);
+	return ret;
+}
+
 /*
  * The pci-driver core runtime PM routines always save the device state
  * before going into suspended state. If the device is going into low power
@@ -568,6 +617,9 @@ int vfio_pci_core_enable(struct vfio_pci_core_device *vdev)
 	if (!vfio_vga_disabled() && vfio_pci_is_vga(pdev))
 		vdev->has_vga = true;
 
+	ret = __vfio_pci_core_map_bars(vdev);
+	if (ret)
+		goto out_free_zdev;
 
 	return 0;
 
@@ -591,7 +643,7 @@ void vfio_pci_core_disable(struct vfio_pci_core_device *vdev)
 	struct pci_dev *pdev = vdev->pdev;
 	struct vfio_pci_dummy_resource *dummy_res, *tmp;
 	struct vfio_pci_ioeventfd *ioeventfd, *ioeventfd_tmp;
-	int i, bar;
+	int i;
 
 	/* For needs_reset */
 	lockdep_assert_held(&vdev->vdev.dev_set->lock);
@@ -646,14 +698,7 @@ void vfio_pci_core_disable(struct vfio_pci_core_device *vdev)
 
 	vfio_config_free(vdev);
 
-	for (i = 0; i < PCI_STD_NUM_BARS; i++) {
-		bar = i + PCI_STD_RESOURCES;
-		if (!vdev->barmap[bar])
-			continue;
-		pci_iounmap(pdev, vdev->barmap[bar]);
-		pci_release_selected_regions(pdev, 1 << bar);
-		vdev->barmap[bar] = NULL;
-	}
+	__vfio_pci_core_unmap_bars(vdev);
 
 	list_for_each_entry_safe(dummy_res, tmp,
 				 &vdev->dummy_resources_list, res_next) {
diff --git a/drivers/vfio/pci/vfio_pci_rdwr.c b/drivers/vfio/pci/vfio_pci_rdwr.c
index 4251ee03e146..d1386a31a3a3 100644
--- a/drivers/vfio/pci/vfio_pci_rdwr.c
+++ b/drivers/vfio/pci/vfio_pci_rdwr.c
@@ -200,26 +200,13 @@ EXPORT_SYMBOL_GPL(vfio_pci_core_do_io_rw);
 
 int vfio_pci_core_setup_barmap(struct vfio_pci_core_device *vdev, int bar)
 {
-	struct pci_dev *pdev = vdev->pdev;
-	int ret;
-	void __iomem *io;
-
-	if (vdev->barmap[bar])
-		return 0;
-
-	ret = pci_request_selected_regions(pdev, 1 << bar, "vfio");
-	if (ret)
-		return ret;
-
-	io = pci_iomap(pdev, bar, 0);
-	if (!io) {
-		pci_release_selected_regions(pdev, 1 << bar);
-		return -ENOMEM;
-	}
-
-	vdev->barmap[bar] = io;
+	/*
+	 * The barmap is now always set up in vfio_pci_core_enable().
+	 * Some legacy callers use this function to check if the BAR
+	 * is legitimate, so maintain that:
+	 */
 
-	return 0;
+	return vdev->barmap[bar] ? 0 : -EBUSY;
 }
 EXPORT_SYMBOL_GPL(vfio_pci_core_setup_barmap);
 
-- 
2.47.3

