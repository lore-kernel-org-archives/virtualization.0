Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21EA22D8DC3
	for <virtualization@lists.linux.dev>; Thu, 23 Apr 2026 18:25:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.145.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776968745; cv=none; b=bZmyWlDqRV7N/9OYgbmRjvzOeWPwDwZyX62KXwlstajriZ67BqOl4dAj/334FqN89IikeQMhdKzN2np+Uih0rF77tYLvKg0l1pZ0E+sUa++zeYRO51LInK16ZkJvkUvHNXyjOQovNh1wHs5iy4VTw+seadupZC/M6lF0WlTuioo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776968745; c=relaxed/simple;
	bh=ShTdoVrnXSyyHN/6OzXuQ0gMCrNZenZCjaudpjrEzb4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ngcTwUdQbHClKbn6smSxg3QepmkV6ZBchX+X8LYBohrKfnfCIrILoCyUq1IKa4G8xt0SbREhoP1a2yeV3sW022GrQn4TltLYTztB6wsbrh15wdooxZH5wS8Xjr2a1xGM9rpT9DwC38kOtZGbwja61+OlnQAJwF7NU9mDsDptMWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=qANomHpC; arc=none smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="qANomHpC"
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63NH8gUo1824977;
	Thu, 23 Apr 2026 11:25:41 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2025-q2;
	 bh=eHQ9GnvNFf670vtjNqDNc3lfQUALdkZNgnI9jY47VFs=; b=qANomHpCq9lk
	pvgxbW/ckFyijJ/D2M93/5Bix1a+tX3xKV/a+9JbqmeLNt5vn+1Jf2aREQ0zZXad
	VvXLdtx8OSK/BxpXhf2Vbuqtm5L2D4zHG8iPmwXj0f0hG2l4ZrznbdZvByd14e8r
	KnUBdofXjwJlLy+Ic9U/aqj4tTJJ7HgmGaFIzUS6krYqQGGFihelK/aIr+uk7NMS
	lRgzUwp76daXivr2K+uEiI5wSOWX8IRUJqD5rd/xCEqHwxm289jaakMGr91oW3Df
	7Do5HP1OzQ06Uzmvr7r3Eei3euTQ53rbbhhQGDCD/O1lZ+KtSzRYYAdjWDF54AZc
	M8HuUvzTWA==
Received: from maileast.thefacebook.com ([163.114.135.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4dpeph6qc5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Thu, 23 Apr 2026 11:25:40 -0700 (PDT)
Received: from localhost (2620:10d:c0a8:1c::1b) by mail.thefacebook.com
 (2620:10d:c0a9:6f::237c) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.37; Thu, 23 Apr
 2026 18:25:39 +0000
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
Subject: [PATCH v2 2/3] vfio/pci: Replace vfio_pci_core_setup_barmap() with checks for resource/map
Date: Thu, 23 Apr 2026 11:25:08 -0700
Message-ID: <20260423182517.2286030-3-mattev@meta.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDIzMDE3OSBTYWx0ZWRfX78vSNFoKBhZ/
 E+cJipjXzBJPB+DUYY6HyohNmZ6VBzW+KswcOsjbJu2sMwWpOerRMsWzLchC/ZSfL/TfAh3bqCV
 9eFjl/hKjfkJLuiOMpwsSDGF/vJ9IcenVX5CGMHVMfxVBSqcK67u77AxmBFEATrNQvYQPt6KBnh
 gbWl66ymifx/Ir9alG2JOBTV+jD4Y/gNcCbLOH9kmkkSEDAGFbd9n7eAH/9+6BSnV4FlXG3eCX/
 2hWehr+sjAWeVa2acyrRT2axe4n3ebQeGElI0NItMU9wdqRmR4TE/h4TAClGfKFjhP/6rAyrMZO
 C9m60GLp3oFdhPuVy+JZJz6vIOHGPeZ4NegySVYPi46TD4NyyaunuWAhyI80wHCk2889yi0EjpM
 qndHBwu38LO6tv6P34gKLF90NGBfa+xo8xpfVIBSzmB6mJtyT0jt139LMiNbkboN7AJherbO/0A
 nRnWQ6oHGmw20aItHkg==
X-Proofpoint-GUID: j9Gm2rLmvaJpt0TfjKBY7Sd1IZkXMObo
X-Proofpoint-ORIG-GUID: j9Gm2rLmvaJpt0TfjKBY7Sd1IZkXMObo
X-Authority-Analysis: v=2.4 cv=B8SJFutM c=1 sm=1 tr=0 ts=69ea6425 cx=c_pps
 a=MfjaFnPeirRr97d5FC5oHw==:117 a=MfjaFnPeirRr97d5FC5oHw==:17
 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22 a=7x6HtfJdh03M6CCDgxCd:22
 a=8elwO82fXORLTBIkMd32:22 a=VabnemYjAAAA:8 a=80U-LRJ5Y8gpQoc0E0sA:9
 a=gKebqoRLp9LExxC7YDUY:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-23_03,2026-04-21_02,2025-10-01_01

Since "vfio/pci: Set up barmap in vfio_pci_core_enable()", the
resource request and iomap for the BARs was performed early, and
vfio_pci_core_setup_barmap() now just checks those actions succeeded.

There were two types of callers:
 - Those that need the iomap, because they'll access the BAR
 - Those that need the resource, because they'll map/export it

This replaces vfio_pci_core_setup_barmap() with two helpers,
vfio_pci_core_check_barmap_valid() and vfio_pci_core_check_bar_rsrc(),
to make it clear which behaviour is required in each caller.

Signed-off-by: Matt Evans <mattev@meta.com>
---
 drivers/vfio/pci/nvgrace-gpu/main.c |  8 +++-----
 drivers/vfio/pci/vfio_pci_core.c    |  5 ++---
 drivers/vfio/pci/vfio_pci_rdwr.c    | 22 ++--------------------
 drivers/vfio/pci/virtio/legacy_io.c |  4 ++--
 include/linux/vfio_pci_core.h       | 23 ++++++++++++++++++++++-
 5 files changed, 31 insertions(+), 31 deletions(-)

diff --git a/drivers/vfio/pci/nvgrace-gpu/main.c b/drivers/vfio/pci/nvgrace-gpu/main.c
index fa056b69f899..d5f09144ac84 100644
--- a/drivers/vfio/pci/nvgrace-gpu/main.c
+++ b/drivers/vfio/pci/nvgrace-gpu/main.c
@@ -184,12 +184,10 @@ static int nvgrace_gpu_open_device(struct vfio_device *core_vdev)
 
 	/*
 	 * GPU readiness is checked by reading the BAR0 registers.
-	 *
-	 * ioremap BAR0 to ensure that the BAR0 mapping is present before
-	 * register reads on first fault before establishing any GPU
-	 * memory mapping.
+	 * Ensure that the BAR0 mapping is present before that
+	 * happens.
 	 */
-	ret = vfio_pci_core_setup_barmap(vdev, 0);
+	ret = vfio_pci_core_check_barmap_valid(vdev, 0);
 	if (ret)
 		goto error_exit;
 
diff --git a/drivers/vfio/pci/vfio_pci_core.c b/drivers/vfio/pci/vfio_pci_core.c
index c59c61861d81..2771d0f21899 100644
--- a/drivers/vfio/pci/vfio_pci_core.c
+++ b/drivers/vfio/pci/vfio_pci_core.c
@@ -1804,10 +1804,9 @@ int vfio_pci_core_mmap(struct vfio_device *core_vdev, struct vm_area_struct *vma
 		return -EINVAL;
 
 	/*
-	 * Even though we don't make use of the barmap for the mmap,
-	 * we need to request the region and the barmap tracks that.
+	 * Ensure the BAR resource region is reserved for use.
 	 */
-	ret = vfio_pci_core_setup_barmap(vdev, index);
+	ret = vfio_pci_core_check_bar_rsrc(vdev, index);
 	if (ret)
 		return ret;
 
diff --git a/drivers/vfio/pci/vfio_pci_rdwr.c b/drivers/vfio/pci/vfio_pci_rdwr.c
index bf7152316db4..40c97d73ff95 100644
--- a/drivers/vfio/pci/vfio_pci_rdwr.c
+++ b/drivers/vfio/pci/vfio_pci_rdwr.c
@@ -198,24 +198,6 @@ ssize_t vfio_pci_core_do_io_rw(struct vfio_pci_core_device *vdev, bool test_mem,
 }
 EXPORT_SYMBOL_GPL(vfio_pci_core_do_io_rw);
 
-int vfio_pci_core_setup_barmap(struct vfio_pci_core_device *vdev, int bar)
-{
-	/*
-	 * The barmap is now always set up in vfio_pci_core_enable().
-	 * Some legacy callers use this function to ensure the BAR
-	 * resources are requested, and others to ensure the
-	 * pci_iomap() was done, so check here:
-	 */
-	if (bar < 0 || bar >= PCI_STD_NUM_BARS)
-		return -EINVAL;
-	if (vdev->barmap[bar] == 0)
-		return -ENOMEM;
-	if (!vdev->bar_has_rsrc[bar])
-		return -EBUSY;
-	return 0;
-}
-EXPORT_SYMBOL_GPL(vfio_pci_core_setup_barmap);
-
 ssize_t vfio_pci_bar_rw(struct vfio_pci_core_device *vdev, char __user *buf,
 			size_t count, loff_t *ppos, bool iswrite)
 {
@@ -267,7 +249,7 @@ ssize_t vfio_pci_bar_rw(struct vfio_pci_core_device *vdev, char __user *buf,
 		 */
 		max_width = VFIO_PCI_IO_WIDTH_4;
 	} else {
-		int ret = vfio_pci_core_setup_barmap(vdev, bar);
+		int ret = vfio_pci_core_check_barmap_valid(vdev, bar);
 		if (ret) {
 			done = ret;
 			goto out;
@@ -445,7 +427,7 @@ int vfio_pci_ioeventfd(struct vfio_pci_core_device *vdev, loff_t offset,
 	if (count == 8)
 		return -EINVAL;
 
-	ret = vfio_pci_core_setup_barmap(vdev, bar);
+	ret = vfio_pci_core_check_barmap_valid(vdev, bar);
 	if (ret)
 		return ret;
 
diff --git a/drivers/vfio/pci/virtio/legacy_io.c b/drivers/vfio/pci/virtio/legacy_io.c
index 1ed349a55629..9c59d1600ac4 100644
--- a/drivers/vfio/pci/virtio/legacy_io.c
+++ b/drivers/vfio/pci/virtio/legacy_io.c
@@ -305,8 +305,8 @@ static int virtiovf_set_notify_addr(struct virtiovf_pci_core_device *virtvdev)
 	 * Setup the BAR where the 'notify' exists to be used by vfio as well
 	 * This will let us mmap it only once and use it when needed.
 	 */
-	ret = vfio_pci_core_setup_barmap(core_device,
-					 virtvdev->notify_bar);
+	ret = vfio_pci_core_check_barmap_valid(core_device,
+					       virtvdev->notify_bar);
 	if (ret)
 		return ret;
 
diff --git a/include/linux/vfio_pci_core.h b/include/linux/vfio_pci_core.h
index 1f508b067d82..6a5384d57f1d 100644
--- a/include/linux/vfio_pci_core.h
+++ b/include/linux/vfio_pci_core.h
@@ -189,7 +189,6 @@ int vfio_pci_core_match_token_uuid(struct vfio_device *core_vdev,
 int vfio_pci_core_enable(struct vfio_pci_core_device *vdev);
 void vfio_pci_core_disable(struct vfio_pci_core_device *vdev);
 void vfio_pci_core_finish_enable(struct vfio_pci_core_device *vdev);
-int vfio_pci_core_setup_barmap(struct vfio_pci_core_device *vdev, int bar);
 pci_ers_result_t vfio_pci_core_aer_err_detected(struct pci_dev *pdev,
 						pci_channel_state_t state);
 ssize_t vfio_pci_core_do_io_rw(struct vfio_pci_core_device *vdev, bool test_mem,
@@ -225,6 +224,28 @@ VFIO_IOREAD_DECLARATION(32)
 VFIO_IOREAD_DECLARATION(64)
 #endif
 
+/* Returns 0 if vdev->barmap[bar] can be accessed, otherwise errno */
+static inline int
+vfio_pci_core_check_barmap_valid(struct vfio_pci_core_device *vdev, int bar)
+{
+	if (bar < 0 || bar >= PCI_STD_NUM_BARS)
+		return -EINVAL;
+	if (vdev->barmap[bar] == 0)
+		return -ENOMEM;
+	return 0;
+}
+
+/* Returns 0 if BAR has a valid resource reserved for use, otherwise errno */
+static inline int vfio_pci_core_check_bar_rsrc(struct vfio_pci_core_device *vdev,
+					       int bar)
+{
+	if (bar < 0 || bar >= PCI_STD_NUM_BARS)
+		return -EINVAL;
+	if (!vdev->have_bar_resource[bar])
+		return -EBUSY;
+	return 0;
+}
+
 static inline bool is_aligned_for_order(struct vm_area_struct *vma,
 					unsigned long addr,
 					unsigned long pfn,
-- 
2.47.3

