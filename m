Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB063C4332F
	for <virtualization@archiver.kernel.org>; Mon, 19 Dec 2022 08:35:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 5A5B460597;
	Mon, 19 Dec 2022 08:35:28 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 5A5B460597
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=solid-run-com.20210112.gappssmtp.com header.i=@solid-run-com.20210112.gappssmtp.com header.a=rsa-sha256 header.s=20210112 header.b=1VPk/0j1
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id GSAdCvP7hg3c; Mon, 19 Dec 2022 08:35:27 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id ED8C660AF4;
	Mon, 19 Dec 2022 08:35:26 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org ED8C660AF4
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id BC808C0070;
	Mon, 19 Dec 2022 08:35:26 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 670A8C002D
 for <virtualization@lists.linux-foundation.org>;
 Mon, 19 Dec 2022 08:35:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 2CDE140895
 for <virtualization@lists.linux-foundation.org>;
 Mon, 19 Dec 2022 08:35:25 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 2CDE140895
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=solid-run-com.20210112.gappssmtp.com
 header.i=@solid-run-com.20210112.gappssmtp.com header.a=rsa-sha256
 header.s=20210112 header.b=1VPk/0j1
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id b2FGZIWINQU7
 for <virtualization@lists.linux-foundation.org>;
 Mon, 19 Dec 2022 08:35:24 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 654DD40894
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com
 [IPv6:2a00:1450:4864:20::336])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 654DD40894
 for <virtualization@lists.linux-foundation.org>;
 Mon, 19 Dec 2022 08:35:24 +0000 (UTC)
Received: by mail-wm1-x336.google.com with SMTP id
 b24-20020a05600c4a9800b003d21efdd61dso5789385wmp.3
 for <virtualization@lists.linux-foundation.org>;
 Mon, 19 Dec 2022 00:35:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=solid-run-com.20210112.gappssmtp.com; s=20210112;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=eqrrdFR0yGu0+OvA2xJ/WZwnDOsQc12K4sxW6RZEG+U=;
 b=1VPk/0j1vwFjcWXN+D7MN9A9coTcbbGH05rafVceAXxqmaBwKqo6xBTJjt9tMe5urA
 S0Luc573uI5EeSg9LaMBNk5uVBTXVKy/ogHmNkMwavwQuH7D3r2R1BlHganekPxjTEQA
 sbEBnQZoxyx10G9oNRS3NNvAeJzYCAeG+npl+a2d+ZdpoZj3noG0GPii0Ahg+n0c6f8n
 JqU+SnedH11PVOYhTM3hUAwJ2s9jQgYoWh1+yrOmp4P4e53eP489zO+vjXQee6Z84rUT
 gGHoPiw5owuL9k5Zzxr6eaADWxgt5rUqFauEmuS9FGCVLuGriEWB/8a2aWy99OwG8fjw
 G5xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=eqrrdFR0yGu0+OvA2xJ/WZwnDOsQc12K4sxW6RZEG+U=;
 b=lk8ykOCXJuwMgXByh1H+7oBQ0/OB+Mh6TckqEuFmpoSidH9K5d8CsnQs/fiP07nv3o
 NG3vjP36G4HdlHtYBE9KUH/amhYrSq5mkT5i5zHcj0iSUxIcXILgEgh6lo5O68k0ICGC
 mY4nirPXgKExEoNiF1TpccnkHUsW8iF7uVLG7LgZOqUNiu6X34696VD8hkFTo/3bmRCT
 5+s2Fdeh00hk2dugJR/73s7cCRCot5gAftLZgNFpxh6lVrGLhohu/TeqXvrwbUa7nsSo
 186RO0qevWPEFy9VU2BoK3oCUaAx+zIYy9zy1576Wv/z30CY8CVFCZzxWw6C746PpsNC
 TVoA==
X-Gm-Message-State: ANoB5pn4+IOxebkdld78AyOZ23njq2b5XIovT4hxazkesucbgacO0wu2
 r3KzsG2mXFD39I3a0yuLmD+zcOzxi9XLy6vc
X-Google-Smtp-Source: AA0mqf7iRpS6BZHAjXZ8g5DKrHj0jEqXC5AIJHXWWXnNyoD5pvIxVXDZ74K0NZgxcMersI3Dy67KKw==
X-Received: by 2002:a05:600c:538f:b0:3d0:2485:c046 with SMTP id
 hg15-20020a05600c538f00b003d02485c046mr31592306wmb.27.1671438921724; 
 Mon, 19 Dec 2022 00:35:21 -0800 (PST)
Received: from localhost.localdomain
 (bzq-84-110-153-254.static-ip.bezeqint.net. [84.110.153.254])
 by smtp.gmail.com with ESMTPSA id
 z22-20020a05600c0a1600b003cfd0bd8c0asm11364246wmp.30.2022.12.19.00.35.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 Dec 2022 00:35:21 -0800 (PST)
From: Alvaro Karsz <alvaro.karsz@solid-run.com>
To: virtualization@lists.linux-foundation.org,
	linux-pci@vger.kernel.org
Subject: [RESEND PATCH 1/3] Add SolidRun vendor id
Date: Mon, 19 Dec 2022 10:35:09 +0200
Message-Id: <20221219083511.73205-2-alvaro.karsz@solid-run.com>
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

The vendor id is used in 2 differrent source files,
the SNET vdpa driver and pci quirks.

Signed-off-by: Alvaro Karsz <alvaro.karsz@solid-run.com>
---
 include/linux/pci_ids.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
index b362d90eb9b..33bbe3160b4 100644
--- a/include/linux/pci_ids.h
+++ b/include/linux/pci_ids.h
@@ -3115,4 +3115,6 @@
 
 #define PCI_VENDOR_ID_NCUBE		0x10ff
 
+#define PCI_VENDOR_ID_SOLIDRUN		0xd063
+
 #endif /* _LINUX_PCI_IDS_H */
-- 
2.32.0

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
