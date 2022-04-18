Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82B56C433F5
	for <virtualization@archiver.kernel.org>; Mon, 18 Apr 2022 09:04:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 2C9A641DE1;
	Mon, 18 Apr 2022 09:04:53 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id KVGAXGTeHbdb; Mon, 18 Apr 2022 09:04:52 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 8BFB841DDF;
	Mon, 18 Apr 2022 09:04:51 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 5A5ABC002F;
	Mon, 18 Apr 2022 09:04:51 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 9AEC7C002C
 for <virtualization@lists.linux-foundation.org>;
 Mon, 18 Apr 2022 09:04:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 8902083F74
 for <virtualization@lists.linux-foundation.org>;
 Mon, 18 Apr 2022 09:04:49 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=bytedance-com.20210112.gappssmtp.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id vmlTarhPJ5Zq
 for <virtualization@lists.linux-foundation.org>;
 Mon, 18 Apr 2022 09:04:49 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com
 [IPv6:2607:f8b0:4864:20::52d])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 1C92383F65
 for <virtualization@lists.linux-foundation.org>;
 Mon, 18 Apr 2022 09:04:49 +0000 (UTC)
Received: by mail-pg1-x52d.google.com with SMTP id u2so17796795pgq.10
 for <virtualization@lists.linux-foundation.org>;
 Mon, 18 Apr 2022 02:04:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance-com.20210112.gappssmtp.com; s=20210112;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=ouz4DgKg6HX7//LGRrUD97CctBPhdyzV/9EeFTiygxk=;
 b=6TWHPFn0LN6u1Gtv/IJ/FZUtIkxZGYRSlYL1xUuSQwz6ytLfUxUHzEhiZogx/oPjrb
 5IOYrTilRPWoHpCRSg3pD9hxYZzJxQhgFu7oMUXgRdkrpSBD8H8p9b2MjNWFFbRV/0fk
 JqtHVC/Atk4oTpbgL809sb6GZ48czjib99D2vLy8PKSaX5Q4H53WLL5nFIul/nggKvzB
 QyCC5TIlf1UwqjmQzzFfYQICmDC+k+WILzeWkCdunjIwypfSFlv0ZFqUS9k7G5oLbxB2
 6oUiQeUOEd1aB+8ADGQyVZYhbF9eyXJK0CCrBZfsSUMAUUktSQsB/HwqoQFmhdVi8f4r
 H9mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=ouz4DgKg6HX7//LGRrUD97CctBPhdyzV/9EeFTiygxk=;
 b=PfLLwu5maOT0BgX3QJr84Ow2e3PuVJdAXyqcisIIfEociV8h86bAb2bYHNCV+9bKnZ
 VLP5JJw1HRJXAOQkFZE/VI3ycq1741L0tkre3ydb4zmGfd25c978+jo4lNYYmqGzbeDY
 x9O8LjyKVqFEULPx/KfYgA5gmN+dQJQUQbdiH9nimLceHwMLxZzaygod4N7D5nSTuvk/
 LbcFU8xBJ3XXcpOea+CXJDRFsEhA6r1EmBdr3vxjrJpTtvPs1Yj2qGDkkcJWo1Og8cBF
 nCWaOXmM7vuazA6ln7Hvx0JWHE/qVJ/wGARMl2QY3fezS7bdC2tHvN4+O8/MtHApNJBz
 aDNg==
X-Gm-Message-State: AOAM530Qnn+rqTGpTx+vmgx3nct5lLZneCUjhucYvy2S2q7HFaHlMt/I
 T6Ybk6vR4oE2AsXfNAuDnM8ctA==
X-Google-Smtp-Source: ABdhPJz7+O43bQjw3Qx8+8pHjS0RYIso9TqOCGaesGbw3hn8vk87HPcB2H/bsqdEGcpfWIhWqakxhg==
X-Received: by 2002:a63:34e:0:b0:39d:8d96:a947 with SMTP id
 75-20020a63034e000000b0039d8d96a947mr9503958pgd.105.1650272688180; 
 Mon, 18 Apr 2022 02:04:48 -0700 (PDT)
Received: from always-x1.bytedance.net ([61.120.150.70])
 by smtp.gmail.com with ESMTPSA id
 m21-20020a17090a7f9500b001c97c6bcaf4sm16408071pjl.39.2022.04.18.02.04.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 18 Apr 2022 02:04:47 -0700 (PDT)
From: zhenwei pi <pizhenwei@bytedance.com>
To: arei.gonglei@huawei.com,
	mst@redhat.com
Subject: [PATCH v2 4/4] virtio-crypto: enable retry for virtio-crypto-dev
Date: Mon, 18 Apr 2022 17:00:51 +0800
Message-Id: <20220418090051.372803-5-pizhenwei@bytedance.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220418090051.372803-1-pizhenwei@bytedance.com>
References: <20220418090051.372803-1-pizhenwei@bytedance.com>
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
