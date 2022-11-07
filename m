Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 827F8C4321E
	for <virtualization@archiver.kernel.org>; Mon,  7 Nov 2022 09:42:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 0A7FD60BA1;
	Mon,  7 Nov 2022 09:42:27 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 0A7FD60BA1
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Kkuqf9qe
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 3xEkQ5NYZiYr; Mon,  7 Nov 2022 09:42:26 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 6731C607EC;
	Mon,  7 Nov 2022 09:42:25 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 6731C607EC
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 4A70FC0032;
	Mon,  7 Nov 2022 09:42:25 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id AE8AAC002D
 for <virtualization@lists.linux-foundation.org>;
 Mon,  7 Nov 2022 09:42:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 757A6404FF
 for <virtualization@lists.linux-foundation.org>;
 Mon,  7 Nov 2022 09:42:23 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 757A6404FF
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=Kkuqf9qe
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id YwBJU45KCFnN
 for <virtualization@lists.linux-foundation.org>;
 Mon,  7 Nov 2022 09:42:22 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org A70F440391
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
 by smtp2.osuosl.org (Postfix) with ESMTPS id A70F440391
 for <virtualization@lists.linux-foundation.org>;
 Mon,  7 Nov 2022 09:42:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1667814142; x=1699350142;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=iFUBVXGqqQcvNJnn0mEHX46qen+2fKl508MhpYLUrbw=;
 b=Kkuqf9qe95MVKYmcCsFMj3jVwTVNv3LTVSA5ohQb7l35qXPP9dpYeprq
 wRLadlWuBUI0L2c7a+C1pAS4UIFVI91s2hSsayUMb0gCLZYaD9kD55tQT
 WkJZ3LjDN0c7wNR2hVuUJ2EFJwF+EdbNRtd8uO+iCtilreqfEQiJzS2oe
 ROkROOeg3H8YzZFQhoCFvJpo0/g8Vt6z3s1McV1dmQX10mp1+5iIQGfFX
 /aZiL7Fmv/ewS3brkc3sAzUIiC6NbBd83wo8wPuSTQSkWybqdEM4Y4R9b
 QZURP156mZmCxG9HaslqWZMTdnb9ulIZv6ecopC4CHLySC3Q8uI9e5rop w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10523"; a="396668852"
X-IronPort-AV: E=Sophos;i="5.96,143,1665471600"; d="scan'208";a="396668852"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
 by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Nov 2022 01:42:22 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10523"; a="704810807"
X-IronPort-AV: E=Sophos;i="5.96,143,1665471600"; d="scan'208";a="704810807"
Received: from unknown (HELO localhost.localdomain.bj.intel.com)
 ([10.240.193.73])
 by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Nov 2022 01:42:20 -0800
From: Zhu Lingshan <lingshan.zhu@intel.com>
To: jasowang@redhat.com,
	mst@redhat.com
Subject: [PATCH 2/4] vDPA/ifcvf: IRQ interfaces work on ifcvf_hw
Date: Mon,  7 Nov 2022 17:33:43 +0800
Message-Id: <20221107093345.121648-3-lingshan.zhu@intel.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20221107093345.121648-1-lingshan.zhu@intel.com>
References: <20221107093345.121648-1-lingshan.zhu@intel.com>
MIME-Version: 1.0
Cc: piotr.uminski@intel.com, hang.yuan@intel.com, kvm@vger.kernel.org,
 virtualization@lists.linux-foundation.org
X-BeenThere: virtualization@lists.linux-foundation.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: Linux virtualization <virtualization.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>, 
 <mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>, 
 <mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

In this commit, ifcvf IRQ interfaces work on ifcvf_hw,
so these functions can be safely invoked before
the adapter struct is allocated since probe.

Signed-off-by: Zhu Lingshan <lingshan.zhu@intel.com>
---
 drivers/vdpa/ifcvf/ifcvf_main.c | 85 ++++++++++++++-------------------
 1 file changed, 37 insertions(+), 48 deletions(-)

diff --git a/drivers/vdpa/ifcvf/ifcvf_main.c b/drivers/vdpa/ifcvf/ifcvf_main.c
index f9c0044c6442..bae518ff6234 100644
--- a/drivers/vdpa/ifcvf/ifcvf_main.c
+++ b/drivers/vdpa/ifcvf/ifcvf_main.c
@@ -69,10 +69,9 @@ static void ifcvf_free_irq_vectors(void *data)
 	pci_free_irq_vectors(data);
 }
 
-static void ifcvf_free_per_vq_irq(struct ifcvf_adapter *adapter)
+static void ifcvf_free_per_vq_irq(struct ifcvf_hw *vf)
 {
-	struct pci_dev *pdev = adapter->pdev;
-	struct ifcvf_hw *vf = &adapter->vf;
+	struct pci_dev *pdev = vf->pdev;
 	int i;
 
 	for (i = 0; i < vf->nr_vring; i++) {
@@ -83,10 +82,9 @@ static void ifcvf_free_per_vq_irq(struct ifcvf_adapter *adapter)
 	}
 }
 
-static void ifcvf_free_vqs_reused_irq(struct ifcvf_adapter *adapter)
+static void ifcvf_free_vqs_reused_irq(struct ifcvf_hw *vf)
 {
-	struct pci_dev *pdev = adapter->pdev;
-	struct ifcvf_hw *vf = &adapter->vf;
+	struct pci_dev *pdev = vf->pdev;
 
 	if (vf->vqs_reused_irq != -EINVAL) {
 		devm_free_irq(&pdev->dev, vf->vqs_reused_irq, vf);
@@ -95,20 +93,18 @@ static void ifcvf_free_vqs_reused_irq(struct ifcvf_adapter *adapter)
 
 }
 
-static void ifcvf_free_vq_irq(struct ifcvf_adapter *adapter)
+static void ifcvf_free_vq_irq(struct ifcvf_hw *vf)
 {
-	struct ifcvf_hw *vf = &adapter->vf;
 
 	if (vf->msix_vector_status == MSIX_VECTOR_PER_VQ_AND_CONFIG)
-		ifcvf_free_per_vq_irq(adapter);
+		ifcvf_free_per_vq_irq(vf);
 	else
-		ifcvf_free_vqs_reused_irq(adapter);
+		ifcvf_free_vqs_reused_irq(vf);
 }
 
-static void ifcvf_free_config_irq(struct ifcvf_adapter *adapter)
+static void ifcvf_free_config_irq(struct ifcvf_hw *vf)
 {
-	struct pci_dev *pdev = adapter->pdev;
-	struct ifcvf_hw *vf = &adapter->vf;
+	struct pci_dev *pdev = vf->pdev;
 
 	if (vf->config_irq == -EINVAL)
 		return;
@@ -123,12 +119,12 @@ static void ifcvf_free_config_irq(struct ifcvf_adapter *adapter)
 	}
 }
 
-static void ifcvf_free_irq(struct ifcvf_adapter *adapter)
+static void ifcvf_free_irq(struct ifcvf_hw *vf)
 {
-	struct pci_dev *pdev = adapter->pdev;
+	struct pci_dev *pdev = vf->pdev;
 
-	ifcvf_free_vq_irq(adapter);
-	ifcvf_free_config_irq(adapter);
+	ifcvf_free_vq_irq(vf);
+	ifcvf_free_config_irq(vf);
 	ifcvf_free_irq_vectors(pdev);
 }
 
@@ -137,10 +133,9 @@ static void ifcvf_free_irq(struct ifcvf_adapter *adapter)
  * It returns the number of allocated vectors, negative
  * return value when fails.
  */
-static int ifcvf_alloc_vectors(struct ifcvf_adapter *adapter)
+static int ifcvf_alloc_vectors(struct ifcvf_hw *vf)
 {
-	struct pci_dev *pdev = adapter->pdev;
-	struct ifcvf_hw *vf = &adapter->vf;
+	struct pci_dev *pdev = vf->pdev;
 	int max_intr, ret;
 
 	/* all queues and config interrupt  */
@@ -160,10 +155,9 @@ static int ifcvf_alloc_vectors(struct ifcvf_adapter *adapter)
 	return ret;
 }
 
-static int ifcvf_request_per_vq_irq(struct ifcvf_adapter *adapter)
+static int ifcvf_request_per_vq_irq(struct ifcvf_hw *vf)
 {
-	struct pci_dev *pdev = adapter->pdev;
-	struct ifcvf_hw *vf = &adapter->vf;
+	struct pci_dev *pdev = vf->pdev;
 	int i, vector, ret, irq;
 
 	vf->vqs_reused_irq = -EINVAL;
@@ -190,15 +184,14 @@ static int ifcvf_request_per_vq_irq(struct ifcvf_adapter *adapter)
 
 	return 0;
 err:
-	ifcvf_free_irq(adapter);
+	ifcvf_free_irq(vf);
 
 	return -EFAULT;
 }
 
-static int ifcvf_request_vqs_reused_irq(struct ifcvf_adapter *adapter)
+static int ifcvf_request_vqs_reused_irq(struct ifcvf_hw *vf)
 {
-	struct pci_dev *pdev = adapter->pdev;
-	struct ifcvf_hw *vf = &adapter->vf;
+	struct pci_dev *pdev = vf->pdev;
 	int i, vector, ret, irq;
 
 	vector = 0;
@@ -224,15 +217,14 @@ static int ifcvf_request_vqs_reused_irq(struct ifcvf_adapter *adapter)
 
 	return 0;
 err:
-	ifcvf_free_irq(adapter);
+	ifcvf_free_irq(vf);
 
 	return -EFAULT;
 }
 
-static int ifcvf_request_dev_irq(struct ifcvf_adapter *adapter)
+static int ifcvf_request_dev_irq(struct ifcvf_hw *vf)
 {
-	struct pci_dev *pdev = adapter->pdev;
-	struct ifcvf_hw *vf = &adapter->vf;
+	struct pci_dev *pdev = vf->pdev;
 	int i, vector, ret, irq;
 
 	vector = 0;
@@ -265,29 +257,27 @@ static int ifcvf_request_dev_irq(struct ifcvf_adapter *adapter)
 
 	return 0;
 err:
-	ifcvf_free_irq(adapter);
+	ifcvf_free_irq(vf);
 
 	return -EFAULT;
 
 }
 
-static int ifcvf_request_vq_irq(struct ifcvf_adapter *adapter)
+static int ifcvf_request_vq_irq(struct ifcvf_hw *vf)
 {
-	struct ifcvf_hw *vf = &adapter->vf;
 	int ret;
 
 	if (vf->msix_vector_status == MSIX_VECTOR_PER_VQ_AND_CONFIG)
-		ret = ifcvf_request_per_vq_irq(adapter);
+		ret = ifcvf_request_per_vq_irq(vf);
 	else
-		ret = ifcvf_request_vqs_reused_irq(adapter);
+		ret = ifcvf_request_vqs_reused_irq(vf);
 
 	return ret;
 }
 
-static int ifcvf_request_config_irq(struct ifcvf_adapter *adapter)
+static int ifcvf_request_config_irq(struct ifcvf_hw *vf)
 {
-	struct pci_dev *pdev = adapter->pdev;
-	struct ifcvf_hw *vf = &adapter->vf;
+	struct pci_dev *pdev = vf->pdev;
 	int config_vector, ret;
 
 	if (vf->msix_vector_status == MSIX_VECTOR_PER_VQ_AND_CONFIG)
@@ -320,17 +310,16 @@ static int ifcvf_request_config_irq(struct ifcvf_adapter *adapter)
 
 	return 0;
 err:
-	ifcvf_free_irq(adapter);
+	ifcvf_free_irq(vf);
 
 	return -EFAULT;
 }
 
-static int ifcvf_request_irq(struct ifcvf_adapter *adapter)
+static int ifcvf_request_irq(struct ifcvf_hw *vf)
 {
-	struct ifcvf_hw *vf = &adapter->vf;
 	int nvectors, ret, max_intr;
 
-	nvectors = ifcvf_alloc_vectors(adapter);
+	nvectors = ifcvf_alloc_vectors(vf);
 	if (nvectors <= 0)
 		return -EFAULT;
 
@@ -341,16 +330,16 @@ static int ifcvf_request_irq(struct ifcvf_adapter *adapter)
 
 	if (nvectors == 1) {
 		vf->msix_vector_status = MSIX_VECTOR_DEV_SHARED;
-		ret = ifcvf_request_dev_irq(adapter);
+		ret = ifcvf_request_dev_irq(vf);
 
 		return ret;
 	}
 
-	ret = ifcvf_request_vq_irq(adapter);
+	ret = ifcvf_request_vq_irq(vf);
 	if (ret)
 		return ret;
 
-	ret = ifcvf_request_config_irq(adapter);
+	ret = ifcvf_request_config_irq(vf);
 
 	if (ret)
 		return ret;
@@ -479,7 +468,7 @@ static void ifcvf_vdpa_set_status(struct vdpa_device *vdpa_dev, u8 status)
 
 	if ((status & VIRTIO_CONFIG_S_DRIVER_OK) &&
 	    !(status_old & VIRTIO_CONFIG_S_DRIVER_OK)) {
-		ret = ifcvf_request_irq(adapter);
+		ret = ifcvf_request_irq(vf);
 		if (ret) {
 			status = ifcvf_get_status(vf);
 			status |= VIRTIO_CONFIG_S_FAILED;
@@ -511,7 +500,7 @@ static int ifcvf_vdpa_reset(struct vdpa_device *vdpa_dev)
 
 	if (status_old & VIRTIO_CONFIG_S_DRIVER_OK) {
 		ifcvf_stop_datapath(adapter);
-		ifcvf_free_irq(adapter);
+		ifcvf_free_irq(vf);
 	}
 
 	ifcvf_reset_vring(adapter);
-- 
2.31.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
