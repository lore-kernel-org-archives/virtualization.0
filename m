Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 718E4197A99
	for <virtualization@lists.linux.dev>; Thu, 29 Aug 2024 14:19:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724941142; cv=none; b=cxCe62OjSo8IWVfJ8VYSRKxxRef4b1tQfHTGv0XX13NDVonob5hreExTmDC0JBMuI0+mIhGkx4UQhABA5lcvNEFnSPSrTu7T2WT0vqF7p8VouCezJQ5Rqz4q6qQCvQBHU+MwpkCPAzTprkt1cAlcOv0PBCwwLBBW/h0CrXwqodw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724941142; c=relaxed/simple;
	bh=Fc7LqA4dsnee2e9i3xlXjC/frSEy4rrwVedoLFfxfmw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SRkNMWZpMCAI82KGmxEoIU14MXv8wxBAGfljzIz/rfJLjH3VPlevTiiw/z7zernCdDRQ0PqSFlikLPhV5LNlkAy6RRjxjn2Ay7G5UVr880DYCyt+R78QBAf+k0jM1NEiZYuVtYKvmmYL/P6+qfU5/xqPm6McnDl+Uy8a3bKmhrs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WO680pxb; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WO680pxb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724941139;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/H9qQSvRoJEHuC9fzeIRZ7nyD5NIc+bT7koxtRIZd8A=;
	b=WO680pxbRDCyw8tFj8r691u2fiOA7GDvywOVll1npJ21zl93liqXYHVrbvxjjs5xIhJ5+Z
	Kpn0cLZVIp/k2n5+hQarHRxPQLad8i/G9r8AG1hZcGHAWomcTypNmI9U+cE4rXA5jeZPev
	q3n98lbIUDiOCVgY27fEknoNjMDypt4=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-345-th58MfdrM9SSYJZOuW_gGQ-1; Thu, 29 Aug 2024 10:18:56 -0400
X-MC-Unique: th58MfdrM9SSYJZOuW_gGQ-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-428fb72245bso4642515e9.1
        for <virtualization@lists.linux.dev>; Thu, 29 Aug 2024 07:18:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724941135; x=1725545935;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/H9qQSvRoJEHuC9fzeIRZ7nyD5NIc+bT7koxtRIZd8A=;
        b=Q8VxAYQw0Qccc5hpnfchcVq/N8l3vY37ZURiAS5bydJfqasi3vypwbFHSOGIaHydEO
         Seacq672jxE1xLOl3Tn7iLA57DYor3G7lmHldYOONZS4HZn39IhZDaCCuhRlRxc7gABN
         m+Ug1ZVCpxC6+U6FdqjjyJXuoGzEIAfDGpGjPhmfSSIB6NG/tHJmiYEO+fpy1iemDHOj
         gw7AsMLuMKMGSfSyjsLGByyLcrS9rrOKhW1SVIVCZgrYCTfYRnrQXzrVDGdqCgoLguUG
         L0v/LCeYHeC1T/0xqQGC/L5abTS9MVGpSH5wyI0E3/t2RjWqG185lnGfoM2bHPQq6EfW
         ZB+Q==
X-Forwarded-Encrypted: i=1; AJvYcCWncyB0wxoaDS1WlXQoaV07AJ2TdbT5Cu25MzQuK9kgQ+aK3FcNFxZJLlKPA//IRDotEU7RnLjWRyWfw0pRGQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YyF6Mve6TTNdLOoDu5jq1YWBzA7G57ntdkPC6mkOfllP2hmeZNz
	mZDXs8ySkBMZaV1kg3iw+pfzGihP49jZJLAxCb7HrKPZ0Jofc+HYxTVfGDnv8d9dMIUicva8qIi
	QozFGWwgsiPr8XnZL76icXH634bUdys0OLAnhTwbTeXYVRws6fn4z+lp+I11DvS5A
X-Received: by 2002:a05:600c:3d16:b0:42a:a749:e6 with SMTP id 5b1f17b1804b1-42bb74403eemr18537865e9.10.1724941135152;
        Thu, 29 Aug 2024 07:18:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE5CyqY/wd5nkLrhi1KCiNw1KCCPc5Bn48lyL/rJpYaGF/BSmvD7WGs5d/ldDgSNQeuDENYTQ==
X-Received: by 2002:a05:600c:3d16:b0:42a:a749:e6 with SMTP id 5b1f17b1804b1-42bb74403eemr18537655e9.10.1724941134717;
        Thu, 29 Aug 2024 07:18:54 -0700 (PDT)
Received: from eisenberg.muc.redhat.com (nat-pool-muc-t.redhat.com. [149.14.88.26])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42ba63abebdsm52670425e9.27.2024.08.29.07.18.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Aug 2024 07:18:54 -0700 (PDT)
From: Philipp Stanner <pstanner@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
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
	Bjorn Helgaas <bhelgaas@google.com>,
	Alvaro Karsz <alvaro.karsz@solid-run.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Damien Le Moal <dlemoal@kernel.org>,
	Hannes Reinecke <hare@suse.de>,
	John Garry <john.g.garry@oracle.com>,
	Philipp Stanner <pstanner@redhat.com>
Cc: linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-fpga@vger.kernel.org,
	linux-gpio@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-pci@vger.kernel.org,
	virtualization@lists.linux.dev,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [PATCH v5 4/7] gpio: Replace deprecated PCI functions
Date: Thu, 29 Aug 2024 16:16:23 +0200
Message-ID: <20240829141844.39064-5-pstanner@redhat.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240829141844.39064-1-pstanner@redhat.com>
References: <20240829141844.39064-1-pstanner@redhat.com>
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

Replace those functions with calls to pcim_iomap_region().

Signed-off-by: Philipp Stanner <pstanner@redhat.com>
Reviewed-by: Andy Shevchenko <andy@kernel.org>
Acked-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 drivers/gpio/gpio-merrifield.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/gpio/gpio-merrifield.c b/drivers/gpio/gpio-merrifield.c
index 421d7e3a6c66..274afcba31e6 100644
--- a/drivers/gpio/gpio-merrifield.c
+++ b/drivers/gpio/gpio-merrifield.c
@@ -78,24 +78,24 @@ static int mrfld_gpio_probe(struct pci_dev *pdev, const struct pci_device_id *id
 	if (retval)
 		return retval;
 
-	retval = pcim_iomap_regions(pdev, BIT(1) | BIT(0), pci_name(pdev));
-	if (retval)
-		return dev_err_probe(dev, retval, "I/O memory mapping error\n");
-
-	base = pcim_iomap_table(pdev)[1];
+	base = pcim_iomap_region(pdev, 1, pci_name(pdev));
+	if (IS_ERR(base))
+		return dev_err_probe(dev, PTR_ERR(base), "I/O memory mapping error\n");
 
 	irq_base = readl(base + 0 * sizeof(u32));
 	gpio_base = readl(base + 1 * sizeof(u32));
 
 	/* Release the IO mapping, since we already get the info from BAR1 */
-	pcim_iounmap_regions(pdev, BIT(1));
+	pcim_iounmap_region(pdev, 1);
 
 	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
 	if (!priv)
 		return -ENOMEM;
 
 	priv->dev = dev;
-	priv->reg_base = pcim_iomap_table(pdev)[0];
+	priv->reg_base = pcim_iomap_region(pdev, 0, pci_name(pdev));
+	if (IS_ERR(priv->reg_base))
+		return dev_err_probe(dev, PTR_ERR(base), "I/O memory mapping error\n");
 
 	priv->pin_info.pin_ranges = mrfld_gpio_ranges;
 	priv->pin_info.nranges = ARRAY_SIZE(mrfld_gpio_ranges);
-- 
2.46.0

