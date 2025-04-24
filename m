Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B94622DF9B;
	Thu, 24 Apr 2025 11:49:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745495348; cv=none; b=SyofkH2Z4gHhaSseVdeo+vJYJxTNiFkoCooirNB1xfE19XlM8isPjhKWySV7eywrJtqVPs63mDeh8nfObCYiY4BbQUty5tvoCTJH3lC5SkrAau2A/EzoggDVH+vKCAHuDoSpKpdyM7iwufqgwx3Ccs8wiyKAbdG7CWUVF40P/Gk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745495348; c=relaxed/simple;
	bh=YszgFMEifreBpsMwGircv5QIeLTFD0j7nAEcYCOWvVQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rEm3yVhe3A06iNtZJoelPJP5/+cgtNQ43Nyhqmg9RHritj/QVG2o6RF3/qZFt9V+2BEIqZ5FgTCxv7J6o84mdN5jgADKrCU61Ff6JQKdQ42nLwVCpJ3yb97nmn846Jdue4ZYWLtOIICd+p0JRGzwPmS3G0U9CbDZ3xNTIhKJQJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Mleqz8TQ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Mleqz8TQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A7F0C4CEE3;
	Thu, 24 Apr 2025 11:49:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745495348;
	bh=YszgFMEifreBpsMwGircv5QIeLTFD0j7nAEcYCOWvVQ=;
	h=From:To:Cc:Subject:Date:From;
	b=Mleqz8TQ7U+Pi7a+4PHn/kY69ycMeNpkNmBUap9Ga1d1SCv8s3mILXeDsn/QM3hQJ
	 bz0qvaxDERfv8wAN5oceaCVpoDAQtlI9nlbdDjDyHzHB4UU3iSKanSfnh8yomtNEUM
	 qwZrsEAy65mmP8b3rjrigMxDFgVuHkCb0++t1IxPpqkw/7/HbL5wIwdF2nxBKM1I/H
	 poPlG96nqwUCZHYzS01lINcyP5w1j/3MFFu9htKhAZ9qyCVaov2FTHQAJkQ+Lxk7sM
	 6Nyf7OmGjBVF/HSVBm+LsQZzcYcqm3pR2AqFaFa/+Ms0efyWZ+tny8G6dumRFkxv5t
	 oP0mmvToo9VwQ==
From: Philipp Stanner <phasta@kernel.org>
To: schalla@marvell.com,
	vattunuru@marvell.com,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	Shijith Thotton <sthotton@marvell.com>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	Philipp Stanner <phasta@kernel.org>,
	Satha Rao <skoteshwar@marvell.com>
Cc: virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3] vdpa/octeon_ep: Control PCI dev enabling manually
Date: Thu, 24 Apr 2025 13:48:51 +0200
Message-ID: <20250424114850.34045-2-phasta@kernel.org>
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

octeopn_ep enables its device with pcim_enable_device() (for AF. PF uses
manual management), but does so only to get automatic disablement. The
driver wants to manage its PCI resources for AF manually, without devres.

The easiest way not to use automatic resource management at all is by
also handling device enable- and disablement manually.

Replace pcim_enable_device() with pci_enable_device(). Add the necessary
calls to pci_disable_device().

Signed-off-by: Philipp Stanner <phasta@kernel.org>
---
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

