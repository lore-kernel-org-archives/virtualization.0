Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C5CD1D1302
	for <virtualization@lists.linux.dev>; Tue,  8 Oct 2024 13:49:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728395370; cv=none; b=Z592AnKsrydFVY0BDhs9c2+xFy/dTsrJVGaWc5l4JYEl26nHMlw8yPW5Jd32ldQuvUJPzWl+kx7MAzxOCU/8uA9qu8fRZ/nblBIj96HGV3anL81FB8egs83dlIj0a+axolDyaY49CiWgs7vChlK645AD2APSAutPyseL0vNDbcY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728395370; c=relaxed/simple;
	bh=C7myXz1PzgO5KntaMzSJdRvlacDd6/XrNcUeuxTsbuY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=iPVr1OXnrKzDPSzMpkgMYJuETdYXqUURtrJSYdRg1YKWLEwiTeyTt9WhPAdN3wpU3iR1SQWsY3/j5CF3QQPkIVFEfbv2PWE0c82ikd1QrA4Cl5KrAFwF+smr9LtREIdY9L8T2N8ZEroRJheCHA9Q9zVx8/hz0TbgRkV+VVppbZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HuzCgSAm; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HuzCgSAm"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1728395366;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=2rDSgv3l5eJFW/isc5zWXHEc/hfh9FE/9/H5LJ8JrEs=;
	b=HuzCgSAmyOUSB+2FxMG9zT/Q1JrSjXJTfOamXLlZbPeikOrdJVr6t5bO/e8oWFpISp4zzS
	hE5OEqgeuR61xH+b4n+lB7wSj4W0SAF/eM6S8TRKzdCmJij7OAppdiQL1Q+Bq5DCfeCJYN
	xn17hTaSP7VIAPc2Sjsgx0z8LE3xIxc=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-408-_VbDocgsMG60ibrKBp9xUQ-1; Tue, 08 Oct 2024 09:49:25 -0400
X-MC-Unique: _VbDocgsMG60ibrKBp9xUQ-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-42cb9e14ab6so46888445e9.3
        for <virtualization@lists.linux.dev>; Tue, 08 Oct 2024 06:49:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728395364; x=1729000164;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2rDSgv3l5eJFW/isc5zWXHEc/hfh9FE/9/H5LJ8JrEs=;
        b=DjFrxwYEjDchGOLZa7v7dvM93+P3f9RCvdcoCiCKD0cPKM4fRp44Jj+ncWTK3OftfH
         aPaajkBnX5G5OQPgE2cDlj67b3I5lj+z4lvbBWkBGNOhNqhUeGjo6HRRWqXuDNzsbMUd
         +9kNW+lkjLi5bOxB3G5UktqlSESNyGTUu4s+XyMxcTnqHVs1AJ58IurWcbvf4SptHnCk
         RcUTjCyrkWCfnpiWaQMorRXQfLJ76o6lrdBwqdkvk06HJvYwCC/zABqGkKo57pAwCeqc
         sq1oJXb+hNPoTmkIAatjXMJZjyXhCqIaxUPOf7XqtYSZ4iXxroPvAdUhsXq1NXK9yLUy
         t1lA==
X-Gm-Message-State: AOJu0YxfjO6sGPv2bDePfXH0p2fUQBvO4vrf32NiGHVM9G/Lh0P/TVkC
	1dEKc8iGned0vG31fKNLSTTVEt4KbykGOZidQN8gmRBeo5QUTUbMGpCYc8TCMl1UqwRR0bVvZmw
	oYjVN0RRU45G05Si4YQpD7AWW3s4OsqH0pNVocnOVFouTxzLhFrrZP/MYvUL85B1O
X-Received: by 2002:a05:600c:1ca4:b0:42c:b995:20d3 with SMTP id 5b1f17b1804b1-42f85ae9d41mr133159315e9.26.1728395364036;
        Tue, 08 Oct 2024 06:49:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEd8VsV5d3a42MkvhyaGQpxAWiPPuXxOfVyKhGcSzEVblc23t5A1J2pfaLTuLp+DD7aI+pjIA==
X-Received: by 2002:a05:600c:1ca4:b0:42c:b995:20d3 with SMTP id 5b1f17b1804b1-42f85ae9d41mr133159075e9.26.1728395363600;
        Tue, 08 Oct 2024 06:49:23 -0700 (PDT)
Received: from eisenberg.fritz.box (200116b82d43760013399881f4bcf5cb.dip.versatel-1u1.de. [2001:16b8:2d43:7600:1339:9881:f4bc:f5cb])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42f89ead666sm109780275e9.28.2024.10.08.06.49.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Oct 2024 06:49:22 -0700 (PDT)
From: Philipp Stanner <pstanner@redhat.com>
To: Alvaro Karsz <alvaro.karsz@solid-run.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	Philipp Stanner <pstanner@redhat.com>
Cc: virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	Andy Shevchenko <andy@kernel.org>
Subject: [PATCH] vdpa: solidrun: Fix UB bug with devres
Date: Tue,  8 Oct 2024 15:49:13 +0200
Message-ID: <20241008134912.30295-2-pstanner@redhat.com>
X-Mailer: git-send-email 2.46.1
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

In psnet_open_pf_bar() and snet_open_vf_bar() a string later passed to
pcim_iomap_regions() is placed on the stack. Neither
pcim_iomap_regions() nor the functions it calls copy that string.

Should the string later ever be used, this, consequently, causes
undefined behavior since the stack frame will by then have disappeared.

Fix the bug by allocating the strings on the heap through
devm_kasprintf().

Cc: stable@vger.kernel.org	# v6.3
Fixes: 51a8f9d7f587 ("virtio: vdpa: new SolidNET DPU driver.")
Reported-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Closes: https://lore.kernel.org/all/74e9109a-ac59-49e2-9b1d-d825c9c9f891@wanadoo.fr/
Suggested-by: Andy Shevchenko <andy@kernel.org>
Signed-off-by: Philipp Stanner <pstanner@redhat.com>
---
 drivers/vdpa/solidrun/snet_main.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/drivers/vdpa/solidrun/snet_main.c b/drivers/vdpa/solidrun/snet_main.c
index 99428a04068d..c8b74980dbd1 100644
--- a/drivers/vdpa/solidrun/snet_main.c
+++ b/drivers/vdpa/solidrun/snet_main.c
@@ -555,7 +555,7 @@ static const struct vdpa_config_ops snet_config_ops = {
 
 static int psnet_open_pf_bar(struct pci_dev *pdev, struct psnet *psnet)
 {
-	char name[50];
+	char *name;
 	int ret, i, mask = 0;
 	/* We don't know which BAR will be used to communicate..
 	 * We will map every bar with len > 0.
@@ -573,7 +573,10 @@ static int psnet_open_pf_bar(struct pci_dev *pdev, struct psnet *psnet)
 		return -ENODEV;
 	}
 
-	snprintf(name, sizeof(name), "psnet[%s]-bars", pci_name(pdev));
+	name = devm_kasprintf(&pdev->dev, GFP_KERNEL, "psnet[%s]-bars", pci_name(pdev));
+	if (!name)
+		return -ENOMEM;
+
 	ret = pcim_iomap_regions(pdev, mask, name);
 	if (ret) {
 		SNET_ERR(pdev, "Failed to request and map PCI BARs\n");
@@ -590,10 +593,13 @@ static int psnet_open_pf_bar(struct pci_dev *pdev, struct psnet *psnet)
 
 static int snet_open_vf_bar(struct pci_dev *pdev, struct snet *snet)
 {
-	char name[50];
+	char *name;
 	int ret;
 
-	snprintf(name, sizeof(name), "snet[%s]-bar", pci_name(pdev));
+	name = devm_kasprintf(&pdev->dev, GFP_KERNEL, "snet[%s]-bars", pci_name(pdev));
+	if (!name)
+		return -ENOMEM;
+
 	/* Request and map BAR */
 	ret = pcim_iomap_regions(pdev, BIT(snet->psnet->cfg.vf_bar), name);
 	if (ret) {
-- 
2.46.1

