Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9FAA1CC16C
	for <virtualization@lists.linux.dev>; Thu, 22 Aug 2024 13:48:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724334490; cv=none; b=jAk2JgRDkyQKhN4U3DCSLmFOyYhItRuMruHBSI3g12b6YyRkedUeyZRPr7H99bpZ6S8STawuBqvCbiIAWcTJncci5dWxJXn9ASIqRAOqVjhxRWvA/N7KWWI9p3oRR/4AfB4+aFYEnLCaPVgL8cveePJ9lPdPL3/igdlP4/cxyq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724334490; c=relaxed/simple;
	bh=3VAt95zZ1Dqz3XrvM2lwpkOQg6dQGTUaYO+6pcMQK9Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KADfiCj468xj+YzPa4ZPXekPMApdpqSybbUB/n3KuBhVOqEcfYImuMU6e0ZO3cPBpm3dAiTwlEWNbVbKl6QRgGTGq8TQp1jRLDlIM1vU9GSduIsgj0KikthjGw3qa768DFIwY42q5dt/Mzfk4cLYTdfKI6xs9jOA04Y8fwp9MIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=K9RqvDjY; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="K9RqvDjY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724334487;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jhs2ECxIqanvtxlvW30RxDZNTtb7z2CuQcsYq71BRfY=;
	b=K9RqvDjYokmVR5ayjZs2zXn3hErWfgjM8iYN5kDso8mTNABvUzmB8nxkEeDRE4SUrLo2JZ
	u/vGq2Gs5hTFSCpB2p22Vs2aFz99/ezdALl08fvTgbavtqDpr6M59GAvoF7QU/W7Tw3y72
	ANrTCaSsw4gd7BNaah0wuCKPm4wWQTc=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-632-ufiGmvTbOQmFs9YeSYhJUg-1; Thu, 22 Aug 2024 09:48:04 -0400
X-MC-Unique: ufiGmvTbOQmFs9YeSYhJUg-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-42807a05413so6220455e9.2
        for <virtualization@lists.linux.dev>; Thu, 22 Aug 2024 06:48:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724334483; x=1724939283;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jhs2ECxIqanvtxlvW30RxDZNTtb7z2CuQcsYq71BRfY=;
        b=JgUft415Tyi4jYYDlneuDTehki2AcAa545c5CxVmP3PvkIfwbQOumSdcQyoHRe+DsP
         PNwPX+WN+SQyyEePp+J6fjPMmls3+KP2DfAH9mZAA5AL2DWEabm2P0PK07PqnBblAA1m
         +mcxfqlJfzi+wqCS3V9DTULVrQ5vILvVFQgp2gvy/hpmiNYqAmCl+W/HjBrR7cDz6wvF
         +er48Mwu/mgbqjb2JY80crmbJRiVeghElvbHTXt+Z8z4WclVX2weisNubrK9EVXRKTmA
         FLF3KiJWj5yE8/iUApAF7iqJBkUx6NV1c0yU3dIlk6ZG1q6bnJyzD/tzmjmBBpklAh+k
         3jTQ==
X-Forwarded-Encrypted: i=1; AJvYcCU+BIVfbU9mMQpeP2RELgMr+GaReNTyRlfDNLl+sCJTEJOIamr8iIzSoJe5nA0TBdVAM9U4DPR9zBob+jscmg==@lists.linux.dev
X-Gm-Message-State: AOJu0YyUYYCAooCylUp7tJTWPSgGZ/OWJ3BlVPhN5IyFLl7vPJ/jaPV2
	85nHy0Ox7jHMg2VS82jelH1o6U0R+i99ohqqFBi2H5ORVZ8ZrJcxsTNR02b34LUeqhUJWslG15e
	zwLdVDzS6az2ogGhXi2g/nNCQmfi3ACMQIVk+EuSLjRGfDrFYJEK3QshonKsUJdIr
X-Received: by 2002:a05:600c:5114:b0:426:60bc:8f4e with SMTP id 5b1f17b1804b1-42abd21f5e8mr38750825e9.5.1724334482795;
        Thu, 22 Aug 2024 06:48:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHXx12BAf3CxTnmjhd6pOZhjB7i9I5cLSUjMGAYvwAfvdwbDB7drJJLXCP1Y+6M4I79vMkMAA==
X-Received: by 2002:a05:600c:5114:b0:426:60bc:8f4e with SMTP id 5b1f17b1804b1-42abd21f5e8mr38750635e9.5.1724334482246;
        Thu, 22 Aug 2024 06:48:02 -0700 (PDT)
Received: from eisenberg.muc.redhat.com (nat-pool-muc-t.redhat.com. [149.14.88.26])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42ac5162322sm25057215e9.24.2024.08.22.06.48.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Aug 2024 06:48:01 -0700 (PDT)
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
Subject: [PATCH v3 3/9] block: mtip32xx: Replace deprecated PCI functions
Date: Thu, 22 Aug 2024 15:47:35 +0200
Message-ID: <20240822134744.44919-4-pstanner@redhat.com>
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

pcim_iomap_regions() and pcim_iomap_table() have been deprecated by the
PCI subsystem in commit e354bb84a4c1 ("PCI: Deprecate
pcim_iomap_table(), pcim_iomap_regions_request_all()").

In mtip32xx, these functions can easily be replaced by their respective
successors, pcim_request_region() and pcim_iomap(). Moreover, the
driver's calls to pcim_iounmap_regions() in probe()'s error path and in
remove() are not necessary. Cleanup can be performed by PCI devres
automatically.

Replace pcim_iomap_regions() and pcim_iomap_table().

Remove the calls to pcim_iounmap_regions().

Signed-off-by: Philipp Stanner <pstanner@redhat.com>
---
 drivers/block/mtip32xx/mtip32xx.c | 16 +++++++---------
 1 file changed, 7 insertions(+), 9 deletions(-)

diff --git a/drivers/block/mtip32xx/mtip32xx.c b/drivers/block/mtip32xx/mtip32xx.c
index c6ef0546ffc9..bd40a06e4c0f 100644
--- a/drivers/block/mtip32xx/mtip32xx.c
+++ b/drivers/block/mtip32xx/mtip32xx.c
@@ -2716,7 +2716,9 @@ static int mtip_hw_init(struct driver_data *dd)
 	int rv;
 	unsigned long timeout, timetaken;
 
-	dd->mmio = pcim_iomap_table(dd->pdev)[MTIP_ABAR];
+	dd->mmio = pcim_iomap(dd->pdev, MTIP_ABAR, 0);
+	if (!dd->mmio)
+		return -ENOMEM;
 
 	mtip_detect_product(dd);
 	if (dd->product_type == MTIP_PRODUCT_UNKNOWN) {
@@ -3722,14 +3724,14 @@ static int mtip_pci_probe(struct pci_dev *pdev,
 	rv = pcim_enable_device(pdev);
 	if (rv < 0) {
 		dev_err(&pdev->dev, "Unable to enable device\n");
-		goto iomap_err;
+		goto setmask_err;
 	}
 
 	/* Map BAR5 to memory. */
-	rv = pcim_iomap_regions(pdev, 1 << MTIP_ABAR, MTIP_DRV_NAME);
+	rv = pcim_request_region(pdev, MTIP_ABAR, MTIP_DRV_NAME);
 	if (rv < 0) {
-		dev_err(&pdev->dev, "Unable to map regions\n");
-		goto iomap_err;
+		dev_err(&pdev->dev, "Unable to request regions\n");
+		goto setmask_err;
 	}
 
 	rv = dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(64));
@@ -3849,9 +3851,6 @@ static int mtip_pci_probe(struct pci_dev *pdev,
 		drop_cpu(dd->work[2].cpu_binding);
 	}
 setmask_err:
-	pcim_iounmap_regions(pdev, 1 << MTIP_ABAR);
-
-iomap_err:
 	kfree(dd);
 	pci_set_drvdata(pdev, NULL);
 	return rv;
@@ -3925,7 +3924,6 @@ static void mtip_pci_remove(struct pci_dev *pdev)
 
 	pci_disable_msi(pdev);
 
-	pcim_iounmap_regions(pdev, 1 << MTIP_ABAR);
 	pci_set_drvdata(pdev, NULL);
 
 	put_disk(dd->disk);
-- 
2.46.0

