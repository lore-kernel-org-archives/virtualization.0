Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CAE73C433EF
	for <virtualization@archiver.kernel.org>; Thu,  5 May 2022 09:28:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 8713F82909;
	Thu,  5 May 2022 09:28:32 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id KYHqB5p6gD5j; Thu,  5 May 2022 09:28:31 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 356D382919;
	Thu,  5 May 2022 09:28:31 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 0B37BC0032;
	Thu,  5 May 2022 09:28:31 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 251A0C002D
 for <virtualization@lists.linux-foundation.org>;
 Thu,  5 May 2022 09:28:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 1503640A80
 for <virtualization@lists.linux-foundation.org>;
 Thu,  5 May 2022 09:28:30 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=bytedance-com.20210112.gappssmtp.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id oZMSClnfVFGo
 for <virtualization@lists.linux-foundation.org>;
 Thu,  5 May 2022 09:28:29 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com
 [IPv6:2607:f8b0:4864:20::42f])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 90A854060B
 for <virtualization@lists.linux-foundation.org>;
 Thu,  5 May 2022 09:28:29 +0000 (UTC)
Received: by mail-pf1-x42f.google.com with SMTP id j6so3185936pfe.13
 for <virtualization@lists.linux-foundation.org>;
 Thu, 05 May 2022 02:28:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance-com.20210112.gappssmtp.com; s=20210112;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=bhiM3AjN7OQUvaBDZQVzT5dsdkup6eI4sw9Fv5sP5tE=;
 b=7pLxwHXxcvVshGXn4uHVSVCm5smt0n8fUCsFCOFPzxzzbMx9xGwFC8KvsSw5ALEAQc
 YtSU16tQmkLgjSPzKZcLVcI5XY2JX4J8x+8n2BcStEZYz241qYt9POCYXssiCowaOCnD
 SmLvMlcKl5dnebFgxc4xwOxBqQrkvHBeuy5+jj97DytTTQWkKiwnyh3c2mgzF5/fpd0y
 cohIs8wSJ51+B9YoK748fTSvOCWCNBu1kkX9DYjIvItRZSfXb5CnAoy2CObgRC0aE0c0
 sqGBDL8LH/OF01q0pOa86ID9gEQECiLfKxnxDW4tw/9Ra+EJ54XueksS/HRBpCnq/uN5
 MqQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=bhiM3AjN7OQUvaBDZQVzT5dsdkup6eI4sw9Fv5sP5tE=;
 b=mmO661scF/9k9yrAk46/Rmw4Zjx+ITwOfQf2SImtEHCsK/VDeizS74e3Rpsyf2mCBD
 dWAmg/ByFHvibcq7zeGstWEk1AXv/Gqem5+liLXXRz0XTCoQMDKD5P058uEc801ds8gV
 1/NyDRdaAduW39fZF8yHzuNV8GqiUbN1YlA64G8DLMHp0DLY9zDDbRXfgb5bGrFyV4J6
 Sk9hUNH6EFqBAUw/3pETyilSII6tXirs7hPPFAE0Ne+3lz3zLg0bkFYMrZVFEkanaaNb
 NA0fQkOlUBiTiioWVx6dMtoar0DT/GDRGNNRJHIsIxWj5rzp2ATvAf7Ow5xVnXzKd/qf
 uwrQ==
X-Gm-Message-State: AOAM5319JfG7mUtpk3+l+wszilzeBjEbRrHKCw1rKdnpQooPj5YnBAPV
 XFjstfKLjodt+QstLpCys6qUFg==
X-Google-Smtp-Source: ABdhPJxfhS9sNn9cwwCynTPr683iYd3vLNFKRz6cyWRcDnnmWCepvXGvvpQ/wv+sEubyXPwG47WkRw==
X-Received: by 2002:a63:310a:0:b0:3c5:f9ba:b010 with SMTP id
 x10-20020a63310a000000b003c5f9bab010mr4724700pgx.143.1651742909075; 
 Thu, 05 May 2022 02:28:29 -0700 (PDT)
Received: from always-x1.www.tendawifi.com ([139.177.225.255])
 by smtp.gmail.com with ESMTPSA id
 t68-20020a625f47000000b0050dc76281dcsm884224pfb.182.2022.05.05.02.28.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 May 2022 02:28:28 -0700 (PDT)
From: zhenwei pi <pizhenwei@bytedance.com>
To: arei.gonglei@huawei.com,
	mst@redhat.com
Subject: [PATCH v5 5/5] virtio-crypto: enable retry for virtio-crypto-dev
Date: Thu,  5 May 2022 17:24:08 +0800
Message-Id: <20220505092408.53692-6-pizhenwei@bytedance.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220505092408.53692-1-pizhenwei@bytedance.com>
References: <20220505092408.53692-1-pizhenwei@bytedance.com>
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
Signed-off-by: lei he <helei.sig11@bytedance.com>
Signed-off-by: zhenwei pi <pizhenwei@bytedance.com>
---
 drivers/crypto/virtio/virtio_crypto_core.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/crypto/virtio/virtio_crypto_core.c b/drivers/crypto/virtio/virtio_crypto_core.c
index 60490ffa3df1..f67e0d4c1b0c 100644
--- a/drivers/crypto/virtio/virtio_crypto_core.c
+++ b/drivers/crypto/virtio/virtio_crypto_core.c
@@ -144,7 +144,8 @@ static int virtcrypto_find_vqs(struct virtio_crypto *vi)
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
