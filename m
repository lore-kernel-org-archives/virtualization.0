Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97C9B4014AD
	for <virtualization@lists.linux.dev>; Mon, 11 May 2026 14:59:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.145.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778511547; cv=none; b=JSQW6f/39BEv6DK1KeBho2XiljQIjtSWbBoMrDzMYxCb1+0wWb/BOTMdSQS5+YjV3E5MDsQVALYRONKRrryF9eaj6wpDf4ERN58q0U7QMn7vx+cJXqGM+GrlgujgZCyx2VTBhOwRAI1F1sWTzJg84b7oDnbFJ/OJCCRAMmMleD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778511547; c=relaxed/simple;
	bh=GH7OEUo0CSzSES0dKOKQScZ8FigFog7YHguLc3TLiZA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bCdOYONY86B2F+F4toaeaGks/N0J3EsYjTL/Eu5DlHZ0p7GGOPjsadrsH8PHPbFTXt9q1Qzl790a1HzIU7u0vaeRy3YSPYZ2QJBrrQiK4aHqm+7qs1t2x/AHoMOAjlEUKVtYjJvZvRGcn1sGW8sDbkvE+dahOiNpeen6tXSiEtg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=vBOfU7gB; arc=none smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="vBOfU7gB"
Received: from pps.filterd (m0528008.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64BEvfSo1143196;
	Mon, 11 May 2026 07:59:02 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2025-q2;
	 bh=VcB1y3QSglxI0gdP4uVXu3IQj3YglwiZAldWcHbVHp8=; b=vBOfU7gB8bso
	1IjeUiKjgzPJqR/YtpjbYj+OsBoLzuf3DWgpU5K7Ck3wFlWBRHkfGttXjBMMhbPd
	e7WBa7+H3Wwovs5USWqWJZhmeHcWzckKlCcakzfGiW/JFwo6T8c6hWDKx0FFoi9J
	HoSnLuoC/+bo+LHt5YBa5i90hjrvZPUFfNOvAZcOUrfNouY6u+CxQVJbp56Q5E7F
	v+hAa/DYX9x1ve9sce0aRMEJUWxFZUKQRvbxGjxthPqewb6397fHXhUxY5AZ117F
	sjnN3EbYuvflMpWEJVcbdwkxWM2Z8+fS0mQyMImx2OMwJVre/9ldgZp+/tdQOO7s
	GEl9Zt4DHQ==
Received: from maileast.thefacebook.com ([163.114.135.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4e2shhwxjx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Mon, 11 May 2026 07:59:02 -0700 (PDT)
Received: from localhost (2620:10d:c0a8:1c::1b) by mail.thefacebook.com
 (2620:10d:c0a9:6f::237c) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.37; Mon, 11 May
 2026 14:59:00 +0000
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
Subject: [PATCH v5 3/3] vfio/pci: Replace vfio_pci_core_setup_barmap() with vfio_pci_core_get_iomap()
Date: Mon, 11 May 2026 07:58:25 -0700
Message-ID: <20260511145829.2993601-4-mattev@meta.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTExMDE2NCBTYWx0ZWRfXx1l9Nw81tlKS
 raj+ZdjZqr1TFthp/LdgJMTobrq9ByO2gOkyZcz9Drit55aCDxAgbQ6jW+goqM3JFoZ0F40ceS/
 QIeWaHdn/rYv3OYpL8zcP04523/Hx+5UJ7R/7BgZ9LrUyeiVi0nnHqdNE+fdX88h5Zd8DbcysI8
 rYWUymvE7TlMFjKyJb2EzHD5ViKArmtQw3edJjEljIOBLqoUCmcakKvYjS/VYBrrjnhB3FAeMKl
 gj4kjh03davrQBypKbhTathmjDyWn4G0Lp2dkT7tN+LnZabAHxu8KXitDsDZjpXewENwKHvi5J+
 ecvSWiAbgs3kZEGpfd6OzwVKwYtpYKNruqEgjy15Ad3s9NnFuzCeCy6tnjUk7GIBNBoEZe9NQ0e
 bnLxk5EnEzVTJF+yq/m19t+dUE6g0M+iqt2GqmjsGs9VFXsTYtwOBac8cMpoFTffaX/Ecs0KBhm
 9BgCkYx/2cRcqFuojhQ==
X-Proofpoint-GUID: c73VIVWMBdTH9NasIsyQrHKwxxnepNAS
X-Authority-Analysis: v=2.4 cv=euzvCIpX c=1 sm=1 tr=0 ts=6a01eeb6 cx=c_pps
 a=MfjaFnPeirRr97d5FC5oHw==:117 a=MfjaFnPeirRr97d5FC5oHw==:17
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=7x6HtfJdh03M6CCDgxCd:22
 a=_1IyUuN4QrATX339ibzo:22 a=VabnemYjAAAA:8 a=Dxuz5bgbLrCaPi_g5IEA:9
 a=gKebqoRLp9LExxC7YDUY:22
X-Proofpoint-ORIG-GUID: c73VIVWMBdTH9NasIsyQrHKwxxnepNAS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-11_04,2026-05-08_02,2025-10-01_01

Since "vfio/pci: Set up barmap in vfio_pci_core_enable()", the
resource request and iomap for the BARs was performed early, and
vfio_pci_core_setup_barmap() just checks those actions succeeded.

Move this logic to a new helper that checks success and returns the
iomap address, replacing the various bare vdev->barmap[] lookups.
This maintains the error behaviour of the previous on-demand
vfio_pci_core_setup_barmap() scheme.

Signed-off-by: Matt Evans <mattev@meta.com>
---
 drivers/vfio/pci/nvgrace-gpu/main.c | 20 ++++++++++++-------
 drivers/vfio/pci/vfio_pci_core.c    | 11 +++++------
 drivers/vfio/pci/vfio_pci_dmabuf.c  |  2 +-
 drivers/vfio/pci/vfio_pci_rdwr.c    | 30 ++++++++---------------------
 drivers/vfio/pci/virtio/legacy_io.c | 13 ++++++-------
 include/linux/vfio_pci_core.h       | 20 ++++++++++++++++++-
 6 files changed, 52 insertions(+), 44 deletions(-)

diff --git a/drivers/vfio/pci/nvgrace-gpu/main.c b/drivers/vfio/pci/nvgrace-gpu/main.c
index fa056b69f899..15e2f03c6cd4 100644
--- a/drivers/vfio/pci/nvgrace-gpu/main.c
+++ b/drivers/vfio/pci/nvgrace-gpu/main.c
@@ -61,6 +61,7 @@ struct nvgrace_gpu_pci_core_device {
 	struct mem_region resmem;
 	/* Lock to control device memory kernel mapping */
 	struct mutex remap_lock;
+	void __iomem *bar0_base;
 	bool has_mig_hw_bug;
 	/* GPU has just been reset */
 	bool reset_done;
@@ -171,6 +172,7 @@ static int nvgrace_gpu_open_device(struct vfio_device *core_vdev)
 	struct nvgrace_gpu_pci_core_device *nvdev =
 		container_of(core_vdev, struct nvgrace_gpu_pci_core_device,
 			     core_device.vdev);
+	void __iomem *io;
 	int ret;
 
 	ret = vfio_pci_core_enable(vdev);
@@ -184,14 +186,14 @@ static int nvgrace_gpu_open_device(struct vfio_device *core_vdev)
 
 	/*
 	 * GPU readiness is checked by reading the BAR0 registers.
-	 *
-	 * ioremap BAR0 to ensure that the BAR0 mapping is present before
-	 * register reads on first fault before establishing any GPU
-	 * memory mapping.
+	 * The BAR map was just set up by vfio_pci_core_enable(), so
+	 * bail early if that wasn't successful:
 	 */
-	ret = vfio_pci_core_setup_barmap(vdev, 0);
-	if (ret)
+	io = vfio_pci_core_get_iomap(vdev, 0);
+	if (IS_ERR(io)) {
+		ret = PTR_ERR(io);
 		goto error_exit;
+	}
 
 	if (nvdev->resmem.memlength) {
 		ret = nvgrace_gpu_vfio_pci_register_pfn_range(core_vdev, &nvdev->resmem);
@@ -204,6 +206,8 @@ static int nvgrace_gpu_open_device(struct vfio_device *core_vdev)
 		goto register_mem_failed;
 
 	vfio_pci_core_finish_enable(vdev);
+	nvdev->bar0_base = io;
+
 	return 0;
 
 register_mem_failed:
@@ -220,6 +224,8 @@ static void nvgrace_gpu_close_device(struct vfio_device *core_vdev)
 		container_of(core_vdev, struct nvgrace_gpu_pci_core_device,
 			     core_device.vdev);
 
+	nvdev->bar0_base = NULL;
+
 	if (nvdev->resmem.memlength)
 		unregister_pfn_address_space(&nvdev->resmem.pfn_address_space);
 
@@ -275,7 +281,7 @@ nvgrace_gpu_check_device_ready(struct nvgrace_gpu_pci_core_device *nvdev)
 	if (!__vfio_pci_memory_enabled(vdev))
 		return -EIO;
 
-	ret = nvgrace_gpu_wait_device_ready(vdev->barmap[0]);
+	ret = nvgrace_gpu_wait_device_ready(nvdev->bar0_base);
 	if (ret)
 		return ret;
 
diff --git a/drivers/vfio/pci/vfio_pci_core.c b/drivers/vfio/pci/vfio_pci_core.c
index 0e4fc17d360f..b1b7fc5183a7 100644
--- a/drivers/vfio/pci/vfio_pci_core.c
+++ b/drivers/vfio/pci/vfio_pci_core.c
@@ -1762,7 +1762,7 @@ int vfio_pci_core_mmap(struct vfio_device *core_vdev, struct vm_area_struct *vma
 	struct pci_dev *pdev = vdev->pdev;
 	unsigned int index;
 	u64 phys_len, req_len, pgoff, req_start;
-	int ret;
+	void __iomem *bar_io;
 
 	index = vma->vm_pgoff >> (VFIO_PCI_OFFSET_SHIFT - PAGE_SHIFT);
 
@@ -1796,12 +1796,11 @@ int vfio_pci_core_mmap(struct vfio_device *core_vdev, struct vm_area_struct *vma
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
index 89165b769e5c..7accd0eac457 100644
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
+vfio_pci_core_get_iomap(struct vfio_pci_core_device *vdev, unsigned int bar)
+{
+	if (WARN_ON_ONCE(bar >= PCI_STD_NUM_BARS))
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

