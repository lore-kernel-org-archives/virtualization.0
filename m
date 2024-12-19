Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0887619C569;
	Thu, 19 Dec 2024 09:44:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734601494; cv=none; b=lJrpijp1o2op1frg1eDxjHYCaSL1Kgl9x1k2LEyb6Jc8PFlUZRnPeylGka1ZMkhcBwWaJWQriZ4ageu404dXw4ETsm3UDqBDSUXj8JqAENQ4RB0zXmksPfncrW0bDTpYdxkv7Nic+l3h0hypeTdWIMX3QFyqE0PxvP1ylEgPip4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734601494; c=relaxed/simple;
	bh=PkLmEmXcHJxnSZqnRVtAiihctT5CtwZoFyVCMBynPGs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=iNco19dWzO3x23Xad9W5KfvREW0NshMzA+qqDzSgGtqyBU8RakuJKWWCIurXpJqsi8xIuAkYwuqXMQVZmLmXgzOaCITUjhX5Ja2c6GUENYyYGYshhOI/K1tDVnfkEYrDzjelAHtjk+d7uJgEK8hjkhqmjql+c7Yz6dX7mheksjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E12WW/6M; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E12WW/6M"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60769C4CECE;
	Thu, 19 Dec 2024 09:44:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734601493;
	bh=PkLmEmXcHJxnSZqnRVtAiihctT5CtwZoFyVCMBynPGs=;
	h=From:To:Cc:Subject:Date:From;
	b=E12WW/6M3wFKEJYUBsmlofWsddnnxPNgLH6IYoO4uzdlYrcDtGS3yi2bLQbiNJD1J
	 f2dDfLgI6qbs2+WcA+BbUROC2TgvImEjJo9fOiNXvjhqBY4NGRdVh53cIReBC31EdW
	 rF4bpbCyYo1OgpGSQd38bC1mjoZhe7OR2qlTQlGmXeNDvezj1Zt6sdllGKUH9m3wUz
	 qEt1ROIwOTee98uQunNOsar74/QDP6Jc933wg22ll8GDImmoyfhAYzUZH7BqRB2Hec
	 LFY33mP66PrJ/J089eKcbAQ6MFdnzlPyw4UuQQ1ff7Xxf2h5zwtue7Chusqh2Uu9jA
	 u8AtTmkUta8JQ==
From: Philipp Stanner <phasta@kernel.org>
To: Alvaro Karsz <alvaro.karsz@solid-run.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	Philipp Stanner <pstanner@redhat.com>,
	Stefano Garzarella <sgarzare@redhat.com>
Cc: virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4] vdpa: solidrun: Replace deprecated PCI functions
Date: Thu, 19 Dec 2024 10:44:29 +0100
Message-ID: <20241219094428.21511-2-phasta@kernel.org>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Philipp Stanner <pstanner@redhat.com>

The PCI functions

	pcim_iomap_regions()
	pcim_iounmap_regions()
	pcim_iomap_table()

have been deprecated by the PCI subsystem.

Replace these functions with their successors pcim_iomap_region() and
pcim_iounmap_region().

Signed-off-by: Philipp Stanner <pstanner@redhat.com>
---
Changes in v4:
  - snet_open_vf_bar(): use distinct temporary variable to ensure
    snet->bar is never an ERR_PTR. (Stefano)

Changes in v3:
  - Move __iomem *io declaration into the loop. (Stefano)

Changes in v2:
  - Fix build warning because of dead variable.
  - Make "bars_found" a boolean, since only true or false are relevant.
---
 drivers/vdpa/solidrun/snet_main.c | 57 +++++++++++++++----------------
 1 file changed, 28 insertions(+), 29 deletions(-)

diff --git a/drivers/vdpa/solidrun/snet_main.c b/drivers/vdpa/solidrun/snet_main.c
index c8b74980dbd1..55ec51c17ab3 100644
--- a/drivers/vdpa/solidrun/snet_main.c
+++ b/drivers/vdpa/solidrun/snet_main.c
@@ -556,58 +556,60 @@ static const struct vdpa_config_ops snet_config_ops = {
 static int psnet_open_pf_bar(struct pci_dev *pdev, struct psnet *psnet)
 {
 	char *name;
-	int ret, i, mask = 0;
+	unsigned short i;
+	bool bars_found = false;
+
+	name = devm_kasprintf(&pdev->dev, GFP_KERNEL, "psnet[%s]-bars", pci_name(pdev));
+	if (!name)
+		return -ENOMEM;
+
 	/* We don't know which BAR will be used to communicate..
 	 * We will map every bar with len > 0.
 	 *
 	 * Later, we will discover the BAR and unmap all other BARs.
 	 */
 	for (i = 0; i < PCI_STD_NUM_BARS; i++) {
-		if (pci_resource_len(pdev, i))
-			mask |= (1 << i);
+		void __iomem *io;
+
+		if (pci_resource_len(pdev, i) == 0)
+			continue;
+
+		io = pcim_iomap_region(pdev, i, name);
+		if (IS_ERR(io)) {
+			SNET_ERR(pdev, "Failed to request and map PCI BARs\n");
+			return PTR_ERR(io);
+		}
+
+		psnet->bars[i] = io;
+		bars_found = true;
 	}
 
 	/* No BAR can be used.. */
-	if (!mask) {
+	if (!bars_found) {
 		SNET_ERR(pdev, "Failed to find a PCI BAR\n");
 		return -ENODEV;
 	}
 
-	name = devm_kasprintf(&pdev->dev, GFP_KERNEL, "psnet[%s]-bars", pci_name(pdev));
-	if (!name)
-		return -ENOMEM;
-
-	ret = pcim_iomap_regions(pdev, mask, name);
-	if (ret) {
-		SNET_ERR(pdev, "Failed to request and map PCI BARs\n");
-		return ret;
-	}
-
-	for (i = 0; i < PCI_STD_NUM_BARS; i++) {
-		if (mask & (1 << i))
-			psnet->bars[i] = pcim_iomap_table(pdev)[i];
-	}
-
 	return 0;
 }
 
 static int snet_open_vf_bar(struct pci_dev *pdev, struct snet *snet)
 {
 	char *name;
-	int ret;
+	void __iomem *io;
 
 	name = devm_kasprintf(&pdev->dev, GFP_KERNEL, "snet[%s]-bars", pci_name(pdev));
 	if (!name)
 		return -ENOMEM;
 
 	/* Request and map BAR */
-	ret = pcim_iomap_regions(pdev, BIT(snet->psnet->cfg.vf_bar), name);
-	if (ret) {
+	io = pcim_iomap_region(pdev, snet->psnet->cfg.vf_bar, name);
+	if (IS_ERR(io)) {
 		SNET_ERR(pdev, "Failed to request and map PCI BAR for a VF\n");
-		return ret;
+		return PTR_ERR(io);
 	}
 
-	snet->bar = pcim_iomap_table(pdev)[snet->psnet->cfg.vf_bar];
+	snet->bar = io;
 
 	return 0;
 }
@@ -656,15 +658,12 @@ static int psnet_detect_bar(struct psnet *psnet, u32 off)
 
 static void psnet_unmap_unused_bars(struct pci_dev *pdev, struct psnet *psnet)
 {
-	int i, mask = 0;
+	unsigned short i;
 
 	for (i = 0; i < PCI_STD_NUM_BARS; i++) {
 		if (psnet->bars[i] && i != psnet->barno)
-			mask |= (1 << i);
+			pcim_iounmap_region(pdev, i);
 	}
-
-	if (mask)
-		pcim_iounmap_regions(pdev, mask);
 }
 
 /* Read SNET config from PCI BAR */
-- 
2.47.1

