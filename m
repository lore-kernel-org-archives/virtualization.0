Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA02D18A931
	for <virtualization@lists.linux.dev>; Mon, 19 Aug 2024 16:53:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724086394; cv=none; b=Yeboy6qHyKPP9waqE4Usc0nw0xfDD20HVG9p1x6AvA/MpN3ITTivtxxQy2lLpy1OF4z1+ydz5Ns4LUYafXMaJln/3cvsZFiOHFXk/vuNqAjhGYHShJnlLURJElVJ07+wl0C6qzrlGEaA9dLNr7Zsgq+PS8kKuakACGt3afV7IsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724086394; c=relaxed/simple;
	bh=kigVrUGzwAc3Gfl0QApPC++gUgBQlYDwvJKklnpQh/U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jQxy87NR6VIy1KjupbYs05vmNImggbzGags61NSmdz2hW/pt/bf1GyaYa2/o/zx7bH7S9zNRqxz1cl+S76gAW8sjDqxbYF8ZClg5CYincORqDOY6eIhs636m5nYj2unji86uJTEx2+pDG1xvVF3716E1FrrcMz7E6Im8p9sA4cs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XK2TKEQ5; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XK2TKEQ5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724086392;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FEnCsYi4V2PnChy33tc28SWivSiMlK/Z32Tet3XvGFE=;
	b=XK2TKEQ54F1MwAEnScSnxYA7yCkS76AiblCUYmhCbKne/5dSnoncSg2YD5U8smbsipQrX6
	Gj4LZ2xKqJE6DWeKQfSv13qJdfgZaW91ytak7KPLUS/2auAduXScIdtHy4K01H2GmliOqA
	hMy2+Ewzgknh4iDecHTuRp69DrPs7eQ=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-86-yDo8zsQsOXKStJkNs4gk_g-1; Mon, 19 Aug 2024 12:53:07 -0400
X-MC-Unique: yDo8zsQsOXKStJkNs4gk_g-1
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-44ff44e2f9bso3520941cf.3
        for <virtualization@lists.linux.dev>; Mon, 19 Aug 2024 09:53:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724086387; x=1724691187;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FEnCsYi4V2PnChy33tc28SWivSiMlK/Z32Tet3XvGFE=;
        b=Cdp9Lwk8ElUGIv230uMObdq6WOv6QDciF7mEiqu6Ig4pD3fDtEVL/XpPHcUjVNECkU
         LqINMDWq+ptAaynUVpxld/oymqrXQgfg6kNj/v4x7lsMlOd5pyxjFOELeUwAym6KsXwh
         yunHtvTAKZedGvHXBLs5ciDufjZRr4StL3ehdV2GAM1WH2X/3+a1oi5BHv2cbAVr7h4e
         bBPJOS4zj9JLXxoD6PTFyeyWqPcwj/q59TezKQdUpPiHNqjiyK+GSdNl7CbpD+Y4V2xJ
         oM0x1lNVADAt3hafom6GkTRP73t9ys+ZF5uaWEtLSZh1+D9GzzTV9IF2kc1nVqcnBt7L
         YAtw==
X-Forwarded-Encrypted: i=1; AJvYcCVPQ0N48YnSpPIgaoLW+8WS3BX1EJPoB9tbDND8UVadgw3Q1yf7oRhpGEWh70hDGcGJd0hI+8LGmM97KbubPQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YyNg6mu6DJA1TzkHI82EPREV5nnfHU8MMDg1y4BFAAQwSrUqX+N
	vOPXgmQmDqroV5mIDr08MMusxm5ZDYKWOtjvcYTCF2/AvDXIDfeYZGItyWpHLpmF1oVGJavENll
	lpFAy6cszCcXfcFvXPRL/njU51nGO25K5vQlDq/crBDC9RG2O9IUkziG/dGxqxF1s
X-Received: by 2002:a05:620a:3d08:b0:7a6:63fb:4303 with SMTP id af79cd13be357-7a663fb45efmr80659485a.10.1724086387005;
        Mon, 19 Aug 2024 09:53:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFwAS0GQz5LBMkiUgj/6m4b5lAyO39MsqxfVGWbhZ8+Xeosey0/oxXphrfuUeFGVc2AzYTAHA==
X-Received: by 2002:a05:620a:3d08:b0:7a6:63fb:4303 with SMTP id af79cd13be357-7a663fb45efmr80656985a.10.1724086386639;
        Mon, 19 Aug 2024 09:53:06 -0700 (PDT)
Received: from eisenberg.muc.redhat.com (nat-pool-muc-t.redhat.com. [149.14.88.26])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a4ff01e293sm446579885a.26.2024.08.19.09.53.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Aug 2024 09:53:06 -0700 (PDT)
From: Philipp Stanner <pstanner@redhat.com>
To: onathan Corbet <corbet@lwn.net>,
	Jens Axboe <axboe@kernel.dk>,
	Wu Hao <hao.wu@intel.com>,
	Tom Rix <trix@redhat.com>,
	Moritz Fischer <mdf@kernel.org>,
	Xu Yilun <yilun.xu@intel.com>,
	Andy Shevchenko <andy@kernel.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jose Abreu <joabreu@synopsys.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Alvaro Karsz <alvaro.karsz@solid-run.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Philipp Stanner <pstanner@redhat.com>,
	Hannes Reinecke <hare@suse.de>,
	Damien Le Moal <dlemoal@kernel.org>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>
Cc: linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-block@vger.kernel.org,
	linux-fpga@vger.kernel.org,
	linux-gpio@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	linux-pci@vger.kernel.org,
	virtualization@lists.linux.dev
Subject: [PATCH 7/9] ethernet: stmicro: Simplify PCI devres usage
Date: Mon, 19 Aug 2024 18:51:47 +0200
Message-ID: <20240819165148.58201-9-pstanner@redhat.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240819165148.58201-2-pstanner@redhat.com>
References: <20240819165148.58201-2-pstanner@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"; x-default=true

stmicro uses PCI devres in the wrong way. Resources requested
through pcim_* functions don't need to be cleaned up manually in the
remove() callback or in the error unwind path of a probe() function.

Moreover, there is an unnecessary loop which only requests and ioremaps
BAR 0, but iterates over all BARs nevertheless.

Furthermore, pcim_iomap_regions() and pcim_iomap_table() have been
deprecated by the PCI subsystem in commit e354bb84a4c1 ("PCI: Deprecate
pcim_iomap_table(), pcim_iomap_regions_request_all()").

Replace these functions with pcim_iomap_region().

Remove the unnecessary manual pcim_* cleanup calls.

Remove the unnecessary loop over all BARs.

Signed-off-by: Philipp Stanner <pstanner@redhat.com>
---
 .../ethernet/stmicro/stmmac/dwmac-loongson.c  | 25 +++++--------------
 .../net/ethernet/stmicro/stmmac/stmmac_pci.c  | 18 +++++--------
 2 files changed, 12 insertions(+), 31 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c
index 9e40c28d453a..5d42a9fad672 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c
@@ -50,7 +50,7 @@ static int loongson_dwmac_probe(struct pci_dev *pdev, const struct pci_device_id
 	struct plat_stmmacenet_data *plat;
 	struct stmmac_resources res;
 	struct device_node *np;
-	int ret, i, phy_mode;
+	int ret, phy_mode;
 
 	np = dev_of_node(&pdev->dev);
 
@@ -88,14 +88,11 @@ static int loongson_dwmac_probe(struct pci_dev *pdev, const struct pci_device_id
 		goto err_put_node;
 	}
 
-	/* Get the base address of device */
-	for (i = 0; i < PCI_STD_NUM_BARS; i++) {
-		if (pci_resource_len(pdev, i) == 0)
-			continue;
-		ret = pcim_iomap_regions(pdev, BIT(0), pci_name(pdev));
-		if (ret)
-			goto err_disable_device;
-		break;
+	memset(&res, 0, sizeof(res));
+	res.addr = pcim_iomap_region(pdev, 0, pci_name(pdev));
+	if (IS_ERR(res.addr)) {
+		ret = PTR_ERR(res.addr);
+		goto err_disable_device;
 	}
 
 	plat->bus_id = of_alias_get_id(np, "ethernet");
@@ -116,8 +113,6 @@ static int loongson_dwmac_probe(struct pci_dev *pdev, const struct pci_device_id
 
 	loongson_default_data(plat);
 	pci_enable_msi(pdev);
-	memset(&res, 0, sizeof(res));
-	res.addr = pcim_iomap_table(pdev)[0];
 
 	res.irq = of_irq_get_byname(np, "macirq");
 	if (res.irq < 0) {
@@ -158,18 +153,10 @@ static void loongson_dwmac_remove(struct pci_dev *pdev)
 {
 	struct net_device *ndev = dev_get_drvdata(&pdev->dev);
 	struct stmmac_priv *priv = netdev_priv(ndev);
-	int i;
 
 	of_node_put(priv->plat->mdio_node);
 	stmmac_dvr_remove(&pdev->dev);
 
-	for (i = 0; i < PCI_STD_NUM_BARS; i++) {
-		if (pci_resource_len(pdev, i) == 0)
-			continue;
-		pcim_iounmap_regions(pdev, BIT(i));
-		break;
-	}
-
 	pci_disable_msi(pdev);
 	pci_disable_device(pdev);
 }
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_pci.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_pci.c
index 352b01678c22..f89a8a54c4e8 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_pci.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_pci.c
@@ -188,11 +188,11 @@ static int stmmac_pci_probe(struct pci_dev *pdev,
 		return ret;
 	}
 
-	/* Get the base address of device */
+	/* Request the base address BAR of device */
 	for (i = 0; i < PCI_STD_NUM_BARS; i++) {
 		if (pci_resource_len(pdev, i) == 0)
 			continue;
-		ret = pcim_iomap_regions(pdev, BIT(i), pci_name(pdev));
+		ret = pcim_request_region(pdev, i, pci_name(pdev));
 		if (ret)
 			return ret;
 		break;
@@ -205,7 +205,10 @@ static int stmmac_pci_probe(struct pci_dev *pdev,
 		return ret;
 
 	memset(&res, 0, sizeof(res));
-	res.addr = pcim_iomap_table(pdev)[i];
+	/* Get the base address of device */
+	res.addr = pcim_iomap(pdev, i, 0);
+	if (!res.addr)
+		return -ENOMEM;
 	res.wol_irq = pdev->irq;
 	res.irq = pdev->irq;
 
@@ -231,16 +234,7 @@ static int stmmac_pci_probe(struct pci_dev *pdev,
  */
 static void stmmac_pci_remove(struct pci_dev *pdev)
 {
-	int i;
-
 	stmmac_dvr_remove(&pdev->dev);
-
-	for (i = 0; i < PCI_STD_NUM_BARS; i++) {
-		if (pci_resource_len(pdev, i) == 0)
-			continue;
-		pcim_iounmap_regions(pdev, BIT(i));
-		break;
-	}
 }
 
 static int __maybe_unused stmmac_pci_suspend(struct device *dev)
-- 
2.46.0

