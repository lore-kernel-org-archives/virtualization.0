Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9044CC10F1D
	for <virtualization@archiver.kernel.org>; Mon, 12 Dec 2022 14:25:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 2C24C60DF9;
	Mon, 12 Dec 2022 14:25:23 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 2C24C60DF9
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=solid-run-com.20210112.gappssmtp.com header.i=@solid-run-com.20210112.gappssmtp.com header.a=rsa-sha256 header.s=20210112 header.b=xjna6vof
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 1rnx3sppkoUp; Mon, 12 Dec 2022 14:25:22 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id B095B60D9D;
	Mon, 12 Dec 2022 14:25:21 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org B095B60D9D
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 9B811C0035;
	Mon, 12 Dec 2022 14:25:21 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 5514DC002D
 for <virtualization@lists.linux-foundation.org>;
 Mon, 12 Dec 2022 14:25:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 2F57540260
 for <virtualization@lists.linux-foundation.org>;
 Mon, 12 Dec 2022 14:25:20 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 2F57540260
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=solid-run-com.20210112.gappssmtp.com
 header.i=@solid-run-com.20210112.gappssmtp.com header.a=rsa-sha256
 header.s=20210112 header.b=xjna6vof
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 63wlx7i9aftT
 for <virtualization@lists.linux-foundation.org>;
 Mon, 12 Dec 2022 14:25:19 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 3B7D040246
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com
 [IPv6:2a00:1450:4864:20::329])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 3B7D040246
 for <virtualization@lists.linux-foundation.org>;
 Mon, 12 Dec 2022 14:25:19 +0000 (UTC)
Received: by mail-wm1-x329.google.com with SMTP id ja17so2619181wmb.3
 for <virtualization@lists.linux-foundation.org>;
 Mon, 12 Dec 2022 06:25:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=solid-run-com.20210112.gappssmtp.com; s=20210112;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=52hahNbuRY46XgQIVISXaE7JbKxYGWL9g99K9Ci+IBU=;
 b=xjna6vofYa36kDqm1KkQaqL6P7ic6GSEwQLiVUkL46IvkvCEQQIB9pCZGgtOVydMBF
 MbR+H12gasTuiTOlTWuj/Wb8F2gmE77a9yCFyjVrWXHccQZF/t7ZbEJ00uLlNSyxXc2p
 PGh+Ljh8QkuQIP1XqHo0d6gE8gdkMP0TR7tqdvu2pX7Xnh/2rwleOgybj3CoH1ZZ8XZ4
 N0JJR4DDvrp3dO4SxJS96Fr94Z1bkr+7+sneinQNGEOBuTwunSFkfaztSdYYTItaTaNj
 ycylFAHMG87FbbBerCACG0TjYaZUlOgnqd0OEkxKDG8v630n5bQuOuuBxBF06ILNtKnZ
 1vvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=52hahNbuRY46XgQIVISXaE7JbKxYGWL9g99K9Ci+IBU=;
 b=FDhU2huMRuXn2iIo2y0T8yN8grXptOi0crJhEXbcT12sBRanu8NsbBQ2vT821P8wMN
 PPFNC8CHh8X67yj4x2hKwjOwy0FDOeqwOPFVr9dbPanj1xXQx16JlyCgt7K69/RndOsk
 7enS9mx4V9+auEfGfgL+gTVfTw0y2vwTTOfOCnGUjLtoHOzPyGhb+26YqRQejabmYvX0
 5EumWZBHaYaICUaFzkeHsIvVi/n/IfvJekt6sy+3fjNVWp+EJJhEvtXjhNcYn0YvG96U
 t2CrezW+l76jKBPbMcU3x/y/zuNwuLf1Gq3/3gG8tg1AkfOFTqZ4XL2lzvnCEd+XJ+vV
 1/lw==
X-Gm-Message-State: ANoB5plj5/uBh3+DTH+6U1SbQWvHmzwpbF6QgM8llBrGN7UDQbMY5bFm
 CBc9e9JJNdxwz08sKDnOVmJJIEAC3tlvHHrQ
X-Google-Smtp-Source: AA0mqf7Rbz+fsLVVWtiJM5oVf640BJBhVAU/1ZqVtTRZzGtLSTgeTmDr2NvJNFQJH9JioRd4yw+gKQ==
X-Received: by 2002:a05:600c:a11:b0:3d2:2a74:3a90 with SMTP id
 z17-20020a05600c0a1100b003d22a743a90mr1746339wmp.22.1670855116751; 
 Mon, 12 Dec 2022 06:25:16 -0800 (PST)
Received: from localhost.localdomain
 (bzq-84-110-153-254.static-ip.bezeqint.net. [84.110.153.254])
 by smtp.gmail.com with ESMTPSA id
 c1-20020a05600c0a4100b003d1e3b1624dsm10662692wmq.2.2022.12.12.06.25.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 Dec 2022 06:25:16 -0800 (PST)
From: Alvaro Karsz <alvaro.karsz@solid-run.com>
To: virtualization@lists.linux-foundation.org
Subject: [PATCH 2/3] New PCI quirk for SolidRun SNET DPU.
Date: Mon, 12 Dec 2022 16:24:53 +0200
Message-Id: <20221212142454.3225177-3-alvaro.karsz@solid-run.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20221212142454.3225177-1-alvaro.karsz@solid-run.com>
References: <20221212142454.3225177-1-alvaro.karsz@solid-run.com>
MIME-Version: 1.0
Cc: linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>
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

The DPU advertises FLR, but it may cause the device to hang.
This only happens with revision 0x1.

Signed-off-by: Alvaro Karsz <alvaro.karsz@solid-run.com>
---
 drivers/pci/quirks.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index 285acc4aacc..809d03272c2 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -5343,6 +5343,14 @@ DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_AMD, 0x149c, quirk_no_flr);
 DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_INTEL, 0x1502, quirk_no_flr);
 DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_INTEL, 0x1503, quirk_no_flr);
 
+/* FLR may cause the SolidRun SNET DPU (rev 0x1) to hang */
+static void quirk_no_flr_snet(struct pci_dev *dev)
+{
+	if (dev->revision == 0x1)
+		quirk_no_flr(dev);
+}
+DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_SOLIDRUN, 0x1000, quirk_no_flr_snet);
+
 static void quirk_no_ext_tags(struct pci_dev *pdev)
 {
 	struct pci_host_bridge *bridge = pci_find_host_bridge(pdev->bus);
-- 
2.32.0

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
