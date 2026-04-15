Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E62323183F
	for <virtualization@lists.linux.dev>; Wed, 15 Apr 2026 18:16:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.145.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776276962; cv=none; b=APpLAmqeKr0JBcGDqVMJencokU6GbmVP5Sv6zQWtpzjPPS+CP4CPOqFHvqi/lNr6a3LFGHfYOMWdvkPfyeR081V7f1RUKbITr1vpItwXYPI7+JF2nJof7hsObNj8KCDb6HBLp38gzi3QyY+MfNTKb3rs6jNDLmq7IlxY0mMWx0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776276962; c=relaxed/simple;
	bh=wGTcWJpGQcppNxn93n4mDuzPIeQ/q4LmsV+y0aA+XSU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oYNqb4whTsVqp4e+x1DczIOa9cjezy6ForjnWgF5dw8dcV8DDpLmYzJRk6S2vtln7njjO38Kw2W+m8Zf+mrrhTe5oU9PRFyp+SjHUfsujRCqxxGLPBvcwmAjxijZIvWpwPZhEm1NGxrhisK/SVpsN5tLws6NhfTfdBItCPXjuoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=jjs1+meE; arc=none smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="jjs1+meE"
Received: from pps.filterd (m0528008.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63FCa9hc3421983;
	Wed, 15 Apr 2026 11:15:57 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2025-q2;
	 bh=8TWQZr17n8b45tNnyl97mqKymu14xxggI2QCSh+nQ/M=; b=jjs1+meEWE5O
	tYaETyiOMErYlKxORa9e47P9SUPtlgxsmbBOLD2+iL39X0szC7NGcJw4Mtydyrtq
	iXP0JAA8XbYa5nIMW0b8LM3pivA98LFrwbtScMlxb6Qnxs8bU8vVEkFznB0H8/rV
	z89pVAFRkD88lU7tzcdU6F/a3FtsTfTuXq3GhLSA5eOVOPQBum0Gv3s13hEX9yDo
	ztKY4POhS+gHBl3loCMs8WAEnMGgZEl+IhjCrneIBp9vvupxZVg+SPnJNqBf/7wX
	RpoemOwsDDgQ4CkRdU0FNe3m1tS69Al5+dzL/99rPFvbiNTMGDLyarCqIlPm/jjM
	NBaoxay20A==
Received: from maileast.thefacebook.com ([163.114.135.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4dh84vw0k3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Wed, 15 Apr 2026 11:15:57 -0700 (PDT)
Received: from localhost (2620:10d:c0a8:1b::30) by mail.thefacebook.com
 (2620:10d:c0a9:6f::8fd4) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.37; Wed, 15 Apr
 2026 18:15:55 +0000
From: Matt Evans <mattev@meta.com>
To: Alex Williamson <alex@shazbot.org>, Ankit Agrawal <ankita@nvidia.com>,
        Jason Gunthorpe <jgg@ziepe.ca>, Yishai Hadas <yishaih@nvidia.com>,
        Shameer
 Kolothum <skolothumtho@nvidia.com>,
        Kevin Tian <kevin.tian@intel.com>
CC: Alistair Popple <apopple@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
        Vivek Kasireddy <vivek.kasireddy@intel.com>,
        Kees Cook <kees@kernel.org>, Zhi
 Wang <zhiw@nvidia.com>,
        Peter Xu <peterx@redhat.com>, Alexey Kardashevskiy
	<aik@ozlabs.ru>,
        Eric Auger <eric.auger@redhat.com>, <kvm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <virtualization@lists.linux.dev>
Subject: [PATCH 2/2] vfio/pci: Serialise vfio_pci_core_setup_barmap()
Date: Wed, 15 Apr 2026 11:14:23 -0700
Message-ID: <20260415181423.1008458-2-mattev@meta.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260415181423.1008458-1-mattev@meta.com>
References: <20260415181423.1008458-1-mattev@meta.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: AzxvLhAggQvxzfBe4tSmurOp6zDPQ3VJ
X-Authority-Analysis: v=2.4 cv=OYioyBTY c=1 sm=1 tr=0 ts=69dfd5dd cx=c_pps
 a=MfjaFnPeirRr97d5FC5oHw==:117 a=MfjaFnPeirRr97d5FC5oHw==:17
 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22 a=7x6HtfJdh03M6CCDgxCd:22
 a=_1IyUuN4QrATX339ibzo:22 a=VabnemYjAAAA:8 a=MAjz_bzUhYPR0glOfYQA:9
 a=gKebqoRLp9LExxC7YDUY:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDE1MDE3MCBTYWx0ZWRfX+6HZZNtlOqch
 VtuTlB1nMMlnd1SB7Cch77DNoAYhOeGhM0MQraDxalKWdCbhBCpZI57ctBfKX+ukk8gXKQ5nM2Z
 CtgLwCQfp6UapLt4r1lP9ApX9AJBFD5KwpTcaZHgfISlqAFCOpPbIorJsIqKG9MrRjtOa6zOtH2
 EJGU0RlCgiKcYeNy6tgciiwVUBytpw/v844hx2uPh9Wa0dBenRxE8nsl1s+Bu0Ea3zTworLXUuX
 3kw+vLVlc65/WOIcPSTWG3AJkBP/TKL8XS/GHZDYyegYNVD4pMlVqcjCyKuWWqIkG42oFQ7RJlm
 CU+2TBT5IbQx+g07LNu1P0U1xpvJZNHdjOYyFsrsigXpW7DmnYBCdY8CuRVTx3xRAYnImW+wEcv
 Fd8i60oe4pHTVPyS2xdNZhT3rwPqMsFcbzDESIiLOoxFIuG4sSle+f9qNj8GfHZxhXXp1siO96h
 7jFLJxXzRXAAqzJw+pw==
X-Proofpoint-GUID: AzxvLhAggQvxzfBe4tSmurOp6zDPQ3VJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-15_01,2026-04-13_04,2025-10-01_01

vfio_pci_core_setup_barmap() is used in a couple of paths
(vfio_pci_bar_rw(), mmap()) to ensure BARs are mapped before access,
and these paths could execute concurrently.  Concurrent execution of
vfio_pci_core_setup_barmap() could lead to some callers getting
-EBUSY, which would be treated as fatal.

Introduce a new vfio_pci_core_lock_setup_barmap() function, which
takes the vdev->memory_lock for write across BAR initialization.
Current in-kernel use moves to this.

The existing (exported!) vfio_pci_core_setup_barmap() keeps its
'unlocked' behaviour.

Fixes: 7f5764e179c6 ("vfio: use vfio_pci_core_setup_barmap to map bar in mmap")
Fixes: 0d77ed3589ac0 ("vfio/pci: Pull BAR mapping setup from read-write path")
Signed-off-by: Matt Evans <mattev@meta.com>
---
 drivers/vfio/pci/nvgrace-gpu/main.c |  2 +-
 drivers/vfio/pci/vfio_pci_core.c    |  2 +-
 drivers/vfio/pci/vfio_pci_dmabuf.c  |  2 +-
 drivers/vfio/pci/vfio_pci_rdwr.c    | 43 +++++++++++++++++++++++++----
 drivers/vfio/pci/virtio/legacy_io.c |  2 +-
 include/linux/vfio_pci_core.h       |  1 +
 6 files changed, 42 insertions(+), 10 deletions(-)

diff --git a/drivers/vfio/pci/nvgrace-gpu/main.c b/drivers/vfio/pci/nvgrace-gpu/main.c
index fa056b69f899..c1df437754f9 100644
--- a/drivers/vfio/pci/nvgrace-gpu/main.c
+++ b/drivers/vfio/pci/nvgrace-gpu/main.c
@@ -189,7 +189,7 @@ static int nvgrace_gpu_open_device(struct vfio_device *core_vdev)
 	 * register reads on first fault before establishing any GPU
 	 * memory mapping.
 	 */
-	ret = vfio_pci_core_setup_barmap(vdev, 0);
+	ret = vfio_pci_core_lock_setup_barmap(vdev, 0);
 	if (ret)
 		goto error_exit;
 
diff --git a/drivers/vfio/pci/vfio_pci_core.c b/drivers/vfio/pci/vfio_pci_core.c
index 3f8d093aacf8..4e9091e5fcc2 100644
--- a/drivers/vfio/pci/vfio_pci_core.c
+++ b/drivers/vfio/pci/vfio_pci_core.c
@@ -1764,7 +1764,7 @@ int vfio_pci_core_mmap(struct vfio_device *core_vdev, struct vm_area_struct *vma
 	 * Even though we don't make use of the barmap for the mmap,
 	 * we need to request the region and the barmap tracks that.
 	 */
-	ret = vfio_pci_core_setup_barmap(vdev, index);
+	ret = vfio_pci_core_lock_setup_barmap(vdev, index);
 	if (ret)
 		return ret;
 
diff --git a/drivers/vfio/pci/vfio_pci_dmabuf.c b/drivers/vfio/pci/vfio_pci_dmabuf.c
index fefe7cf4256b..281ba7d69567 100644
--- a/drivers/vfio/pci/vfio_pci_dmabuf.c
+++ b/drivers/vfio/pci/vfio_pci_dmabuf.c
@@ -277,7 +277,7 @@ int vfio_pci_core_feature_dma_buf(struct vfio_pci_core_device *vdev, u32 flags,
 	 * were requested before returning DMABUFs that reference
 	 * them.  Barmap setup does this:
 	 */
-	ret = vfio_pci_core_setup_barmap(vdev, get_dma_buf.region_index);
+	ret = vfio_pci_core_lock_setup_barmap(vdev, get_dma_buf.region_index);
 	if (ret)
 		goto err_free_phys;
 
diff --git a/drivers/vfio/pci/vfio_pci_rdwr.c b/drivers/vfio/pci/vfio_pci_rdwr.c
index 4251ee03e146..11e155acf8ef 100644
--- a/drivers/vfio/pci/vfio_pci_rdwr.c
+++ b/drivers/vfio/pci/vfio_pci_rdwr.c
@@ -198,15 +198,12 @@ ssize_t vfio_pci_core_do_io_rw(struct vfio_pci_core_device *vdev, bool test_mem,
 }
 EXPORT_SYMBOL_GPL(vfio_pci_core_do_io_rw);
 
-int vfio_pci_core_setup_barmap(struct vfio_pci_core_device *vdev, int bar)
+static int __vfio_pci_core_iomap_barmap(struct vfio_pci_core_device *vdev, int bar)
 {
 	struct pci_dev *pdev = vdev->pdev;
 	int ret;
 	void __iomem *io;
 
-	if (vdev->barmap[bar])
-		return 0;
-
 	ret = pci_request_selected_regions(pdev, 1 << bar, "vfio");
 	if (ret)
 		return ret;
@@ -221,6 +218,40 @@ int vfio_pci_core_setup_barmap(struct vfio_pci_core_device *vdev, int bar)
 
 	return 0;
 }
+
+int vfio_pci_core_lock_setup_barmap(struct vfio_pci_core_device *vdev, int bar)
+{
+	int ret;
+
+	lockdep_assert_not_held(&vdev->memory_lock);
+
+	if (likely(READ_ONCE(vdev->barmap[bar])))
+		return 0;
+
+	down_write(&vdev->memory_lock);
+	if (unlikely(READ_ONCE(vdev->barmap[bar]))) {
+		up_write(&vdev->memory_lock);
+		return 0;
+	}
+
+	ret = __vfio_pci_core_iomap_barmap(vdev, bar);
+	up_write(&vdev->memory_lock);
+
+	return ret;
+}
+
+int vfio_pci_core_setup_barmap(struct vfio_pci_core_device *vdev, int bar)
+{
+	/*
+	 * An external caller must prevent concurrent calls of this,
+	 * including via other VFIO-internal paths (for example, by
+	 * holding vdev->memory_lock).
+	 */
+	if (vdev->barmap[bar])
+		return 0;
+
+	return __vfio_pci_core_iomap_barmap(vdev, bar);
+}
 EXPORT_SYMBOL_GPL(vfio_pci_core_setup_barmap);
 
 ssize_t vfio_pci_bar_rw(struct vfio_pci_core_device *vdev, char __user *buf,
@@ -274,7 +305,7 @@ ssize_t vfio_pci_bar_rw(struct vfio_pci_core_device *vdev, char __user *buf,
 		 */
 		max_width = VFIO_PCI_IO_WIDTH_4;
 	} else {
-		int ret = vfio_pci_core_setup_barmap(vdev, bar);
+		int ret = vfio_pci_core_lock_setup_barmap(vdev, bar);
 		if (ret) {
 			done = ret;
 			goto out;
@@ -452,7 +483,7 @@ int vfio_pci_ioeventfd(struct vfio_pci_core_device *vdev, loff_t offset,
 	if (count == 8)
 		return -EINVAL;
 
-	ret = vfio_pci_core_setup_barmap(vdev, bar);
+	ret = vfio_pci_core_lock_setup_barmap(vdev, bar);
 	if (ret)
 		return ret;
 
diff --git a/drivers/vfio/pci/virtio/legacy_io.c b/drivers/vfio/pci/virtio/legacy_io.c
index 1ed349a55629..c77064e3f5c4 100644
--- a/drivers/vfio/pci/virtio/legacy_io.c
+++ b/drivers/vfio/pci/virtio/legacy_io.c
@@ -305,7 +305,7 @@ static int virtiovf_set_notify_addr(struct virtiovf_pci_core_device *virtvdev)
 	 * Setup the BAR where the 'notify' exists to be used by vfio as well
 	 * This will let us mmap it only once and use it when needed.
 	 */
-	ret = vfio_pci_core_setup_barmap(core_device,
+	ret = vfio_pci_core_lock_setup_barmap(core_device,
 					 virtvdev->notify_bar);
 	if (ret)
 		return ret;
diff --git a/include/linux/vfio_pci_core.h b/include/linux/vfio_pci_core.h
index 2ebba746c18f..2ea4e773c121 100644
--- a/include/linux/vfio_pci_core.h
+++ b/include/linux/vfio_pci_core.h
@@ -189,6 +189,7 @@ int vfio_pci_core_enable(struct vfio_pci_core_device *vdev);
 void vfio_pci_core_disable(struct vfio_pci_core_device *vdev);
 void vfio_pci_core_finish_enable(struct vfio_pci_core_device *vdev);
 int vfio_pci_core_setup_barmap(struct vfio_pci_core_device *vdev, int bar);
+int vfio_pci_core_lock_setup_barmap(struct vfio_pci_core_device *vdev, int bar);
 pci_ers_result_t vfio_pci_core_aer_err_detected(struct pci_dev *pdev,
 						pci_channel_state_t state);
 ssize_t vfio_pci_core_do_io_rw(struct vfio_pci_core_device *vdev, bool test_mem,
-- 
2.47.3

