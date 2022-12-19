Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 894A3C4332F
	for <virtualization@archiver.kernel.org>; Mon, 19 Dec 2022 08:35:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 18DDA403E7;
	Mon, 19 Dec 2022 08:35:32 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 18DDA403E7
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=solid-run-com.20210112.gappssmtp.com header.i=@solid-run-com.20210112.gappssmtp.com header.a=rsa-sha256 header.s=20210112 header.b=ZC2FKqer
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id nra41_j80MTs; Mon, 19 Dec 2022 08:35:31 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 8F83A400F8;
	Mon, 19 Dec 2022 08:35:30 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 8F83A400F8
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 5BC80C0032;
	Mon, 19 Dec 2022 08:35:30 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 2140BC002D
 for <virtualization@lists.linux-foundation.org>;
 Mon, 19 Dec 2022 08:35:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id CF1F1605BE
 for <virtualization@lists.linux-foundation.org>;
 Mon, 19 Dec 2022 08:35:28 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org CF1F1605BE
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=solid-run-com.20210112.gappssmtp.com
 header.i=@solid-run-com.20210112.gappssmtp.com header.a=rsa-sha256
 header.s=20210112 header.b=ZC2FKqer
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Sl5BYQdv_HpH
 for <virtualization@lists.linux-foundation.org>;
 Mon, 19 Dec 2022 08:35:26 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 9A2DD60AA7
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com
 [IPv6:2a00:1450:4864:20::332])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 9A2DD60AA7
 for <virtualization@lists.linux-foundation.org>;
 Mon, 19 Dec 2022 08:35:26 +0000 (UTC)
Received: by mail-wm1-x332.google.com with SMTP id
 bi26-20020a05600c3d9a00b003d3404a89faso4237866wmb.1
 for <virtualization@lists.linux-foundation.org>;
 Mon, 19 Dec 2022 00:35:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=solid-run-com.20210112.gappssmtp.com; s=20210112;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=52hahNbuRY46XgQIVISXaE7JbKxYGWL9g99K9Ci+IBU=;
 b=ZC2FKqerEx9qtzZe4J4ankTEh1eSrRfgETY+4/nQ0oIs8wjZB/j3Cl2rRu5mOQxl81
 2dQ0eldmSXHiDLFBg0ATvMwlUo1VVMG9Pr8Fzk9kMdZS0CB6U7jXFRKzxAMTulv7ZK5h
 8mkdyHWaHH4lzYBYsNAyGwOobpcicnii30ArLhIMP3Oejm4dg6HmzOrOIpuyU+dHGcEa
 9lDtew1A6vlKQxzEcwFShZPwLJ6V1ffzxkGhVuKLxVVb52Go7TL4qLNbNKqWIa5nynmW
 5PpzzvEEQaVxQnc8nFm/kxKJKdrixhWKfhrC5HmugUgKUXDm5ck10E97z004LUG7c8by
 VsLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=52hahNbuRY46XgQIVISXaE7JbKxYGWL9g99K9Ci+IBU=;
 b=Mx9ljvrgbg/ywPhm4guY2B2k+G/081oQ6lqMfz/dYNhtK3rUlb+Kxv0AJm0H2T0lQw
 Rq4xwGOQp9ZLXkeVKLuMWxCYn5GtCyBzxw+nDtgKt45Z46VIbgfJsW73gteEUClc3xZr
 qVEQPdD9C88wUBrH9UA+q888PJOVOpwBBDO0q3gTyAOi9F11tqGD16Z5Bd/A2hl92TUj
 BtOht8kvrGrYfoJ3cQp4p5UH7d0lUmjQg969uCLbcx78lqVJrKOM99+ks17qMLKlHNRS
 ML1sd3nKC4pxCG8my1u86PSqIcNil8Vh1QJ7ZEPvPSo+lOW47gWcXbwAAtFr6Czw9FCA
 /nqQ==
X-Gm-Message-State: ANoB5pmqrlH8ckCssvk3WSenfSr727XSKYQxSWZHXm+K+vhkDkbYYib9
 6EzaraudBWi3o91bCH1RWgY9NMuR4L3e50Cn
X-Google-Smtp-Source: AA0mqf7hYnzbIjb0nIp00iP7pAjJnjsCKyBOTShmIdjjr3HBawJcGzuQHqMBYyp4OiBpU8AkoGI4dw==
X-Received: by 2002:a05:600c:3b93:b0:3d2:3e75:7bb9 with SMTP id
 n19-20020a05600c3b9300b003d23e757bb9mr12920522wms.34.1671438923815; 
 Mon, 19 Dec 2022 00:35:23 -0800 (PST)
Received: from localhost.localdomain
 (bzq-84-110-153-254.static-ip.bezeqint.net. [84.110.153.254])
 by smtp.gmail.com with ESMTPSA id
 z22-20020a05600c0a1600b003cfd0bd8c0asm11364246wmp.30.2022.12.19.00.35.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 Dec 2022 00:35:23 -0800 (PST)
From: Alvaro Karsz <alvaro.karsz@solid-run.com>
To: virtualization@lists.linux-foundation.org,
	linux-pci@vger.kernel.org
Subject: [RESEND PATCH 2/3] New PCI quirk for SolidRun SNET DPU.
Date: Mon, 19 Dec 2022 10:35:10 +0200
Message-Id: <20221219083511.73205-3-alvaro.karsz@solid-run.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20221219083511.73205-1-alvaro.karsz@solid-run.com>
References: <20221219083511.73205-1-alvaro.karsz@solid-run.com>
MIME-Version: 1.0
Cc: bhelgaas@google.com
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
