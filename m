Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BFD81D47AA
	for <virtualization@lists.linux.dev>; Tue, 27 Aug 2024 18:56:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724784996; cv=none; b=dwPlBYiaeIg0EKF6fJ6XuC9PCxwh3VkQA9eVyEhH7X5992ORHiaJ/ima7JHeykvjEKgD0TS1w651F+rt9+7DqL83dhg0q6OdeJmkIcYNwBsWcehpHiyZvnBFvyenM2kZ0RiCtL23aV9BUV4BLE1hs3AyoVv3KaxjdXsa2oxQYEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724784996; c=relaxed/simple;
	bh=ARR42U31SsfvWWCrHwbXesPCT1d63Wp8dyC5fYwgRtc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Y6HR2mBQKFadtDUvhY2d9knDKCOo443dt9BBnXHI1D/z8bAkDYIzW2eTtnPfCGL4gY8jhiDi+bVabsoqIVyHhia7W4wlvD0zdqZLlOXuak+ggvTNDMF+WD5F0L41ZzAxYfjiDzdFSd3mtTumTyNnTSBTk0bev4YUdcjGXRrORks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RQBTr+qp; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RQBTr+qp"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724784993;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ot52nkK/Na0X35bsJx5mf+W03nkANhJiuieinuTtF+Y=;
	b=RQBTr+qpOUpg5tAu8YqawR+c+0Mg9SNEDojSMhqaPHCma0quKx6JrDKW90OsnAu/z39NVr
	BseHHE1s9nEv26x0aKZ3fobRIMn8WWVvlEpMXDMw5pzggKVZxjz0qcnKdJ94dt+AY2bH3L
	ojHqp3hGz7E/zI6CbcKTazQabbZX22I=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-224-5JETAV0IOgKUbMYxvOs5_w-1; Tue, 27 Aug 2024 14:56:30 -0400
X-MC-Unique: 5JETAV0IOgKUbMYxvOs5_w-1
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-a8698664af8so765882966b.0
        for <virtualization@lists.linux.dev>; Tue, 27 Aug 2024 11:56:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724784989; x=1725389789;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ot52nkK/Na0X35bsJx5mf+W03nkANhJiuieinuTtF+Y=;
        b=CL40HswNSYRT5RCZmQhz5WWpm4We4TlvdaGGf2zk+AIIda8hUsQSngfZx8fGCgeglC
         iq4V7gHJyQBvOsObizs7kLD5/0UeUm1fvPl8NmtQNOJTTWNi45za2PkNjrLGT90hZgCl
         Rl9xWWC3EYb3drZ/17PzeUtvTkJKQugpsJfA6rXP9OygwkZCgD2Z9fRUwyXm7vERTb3b
         43M8CxcQeDmjya8nkfqYYsITm5nOUNljQudw5l53pnhojMGkL4/Um/qWhgNVxprQtmRQ
         kk7sCOj1kSN9ye9scHwxcyWivIVhHikte+zG147HWh92cfa/Swd93c4acxny14GQAgpc
         GtkA==
X-Forwarded-Encrypted: i=1; AJvYcCUho5kf6KYsguRMOjSBm6vWkDtpj0SbLNE+JjxdKDqhTf1Ci6auYBq2pJavk3ukyGtWy5IiryhclyVm3+0rKg==@lists.linux.dev
X-Gm-Message-State: AOJu0YyzbDEUQ3mCh9OM/6nefpSK95PZqBLEVvhvSIPjoi2PVXCFxOU4
	kXNViSZmWWw+nuY5GqMzAufqUEaa3jnusH48eTG07S+/ZOYelscxX89GWNvtiSDAW4f30OobUbN
	rLithAJXKw0clIcpftK067xk+TflLT9jJ26IwjwpGK3MOqQHavf0CIHWW4VKEOA+O
X-Received: by 2002:a17:907:968b:b0:a77:dbf9:118f with SMTP id a640c23a62f3a-a870589d7bemr19230166b.13.1724784988732;
        Tue, 27 Aug 2024 11:56:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFpPIsWnweTtHk2jYqlmIfKSsDaoipOeMWhXQ4B5bGcQn25jUZvX7EeAh161EGEDUYY0nmhrA==
X-Received: by 2002:a17:907:968b:b0:a77:dbf9:118f with SMTP id a640c23a62f3a-a870589d7bemr19227366b.13.1724784988317;
        Tue, 27 Aug 2024 11:56:28 -0700 (PDT)
Received: from eisenberg.fritz.box ([2001:16b8:3dbc:3c00:460c:db7e:8195:ddb5])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a86e549c4e9sm141473066b.47.2024.08.27.11.56.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Aug 2024 11:56:27 -0700 (PDT)
From: Philipp Stanner <pstanner@redhat.com>
To: ens Axboe <axboe@kernel.dk>,
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
	Keith Busch <kbusch@kernel.org>,
	Philipp Stanner <pstanner@redhat.com>
Cc: linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-fpga@vger.kernel.org,
	linux-gpio@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-pci@vger.kernel.org,
	virtualization@lists.linux.dev
Subject: [PATCH v4 5/7] ethernet: cavium: Replace deprecated PCI functions
Date: Tue, 27 Aug 2024 20:56:10 +0200
Message-ID: <20240827185616.45094-6-pstanner@redhat.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240827185616.45094-1-pstanner@redhat.com>
References: <20240827185616.45094-1-pstanner@redhat.com>
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

Furthermore, the driver contains an unneeded call to
pcim_iounmap_regions() in its probe() function's error unwind path.

Replace the deprecated PCI functions with pcim_iomap_region().

Remove the unnecessary call to pcim_iounmap_regions().

Signed-off-by: Philipp Stanner <pstanner@redhat.com>
---
 drivers/net/ethernet/cavium/common/cavium_ptp.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/cavium/common/cavium_ptp.c b/drivers/net/ethernet/cavium/common/cavium_ptp.c
index 9fd717b9cf69..914ccc8eaf5e 100644
--- a/drivers/net/ethernet/cavium/common/cavium_ptp.c
+++ b/drivers/net/ethernet/cavium/common/cavium_ptp.c
@@ -239,12 +239,11 @@ static int cavium_ptp_probe(struct pci_dev *pdev,
 	if (err)
 		goto error_free;
 
-	err = pcim_iomap_regions(pdev, 1 << PCI_PTP_BAR_NO, pci_name(pdev));
+	clock->reg_base = pcim_iomap_region(pdev, PCI_PTP_BAR_NO, pci_name(pdev));
+	err = PTR_ERR_OR_ZERO(clock->reg_base);
 	if (err)
 		goto error_free;
 
-	clock->reg_base = pcim_iomap_table(pdev)[PCI_PTP_BAR_NO];
-
 	spin_lock_init(&clock->spin_lock);
 
 	cc = &clock->cycle_counter;
@@ -292,7 +291,6 @@ static int cavium_ptp_probe(struct pci_dev *pdev,
 	clock_cfg = readq(clock->reg_base + PTP_CLOCK_CFG);
 	clock_cfg &= ~PTP_CLOCK_CFG_PTP_EN;
 	writeq(clock_cfg, clock->reg_base + PTP_CLOCK_CFG);
-	pcim_iounmap_regions(pdev, 1 << PCI_PTP_BAR_NO);
 
 error_free:
 	devm_kfree(dev, clock);
-- 
2.46.0

