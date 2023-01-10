Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9FC74C46467
	for <virtualization@archiver.kernel.org>; Tue, 10 Jan 2023 16:57:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 3E0C481F26;
	Tue, 10 Jan 2023 16:57:06 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 3E0C481F26
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=solid-run-com.20210112.gappssmtp.com header.i=@solid-run-com.20210112.gappssmtp.com header.a=rsa-sha256 header.s=20210112 header.b=YeJaEvkx
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id JcNL1S1lykpM; Tue, 10 Jan 2023 16:57:02 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id A82BD81F0D;
	Tue, 10 Jan 2023 16:57:01 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org A82BD81F0D
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C353BC007E;
	Tue, 10 Jan 2023 16:57:00 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 61263C002D
 for <virtualization@lists.linux-foundation.org>;
 Tue, 10 Jan 2023 16:56:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 2EE6B40B65
 for <virtualization@lists.linux-foundation.org>;
 Tue, 10 Jan 2023 16:56:59 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 2EE6B40B65
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=solid-run-com.20210112.gappssmtp.com
 header.i=@solid-run-com.20210112.gappssmtp.com header.a=rsa-sha256
 header.s=20210112 header.b=YeJaEvkx
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ZcOadNcWkDeZ
 for <virtualization@lists.linux-foundation.org>;
 Tue, 10 Jan 2023 16:56:57 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org F1BA9400EF
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com
 [IPv6:2a00:1450:4864:20::42b])
 by smtp2.osuosl.org (Postfix) with ESMTPS id F1BA9400EF
 for <virtualization@lists.linux-foundation.org>;
 Tue, 10 Jan 2023 16:56:56 +0000 (UTC)
Received: by mail-wr1-x42b.google.com with SMTP id e3so3248489wru.13
 for <virtualization@lists.linux-foundation.org>;
 Tue, 10 Jan 2023 08:56:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=solid-run-com.20210112.gappssmtp.com; s=20210112;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YlNxrwuGFyPGLoPwPI30O34tsYGN152NUipyHwYQGtk=;
 b=YeJaEvkxfx/MG84ZL8LfrDbZ/Aq0e/mcARdZitN9SdftgbaL8JEJTvHQvWKTDD4NtE
 TxkxlzH4u45NacTioohnwL5Qju6XbXNTYhdBmz2oT+v5FyqTtX2EbECnsqDmw0AOaQK6
 bY/JrPZy8pGNsSWiRokppn9wcGRJ77VGugy3vU2Wti93JZ2uCWd0A3+09Kv1iLZtxZp2
 jTEliGn9WSeoZ9ky+SCBgEQkgGjgh7v+kTEt9/rpbCp8A9S4MImJ6KU+PIU4qO4K10zh
 /2wMd+huU4WC1gzOffNBxmZV70EBpOA15cIhV2/8+7gTJ+z3QiN0xsPT3EWqp4TcNcDr
 JHDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YlNxrwuGFyPGLoPwPI30O34tsYGN152NUipyHwYQGtk=;
 b=w/gr/Mc5872eqsQ61Fzrev8GEWfgkNxiiOTr7i+xvOYuSWfzokeCsnNrx9bbQt/PO/
 mBXA2qvUYXiwgEKt7npL+gPepwg9UPuwrjbzQUCbPopjpWfDDMcyFuBst3n9N95OY5AM
 031yU0xHwdBa3jXIONVX/4dk9oluPJMDNFEjx9bGP0r6y1Amikxy8q+nPMCM6oY/lGNp
 yqM936lh/U6mi0q9a07jxWUJD0jmx5unoigR+CwwAmkJNh2Ligab10PdJ0V4YThzsTeL
 K8aH+skHTLAjLPaSFkpOUskQ4I9H8k3ItLjOv+l+P8PGWMgDNWOjC86oJNP+d9QrycDV
 ZK7A==
X-Gm-Message-State: AFqh2krDBj6g13J16ZDQodYOwj8j8OVpXxmoWRlPuCU6HxFNRdZB+mZp
 90ztCDnts6JF6HIhmWUcEvd8TQ==
X-Google-Smtp-Source: AMrXdXuHqKqd7VPyUwLF0A0z0COCPVuG9BTDEIB2kMwLsPhDfNhoshPTDFgmxT7CiBm+hcCztDWZDg==
X-Received: by 2002:adf:cd0a:0:b0:2b7:26c1:e81a with SMTP id
 w10-20020adfcd0a000000b002b726c1e81amr11863825wrm.25.1673369815162; 
 Tue, 10 Jan 2023 08:56:55 -0800 (PST)
Received: from localhost.localdomain
 (bzq-84-110-153-254.static-ip.bezeqint.net. [84.110.153.254])
 by smtp.gmail.com with ESMTPSA id
 q11-20020adf9dcb000000b00268aae5fb5bsm11918066wre.3.2023.01.10.08.56.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Jan 2023 08:56:54 -0800 (PST)
From: Alvaro Karsz <alvaro.karsz@solid-run.com>
To: linux-pci@vger.kernel.org,
	virtualization@lists.linux-foundation.org
Subject: [PATCH v9 1/3] PCI: Add SolidRun vendor ID
Date: Tue, 10 Jan 2023 18:56:36 +0200
Message-Id: <20230110165638.123745-2-alvaro.karsz@solid-run.com>
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

Add SolidRun vendor ID to pci_ids.h

The vendor ID is used in 2 different source files, the SNET vDPA driver
and PCI quirks.

Signed-off-by: Alvaro Karsz <alvaro.karsz@solid-run.com>
Acked-by: Bjorn Helgaas <bhelgaas@google.com>
---
 include/linux/pci_ids.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
index b362d90eb9b..6716e6371a1 100644
--- a/include/linux/pci_ids.h
+++ b/include/linux/pci_ids.h
@@ -3092,6 +3092,8 @@
 
 #define PCI_VENDOR_ID_3COM_2		0xa727
 
+#define PCI_VENDOR_ID_SOLIDRUN		0xd063
+
 #define PCI_VENDOR_ID_DIGIUM		0xd161
 #define PCI_DEVICE_ID_DIGIUM_HFC4S	0xb410
 
-- 
2.32.0

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
