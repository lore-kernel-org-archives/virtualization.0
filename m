Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4068448B39C
	for <virtualization@lists.linux.dev>; Tue,  5 May 2026 17:39:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.145.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778002761; cv=none; b=qVM4FbeokuqqldndQRBf4MvAPgIk2/JKedxdmnqUX8PranBh6pSWiL2oBAH0bpJvGeNIqkDzZpINQdXFXrF3QCVbWH4VpM0BRiToYGSs2ke3X/p/saBuaIyiXhGLcwKaygD+OssJuenYe+SUA49YANmAHL9Fatrr107emNxg1qk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778002761; c=relaxed/simple;
	bh=cXP0cw/vmuIMezt8OaMspQhvQNflx32gyCTCp9IxP/I=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GaMGD1RoLFPtSw2m+BK1QnsMMbyqCyt2Jv6z7HmxHIEM3Jgth7wPKtvQ7zNZ6kiM6zwWclCLe48+2PbD0tjX+t9E0cy4peG1AimMPooFDVXin6H3rxJoe4QuELGLtPWpUcPVrfcmdWlRZPSRscfT6gkVlOpSnSkz9o+2PH6xTfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=u+b7VA0T; arc=none smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="u+b7VA0T"
Received: from pps.filterd (m0528009.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 645EFdWl3822354;
	Tue, 5 May 2026 10:39:17 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2025-q2;
	 bh=vVj7iQqkLu0ZHUU3VP6G/UKN+KzbLFcMnwbEARkqGyg=; b=u+b7VA0TcHa/
	EWiEAlceVAvVuGSJXz35BhMmoyd3yFudutrCdE/7eoSJfuQ2rQqSXbVdEMlu1UMI
	PRVBu5ftRHT/S47fol74FcOigQDF9nGSRsYMGVouMo5DTDI2gLadmgYenEgjzKez
	q8S1V2A4GBtJ8UM3hb1dJtClHcE7O7sJUEdT+vcihYt/UnNTWFU6coNtsdR4rJqO
	rAtItLw+KTXnORkaWyMD4S7vXuH8ulMmbibbZEECj09UuM24HDJsqPRM86YORbd/
	i+w2zKPDWmwWxWWUdUY38JMjOuLaTvAw8VIPYUK6bJ3/WoNFvV9EnkGh4LAJAdO1
	nCNzCHeNFA==
Received: from mail.thefacebook.com ([163.114.134.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4dx315emrv-9
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Tue, 05 May 2026 10:39:16 -0700 (PDT)
Received: from localhost (2620:10d:c085:208::f) by mail.thefacebook.com
 (2620:10d:c08b:78::2ac9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.37; Tue, 5 May
 2026 17:39:10 +0000
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
Subject: [PATCH v4 3/3] vfio/pci: Replace vfio_pci_core_setup_barmap() with vfio_pci_core_get_iomap()
Date: Tue, 5 May 2026 10:38:31 -0700
Message-ID: <20260505173835.2324179-4-mattev@meta.com>
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
X-Proofpoint-GUID: ML9YU2Aop1nPcm5xoJ2AUZ9vPWs0J4Da
X-Proofpoint-ORIG-GUID: ML9YU2Aop1nPcm5xoJ2AUZ9vPWs0J4Da
X-Authority-Analysis: v=2.4 cv=K4AS2SWI c=1 sm=1 tr=0 ts=69fa2b44 cx=c_pps
 a=CB4LiSf2rd0gKozIdrpkBw==:117 a=CB4LiSf2rd0gKozIdrpkBw==:17
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=7x6HtfJdh03M6CCDgxCd:22
 a=U_y8lYiYyhHBU5rMqhb2:22 a=VabnemYjAAAA:8 a=srd7E2Gw4o7griR4iQgA:9
 a=gKebqoRLp9LExxC7YDUY:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA1MDE3MSBTYWx0ZWRfXxgI3IWl/HNCJ
 SE2+2HTq4XsO6vr5MYejJ3IyXAokK/hSkDc39rH+wGbme3IjZIv5gWpU5iMUChr76BBUC/KG0aN
 K0DppaqZd131Zg8bDh4r9ewsyidVFVM+oHFmaO7Brbb9rxeVBKS0lW6SHuat+HIMoecG1ICgeZF
 ZPXcV8rnxszpQKZAOWAzdgCras9CV2cy8gL7FlkWhZOY6pAygM9BRNrZe686tjXipbJW8NnTug0
 ZbgisY/gxC9pBfZdmLDkpXUKxfRMnG+BehX+GD9O2i6y+BLtNnzZj7WWSp2Bt/OVrwQSz2HCgPh
 bEH0YUAx6NlE+0oFfgXbakIfWC0l8mNPxO/4vMI2vfncq0onJwSiSR4aMZ6Y5H8rZ/c5SqrQwa3
 mtGPLoQvM6mH91VAYc1KGu0eaAUF6ZCM4UtrseyYeSgnYcfQU2uaEUrNbCh5LrKOUe00OurS47J
 spmbFySOeanIm2lLxmA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-05_02,2026-04-30_02,2025-10-01_01

Since "vfio/pci: Set up barmap in vfio_pci_core_enable()", the
resource request and iomap for the BARs was performed early, and
vfio_pci_core_setup_barmap() just checks those actions succeeded.

Move this logic to a new helper that checks success and returns the
iomap address, replacing the various bare vdev->barmap[] lookups.
This maintains the error behaviour of the previous on-demand
vfio_pci_core_setup_barmap() scheme.

Signed-off-by: Matt Evans <mattev@meta.com>
---
 drivers/vfio/pci/nvgrace-gpu/main.c | 11 ++++-------
 drivers/vfio/pci/vfio_pci_core.c    | 11 +++++------
 drivers/vfio/pci/vfio_pci_dmabuf.c  |  2 +-
 drivers/vfio/pci/vfio_pci_rdwr.c    | 30 ++++++++---------------------
 drivers/vfio/pci/virtio/legacy_io.c | 13 ++++++-------
 include/linux/vfio_pci_core.h       | 20 ++++++++++++++++++-
 6 files changed, 43 insertions(+), 44 deletions(-)

diff --git a/drivers/vfio/pci/nvgrace-gpu/main.c b/drivers/vfio/pci/nvgrace-gpu/main.c
index fa056b69f899..e153002258ce 100644
--- a/drivers/vfio/pci/nvgrace-gpu/main.c
+++ b/drivers/vfio/pci/nvgrace-gpu/main.c
@@ -184,13 +184,10 @@ static int nvgrace_gpu_open_device(struct vfio_device *core_vdev)
 
 	/*
 	 * GPU readiness is checked by reading the BAR0 registers.
-	 *
-	 * ioremap BAR0 to ensure that the BAR0 mapping is present before
-	 * register reads on first fault before establishing any GPU
-	 * memory mapping.
+	 * The BAR map was just set up by vfio_pci_core_enable(), so
+	 * check that was successful and bail early if not:
 	 */
-	ret = vfio_pci_core_setup_barmap(vdev, 0);
-	if (ret)
+	if (IS_ERR(vfio_pci_core_get_iomap(vdev, 0)))
 		goto error_exit;
 
 	if (nvdev->resmem.memlength) {
@@ -275,7 +272,7 @@ nvgrace_gpu_check_device_ready(struct nvgrace_gpu_pci_core_device *nvdev)
 	if (!__vfio_pci_memory_enabled(vdev))
 		return -EIO;
 
-	ret = nvgrace_gpu_wait_device_ready(vdev->barmap[0]);
+	ret = nvgrace_gpu_wait_device_ready(vfio_pci_core_get_iomap(vdev, 0));
 	if (ret)
 		return ret;
 
diff --git a/drivers/vfio/pci/vfio_pci_core.c b/drivers/vfio/pci/vfio_pci_core.c
index 62931dc381d8..5c8bd13f10d0 100644
--- a/drivers/vfio/pci/vfio_pci_core.c
+++ b/drivers/vfio/pci/vfio_pci_core.c
@@ -1761,7 +1761,7 @@ int vfio_pci_core_mmap(struct vfio_device *core_vdev, struct vm_area_struct *vma
 	struct pci_dev *pdev = vdev->pdev;
 	unsigned int index;
 	u64 phys_len, req_len, pgoff, req_start;
-	int ret;
+	void __iomem *bar_io;
 
 	index = vma->vm_pgoff >> (VFIO_PCI_OFFSET_SHIFT - PAGE_SHIFT);
 
@@ -1795,12 +1795,11 @@ int vfio_pci_core_mmap(struct vfio_device *core_vdev, struct vm_area_struct *vma
 		return -EINVAL;
 
 	/*
-	 * Even though we don't make use of the barmap for the mmap,
-	 * we need to request the region and the barmap tracks that.
+	 * Ensure the BAR resource region is reserved for use.
 	 */
-	ret = vfio_pci_core_setup_barmap(vdev, index);
-	if (ret)
-		return ret;
+	bar_io = vfio_pci_core_get_iomap(vdev, index);
+	if (IS_ERR(bar_io))
+		return PTR_ERR(bar_io);
 
 	vma->vm_private_data = vdev;
 	vma->vm_page_prot = pgprot_noncached(vma->vm_page_prot);
diff --git a/drivers/vfio/pci/vfio_pci_dmabuf.c b/drivers/vfio/pci/vfio_pci_dmabuf.c
index 69a5c2d511e6..46cd44b22c9c 100644
--- a/drivers/vfio/pci/vfio_pci_dmabuf.c
+++ b/drivers/vfio/pci/vfio_pci_dmabuf.c
@@ -248,7 +248,7 @@ int vfio_pci_core_feature_dma_buf(struct vfio_pci_core_device *vdev, u32 flags,
 	 * else.  Check that PCI resources have been claimed for it.
 	 */
 	if (get_dma_buf.region_index >= VFIO_PCI_ROM_REGION_INDEX ||
-	    vfio_pci_core_setup_barmap(vdev, get_dma_buf.region_index))
+	    IS_ERR(vfio_pci_core_get_iomap(vdev, get_dma_buf.region_index)))
 		return -ENODEV;
 
 	dma_ranges = memdup_array_user(&arg->dma_ranges, get_dma_buf.nr_ranges,
diff --git a/drivers/vfio/pci/vfio_pci_rdwr.c b/drivers/vfio/pci/vfio_pci_rdwr.c
index 3bfbb879a005..7f14dd46de17 100644
--- a/drivers/vfio/pci/vfio_pci_rdwr.c
+++ b/drivers/vfio/pci/vfio_pci_rdwr.c
@@ -198,19 +198,6 @@ ssize_t vfio_pci_core_do_io_rw(struct vfio_pci_core_device *vdev, bool test_mem,
 }
 EXPORT_SYMBOL_GPL(vfio_pci_core_do_io_rw);
 
-/*
- * The barmap is set up in vfio_pci_core_enable().  Callers use this
- * function to check that the BAR resources are requested or that the
- * pci_iomap() was done.
- */
-int vfio_pci_core_setup_barmap(struct vfio_pci_core_device *vdev, int bar)
-{
-	if (IS_ERR(vdev->barmap[bar]))
-		return PTR_ERR(vdev->barmap[bar]);
-	return 0;
-}
-EXPORT_SYMBOL_GPL(vfio_pci_core_setup_barmap);
-
 ssize_t vfio_pci_bar_rw(struct vfio_pci_core_device *vdev, char __user *buf,
 			size_t count, loff_t *ppos, bool iswrite)
 {
@@ -262,13 +249,11 @@ ssize_t vfio_pci_bar_rw(struct vfio_pci_core_device *vdev, char __user *buf,
 		 */
 		max_width = VFIO_PCI_IO_WIDTH_4;
 	} else {
-		int ret = vfio_pci_core_setup_barmap(vdev, bar);
-		if (ret) {
-			done = ret;
+		io = vfio_pci_core_get_iomap(vdev, bar);
+		if (IS_ERR(io)) {
+			done = PTR_ERR(io);
 			goto out;
 		}
-
-		io = vdev->barmap[bar];
 	}
 
 	if (bar == vdev->msix_bar) {
@@ -423,6 +408,7 @@ int vfio_pci_ioeventfd(struct vfio_pci_core_device *vdev, loff_t offset,
 	loff_t pos = offset & VFIO_PCI_OFFSET_MASK;
 	int ret, bar = VFIO_PCI_OFFSET_TO_INDEX(offset);
 	struct vfio_pci_ioeventfd *ioeventfd;
+	void __iomem *io;
 
 	/* Only support ioeventfds into BARs */
 	if (bar > VFIO_PCI_BAR5_REGION_INDEX)
@@ -440,9 +426,9 @@ int vfio_pci_ioeventfd(struct vfio_pci_core_device *vdev, loff_t offset,
 	if (count == 8)
 		return -EINVAL;
 
-	ret = vfio_pci_core_setup_barmap(vdev, bar);
-	if (ret)
-		return ret;
+	io = vfio_pci_core_get_iomap(vdev, bar);
+	if (IS_ERR(io))
+		return PTR_ERR(io);
 
 	mutex_lock(&vdev->ioeventfds_lock);
 
@@ -479,7 +465,7 @@ int vfio_pci_ioeventfd(struct vfio_pci_core_device *vdev, loff_t offset,
 	}
 
 	ioeventfd->vdev = vdev;
-	ioeventfd->addr = vdev->barmap[bar] + pos;
+	ioeventfd->addr = io + pos;
 	ioeventfd->data = data;
 	ioeventfd->pos = pos;
 	ioeventfd->bar = bar;
diff --git a/drivers/vfio/pci/virtio/legacy_io.c b/drivers/vfio/pci/virtio/legacy_io.c
index 1ed349a55629..c868b2177310 100644
--- a/drivers/vfio/pci/virtio/legacy_io.c
+++ b/drivers/vfio/pci/virtio/legacy_io.c
@@ -299,19 +299,18 @@ int virtiovf_pci_ioctl_get_region_info(struct vfio_device *core_vdev,
 static int virtiovf_set_notify_addr(struct virtiovf_pci_core_device *virtvdev)
 {
 	struct vfio_pci_core_device *core_device = &virtvdev->core_device;
-	int ret;
+	void __iomem *io;
 
 	/*
 	 * Setup the BAR where the 'notify' exists to be used by vfio as well
 	 * This will let us mmap it only once and use it when needed.
 	 */
-	ret = vfio_pci_core_setup_barmap(core_device,
-					 virtvdev->notify_bar);
-	if (ret)
-		return ret;
+	io = vfio_pci_core_get_iomap(core_device,
+				     virtvdev->notify_bar);
+	if (IS_ERR(io))
+		return PTR_ERR(io);
 
-	virtvdev->notify_addr = core_device->barmap[virtvdev->notify_bar] +
-			virtvdev->notify_offset;
+	virtvdev->notify_addr = io + virtvdev->notify_offset;
 	return 0;
 }
 
diff --git a/include/linux/vfio_pci_core.h b/include/linux/vfio_pci_core.h
index 2ebba746c18f..ffd67e25bf3f 100644
--- a/include/linux/vfio_pci_core.h
+++ b/include/linux/vfio_pci_core.h
@@ -188,7 +188,6 @@ int vfio_pci_core_match_token_uuid(struct vfio_device *core_vdev,
 int vfio_pci_core_enable(struct vfio_pci_core_device *vdev);
 void vfio_pci_core_disable(struct vfio_pci_core_device *vdev);
 void vfio_pci_core_finish_enable(struct vfio_pci_core_device *vdev);
-int vfio_pci_core_setup_barmap(struct vfio_pci_core_device *vdev, int bar);
 pci_ers_result_t vfio_pci_core_aer_err_detected(struct pci_dev *pdev,
 						pci_channel_state_t state);
 ssize_t vfio_pci_core_do_io_rw(struct vfio_pci_core_device *vdev, bool test_mem,
@@ -234,6 +233,25 @@ static inline bool is_aligned_for_order(struct vm_area_struct *vma,
 			   !IS_ALIGNED(pfn, 1 << order)));
 }
 
+/*
+ * Returns a BAR's iomap base or an ERR_PTR() if, for example, the
+ * BAR isn't valid, its resource wasn't acquired, or its iomap
+ * failed.  This shall only be used after vfio_pci_core_enable()
+ * has set up the BAR maps and before vfio_pci_core_disable()
+ * tears them down.
+ */
+static inline void __iomem __must_check *
+vfio_pci_core_get_iomap(struct vfio_pci_core_device *vdev, int bar)
+{
+	if (WARN_ON_ONCE(bar < 0 || bar >= PCI_STD_NUM_BARS))
+		return ERR_PTR(-EINVAL);
+
+	if (WARN_ON_ONCE(!vdev->barmap[bar]))
+		return ERR_PTR(-ENODEV);
+
+	return vdev->barmap[bar];
+}
+
 int vfio_pci_dma_buf_iommufd_map(struct dma_buf_attachment *attachment,
 				 struct phys_vec *phys);
 
-- 
2.47.3

