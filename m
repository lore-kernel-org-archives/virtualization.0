Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B549A1CC8BE
	for <virtualization@lists.linux.dev>; Thu, 22 Aug 2024 13:48:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724334494; cv=none; b=s6yRHeANS21nsBZqg7PKG7rN7G4A/6VM1UVgnEK6QjJmFYFWBa90ZF0Zdr+Y5CgUFokwCwF+ltX+JA1z6vBNgCtH3Eu0MGZNgZMSlITe98O3lqr2R8LB3xAfBdPbvnUyzvF1k1xf1Yk7mKJf20GYV+fIZP4FsCKQ19Z277qPTbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724334494; c=relaxed/simple;
	bh=SgQa/apEnyQVxi5RGIOMYDsJA8zmcu1/aNTE/QznKio=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=H2KyrjH0yDZOm3ea37675wyLNHlt0FPZcaF5hfVyEJy9GHhQruZb8SPRJOftDsCzKyNEdy+yMWgS3QvjnaSHpnmIhIHMXw+rCdthmNiu7YDtRzRuj3VxhKHm1gpXmIx2ejz4XrntkXrzYlrbSpnRJ10d1lA3oRNAqq+0UwHifO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Mzli9v02; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Mzli9v02"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724334490;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AJtm3uYD4inmsDECmrMxkvS6gTo4VXXtBuq4LxNQ/Aw=;
	b=Mzli9v02OmQAsQKRvY8aHCmI8MRnjpfNg+QpoiUO97m7SmUZ6ixpjz6GtJyZsxj62/lsNc
	AgwzNJHszOatSnj2KF49G0v6CmQz7I6QonB/rSVPSdb6qW3Ypl5t+ROoVNgro2OLMsV9+l
	7oFHDVUlcsTA1Qf7/AItRcr4u9x4xLs=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-128-sZkgWYJjOgyCaMnq9w8e_Q-1; Thu, 22 Aug 2024 09:48:07 -0400
X-MC-Unique: sZkgWYJjOgyCaMnq9w8e_Q-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-42809eb7b99so4693225e9.0
        for <virtualization@lists.linux.dev>; Thu, 22 Aug 2024 06:48:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724334486; x=1724939286;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AJtm3uYD4inmsDECmrMxkvS6gTo4VXXtBuq4LxNQ/Aw=;
        b=JuzjP7V47sZRs3tKyFLs/kSKM+w3Z+wNPRl9zSeckCJhV+6/kcmz03mO/aQMb8/IFc
         GUjB3/dPW9UPoc/tq5l31zArF33vIcYuPLD5MmXZjOBUjPyxZWXbGlt0VfLj2Y8v0s06
         bJfjiwUv3pyw0V0wDgigVovzYmaAupvpoAp/RH+t948LAqZ5/xpbmruDLc9GZtZUe2hf
         SNqd8PP2dCWIOgAVUPi409o4CjoceWi7MExROzN0659t13+e11hG2LBF+IDLKt+xAl9S
         HuJKf0KF/QH+wgVFLqr1P7AiSSAzyQJaPCqZxDyMvu5r+EREiJSge1IBukWeNlvCZ+33
         9t/A==
X-Forwarded-Encrypted: i=1; AJvYcCX0DSe57HpuwK4mT799MtgDcrvRXo7EXIMABUVBPsEL8YbP0GpE0Pey5XskPS+9yeBh1uyg2o9G3C4LKpxQOw==@lists.linux.dev
X-Gm-Message-State: AOJu0YwKdk7+MK4+Z7kMUsKxjLjlGB0WRFecm4zHC94EQwa8PM69Eg7V
	0URmsiDQemsQ5uWKXFVB72rFHddaLx4n3UyUQKxkevIYrgst0mCFVVlVR9ikA+TuMkT2VfvC6hu
	utJ9XIO83XRXK2Gql0iBSImi06RAWVkFfkZDfoWoVDWRqKiXO8fx6My0EKCdf5EyE
X-Received: by 2002:a05:600c:5112:b0:426:63bc:f031 with SMTP id 5b1f17b1804b1-42ac3899e09mr16337195e9.1.1724334486181;
        Thu, 22 Aug 2024 06:48:06 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGRSoYjY+fRaVMhy3JkraKLBSrGHIYEYva7zoKLHV+1g1iMr3Zs/N1D05tQ7XJx0t0ZIIxXpg==
X-Received: by 2002:a05:600c:5112:b0:426:63bc:f031 with SMTP id 5b1f17b1804b1-42ac3899e09mr16336835e9.1.1724334485558;
        Thu, 22 Aug 2024 06:48:05 -0700 (PDT)
Received: from eisenberg.muc.redhat.com (nat-pool-muc-t.redhat.com. [149.14.88.26])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42ac5162322sm25057215e9.24.2024.08.22.06.48.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Aug 2024 06:48:05 -0700 (PDT)
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
Subject: [PATCH v3 5/9] ethernet: cavium: Replace deprecated PCI functions
Date: Thu, 22 Aug 2024 15:47:37 +0200
Message-ID: <20240822134744.44919-6-pstanner@redhat.com>
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

pcim_iomap_regions() and pcim_iomap_table() have been deprecated by
the PCI subsystem in commit e354bb84a4c1 ("PCI: Deprecate
pcim_iomap_table(), pcim_iomap_regions_request_all()").

Replace these functions with the function pcim_iomap_region().

Signed-off-by: Philipp Stanner <pstanner@redhat.com>
---
 drivers/net/ethernet/cavium/common/cavium_ptp.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/cavium/common/cavium_ptp.c b/drivers/net/ethernet/cavium/common/cavium_ptp.c
index 9fd717b9cf69..1849c62cde1d 100644
--- a/drivers/net/ethernet/cavium/common/cavium_ptp.c
+++ b/drivers/net/ethernet/cavium/common/cavium_ptp.c
@@ -239,11 +239,11 @@ static int cavium_ptp_probe(struct pci_dev *pdev,
 	if (err)
 		goto error_free;
 
-	err = pcim_iomap_regions(pdev, 1 << PCI_PTP_BAR_NO, pci_name(pdev));
-	if (err)
+	clock->reg_base = pcim_iomap_region(pdev, PCI_PTP_BAR_NO, pci_name(pdev));
+	if (IS_ERR(clock->reg_base)) {
+		err = PTR_ERR(clock->reg_base);
 		goto error_free;
-
-	clock->reg_base = pcim_iomap_table(pdev)[PCI_PTP_BAR_NO];
+	}
 
 	spin_lock_init(&clock->spin_lock);
 
@@ -292,7 +292,7 @@ static int cavium_ptp_probe(struct pci_dev *pdev,
 	clock_cfg = readq(clock->reg_base + PTP_CLOCK_CFG);
 	clock_cfg &= ~PTP_CLOCK_CFG_PTP_EN;
 	writeq(clock_cfg, clock->reg_base + PTP_CLOCK_CFG);
-	pcim_iounmap_regions(pdev, 1 << PCI_PTP_BAR_NO);
+	pcim_iounmap_region(pdev, PCI_PTP_BAR_NO);
 
 error_free:
 	devm_kfree(dev, clock);
-- 
2.46.0

