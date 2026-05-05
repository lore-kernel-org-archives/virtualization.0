Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9871848C3FE
	for <virtualization@lists.linux.dev>; Tue,  5 May 2026 17:39:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.153.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778002762; cv=none; b=MplX+Rn9vYweSlhYTw0kNyQlraoIpGGKgN9UMxKPC9F+jYsgjW/kfEU7bX2wu3dUaKnrySO7vtsLZv4lJMFndKBNbcXLEnDSC19/mrOjYvTd2cIj71EXg94u6YqrhPcX/pUg9bel9JP7LwgIMNBYBduj4RvaAbU45Hs8IpbSjFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778002762; c=relaxed/simple;
	bh=cdIbyasj3bE8oaLmSjNsZSSPQso4bqF1HQNzAL50cF4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eGjRZ9ZU+DzUFiMgdbaCFUlcXIKLRe1Vae1jYwsViUiAxxy1+ChwrZDrsKWCTMhZ5QpB5KWtLkZU022CFcenvY5h2vyBygo0JvR7H6vD8xhvxV3vRKvNXgKxW1uH4aT2n5g43unVQxTqfxwTokw2wBtX948KoRXOCzeixV/+PlY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=JREfTG8q; arc=none smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="JREfTG8q"
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 645EFpe63475823;
	Tue, 5 May 2026 10:39:16 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2025-q2;
	 bh=eAzBiKS6rhPKrlXRfIUEzHJ+MYgbJC8zmQmMJ/NUXZA=; b=JREfTG8qKzZ9
	IeRl0IF2RuUEmVADQFl+zly9/pi/tSuMrHGEkn+0EfQPTKYBv+WQRMg5sadfntBK
	PjpPDzIPMyHG03tMIRMP1MJCG4Wf/rNAbS+kNSwzMkNTEtBowJNyX3fV9y5xlIer
	+KHBj8DC7ayzs1KQI1IQLfcfg9UBCx4d4OXLr2lDgoD0bobdhpRXE+BKXCwfSyvR
	x2cCX+cglYrYLEidGHcFbu8yRQo5YGukm0ZTjVekplLz0IBg5KN4tedNmVV3ngha
	mSVe+yhNKqBWmcF+UU+zpkOxm+LGf7xxdc1C9lpukY6jWLYFr1+fsWQRBNcyAcY3
	LUD73DrJmg==
Received: from maileast.thefacebook.com ([163.114.135.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4dwf0da7en-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Tue, 05 May 2026 10:39:16 -0700 (PDT)
Received: from localhost (2620:10d:c0a8:1c::11) by mail.thefacebook.com
 (2620:10d:c0a9:6f::237c) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.37; Tue, 5 May
 2026 17:39:02 +0000
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
Subject: [PATCH v4 1/3] vfio/pci: Set up BAR resources and maps in vfio_pci_core_enable()
Date: Tue, 5 May 2026 10:38:29 -0700
Message-ID: <20260505173835.2324179-2-mattev@meta.com>
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
X-Authority-Analysis: v=2.4 cv=Y7LIdBeN c=1 sm=1 tr=0 ts=69fa2b44 cx=c_pps
 a=MfjaFnPeirRr97d5FC5oHw==:117 a=MfjaFnPeirRr97d5FC5oHw==:17
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=7x6HtfJdh03M6CCDgxCd:22
 a=xtH7KyWI9dI7BmFOsl-x:22 a=VabnemYjAAAA:8 a=Lb-xxqHfFU9yCMAFiGgA:9
 a=gKebqoRLp9LExxC7YDUY:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA1MDE3MSBTYWx0ZWRfXx/2HVgpJlSGu
 p0N/PTee24IBpy36Gxv6qPoRLGVay8WVEy+y7q3a3QezY/T2rjFeNtU4shIERjSsNnJUKsvLNZ/
 KOMhnysXS2hU0qxD6J66x2137oUeedZfYq+xFJuJjTuxtV5m4I9g335pElgMTUb3gI9PK3NWbta
 Voa8OPHnMBCnEaV8SihPDSCgleH/3UbNJJZvK1LvOjko5/8YQh8FitEfPc65cRpgD7AewKcjG4X
 sZLmzTyoQgdi6SViiFZjdznExir7VeWycM45ttUBJv+L+3BmvFLY1rrWPY5RUhm5TbpISJWOzeL
 qnL26xcbXBW3LJe6tCuBs91mQysbepC+nE3vMaI1vwH8s5McTr/+V4BiA/7WT79M8B0v2why2t3
 0XgKhNa2xz/5uzSEUBrJw3ViOKs9WPS5a20/6xJooH3Ld0/En0EdJCScC9seKLs4D5T3kNyECuq
 abKfgYk+pfK+rj1G2FQ==
X-Proofpoint-ORIG-GUID: 63jDhWEiX67aPNdyIvX9abbKanKiFK8I
X-Proofpoint-GUID: 63jDhWEiX67aPNdyIvX9abbKanKiFK8I
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-05_02,2026-04-30_02,2025-10-01_01

Previously BAR resource requests and the corresponding pci_iomap()
were performed on-demand and without synchronisation, which was racy.
Rather than add synchronisation, it's simplest to address this by
doing both activities from vfio_pci_core_enable().

The resource allocation and/or pci_iomap() can still fail; their
status is tracked and existing calls to vfio_pci_core_setup_barmap()
will fail in a similar way to before.  This keeps the point of failure
as observed by userspace the same, i.e. failures to request/map unused
BARs are benign.

Fixes: 89e1f7d4c66d ("vfio: Add PCI device driver")
Signed-off-by: Matt Evans <mattev@meta.com>
---
 drivers/vfio/pci/vfio_pci_core.c | 36 +++++++++++++++++++++++++++++++-
 drivers/vfio/pci/vfio_pci_rdwr.c | 26 +++++++----------------
 2 files changed, 42 insertions(+), 20 deletions(-)

diff --git a/drivers/vfio/pci/vfio_pci_core.c b/drivers/vfio/pci/vfio_pci_core.c
index 3f8d093aacf8..62931dc381d8 100644
--- a/drivers/vfio/pci/vfio_pci_core.c
+++ b/drivers/vfio/pci/vfio_pci_core.c
@@ -482,6 +482,39 @@ static int vfio_pci_core_runtime_resume(struct device *dev)
 }
 #endif /* CONFIG_PM */
 
+/*
+ * Eager-request BAR resources, and iomap them.  Soft failures are
+ * allowed, and consumers must check the barmap before use in order to
+ * give compatible user-visible behaviour with the previous on-demand
+ * allocation method.
+ */
+static void vfio_pci_core_map_bars(struct vfio_pci_core_device *vdev)
+{
+	struct pci_dev *pdev = vdev->pdev;
+	int i;
+
+	for (i = 0; i < PCI_STD_NUM_BARS; i++) {
+		int bar = i + PCI_STD_RESOURCES;
+
+		vdev->barmap[bar] = ERR_PTR(-ENODEV);
+
+		if (!pci_resource_len(pdev, i))
+			continue;
+
+		if (pci_request_selected_regions(pdev, 1 << bar, "vfio")) {
+			pci_dbg(vdev->pdev, "Failed to reserve region %d\n", bar);
+			vdev->barmap[bar] = ERR_PTR(-EBUSY);
+			continue;
+		}
+
+		vdev->barmap[bar] = pci_iomap(pdev, bar, 0);
+		if (!vdev->barmap[bar]) {
+			pci_dbg(vdev->pdev, "Failed to iomap region %d\n", bar);
+			vdev->barmap[bar] = ERR_PTR(-ENOMEM);
+		}
+	}
+}
+
 /*
  * The pci-driver core runtime PM routines always save the device state
  * before going into suspended state. If the device is going into low power
@@ -568,6 +601,7 @@ int vfio_pci_core_enable(struct vfio_pci_core_device *vdev)
 	if (!vfio_vga_disabled() && vfio_pci_is_vga(pdev))
 		vdev->has_vga = true;
 
+	vfio_pci_core_map_bars(vdev);
 
 	return 0;
 
@@ -648,7 +682,7 @@ void vfio_pci_core_disable(struct vfio_pci_core_device *vdev)
 
 	for (i = 0; i < PCI_STD_NUM_BARS; i++) {
 		bar = i + PCI_STD_RESOURCES;
-		if (!vdev->barmap[bar])
+		if (IS_ERR_OR_NULL(vdev->barmap[bar]))
 			continue;
 		pci_iounmap(pdev, vdev->barmap[bar]);
 		pci_release_selected_regions(pdev, 1 << bar);
diff --git a/drivers/vfio/pci/vfio_pci_rdwr.c b/drivers/vfio/pci/vfio_pci_rdwr.c
index 4251ee03e146..3bfbb879a005 100644
--- a/drivers/vfio/pci/vfio_pci_rdwr.c
+++ b/drivers/vfio/pci/vfio_pci_rdwr.c
@@ -198,27 +198,15 @@ ssize_t vfio_pci_core_do_io_rw(struct vfio_pci_core_device *vdev, bool test_mem,
 }
 EXPORT_SYMBOL_GPL(vfio_pci_core_do_io_rw);
 
+/*
+ * The barmap is set up in vfio_pci_core_enable().  Callers use this
+ * function to check that the BAR resources are requested or that the
+ * pci_iomap() was done.
+ */
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
-
+	if (IS_ERR(vdev->barmap[bar]))
+		return PTR_ERR(vdev->barmap[bar]);
 	return 0;
 }
 EXPORT_SYMBOL_GPL(vfio_pci_core_setup_barmap);
-- 
2.47.3

