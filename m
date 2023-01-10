Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B4AAC54EBE
	for <virtualization@archiver.kernel.org>; Tue, 10 Jan 2023 16:57:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id A04266103E;
	Tue, 10 Jan 2023 16:57:03 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org A04266103E
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=solid-run-com.20210112.gappssmtp.com header.i=@solid-run-com.20210112.gappssmtp.com header.a=rsa-sha256 header.s=20210112 header.b=pgfxQPhM
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id TV2YxkuVULYy; Tue, 10 Jan 2023 16:57:02 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 3DA006103A;
	Tue, 10 Jan 2023 16:57:02 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 3DA006103A
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 0CBE0C0082;
	Tue, 10 Jan 2023 16:57:01 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id F29D6C002D
 for <virtualization@lists.linux-foundation.org>;
 Tue, 10 Jan 2023 16:56:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id CE24961029
 for <virtualization@lists.linux-foundation.org>;
 Tue, 10 Jan 2023 16:56:59 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org CE24961029
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Y65Stzculc7x
 for <virtualization@lists.linux-foundation.org>;
 Tue, 10 Jan 2023 16:56:59 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 0A6B360AEA
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com
 [IPv6:2a00:1450:4864:20::42b])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 0A6B360AEA
 for <virtualization@lists.linux-foundation.org>;
 Tue, 10 Jan 2023 16:56:58 +0000 (UTC)
Received: by mail-wr1-x42b.google.com with SMTP id co23so12473499wrb.4
 for <virtualization@lists.linux-foundation.org>;
 Tue, 10 Jan 2023 08:56:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=solid-run-com.20210112.gappssmtp.com; s=20210112;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2NOZUXey1qu1DXnDXCB3ax9qkfzwnIbFIlklzJ8G9G0=;
 b=pgfxQPhMkMsZ65vs7lXnIMK6H9EDoUjlucyTmQvsBs3zKpN1hGy19i72uLMus0rH5t
 ZDVRD6gjUG/Vi6IvdUV72+3M0js87j55xbvEFEO888B12k9SbW8UndIA1qQhYCPYv30/
 XawQv4lNdYdPjQtim8RBz2bKGOwBaDVQq6Yh0y1NzWTNTwkfVLNqUKrCvh2HR0jlJSob
 v14D+6CYR4Mxjd4itPFvxIFyUC7a6zaITdWgfaTzdwm2Izm94qX8I72Q3JzyArbhVEde
 jYm4E861NOkFeWidecEvymZwTVuig0SuccjjUjfqmIUZSeM/5tqL+GXvX6XSH7pHNoVK
 xfBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2NOZUXey1qu1DXnDXCB3ax9qkfzwnIbFIlklzJ8G9G0=;
 b=fUDrTF/wWtPMdbwzDPnaFgeTvO3QHv+3MxtOst8F0m7PRAT2rUDesWw6YfNh8BcEI3
 U0h5abvJtDuOSL244qwRXd2tzD5AcoeB66FIiwyl/PcYj/wG+M2+bmqO0l2D8lEKT6RE
 NWmSnrrhaUxefmnPmlMANTaOKC368NWIPTZgdrNK63Md/AG7qffXsv7reU/A1MLqn5Cs
 vfckWtzImeokbHlFQJPj340IrS7Ei8vaOC9GSpJdmCaeO8ftIZq5TitDcFOgnL2NLvd+
 0XPsoxLegns4MJIBusvdsU+bGtcZ7oxaz3JFARCL3cF8Zg6bcDAS+pFp68zNG4M6JVhu
 jfIA==
X-Gm-Message-State: AFqh2kryocyhb920TOJYfTqFWwh+0BGdYIJAu376kRyrRzPFywbAKOZp
 C9w4yPuLG0MMOF2VIrR+N/INNw==
X-Google-Smtp-Source: AMrXdXtEGQl0JOhK8lc5tXKJn3oaRaXcptGLzyKh48IRPbE+dHREc6xHFYg3ICRAIJ36/0T/f0YTkQ==
X-Received: by 2002:a05:6000:d0:b0:29a:555d:2436 with SMTP id
 q16-20020a05600000d000b0029a555d2436mr19454603wrx.31.1673369817200; 
 Tue, 10 Jan 2023 08:56:57 -0800 (PST)
Received: from localhost.localdomain
 (bzq-84-110-153-254.static-ip.bezeqint.net. [84.110.153.254])
 by smtp.gmail.com with ESMTPSA id
 q11-20020adf9dcb000000b00268aae5fb5bsm11918066wre.3.2023.01.10.08.56.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Jan 2023 08:56:56 -0800 (PST)
From: Alvaro Karsz <alvaro.karsz@solid-run.com>
To: linux-pci@vger.kernel.org,
	virtualization@lists.linux-foundation.org
Subject: [PATCH v9 2/3] PCI: Avoid FLR for SolidRun SNET DPU rev 1
Date: Tue, 10 Jan 2023 18:56:37 +0200
Message-Id: <20230110165638.123745-3-alvaro.karsz@solid-run.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20230110165638.123745-1-alvaro.karsz@solid-run.com>
References: <20230110165638.123745-1-alvaro.karsz@solid-run.com>
MIME-Version: 1.0
Cc: Bjorn Helgaas <bhelgaas@google.com>, helgaas@kernel.org, mst@redhat.com
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

This patch fixes a FLR bug on the SNET DPU rev 1 by setting the
PCI_DEV_FLAGS_NO_FLR_RESET flag.

As there is a quirk to avoid FLR (quirk_no_flr), I added a new quirk
to check the rev ID before calling to quirk_no_flr.

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
