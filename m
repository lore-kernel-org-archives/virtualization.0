Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28DE2C433F5
	for <virtualization@archiver.kernel.org>; Thu, 21 Apr 2022 10:44:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id DAB996131E;
	Thu, 21 Apr 2022 10:44:26 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 7oTAm4-aSlLX; Thu, 21 Apr 2022 10:44:26 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 7961A6117E;
	Thu, 21 Apr 2022 10:44:25 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 4C58AC0033;
	Thu, 21 Apr 2022 10:44:25 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 953F3C002C
 for <virtualization@lists.linux-foundation.org>;
 Thu, 21 Apr 2022 10:44:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 6DB306117E
 for <virtualization@lists.linux-foundation.org>;
 Thu, 21 Apr 2022 10:44:24 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id xq5-JdVlmvz4
 for <virtualization@lists.linux-foundation.org>;
 Thu, 21 Apr 2022 10:44:23 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com
 [IPv6:2607:f8b0:4864:20::52d])
 by smtp3.osuosl.org (Postfix) with ESMTPS id D2D6361184
 for <virtualization@lists.linux-foundation.org>;
 Thu, 21 Apr 2022 10:44:23 +0000 (UTC)
Received: by mail-pg1-x52d.google.com with SMTP id i63so4288739pge.11
 for <virtualization@lists.linux-foundation.org>;
 Thu, 21 Apr 2022 03:44:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance-com.20210112.gappssmtp.com; s=20210112;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=Vgyphshva4+1MoZbiUZHYBed15/dj2PxkqwfRwCNPpE=;
 b=EfTBFRclrg2OJBpUoWZLcqlhoTqhRPEqclktYCgbN7WckD+ipu67xVjpp/KgX7S3df
 0IajjdCl6lQ4JqNYZ2giw2+aoayfss17DKxqHwh6fCOCKA+6vJXZux5rCgrI/FvsvgZW
 6maMRybm/GRxdmiP7SY1PPpQYHJ3wabRoo8f+BHWM0ec9Z8SSDXgW5f4txOhg+0YNp9e
 igR+AHPtL0BXLeX/E03XpjTxJnzt+JoQtKDa/lJErvLuZ7Mnh2Vs9vvIAggOKq9U4eSY
 xmdDLBRPP7BdgUm0SkYvRhfiNAkFaZkxy2rIWHF7ahWI1j//YJPqwXC44BuF6XA7i7kQ
 FeHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=Vgyphshva4+1MoZbiUZHYBed15/dj2PxkqwfRwCNPpE=;
 b=XZMDVU7U0uKArbz0+6Wk6pLb2kQj7PLEkQUjobGM/bgEsnzRxcmTa4OBESdw73zl21
 fNVppQl9eCGd7kFjAIzk9G6BQb9wJwc/xJHR60a6uYi653jEFEl6AcgUXfCDxGhg+kG9
 7PG1qo1GfMYU/UgicQ8pFx0E1DEDul3k7ZoB4aNtB1cn4lrTdBj0QzaHJCcU1kRgIc1A
 mlQiP55qsIagfy1TgbLgifsrPChKM9PrcuBXGQj3gT2t1C6teui4ewWaFlgDEON+kr3O
 WlwVBa6v7rjoND4Qx4KXYoNChYrHQLZRmS1HbyITnJYdLsfiJw0DIIzwD47z30w/4nhe
 LYxQ==
X-Gm-Message-State: AOAM531htJmBfuPw7aIKQasldIp8TDyS3PYDE1Yz2F0hy9P4L6hZsUA1
 7mbbsUwxK/4KsgIRv34WU3FrwQ==
X-Google-Smtp-Source: ABdhPJyJLS3mZ53Vu2R9I+Mt2sPcqwMG8V444JCZXnqM/k/gHuRh+50aLFK0VyGbedV642Rj9fvPKg==
X-Received: by 2002:a65:6e9a:0:b0:382:1804:35c8 with SMTP id
 bm26-20020a656e9a000000b00382180435c8mr23664506pgb.584.1650537863265; 
 Thu, 21 Apr 2022 03:44:23 -0700 (PDT)
Received: from always-x1.bytedance.net ([61.120.150.69])
 by smtp.gmail.com with ESMTPSA id
 w7-20020aa79547000000b0050ad0e82e6dsm3772485pfq.215.2022.04.21.03.44.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 Apr 2022 03:44:22 -0700 (PDT)
From: zhenwei pi <pizhenwei@bytedance.com>
To: arei.gonglei@huawei.com,
	mst@redhat.com
Subject: [PATCH v3 5/5] virtio-crypto: enable retry for virtio-crypto-dev
Date: Thu, 21 Apr 2022 18:40:16 +0800
Message-Id: <20220421104016.453458-6-pizhenwei@bytedance.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220421104016.453458-1-pizhenwei@bytedance.com>
References: <20220421104016.453458-1-pizhenwei@bytedance.com>
MIME-Version: 1.0
Cc: helei.sig11@bytedance.com, linux-kernel@vger.kernel.org,
 zhenwei pi <pizhenwei@bytedance.com>,
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

Cc: Michael S. Tsirkin <mst@redhat.com>
Cc: Jason Wang <jasowang@redhat.com>
Cc: Gonglei <arei.gonglei@huawei.com>
Signed-off-by: lei he <helei.sig11@bytedance.com>
Signed-off-by: zhenwei pi <pizhenwei@bytedance.com>
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
