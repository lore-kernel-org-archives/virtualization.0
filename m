Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 542F3C00145
	for <virtualization@archiver.kernel.org>; Mon, 12 Dec 2022 14:25:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id BE26C400D2;
	Mon, 12 Dec 2022 14:25:16 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org BE26C400D2
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=solid-run-com.20210112.gappssmtp.com header.i=@solid-run-com.20210112.gappssmtp.com header.a=rsa-sha256 header.s=20210112 header.b=MdCDSlAe
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id IADLGlJuGecr; Mon, 12 Dec 2022 14:25:16 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 5EAAA40256;
	Mon, 12 Dec 2022 14:25:15 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 5EAAA40256
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 166C4C0032;
	Mon, 12 Dec 2022 14:25:15 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 7BE30C002D
 for <virtualization@lists.linux-foundation.org>;
 Mon, 12 Dec 2022 14:25:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 5415F40255
 for <virtualization@lists.linux-foundation.org>;
 Mon, 12 Dec 2022 14:25:14 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 5415F40255
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=solid-run-com.20210112.gappssmtp.com
 header.i=@solid-run-com.20210112.gappssmtp.com header.a=rsa-sha256
 header.s=20210112 header.b=MdCDSlAe
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id f8EFzCRd0EjE
 for <virtualization@lists.linux-foundation.org>;
 Mon, 12 Dec 2022 14:25:13 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 51C6140246
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com
 [IPv6:2a00:1450:4864:20::331])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 51C6140246
 for <virtualization@lists.linux-foundation.org>;
 Mon, 12 Dec 2022 14:25:13 +0000 (UTC)
Received: by mail-wm1-x331.google.com with SMTP id v7so5561844wmn.0
 for <virtualization@lists.linux-foundation.org>;
 Mon, 12 Dec 2022 06:25:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=solid-run-com.20210112.gappssmtp.com; s=20210112;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=/VkX0ZgY+XC31wIVV7Rqaaa4AmLATaZui7Ah2xDnRSU=;
 b=MdCDSlAeAfE4xBO1BOBln/d6leue6jP5BSnNKVUzPvIhMKjGAv7wKNJv/OAHnPXBao
 tGYmgfldh4pDjjPrKgSKb8HVfwT2UuzpDyWNh79KuzcHfVXdIcSgelPCCy7gwylvcLCh
 LheOd6KbTJJauO0qnbhXZNszNkBr66U0iwtWGwDJy5bQpmccdm3zHEy/e8S5GP86BBCr
 c+AnJa8I7jiLTnbYEvOg7D4p4D4BmFbXctugQYWUxRgDrIXY9q78fcbz3/NOz7IJFqJk
 +rvhTT0OpVqGmoHVD1Xn50CG693w0KEyhwL5Ysd/3hV6soqUN7d2JAFgbIZaNBllokOl
 pJsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=/VkX0ZgY+XC31wIVV7Rqaaa4AmLATaZui7Ah2xDnRSU=;
 b=DO7MDhxj83Zh+FXKLixairGKcFz7wHOK3OWptf4RIiWinbq5UhsuQ+5FauEk3phIpX
 gx6uZ3s+YBqdtcFtDhzG7IicbmUV7QR9hPuHxDinOlauXTjwpAXTwWsccaL7n1toVfyb
 qbqfcqOXJHxTV6BBXpEYNmVwxMv8odtYOH5o2NB/3tqDKUZvlgrSyEwIxSbTTkZ0V0CN
 bUFi4z5+gYxzZBjNjAti6lOdZ5r/9mILjneXrysW77E8sDtzaWzzBSTqhZLMog1nG4Aw
 6wZL7wUZKxSx50pbScq5r0/HPazpCL6Na5ds013EGOMzgJ66TzRo0erxSVxyywc/mujm
 3IXQ==
X-Gm-Message-State: ANoB5plulmfcsHGd0g36DbnmvgKpHG1b4ra6wt4MTwFm6r0FQfv/Frum
 sWsEbKgS6MApruuSOVsnkss9/tkkTArEg+li
X-Google-Smtp-Source: AA0mqf7azZI79xLlzzwTkKfotuoktvz3SBud6DANHCbaRb2o6qqS5Mj0Ewhu77XzNgU4ftL3DIW7eQ==
X-Received: by 2002:a05:600c:3ac7:b0:3d0:7fee:8a70 with SMTP id
 d7-20020a05600c3ac700b003d07fee8a70mr12761565wms.19.1670855110537; 
 Mon, 12 Dec 2022 06:25:10 -0800 (PST)
Received: from localhost.localdomain
 (bzq-84-110-153-254.static-ip.bezeqint.net. [84.110.153.254])
 by smtp.gmail.com with ESMTPSA id
 c1-20020a05600c0a4100b003d1e3b1624dsm10662692wmq.2.2022.12.12.06.25.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 Dec 2022 06:25:09 -0800 (PST)
From: Alvaro Karsz <alvaro.karsz@solid-run.com>
To: virtualization@lists.linux-foundation.org
Subject: [PATCH 0/3] virtio: vdpa: new SolidNET DPU driver
Date: Mon, 12 Dec 2022 16:24:51 +0200
Message-Id: <20221212142454.3225177-1-alvaro.karsz@solid-run.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Cc: linux-pci@vger.kernel.org
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

This series adds a vDPA driver for SolidNET DPU.

Patch 1 adds SolidRun vendor id to pci_ids.
Patch 2 adds a pci quirk needed by the DPU.
Patch 3 has the driver source code.

Patch 1 is prerequisite for both patch 2 and patch 3.

Alvaro Karsz (3):
  Add SolidRun vendor id
  New PCI quirk for SolidRun SNET DPU.
  virtio: vdpa: new SolidNET DPU driver.

 MAINTAINERS                        |    4 +
 drivers/pci/quirks.c               |    8 +
 drivers/vdpa/Kconfig               |   11 +
 drivers/vdpa/Makefile              |    1 +
 drivers/vdpa/solidrun/Makefile     |    3 +
 drivers/vdpa/solidrun/snet_hwmon.c |  191 +++++
 drivers/vdpa/solidrun/snet_main.c  | 1114 ++++++++++++++++++++++++++++
 drivers/vdpa/solidrun/snet_vdpa.h  |  192 +++++
 include/linux/pci_ids.h            |    2 +
 9 files changed, 1526 insertions(+)
 create mode 100644 drivers/vdpa/solidrun/Makefile
 create mode 100644 drivers/vdpa/solidrun/snet_hwmon.c
 create mode 100644 drivers/vdpa/solidrun/snet_main.c
 create mode 100644 drivers/vdpa/solidrun/snet_vdpa.h

-- 
2.32.0

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
