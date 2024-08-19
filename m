Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B2EC17921D
	for <virtualization@lists.linux.dev>; Mon, 19 Aug 2024 16:52:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724086356; cv=none; b=UaPjiY3W5jmGyQbu+JsN6o34bLvcduQWloN9oLboiJXNxIJnKrI3Vib7YfFFbfVhkguRk0mRQVoZKrVrEYT1rCF5rqrNDgce7Z/1Ej8jLyfWEo4j8wuA43BBH7PDLSNPculXOEv3gSqK98n634bIJhUF3rkqX+xRD0kMHnm3kyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724086356; c=relaxed/simple;
	bh=StzfX7D+b5jZ3LVEyPb0XmRGLTAQPRkMUDb8wVYSh3w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=OIa0GVmGsKPfgyR2hf7eFoQ2miQS3Rm8TURWK9S835lDCt3Y7tB+GfmApt2i+RsHpq7qS0rk9BhClaJJn4mnV5lVh7I4puO9FmY13ge9auBBRDKXwsVZtfaknlUQquXVr1PeeUOPs/9JdhVKVAw0pUuBWMfrne3wnTb/bvBwP8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=c3PIROzY; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="c3PIROzY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724086354;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=oDgCmWXPsT/ByKSJo2B5hdxGUNecM9yTJg3LqwyPBvM=;
	b=c3PIROzYChOEkCMNL3+JKDkdWxx4sQ5XmLezRLblRFvPM5M6pLNNx3PR0bJd5N9TA4heYV
	toYrFMiQrZRmQLc7EFd1Gvs4BIPgUWCKWlh1aY++evT3PiI8QWtoAUgnZ+dppkbM+j64ym
	2SVGqcA24+Sjto/y4QjPLxlew08/yWI=
Received: from mail-ot1-f71.google.com (mail-ot1-f71.google.com
 [209.85.210.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-688-hIA7Q8bPNR-VpDtR5dWDvA-1; Mon, 19 Aug 2024 12:52:30 -0400
X-MC-Unique: hIA7Q8bPNR-VpDtR5dWDvA-1
Received: by mail-ot1-f71.google.com with SMTP id 46e09a7af769-70954de6142so891488a34.0
        for <virtualization@lists.linux.dev>; Mon, 19 Aug 2024 09:52:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724086350; x=1724691150;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oDgCmWXPsT/ByKSJo2B5hdxGUNecM9yTJg3LqwyPBvM=;
        b=XTnrS8LKxESPTBNY6Vv4yMooN2bJGAcXySo5nhByOv+gdheXibn85wd8D+omKMwG0F
         XUZIoUURyLaGLNoQDL8DKhHTdVno4381bsQdIwPOyeZ8lO4XPGWYtcfye/oTZlqXwRJq
         WdY/HDSkZS9eTSIYBYH7Esvtma68mHNaJHvyCmVR38WGpxGEikHW/iBggZuEgMRAfhOV
         XiV4JqKsSTOuJHk+AhCqZdvi1JbfKypY6yRZV6M9XVHKuSdsdZEneMlVFq+qjocKsXxI
         Xxzl+BzlEWDenGAjWj0PyE5+AAT2E3KfBLzdTECQwPG8w7DCNH/eSp2L7Eaf77XUVY21
         YEdA==
X-Forwarded-Encrypted: i=1; AJvYcCWFv/i7c3Xrk+I7AaxtTDpCpGsZouN9OyOPCvnOOdtAi/SaJ/MmzgXkG2UhuwyDzywcd2vUoMuTOymWG62W4g==@lists.linux.dev
X-Gm-Message-State: AOJu0Yw/HJS6gnrFMAATs0voVXjyVPl9mHcS28Fowme3MNMCytofuKlO
	tz8+mF1kC4lbI9wgPlqYEck751VCv4zjKV5kBwZH6z/Xmq3shzmiPp3HS0id/miChT4kU1nto+Y
	PeQaovqlarG8B10OeyC4glTU+wqKPSZA3ho1UQRdLmGLL58JG4kLEt2KyyCKM8Eqo
X-Received: by 2002:a05:6359:4c87:b0:1ac:a26c:a5e8 with SMTP id e5c5f4694b2df-1b39333e0c1mr737788055d.4.1724086349982;
        Mon, 19 Aug 2024 09:52:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEksR+Cpw2eRNuHRkEIfwdvURGCWFxAEIEKM8Aw05iYSBMnqj3x39V0KKigIE6pVo5nSVtsiQ==
X-Received: by 2002:a05:6359:4c87:b0:1ac:a26c:a5e8 with SMTP id e5c5f4694b2df-1b39333e0c1mr737785755d.4.1724086349577;
        Mon, 19 Aug 2024 09:52:29 -0700 (PDT)
Received: from eisenberg.muc.redhat.com (nat-pool-muc-t.redhat.com. [149.14.88.26])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a4ff01e293sm446579885a.26.2024.08.19.09.52.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Aug 2024 09:52:29 -0700 (PDT)
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
Subject: [PATCH 0/9] PCI: Remove pcim_iounmap_regions()
Date: Mon, 19 Aug 2024 18:51:40 +0200
Message-ID: <20240819165148.58201-2-pstanner@redhat.com>
X-Mailer: git-send-email 2.46.0
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

Important things first:
This series is based on [1] and [2] which Bjorn Helgaas has currently
queued for v6.12 in the PCI tree.

This series shall remove pcim_iounmap_regions() in order to make way to
remove its brother, pcim_iomap_regions().

@Bjorn: Feel free to squash the PCI commits.

Regards,
P.

[1] https://lore.kernel.org/all/20240729093625.17561-4-pstanner@redhat.com/
[2] https://lore.kernel.org/all/20240807083018.8734-2-pstanner@redhat.com/

Philipp Stanner (9):
  PCI: Make pcim_release_region() a public function
  PCI: Make pcim_iounmap_region() a public function
  fpga/dfl-pci.c: Replace deprecated PCI functions
  block: mtip32xx: Replace deprecated PCI functions
  gpio: Replace deprecated PCI functions
  ethernet: cavium: Replace deprecated PCI functions
  ethernet: stmicro: Simplify PCI devres usage
  vdap: solidrun: Replace deprecated PCI functions
  PCI: Remove pcim_iounmap_regions()

 .../driver-api/driver-model/devres.rst        |  1 -
 drivers/block/mtip32xx/mtip32xx.c             | 11 +++--
 drivers/fpga/dfl-pci.c                        |  9 ++--
 drivers/gpio/gpio-merrifield.c                | 14 +++---
 .../net/ethernet/cavium/common/cavium_ptp.c   | 10 ++--
 .../ethernet/stmicro/stmmac/dwmac-loongson.c  | 25 +++-------
 .../net/ethernet/stmicro/stmmac/stmmac_pci.c  | 18 +++----
 drivers/pci/devres.c                          | 25 ++--------
 drivers/pci/pci.h                             |  1 -
 drivers/vdpa/solidrun/snet_main.c             | 47 +++++++------------
 include/linux/pci.h                           |  3 +-
 11 files changed, 57 insertions(+), 107 deletions(-)

-- 
2.46.0

