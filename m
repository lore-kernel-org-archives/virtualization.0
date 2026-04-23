Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55B5325A2BB
	for <virtualization@lists.linux.dev>; Thu, 23 Apr 2026 18:25:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.153.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776968744; cv=none; b=B8Nyx4zgO1eCxwpAA3DJEMOqmOZFmY8iDV1IgMw7FB5qql7qcDA3t3Eiw/cZrViuqisFjCvbmVMzmEcVL9rtsU1P9VlKWAXPiYwj3aOBSjhincefRata+jLOJIxYsCiXIyp04uhf6OoZT87JWkJhUkJOoqU/acoFvlCEbpJq+VA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776968744; c=relaxed/simple;
	bh=2Kh3WQw1w8i5k2sGtqTS7Vgt/AVxyI1lGB2Rr7Vp51o=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fbOGVkW5PXg/NQyaxxSFZATDpkl2qe6KLUnG0dnm6hh7HgZLdsnUeV3659brZ6kiv2LLVZqjAN1IMbfh2Hm+1riYTdVp00k+kvc/Y677NCqF62TwH9sjGH3/zlULuRFxbhNpnHrKbzJrv5vvUuihmGBrcjiFbbYt5Ef2fJeeLSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=djpgkP4F; arc=none smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="djpgkP4F"
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63NH8ebO2084353;
	Thu, 23 Apr 2026 11:25:37 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2025-q2;
	 bh=2NsjjNNKB1Sd5FL7ejXy198NJ9GNqDkeoa+SR5kpEdU=; b=djpgkP4FE0uJ
	jIdwhfAqCez2Y7irRd4FnNXzxpmmQ/dbIwB2kscSX1Cmdy6QroxI/0D+6GRihFn0
	ysaDFRVTDHxdXuEV111PoWwyaq4E1pAZa4mqbW6HpJaN+WldcR9X4ETa/y6Yd2PP
	mg0xXVrgwgJzBBk4yPSxLyTmG5eJrmn1u281gwam2iz0u8SU9kJT1CSu6Oc5B3vf
	X8R+DBKSiHWohimPK4iFhvv/5fMXrazXI05o7fOYufRguTHjulkdF6wK7nn8wJJ/
	WPAjZhHukDiLbhcHolo+kxWQWSQYCFdp+DPhZBeb1eTwhxzpsbbIFh/NHGIFQRqp
	aihnBd3unA==
Received: from maileast.thefacebook.com ([163.114.135.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4dpepapmp9-4
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Thu, 23 Apr 2026 11:25:37 -0700 (PDT)
Received: from localhost (2620:10d:c0a8:fe::f072) by mail.thefacebook.com
 (2620:10d:c0a9:6f::8fd4) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.37; Thu, 23 Apr
 2026 18:25:36 +0000
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
Subject: [PATCH v2 1/3] vfio/pci: Set up bar resources and maps in vfio_pci_core_enable()
Date: Thu, 23 Apr 2026 11:25:07 -0700
Message-ID: <20260423182517.2286030-2-mattev@meta.com>
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
X-Proofpoint-GUID: GtzOfmiZD38WzweTpNfw_eCl_1XRJ-Kb
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDIzMDE3OSBTYWx0ZWRfX8BfbJtcE23yC
 Ez33lUSXSAzpiHnYKyLtPJjGV5rmlup2DOSReIdwCAKN8QojHz7m1RCLBqosTtROe+cnYOzfnKG
 39cTGDqqqUv9+d7AKyUNmayCwbDv7FjrKCAnZG/yfH8++mT+I4IJMqOMnopgveraQlsLoIq+fsp
 n8Mw2nNRTsvXZwV+Gl4exLROQzEgsPJrwMfhVqQbOEmO+7uRcUZTYiDANj/w5OgKrHbgfT+iUOJ
 yvQBlUH4/uP9DHg8bpR9mFkXHLUDgeVVNb5OQtB7kJi+MwcgO/VoCemXkJdhMeql2Yxho6scgiZ
 PJfKVSNNPonywGtp1ql3PL05O2co20zIqwao/z/W2fL7+YYl8z3/UIGFRB4oKZE7YJlM0/0L7AY
 IBgAW9Fh98MKXvDVkFLDkcccIriuHE9uw78xWtUgoP7P2CsMnipkPFAxdOA4nIsCbCr6g0Mkv+Q
 JuRWuGQBXzpuC7hKHtA==
X-Proofpoint-ORIG-GUID: GtzOfmiZD38WzweTpNfw_eCl_1XRJ-Kb
X-Authority-Analysis: v=2.4 cv=GcknWwXL c=1 sm=1 tr=0 ts=69ea6421 cx=c_pps
 a=MfjaFnPeirRr97d5FC5oHw==:117 a=MfjaFnPeirRr97d5FC5oHw==:17
 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22 a=7x6HtfJdh03M6CCDgxCd:22
 a=wpfVPzegXHpEFt3DAXn9:22 a=VabnemYjAAAA:8 a=UfQzwJ_779yHtm4POjsA:9
 a=gKebqoRLp9LExxC7YDUY:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-23_03,2026-04-21_02,2025-10-01_01

Previously BAR resource requests and the corresponding pci_iomap()
were performed on-demand and without synchronisation, which was racy.
Rather than add synchronisation, it's simplest to address this by
doing both activities from vfio_pci_core_enable().

The resource allocation and/or pci_iomap() can still fail; their
status is tracked and existing calls to vfio_pci_core_setup_barmap()
will fail in the same way as before.  This keeps the point of failure
as observed by userspace the same, i.e. failures to request/map unused
BARs are benign.

Fixes: 7f5764e179c6 ("vfio: use vfio_pci_core_setup_barmap to map bar in mmap")
Fixes: 0d77ed3589ac0 ("vfio/pci: Pull BAR mapping setup from read-write path")
Signed-off-by: Matt Evans <mattev@meta.com>
---
 drivers/vfio/pci/vfio_pci_core.c | 61 +++++++++++++++++++++++++++-----
 drivers/vfio/pci/vfio_pci_rdwr.c | 29 ++++++---------
 include/linux/vfio_pci_core.h    |  1 +
 3 files changed, 64 insertions(+), 27 deletions(-)

diff --git a/drivers/vfio/pci/vfio_pci_core.c b/drivers/vfio/pci/vfio_pci_core.c
index 3f8d093aacf8..c59c61861d81 100644
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
+		if (vdev->barmap[bar])
+			pci_iounmap(pdev, vdev->barmap[bar]);
+		if (vdev->have_bar_resource[bar])
+			pci_release_selected_regions(pdev, 1 << bar);
+		vdev->barmap[bar] = NULL;
+		vdev->have_bar_resource[bar] = false;
+	}
+}
+
+static void __vfio_pci_core_map_bars(struct vfio_pci_core_device *vdev)
+{
+	struct pci_dev *pdev = vdev->pdev;
+	int i;
+
+	/*
+	 * Eager-request BAR resources, and iomap; soft failures are
+	 * allowed, and consumers must check before use.
+	 */
+	for (i = 0; i < PCI_STD_NUM_BARS; i++) {
+		int ret;
+		int bar = i + PCI_STD_RESOURCES;
+		void __iomem *io;
+
+		if (pci_resource_len(pdev, i) == 0)
+			continue;
+
+		ret = pci_request_selected_regions(pdev, 1 << bar, "vfio");
+		if (ret) {
+			pci_warn(vdev->pdev, "Failed to reserve region %d\n", bar);
+			continue;
+		}
+		vdev->have_bar_resource[bar] = true;
+
+		io = pci_iomap(pdev, bar, 0);
+		if (io)
+			vdev->barmap[bar] = io;
+		else
+			pci_warn(vdev->pdev, "Failed to iomap region %d\n", bar);
+	}
+}
+
 /*
  * The pci-driver core runtime PM routines always save the device state
  * before going into suspended state. If the device is going into low power
@@ -568,6 +617,7 @@ int vfio_pci_core_enable(struct vfio_pci_core_device *vdev)
 	if (!vfio_vga_disabled() && vfio_pci_is_vga(pdev))
 		vdev->has_vga = true;
 
+	 __vfio_pci_core_map_bars(vdev);
 
 	return 0;
 
@@ -591,7 +641,7 @@ void vfio_pci_core_disable(struct vfio_pci_core_device *vdev)
 	struct pci_dev *pdev = vdev->pdev;
 	struct vfio_pci_dummy_resource *dummy_res, *tmp;
 	struct vfio_pci_ioeventfd *ioeventfd, *ioeventfd_tmp;
-	int i, bar;
+	int i;
 
 	/* For needs_reset */
 	lockdep_assert_held(&vdev->vdev.dev_set->lock);
@@ -646,14 +696,7 @@ void vfio_pci_core_disable(struct vfio_pci_core_device *vdev)
 
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
index 4251ee03e146..bf7152316db4 100644
--- a/drivers/vfio/pci/vfio_pci_rdwr.c
+++ b/drivers/vfio/pci/vfio_pci_rdwr.c
@@ -200,25 +200,18 @@ EXPORT_SYMBOL_GPL(vfio_pci_core_do_io_rw);
 
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
+	/*
+	 * The barmap is now always set up in vfio_pci_core_enable().
+	 * Some legacy callers use this function to ensure the BAR
+	 * resources are requested, and others to ensure the
+	 * pci_iomap() was done, so check here:
+	 */
+	if (bar < 0 || bar >= PCI_STD_NUM_BARS)
+		return -EINVAL;
+	if (vdev->barmap[bar] == 0)
 		return -ENOMEM;
-	}
-
-	vdev->barmap[bar] = io;
-
+	if (!vdev->bar_has_rsrc[bar])
+		return -EBUSY;
 	return 0;
 }
 EXPORT_SYMBOL_GPL(vfio_pci_core_setup_barmap);
diff --git a/include/linux/vfio_pci_core.h b/include/linux/vfio_pci_core.h
index 2ebba746c18f..1f508b067d82 100644
--- a/include/linux/vfio_pci_core.h
+++ b/include/linux/vfio_pci_core.h
@@ -101,6 +101,7 @@ struct vfio_pci_core_device {
 	const struct vfio_pci_device_ops *pci_ops;
 	void __iomem		*barmap[PCI_STD_NUM_BARS];
 	bool			bar_mmap_supported[PCI_STD_NUM_BARS];
+	bool			have_bar_resource[PCI_STD_NUM_BARS];
 	u8			*pci_config_map;
 	u8			*vconfig;
 	struct perm_bits	*msi_perm;
-- 
2.47.3

