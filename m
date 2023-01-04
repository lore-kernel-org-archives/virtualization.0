Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51F1BC46467
	for <virtualization@archiver.kernel.org>; Wed,  4 Jan 2023 08:43:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id B6C6540147;
	Wed,  4 Jan 2023 08:43:28 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org B6C6540147
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=solid-run-com.20210112.gappssmtp.com header.i=@solid-run-com.20210112.gappssmtp.com header.a=rsa-sha256 header.s=20210112 header.b=zD2tk5KY
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 3ZmKQ59U6pBV; Wed,  4 Jan 2023 08:43:27 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 09B8D400DC;
	Wed,  4 Jan 2023 08:43:27 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 09B8D400DC
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D9B47C0032;
	Wed,  4 Jan 2023 08:43:26 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 63FCAC002D
 for <virtualization@lists.linux-foundation.org>;
 Wed,  4 Jan 2023 08:43:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 3D499400F6
 for <virtualization@lists.linux-foundation.org>;
 Wed,  4 Jan 2023 08:43:26 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 3D499400F6
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id wcRjZpIz2bcl
 for <virtualization@lists.linux-foundation.org>;
 Wed,  4 Jan 2023 08:43:25 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 46256400DC
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com
 [IPv6:2a00:1450:4864:20::436])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 46256400DC
 for <virtualization@lists.linux-foundation.org>;
 Wed,  4 Jan 2023 08:43:25 +0000 (UTC)
Received: by mail-wr1-x436.google.com with SMTP id d17so12476896wrs.2
 for <virtualization@lists.linux-foundation.org>;
 Wed, 04 Jan 2023 00:43:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=solid-run-com.20210112.gappssmtp.com; s=20210112;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=NbUaUyK4DKiN/LpC1zIoNCyihOmH2oj+soivrwgnCFw=;
 b=zD2tk5KYVwqDd0XbyT9/dIPgu1n+ubbYN50TYIDXU6wtuc/7Nqcd5uHMm0dog4vZWs
 SwtYwVudA9Vq1wO3L8t5YwDA1XW6oGyERTtwKrAyJn6oGzbomMa5jpXCDNXMQacOpVks
 W6Z4HPwp7CNq8bXhGufEj+hoyNULWkWS9Wg1DBeEIxA6i6+ae2tAHLTB3a/UPjtnzzVs
 zxLhsOLLBL2sw9A/rlkhIbY4szxSYDEW/9+fypw9UVqCdfU0JxNH5vw5EeTt+GyKSzT7
 a1ls1O4y3v9paGX7vJaJSKR7fgGtX8ptwhEl2U8aqJVPRc7remEAbxZm4b+nIi3PIdcX
 kLWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=NbUaUyK4DKiN/LpC1zIoNCyihOmH2oj+soivrwgnCFw=;
 b=x0M1WGznq1cVR74XIgFb6TAkqqWtdUZZ3GONsrf06RgWvn890m2W9bkQVpyER9R57c
 BHV5hOKspDwgAZNYCwrSHCj11nAvVM2P8AJ9tBB6oWdPu6i7+FCatJkotYrwDPQESZ9X
 6qiixsb5SWmyxP7E4CzWY/OKg7CmS7euaSaFCajYvjK4uo8dp6JqccVJKZEpOqnlrx9o
 atpmLq+xInOFiVIRR+iWK0P4wsi8l57sMO4EPVHJLSsmUym+VkG2kMqPdy5d4quZIw6W
 BFy8mRCJWOD7Q1UM81uQvhvUxxKw6FiEfO88zwj1qVNp3FF3dZuBBKmlhR2IFf4X8DVn
 VPjQ==
X-Gm-Message-State: AFqh2kp0zwvQ6d1yAXosX5/JAkmzaKkSNqTF4MRgzSq5C5BZTwEgyb9F
 psj08Mcyg/02L2vVEQ9mgbmrXHlvaPJgB8C7
X-Google-Smtp-Source: AMrXdXvKI2KtgTMvsitFeIbf8S31N5ntyLmhr055G3WQ4mc6X6RxeEknD7F+5dP4wOj4/S3KEeQo1w==
X-Received: by 2002:adf:ecc8:0:b0:26a:5040:78f6 with SMTP id
 s8-20020adfecc8000000b0026a504078f6mr31955983wro.46.1672821802627; 
 Wed, 04 Jan 2023 00:43:22 -0800 (PST)
Received: from localhost.localdomain
 (bzq-84-110-153-254.static-ip.bezeqint.net. [84.110.153.254])
 by smtp.gmail.com with ESMTPSA id
 u13-20020a5d468d000000b00275970a85f4sm31176189wrq.74.2023.01.04.00.43.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Jan 2023 00:43:21 -0800 (PST)
From: Alvaro Karsz <alvaro.karsz@solid-run.com>
To: virtualization@lists.linux-foundation.org,
	linux-pci@vger.kernel.org
Subject: [PATCH v2 2/3] PCI: Avoid FLR for SolidRun SNET DPU rev 1
Date: Wed,  4 Jan 2023 10:43:19 +0200
Message-Id: <20230104084319.3424462-1-alvaro.karsz@solid-run.com>
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
--
v2:
	- Update patch subject to be more meaningful and similar to
	  previous quirks.
	- Update the commit log to describe better what the patch does.
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
