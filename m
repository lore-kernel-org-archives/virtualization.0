Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 324023FFAD2
	for <virtualization@lists.linux.dev>; Mon, 11 May 2026 14:58:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.145.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778511539; cv=none; b=sa+yAXBG3dIsFmOvoNGz4KNbj0hzxMlO0zUc0a69OiPVJPmhkw3GP8gxcJIdptAjgvKhfqYPjKZ/ak9ZMWhXZ4jSA7/qIrUM03ES6/7zj6PbZ7X570fQdFW+Xw+76j5vq5d6DDODE0kVwvvv32uZFpeqe4mSXrSe73K3sfO/zW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778511539; c=relaxed/simple;
	bh=DImIVzk4Fp/d0uKSX5Q013I75BODcyG03vsky99bTq0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CLoWgrT4JYfp7gslox2JJH9BlBouZWnKqKnr72qcaJUtEfEKEF1OVquSTp4EbNnYsz9O0j12FgbQV8XMl//T5owBSGGxUwGG8oixain3iSrl5GH992ZHiAi/UkGZksp/Bj9fHTyHdzEQ01m2GuR08MuO6YSIQofrliMcz4hXnMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=lvj2SSw9; arc=none smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="lvj2SSw9"
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64BEw5rj941942;
	Mon, 11 May 2026 07:58:55 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2025-q2;
	 bh=DcBD5V6ipvKym87WVE2bt/Rih+AWDUPxJbgEfmukeaQ=; b=lvj2SSw9uy3v
	4f7a4bL0ObXPyyp71WlhUVpgx8wUyV4hNJ8kTwdUH7PJohFL/uDy5Qc6OrU70dZb
	Ze3vqDR6jvZ09+k+bhvIi+beeviiHHFRNTtfRTxlkR5pO4IVojSUomNu+sORIPbC
	bXBBxiGRyrX1tObaXAVqMIhKYA2GWKOp2+BOESTAvurCOypYHRyI6PwXyya2+FmW
	MleurSS21/RFFYFriQikUalM42IGM9g2rIu1Go7KJo3w2vhqEJYgDDwHn+BOk69O
	332kex60nmbZJUBvEZz29gEIiR7ZMB2kiZH/ICnbsF2yqqJkHXiRPWv/2GSRrXPP
	l4D/f9I0UQ==
Received: from maileast.thefacebook.com ([163.114.135.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4e221d2h9a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Mon, 11 May 2026 07:58:55 -0700 (PDT)
Received: from localhost (2620:10d:c0a8:fe::f072) by mail.thefacebook.com
 (2620:10d:c0a9:6f::8fd4) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.37; Mon, 11 May
 2026 14:58:53 +0000
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
Subject: [PATCH v5 1/3] vfio/pci: Set up BAR resources and maps in vfio_pci_core_enable()
Date: Mon, 11 May 2026 07:58:23 -0700
Message-ID: <20260511145829.2993601-2-mattev@meta.com>
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
X-Authority-Analysis: v=2.4 cv=YJuvDxGx c=1 sm=1 tr=0 ts=6a01eeaf cx=c_pps
 a=MfjaFnPeirRr97d5FC5oHw==:117 a=MfjaFnPeirRr97d5FC5oHw==:17
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=7x6HtfJdh03M6CCDgxCd:22
 a=03ozwUkBphtHgyqjj1sw:22 a=VabnemYjAAAA:8 a=Lb-xxqHfFU9yCMAFiGgA:9
 a=gKebqoRLp9LExxC7YDUY:22
X-Proofpoint-ORIG-GUID: dr9uc5bF20qs2VvA6RQ2qT2L72xsCqb8
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTExMDE2NCBTYWx0ZWRfX7Ew39mdAfjHD
 FMZ2fh8w41ngBnwOWFPKS3HylKJpcypbOE2APcRslABVtgPLvWLyN/cWnJa9tv1XQPj5FNRLhgT
 oLUAko901hflOWc3GJ772xLw+0l+diCWaGTfDVTXi9NDmhNw4FgFxZPjzetVRplc3aFAkLspHXy
 T0HnRlThyn23+TQ16IB/ucfx+1DZqT1jLZr23eq4AzUGpsFnsi1bUPYNnCQqHJ09iFNOqR8kRfr
 +yuMj+8ddFuzQjTjRuuOsuVbhNX2n1o2PmlnhUMmP9IvPe3a3OZWu7LdKhyyVgg8IRKMJs39McE
 +TBaD80EmOEDWS4cNnsQHYOP55ncnHzAIeYu/JIuug/Ads4h7eKCCQQCGcE3M/u5Ea0c7NlAN/1
 WQmfmZuKV7kme2pm6ymFxxT13n4UNYTmJimyJmmMOBkA8tR+ZNDOOSfu/SGFJbg5ktBpo7ACcQf
 Nj2Z1RQv46t63GS2fwQ==
X-Proofpoint-GUID: dr9uc5bF20qs2VvA6RQ2qT2L72xsCqb8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-11_04,2026-05-08_02,2025-10-01_01

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
 drivers/vfio/pci/vfio_pci_core.c | 37 +++++++++++++++++++++++++++++++-
 drivers/vfio/pci/vfio_pci_rdwr.c | 26 ++++++----------------
 2 files changed, 43 insertions(+), 20 deletions(-)

diff --git a/drivers/vfio/pci/vfio_pci_core.c b/drivers/vfio/pci/vfio_pci_core.c
index 3f8d093aacf8..0e4fc17d360f 100644
--- a/drivers/vfio/pci/vfio_pci_core.c
+++ b/drivers/vfio/pci/vfio_pci_core.c
@@ -482,6 +482,40 @@ static int vfio_pci_core_runtime_resume(struct device *dev)
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
+			pci_dbg(pdev, "Failed to reserve region %d\n", bar);
+			vdev->barmap[bar] = ERR_PTR(-EBUSY);
+			continue;
+		}
+
+		vdev->barmap[bar] = pci_iomap(pdev, bar, 0);
+		if (!vdev->barmap[bar]) {
+			pci_dbg(pdev, "Failed to iomap region %d\n", bar);
+			pci_release_selected_regions(pdev, 1 << bar);
+			vdev->barmap[bar] = ERR_PTR(-ENOMEM);
+		}
+	}
+}
+
 /*
  * The pci-driver core runtime PM routines always save the device state
  * before going into suspended state. If the device is going into low power
@@ -568,6 +602,7 @@ int vfio_pci_core_enable(struct vfio_pci_core_device *vdev)
 	if (!vfio_vga_disabled() && vfio_pci_is_vga(pdev))
 		vdev->has_vga = true;
 
+	vfio_pci_core_map_bars(vdev);
 
 	return 0;
 
@@ -648,7 +683,7 @@ void vfio_pci_core_disable(struct vfio_pci_core_device *vdev)
 
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

