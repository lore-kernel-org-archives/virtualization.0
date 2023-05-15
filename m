Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1FAAAC77B7D
	for <virtualization@archiver.kernel.org>; Mon, 15 May 2023 11:50:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 81DB260B96;
	Mon, 15 May 2023 11:50:44 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 81DB260B96
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=UTxsBakQ
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id L4v8hqROg16m; Mon, 15 May 2023 11:50:43 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id F32FB60C34;
	Mon, 15 May 2023 11:50:42 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org F32FB60C34
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C1701C0036;
	Mon, 15 May 2023 11:50:42 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0FB1DC002A
 for <virtualization@lists.linux-foundation.org>;
 Mon, 15 May 2023 11:50:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id DD76260C34
 for <virtualization@lists.linux-foundation.org>;
 Mon, 15 May 2023 11:50:41 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org DD76260C34
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id aWPasCVzq07B
 for <virtualization@lists.linux-foundation.org>;
 Mon, 15 May 2023 11:50:40 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 7FB3960B96
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com
 [IPv6:2a00:1450:4864:20::434])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 7FB3960B96
 for <virtualization@lists.linux-foundation.org>;
 Mon, 15 May 2023 11:50:40 +0000 (UTC)
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-3077d134028so7537781f8f.3
 for <virtualization@lists.linux-foundation.org>;
 Mon, 15 May 2023 04:50:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1684151438; x=1686743438;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=GyzK6zODNZ80W+kK6XaRTPTEwX24SG6fcd1Iz/90fb8=;
 b=UTxsBakQU4eCusOYdatlhpnQ9g4/hE792zqadsLiaerX3oFqGbaE6QJH3nuV2Tw8DW
 41J37uxPHZjRsIdRSVwKE7YkvQYjQhanUes45CA8lfKM+AS7O8pUOvz5BaKjtzcfVHVV
 h1iX098ww8e8adpRDbKmZe8JDFzK4yM9kKWKN6wDkGxlH/JC3BlmQaHuMR+aqAD8JReW
 O3dBh8fjgo4XYOesAqD2LI3KSAvLeKXG08ySvCbGzDRTQDXt7Tfur9CxQ6A3+WkmvMRe
 4aptp5JI2i4+hVofB4sQqvO+TiC2GhU1rI4HymtiQiyKTezbxOsynLj77l0zM3ehpWna
 BesQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684151438; x=1686743438;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=GyzK6zODNZ80W+kK6XaRTPTEwX24SG6fcd1Iz/90fb8=;
 b=R6YKtV0HU8Q+8B80uxgpBn16to//2cs+ffsc3HZf5FAKePvImCWcw/KkIdHw2rFkL1
 cVys9L5v2PiVRoBVgT99t6eAl5LvLvpPg1ANC1l7msuj/DqcG1vxev2A0S+GdXJIgKfc
 CCxLrkQU5liMRw2wzhFErsfaT1y5Koo52L9RyF0zYGKM1RktxchniAZFx892517MFYIQ
 xkgHWISSx+3ookMjufrfVfOYGrgI6HIC7seHknzl1sF1DFknoqLjRhbcC4Lt1vjWVa/J
 cQCm5xI5nU8XwY7S4go3qP0uL4w0Wr7bmJoVkjBUL1oJkKIQPGPWwI98LVdK+8EqTCKl
 smTw==
X-Gm-Message-State: AC+VfDyzo8dJouACDK6onv5NHlKeg+ESzyRReFf/y3v3nP42gxuds9Rp
 XonoacO/ggqRBsocnwF49xOeDg==
X-Google-Smtp-Source: ACHHUZ5fwYAwjxp2LGlU56hWvOhWFldIqE1lVKGuVXgWQ/WSLETo9yNBvOKJeDm1tywC5gQEZcgzBA==
X-Received: by 2002:a5d:680e:0:b0:309:e24:57b0 with SMTP id
 w14-20020a5d680e000000b003090e2457b0mr5209363wru.30.1684151438281; 
 Mon, 15 May 2023 04:50:38 -0700 (PDT)
Received: from localhost.localdomain (5750a5b3.skybroadband.com.
 [87.80.165.179]) by smtp.gmail.com with ESMTPSA id
 j6-20020a5d6186000000b003090cb7a9e6sm7555395wru.31.2023.05.15.04.50.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 15 May 2023 04:50:37 -0700 (PDT)
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: joro@8bytes.org,
	will@kernel.org
Subject: [PATCH v2 0/2] iommu/virtio: Fixes
Date: Mon, 15 May 2023 12:39:46 +0100
Message-Id: <20230515113946.1017624-1-jean-philippe@linaro.org>
X-Mailer: git-send-email 2.40.0
MIME-Version: 1.0
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>, akihiko.odaki@daynix.com,
 virtualization@lists.linux-foundation.org, eric.auger@redhat.com,
 iommu@lists.linux.dev, robin.murphy@arm.com
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

One fix reported by Akihiko, and another found while going over the
driver.

Jean-Philippe Brucker (2):
  iommu/virtio: Detach domain on endpoint release
  iommu/virtio: Return size mapped for a detached domain

 drivers/iommu/virtio-iommu.c | 57 ++++++++++++++++++++++++++----------
 1 file changed, 41 insertions(+), 16 deletions(-)

-- 
2.40.0

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
