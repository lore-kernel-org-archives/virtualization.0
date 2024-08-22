Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97A541CC165
	for <virtualization@lists.linux.dev>; Thu, 22 Aug 2024 13:48:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724334489; cv=none; b=Fw6pLM7lWlLv75ogcsXKUOORUNQU4+R5oZSP9K4xepb9TCMWkpUY57qAaL7QVgOMCnbxTYjbU5/3WJnkmHjSmLsFsPf9id2gnUSnEQkmhhd+yvVtez56IiAwaiycshkGAZQH3A3K0wcxHaqN4z4N5MP7ZCgXjWz/WrJPF710uzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724334489; c=relaxed/simple;
	bh=Fc7LqA4dsnee2e9i3xlXjC/frSEy4rrwVedoLFfxfmw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kKX+QXM3onFFx/Vg6Hb/n194vAEhb9QizqdtHYnWuf+0CV/IhNA+4hl761SYyAdJiceWgFRQ2kT+ZINgLqxLMVn4HXmz6qFozse3p0XeyvIBOewpSdSvRbMQAn8eP6IJ3SOf6BNhjCazI1+2QJfXxxxDBxUiBoHSkT4fo0iYnLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=D1gJtaFt; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="D1gJtaFt"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724334486;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/H9qQSvRoJEHuC9fzeIRZ7nyD5NIc+bT7koxtRIZd8A=;
	b=D1gJtaFtIZkwrfhTb1p7G4VDtQXCIkZzd/zda0XrK1OaoJQm/iWCpDs2PvJaOC40tJaW6k
	YXQF57XgrpjCb/irJ1Kzy12yic2Rdm8TAkaquHsV3Vt4y1CnrnkBgCKr2C0UtsShkN/ciC
	h+iN/SWK5Dd7UQwMD1nuCbxk/ZtVcFs=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-29-ALZdnZPWNmSlmIpAauliVA-1; Thu, 22 Aug 2024 09:48:05 -0400
X-MC-Unique: ALZdnZPWNmSlmIpAauliVA-1
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-371881b6de3so418418f8f.2
        for <virtualization@lists.linux.dev>; Thu, 22 Aug 2024 06:48:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724334484; x=1724939284;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/H9qQSvRoJEHuC9fzeIRZ7nyD5NIc+bT7koxtRIZd8A=;
        b=q851PBw5ENaigjV6DQV2CIJ3jtOz+0jpvmA4k+apemjGvaTFKSi4GSx3mkZm12AKvl
         IcDXUKzYGesaHiKE9eU8ibvm4cC7LDtaDTOm6X3IhuwxiBP4RR8W05ce38dyYqB1y6Tp
         lRrwH49jt/cMyEDwBVKb/vLT9OCR4uQye8OIf4/KX2Jr05IN1ahMUBEHWoDK6DWMiPeh
         x9lYrE7fTGN+JoBlw2ZhvtKydN+hJvlMq7SqvoNtXVHzBmgbWyIwlWSr9HtT9rb616zc
         EbUILpKsW6yp02tYGYOrmu89z89Scr22vjHnq8xjvkB4FS1gbWmYOxXtsFzpezgrUfZ6
         UWjQ==
X-Forwarded-Encrypted: i=1; AJvYcCX0Kx1AdSFYoe6rxgMa18gv5b5kN5VVcM/Olt+ipoxnG4XLqjBeSAvRTh33qymp+L6WXyLjWMXKa9vyo03pTQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YyWQTl13HlGH8El2kwfGEw6cUJZ6fcvi08ctE2LRnhUN2gKdLJF
	phSAqRLU6cxXMPItfkIZs+AMDz/pwpXzK/uD5pcx6+A88vl2h6rjEy9U3oTgJONoi4ZTdWvSN4+
	TSKMp+lldzRJDYs8Q/oknlGOHhzxk6zVrOXBbB7qFrGc0fg2q63YCgAoSx3AM+pCV
X-Received: by 2002:adf:f802:0:b0:371:8c06:82ee with SMTP id ffacd0b85a97d-372fd82c3dcmr3699803f8f.49.1724334484241;
        Thu, 22 Aug 2024 06:48:04 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE/dGSNW4Q5J8zIjht7W8w6lm/DRlJe50ZIJE1uWbGQpR5tL77ENnUxbm6ccKv01r659J3/tA==
X-Received: by 2002:adf:f802:0:b0:371:8c06:82ee with SMTP id ffacd0b85a97d-372fd82c3dcmr3699770f8f.49.1724334483816;
        Thu, 22 Aug 2024 06:48:03 -0700 (PDT)
Received: from eisenberg.muc.redhat.com (nat-pool-muc-t.redhat.com. [149.14.88.26])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42ac5162322sm25057215e9.24.2024.08.22.06.48.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Aug 2024 06:48:03 -0700 (PDT)
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
	virtualization@lists.linux.dev,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [PATCH v3 4/9] gpio: Replace deprecated PCI functions
Date: Thu, 22 Aug 2024 15:47:36 +0200
Message-ID: <20240822134744.44919-5-pstanner@redhat.com>
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

