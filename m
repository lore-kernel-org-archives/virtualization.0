Return-Path: <SRS0=VeF6=MF=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_RED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87581C07E95
	for <virtualization@archiver.kernel.org>; Tue, 13 Jul 2021 10:51:02 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4CA9D61260
	for <virtualization@archiver.kernel.org>; Tue, 13 Jul 2021 10:51:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4CA9D61260
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 1D5026071D;
	Tue, 13 Jul 2021 10:51:02 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id wc4p3LWqxmCN; Tue, 13 Jul 2021 10:51:00 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 4F4BF6087F;
	Tue, 13 Jul 2021 10:51:00 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 28E83C001A;
	Tue, 13 Jul 2021 10:51:00 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 897FEC000E
 for <virtualization@lists.linux-foundation.org>;
 Tue, 13 Jul 2021 10:50:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 6A54E83ABB
 for <virtualization@lists.linux-foundation.org>;
 Tue, 13 Jul 2021 10:50:59 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=linaro.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id OHVVzlP5vrqQ
 for <virtualization@lists.linux-foundation.org>;
 Tue, 13 Jul 2021 10:50:58 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com
 [IPv6:2607:f8b0:4864:20::102b])
 by smtp1.osuosl.org (Postfix) with ESMTPS id B1AB383AB9
 for <virtualization@lists.linux-foundation.org>;
 Tue, 13 Jul 2021 10:50:58 +0000 (UTC)
Received: by mail-pj1-x102b.google.com with SMTP id
 g6-20020a17090adac6b029015d1a9a6f1aso1642971pjx.1
 for <virtualization@lists.linux-foundation.org>;
 Tue, 13 Jul 2021 03:50:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=jpLLVifshAbN8p9woBgv2ZTKXWPkKhiksBb+TTgeAU0=;
 b=xPiyCCSNVpUMFrtC2LlEfZacKYLM5pphD5lCNG/nuXs3LaUM5dOdfAlFOW8nZwkqhu
 KkEF7hs6FWetfVpeyk/kj3vIOQp4c6kMkbj6KB3alHAs2XmY8I3JJLGZsAfy8sG9X+dY
 MlDtHTK4uyqX6888rCNx/o5Z7cT6DVqqrP4t3QalqFpSyc4jzUya9kWF44FBWSom0UvP
 k2s8/NkxjOW2mRNP0ZkIt0ONSWCgLwQWrPScrazAgHeRnZd+2gznoA9yhDKk8YDfK2w+
 yGYMNjQG8zE+vM4M3R7yjJNtvjpVzhwmWwlT3+wIeF14JFd7vkYNAXazbJKODKH7zP7X
 H+dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=jpLLVifshAbN8p9woBgv2ZTKXWPkKhiksBb+TTgeAU0=;
 b=Ah0JhMr5uC4ocdFr1Nn/9icSAo5M7E4i2hpTqt7/IA1DOEJuyEYCgizw0bBZYhfVN1
 P5LtoIUuLhDdzgjDH92FVMugHl+BbhoP+EUdl4xz07X/SPB5Q5oZFBTjtTiP17zfo+/J
 zRtVriy7B1dHXcNpt8+2Howh4d9o1c/Bfx2WtvCvU1x++3RqEm+6EWa27RcqbL1AHKvS
 hNh79UndQ430hUu+37fbQrcNPeVJmIedEioAA4GDbX2PGwssU/N/WylSMFpRaFVz5BU6
 C93aRaqP0J1nylMbUcS9zyTL9QPraIJainwdEmWht2AHWmr2aVIUSQ1ZuMYPPmIMFeaW
 4INg==
X-Gm-Message-State: AOAM530R3YuP5L0QLyluSFg56FVyEg4efgwclZFPdRPth/0A8TKq4vKO
 uuZn6TqnPnk/li5aWoYTVS4I3w==
X-Google-Smtp-Source: ABdhPJyA0h7pGPn9Q2oO94AvZyMMvb0OAUTS7pkEtEgXnaYJk7eDeP5GAW7/sEilxZeKxmzO7loJrw==
X-Received: by 2002:a17:902:9b87:b029:11e:7c15:a597 with SMTP id
 y7-20020a1709029b87b029011e7c15a597mr3091660plp.6.1626173458228; 
 Tue, 13 Jul 2021 03:50:58 -0700 (PDT)
Received: from localhost ([106.201.108.2])
 by smtp.gmail.com with ESMTPSA id m13sm18415675pfc.119.2021.07.13.03.50.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Jul 2021 03:50:57 -0700 (PDT)
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Jason Wang <jasowang@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Rob Herring <robh+dt@kernel.org>, Arnd Bergmann <arnd@kernel.org>,
 Jean-Philippe Brucker <jean-philippe@linaro.org>
Subject: [PATCH 4/5] i2c: virtio: Update i2c-adapter's of_node
Date: Tue, 13 Jul 2021 16:20:33 +0530
Message-Id: <5465df68b2e18d510fa47e691907287fe655fe8b.1626173013.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.31.1.272.g89b43f80a514
In-Reply-To: <cover.1626173013.git.viresh.kumar@linaro.org>
References: <cover.1626173013.git.viresh.kumar@linaro.org>
MIME-Version: 1.0
Cc: "Enrico Weigelt, metux IT consult" <info@metux.net>,
 Vincent Guittot <vincent.guittot@linaro.org>, devicetree@vger.kernel.org,
 Viresh Kumar <viresh.kumar@linaro.org>, Bill Mills <bill.mills@linaro.org>,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 Wolfram Sang <wsa@kernel.org>, linux-i2c@vger.kernel.org
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

Set of_node of the adapter from the virtio device to enable automatic
parsing the of the I2C devices present in DT.

Cc: Wolfram Sang <wsa@kernel.org>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
Depends on:

https://lore.kernel.org/linux-i2c/984ebecaf697058eb73389ed14ead9dd6d38fb53.1625796246.git.jie.deng@intel.com/
---
 drivers/i2c/busses/i2c-virtio.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/i2c/busses/i2c-virtio.c b/drivers/i2c/busses/i2c-virtio.c
index 0139cdc33cae..cb8cfae2748f 100644
--- a/drivers/i2c/busses/i2c-virtio.c
+++ b/drivers/i2c/busses/i2c-virtio.c
@@ -223,6 +223,7 @@ static int virtio_i2c_probe(struct virtio_device *vdev)
 		 "i2c_virtio at virtio bus %d", vdev->index);
 	vi->adap.algo = &virtio_algorithm;
 	vi->adap.dev.parent = &vdev->dev;
+	vi->adap.dev.of_node = vdev->dev.of_node;
 	i2c_set_adapdata(&vi->adap, vi);
 
 	/*
-- 
2.31.1.272.g89b43f80a514

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
