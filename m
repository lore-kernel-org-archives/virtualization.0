Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04ACB18785A
	for <virtualization@lists.linux.dev>; Mon, 19 Aug 2024 16:52:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724086360; cv=none; b=prGlNzK7N+hv26dPrfG57Y3EjYHAqiWOZ5MQ2tOP3fi4yXl9UoVo0/UlJuPPjSz5o90jKpOr+vuMHr8/jIIkWayN+Z4WpeM0h0/f0G4OqVDV4JQFVjQG8B2kxq/yBoDpmiAGG1B8SD844vKw2Y62+oC5L+UFMO74s2pPI8te7As=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724086360; c=relaxed/simple;
	bh=kHKzvvyyQCeBkpz1OciLUTykSAMmzD8brX9rJ76+fHY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cN9ZTWvvd3GaVckGsf3Rpwlo3+5tIrtRgeCAMHwyD+wo3RXPFcKXiPuKxS2dQQ31Mcac1ELf6VxiUvZYF9EzpQfYvLaRelJ2uugmxCCFNWW6YG4g1pkJK2IOpgy4VNa+sNo2F0Vhdapl+C2RN4KxXyjS/LtGF8x0NlBo7fifI58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OrHjSB0w; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OrHjSB0w"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724086358;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NwxbMRfa8A0AMonhiodSZXz8snc1ppjCUOJ6oxZMysE=;
	b=OrHjSB0wyGLxVAHbxF8kqFP29uGBxLDDRv7Ops7LOliZLNGX9M0rGTP3NwnEpfNOKAtGht
	/njkpjuCj+n6xAQBtfxvjYCpji0V5yxnoQrlET4hPobqADDE1z2hGyakcW+gIDR0m0JvWo
	oLpRH3xmjkrqgVvzgJO9qiNgXv9FPeo=
Received: from mail-ua1-f70.google.com (mail-ua1-f70.google.com
 [209.85.222.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-15-y0Eb3WrgO7iKzasJkXE6xg-1; Mon, 19 Aug 2024 12:52:36 -0400
X-MC-Unique: y0Eb3WrgO7iKzasJkXE6xg-1
Received: by mail-ua1-f70.google.com with SMTP id a1e0cc1a2514c-84303cc34bdso77908241.3
        for <virtualization@lists.linux.dev>; Mon, 19 Aug 2024 09:52:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724086355; x=1724691155;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NwxbMRfa8A0AMonhiodSZXz8snc1ppjCUOJ6oxZMysE=;
        b=FCS1YUV4zEkejF4e5LL+QmAMkcKohD9JhjqfzYpIYRhJFAVbsciBIEydckYb4Lgzoa
         abCCfpa6CXsuD6Xei71T/XlGqEq0oH53aCjiq3XB9DDZ3uOzdDkLH02PoGkdpsNPPHrW
         VwhIXtSdbM69+bfViUUolBBvyS0FxJg6Jtn7Avl2ESVuYoGTQihKr+RkW2Btd2EAydeM
         UTFCe48T4dzBkOhmy/EC9AgoTIQHWXYrl6bsAWkw2i2uaYSwzOQir/lk3VyNrv5EUq1Z
         e9Xr9zDCzjZwP18dTRsokpOEjj9Uk8c7DunboIgTRpssvhq2RwGp+Vcy2M4H3rF91+Ll
         bIQw==
X-Forwarded-Encrypted: i=1; AJvYcCWN6x++m6a1Yg+4a2bzfj1UjRIWIABtkkdcvagCjuCiwRUdXkkMxbV4Zf7Zkgtargv0VcZGUwi0W3sVmJslFzZP/9QlTFkxO+NWOvI7kLM=
X-Gm-Message-State: AOJu0YytQWnEgI+eonpvSjuzt+dICcfz/sWNUh9B7qwIN8TDaALm4iI7
	O3+m5gQHVXSOLHeGzUcecsqRzYfins5mcRd8EUBKI2B5i6/1ggml9qeLbYuUb/icUQoi54OP6M3
	WiSPaOd1pQwOmYWvTaZJkLEq2jD1WWTmIcEoJefQj0gsd9fods4p2WlyYgOwCv56v
X-Received: by 2002:a05:6102:5494:b0:495:c40b:f7ca with SMTP id ada2fe7eead31-4977bf0d2d4mr5497598137.3.1724086355214;
        Mon, 19 Aug 2024 09:52:35 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHysbKKqXtZq0nkk+KqqjyQL404GAu1sdBPta+GD7btYSYi5SLJQ3pijiCStxEYNXypkns3Gw==
X-Received: by 2002:a05:6102:5494:b0:495:c40b:f7ca with SMTP id ada2fe7eead31-4977bf0d2d4mr5497574137.3.1724086354811;
        Mon, 19 Aug 2024 09:52:34 -0700 (PDT)
Received: from eisenberg.muc.redhat.com (nat-pool-muc-t.redhat.com. [149.14.88.26])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a4ff01e293sm446579885a.26.2024.08.19.09.52.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Aug 2024 09:52:34 -0700 (PDT)
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
Subject: [PATCH 1/9] PCI: Make pcim_release_region() a public function
Date: Mon, 19 Aug 2024 18:51:41 +0200
Message-ID: <20240819165148.58201-3-pstanner@redhat.com>
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

pcim_release_region() is the managed counterpart of
pci_release_region(). It can be useful in some cases where drivers want
to manually release a requested region before the driver's remove()
callback is invoked.

Make pcim_release_region() a public function.

Signed-off-by: Philipp Stanner <pstanner@redhat.com>
---
 drivers/pci/devres.c | 1 +
 drivers/pci/pci.h    | 1 -
 include/linux/pci.h  | 1 +
 3 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/devres.c b/drivers/pci/devres.c
index b97589e99fad..608f13ef2a4b 100644
--- a/drivers/pci/devres.c
+++ b/drivers/pci/devres.c
@@ -906,6 +906,7 @@ void pcim_release_region(struct pci_dev *pdev, int bar)
 	devres_release(&pdev->dev, pcim_addr_resource_release,
 			pcim_addr_resources_match, &res_searched);
 }
+EXPORT_SYMBOL(pcim_release_region);
 
 
 /**
diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index 2fe6055a334d..01b55ed2867c 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -889,7 +889,6 @@ static inline pci_power_t mid_pci_get_power_state(struct pci_dev *pdev)
 int pcim_intx(struct pci_dev *dev, int enable);
 int pcim_request_region_exclusive(struct pci_dev *pdev, int bar,
 				  const char *name);
-void pcim_release_region(struct pci_dev *pdev, int bar);
 
 /*
  * Config Address for PCI Configuration Mechanism #1
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 01b9f1a351be..dfa9af3a9c22 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -2295,6 +2295,7 @@ void __iomem *pcim_iomap(struct pci_dev *pdev, int bar, unsigned long maxlen);
 void pcim_iounmap(struct pci_dev *pdev, void __iomem *addr);
 void __iomem * const *pcim_iomap_table(struct pci_dev *pdev);
 int pcim_request_region(struct pci_dev *pdev, int bar, const char *name);
+void pcim_release_region(struct pci_dev *pdev, int bar);
 void __iomem *pcim_iomap_region(struct pci_dev *pdev, int bar,
 				       const char *name);
 int pcim_iomap_regions(struct pci_dev *pdev, int mask, const char *name);
-- 
2.46.0

