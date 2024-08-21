Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 898301A7AC8
	for <virtualization@lists.linux.dev>; Wed, 21 Aug 2024 07:19:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724224759; cv=none; b=NGc2jNkkKyOBVjcSYUS1G6H1G728BQ+SrHS6FUYDPZy5Vld5fPXaABT2toigg6+XmUjtIvjS7QXsHu7UT5pCTlALRIYcjRKjAEb5oSrXsEoIiV45V5wwCcywPquDRXQAqihUSMWOercHfONdG4HttfR0IR8u24MDWeu/mptwly4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724224759; c=relaxed/simple;
	bh=X1zz/TunuR2PG93iDywgu0fR0ZIioix5D5qvFJsuS9M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=h5jnCYn3qvMj64XydGYcGqkre3+RfVBmCyD1R3X6E3qPy+PPM7mTyo/pITIzlxhQ4e+xSgtlHhozqqf2+y0P+ac1mlnovl+kN5MFergJuXptsBb+E+8EzT4SOLx1d7Cf6GjIN6uTez/vcNZKCXfAte68sGx87I8l8j3BUJ3Gcvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SBI4eUq+; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SBI4eUq+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724224757;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CLI8bZjR6OdWE6SPmBhjzuWJVjW15O9K3MBwEhWkwDY=;
	b=SBI4eUq+kkz97PsPcZrDxcCfP2DvoajxiroxRMLzem7onMZODHVsPsOM3fIaClLo+XTOCY
	1TxVNJUKHxTGCLJPB7KwOy9MNTVbWhDxBy0ixYedr9jlgpEKRn++OcCDe7J4okkn7ZS61X
	Sid52sl/7/IDr9Q/Q39R2aMBFDJJQPU=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-222-lfUdw6RgOmqAEYVSDYRetw-1; Wed, 21 Aug 2024 03:19:16 -0400
X-MC-Unique: lfUdw6RgOmqAEYVSDYRetw-1
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-7a34e9c8945so657226685a.2
        for <virtualization@lists.linux.dev>; Wed, 21 Aug 2024 00:19:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724224755; x=1724829555;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CLI8bZjR6OdWE6SPmBhjzuWJVjW15O9K3MBwEhWkwDY=;
        b=MNO65ve5Xf/ntOS/l854OOm7qHqjjaiRA3xcpJf8tM4xRvGeEruNqN8fMjvAHBtZqr
         shaYn65nVQh4sovSzfNA9nUQoF0j5aFlxQuHMWe7lHUkhoRyWsk2oTaUV/SpSFy9c4QE
         90vghA+BgJr+wQevDuC5qyYE15kZlLHsEHrI7BfQ1yLBB4ckWFFg0kkh0qIykGMO5G6A
         +m6UNWUOcC7mc1pRdETs5OsnC+eMstzMzbfi19ZdlUYNaB3kLhaStBJVJQxytO4GFrLo
         2w8hYv1L06kb5rIHbFK0ovcCF+Aehbiq0O6yvM8qvBKZ8iCs4ExOIqdtpiYj++8rtD5L
         LBhg==
X-Forwarded-Encrypted: i=1; AJvYcCX602XJhHbAs9EhMAsG0PEE/ZOeK9njC10HBZxTH8rrMMo3WwCLsu/bDMnU+gr0+fPuM/PT0bL56oCNY7MSoQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Ywxd+N48xwvHfWh3g5NSogpSnS+eDjrTHI07nkbx2nIEaWThOJE
	zQ48yuFKwnpOP7oUmk9xePO1ZqWG5L4IBPqnfofjqWXYdzIRdzGKarAYY8dhTWUN4jQOSqBKxNF
	rUGUmdb9XvtWFNrXf7F9uNwohR+HTJ9X+KUaKPxf/VOhTTjnwmm1iora5WBBLs6Vb
X-Received: by 2002:a05:620a:1906:b0:79e:f8b7:5c73 with SMTP id af79cd13be357-7a6740c5e31mr226525785a.55.1724224755550;
        Wed, 21 Aug 2024 00:19:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFtpkoHy3cS2PdzwF01k905nXUdsELS2xvQjiGeTjNuWZ60d5TFnGqma74hup77Ia1MJryw5Q==
X-Received: by 2002:a05:620a:1906:b0:79e:f8b7:5c73 with SMTP id af79cd13be357-7a6740c5e31mr226522685a.55.1724224755041;
        Wed, 21 Aug 2024 00:19:15 -0700 (PDT)
Received: from eisenberg.redhat.com (nat-pool-muc-t.redhat.com. [149.14.88.26])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a4ff013ef2sm596207885a.11.2024.08.21.00.19.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Aug 2024 00:19:14 -0700 (PDT)
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
	virtualization@lists.linux.dev
Subject: [PATCH v2 3/9] block: mtip32xx: Replace deprecated PCI functions
Date: Wed, 21 Aug 2024 09:18:36 +0200
Message-ID: <20240821071842.8591-5-pstanner@redhat.com>
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

In mtip32xx, these functions can easily be replaced by their respective
successors, pcim_request_region() and pcim_iomap(). Moreover, the
driver's calls to pcim_iounmap_regions() in probe()'s error path and in
remove() are not necessary. Cleanup can be performed by PCI devres
automatically.

Replace pcim_iomap_regions() and pcim_iomap_table().

Remove the calls to pcim_iounmap_regions().

Signed-off-by: Philipp Stanner <pstanner@redhat.com>
---
 drivers/block/mtip32xx/mtip32xx.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/block/mtip32xx/mtip32xx.c b/drivers/block/mtip32xx/mtip32xx.c
index c6ef0546ffc9..fcd5806621c7 100644
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
@@ -3726,9 +3728,9 @@ static int mtip_pci_probe(struct pci_dev *pdev,
 	}
 
 	/* Map BAR5 to memory. */
-	rv = pcim_iomap_regions(pdev, 1 << MTIP_ABAR, MTIP_DRV_NAME);
+	rv = pcim_request_region(pdev, MTIP_ABAR, MTIP_DRV_NAME);
 	if (rv < 0) {
-		dev_err(&pdev->dev, "Unable to map regions\n");
+		dev_err(&pdev->dev, "Unable to request regions\n");
 		goto iomap_err;
 	}
 
@@ -3849,8 +3851,6 @@ static int mtip_pci_probe(struct pci_dev *pdev,
 		drop_cpu(dd->work[2].cpu_binding);
 	}
 setmask_err:
-	pcim_iounmap_regions(pdev, 1 << MTIP_ABAR);
-
 iomap_err:
 	kfree(dd);
 	pci_set_drvdata(pdev, NULL);
@@ -3925,7 +3925,6 @@ static void mtip_pci_remove(struct pci_dev *pdev)
 
 	pci_disable_msi(pdev);
 
-	pcim_iounmap_regions(pdev, 1 << MTIP_ABAR);
 	pci_set_drvdata(pdev, NULL);
 
 	put_disk(dd->disk);
-- 
2.46.0

