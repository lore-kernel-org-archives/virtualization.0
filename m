Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E47A318A92F
	for <virtualization@lists.linux.dev>; Mon, 19 Aug 2024 16:53:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724086396; cv=none; b=K44Nwlk2KzahT6jhCLDG2Cq33KS1h+HELALkAqhioaj9AIApH1NohQRHqNNrX+98hy4FORp/CkD1XQtSQTQTq/VtXtU4bK2XP+WSSCyboYACsyI3GWDk/WdhH1Qg2GsKDnxuFVAL/qYNuE6ADTUB3yBkPgiz5arkcTSzckpF4qo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724086396; c=relaxed/simple;
	bh=1bt3tMc09G6s9xV0I/qYPefc2X8n9siL1P6ZGlLhoAc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kxZ+by/rjT1icmKYftK0lgW10MS6NKPcgeBl22GZ+RXjaZJnbSIkQLFGdqljTX/hW/czOdRulvODvUSPyGJ7VGIqAM4RKci6U60De+hyXfUumqdbFAsT91JqFZ9r/wVpDtgxXvX5TmjCnXkPp4N5cSZiTliSz4Y6W8U+voP29yo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=jHEosUDa; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jHEosUDa"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724086394;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=abZiwvPf4gC19vxFT17Sz8slSRtUXISkEhAwbNUMlrw=;
	b=jHEosUDaYifn+Ib8dZE0Kf2u7oL3JJsB3kc9nht8ZBXoqYGpo6wjgxrbWcQmsc8QeqQNWz
	qaoQJ9qGgxK5QuYalpxO+w75hndqL5VRMJj4hDLOEGcq+wJkWWWGm9uVIrOYePD8Zo2rB2
	Z4jJ71/qaXpBrwdCLGvV2woVkTMVDEI=
Received: from mail-ua1-f69.google.com (mail-ua1-f69.google.com
 [209.85.222.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-138-191yljKYPHWP5KlyGnBKxA-1; Mon, 19 Aug 2024 12:53:12 -0400
X-MC-Unique: 191yljKYPHWP5KlyGnBKxA-1
Received: by mail-ua1-f69.google.com with SMTP id a1e0cc1a2514c-8430e0fcda8so49428241.1
        for <virtualization@lists.linux.dev>; Mon, 19 Aug 2024 09:53:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724086392; x=1724691192;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=abZiwvPf4gC19vxFT17Sz8slSRtUXISkEhAwbNUMlrw=;
        b=kHfNuQMdm3Yp88K5VF49da+WG/3x1mVDWb7g++QKQlF40hz2rjH5B0bSS9FnxrP0r+
         8kxVeCorDf8Ro+cD9aISwt1RmqB/BXoo4C10hK2dfLoOU7ReyW+OHCih7NxfiXK5jn+u
         avQjMpfYLmWLl8EsrLlNGb/jk0QDAq2SIcaD5dMiTG5cOlqRG6DRQdYgNopFUYLoxREh
         VPYj+jlTt6yn6XiSi7dbwLlRKrl8lBPydxg1wU8NxlbRFMhNqa1T+xCqKVmMsiTRGOeQ
         a79GyEDLMqGfiD8p4HyX7wnqPvFPoNIi21WQK8HafEyMn0wPgzsNScxeezRae9O1Bt30
         Qq/A==
X-Forwarded-Encrypted: i=1; AJvYcCWwGSQAHtk4V+QW8ZlgQzZqVLxssbOZyFWwrUWnTzyeXpzjkyOck+jw7OaQh+TTmpeXYa7FPWCB+YhJzUeMUQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Yx8Y2SMcjS8F9xLzKULpjS2FBLBBbI++Srgt39Sr/74wVJVRJYs
	d15sIxe+Dx+U19N59CZLk79fdPUscoa6txSyeXi/oHQULB5jzUkZ3wuh1CuAXxJ23y0zz0+pfhd
	xwIOGVGwIqelgXiHS0XSx/IDvKr+gmq+QZgOAEH/zj8w2gDD/ie6YPx/+RebB5Cvv
X-Received: by 2002:a05:6102:5127:b0:493:bb70:940 with SMTP id ada2fe7eead31-4977992674fmr7984153137.2.1724086392198;
        Mon, 19 Aug 2024 09:53:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGSFSVYmUjqgNVHiq1+h9E7HGJis8qQ3DMxEZS8Skowa7KMQsueVdBGNDdQuxxSfXwtk0QtBA==
X-Received: by 2002:a05:6102:5127:b0:493:bb70:940 with SMTP id ada2fe7eead31-4977992674fmr7984139137.2.1724086391863;
        Mon, 19 Aug 2024 09:53:11 -0700 (PDT)
Received: from eisenberg.muc.redhat.com (nat-pool-muc-t.redhat.com. [149.14.88.26])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a4ff01e293sm446579885a.26.2024.08.19.09.53.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Aug 2024 09:53:11 -0700 (PDT)
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
Subject: [PATCH 8/9] vdap: solidrun: Replace deprecated PCI functions
Date: Mon, 19 Aug 2024 18:51:48 +0200
Message-ID: <20240819165148.58201-10-pstanner@redhat.com>
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

solidrun utilizes pcim_iomap_regions(), which has been deprecated by the
PCI subsystem in commit e354bb84a4c1 ("PCI: Deprecate
pcim_iomap_table(), pcim_iomap_regions_request_all()"), among other
things because it forces usage of quite a complicated bitmask mechanism.
The bitmask handling code can entirely be removed by replacing
pcim_iomap_regions() and pcim_iomap_table().

Replace pcim_iomap_regions() and pcim_iomap_table() with
pci_iomap_region().

Signed-off-by: Philipp Stanner <pstanner@redhat.com>
---
 drivers/vdpa/solidrun/snet_main.c | 47 +++++++++++--------------------
 1 file changed, 16 insertions(+), 31 deletions(-)

diff --git a/drivers/vdpa/solidrun/snet_main.c b/drivers/vdpa/solidrun/snet_main.c
index 99428a04068d..abf027ca35e1 100644
--- a/drivers/vdpa/solidrun/snet_main.c
+++ b/drivers/vdpa/solidrun/snet_main.c
@@ -556,33 +556,24 @@ static const struct vdpa_config_ops snet_config_ops = {
 static int psnet_open_pf_bar(struct pci_dev *pdev, struct psnet *psnet)
 {
 	char name[50];
-	int ret, i, mask = 0;
+	int i;
+
+	snprintf(name, sizeof(name), "psnet[%s]-bars", pci_name(pdev));
+
 	/* We don't know which BAR will be used to communicate..
 	 * We will map every bar with len > 0.
 	 *
 	 * Later, we will discover the BAR and unmap all other BARs.
 	 */
 	for (i = 0; i < PCI_STD_NUM_BARS; i++) {
-		if (pci_resource_len(pdev, i))
-			mask |= (1 << i);
-	}
-
-	/* No BAR can be used.. */
-	if (!mask) {
-		SNET_ERR(pdev, "Failed to find a PCI BAR\n");
-		return -ENODEV;
-	}
-
-	snprintf(name, sizeof(name), "psnet[%s]-bars", pci_name(pdev));
-	ret = pcim_iomap_regions(pdev, mask, name);
-	if (ret) {
-		SNET_ERR(pdev, "Failed to request and map PCI BARs\n");
-		return ret;
-	}
+		if (pci_resource_len(pdev, i)) {
+			psnet->bars[i] = pcim_iomap_region(pdev, i, name);
+			if (IS_ERR(psnet->bars[i])) {
+				SNET_ERR(pdev, "Failed to request and map PCI BARs\n");
+				return PTR_ERR(psnet->bars[i]);
+			}
+		}
 
-	for (i = 0; i < PCI_STD_NUM_BARS; i++) {
-		if (mask & (1 << i))
-			psnet->bars[i] = pcim_iomap_table(pdev)[i];
 	}
 
 	return 0;
@@ -591,18 +582,15 @@ static int psnet_open_pf_bar(struct pci_dev *pdev, struct psnet *psnet)
 static int snet_open_vf_bar(struct pci_dev *pdev, struct snet *snet)
 {
 	char name[50];
-	int ret;
 
 	snprintf(name, sizeof(name), "snet[%s]-bar", pci_name(pdev));
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
 
@@ -650,15 +638,12 @@ static int psnet_detect_bar(struct psnet *psnet, u32 off)
 
 static void psnet_unmap_unused_bars(struct pci_dev *pdev, struct psnet *psnet)
 {
-	int i, mask = 0;
+	int i;
 
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

