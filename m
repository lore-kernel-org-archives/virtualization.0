Return-Path: <SRS0=zxqJ=OA=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BD2EC433EF
	for <virtualization@archiver.kernel.org>; Fri, 10 Sep 2021 01:40:38 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E31BC60235
	for <virtualization@archiver.kernel.org>; Fri, 10 Sep 2021 01:40:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org E31BC60235
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 9B37060659;
	Fri, 10 Sep 2021 01:40:37 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id xizjxIL9lq4C; Fri, 10 Sep 2021 01:40:36 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 3305460621;
	Fri, 10 Sep 2021 01:40:36 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 1CBECC000F;
	Fri, 10 Sep 2021 01:40:36 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 8B2D8C000D
 for <virtualization@lists.linux-foundation.org>;
 Fri, 10 Sep 2021 01:40:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 7AD1F60659
 for <virtualization@lists.linux-foundation.org>;
 Fri, 10 Sep 2021 01:40:34 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Mz_YvMoOFNY6
 for <virtualization@lists.linux-foundation.org>;
 Fri, 10 Sep 2021 01:40:34 +0000 (UTC)
X-Greylist: delayed 00:33:17 by SQLgrey-1.8.0
Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
 by smtp3.osuosl.org (Postfix) with ESMTPS id EA5F460621
 for <virtualization@lists.linux-foundation.org>;
 Fri, 10 Sep 2021 01:40:33 +0000 (UTC)
Received: from tazenda.hos.anvin.org
 ([IPv6:2601:646:8600:3c70:7285:c2ff:fefb:fd4]) (authenticated bits=0)
 by mail.zytor.com (8.16.1/8.15.2) with ESMTPSA id 18A1729L277238
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
 Thu, 9 Sep 2021 18:07:08 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 18A1729L277238
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
 s=2021083001; t=1631236030;
 bh=V6F7bdaXf2OKxaplYOc+J8bYBVsMAGw7SiKf5H6zkvY=;
 h=From:To:Cc:Subject:Date:From;
 b=UqI+VY9J3gscDPibGFV+GaghgePB3g8ITCLAyDkkf7xFk6KRPA1sX9Tr3anudTCD5
 2REygG/vPnLwhylBlCQuoMFPJ3ZoxcOB+H0XKK7jPKkqzlnCEQzCdqC1KYH/oX6NgV
 96i6oWwzW1kpUv8X/kx01vvLYMVmCwCBtt7Vsb1h+ZiZla3Cfc7D/ke0U/I/1EJWEw
 DuIY4xVSQWWvKrd+lZGuJkFn+KZhUe5+0AKZe6qFOk3HsvgBzqGaJTDAYh2bEx0u5i
 bV3ewWGmA+C0IcriU0B341jt74JYOK+nSYi4smIFrpsdchw8XuC9duCtGO+WxAYgds
 Aw0kvtB3U7r1g==
From: "H. Peter Anvin (Intel)" <hpa@zytor.com>
To: Gerd Hoffmann <kraxel@redhat.com>, David Airlie <airlied@linux.ie>,
 Daniel Vetter <daniel@ffwll.ch>
Subject: [PATCH] drm/bochs: add Bochs PCI ID for Simics model
Date: Thu,  9 Sep 2021 18:06:55 -0700
Message-Id: <20210910010655.2356245-1-hpa@zytor.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Cc: "H. Peter Anvin \(Intel\)" <hpa@zytor.com>, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, virtualization@lists.linux-foundation.org
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

Current (and older) Simics models for the Bochs VGA used the wrong PCI
vendor ID (0x4321 instead of 0x1234).  Although this can hopefully be
fixed in the future, it is a problem for users of the current version,
not the least because to update the device ID the BIOS has to be
rebuilt in order to see BIOS output.

Add support for the 4321:1111 device number in addition to the
1234:1111 one.

Signed-off-by: H. Peter Anvin (Intel) <hpa@zytor.com>
---
 drivers/gpu/drm/tiny/bochs.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/gpu/drm/tiny/bochs.c b/drivers/gpu/drm/tiny/bochs.c
index 73415fa9ae0f..2ce3bd903b70 100644
--- a/drivers/gpu/drm/tiny/bochs.c
+++ b/drivers/gpu/drm/tiny/bochs.c
@@ -63,6 +63,7 @@ MODULE_PARM_DESC(defy, "default y resolution");
 
 enum bochs_types {
 	BOCHS_QEMU_STDVGA,
+	BOCHS_SIMICS,
 	BOCHS_UNKNOWN,
 };
 
@@ -695,6 +696,13 @@ static const struct pci_device_id bochs_pci_tbl[] = {
 		.subdevice   = PCI_ANY_ID,
 		.driver_data = BOCHS_UNKNOWN,
 	},
+	{
+		.vendor      = 0x4321,
+		.device      = 0x1111,
+		.subvendor   = PCI_ANY_ID,
+		.subdevice   = PCI_ANY_ID,
+		.driver_data = BOCHS_SIMICS,
+	},
 	{ /* end of list */ }
 };
 
-- 
2.31.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
