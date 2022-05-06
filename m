Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 752C8C433EF
	for <virtualization@archiver.kernel.org>; Fri,  6 May 2022 13:21:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 3CA0983FEE;
	Fri,  6 May 2022 13:21:22 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id JWR4QlABLCuq; Fri,  6 May 2022 13:21:21 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id CFDD88409E;
	Fri,  6 May 2022 13:21:20 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 792F4C0082;
	Fri,  6 May 2022 13:21:20 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0737DC002D
 for <virtualization@lists.linux-foundation.org>;
 Fri,  6 May 2022 13:21:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id DB96140C1C
 for <virtualization@lists.linux-foundation.org>;
 Fri,  6 May 2022 13:21:18 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=bytedance-com.20210112.gappssmtp.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id T51sXiA_SLXj
 for <virtualization@lists.linux-foundation.org>;
 Fri,  6 May 2022 13:21:18 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com
 [IPv6:2607:f8b0:4864:20::629])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 630C440025
 for <virtualization@lists.linux-foundation.org>;
 Fri,  6 May 2022 13:21:18 +0000 (UTC)
Received: by mail-pl1-x629.google.com with SMTP id j14so7420546plx.3
 for <virtualization@lists.linux-foundation.org>;
 Fri, 06 May 2022 06:21:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance-com.20210112.gappssmtp.com; s=20210112;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=snAq8vOceBJQXNtHaQrKZKIzrWkN2Ytbsg/b/TMNKmk=;
 b=RcbJboymTfiVvIkRHCgMojUfl9bLvh+A2nG+XBtgmx0u4q3MuN7jucM7/yuVKMzlwh
 UnMU2h/tV8bvG7ApiCvCmir6sodCeLyONGmHHscGkU0RofG2yjBLERzmHarv3zKNdn3c
 W1qDNbeb8vuDdLXbyGwpLxh4as5TGCG+DtP5oGtMuiJwcz9+Ocnj6sZ9xOBb211wgbSW
 lsRhEZHd8CZ93wsB7gNlHbWHuwdNKtEIzUYtmdB/cxqBRweoDwfSlHs4aj/ZF7ZTmad+
 TDCC2YheRyFnYFVnvg1YVHCxdu5HESG/g1d4BiK1Ixu56OjuAOLXVlpoBk9MzY19DPQI
 qzKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=snAq8vOceBJQXNtHaQrKZKIzrWkN2Ytbsg/b/TMNKmk=;
 b=vT3U9iAPE24bsfcIxMUDtFgkanDWas70mV8lESsHexDQQSgoR5TKrKTGGDKV07ECah
 TJ3EB+svCD1dmfhcE4pI3JK0wcWxEIBmBL3FZ9XvFOzHiVQq4nFC/FavTGzFecjcfK1c
 IqK7UiD0qLC+wmuW1Ss98hoD7iWKJbRC3s+y2uqfWl0M9WP7GvK2POH1A6aEOUZdEq7B
 pdwVdcJcGjeXpYJjHNY1ybB0W3IZ+7ImglQeW3KcbFpbopldeygl1SAG3wL9Vn8K3rIZ
 R8jazb1jlTB/CfOpsz3sp+IJa+6v1YxvAPkmgRICBuONX9TnE2CqVzZ3iIK/UZfLcvPd
 +eVg==
X-Gm-Message-State: AOAM531L+iGvO5ZKcZ2K6RueAalUuYkqsIFVJ5YnkGpa0CjiWNzdIPxC
 ZFkGCJfjPs2nhGcqq8aRdoPkRA==
X-Google-Smtp-Source: ABdhPJyFm1OdK877ATfQ8sTTUFDzZf6kwJX19vO8QKfl9vfzuJo5UneDBXKKQgQprvUGJ1o25mQvVQ==
X-Received: by 2002:a17:902:8605:b0:15d:10dc:1c6f with SMTP id
 f5-20020a170902860500b0015d10dc1c6fmr3781372plo.4.1651843277875; 
 Fri, 06 May 2022 06:21:17 -0700 (PDT)
Received: from always-x1.www.tendawifi.com ([139.177.225.255])
 by smtp.gmail.com with ESMTPSA id
 i22-20020a63e916000000b003c14af50643sm3256986pgh.91.2022.05.06.06.21.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 May 2022 06:21:17 -0700 (PDT)
From: zhenwei pi <pizhenwei@bytedance.com>
To: arei.gonglei@huawei.com,
	mst@redhat.com
Subject: [PATCH v6 5/5] virtio-crypto: enable retry for virtio-crypto-dev
Date: Fri,  6 May 2022 21:16:27 +0800
Message-Id: <20220506131627.180784-6-pizhenwei@bytedance.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220506131627.180784-1-pizhenwei@bytedance.com>
References: <20220506131627.180784-1-pizhenwei@bytedance.com>
MIME-Version: 1.0
Cc: helei.sig11@bytedance.com, linux-kernel@vger.kernel.org,
 pizhenwei@bytedance.com, virtualization@lists.linux-foundation.org,
 linux-crypto@vger.kernel.org, davem@davemloft.net, herbert@gondor.apana.org.au
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

Cc: Michael S. Tsirkin <mst@redhat.com>
Cc: Jason Wang <jasowang@redhat.com>
Cc: Gonglei <arei.gonglei@huawei.com>
Reviewed-by: Gonglei <arei.gonglei@huawei.com>
Signed-off-by: lei he <helei.sig11@bytedance.com>
Signed-off-by: zhenwei pi <pizhenwei@bytedance.com>
---
 drivers/crypto/virtio/virtio_crypto_core.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/crypto/virtio/virtio_crypto_core.c b/drivers/crypto/virtio/virtio_crypto_core.c
index 60490ffa3df1..1198bd306365 100644
--- a/drivers/crypto/virtio/virtio_crypto_core.c
+++ b/drivers/crypto/virtio/virtio_crypto_core.c
@@ -144,7 +144,8 @@ static int virtcrypto_find_vqs(struct virtio_crypto *vi)
 		spin_lock_init(&vi->data_vq[i].lock);
 		vi->data_vq[i].vq = vqs[i];
 		/* Initialize crypto engine */
-		vi->data_vq[i].engine = crypto_engine_alloc_init(dev, 1);
+		vi->data_vq[i].engine = crypto_engine_alloc_init_and_set(dev, true, NULL, true,
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
