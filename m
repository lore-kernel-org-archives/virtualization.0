Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47EC81FA857
	for <virtualization@lists.linux.dev>; Mon,  2 Dec 2024 12:24:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733142279; cv=none; b=h3jVcycEenBbun3XO0FsMSV+c8YLzNR6W6G4QL4+DkjBTzkaobFoHHQqS3biGZoMipVk4dz1TWav9V4QDOmvGxFKQQAoX7xpjttxlrX1IdBwBGzhkRe/NZ805KhOEc09Hy0LTmXtN70pSEKZ5+0eChgAXP7c96DlZCzNHeUJWuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733142279; c=relaxed/simple;
	bh=vypkcfmqQSQvNnGSzTrTPtN8sTgc1btYj2S2DQlsl3Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:content-type; b=NuWmgbV79hJxppF/VVNSc3WUERBJF52Sgv2SVB0OXhbYG+R1Q8uw4BkRGAKVYQYJdftxRa5l7PnomuKqpcH47m0Y+6frd9V7i98UBIb9kZ38KMJ1s78NGpGMUu+xETkP1xwHb8lUEF9CUoPM/AKTt7GKjHIpxzCgtLELaj0se/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=C0Qrp4UI; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="C0Qrp4UI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733142276;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=//HEqIowSWTGQpyQRQeePRqHW275Z/0v15zKmzWbkGs=;
	b=C0Qrp4UIlBlKkAfh/fanlWMcp8sTIgjikBc7ebCJUvmw7AqnRNB3MQ/x7azwtVNld14CNZ
	P0jv2lAh03Z8rw4PKjV0V52D6jhYJv5chCf7O7wB6yHkJXFpi6/72LM0oBMcPwAWu7o9yw
	MX2nQTaic+3SQJWYr31HpJii1cZc3B4=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-595-UaitSRoOMjCQqG1n6ip7vw-1; Mon, 02 Dec 2024 07:24:35 -0500
X-MC-Unique: UaitSRoOMjCQqG1n6ip7vw-1
X-Mimecast-MFC-AGG-ID: UaitSRoOMjCQqG1n6ip7vw
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-385d7f6dff1so1994501f8f.3
        for <virtualization@lists.linux.dev>; Mon, 02 Dec 2024 04:24:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733142274; x=1733747074;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=//HEqIowSWTGQpyQRQeePRqHW275Z/0v15zKmzWbkGs=;
        b=S/02y5hteRqxOL9N+TUuFncGRhw8mKSUiuf7ZdinvZsn6vvnaRjhfIW2c49ZEEFM+n
         fLtLfZ5hoI9/QumaqdFalcHg+BiYkzJb0L8U4PCzagkL3RAlSi4QdqZOVrHK4QbTmpU4
         EvyGZdZYutr6LWw5FWvLfeHDMDaHPjwJtldfhMxb43CmDkQ0VlAOfJRakQfEQhf0ygw3
         ITep4ul/zXC4fjON3RvxOAuzk/NF52jI1StjosHRuwhW2OizJzDRMlT+g1ImxKCVvtvT
         fBer9HxNnqRM5Ifa6W1qJxouvvbkzbUsi8P2jzWcZNlNe/MdMpsEkwXF502iSw000nJU
         PM/Q==
X-Gm-Message-State: AOJu0YzI1d0M8ARJyM2wf7YXo8FgMKb819qAksLYhvcW67rZgrpYVQMh
	SyLmLBz/lFF0wmfAqyvoDihJAdFsHw5XJiGWIN3F/BIXJd/E32lTcq1AChFUDiXFqsPd43okB15
	QCbFQUZxRXQgSzhRpWfinjKm/4hnk2kvfHCOTiFNLm958w7v95rYRh0V93rs3EBJZ
X-Gm-Gg: ASbGncvSR8y/B63gVLz5s8nyEvRZNMP9gRmY74+OTCrZgXXAwJw+e84AmfPpAkl0awt
	snpqMdhHJGqG6z+1c6N1jrrPiFA0TPh59QoeWymUpkEJ8ElyGlEp80IBTOVjeBUHbXl/UTJ3mxU
	ecdqWtLDfpSxw/MdMcifCyrTe8QlYWaPzU9HBYfKRpan9a7ClY+T5FM+oXR/MQUr33AkcepLxL2
	37xMTYvYvVsuR0AEOjcLticTl/vKHajTLX5mXz3sOnWdD/5qoBKi1s1ajEeJp8=
X-Received: by 2002:a05:6000:4918:b0:385:e2d5:cded with SMTP id ffacd0b85a97d-385e2d5cf22mr8062672f8f.20.1733142273825;
        Mon, 02 Dec 2024 04:24:33 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEznjBSyloh5TVy1Rv4zaou6u8fNelvxW6jc6X0JnKSCA4c3wEpM0CSdoo/UUE4ySyQjSwJIA==
X-Received: by 2002:a05:6000:4918:b0:385:e2d5:cded with SMTP id ffacd0b85a97d-385e2d5cf22mr8062648f8f.20.1733142273472;
        Mon, 02 Dec 2024 04:24:33 -0800 (PST)
Received: from eisenberg.fritz.box ([2001:16b8:3d41:300:52e4:1c77:9288:7c4c])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5d0bb296379sm3744274a12.40.2024.12.02.04.24.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Dec 2024 04:24:33 -0800 (PST)
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
Subject: [PATCH] vdpa: solidrun: Replace deprecated PCI functions
Date: Mon,  2 Dec 2024 13:23:54 +0100
Message-ID: <20241202122353.9793-2-pstanner@redhat.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 4hIJXJRO58bt072Fk41_z0UL5AwlXsaxKMfg6_o9vwY_1733142274
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
 drivers/vdpa/solidrun/snet_main.c | 55 ++++++++++++++-----------------
 1 file changed, 25 insertions(+), 30 deletions(-)

diff --git a/drivers/vdpa/solidrun/snet_main.c b/drivers/vdpa/solidrun/snet_main.c
index c8b74980dbd1..679c1c7dabf5 100644
--- a/drivers/vdpa/solidrun/snet_main.c
+++ b/drivers/vdpa/solidrun/snet_main.c
@@ -556,59 +556,57 @@ static const struct vdpa_config_ops snet_config_ops = {
 static int psnet_open_pf_bar(struct pci_dev *pdev, struct psnet *psnet)
 {
 	char *name;
-	int ret, i, mask = 0;
+	int ret;
+	unsigned short i, bars_found = 0;
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
+		bars_found++;
 	}
 
 	/* No BAR can be used.. */
-	if (!mask) {
+	if (bars_found == 0) {
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
2.47.0

