Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30DDC1F4E34;
	Wed, 23 Apr 2025 10:39:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745404762; cv=none; b=Z6qzcmLbuX9ynGPsZLk3ACMlSnLazOF1Lpxdp69hcQ/gWSeabJvlfCHJ1//32HGpudO3nUxdMvTe1GEa6UIMoBKmcMmDAdp/SiA/v0IBEvhXvqgTvVGTWUyLGM4GUXOhWSo5SFfB4yZcMbGm8j/0PJLqIsc+NfYn8s6HzUDkJGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745404762; c=relaxed/simple;
	bh=L38rUG5wPLUQXtgLHAxhiCmtpixpe4I0L/kYxUZcG+Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EmxMfJ5TpQiYdws9SLGT/AwgLe0LByeX3L+Xw9Ac5XPdyyMHkLHMQST74NGcFZabSQnljMNVsbX3cLVUDNwTlrkXmWefPc6fbT9Lp5XzvWbCxj7+AbZ0P0IQK+B6qK4/g/nOnxHrtooDkhN1nATCukulPBbHirD6N5OQ6jsG8g8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b7+HHqMW; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b7+HHqMW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90D9EC4CEE2;
	Wed, 23 Apr 2025 10:39:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745404761;
	bh=L38rUG5wPLUQXtgLHAxhiCmtpixpe4I0L/kYxUZcG+Y=;
	h=From:To:Cc:Subject:Date:From;
	b=b7+HHqMWZB9Z80VulErNfm301h2c7v+UKpHbCWSGKHmrTeCo3XejfOEkz8Nvn3XYm
	 yK4w1Nj4FTBcThxvbyBV+MdqfhoN9mQFNN8P8FaKrnt8z7WVFKwR55PtDrnsibrAhe
	 ttBnppn8p46TbOF0ucMmZGcpR07Jr/IMC9JzSapbvslV+WU3XRLCu1l0rpxubDN01f
	 mukhUSSnxNlRkBSXqhkP6KHA3707EelUVrHS72fQ2B+pVMly3IzD2Xq5GDGF0wokey
	 D+7DPjrxkKhhjmKxHfrIGVlhrFL44KVKWNRV4KWFoxelQwlAS0daCtLw1pQRTpoKiE
	 x0ZYL7JKR71TA==
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
Subject: [PATCH v2] vdpa/octeon_ep: Control PCI dev enabling manually
Date: Wed, 23 Apr 2025 12:39:10 +0200
Message-ID: <20250423103909.59063-2-phasta@kernel.org>
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

octeopn_ep enables its device with pcim_enable_device(), but does so
only to get automatic disablement. The driver wants to manage its PCI
resources manually, without devres.

The easiest way not to use automatic resource management at all is by
also handling device enable- and disablement manually.

Replace pcim_enable_device() with pci_enable_device(). Add the necessary
calls to pci_disable_device().

Signed-off-by: Philipp Stanner <phasta@kernel.org>
---
Was formerly called "Use non-hybrid PCI devres API"

Changes in v2:
  - Don't replace the request functions. Enable / disable manually
    instead. (Vamsi)
---
 drivers/vdpa/octeon_ep/octep_vdpa_main.c | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/drivers/vdpa/octeon_ep/octep_vdpa_main.c b/drivers/vdpa/octeon_ep/octep_vdpa_main.c
index f3d4dda4e04c..0a282f9186f4 100644
--- a/drivers/vdpa/octeon_ep/octep_vdpa_main.c
+++ b/drivers/vdpa/octeon_ep/octep_vdpa_main.c
@@ -492,6 +492,8 @@ static void octep_vdpa_remove(struct pci_dev *pdev)
 		octep_vdpa_remove_vf(pdev);
 	else
 		octep_vdpa_remove_pf(pdev);
+
+	pci_disable_device(pdev);
 }
 
 static int octep_vdpa_dev_add(struct vdpa_mgmt_dev *mdev, const char *name,
@@ -825,7 +827,7 @@ static int octep_vdpa_probe_pf(struct pci_dev *pdev)
 	struct octep_pf *octpf;
 	int ret;
 
-	ret = pcim_enable_device(pdev);
+	ret = pci_enable_device(pdev);
 	if (ret) {
 		dev_err(dev, "Failed to enable device\n");
 		return ret;
@@ -834,15 +836,17 @@ static int octep_vdpa_probe_pf(struct pci_dev *pdev)
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
@@ -856,6 +860,8 @@ static int octep_vdpa_probe_pf(struct pci_dev *pdev)
 
 unmap_region:
 	octep_iounmap_region(pdev, octpf->base, OCTEP_HW_MBOX_BAR);
+disable_pci:
+	pci_disable_device(pdev);
 	return ret;
 }
 
-- 
2.48.1

