Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 772B61B395B
	for <virtualization@lists.linux.dev>; Wed, 16 Oct 2024 07:26:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729063584; cv=none; b=mJRdhatmkP/JMX36y0SxgNuPQfB/5CwTQAtOvwTW+I70AIB9aFNapUDwlF5tqbUQq/Cr5rLFAZ3uot+EuLTI2lujBJoVm/pegEJ88P9X65SHBeuuuNpfR3dnL3upWf73etA5wWoQyI9WV5xpTluyUhYUU1dxyz2Qz4ygJFtGDs0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729063584; c=relaxed/simple;
	bh=C7myXz1PzgO5KntaMzSJdRvlacDd6/XrNcUeuxTsbuY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Htt5gIQB3mZrE4FDu7DGdhnc3N4XACYhIfjh2pP6+BKSKaRMwNeSyoxGYz8LpM6XaYBYMdmnHqPYMRt+BqDiGzM5RdZ7vnVUnnGsiGwUurUZUMFf0ExPBUGGOUTWsQ5EGyfrMtpyNsuuISUqRIqdVcI+U094GWbzWUXoh8QZy8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LW1KLnIe; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LW1KLnIe"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1729063581;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=2rDSgv3l5eJFW/isc5zWXHEc/hfh9FE/9/H5LJ8JrEs=;
	b=LW1KLnIeuYJmmFx8l19QzVS1CUitPv0GoYJUbYNKess3BMvXMXCvis0mvwAxcYHzjhV/RW
	QIFkurSN48SOiMZT2ZOAbhJjwr4MVWSkGhVAgKwyiF4/PTRPkK62FXid5lJhsYW5utdLI1
	LQrszBoQPPBX22zX/rk8CClhZ8PJ5ZY=
Received: from mail-yb1-f199.google.com (mail-yb1-f199.google.com
 [209.85.219.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-203-5j3hp1c2Ox-XGd9-w0y7fQ-1; Wed, 16 Oct 2024 03:26:20 -0400
X-MC-Unique: 5j3hp1c2Ox-XGd9-w0y7fQ-1
Received: by mail-yb1-f199.google.com with SMTP id 3f1490d57ef6-e2971589916so2404048276.3
        for <virtualization@lists.linux.dev>; Wed, 16 Oct 2024 00:26:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729063580; x=1729668380;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2rDSgv3l5eJFW/isc5zWXHEc/hfh9FE/9/H5LJ8JrEs=;
        b=VJ9tUsfXrSjCX6tkyv/962ywoCBq4pCCeBUfjRHyi4BHKISbsU5QZG6EUhpkf7azjV
         ru7bXFAGmdrIFcCOQLJY01IQaTAxtomc9bE24MwZZWi/e3kgJeMX3xj0k1c73/vFT88s
         o/woDHroua8TmiQohjavEehaxM8IGc7ydiKI250C1+ewErzylxXYIhXoD5yeF8p4WxF9
         OXWstMWva64ii8bP6hQlahulZXlaSBid5ycqPTcOLajDPyuvVQvpayRlBqAtd65zC0Db
         2mbBsvz2mlKbXFnilGJVzB3QE4dp5ME3TccIrtPOQmFpEz27bufHxKvlJacfz/6eOxYG
         KZSw==
X-Gm-Message-State: AOJu0Ywux7u5+GCzfGODK/3SDBAG4Fgi6cEfYO9sGk1c5OFq55WE85FC
	M/awscUYGK7F6NSHKQaO7Qt318Fr6xavxawql23hYu9hSWklWCpIUBLUDHB2ZrqS2Fcy/vuIOzi
	VL9oanr8edtj8pYGGegwK7+VYzdOS1qRY20XVZ8wPMIHlQQXqXImUOteRD7LaBWaj
X-Received: by 2002:a05:6902:2b92:b0:e25:fc6f:9cbf with SMTP id 3f1490d57ef6-e2919ffb24amr15378996276.52.1729063579897;
        Wed, 16 Oct 2024 00:26:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH0VnLtU01GEdrbqIU14wiCEwVYdDzFIuoPMbbYPcqCMCItsvNSf8e9UkD6khJT6N2aapdCgQ==
X-Received: by 2002:a05:6902:2b92:b0:e25:fc6f:9cbf with SMTP id 3f1490d57ef6-e2919ffb24amr15378990276.52.1729063579574;
        Wed, 16 Oct 2024 00:26:19 -0700 (PDT)
Received: from eisenberg.muc.redhat.com (nat-pool-muc-t.redhat.com. [149.14.88.26])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6cc22910f0bsm14645746d6.16.2024.10.16.00.26.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Oct 2024 00:26:19 -0700 (PDT)
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
Subject: [PATCH RESEND] vdpa: solidrun: Fix UB bug with devres
Date: Wed, 16 Oct 2024 09:25:54 +0200
Message-ID: <20241016072553.8891-2-pstanner@redhat.com>
X-Mailer: git-send-email 2.47.0
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

