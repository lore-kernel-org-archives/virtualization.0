Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B56033242AB
	for <virtualization@lists.linux.dev>; Tue, 21 Apr 2026 17:42:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.145.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776793327; cv=none; b=CXTh0W4z2pXxVutSvZxu3UbAFHZOYvhyv3IDvyLQFz6LfpadwJoKdF/9OZvaYBccWI5XYdv8mXHaoICDJQ2e89st3sduO2rk7tqmcL+WqZAgybek36X8Ymb/tRYHOkIK+XIb+VTQk+DUc6sPeiszVYwnKskFrPha/OtnjHNefKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776793327; c=relaxed/simple;
	bh=llIY7xSaOkEj+G+PT2pLcrAq94SlFlIN/oRet/cVjqY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gsFEm2jeaHRCC3McCuC94KjEHPQTRgCvIKJZ0e2C7ec2klucG+Q5MB4sRadrB91j3fErjkIzabgvNd6zxXtHyTM/Uw4aU0prrXZFeNsDgIcD22AyMXs1bne120MTWfq1DsMlursRghW/+CJWQq4FRE0rjd+uC4+sGGlxNvNSFLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=nJDuv8VX; arc=none smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="nJDuv8VX"
Received: from pps.filterd (m0528008.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63LHKw8I3579011;
	Tue, 21 Apr 2026 10:42:02 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2025-q2;
	 bh=WevERmmtCvd8InNrpuwVz010uP+4eFXvtcbOI8hMzCU=; b=nJDuv8VXGRD5
	9p9adk4N0t2P9ZhvQNdeV6IagLtgqnOz+xGPkM5uhWMKVCBSechwGCgUtbA9K9Ka
	obYFX7NYZHb9ov1dm/mgOZ3p1UXUVisEzMV8rk3KYnDIz8o9i2UXVygcG3wD+LWn
	NzmZkvLjtDTspSuodaL4dRf9a8JY5I4Ubl0mIeUDJ0Pyce5fqOnuHybGgF3wWKfY
	mlzvhoFCb0f9N9Y1pfhRoeEv8U9mNj+OInpEOM+SYBE0lG6mf2al0V+AUZFXcAtw
	emOpMLjMd0+QSPZVo9rk6J1w3IhQI3bOsBUbVOIWtxvTvs6JsAA4GgV8WNfVQ9n3
	oBC4p8QFiA==
Received: from mail.thefacebook.com ([163.114.134.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4dmxjgwr6d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Tue, 21 Apr 2026 10:42:01 -0700 (PDT)
Received: from localhost (2620:10d:c085:208::7cb7) by mail.thefacebook.com
 (2620:10d:c08b:78::c78f) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.37; Tue, 21 Apr
 2026 17:41:54 +0000
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
Subject: [PATCH 2/2] vfio/pci: Remove vfio_pci_core_setup_barmap()
Date: Tue, 21 Apr 2026 10:41:41 -0700
Message-ID: <20260421174143.3883579-3-mattev@meta.com>
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
X-Proofpoint-ORIG-GUID: oy2likjbj8ZzDPf_DsOTqvdW70Z8ymyK
X-Authority-Analysis: v=2.4 cv=WsIb99fv c=1 sm=1 tr=0 ts=69e7b6ea cx=c_pps
 a=CB4LiSf2rd0gKozIdrpkBw==:117 a=CB4LiSf2rd0gKozIdrpkBw==:17
 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22 a=7x6HtfJdh03M6CCDgxCd:22
 a=_1IyUuN4QrATX339ibzo:22 a=VabnemYjAAAA:8 a=hddtpw1Fc0ytyWcZ_ioA:9
 a=gKebqoRLp9LExxC7YDUY:22
X-Proofpoint-GUID: oy2likjbj8ZzDPf_DsOTqvdW70Z8ymyK
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDIxMDE3NiBTYWx0ZWRfXw3Wdcj/gKDAt
 dtIGiqnQKWJWdPv87YDmdDBR0jXuxZfkKWvMjknH2zlIGGjNcGLGBrPBcms7DPntBSxG4nW8+DZ
 7qraDezbtr51jrXAtMSiHMEiHU9LrDUyfVV4UPT/5qvKGi0pNFLckMQmsfVYgr0j/tPTTEt9DSf
 aPNBwd+WJqooGvgwWQ04ztx9JbVF7S8LD29/uL+aeOnPA5GSV/fe9aIrO1i1yGjPhDhYDOzSYOn
 IbIpe3HxiikvOzaZhyFly2GT2BSJOUa4rcUPW9KoppaH5NdA/vxpX8UJtv+kymCcgVSX1fh199w
 /Kkdo5fcyiPnFmoQ6ygIpMNqJ+gva9lLEZfUxDyQYry0c6p5O3fHTgwGoz5igLnq51Ho8/VQTQv
 cOaQHbv6WkO/t+iq8JUDg5CnVUfVZN1Pq/NIWdDaij29TXEoAnDjdNLED7Cg36utOYbk9TWrrT4
 LLyJtekDM9eitM2OjZg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-21_03,2026-04-21_02,2025-10-01_01

Since "vfio/pci: Set up barmap in vfio_pci_core_enable()", the BAR
mapping and resource acquisition are done at setup time, and most uses
of vfio_pci_core_setup_barmap() are now unnecessary.  Remove the
callers, and the function.

Some callers used it to also test if a mapping is present before a
direct access, and these places now do a simple test of
vdev->barmap[].

Signed-off-by: Matt Evans <mattev@meta.com>
---
 drivers/vfio/pci/nvgrace-gpu/main.c | 11 +++++------
 drivers/vfio/pci/vfio_pci_core.c    |  8 --------
 drivers/vfio/pci/vfio_pci_rdwr.c    | 22 ++++------------------
 drivers/vfio/pci/virtio/legacy_io.c |  5 ++---
 4 files changed, 11 insertions(+), 35 deletions(-)

diff --git a/drivers/vfio/pci/nvgrace-gpu/main.c b/drivers/vfio/pci/nvgrace-gpu/main.c
index fa056b69f899..3712f6b54d46 100644
--- a/drivers/vfio/pci/nvgrace-gpu/main.c
+++ b/drivers/vfio/pci/nvgrace-gpu/main.c
@@ -184,14 +184,13 @@ static int nvgrace_gpu_open_device(struct vfio_device *core_vdev)
 
 	/*
 	 * GPU readiness is checked by reading the BAR0 registers.
-	 *
-	 * ioremap BAR0 to ensure that the BAR0 mapping is present before
-	 * register reads on first fault before establishing any GPU
-	 * memory mapping.
+	 * BARs should have been mapped at device enable, but it's
+	 * good to assert they're present before the access:
 	 */
-	ret = vfio_pci_core_setup_barmap(vdev, 0);
-	if (ret)
+	if (!vdev->barmap[0]) {
+		ret = -EINVAL;
 		goto error_exit;
+	}
 
 	if (nvdev->resmem.memlength) {
 		ret = nvgrace_gpu_vfio_pci_register_pfn_range(core_vdev, &nvdev->resmem);
diff --git a/drivers/vfio/pci/vfio_pci_core.c b/drivers/vfio/pci/vfio_pci_core.c
index 4a314213f3ae..228d92ce61d1 100644
--- a/drivers/vfio/pci/vfio_pci_core.c
+++ b/drivers/vfio/pci/vfio_pci_core.c
@@ -1805,14 +1805,6 @@ int vfio_pci_core_mmap(struct vfio_device *core_vdev, struct vm_area_struct *vma
 	if (req_start + req_len > phys_len)
 		return -EINVAL;
 
-	/*
-	 * Even though we don't make use of the barmap for the mmap,
-	 * we need to request the region and the barmap tracks that.
-	 */
-	ret = vfio_pci_core_setup_barmap(vdev, index);
-	if (ret)
-		return ret;
-
 	vma->vm_private_data = vdev;
 	vma->vm_page_prot = pgprot_noncached(vma->vm_page_prot);
 	vma->vm_page_prot = pgprot_decrypted(vma->vm_page_prot);
diff --git a/drivers/vfio/pci/vfio_pci_rdwr.c b/drivers/vfio/pci/vfio_pci_rdwr.c
index d1386a31a3a3..21e19ed48bf5 100644
--- a/drivers/vfio/pci/vfio_pci_rdwr.c
+++ b/drivers/vfio/pci/vfio_pci_rdwr.c
@@ -198,18 +198,6 @@ ssize_t vfio_pci_core_do_io_rw(struct vfio_pci_core_device *vdev, bool test_mem,
 }
 EXPORT_SYMBOL_GPL(vfio_pci_core_do_io_rw);
 
-int vfio_pci_core_setup_barmap(struct vfio_pci_core_device *vdev, int bar)
-{
-	/*
-	 * The barmap is now always set up in vfio_pci_core_enable().
-	 * Some legacy callers use this function to check if the BAR
-	 * is legitimate, so maintain that:
-	 */
-
-	return vdev->barmap[bar] ? 0 : -EBUSY;
-}
-EXPORT_SYMBOL_GPL(vfio_pci_core_setup_barmap);
-
 ssize_t vfio_pci_bar_rw(struct vfio_pci_core_device *vdev, char __user *buf,
 			size_t count, loff_t *ppos, bool iswrite)
 {
@@ -261,9 +249,8 @@ ssize_t vfio_pci_bar_rw(struct vfio_pci_core_device *vdev, char __user *buf,
 		 */
 		max_width = VFIO_PCI_IO_WIDTH_4;
 	} else {
-		int ret = vfio_pci_core_setup_barmap(vdev, bar);
-		if (ret) {
-			done = ret;
+		if (!vdev->barmap[bar]) {
+			done = -EINVAL;
 			goto out;
 		}
 
@@ -439,9 +426,8 @@ int vfio_pci_ioeventfd(struct vfio_pci_core_device *vdev, loff_t offset,
 	if (count == 8)
 		return -EINVAL;
 
-	ret = vfio_pci_core_setup_barmap(vdev, bar);
-	if (ret)
-		return ret;
+	if (!vdev->barmap[bar])
+		return -EINVAL;
 
 	mutex_lock(&vdev->ioeventfds_lock);
 
diff --git a/drivers/vfio/pci/virtio/legacy_io.c b/drivers/vfio/pci/virtio/legacy_io.c
index 1ed349a55629..67f93b96c099 100644
--- a/drivers/vfio/pci/virtio/legacy_io.c
+++ b/drivers/vfio/pci/virtio/legacy_io.c
@@ -305,9 +305,8 @@ static int virtiovf_set_notify_addr(struct virtiovf_pci_core_device *virtvdev)
 	 * Setup the BAR where the 'notify' exists to be used by vfio as well
 	 * This will let us mmap it only once and use it when needed.
 	 */
-	ret = vfio_pci_core_setup_barmap(core_device,
-					 virtvdev->notify_bar);
-	if (ret)
+	if (virtvdev->notify_bar >= PCI_STD_NUM_BARS ||
+	    !core_device->barmap[virtvdev->notify_bar])
 		return ret;
 
 	virtvdev->notify_addr = core_device->barmap[virtvdev->notify_bar] +
-- 
2.47.3

