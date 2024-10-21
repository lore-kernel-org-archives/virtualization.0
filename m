Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 701CC1E4113
	for <virtualization@lists.linux.dev>; Mon, 21 Oct 2024 12:08:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729512529; cv=none; b=ig5MfCFptnHjn8+7sXq1AfPHTWF2x4CfCGfrmnYKPI0q5iofOV7al74lsgj06GoXyvZcrOUqa+To2PpkoY1KIjMJLCceS6e9e3Ga6s/8fEHQ6L7+z9jCyXPjkCVjrtIX5lREK4lm4O5/c16+SPcp8FIfcaIoSVXwSCPrhSsv3ds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729512529; c=relaxed/simple;
	bh=j+GJsbNdGb3n5KiawnqmerPW8nffx8mxZoxb7H8tD/E=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gsNI/Jn8Dkjt4hr53GijqBCU4CvtC1bw+2MY6ETBXp64OqatcJj0/+pQV3HGyDZUN3FQp0ijlLclsAfYiaEelSGaqyq2y/HZPXfEQk8v4EhfbGIbZLn7L1YrdySQfP3G5bYMcPCklQLBNWO7/CgFq8FSGzt6KLngATdXh/DtDQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=YJ/6meCC; arc=none smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="YJ/6meCC"
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49L7X55L026105;
	Mon, 21 Oct 2024 05:08:44 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pfpt0220; bh=4
	SpD7Y0HWT0PK/7D7AOc2lrARoe+J909jM6IJ6l9NEA=; b=YJ/6meCC2957gPJM6
	655UeeCQEiw2R4XleD1FiwyLIJRYHAmAwbeqUZzyq71MVIChmf+mlH4oZ1rR0eI/
	W2IyAww4QlO4OHzYFZ5Y7x4HYUmTVgM0nMlY+6ZmONaSBYqChW57HYKSJu/7cC3d
	Y9pAiIfJgm27ubbSLBL6WUXHuxVtKGJ6UPf9FmjTlOKbLwjS7YNXoowGjVpGXGv5
	dwJgpUFgPC0quXHW1+dLja8HOtlqmtUxTj2YyxpmcpP7pdUu3DoT1eJRTCZOygCZ
	dw0LrLDgsh9u2OGOlzRK76tsYD1L3qst5/F2BLAFyfRGQJAY2QwsXXKtjDDoN2lZ
	MXfUg==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 42djnmrh9p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 21 Oct 2024 05:08:44 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Mon, 21 Oct 2024 05:08:43 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Mon, 21 Oct 2024 05:08:43 -0700
Received: from localhost.localdomain (unknown [10.28.36.175])
	by maili.marvell.com (Postfix) with ESMTP id EF0C83F7052;
	Mon, 21 Oct 2024 05:08:40 -0700 (PDT)
From: Srujana Challa <schalla@marvell.com>
To: <virtualization@lists.linux.dev>, <kvm@vger.kernel.org>
CC: <mst@redhat.com>, <jasowang@redhat.com>, <eperezma@redhat.com>,
        <ndabilpuram@marvell.com>, <jerinj@marvell.com>
Subject: [PATCH v3 1/2] vhost-vdpa: introduce module parameter for no-IOMMU mode
Date: Mon, 21 Oct 2024 17:38:36 +0530
Message-ID: <20241021120837.1438628-2-schalla@marvell.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241021120837.1438628-1-schalla@marvell.com>
References: <20241021120837.1438628-1-schalla@marvell.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: Rw_62OBNltKANjYGmJ42OX6LdJUjc4F8
X-Proofpoint-ORIG-GUID: Rw_62OBNltKANjYGmJ42OX6LdJUjc4F8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01

This commit introduces module parameter
"enable_vhost_vdpa_unsafe_noiommu_mode" to enable an UNSAFE, no-IOMMU
mode in the vhost-vdpa driver. When enabled, this mode provides no
device isolation, no DMA translation, no host kernel protection, and
cannot be used for device assignment to virtual machines.
It requires RAWIO permissions and will taint the kernel.

Signed-off-by: Srujana Challa <schalla@marvell.com>
Change-Id: I6b9bbedb81a8f5031f69707ffc3213d9d5cbc6f5
---
 drivers/vhost/vdpa.c | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/drivers/vhost/vdpa.c b/drivers/vhost/vdpa.c
index 5a49b5a6d496..81dd8bfb152b 100644
--- a/drivers/vhost/vdpa.c
+++ b/drivers/vhost/vdpa.c
@@ -36,6 +36,11 @@ enum {
 
 #define VHOST_VDPA_IOTLB_BUCKETS 16
 
+static bool vhost_vdpa_noiommu;
+module_param_named(enable_vhost_vdpa_unsafe_noiommu_mode,
+		   vhost_vdpa_noiommu, bool, 0644);
+MODULE_PARM_DESC(enable_vhost_vdpa_unsafe_noiommu_mode, "Enable UNSAFE, no-IOMMU mode.  This mode provides no device isolation, no DMA translation, no host kernel protection, cannot be used for device assignment to virtual machines, requires RAWIO permissions, and will taint the kernel.  If you do not know what this is for, step away. (default: false)");
+
 struct vhost_vdpa_as {
 	struct hlist_node hash_link;
 	struct vhost_iotlb iotlb;
@@ -60,6 +65,7 @@ struct vhost_vdpa {
 	struct vdpa_iova_range range;
 	u32 batch_asid;
 	bool suspended;
+	bool noiommu_en;
 };
 
 static DEFINE_IDA(vhost_vdpa_ida);
@@ -910,6 +916,10 @@ static void vhost_vdpa_general_unmap(struct vhost_vdpa *v,
 {
 	struct vdpa_device *vdpa = v->vdpa;
 	const struct vdpa_config_ops *ops = vdpa->config;
+
+	if (v->noiommu_en)
+		return;
+
 	if (ops->dma_map) {
 		ops->dma_unmap(vdpa, asid, map->start, map->size);
 	} else if (ops->set_map == NULL) {
@@ -1003,6 +1013,9 @@ static int vhost_vdpa_map(struct vhost_vdpa *v, struct vhost_iotlb *iotlb,
 	if (r)
 		return r;
 
+	if (v->noiommu_en)
+		goto skip_map;
+
 	if (ops->dma_map) {
 		r = ops->dma_map(vdpa, asid, iova, size, pa, perm, opaque);
 	} else if (ops->set_map) {
@@ -1018,6 +1031,7 @@ static int vhost_vdpa_map(struct vhost_vdpa *v, struct vhost_iotlb *iotlb,
 		return r;
 	}
 
+skip_map:
 	if (!vdpa->use_va)
 		atomic64_add(PFN_DOWN(size), &dev->mm->pinned_vm);
 
@@ -1321,12 +1335,26 @@ static int vhost_vdpa_alloc_domain(struct vhost_vdpa *v)
 	struct vdpa_device *vdpa = v->vdpa;
 	const struct vdpa_config_ops *ops = vdpa->config;
 	struct device *dma_dev = vdpa_get_dma_dev(vdpa);
+	struct iommu_domain *domain;
 	int ret;
 
 	/* Device want to do DMA by itself */
 	if (ops->set_map || ops->dma_map)
 		return 0;
 
+	domain = iommu_get_domain_for_dev(dma_dev);
+	if (!domain && vhost_vdpa_noiommu) {
+		if (!capable(CAP_SYS_RAWIO)) {
+			dev_warn_once(&v->dev, "No RAWIO permissions, couldn't support NOIOMMU\n");
+			return -ENOTSUPP;
+		}
+		add_taint(TAINT_USER, LOCKDEP_STILL_OK);
+		dev_warn(&v->dev, "Adding kernel taint for noiommu on device\n");
+		v->noiommu_en = true;
+		return 0;
+	}
+	v->noiommu_en = false;
+
 	if (!device_iommu_capable(dma_dev, IOMMU_CAP_CACHE_COHERENCY)) {
 		dev_warn_once(&v->dev,
 			      "Failed to allocate domain, device is not IOMMU cache coherent capable\n");
-- 
2.25.1

