Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F3BBC10F1B
	for <virtualization@archiver.kernel.org>; Mon, 19 Dec 2022 08:35:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 1D6E04016F;
	Mon, 19 Dec 2022 08:35:27 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 1D6E04016F
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=solid-run-com.20210112.gappssmtp.com header.i=@solid-run-com.20210112.gappssmtp.com header.a=rsa-sha256 header.s=20210112 header.b=vxew87ZC
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id vLlTyPgvxR5H; Mon, 19 Dec 2022 08:35:26 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id B092A400F8;
	Mon, 19 Dec 2022 08:35:25 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org B092A400F8
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 7876BC0070;
	Mon, 19 Dec 2022 08:35:25 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 736F0C002D
 for <virtualization@lists.linux-foundation.org>;
 Mon, 19 Dec 2022 08:35:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 2C45C4012E
 for <virtualization@lists.linux-foundation.org>;
 Mon, 19 Dec 2022 08:35:23 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 2C45C4012E
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 4biZQIL4YxND
 for <virtualization@lists.linux-foundation.org>;
 Mon, 19 Dec 2022 08:35:22 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 3DDD4400F8
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com
 [IPv6:2a00:1450:4864:20::32b])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 3DDD4400F8
 for <virtualization@lists.linux-foundation.org>;
 Mon, 19 Dec 2022 08:35:22 +0000 (UTC)
Received: by mail-wm1-x32b.google.com with SMTP id
 h8-20020a1c2108000000b003d1efd60b65so8273788wmh.0
 for <virtualization@lists.linux-foundation.org>;
 Mon, 19 Dec 2022 00:35:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=solid-run-com.20210112.gappssmtp.com; s=20210112;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=QJNvWlx4hs2HzBNceRW3/M7eig4DdhugN3XpshYak/4=;
 b=vxew87ZC1wciAGea9e0EpXjGmJdmIIHDwsGA+WFKNonuRW+0xmvdaN1P9DrIXzIFlc
 UL1+upmwr7nSo83Ew9G4Bnuif1t+14rh1c//hwkQY7Ss/NstccMlKqJrDrmbCCHodWX/
 bwvMKywJKVVOMddNVmu6LmCVj7fOxe7R6Q9ZReasI6xScBXGDZWNZFo+ANKa2SQulXAO
 qzjpjmqWEqT4fyEevB4wVvm6s8tIYWX+a9sqbSMTNULIux9Qgv6nybjpWoOjlkeTffuR
 3aWjlHlMH0rPJBh6xUWZ12VHSGAHMopH2NfabBzukQBQEmzFgA/Jdjrj3iZK2lW065Zr
 huVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=QJNvWlx4hs2HzBNceRW3/M7eig4DdhugN3XpshYak/4=;
 b=i0Us3HZJQwHsg2wz/S4Snlggkzo/QA8d8tT1AyGJKqaFBHwC2t4rRnvkY2TS3Z+jo9
 L05UWPeTY9bJqR2waWFEf1gotCH2mOxf+4WLRvxAM4f4a2CYiukSXzoa6wzubcNsp4Cq
 qnEDpjKPIPgFs8m3CTrRTTVxM/LEbX9em3egVv6tvTp/zrW/JUQMpTzSCQrSAe+j6qag
 eOmDs3NPY6UPsAzDD4NIFK4vjUruuyaK+nkjRFv5M1Z9VYwINomL6i2ZYcqydiuLa2TW
 SkoJpbksvcTtV5nIJqwpTWkDBUJLD4tSR22zra/vV+HFqRy2kDoDlmB0Zh1/enRIEHqI
 L3ZQ==
X-Gm-Message-State: AFqh2krjnxGn+6phdCDSOg7cnlZMXffXeSwKgYldUTGnUKDbAhYH+b8L
 QFwSnamIaEw9gIM27MRiM+7qudYcoqOoJfIm
X-Google-Smtp-Source: AMrXdXuPMXY4qJBry1TzKs47PEIklDEv++kof+LSyU3ukg70r+xBAV2/+gnOipHwdDp9j059uTPBAA==
X-Received: by 2002:a05:600c:4f83:b0:3d3:56ce:5673 with SMTP id
 n3-20020a05600c4f8300b003d356ce5673mr2597815wmq.6.1671438919611; 
 Mon, 19 Dec 2022 00:35:19 -0800 (PST)
Received: from localhost.localdomain
 (bzq-84-110-153-254.static-ip.bezeqint.net. [84.110.153.254])
 by smtp.gmail.com with ESMTPSA id
 z22-20020a05600c0a1600b003cfd0bd8c0asm11364246wmp.30.2022.12.19.00.35.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 Dec 2022 00:35:18 -0800 (PST)
From: Alvaro Karsz <alvaro.karsz@solid-run.com>
To: virtualization@lists.linux-foundation.org,
	linux-pci@vger.kernel.org
Subject: [RESEND PATCH 0/3] virtio: vdpa: new SolidNET DPU driver
Date: Mon, 19 Dec 2022 10:35:08 +0200
Message-Id: <20221219083511.73205-1-alvaro.karsz@solid-run.com>
X-Mailer: git-send-email 2.32.0
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
 drivers/vdpa/Kconfig               |   10 +
 drivers/vdpa/Makefile              |    1 +
 drivers/vdpa/solidrun/Makefile     |    6 +
 drivers/vdpa/solidrun/snet_hwmon.c |  188 +++++
 drivers/vdpa/solidrun/snet_main.c  | 1111 ++++++++++++++++++++++++++++
 drivers/vdpa/solidrun/snet_vdpa.h  |  196 +++++
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
