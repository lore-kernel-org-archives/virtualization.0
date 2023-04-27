Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3818BC77B7F
	for <virtualization@archiver.kernel.org>; Thu, 27 Apr 2023 10:44:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id CA539615D9;
	Thu, 27 Apr 2023 10:44:52 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org CA539615D9
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igel-co-jp.20221208.gappssmtp.com header.i=@igel-co-jp.20221208.gappssmtp.com header.a=rsa-sha256 header.s=20221208 header.b=hYqAufa4
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id W6w4m3y3M7o4; Thu, 27 Apr 2023 10:44:52 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 5EF20615D5;
	Thu, 27 Apr 2023 10:44:51 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 5EF20615D5
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 2B3B7C008A;
	Thu, 27 Apr 2023 10:44:51 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3452BC002A
 for <virtualization@lists.linux-foundation.org>;
 Thu, 27 Apr 2023 10:44:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 0F54A40635
 for <virtualization@lists.linux-foundation.org>;
 Thu, 27 Apr 2023 10:44:47 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 0F54A40635
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=igel-co-jp.20221208.gappssmtp.com
 header.i=@igel-co-jp.20221208.gappssmtp.com header.a=rsa-sha256
 header.s=20221208 header.b=hYqAufa4
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id uy0j9Zxd71EQ
 for <virtualization@lists.linux-foundation.org>;
 Thu, 27 Apr 2023 10:44:46 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 6D2D240591
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com
 [IPv6:2607:f8b0:4864:20::434])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 6D2D240591
 for <virtualization@lists.linux-foundation.org>;
 Thu, 27 Apr 2023 10:44:46 +0000 (UTC)
Received: by mail-pf1-x434.google.com with SMTP id
 d2e1a72fcca58-63b4e5fdb1eso9657653b3a.1
 for <virtualization@lists.linux-foundation.org>;
 Thu, 27 Apr 2023 03:44:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=igel-co-jp.20221208.gappssmtp.com; s=20221208; t=1682592286; x=1685184286;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fuOjoATSwNwQ5isXLaWbsITf7ep/YO9eHaGnk3Xv1+k=;
 b=hYqAufa4TE3E13v6DVzZqXL2LgZM3tGhzXzeC/RXQWeCPnDroXtW4401AHTsakrrdT
 YpglWLsLyen3dm0MQ1ZSumQ35y/2jEcCxe5PxefBZJNacdGnp2pc/+KWPC4QsPUeDezv
 OIkYvSC1wmhp4a7aDsv9swfYcTz3yay3GKiwRKLY+yFiT3ntA88bIc+wIWiTWy8uIY7+
 au0hiN//H59a1eX/a9u2DyAFGu4VWjqACeWmAV6pKzl+Pa+1/xEytXMTRBlMcaF4vRBU
 iG618MyM93PzNbUfej9In1yxqCTt5tmKV7cX6D1WkwqMTf6/zlT9scMIMmP2C5MediIO
 AVFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1682592286; x=1685184286;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fuOjoATSwNwQ5isXLaWbsITf7ep/YO9eHaGnk3Xv1+k=;
 b=labAlfPTX7+y9ZB72VF+5CL+Kahp79hY2KpzTFeDz1Cc2MLkHuUH6niXUR7mtM1UYQ
 rzpN8YuSJW/hkr4aIC/6Zy7JbKW8gf5mH3euzsJizGuO0HrY89/t9mjwIcL/hzDbm1Kk
 2os6qTJdNyln3JQI58n6wChQFnFRbYhod7q+2if9GJkgwMIu8vkyVzgWlFnOSQaL0a/2
 rW0NiLKs6qgzKKXShw3NEWgJArHUzqQQ2DT2y3FWnOga+iZ1GNIy+SWNvww/UHkvLNy+
 jKYQVJuaVh7L2NF6f/ZdUlXtFuMrfjAFUK+Tb1ptEXQXh5CVH6EYwFfqU++Y+1Tjg93H
 GOlA==
X-Gm-Message-State: AC+VfDwt6UM+TZMaWy60LmlrooEdwDXFlX4yJp9jwfqcrhAqquWFWGlE
 niEjJb2AC8OPvqpmO9hfQqv/XA==
X-Google-Smtp-Source: ACHHUZ6+mO8MNfDjediiWb04QBeKKlGEKAVthfq82g/F9dpwMpBpxs0PCUGgTwMThDQwB6uxdelnbw==
X-Received: by 2002:a05:6a20:3c8b:b0:f2:93b7:a452 with SMTP id
 b11-20020a056a203c8b00b000f293b7a452mr1632523pzj.4.1682592285840; 
 Thu, 27 Apr 2023 03:44:45 -0700 (PDT)
Received: from tyrell.hq.igel.co.jp (napt.igel.co.jp. [219.106.231.132])
 by smtp.gmail.com with ESMTPSA id
 b3-20020a631b03000000b0050f93a3586fsm11029042pgb.37.2023.04.27.03.44.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Apr 2023 03:44:45 -0700 (PDT)
From: Shunsuke Mie <mie@igel.co.jp>
To: Lorenzo Pieralisi <lpieralisi@kernel.org>
Subject: [RFC PATCH v2 2/3] virtio_pci: add a definition of queue flag in ISR
Date: Thu, 27 Apr 2023 19:44:27 +0900
Message-Id: <20230427104428.862643-3-mie@igel.co.jp>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230427104428.862643-1-mie@igel.co.jp>
References: <20230427104428.862643-1-mie@igel.co.jp>
MIME-Version: 1.0
Cc: Kishon Vijay Abraham I <kishon@kernel.org>,
 =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
 Randy Dunlap <rdunlap@infradead.org>, "Michael S. Tsirkin" <mst@redhat.com>,
 linux-pci@vger.kernel.org, Manivannan Sadhasivam <mani@kernel.org>,
 Frank Li <Frank.Li@nxp.com>, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, Ren Zhijie <renzhijie2@huawei.com>,
 Shunsuke Mie <mie@igel.co.jp>, Jon Mason <jdmason@kudzu.us>,
 Bjorn Helgaas <bhelgaas@google.com>
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

Already it has beed defined a config changed flag of ISR, but not the queue
flag. Add a macro for it.

Signed-off-by: Shunsuke Mie <mie@igel.co.jp>
---
 include/uapi/linux/virtio_pci.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/include/uapi/linux/virtio_pci.h b/include/uapi/linux/virtio_pci.h
index f703afc7ad31..d405bea27240 100644
--- a/include/uapi/linux/virtio_pci.h
+++ b/include/uapi/linux/virtio_pci.h
@@ -94,6 +94,9 @@
 
 #endif /* VIRTIO_PCI_NO_LEGACY */
 
+/* Bits for ISR status field:only when if MSI-X is disabled */
+/* The bit of the ISR which indicates a queue entry update. */
+#define VIRTIO_PCI_ISR_QUEUE		0x1
 /* The bit of the ISR which indicates a device configuration change. */
 #define VIRTIO_PCI_ISR_CONFIG		0x2
 /* Vector value used to disable MSI for queue */
-- 
2.25.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
