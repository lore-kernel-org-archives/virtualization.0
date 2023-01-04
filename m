Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9BDB2C46467
	for <virtualization@archiver.kernel.org>; Wed,  4 Jan 2023 12:13:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 1BC2B40328;
	Wed,  4 Jan 2023 12:13:32 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 1BC2B40328
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=solid-run-com.20210112.gappssmtp.com header.i=@solid-run-com.20210112.gappssmtp.com header.a=rsa-sha256 header.s=20210112 header.b=R5XNmAXf
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id q5jH8yL7loUm; Wed,  4 Jan 2023 12:13:31 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id AC87740420;
	Wed,  4 Jan 2023 12:13:30 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org AC87740420
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 84549C0033;
	Wed,  4 Jan 2023 12:13:30 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 69425C002D
 for <virtualization@lists.linux-foundation.org>;
 Wed,  4 Jan 2023 12:13:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 510BD40420
 for <virtualization@lists.linux-foundation.org>;
 Wed,  4 Jan 2023 12:13:29 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 510BD40420
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 0LlBFlnYt6tY
 for <virtualization@lists.linux-foundation.org>;
 Wed,  4 Jan 2023 12:13:28 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 6A12840328
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com
 [IPv6:2a00:1450:4864:20::32e])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 6A12840328
 for <virtualization@lists.linux-foundation.org>;
 Wed,  4 Jan 2023 12:13:28 +0000 (UTC)
Received: by mail-wm1-x32e.google.com with SMTP id
 p1-20020a05600c1d8100b003d8c9b191e0so26261169wms.4
 for <virtualization@lists.linux-foundation.org>;
 Wed, 04 Jan 2023 04:13:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=solid-run-com.20210112.gappssmtp.com; s=20210112;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=vl5DK/+4EXCuNeg8yiIZUHFWHVaFdQmZhRZ8iijVByY=;
 b=R5XNmAXfgiR6j+vvXNZ+0MNAhF76pMPk9MG8+it8cODFQX1lNK765PPMiR2alCo42e
 yH0qelYDKSNbd1W+5psw4ULMr53BKb54t9dkyqZR2b62eB9luQBg4B6KQLXK/qNpZkEG
 r+XDWZM0gagr6PPINCAR0E2hiNG/7AVMEqeIlbPhnRc+qsknwLkbnu5rb8pOIfTwFwGs
 loDZMQOdk412YAC/2NegtBEoVideuHU8d3To3MokG5zUdv6gqDjnhjnJ+/aBxRMsD0sm
 0t4VghAAxMU77oq8hVyS8o0nhl3+KHK0WbdfUZ/d7KmFLEYq/aqwp1gN0JF6fC/YDQuK
 5jfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=vl5DK/+4EXCuNeg8yiIZUHFWHVaFdQmZhRZ8iijVByY=;
 b=XZ9flsEBmIQRZ1P1keCTn6fvTwSQXJ3SFchW3kngBr4p4rvfsv8vZuCqE7mW0/3d9t
 /We89mv0v6vwCIRQMOczocpGSf93XBatVWeK+1NGqKriMYMGvtqoSivahv9I8YwkSKm0
 8dMtUzRNpry5iqbuwSmhoMCfWksrKkH+h1JgXNYW+iHTpyazLp/+awU8fn/5w0KHScOi
 JKatEfaJO8YGgJhTDdHWJplyWVqGl5Lo2qZBjEeIw0PM7vOQG1bERJXYq/ncLqZlhLTd
 QMyhVL2736SYAkjXW0BzTGncSTQVnPZLAgjUTG6rlb7Xutt/Pz6XPJ68QC5oxgm0I0k7
 snWQ==
X-Gm-Message-State: AFqh2kqRG+JLdLk+pO/Tre/+9lKP+64VNcNZJihWsV88t6RxSbphGTzN
 AbgTQIqxa9QAMSXiyqlxDAntCp4/AiwEb3Qh
X-Google-Smtp-Source: AMrXdXuktmXhTLHdcZnQfW8+rj0/DjOxaEqCKSIPOVGoHuTAAy7CqLlEPfU7XjVWIeM9CFuAXF7FtQ==
X-Received: by 2002:a05:600c:16c5:b0:3d1:f687:1fd0 with SMTP id
 l5-20020a05600c16c500b003d1f6871fd0mr33814216wmn.12.1672834406002; 
 Wed, 04 Jan 2023 04:13:26 -0800 (PST)
Received: from localhost.localdomain
 (bzq-84-110-153-254.static-ip.bezeqint.net. [84.110.153.254])
 by smtp.gmail.com with ESMTPSA id
 m17-20020a05600c3b1100b003cfbbd54178sm2285157wms.2.2023.01.04.04.13.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Jan 2023 04:13:25 -0800 (PST)
From: Alvaro Karsz <alvaro.karsz@solid-run.com>
To: virtualization@lists.linux-foundation.org
Subject: [PATCH] virtio: vdpa: fix kernel warning in snet_vdpa_remove_vf
Date: Wed,  4 Jan 2023 14:13:22 +0200
Message-Id: <20230104121322.3892266-1-alvaro.karsz@solid-run.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Cc: mst@redhat.com
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

Call pci_free_irq_vectors after calling vdpa_unregister_device.
Otherwise, we get the following kernel warning:

	remove_proc_entry: removing non-empty directory 'irq/..',
	leaking at least '..'

This happens only if SNET_CFG_FLAG_IRQ_PF flag is not set.

This patch should be applied on top of:
virtio: vdpa: new SolidNET DPU driver,
by Alvaro Karsz alvaro.karsz@solid-run.com

Signed-off-by: Alvaro Karsz <alvaro.karsz@solid-run.com>
---
 drivers/vdpa/solidrun/snet_main.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/vdpa/solidrun/snet_main.c b/drivers/vdpa/solidrun/snet_main.c
index 9ceacf96de0..0c13ccde452 100644
--- a/drivers/vdpa/solidrun/snet_main.c
+++ b/drivers/vdpa/solidrun/snet_main.c
@@ -1073,12 +1073,11 @@ static void snet_vdpa_remove_vf(struct pci_dev *pdev)
 	struct snet *snet = pci_get_drvdata(pdev);
 	struct psnet *psnet = snet->psnet;
 
+	vdpa_unregister_device(&snet->vdpa);
+	snet_free_vqs(snet);
 	/* If IRQs are allocated from the VF, we should free the IRQs */
 	if (!PSNET_FLAG_ON(psnet, SNET_CFG_FLAG_IRQ_PF))
 		pci_free_irq_vectors(pdev);
-
-	vdpa_unregister_device(&snet->vdpa);
-	snet_free_vqs(snet);
 }
 
 static void snet_vdpa_remove(struct pci_dev *pdev)
-- 
2.32.0

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
