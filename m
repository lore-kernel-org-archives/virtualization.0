Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B491C433F5
	for <virtualization@archiver.kernel.org>; Fri, 15 Apr 2022 06:45:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id D25D560B1C;
	Fri, 15 Apr 2022 06:45:35 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 5y52oNFARNUn; Fri, 15 Apr 2022 06:45:35 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 76C336103E;
	Fri, 15 Apr 2022 06:45:34 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 5E228C002F;
	Fri, 15 Apr 2022 06:45:34 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 87579C002C
 for <virtualization@lists.linux-foundation.org>;
 Fri, 15 Apr 2022 06:45:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 8422E84138
 for <virtualization@lists.linux-foundation.org>;
 Fri, 15 Apr 2022 06:45:33 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=bytedance-com.20210112.gappssmtp.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Af1HeYbMiNMM
 for <virtualization@lists.linux-foundation.org>;
 Fri, 15 Apr 2022 06:45:33 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com
 [IPv6:2607:f8b0:4864:20::432])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 163D284068
 for <virtualization@lists.linux-foundation.org>;
 Fri, 15 Apr 2022 06:45:32 +0000 (UTC)
Received: by mail-pf1-x432.google.com with SMTP id n43so2665378pfv.10
 for <virtualization@lists.linux-foundation.org>;
 Thu, 14 Apr 2022 23:45:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance-com.20210112.gappssmtp.com; s=20210112;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=ouz4DgKg6HX7//LGRrUD97CctBPhdyzV/9EeFTiygxk=;
 b=gMCyNTTL33kI18vJdBqOu9Mcm2fImvGdxj+ka3vkQktHDiY/CK6mvTSSga/VonfgCK
 G2yDrY4zAQ73dGXaCnliYP1Sy/I4SgZ0iyzTWjhjjHSEigW4fxdNA2tP2Wf0uxbksfhX
 cBHCROmEIoL5iGVlxzgLAUEjeRiwP80HJL4kjIiu0Ul8xGUMQGmqpnFWq7dE7QrLdKSO
 69iqyiKk38F14+E73N4tvDHBGN2U4xpNoI5fXGuTfLl7tLH4+PRaN5ohLpVXe45yFSXv
 GER/mPzklCwMsqFB3YjPtmkoDrHVR4kVx5qMb1cFyLLTHiTjMubqehbQDnte90iuhh6h
 Bb1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=ouz4DgKg6HX7//LGRrUD97CctBPhdyzV/9EeFTiygxk=;
 b=6Py7VJqFo8OAs5zzV0NGZVTTdd1MvGllr5UvgRrAuIl/Xf6aICmAZ7ETXc5yqn3WOV
 ZCHsl0NUVy9ZMdV7PgTWZezbQrIzIp3s0c2HuDoq00pXx4ttwu1vqmI/ok7HyARwOQaR
 3U5Sd7XoStaUlPojOgWH7nrPpE+D5TAazozizXE8Kpfxff1cXC1XMkfwQ1s9RhlNokY5
 DWmXRx53p/sKoiJjMxNc1Z9cp/XF/wIal44PMiQMT2JmPxczhZ/UyEdvSihwpWC5GzK1
 k0MVPA8fLITsRErw6AykWH4AL6CsS1qTYGuP9mwR+om+p+ucbRFlwGHm6RrO5vY5CCEF
 504A==
X-Gm-Message-State: AOAM5316O60i7HtQhg7ZWPV0+ZLRLQrNXUlfpe7ap7lSRcpPQothKsGm
 QQajmIQyLCUIma6syMv/89SPvQ==
X-Google-Smtp-Source: ABdhPJwyfNEEO9oK4pBktYn2c0uxMeRu2wWbIGD1BpxdATL+9+KfkFN82SS1+bpSVF2rQMXvUC8AAw==
X-Received: by 2002:a63:6a88:0:b0:398:54fb:85ba with SMTP id
 f130-20020a636a88000000b0039854fb85bamr5311202pgc.88.1650005132521; 
 Thu, 14 Apr 2022 23:45:32 -0700 (PDT)
Received: from always-x1.bytedance.net ([61.120.150.70])
 by smtp.gmail.com with ESMTPSA id
 d8-20020a056a00198800b004fab740dbe6sm1867385pfl.15.2022.04.14.23.45.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 Apr 2022 23:45:32 -0700 (PDT)
From: zhenwei pi <pizhenwei@bytedance.com>
To: arei.gonglei@huawei.com,
	mst@redhat.com
Subject: [PATCH 4/4] virtio-crypto: enable retry for virtio-crypto-dev
Date: Fri, 15 Apr 2022 14:41:36 +0800
Message-Id: <20220415064136.304661-5-pizhenwei@bytedance.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220415064136.304661-1-pizhenwei@bytedance.com>
References: <20220415064136.304661-1-pizhenwei@bytedance.com>
MIME-Version: 1.0
Cc: helei.sig11@bytedance.com, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, linux-crypto@vger.kernel.org,
 davem@davemloft.net, herbert@gondor.apana.org.au
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

From: lei he <helei.sig11@bytedance.com>

Enable retry for virtio-crypto-dev, so that crypto-engine
can process cipher-requests parallelly.

Signed-off-by: lei he <helei.sig11@bytedance.com>
---
 drivers/crypto/virtio/virtio_crypto_core.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/crypto/virtio/virtio_crypto_core.c b/drivers/crypto/virtio/virtio_crypto_core.c
index d8edefcb966c..5c0d68c9e894 100644
--- a/drivers/crypto/virtio/virtio_crypto_core.c
+++ b/drivers/crypto/virtio/virtio_crypto_core.c
@@ -62,7 +62,8 @@ static int virtcrypto_find_vqs(struct virtio_crypto *vi)
 		spin_lock_init(&vi->data_vq[i].lock);
 		vi->data_vq[i].vq = vqs[i];
 		/* Initialize crypto engine */
-		vi->data_vq[i].engine = crypto_engine_alloc_init(dev, 1);
+		vi->data_vq[i].engine = crypto_engine_alloc_init_and_set(dev, true, NULL, 1,
+						virtqueue_get_vring_size(vqs[i]));
 		if (!vi->data_vq[i].engine) {
 			ret = -ENOMEM;
 			goto err_engine;
-- 
2.20.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
