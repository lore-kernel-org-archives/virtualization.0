Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 888B0C4332F
	for <virtualization@archiver.kernel.org>; Wed, 21 Dec 2022 07:20:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 0C8D1404B5;
	Wed, 21 Dec 2022 07:20:21 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 0C8D1404B5
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=solid-run-com.20210112.gappssmtp.com header.i=@solid-run-com.20210112.gappssmtp.com header.a=rsa-sha256 header.s=20210112 header.b=H22YS81J
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id J8ZnnQQ0wO9K; Wed, 21 Dec 2022 07:20:20 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id AAFF540476;
	Wed, 21 Dec 2022 07:20:19 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org AAFF540476
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 2CB1FC0071;
	Wed, 21 Dec 2022 07:20:18 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 69C0AC0070
 for <virtualization@lists.linux-foundation.org>;
 Wed, 21 Dec 2022 07:20:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 3AEC481E64
 for <virtualization@lists.linux-foundation.org>;
 Wed, 21 Dec 2022 07:20:11 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 3AEC481E64
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=solid-run-com.20210112.gappssmtp.com
 header.i=@solid-run-com.20210112.gappssmtp.com header.a=rsa-sha256
 header.s=20210112 header.b=H22YS81J
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 2QauIqtsLa3P
 for <virtualization@lists.linux-foundation.org>;
 Wed, 21 Dec 2022 07:20:10 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 6779481E57
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com
 [IPv6:2a00:1450:4864:20::32e])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 6779481E57
 for <virtualization@lists.linux-foundation.org>;
 Wed, 21 Dec 2022 07:20:10 +0000 (UTC)
Received: by mail-wm1-x32e.google.com with SMTP id
 r126-20020a1c4484000000b003d6b8e8e07fso642170wma.0
 for <virtualization@lists.linux-foundation.org>;
 Tue, 20 Dec 2022 23:20:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=solid-run-com.20210112.gappssmtp.com; s=20210112;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=RzSL91GeQVkxbiqrXzSQnMt7MADMKaP5uwMVsKmNkYI=;
 b=H22YS81JBkO+my2tm6b2nsfJJscY4GTGZ5Ji8rVlA2qt1uUYoXQYk+v3FB8TGgD84v
 h3RMG7U/igB0S/oB2MWileAvBV3kSfPIeeR4GBgyp99Eo57HMcPOPnBTksgEiLon7cNJ
 NKO8TYzjf6VMKkFhYwAFTrZeqJfIVG2y0gjjX2Ceej3vzfeDX9pbUUIv7bQjRjQz9Bgk
 coXcVvNg96+qKEGXstjvNAMgUnzjRGAZqzKbEmZMxb2ruL8dD7hqeAM9ka887MzhY0ZY
 +F90KsqTWYWGek1S35lDlqwLaaI1t6JJeLp6XhLgIQt+0hIeOmRHeT06kT0BNQTnGGRO
 I8Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=RzSL91GeQVkxbiqrXzSQnMt7MADMKaP5uwMVsKmNkYI=;
 b=BZiPtc/rt57QIaE/t1B3pC2P1qSE2YPKcPgEsCBpGBGBeZMvCJ23wUs30HN7uIhZ0Q
 wz2ZfWLFuSarMtsXs10msFxr2HW2ljswPrQOoCLDvcRvw2w+VNgvQ7D6INqTMiv7ynrT
 lqbEIWurVrH473S+BpJZm/qhqkvPE+TJS2bPhn/mxu9POk+yVwo9+HWLurrp32GsP9DL
 KXHJRH69gCFaMMyrWZuMCZNyHyiPwRdn3oPDwtyryLyHohSMi5+0V4xWqlHx3cybtEWv
 kX++gPdH/6xmwr2QdkbRS1UzB3MxjebGNTQ9IicR7xZMxeZ8YtlcdKNqRgrc3HLMqvu2
 VAcA==
X-Gm-Message-State: AFqh2kqbOpqRMRkCDn7PYCHzx57+WY56s3DQOu6vWQSXffeRwZF+815o
 D++t9psu/LvDT248RQxo3j7I0zDx9cvczcIR
X-Google-Smtp-Source: AMrXdXu9pawOXrcU224owa4D3oLy8TZbcCKKxPNm/Rf0naE+3uD0FsS8kxEIEH36whvAmO4l+v08dQ==
X-Received: by 2002:a05:600c:1e11:b0:3d2:26e1:bd45 with SMTP id
 ay17-20020a05600c1e1100b003d226e1bd45mr964549wmb.29.1671607207833; 
 Tue, 20 Dec 2022 23:20:07 -0800 (PST)
Received: from localhost.localdomain
 (bzq-84-110-153-254.static-ip.bezeqint.net. [84.110.153.254])
 by smtp.gmail.com with ESMTPSA id
 p19-20020a1c5453000000b003d2157627a8sm1160927wmi.47.2022.12.20.23.20.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Dec 2022 23:20:07 -0800 (PST)
From: Alvaro Karsz <alvaro.karsz@solid-run.com>
To: virtualization@lists.linux-foundation.org
Subject: [PATCH] virtio: vdpa: fix snprintf size argument in snet_vdpa driver
Date: Wed, 21 Dec 2022 09:20:00 +0200
Message-Id: <20221221072003.551091-1-alvaro.karsz@solid-run.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Cc: mst@redhat.com, Tom Rix <trix@redhat.com>,
 Nick Desaulniers <ndesaulniers@google.com>,
 Nathan Chancellor <nathan@kernel.org>
X-BeenThere: virtualization@lists.linux-foundation.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: Linux virtualization <virtualization.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>, 
 <mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>, 
 <mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

The buffer size and the size passed to snprintf don't match, causing
clang warnings.

This patch increases a little bit the size of the buffer, and uses
sizeof() to get the buffer size.

This patch should be applied on top of the following patch:

virtio: vdpa: new SolidNET DPU driver,
by Alvaro Karsz alvaro.karsz@solid-run.com

Reported-by: Nathan Chancellor <nathan@kernel.org>
Signed-off-by: Alvaro Karsz <alvaro.karsz@solid-run.com>
---
 drivers/vdpa/solidrun/snet_main.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/vdpa/solidrun/snet_main.c b/drivers/vdpa/solidrun/snet_main.c
index d438a89b359..9ceacf96de0 100644
--- a/drivers/vdpa/solidrun/snet_main.c
+++ b/drivers/vdpa/solidrun/snet_main.c
@@ -540,7 +540,7 @@ static const struct vdpa_config_ops snet_config_ops = {
 
 static int psnet_open_pf_bar(struct pci_dev *pdev, struct psnet *psnet)
 {
-	char name[25];
+	char name[50];
 	int ret, i, mask = 0;
 	/* We don't know which BAR will be used to communicate..
 	 * We will map every bar with len > 0.
@@ -558,7 +558,7 @@ static int psnet_open_pf_bar(struct pci_dev *pdev, struct psnet *psnet)
 		return -ENODEV;
 	}
 
-	snprintf(name, SNET_NAME_SIZE, "psnet[%s]-bars", pci_name(pdev));
+	snprintf(name, sizeof(name), "psnet[%s]-bars", pci_name(pdev));
 	ret = pcim_iomap_regions(pdev, mask, name);
 	if (ret) {
 		SNET_ERR(pdev, "Failed to request and map PCI BARs\n");
@@ -575,10 +575,10 @@ static int psnet_open_pf_bar(struct pci_dev *pdev, struct psnet *psnet)
 
 static int snet_open_vf_bar(struct pci_dev *pdev, struct snet *snet)
 {
-	char name[20];
+	char name[50];
 	int ret;
 
-	snprintf(name, SNET_NAME_SIZE, "snet[%s]-bar", pci_name(pdev));
+	snprintf(name, sizeof(name), "snet[%s]-bar", pci_name(pdev));
 	/* Request and map BAR */
 	ret = pcim_iomap_regions(pdev, BIT(snet->psnet->cfg.vf_bar), name);
 	if (ret) {
-- 
2.32.0

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
