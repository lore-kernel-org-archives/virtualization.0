Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F6B115FA92
	for <virtualization@lists.linux.dev>; Wed, 21 Aug 2024 07:19:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724224765; cv=none; b=fTFQ7vjHrYQW0C6HMsLqJ4bscN67Vq7SSTqKVTRtR79vq0HyfxHdJzDllFJbgdOthPBeyHxMvBOgxG1rMphuHLGKhvTjYT5gL7YArfjzh1ryi00zSm72paWZt7s6T8FoqkbbqWCgUQWxyFNkfAQwH8XNUGXBl90d2I1mRyK+x4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724224765; c=relaxed/simple;
	bh=Fc7LqA4dsnee2e9i3xlXjC/frSEy4rrwVedoLFfxfmw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BPW3qq7/z9qFA4N3lkoY79hDVrtbXupwskL3kvqH16m6EyEX3A8uoPrarWsmeI7u5Z0cODMtzMmPpQEiy39pKDAFtpjIOhoK8L3wdwMANMriVVrZ6UUxFHBUz7mi4N1ThKP2kk5JbEf3m9bWavAsfC/fqdpCbmvv2uJ2XT5WoZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TLM2K4Kr; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TLM2K4Kr"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724224762;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/H9qQSvRoJEHuC9fzeIRZ7nyD5NIc+bT7koxtRIZd8A=;
	b=TLM2K4KrUiKK7SwbRLsdvRj1ql/YWBeLpH56BKCW2JXozgRZJGR9vb0MM1pI+NkMeetbgP
	uzuau0lBrtRUQqvhlGRcyQ87DyFjUTYBu8gX84msNoZehylT07M3z2zoJjyOsBPJvTXUBp
	e3W8covl7rncL8iuo+7McG9JBkfw6Ak=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-414-l2iG--FRPFuaqmK35t198w-1; Wed, 21 Aug 2024 03:19:21 -0400
X-MC-Unique: l2iG--FRPFuaqmK35t198w-1
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-7a1db42803eso751527685a.2
        for <virtualization@lists.linux.dev>; Wed, 21 Aug 2024 00:19:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724224761; x=1724829561;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/H9qQSvRoJEHuC9fzeIRZ7nyD5NIc+bT7koxtRIZd8A=;
        b=W75Axv+KN4xCMiUUQMsK+uVRRamVxldswjFlDPwQxfZ8C+/xbmKRJE5PLKW0FV+23N
         65evzhDJqrxXCKu6dQw9Pf5Y2ILczTJK6eoJUP725m0k3XyfwzDnbwjG32HF08NPfGfV
         a/zF5LnOEsRk0/CoclW7v5w72f1hdV+HGG/o6GCuJXqX2dYDsoPGsXBSkrPDlLUAk84E
         FmezHpzZxS6FTfBKY25mcV0byNEaIyyg0U1zXj3EGlvRupSw0eU74Eepr1wxDQcp5Ky4
         As0BzRQrnYJJ59zkL45UNcCDAEVlm13Diag2orZUw4/w1NTuw/03q8cIzw6yoRv44oYq
         vOyA==
X-Forwarded-Encrypted: i=1; AJvYcCWwm9SBIWvDtfLWNqkj/WnOsjeROLu1cDjiYMivdulGvvZGQ6dpkFKdKyr11TAz4mWrQMm11LqkoLcbmq97iQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YxbDvsxj6vj2kkSspo8oXCVf/luxUAdurgaOSLpGcMqcf5DzpLp
	qhm/XXYgq4mh332nbWibf0YBtYkyYvIlKobKPoUZwal4zoiaC/Hix9lTCTY0jEWA55WtuwjDhJF
	KoNvfa4CdKDewFcNpBECaMNujcHFeS8X+S1MY3SMjDx6SaLEbvhS+wKt4gaVX9iKI
X-Received: by 2002:a05:620a:1a23:b0:79c:130:452b with SMTP id af79cd13be357-7a6740bf833mr201731085a.47.1724224760984;
        Wed, 21 Aug 2024 00:19:20 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHlHEduRbx+7oLWq2FWdoqLifqFviA1Dz0/eZWADNmQ+nKTULVnIfuczZLElQLlBGhubXgMag==
X-Received: by 2002:a05:620a:1a23:b0:79c:130:452b with SMTP id af79cd13be357-7a6740bf833mr201726085a.47.1724224760509;
        Wed, 21 Aug 2024 00:19:20 -0700 (PDT)
Received: from eisenberg.redhat.com (nat-pool-muc-t.redhat.com. [149.14.88.26])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a4ff013ef2sm596207885a.11.2024.08.21.00.19.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Aug 2024 00:19:20 -0700 (PDT)
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
	Keith Busch <kbusch@kernel.org>
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
Subject: [PATCH v2 4/9] gpio: Replace deprecated PCI functions
Date: Wed, 21 Aug 2024 09:18:37 +0200
Message-ID: <20240821071842.8591-6-pstanner@redhat.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240821071842.8591-2-pstanner@redhat.com>
References: <20240821071842.8591-2-pstanner@redhat.com>
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

