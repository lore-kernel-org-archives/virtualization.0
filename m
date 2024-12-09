Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D5CB221DAC
	for <virtualization@lists.linux.dev>; Mon,  9 Dec 2024 11:52:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733745132; cv=none; b=k5qTriGjMP4leOpdOcbbfcxLPXihj0xiYvPU3ww6DJYnDzusnphM1MufAY5RlZNJeRmC6spKGUHt/69QCV6ZXaULQ6WsyKzCpvGdLgBlKlHCtD8bYt/zyluTibQpV1kXdeTy24DMAXS2kL5AQtagu6zuRZKefD9ViKt/rila5tU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733745132; c=relaxed/simple;
	bh=zKAUbGmvAgID24Tkc2Jy8LhdxFNgsedeJPeuoBz5fSo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:content-type; b=VgX1fDv5rVnlLRnKwgyADAYnaVtE57hKKDkAQNHuZfR0V4DVljipy4I77eXvuZZw8iXPmgJnL9e4DijEgTSTtKe/nIFKcm1raWRqU5LKbLxtKTO+RlRQ7uRXgovXwUh1Gl0zxu+qsqQHTnWpLPYM9sPv7YsWfKrY9xSVOSEI4Dg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=X6PfBEr4; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="X6PfBEr4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733745129;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=39hwM53MEQ2TN5uIZ38P4dO6wIvfD25t892amO3OF6o=;
	b=X6PfBEr4yYfjDFfKdi193MFgaJBeZih77dw9FZ+WzswINaEmgCgM6DEx2S5coSpCu28jHi
	avitgSzYBpm7SNn2ENQt2Cm8QYHJC2DnLHrZSDxZAFF2GtF3iBAcyI1Y7lqj7yFWVmyS3v
	Yhsi+dyNGkyZPUznV2fErsrqDLfz4lY=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-446-CkAz88jaMRqOs8Wp7cdAWQ-1; Mon, 09 Dec 2024 06:52:07 -0500
X-MC-Unique: CkAz88jaMRqOs8Wp7cdAWQ-1
X-Mimecast-MFC-AGG-ID: CkAz88jaMRqOs8Wp7cdAWQ
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-434f3fcc891so9300285e9.1
        for <virtualization@lists.linux.dev>; Mon, 09 Dec 2024 03:52:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733745126; x=1734349926;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=39hwM53MEQ2TN5uIZ38P4dO6wIvfD25t892amO3OF6o=;
        b=SrCArofwLSPSa+zOCHQRx2JD5I0alAnToEfCSMTXGR4PYkpRVn4VibIVIvuR/9w7R4
         gytUYE3hJu1WnvWAwXM41V+T/GGZW1ZvOMgwJSfIpJsCV/55IDDfJgX5ZcnKcp10iZUF
         V+HrYC6/S3V5SWi+dY8KKpaXbXvapdymQDM1OwOjpJ6q9s2YZMMFvREjVoI6WHeRwzCE
         pYCGFBi0z9zbT+zzXg8I2tao11sh0IU8Pc+i41j4XToIS+4kyWTryq40mnaygGrIYsLs
         1eMsrvYp3GK8JEPUdqge+9pGtBRl7JPzQFOJ8Is11TDoPp08qX6lqBHsh4jpW22KCcgV
         H51g==
X-Gm-Message-State: AOJu0Yzk7xIlm7rWcf4b3uBbZTqLryboudg9DPMBGxPsCZ8BuGbNPRVp
	D8Nqz4mw/jQl0+XLE6guNi/Fqekr8HugHQJ1MB2PlkEUUbpz/xA7VmSGsFLTNR6GVftcdrQHUMi
	B8ebMjFYnrIpERzhQOjsF2b6YD2JFDjOjJeOqxRcFZ6Yuy0vOp1GtoKZftXu/K/C/
X-Gm-Gg: ASbGncvy3u4HkwCgpF5xBQ3I6SBa25x5q00CfJLK9sazvSALmNX6tNTiu6mI6sJHkit
	FtP0lS2378djxJ+5/2bSrUPKHz6QVQNYvbmtkoV7h2aYMdQ2bxpbForByh7rOby86KDImutFB6v
	fllWnEQ0ZPUWU/vOwK5Ugn4edqCYVDFyASXpw0u18hHWVkcsVmYYU5mOG9uP0TnYIPnt6fiej/X
	U4ybu4X+O2t4IVQ3WFsfSzTI+i6aoR/fpaDyE1LGnXz1dms6dwJ54q6AcWFa5PI6hN/I8IA+GK1
	7K4XLVBU
X-Received: by 2002:a05:600c:4511:b0:434:9fac:b157 with SMTP id 5b1f17b1804b1-434fff3de64mr1791045e9.13.1733745125897;
        Mon, 09 Dec 2024 03:52:05 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF782C5lClyEB8l63P5SOhwTnc8lqniPmPy6ramG0umEAdEdY2btSYCOdTMojVMJnIZOAg22Q==
X-Received: by 2002:a05:600c:4511:b0:434:9fac:b157 with SMTP id 5b1f17b1804b1-434fff3de64mr1790775e9.13.1733745125555;
        Mon, 09 Dec 2024 03:52:05 -0800 (PST)
Received: from eisenberg.redhat.com (nat-pool-muc-u.redhat.com. [149.14.88.27])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-434f9da4cd0sm29803105e9.26.2024.12.09.03.52.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Dec 2024 03:52:05 -0800 (PST)
From: Philipp Stanner <pstanner@redhat.com>
To: Alvaro Karsz <alvaro.karsz@solid-run.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	Philipp Stanner <pstanner@redhat.com>,
	Stefano Garzarella <sgarzare@redhat.com>
Cc: virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] vdpa: solidrun: Replace deprecated PCI functions
Date: Mon,  9 Dec 2024 12:51:18 +0100
Message-ID: <20241209115118.125940-2-pstanner@redhat.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: Yxo7rgDrdCDW5GaVk96sjjSxhw4y4VZen4yBGquOxKk_1733745126
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

The PCI functions

	pcim_iomap_regions()
	pcim_iounmap_regions()
	pcim_iomap_table()

have been deprecated by the PCI subsystem.

Replace these functions with their successors pcim_iomap_region() and
pcim_iounmap_region().

Signed-off-by: Philipp Stanner <pstanner@redhat.com>
---
Changes in v2:
  - Fix build warning because of dead variable.
  - Make "bars_found" a boolean, since only true or false are relevant.
---
 drivers/vdpa/solidrun/snet_main.c | 55 ++++++++++++++-----------------
 1 file changed, 25 insertions(+), 30 deletions(-)

diff --git a/drivers/vdpa/solidrun/snet_main.c b/drivers/vdpa/solidrun/snet_main.c
index c8b74980dbd1..1b9841698a1a 100644
--- a/drivers/vdpa/solidrun/snet_main.c
+++ b/drivers/vdpa/solidrun/snet_main.c
@@ -556,59 +556,57 @@ static const struct vdpa_config_ops snet_config_ops = {
 static int psnet_open_pf_bar(struct pci_dev *pdev, struct psnet *psnet)
 {
 	char *name;
-	int ret, i, mask = 0;
+	unsigned short i;
+	bool bars_found = false;
+	void __iomem *io;
+
+	name = devm_kasprintf(&pdev->dev, GFP_KERNEL, "psnet[%s]-bars", pci_name(pdev));
+	if (!name)
+		return -ENOMEM;
+
 	/* We don't know which BAR will be used to communicate..
 	 * We will map every bar with len > 0.
 	 *
 	 * Later, we will discover the BAR and unmap all other BARs.
 	 */
 	for (i = 0; i < PCI_STD_NUM_BARS; i++) {
-		if (pci_resource_len(pdev, i))
-			mask |= (1 << i);
+		if (pci_resource_len(pdev, i) == 0)
+			continue;
+
+		io = pcim_iomap_region(pdev, i, name);
+		if (IS_ERR(io)) {
+			SNET_ERR(pdev, "Failed to request and map PCI BARs\n");
+			return PTR_ERR(io);
+		}
+
+		psnet->bars[i] = io;
+		bars_found = true;
 	}
 
 	/* No BAR can be used.. */
-	if (!mask) {
+	if (!bars_found) {
 		SNET_ERR(pdev, "Failed to find a PCI BAR\n");
 		return -ENODEV;
 	}
 
-	name = devm_kasprintf(&pdev->dev, GFP_KERNEL, "psnet[%s]-bars", pci_name(pdev));
-	if (!name)
-		return -ENOMEM;
-
-	ret = pcim_iomap_regions(pdev, mask, name);
-	if (ret) {
-		SNET_ERR(pdev, "Failed to request and map PCI BARs\n");
-		return ret;
-	}
-
-	for (i = 0; i < PCI_STD_NUM_BARS; i++) {
-		if (mask & (1 << i))
-			psnet->bars[i] = pcim_iomap_table(pdev)[i];
-	}
-
 	return 0;
 }
 
 static int snet_open_vf_bar(struct pci_dev *pdev, struct snet *snet)
 {
 	char *name;
-	int ret;
 
 	name = devm_kasprintf(&pdev->dev, GFP_KERNEL, "snet[%s]-bars", pci_name(pdev));
 	if (!name)
 		return -ENOMEM;
 
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
 
@@ -656,15 +654,12 @@ static int psnet_detect_bar(struct psnet *psnet, u32 off)
 
 static void psnet_unmap_unused_bars(struct pci_dev *pdev, struct psnet *psnet)
 {
-	int i, mask = 0;
+	unsigned short i;
 
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
2.47.1

