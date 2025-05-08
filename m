Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 442AC21D3D1;
	Thu,  8 May 2025 08:51:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746694306; cv=none; b=HZdi03Ij+lrc5xRP5ky2hZFnST9k2O7KWqwcvIEDvbzFWI3aPrjC8b0vicoRSVtpYrMyVkzQlVQBBMQRCG60L0RN9C/gqAzUxXCHhpzzgNp2DUtfZEKdjDyu9zn6HXCk5aer+QV/kp+NboRwNZ8OYcxua+545gQGgrIweyG8bsg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746694306; c=relaxed/simple;
	bh=g4vvz+1sC8PYlJe+IjdoWsQQ0G2aDr2E1sIDxHh/bc8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dQgoCktszqNugkkdUran8XFBNoST2/pa9V7PswyG70aqZN0aAuM7x5YBMrv4fbJ7EfrPI3zgtus1Fu8cfn8sD2kVIlHBochR1oeef/YE9Do6+ezOr+SOMmWvpYLSB57d+BrZVGW1jLw9QKx8g8uF2diajSpk+K3E5Sg2j6NzsTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Cw5QhkPx; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Cw5QhkPx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1D26C4CEE7;
	Thu,  8 May 2025 08:51:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746694305;
	bh=g4vvz+1sC8PYlJe+IjdoWsQQ0G2aDr2E1sIDxHh/bc8=;
	h=From:To:Cc:Subject:Date:From;
	b=Cw5QhkPx446koYPzDN6Fb/2MM1Qu3M9lN4j+KJSVfYC60EkluMmKxqWPeTCq+5oem
	 y7xOpzvcDTXG7p9HAcA2CWybgegwlIepgEyIH1oNGtyXwZZPMbegtOL+oo+XALsBcW
	 R0rX0aD4YR+yKKVl4P9onl7k9ZQlQsvDLLe9XTTn1w43ISSbDov7T5j+qRr8bzST/o
	 TWOfkBLyS4wdVNaTJRXNH1TKRxtZLBEeNDUxPHUGvOdMYDkC/Bbuhh0JdonPIdWxcH
	 AjQOG0X4WV6ElpBRg3W26X9fyReG9EJWyRurPHyr3/IEGMyg9OzdIxoNleI4JYEAP8
	 fcnyMHgh6F2Kw==
From: Philipp Stanner <phasta@kernel.org>
To: schalla@marvell.com,
	vattunuru@marvell.com,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	Shijith Thotton <sthotton@marvell.com>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	Satha Rao <skoteshwar@marvell.com>,
	Philipp Stanner <phasta@kernel.org>
Cc: virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4] vdpa/octeon_ep: Control PCI dev enabling manually
Date: Thu,  8 May 2025 10:51:35 +0200
Message-ID: <20250508085134.24084-2-phasta@kernel.org>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

PCI region request functions such as pci_request_region() currently have
the problem of becoming sometimes managed functions, if
pcim_enable_device() instead of pci_enable_device() was called. The PCI
subsystem wants to remove this deprecated behavior from its interfaces.

octeopn_ep enables its device with pcim_enable_device() (for VF. PF uses
manual management), but does so only to get automatic disablement. The
driver wants to manage its PCI resources for VF manually, without devres.

The easiest way not to use automatic resource management at all is by
also handling device enable- and disablement manually.

Replace pcim_enable_device() with pci_enable_device(). Add the necessary
calls to pci_disable_device().

Signed-off-by: Philipp Stanner <phasta@kernel.org>
Acked-by: Vamsi Attunuru <vattunuru@marvell.com>
---
Changes in v4:
  - s/AF/PF
  - Add Vamsi's AB

Changes in v3:
  - Only call pci_disable_device() for the PF version. For AF it would
    cause a WARN_ON because pcim_enable_device()'s callback will also
    try to disable.
---
 drivers/vdpa/octeon_ep/octep_vdpa_main.c | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/drivers/vdpa/octeon_ep/octep_vdpa_main.c b/drivers/vdpa/octeon_ep/octep_vdpa_main.c
index f3d4dda4e04c..9b49efd24391 100644
--- a/drivers/vdpa/octeon_ep/octep_vdpa_main.c
+++ b/drivers/vdpa/octeon_ep/octep_vdpa_main.c
@@ -454,6 +454,9 @@ static void octep_vdpa_remove_pf(struct pci_dev *pdev)
 		octep_iounmap_region(pdev, octpf->base, OCTEP_HW_MBOX_BAR);
 
 	octep_vdpa_pf_bar_expand(octpf);
+
+	/* The pf version does not use managed PCI. */
+	pci_disable_device(pdev);
 }
 
 static void octep_vdpa_vf_bar_shrink(struct pci_dev *pdev)
@@ -825,7 +828,7 @@ static int octep_vdpa_probe_pf(struct pci_dev *pdev)
 	struct octep_pf *octpf;
 	int ret;
 
-	ret = pcim_enable_device(pdev);
+	ret = pci_enable_device(pdev);
 	if (ret) {
 		dev_err(dev, "Failed to enable device\n");
 		return ret;
@@ -834,15 +837,17 @@ static int octep_vdpa_probe_pf(struct pci_dev *pdev)
 	ret = dma_set_mask_and_coherent(dev, DMA_BIT_MASK(64));
 	if (ret) {
 		dev_err(dev, "No usable DMA configuration\n");
-		return ret;
+		goto disable_pci;
 	}
 	octpf = devm_kzalloc(dev, sizeof(*octpf), GFP_KERNEL);
-	if (!octpf)
-		return -ENOMEM;
+	if (!octpf) {
+		ret = -ENOMEM;
+		goto disable_pci;
+	}
 
 	ret = octep_iomap_region(pdev, octpf->base, OCTEP_HW_MBOX_BAR);
 	if (ret)
-		return ret;
+		goto disable_pci;
 
 	pci_set_master(pdev);
 	pci_set_drvdata(pdev, octpf);
@@ -856,6 +861,8 @@ static int octep_vdpa_probe_pf(struct pci_dev *pdev)
 
 unmap_region:
 	octep_iounmap_region(pdev, octpf->base, OCTEP_HW_MBOX_BAR);
+disable_pci:
+	pci_disable_device(pdev);
 	return ret;
 }
 
-- 
2.48.1

