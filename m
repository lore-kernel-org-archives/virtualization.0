Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8565C4332F
	for <virtualization@archiver.kernel.org>; Mon, 12 Dec 2022 14:25:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 25CA5414CC;
	Mon, 12 Dec 2022 14:25:22 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 25CA5414CC
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=solid-run-com.20210112.gappssmtp.com header.i=@solid-run-com.20210112.gappssmtp.com header.a=rsa-sha256 header.s=20210112 header.b=0aCBUTRz
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id papQ0dpThNsl; Mon, 12 Dec 2022 14:25:21 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 9683D40246;
	Mon, 12 Dec 2022 14:25:20 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 9683D40246
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 69F96C0035;
	Mon, 12 Dec 2022 14:25:20 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 6EBBFC002D
 for <virtualization@lists.linux-foundation.org>;
 Mon, 12 Dec 2022 14:25:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 3CDD3812C7
 for <virtualization@lists.linux-foundation.org>;
 Mon, 12 Dec 2022 14:25:19 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 3CDD3812C7
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=solid-run-com.20210112.gappssmtp.com
 header.i=@solid-run-com.20210112.gappssmtp.com header.a=rsa-sha256
 header.s=20210112 header.b=0aCBUTRz
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id VK_LHWXxInrm
 for <virtualization@lists.linux-foundation.org>;
 Mon, 12 Dec 2022 14:25:17 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org E058C812CD
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com
 [IPv6:2a00:1450:4864:20::334])
 by smtp1.osuosl.org (Postfix) with ESMTPS id E058C812CD
 for <virtualization@lists.linux-foundation.org>;
 Mon, 12 Dec 2022 14:25:16 +0000 (UTC)
Received: by mail-wm1-x334.google.com with SMTP id
 v124-20020a1cac82000000b003cf7a4ea2caso5295173wme.5
 for <virtualization@lists.linux-foundation.org>;
 Mon, 12 Dec 2022 06:25:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=solid-run-com.20210112.gappssmtp.com; s=20210112;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=eqrrdFR0yGu0+OvA2xJ/WZwnDOsQc12K4sxW6RZEG+U=;
 b=0aCBUTRzSEqtv3war4tiQjO8gLQAecP3Rq+FM+pk8d6ahiKZ/FRiP6hTfXwhcl4wAC
 DNePOiV3bh+FLaQ9qn0fFJ4SPqT6V9FMf52UoOfOQaWIzgwmvzMhHuEDivWhA49AS2QM
 DNfioG+QVP42HUOI8tG2ELcZCgxj4CtR74Bad7/v7xG5tuC98+ahRq879AupJtpOGLsa
 FKB3e74lv1OOgSZRl+vl5ipNVco8u0GUCY8HbSpkQmQeXBMQIkyC6DZiaSZtIiLD0/rJ
 0MQotRjVQL2QD3hV6/j2nMaeE7IcCua3rsZgKl6vQx20JhtmcZGzb8UYq3iSLw1mzS86
 VlBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=eqrrdFR0yGu0+OvA2xJ/WZwnDOsQc12K4sxW6RZEG+U=;
 b=zPeyvpcuurt0rfJ5xQbXAsg+5Wj3QigRjPV1meyDbJ5/b9hORFOQs05YUyjISwonKd
 Rx/OywBNyIf1/U1PIVr7cKo5k/L9PBk3QhF/LrnKxj/5/z0eK4PcyjcUwWe9X1fIdzD3
 8wrC+ph5g09pcSetkCAhv20uIfmJMV8Y2YjBXceNZd7Jx5Z3IWQaXHO5GkFPUCHnM81n
 LQUJwPrPlLV2/cbmeU5L1CCq4DbO2rRfEDb1vXHVkgd/LSZTg4y1WLZjCLQuaUhZmBUv
 KNCuP19VqE+au6RMz3N9qJbb0+GXVk6iFoULAKm2QtDCyAiWyC4rzebbTZARNZRinza6
 cAsQ==
X-Gm-Message-State: ANoB5pmCqkwkmIJs2ilsjU6rXxQWEtxTGFw75Tra04NBedHHP2Yji9xx
 Ujeba5S3wh+U5Gb2UaV0wOjYvMGjlMXDbRPi
X-Google-Smtp-Source: AA0mqf4lHJ54ollxf7pUgiXEQKYXLDUubLj+Mrtu+pwLBBEIh7QSTP3lZwqAmg8AxTu8TUfvl2l33g==
X-Received: by 2002:a05:600c:1da2:b0:3cf:5fd2:87a0 with SMTP id
 p34-20020a05600c1da200b003cf5fd287a0mr12010376wms.40.1670855114403; 
 Mon, 12 Dec 2022 06:25:14 -0800 (PST)
Received: from localhost.localdomain
 (bzq-84-110-153-254.static-ip.bezeqint.net. [84.110.153.254])
 by smtp.gmail.com with ESMTPSA id
 c1-20020a05600c0a4100b003d1e3b1624dsm10662692wmq.2.2022.12.12.06.25.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 Dec 2022 06:25:13 -0800 (PST)
From: Alvaro Karsz <alvaro.karsz@solid-run.com>
To: virtualization@lists.linux-foundation.org
Subject: [PATCH 1/3] Add SolidRun vendor id
Date: Mon, 12 Dec 2022 16:24:52 +0200
Message-Id: <20221212142454.3225177-2-alvaro.karsz@solid-run.com>
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
