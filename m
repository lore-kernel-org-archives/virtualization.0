Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95A2922423C;
	Thu, 17 Apr 2025 08:03:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744877030; cv=none; b=ci5TBMZTtLIBfDdpBbRRO4AR2AbNBJYznE5BuBNclBWagqSIgaF4sMzjyG8A9dNE2/CZVRmD383r8+2DBfhiNNHJWByWwPvTAUkQTSdgCQ+FB9B++JgAYwJ7XBdFUfAZvG2z6ERMPFouFb8lmfJp2uZ+YCZng4+7ZLE6B5rFRZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744877030; c=relaxed/simple;
	bh=/hss0P/gPPDydOlWxQkzm7ADD0P5tj2HUtGEQ57EIhM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qe5tqz7Mf2wlO3mCEg8X3Ru6V62WnRQTXyg+XTpTzR816GaRoVIbxa6KzWgLOf9C3ac9/WzI/u7TJ1Sxyq3wkbDG7eZaVWlctdT2PlkH5v6eRryKjQiVQwgPPCJGOEztksDGf5CryYucsDB3tyrEY6VX6QyfCQN8N7Y87gQv3E8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hYwxILuk; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hYwxILuk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EAE5FC4CEE4;
	Thu, 17 Apr 2025 08:03:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744877030;
	bh=/hss0P/gPPDydOlWxQkzm7ADD0P5tj2HUtGEQ57EIhM=;
	h=From:To:Cc:Subject:Date:From;
	b=hYwxILuk4Sz9tlsH3G54+Fj5sDipxOqnfv6fdd1gtZSBdcL275XE+ICi/r2d3ikN1
	 sy+e8J9yXQz2+lwDt7NGLczIy4SBtmxlZBEhq9nm4u0FRgWtvGNt4L8Dgn7COPUL6q
	 +qU9fdCWw559VaVJ8JLg5wJRY4LToZr6aaWpRU1Ogh0TIFao5i/0ffAQdSaazpnx5b
	 rSexkDHLqfuElOw3YXQBfyKS9s438t9trhrupFGndagV+OQh+zLIhKue+8EZEaSzMY
	 S9c52ie1waCiQX+C2GkY57tNQ6zaHBd+cBlSOqXlS0nadWFHq5vgpxJvHDopG0iXmu
	 Bjurcs9n+UJnw==
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
Subject: [PATCH] vdpa/octeon_ep: Use non-hybrid PCI devres API
Date: Thu, 17 Apr 2025 10:02:12 +0200
Message-ID: <20250417080211.19970-2-phasta@kernel.org>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

octeon enables its PCI device with pcim_enable_device(). This,
implicitly, switches the function pci_request_region() into managed
mode, where it becomes a devres function.

The PCI subsystem wants to remove this hybrid nature from its
interfaces. To do so, users of the aforementioned combination of
functions must be ported to non-hybrid functions.

Moreover, since both functions are already managed in this driver, the
calls to pci_release_region() are unnecessary.

Remove the calls to pci_release_region().

Replace the call to sometimes-managed pci_request_region() with one to
the always-managed pcim_request_region().

Signed-off-by: Philipp Stanner <phasta@kernel.org>
---
 drivers/vdpa/octeon_ep/octep_vdpa_main.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/vdpa/octeon_ep/octep_vdpa_main.c b/drivers/vdpa/octeon_ep/octep_vdpa_main.c
index f3d4dda4e04c..e0da6367661e 100644
--- a/drivers/vdpa/octeon_ep/octep_vdpa_main.c
+++ b/drivers/vdpa/octeon_ep/octep_vdpa_main.c
@@ -391,7 +391,7 @@ static int octep_iomap_region(struct pci_dev *pdev, u8 __iomem **tbl, u8 bar)
 {
 	int ret;
 
-	ret = pci_request_region(pdev, bar, OCTEP_VDPA_DRIVER_NAME);
+	ret = pcim_request_region(pdev, bar, OCTEP_VDPA_DRIVER_NAME);
 	if (ret) {
 		dev_err(&pdev->dev, "Failed to request BAR:%u region\n", bar);
 		return ret;
@@ -400,7 +400,6 @@ static int octep_iomap_region(struct pci_dev *pdev, u8 __iomem **tbl, u8 bar)
 	tbl[bar] = pci_iomap(pdev, bar, pci_resource_len(pdev, bar));
 	if (!tbl[bar]) {
 		dev_err(&pdev->dev, "Failed to iomap BAR:%u\n", bar);
-		pci_release_region(pdev, bar);
 		ret = -ENOMEM;
 	}
 
@@ -410,7 +409,6 @@ static int octep_iomap_region(struct pci_dev *pdev, u8 __iomem **tbl, u8 bar)
 static void octep_iounmap_region(struct pci_dev *pdev, u8 __iomem **tbl, u8 bar)
 {
 	pci_iounmap(pdev, tbl[bar]);
-	pci_release_region(pdev, bar);
 }
 
 static void octep_vdpa_pf_bar_shrink(struct octep_pf *octpf)
-- 
2.48.1

