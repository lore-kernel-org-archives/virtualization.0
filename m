Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E2DE1CE6E3
	for <virtualization@lists.linux.dev>; Thu, 22 Aug 2024 13:48:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724334500; cv=none; b=Jhf7huu6vKNq6FcBa3ZFHD4b+WpVUp7ScrytX5kBd5zVIO659q/UCN8kUy+p9KELfwrV7RIac4dMxnjcrTns7vpW5/Vqp3skQu2uynZaPcb5PHFvxhLfD0NsKZpt5TpwOvBXmpgz1oAXedBMWpPoVSdfJqqVV927GAK4XiYzdac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724334500; c=relaxed/simple;
	bh=Me/VBGfLq2KkhHhzkti+j6tzd1UShbG7U7ve4P+FN3c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Wg0g/m8R/9rn24M/aQv/zwZLlG4hP+/Cll0SplJODefCpjf5IzZU+67/ZNe6kyX5Ks2Hpd9F42os0i+wMphz1loAwHQ4/k6NctwQ1IvXEPHNQ92xxHjwuqeF+M7Z3qI26TH3qf1h1fW2SS7gjSIXLDgeo086sDwjexNb5ut31zc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GlNscmFn; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GlNscmFn"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724334497;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6h4v+tZpLlqIwoSAXvFUJWXM7qY2tlcI9NvuTPZYAG4=;
	b=GlNscmFnNKCy8W7U/p7rLovEjcrgXKii8wFeNxIx5lTcfuvzQFrcowg9OMbo4BTxkTbzS+
	DEArQCNS7tq7PW0jo6klkVmDKJVld62SjG5CY1Z0cQDn8T3dvibbNiCnOIwXvRg5qf2ms1
	sxmUK/Tok8/lbNetS3P+QYnn0ezYdZg=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-12-Kyo1p6DxMkiV4BHkWkzgaA-1; Thu, 22 Aug 2024 09:48:12 -0400
X-MC-Unique: Kyo1p6DxMkiV4BHkWkzgaA-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-42816aacabcso6774425e9.1
        for <virtualization@lists.linux.dev>; Thu, 22 Aug 2024 06:48:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724334491; x=1724939291;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6h4v+tZpLlqIwoSAXvFUJWXM7qY2tlcI9NvuTPZYAG4=;
        b=j2bhwGTaPgJfDqSFFp1fVXQpJFYodxuLJDrCV7WKc03wyU1JRmxsizbsh11aVgYhT3
         /k34s6t81tnR5YDdSKAhK6P2bpvS7W/LHQdvndbKv2C5JUdosFNqEs5vBvV/wiRBbxGE
         kLhDesdWrouGWkUB30jM8eWWPJ6kghEa3xQPr9FxmARzSMpY7xd/2EtRReUib4cBYAZw
         tuxWyo9URqCbcqUBN0KvrH/r2r/SozVBlrpsxjAiB6kI7+SdkuInSJctOX1Vg4Zqq56W
         OI3lfUi4O0xyOqgYLIJKyFLTpzypVYQ8jimmKSK5R2dkhSnzrN3M7T1v9CwHtww2uV5p
         U6qQ==
X-Forwarded-Encrypted: i=1; AJvYcCU2V0J9RyIdZzrefDfwbqPpp6Ge4lrE6vvCF/jp1YQda9qJ5vE1tsvR1lxnJvgCTp8CIbL6K+bUg6QPK/LkMA==@lists.linux.dev
X-Gm-Message-State: AOJu0YxyvK7A5OW9/e7dC6WTwhw2sUDbFqJD4oDlhnWo3rM2VfEmIdnj
	vd/fAIrguABvOCQp6me5Y62HHwM1sOBgCvk47u58tZHTv6TBqubNGkupWroSk2SXiNiL62RF+i3
	rsj6lchzMKJx59ahUBnPgdhyPYci0WFr/JbMldJlAqiwem1Nz4kakMq5PedDLtJ7n
X-Received: by 2002:a05:600c:444b:b0:428:1ce0:4dfd with SMTP id 5b1f17b1804b1-42abf09ff9cmr36150015e9.34.1724334491034;
        Thu, 22 Aug 2024 06:48:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH6akima5CtgXO6K5U8TUtsOlzD7gs9FdnvsxKJnG5gEPJ1/b/QeEPWH0oT+lxtkjuS4oHl+Q==
X-Received: by 2002:a05:600c:444b:b0:428:1ce0:4dfd with SMTP id 5b1f17b1804b1-42abf09ff9cmr36149635e9.34.1724334490614;
        Thu, 22 Aug 2024 06:48:10 -0700 (PDT)
Received: from eisenberg.muc.redhat.com (nat-pool-muc-t.redhat.com. [149.14.88.26])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42ac5162322sm25057215e9.24.2024.08.22.06.48.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Aug 2024 06:48:10 -0700 (PDT)
From: Philipp Stanner <pstanner@redhat.com>
To: Jonathan Corbet <corbet@lwn.net>,
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
	Philipp Stanner <pstanner@redhat.com>,
	Damien Le Moal <dlemoal@kernel.org>,
	Hannes Reinecke <hare@suse.de>,
	Chaitanya Kulkarni <kch@nvidia.com>
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
Subject: [PATCH v3 8/9] vdap: solidrun: Replace deprecated PCI functions
Date: Thu, 22 Aug 2024 15:47:40 +0200
Message-ID: <20240822134744.44919-9-pstanner@redhat.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240822134744.44919-1-pstanner@redhat.com>
References: <20240822134744.44919-1-pstanner@redhat.com>
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

solidrun utilizes pcim_iomap_regions(), which has been deprecated by the
PCI subsystem in commit e354bb84a4c1 ("PCI: Deprecate
pcim_iomap_table(), pcim_iomap_regions_request_all()"), among other
things because it forces usage of quite a complicated bitmask mechanism.
The bitmask handling code can entirely be removed by replacing
pcim_iomap_regions() and pcim_iomap_table().

Replace pcim_iomap_regions() and pcim_iomap_table() with
pcim_iomap_region().

Signed-off-by: Philipp Stanner <pstanner@redhat.com>
---
 drivers/vdpa/solidrun/snet_main.c | 52 +++++++++++--------------------
 1 file changed, 18 insertions(+), 34 deletions(-)

diff --git a/drivers/vdpa/solidrun/snet_main.c b/drivers/vdpa/solidrun/snet_main.c
index 67235f6190ef..fb15e844847d 100644
--- a/drivers/vdpa/solidrun/snet_main.c
+++ b/drivers/vdpa/solidrun/snet_main.c
@@ -556,36 +556,25 @@ static const struct vdpa_config_ops snet_config_ops = {
 static int psnet_open_pf_bar(struct pci_dev *pdev, struct psnet *psnet)
 {
 	char *name;
-	int ret, i, mask = 0;
-	/* We don't know which BAR will be used to communicate..
-	 * We will map every bar with len > 0.
-	 *
-	 * Later, we will discover the BAR and unmap all other BARs.
-	 */
-	for (i = 0; i < PCI_STD_NUM_BARS; i++) {
-		if (pci_resource_len(pdev, i))
-			mask |= (1 << i);
-	}
-
-	/* No BAR can be used.. */
-	if (!mask) {
-		SNET_ERR(pdev, "Failed to find a PCI BAR\n");
-		return -ENODEV;
-	}
+	unsigned short i;
 
 	name = devm_kasprintf(&pdev->dev, GFP_KERNEL, "psnet[%s]-bars", pci_name(pdev));
 	if (!name)
 		return -ENOMEM;
 
-	ret = pcim_iomap_regions(pdev, mask, name);
-	if (ret) {
-		SNET_ERR(pdev, "Failed to request and map PCI BARs\n");
-		return ret;
-	}
-
+	/* We don't know which BAR will be used to communicate..
+	 * We will map every bar with len > 0.
+	 *
+	 * Later, we will discover the BAR and unmap all other BARs.
+	 */
 	for (i = 0; i < PCI_STD_NUM_BARS; i++) {
-		if (mask & (1 << i))
-			psnet->bars[i] = pcim_iomap_table(pdev)[i];
+		if (!pci_resource_len(pdev, i))
+			continue;
+		psnet->bars[i] = pcim_iomap_region(pdev, i, name);
+		if (IS_ERR(psnet->bars[i])) {
+			SNET_ERR(pdev, "Failed to request and map PCI BARs\n");
+			return PTR_ERR(psnet->bars[i]);
+		}
 	}
 
 	return 0;
@@ -600,14 +589,12 @@ static int snet_open_vf_bar(struct pci_dev *pdev, struct snet *snet)
 	if (!name)
 		return -ENOMEM;
 	/* Request and map BAR */
-	ret = pcim_iomap_regions(pdev, BIT(snet->psnet->cfg.vf_bar), name);
-	if (ret) {
+	snet->bar = pcim_iomap_region(pdev, snet->psnet->cfg.vf_bar, name);
+	if (IS_ERR(snet->bar)) {
 		SNET_ERR(pdev, "Failed to request and map PCI BAR for a VF\n");
-		return ret;
+		return PTR_ERR(snet->bar);
 	}
 
-	snet->bar = pcim_iomap_table(pdev)[snet->psnet->cfg.vf_bar];
-
 	return 0;
 }
 
@@ -655,15 +642,12 @@ static int psnet_detect_bar(struct psnet *psnet, u32 off)
 
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
2.46.0

