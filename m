Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4DF7CC5479D
	for <virtualization@archiver.kernel.org>; Mon,  9 Jan 2023 08:05:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id E4D6440AB9;
	Mon,  9 Jan 2023 08:05:30 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org E4D6440AB9
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=solid-run-com.20210112.gappssmtp.com header.i=@solid-run-com.20210112.gappssmtp.com header.a=rsa-sha256 header.s=20210112 header.b=aQDUM7y3
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id PR-y0aO9SZji; Mon,  9 Jan 2023 08:05:29 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 3494940925;
	Mon,  9 Jan 2023 08:05:29 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 3494940925
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 1BCD1C0032;
	Mon,  9 Jan 2023 08:05:29 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 38454C002D
 for <virtualization@lists.linux-foundation.org>;
 Mon,  9 Jan 2023 08:05:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 137BC60C29
 for <virtualization@lists.linux-foundation.org>;
 Mon,  9 Jan 2023 08:05:27 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 137BC60C29
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=solid-run-com.20210112.gappssmtp.com
 header.i=@solid-run-com.20210112.gappssmtp.com header.a=rsa-sha256
 header.s=20210112 header.b=aQDUM7y3
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id L0EW4lgZmXIl
 for <virtualization@lists.linux-foundation.org>;
 Mon,  9 Jan 2023 08:05:26 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 4ED0760AA7
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com
 [IPv6:2a00:1450:4864:20::42f])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 4ED0760AA7
 for <virtualization@lists.linux-foundation.org>;
 Mon,  9 Jan 2023 08:05:26 +0000 (UTC)
Received: by mail-wr1-x42f.google.com with SMTP id co23so7286989wrb.4
 for <virtualization@lists.linux-foundation.org>;
 Mon, 09 Jan 2023 00:05:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=solid-run-com.20210112.gappssmtp.com; s=20210112;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=cGPSxy7QLFpAMcyajFwTiQmrNr019Rt19d70cLX622A=;
 b=aQDUM7y3VoRimkBLQS+6D4F4ZZhqgi2OHhGkLKLLZZflWAvld4qDM8kamEtpgCSm+s
 kfRG4gKuhq5PN3Zb6sTqxkGm8p1bACjLaCXcvp6il7e0HmQ9qyFrxUiiUm3Mw0PZjjrd
 PycwgBeOSBwmiL7Zb00HJWwmL8gNJrxHAAsJBKhHsgIK7dtmusVH3FnDDGCeLIYJwR3h
 AkslaDFQR7WhZIbyYx0hKZl0eqdmQqFM2T68Hke8sEBBGha7gTx/wzc/5NBs/fTppEWH
 y7tHNKsbpZ8RCfGkHfMjUN0L+uDN0ok7Bg03U9AWO9aGUXIW5tgB21cTH5shLg4ZieeJ
 hQYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=cGPSxy7QLFpAMcyajFwTiQmrNr019Rt19d70cLX622A=;
 b=JdW2k0mLYrXEpv6ZiCIybAwNYFNLIWuotWLKqDy/NQza7QPAKpIg5/AV4N6De2ErFj
 j9rupQKqm0wnG+FCchl+nnPxHQj3mXJ7zrtw5eVVV/1dcCuq8Djc3hYEUaA4EFKVasl6
 lKee0/svQr13siN4mClDy9ATFXahGM6G6dCbRiIkDUI0bFwHUY/JzsnY9jm7plTKTcyl
 2X5cG26QaxzDwdinLXTDoWlmBSUhsRQiy5KX9G++BnueFI7OeMgZy7z7/rZc2b+TMSTp
 RrjuK5Ha6O2btSKtLx+J2YaUwuAcXk8mkaTLqvVrkCThSDQ6hhz0V7ScWNCBK0Neb8aG
 o3uQ==
X-Gm-Message-State: AFqh2krD49pSC8/F6eF24MTgE7SLyqdHfwofG54XChlj2H00EJNpd6nc
 3HOOIDDAKj0x9rRf62PtSBOV4+AucCufder2
X-Google-Smtp-Source: AMrXdXv4NWKNzfM/eWUIfTwSf/GRmZt7LJRTM3llNMRyanTQj8SZn+0wFN15+7Gl2nyIn11zdd/3Ow==
X-Received: by 2002:a5d:4bc1:0:b0:2bb:7a1a:aeba with SMTP id
 l1-20020a5d4bc1000000b002bb7a1aaebamr4488868wrt.49.1673251523748; 
 Mon, 09 Jan 2023 00:05:23 -0800 (PST)
Received: from localhost.localdomain
 (bzq-84-110-153-254.static-ip.bezeqint.net. [84.110.153.254])
 by smtp.gmail.com with ESMTPSA id
 i2-20020adfdec2000000b002b9b9445149sm9191153wrn.54.2023.01.09.00.05.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Jan 2023 00:05:23 -0800 (PST)
From: Alvaro Karsz <alvaro.karsz@solid-run.com>
To: virtualization@lists.linux-foundation.org,
	linux-pci@vger.kernel.org
Subject: [PATCH v8 2/3] PCI: Avoid FLR for SolidRun SNET DPU rev 1
Date: Mon,  9 Jan 2023 10:05:20 +0200
Message-Id: <20230109080520.1155220-1-alvaro.karsz@solid-run.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Cc: bhelgaas@google.com, mst@redhat.com
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

This patch fixes a FLR bug on the SNET DPU rev 1 by setting
the PCI_DEV_FLAGS_NO_FLR_RESET flag.

As there is a quirk to avoid FLR (quirk_no_flr), I added a new
quirk to check the rev ID before calling to quirk_no_flr.

Without this patch, a SNET DPU rev 1 may hang when FLR is applied.

Signed-off-by: Alvaro Karsz <alvaro.karsz@solid-run.com>
Acked-by: Bjorn Helgaas <bhelgaas@google.com>
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
