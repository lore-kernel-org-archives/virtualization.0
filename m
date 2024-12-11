Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C792205E06
	for <virtualization@lists.linux.dev>; Wed, 11 Dec 2024 10:48:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733914110; cv=none; b=TCkaQvf0/q2l6DEDF6p6WPKqjOpdSvNlD7xxCPuFIDBEvCDH/jVreCCeU7wb5ZGdVx6VzWCx0LmsusVUBzdWnsWBgmbHTrLpRYwifcx3091f6XQDpcS1fO0+lu6SOC5nx7QyZowzQ328QTQ5cenrlbi50hdNhICoDTOeqEi3NI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733914110; c=relaxed/simple;
	bh=egu/qf9ZXozSwLFwNngQ4Tg9AIPyu1rjBBdpZhbEih0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:content-type; b=SN6w/jTvbeO9Dkv7ZF19D73iJSz8+ppqyGAYxclClT27k5kJmUGW1FH+f2hNyl+dggDLIBFbZM55RmRN0Vee2NWznYJtyGJ+uopbW00lKjMybRA0YNfbjlfxNy57NvypCy7V++MxDbYf18ZHHrooSaRMdUULWoAN7ao88GwX+4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=c0Pit2mP; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="c0Pit2mP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733914106;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=MXVy+NvGEa+lmV97Ho50kUKoiqwvV53RUh8hJ9LNZo8=;
	b=c0Pit2mPXUdTv821SNBtV/Ntshi3UbZag/hSgxrW6fnESNFjLEaHjayDp4QWMWBHDpcpty
	XDGMwMO8dy7fz8GPseOHg666GNwEgVCaZHPqO4OxIdfUR0fhDjlhmUEx6mgxgFgydG4Xoz
	kSDQ03UpzDjk7tl5ho1p15gLefHIXcs=
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com
 [209.85.210.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-581-umo1IE50NsmtdC63BlNlbw-1; Wed, 11 Dec 2024 05:48:25 -0500
X-MC-Unique: umo1IE50NsmtdC63BlNlbw-1
X-Mimecast-MFC-AGG-ID: umo1IE50NsmtdC63BlNlbw
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-725e81ccf17so3067209b3a.0
        for <virtualization@lists.linux.dev>; Wed, 11 Dec 2024 02:48:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733914104; x=1734518904;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MXVy+NvGEa+lmV97Ho50kUKoiqwvV53RUh8hJ9LNZo8=;
        b=AOeZIKtWDFkwNY1R2lNCT8R+CzQMAFZ594wVLvpI0pWby9jtjyrgKzCMS6CoZ+luF3
         xod28TCfY1ipsVoB7ZAJilTH9y5QBCbgucBjOZDYoDq8PAcnNmQHKSG0QUc/neG0tev4
         GbBV1nTkYd2arl65+sCbIGqR+ZTsnyWoB/mp/JKSDIwrhqOjyuP12hMOzpYkOjR+g5rj
         +fKEgckish2+2v/CabOh6xdokdXB1m9pIjdW5TabOOO6tPh5/VOzWMEpzvxCNpFwoYJx
         8Zhzraib94TTaDmHZRDKrH2yKKRCmFJfoYvG/vt6DeMcJ/RiBGe0erPCeyMOkYQZ1mGH
         /VJA==
X-Gm-Message-State: AOJu0YwbAtTzYNg/wxZh3VaQq+9axfMrYmCwno77ZxbdGKN9zIej5asc
	U6j8Blhpt+T98NSCaT87E8Vz8BIvmnPpfMDPtWG8JMSRInOEMRnXym8KwR38qAInAGmXUMjqkhI
	o1HTaF7SPjrjEgRyeoc4fx8I/GyPiifVEUsX1CnEz5s+12l/MMEk6AIV33afOgw2J
X-Gm-Gg: ASbGncsCnAlsdvliJXQeEJ80MayZOLblrnhFUsqY4Q6+nSgOg4RQuPcqN47RyAEJZxj
	1QCsUpmWCiiQQnyOOFd41rOJNvf4/+LmKda2HkJPd0Q9u1OfFzwzjc8aleK/6rSm8yRFoWKue49
	sfonkuAFo1uiRqz/hPAuPIV80nkWGxu6TRC/JLQgBQhBGvOToBFlL316Cds6OnNYvBg7+b3NU6q
	WLRladkrFKPYxzWDH9iqGfso0+z2GV+yLOeO+XnOQMMIJt/jM1ILLrhjoqb7WLXOkhMtgJdbJFt
	TYDLG+qZkyTI
X-Received: by 2002:a05:6a21:6da6:b0:1e1:b60c:5bdb with SMTP id adf61e73a8af0-1e1c1368111mr4232613637.26.1733914104158;
        Wed, 11 Dec 2024 02:48:24 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFKt022fmtoA9CLjQqNxiTi/5lRfTovEKjrPW8kGQgFEpLpzAI2XERexj2+dToCXSlaFgduIA==
X-Received: by 2002:a05:6a21:6da6:b0:1e1:b60c:5bdb with SMTP id adf61e73a8af0-1e1c1368111mr4232587637.26.1733914103787;
        Wed, 11 Dec 2024 02:48:23 -0800 (PST)
Received: from eisenberg.redhat.com (nat-pool-muc-u.redhat.com. [149.14.88.27])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7fd564f6703sm3229263a12.49.2024.12.11.02.48.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Dec 2024 02:48:23 -0800 (PST)
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
Subject: [PATCH v3] vdpa: solidrun: Replace deprecated PCI functions
Date: Wed, 11 Dec 2024 11:47:05 +0100
Message-ID: <20241211104704.208354-2-pstanner@redhat.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 0NeBE5lv_Cc3NomzuZjE1wYs5HXsK1zQuVfYxw5LHqI_1733914104
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
Changes in v3:
  - Move __iomem *io declaration into the loop. (Stefano)

Changes in v2:
  - Fix build warning because of dead variable.
  - Make "bars_found" a boolean, since only true or false are relevant.
---
 drivers/vdpa/solidrun/snet_main.c | 56 ++++++++++++++-----------------
 1 file changed, 26 insertions(+), 30 deletions(-)

diff --git a/drivers/vdpa/solidrun/snet_main.c b/drivers/vdpa/solidrun/snet_main.c
index c8b74980dbd1..643e335f00f1 100644
--- a/drivers/vdpa/solidrun/snet_main.c
+++ b/drivers/vdpa/solidrun/snet_main.c
@@ -556,59 +556,58 @@ static const struct vdpa_config_ops snet_config_ops = {
 static int psnet_open_pf_bar(struct pci_dev *pdev, struct psnet *psnet)
 {
 	char *name;
-	int ret, i, mask = 0;
+	unsigned short i;
+	bool bars_found = false;
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
+		void __iomem *io;
+
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
 
@@ -656,15 +655,12 @@ static int psnet_detect_bar(struct psnet *psnet, u32 off)
 
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

