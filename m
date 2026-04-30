Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 043D63FBECA
	for <virtualization@lists.linux.dev>; Thu, 30 Apr 2026 10:03:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.153.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777543440; cv=none; b=lBOLYLRsLUO8azzw+ssCAs/h9imPRFycVGGiPbKZOoQBrs4C9MbOxcuk8sdl0LjpItbzYnSYaMa63sXMXlInhpM0sADgUw2BmQBS7VPJLdu76IBbkiSJY27NFqh0aIPWNr/xzGTDIYBs+BzjBwzktgnAHv7ToY0vEcuwfSgnW9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777543440; c=relaxed/simple;
	bh=tiaqkiNlSh5kxlvQ/zX0MVeZs4mlVA/Xf3/XPXUONHw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oFFf1mDesi3molXi0tOQ2yLyKAyd1W7nS4ffySvUq6mRPqh9ZcAWPjpWI/LTcUa0azc8jhJWlXoisSkz7xlMbaXhdUjN8mekocHRDxAvgoJlfsakLw6PcDjGhHjdZpk9uAwM7X0ZCKeLp81pWNo//kvWa62bwcFO5n10yG8sy7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=ipGV1Rfh; arc=none smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="ipGV1Rfh"
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63U2nbjG1981453;
	Thu, 30 Apr 2026 03:03:52 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2025-q2;
	 bh=hKh2yyKTwlsM0roCF1ei7q92UuuhNxf8ag6BveBAjpw=; b=ipGV1Rfhz7iZ
	3UMuiaaBcnMYGLm0MMVlbxZ485Qoi1D80eDUF6vaUm0Yr89SQVn97eZuqah/Gh/n
	gT5RZ1ASauuyY0mI3jMKob+WfoBwxVLBp0VvbyJ/l3hScOd0uJ2TGprEIInOyJHb
	Q3GZPxgjXvOHJo1ZZf01kEAOYv2JYsP7xSlZtDX6DKzmVa0GTLnvHnUkcQGX5iwb
	IXiUOsBl0mEcWlR7yy5/Mt2Si8RfI36VNHyF5m+zH5stIvoTLkSqsb1LJxCIpK6g
	FxqLZA7bGXA6b/MtRUMVNbnQeknA3fLpnWA3qDyiD3ILoYHK2uv/X8q/3JLDbWg7
	NVlBTDqnEg==
Received: from mail.thefacebook.com ([163.114.134.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4dru4frcg2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Thu, 30 Apr 2026 03:03:52 -0700 (PDT)
Received: from localhost (2620:10d:c085:108::150d) by mail.thefacebook.com
 (2620:10d:c08b:78::2ac9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.37; Thu, 30 Apr
 2026 10:03:51 +0000
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
Subject: [PATCH v3 1/3] vfio/pci: Set up bar resources and maps in vfio_pci_core_enable()
Date: Thu, 30 Apr 2026 03:03:20 -0700
Message-ID: <20260430100340.2787446-2-mattev@meta.com>
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
X-Proofpoint-GUID: pksXHTCoc5iXwp3w_zYX22Y0-MY-Bdoe
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDMwMDEwMCBTYWx0ZWRfX7e/DHJ4dfiDq
 r2dvxi4+Z0NghzOFAW5UOxQ2WS5gbHuqjH7QPMzHRmVJ8YMuugRH7EH2+FTi6NN4MRiETtDPwJi
 juYXLWD/RnXhV6kj6lgadDdlk740jmKtFOdeB/tEcoA9Bdup8hyK200t8JE8CKrkvEi41vQsr3L
 vDiSZMvuicXE1PpeEllGeXseV6yqYXJNkt1zCT0udsE1quXe3YubjieTWDkd3tLQHRqliyB4N3t
 RI4HsfcZbLfGERozOp5U40FP/Yur/4h2upsHFU1o+UhPBQVmQXMV7937PIIxvzQC9/yv3Ex50T/
 M08fTaszQWArRAhK+dO0SXaj3tWEveFin1oev7MescTZeitB3qveOAh2a4oadgX7Dvzfry29Zuo
 LbXTo5JOPAbYccgz++FiW5JVn5VdVgQiTiKIxHf4Een1431681ax3yJT2eUYctLiDqrFL5rgvTY
 584MNSREbJ0a3vqyugg==
X-Authority-Analysis: v=2.4 cv=WLdPmHsR c=1 sm=1 tr=0 ts=69f32908 cx=c_pps
 a=CB4LiSf2rd0gKozIdrpkBw==:117 a=CB4LiSf2rd0gKozIdrpkBw==:17
 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22 a=7x6HtfJdh03M6CCDgxCd:22
 a=JnKecZnUtZousrUlYMGU:22 a=VabnemYjAAAA:8 a=s4PiSZQpilcMNiFIlqwA:9
 a=gKebqoRLp9LExxC7YDUY:22
X-Proofpoint-ORIG-GUID: pksXHTCoc5iXwp3w_zYX22Y0-MY-Bdoe
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-30_03,2026-04-28_01,2025-10-01_01

Previously BAR resource requests and the corresponding pci_iomap()
were performed on-demand and without synchronisation, which was racy.
Rather than add synchronisation, it's simplest to address this by
doing both activities from vfio_pci_core_enable().

The resource allocation and/or pci_iomap() can still fail; their
status is tracked and existing calls to vfio_pci_core_setup_barmap()
will fail in a similar way to before.  This keeps the point of failure
as observed by userspace the same, i.e. failures to request/map unused
BARs are benign.

Fixes: 7f5764e179c6 ("vfio: use vfio_pci_core_setup_barmap to map bar in mmap")
Fixes: 0d77ed3589ac0 ("vfio/pci: Pull BAR mapping setup from read-write path")
Signed-off-by: Matt Evans <mattev@meta.com>
---
 drivers/vfio/pci/vfio_pci_core.c | 33 ++++++++++++++++++++++++++++++++
 drivers/vfio/pci/vfio_pci_rdwr.c | 29 ++++++++++++----------------
 2 files changed, 45 insertions(+), 17 deletions(-)

diff --git a/drivers/vfio/pci/vfio_pci_core.c b/drivers/vfio/pci/vfio_pci_core.c
index 3f8d093aacf8..eab4f2626b39 100644
--- a/drivers/vfio/pci/vfio_pci_core.c
+++ b/drivers/vfio/pci/vfio_pci_core.c
@@ -482,6 +482,38 @@ static int vfio_pci_core_runtime_resume(struct device *dev)
 }
 #endif /* CONFIG_PM */
 
+static void vfio_pci_core_map_bars(struct vfio_pci_core_device *vdev)
+{
+	struct pci_dev *pdev = vdev->pdev;
+	int i;
+
+	/*
+	 * Eager-request BAR resources, and iomap.  Soft failures are
+	 * allowed, and consumers must check the barmap before use in
+	 * order to give compatible user-visible behaviour with the
+	 * previous on-demand allocation method.
+	 */
+	for (i = 0; i < PCI_STD_NUM_BARS; i++) {
+		int bar = i + PCI_STD_RESOURCES;
+		void __iomem *io = ERR_PTR(-ENODEV);
+
+		if (pci_resource_len(pdev, i) > 0) {
+			if (pci_request_selected_regions(pdev, 1 << bar, "vfio")) {
+				pci_warn(vdev->pdev, "Failed to reserve region %d\n", bar);
+				io = ERR_PTR(-EBUSY);
+			} else {
+				io = pci_iomap(pdev, bar, 0);
+				if (!io) {
+					pci_warn(vdev->pdev, "Failed to iomap region %d\n",
+						 bar);
+					io = ERR_PTR(-ENOMEM);
+				}
+			}
+		}
+		vdev->barmap[bar] = io;
+	}
+}
+
 /*
  * The pci-driver core runtime PM routines always save the device state
  * before going into suspended state. If the device is going into low power
@@ -568,6 +600,7 @@ int vfio_pci_core_enable(struct vfio_pci_core_device *vdev)
 	if (!vfio_vga_disabled() && vfio_pci_is_vga(pdev))
 		vdev->has_vga = true;
 
+	vfio_pci_core_map_bars(vdev);
 
 	return 0;
 
diff --git a/drivers/vfio/pci/vfio_pci_rdwr.c b/drivers/vfio/pci/vfio_pci_rdwr.c
index 4251ee03e146..f66ad3d96481 100644
--- a/drivers/vfio/pci/vfio_pci_rdwr.c
+++ b/drivers/vfio/pci/vfio_pci_rdwr.c
@@ -200,25 +200,20 @@ EXPORT_SYMBOL_GPL(vfio_pci_core_do_io_rw);
 
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
+	/*
+	 * The barmap is set up in vfio_pci_core_enable().  Callers
+	 * use this function to check that the BAR resources are
+	 * requested or that the pci_iomap() was done.
+	 */
+	if (bar < 0 || bar >= PCI_STD_NUM_BARS)
+		return -EINVAL;
 
-	vdev->barmap[bar] = io;
+	/* Did vfio_pci_core_map_bars() set it up yet? */
+	if (!vdev->barmap[bar])
+		return -ENODEV;
 
+	if (IS_ERR(vdev->barmap[bar]))
+		return PTR_ERR(vdev->barmap[bar]);
 	return 0;
 }
 EXPORT_SYMBOL_GPL(vfio_pci_core_setup_barmap);
-- 
2.47.3

