Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 509823FB7E3
	for <virtualization@lists.linux.dev>; Thu, 30 Apr 2026 10:03:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.145.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777543439; cv=none; b=CUtt0xQqaI2lXmYNe9RhM97AXOBBrrvuj6/p4MrczV5xXMcbEleLqvvey6U5ozKoqRKCUbHBTTIX3GiFLMhOOi+H+Nv9upEat70jaZtuEuS4OSjfqDeKlPeueJv01dNWGHROQKGnvQXVWIJRqsPPzN1MNRB70e29+sJJ0/0VXsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777543439; c=relaxed/simple;
	bh=aKMUgnhcqf+swiFscohRYZI4ETFq9DrRlhcmFQ4dmb8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=vGP17Luat2ZR7zRdAjE6HzhhtMVnWvWs1R++5o4qPofVQOtSLir90Z7CvuAy2iFfL+seKsInlgJRmdxonZQyUtX9wqlZ3k6Gqa0GaWKia393FIHqMPwJ8gN2HsYt3vN00H+ZupDc7uI+BufoMczqrc2ZCb2L/bJ0w2k/WxKVfxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=lMhmSv2a; arc=none smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="lMhmSv2a"
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63U49i4u2006293;
	Thu, 30 Apr 2026 03:03:54 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2025-q2;
	 bh=URyqm4DU6tZrmJrdCb8fM6nxg82K496rFtrOAXyE7TU=; b=lMhmSv2azmW3
	ZOoeMC9PHYm3C42aOyKInCAoaip5LkA8CxH7tK/F4DTi+ECQFDSX60eOFSQT3L/9
	oQSHpPjGeBmY9NR0kWkq/ZntX0tZCKYtHkPXgV5tf36Q5xlw8s1a/paClrsVDi2N
	xdHYtCswJgKtolNe44CutWrCVIi1JhIEJz8rLC/lZET2qRvKf4Qy/3Vf0hDy7Ff7
	Bn83a5NBxTTFa2ZDohziAjrc0lPmn5eEw5pVwa1O19sqO+lBpTg8+/HvS5VMl5uz
	HjvrOfeZXoeuIZG8AWLfx0hc/BTwnThFQHxI7VpZzttRJA6xa3RfLMLXmPcLUWKR
	NmwBuIce1w==
Received: from maileast.thefacebook.com ([163.114.135.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4drua3rcqh-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Thu, 30 Apr 2026 03:03:54 -0700 (PDT)
Received: from localhost (2620:10d:c0a8:fe::f072) by mail.thefacebook.com
 (2620:10d:c0a9:6f::237c) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.37; Thu, 30 Apr
 2026 10:03:53 +0000
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
Subject: [PATCH v3 2/3] vfio/pci: Replace vfio_pci_core_setup_barmap() with vfio_pci_core_get_iomap()
Date: Thu, 30 Apr 2026 03:03:21 -0700
Message-ID: <20260430100340.2787446-3-mattev@meta.com>
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
X-Proofpoint-GUID: myC6x2IFiCLoUii1-c6LPuSgRwaBLGMZ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDMwMDEwMCBTYWx0ZWRfX3A/ekz9zFsKQ
 34pdcN9uxo5jOzDI6djgHlVPAPMWR4rg9X3/yPUk/c66K29HV8saiq7DpenmalLijJrqgm5vjwj
 /3sOANAPDsQqeCE9hh8Meu2zSYmM102ZBhwhfTaGWiNIQK+1GcE+4wGnkysDenhe4+ZyEqHibH9
 4iUcfy0w/I9Kzx7dT7kmgtttNr78EbAs+uropU7+7rWLAoIkgw6QsZPcTVPL/EaPMb5LH+8jWlK
 xw0EGYxfUO69SAfyDF9SwlvmEtUdsvuWbXv/NslaxjyNOVsGt7yofMDRoCRIlvrAxXwsiaCKhEP
 t4KWkse51fSSzhyV3IIZgaWILI9v/eBByGygi67LstIpv4sXCTFo963edi1ensTJUvyEVNemZt5
 gCTQQoqfcaTEnhB0R7kIiI/J2soDGxd2d/ujA2+gsGWYNMHCep6FB/ROsQnlJYgq51WDDYqX2nS
 8pfHDHDgfnHdPJ2KGag==
X-Proofpoint-ORIG-GUID: myC6x2IFiCLoUii1-c6LPuSgRwaBLGMZ
X-Authority-Analysis: v=2.4 cv=UYphjqSN c=1 sm=1 tr=0 ts=69f3290a cx=c_pps
 a=MfjaFnPeirRr97d5FC5oHw==:117 a=MfjaFnPeirRr97d5FC5oHw==:17
 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22 a=7x6HtfJdh03M6CCDgxCd:22
 a=PAz_-FQ8hEVmOPYdF0yf:22 a=VabnemYjAAAA:8 a=YWJoA2wA2ee_WqQzurEA:9
 a=gKebqoRLp9LExxC7YDUY:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-30_03,2026-04-28_01,2025-10-01_01

Since "vfio/pci: Set up barmap in vfio_pci_core_enable()", the
resource request and iomap for the BARs was performed early, and
vfio_pci_core_setup_barmap() just checks those actions succeeded.

Move this logic to a new helper that checks success and returns the
iomap address, replacing the various bare vdev->barmap[] lookups.
This maintains the error behaviour of the previous on-demand
vfio_pci_core_setup_barmap() scheme.

Signed-off-by: Matt Evans <mattev@meta.com>
---
 drivers/vfio/pci/nvgrace-gpu/main.c | 17 +++++++------
 drivers/vfio/pci/vfio_pci_core.c    | 11 ++++-----
 drivers/vfio/pci/vfio_pci_rdwr.c    | 37 +++++++----------------------
 drivers/vfio/pci/virtio/legacy_io.c | 13 +++++-----
 include/linux/vfio_pci_core.h       | 19 ++++++++++++++-
 5 files changed, 47 insertions(+), 50 deletions(-)

diff --git a/drivers/vfio/pci/nvgrace-gpu/main.c b/drivers/vfio/pci/nvgrace-gpu/main.c
index fa056b69f899..2f5ec60c15d9 100644
--- a/drivers/vfio/pci/nvgrace-gpu/main.c
+++ b/drivers/vfio/pci/nvgrace-gpu/main.c
@@ -184,13 +184,11 @@ static int nvgrace_gpu_open_device(struct vfio_device *core_vdev)
 
 	/*
 	 * GPU readiness is checked by reading the BAR0 registers.
-	 *
-	 * ioremap BAR0 to ensure that the BAR0 mapping is present before
-	 * register reads on first fault before establishing any GPU
-	 * memory mapping.
+	 * The BAR map was just set up by vfio_pci_core_enable() and,
+	 * although the readiness check checks validity of the BAR0
+	 * map, assert early that the map was successful:
 	 */
-	ret = vfio_pci_core_setup_barmap(vdev, 0);
-	if (ret)
+	if (IS_ERR(vfio_pci_core_get_iomap(vdev, 0)))
 		goto error_exit;
 
 	if (nvdev->resmem.memlength) {
@@ -265,6 +263,7 @@ static int
 nvgrace_gpu_check_device_ready(struct nvgrace_gpu_pci_core_device *nvdev)
 {
 	struct vfio_pci_core_device *vdev = &nvdev->core_device;
+	void __iomem *io;
 	int ret;
 
 	lockdep_assert_held_read(&vdev->memory_lock);
@@ -275,7 +274,11 @@ nvgrace_gpu_check_device_ready(struct nvgrace_gpu_pci_core_device *nvdev)
 	if (!__vfio_pci_memory_enabled(vdev))
 		return -EIO;
 
-	ret = nvgrace_gpu_wait_device_ready(vdev->barmap[0]);
+	io = vfio_pci_core_get_iomap(vdev, 0);
+	if (IS_ERR(io))
+		return PTR_ERR(io);
+
+	ret = nvgrace_gpu_wait_device_ready(io);
 	if (ret)
 		return ret;
 
diff --git a/drivers/vfio/pci/vfio_pci_core.c b/drivers/vfio/pci/vfio_pci_core.c
index eab4f2626b39..feaf894ac118 100644
--- a/drivers/vfio/pci/vfio_pci_core.c
+++ b/drivers/vfio/pci/vfio_pci_core.c
@@ -1760,7 +1760,7 @@ int vfio_pci_core_mmap(struct vfio_device *core_vdev, struct vm_area_struct *vma
 	struct pci_dev *pdev = vdev->pdev;
 	unsigned int index;
 	u64 phys_len, req_len, pgoff, req_start;
-	int ret;
+	void __iomem *bar_io;
 
 	index = vma->vm_pgoff >> (VFIO_PCI_OFFSET_SHIFT - PAGE_SHIFT);
 
@@ -1794,12 +1794,11 @@ int vfio_pci_core_mmap(struct vfio_device *core_vdev, struct vm_area_struct *vma
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
diff --git a/drivers/vfio/pci/vfio_pci_rdwr.c b/drivers/vfio/pci/vfio_pci_rdwr.c
index f66ad3d96481..7f14dd46de17 100644
--- a/drivers/vfio/pci/vfio_pci_rdwr.c
+++ b/drivers/vfio/pci/vfio_pci_rdwr.c
@@ -198,26 +198,6 @@ ssize_t vfio_pci_core_do_io_rw(struct vfio_pci_core_device *vdev, bool test_mem,
 }
 EXPORT_SYMBOL_GPL(vfio_pci_core_do_io_rw);
 
-int vfio_pci_core_setup_barmap(struct vfio_pci_core_device *vdev, int bar)
-{
-	/*
-	 * The barmap is set up in vfio_pci_core_enable().  Callers
-	 * use this function to check that the BAR resources are
-	 * requested or that the pci_iomap() was done.
-	 */
-	if (bar < 0 || bar >= PCI_STD_NUM_BARS)
-		return -EINVAL;
-
-	/* Did vfio_pci_core_map_bars() set it up yet? */
-	if (!vdev->barmap[bar])
-		return -ENODEV;
-
-	if (IS_ERR(vdev->barmap[bar]))
-		return PTR_ERR(vdev->barmap[bar]);
-	return 0;
-}
-EXPORT_SYMBOL_GPL(vfio_pci_core_setup_barmap);
-
 ssize_t vfio_pci_bar_rw(struct vfio_pci_core_device *vdev, char __user *buf,
 			size_t count, loff_t *ppos, bool iswrite)
 {
@@ -269,13 +249,11 @@ ssize_t vfio_pci_bar_rw(struct vfio_pci_core_device *vdev, char __user *buf,
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
@@ -430,6 +408,7 @@ int vfio_pci_ioeventfd(struct vfio_pci_core_device *vdev, loff_t offset,
 	loff_t pos = offset & VFIO_PCI_OFFSET_MASK;
 	int ret, bar = VFIO_PCI_OFFSET_TO_INDEX(offset);
 	struct vfio_pci_ioeventfd *ioeventfd;
+	void __iomem *io;
 
 	/* Only support ioeventfds into BARs */
 	if (bar > VFIO_PCI_BAR5_REGION_INDEX)
@@ -447,9 +426,9 @@ int vfio_pci_ioeventfd(struct vfio_pci_core_device *vdev, loff_t offset,
 	if (count == 8)
 		return -EINVAL;
 
-	ret = vfio_pci_core_setup_barmap(vdev, bar);
-	if (ret)
-		return ret;
+	io = vfio_pci_core_get_iomap(vdev, bar);
+	if (IS_ERR(io))
+		return PTR_ERR(io);
 
 	mutex_lock(&vdev->ioeventfds_lock);
 
@@ -486,7 +465,7 @@ int vfio_pci_ioeventfd(struct vfio_pci_core_device *vdev, loff_t offset,
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
index 2ebba746c18f..5598071c5ea3 100644
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
@@ -234,6 +233,24 @@ static inline bool is_aligned_for_order(struct vm_area_struct *vma,
 			   !IS_ALIGNED(pfn, 1 << order)));
 }
 
+/*
+ * Returns a BAR's iomap base, or an ERR_PTR() if, for example, the
+ * BAR isn't valid, its resource wasn't acquired, or its iomap
+ * failed.
+ */
+static inline void __iomem __must_check *
+vfio_pci_core_get_iomap(struct vfio_pci_core_device *vdev, int bar)
+{
+	if (bar < 0 || bar >= PCI_STD_NUM_BARS)
+		return ERR_PTR(-EINVAL);
+
+	/* Did vfio_pci_core_map_bars() set it up yet? */
+	if (!vdev->barmap[bar])
+		return ERR_PTR(-ENODEV);
+
+	return vdev->barmap[bar];
+}
+
 int vfio_pci_dma_buf_iommufd_map(struct dma_buf_attachment *attachment,
 				 struct phys_vec *phys);
 
-- 
2.47.3

