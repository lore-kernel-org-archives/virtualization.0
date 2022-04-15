Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA278C433EF
	for <virtualization@archiver.kernel.org>; Fri, 15 Apr 2022 06:45:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 89E928412F;
	Fri, 15 Apr 2022 06:45:31 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id MtGfHX6-JGYm; Fri, 15 Apr 2022 06:45:30 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 3BFF584120;
	Fri, 15 Apr 2022 06:45:30 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 23F8DC002F;
	Fri, 15 Apr 2022 06:45:30 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 554D4C002C
 for <virtualization@lists.linux-foundation.org>;
 Fri, 15 Apr 2022 06:45:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 33E7F40598
 for <virtualization@lists.linux-foundation.org>;
 Fri, 15 Apr 2022 06:45:29 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=bytedance-com.20210112.gappssmtp.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 7fNF4rBerOdd
 for <virtualization@lists.linux-foundation.org>;
 Fri, 15 Apr 2022 06:45:28 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com
 [IPv6:2607:f8b0:4864:20::629])
 by smtp2.osuosl.org (Postfix) with ESMTPS id AD6EB40BB8
 for <virtualization@lists.linux-foundation.org>;
 Fri, 15 Apr 2022 06:45:28 +0000 (UTC)
Received: by mail-pl1-x629.google.com with SMTP id y6so6502120plg.2
 for <virtualization@lists.linux-foundation.org>;
 Thu, 14 Apr 2022 23:45:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance-com.20210112.gappssmtp.com; s=20210112;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=eUPRo1W7HXTqRUmuszkjpWErgWaPyulrOyER93ew8mA=;
 b=2okK/vk4qQTljwBk1QYv8jssjKnLC1JWY6AXCN8hrTti/FJJ9mD+eNzxXeBbs+jshV
 AWEUMm0LmqJSBH/7058T7s6qFIKwViTM9mC5t3WNsTLJD21HO2MayRpqye5vrVeHx2Fk
 p1KyRNx72f3Lx/Q8nz+f2wJsYzFgsckeQXIMFOAZ+Pgb2CGZwskKTyUucasgjjisAtA7
 nxrk5PcUU0vN7wVsPu9vyZaarfvQO1dgcjhd5A3mxbr//0sV6vCZjwfbj/DzB7p7cbfN
 OH7l0ZGqqMf/TwdXfQKp8ots3JjEDr07bevn8Yh4I5I+nielXDSLVPOXLwupIMlP/RZ0
 9TQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=eUPRo1W7HXTqRUmuszkjpWErgWaPyulrOyER93ew8mA=;
 b=Os/7kjiMI+eOntB61xiyS339k3IWbm+eTyS4VZXEhH9y8gq0hqdwm5WNfrTD/lfgTr
 RBKo5rMhPUms7odJAUpAns2HK6AyuqHLp0DUx2HwLQr6SzQd9D83XMpGqIl2v6TsKnum
 D/1aNK51zYZYamS9X5kFUlrVn3Uj5LnUQau5qJ5CdgOz5AvlA7d/CgDkYvaBOvcsOFvQ
 CbHAfAyIqSRvfK+MV0moARu3P/jOHgGuHxarrdoKowYYkn0V0TBP1KyMGsOP8wI4iiLQ
 +AVFzUdLcJuWpTLRT5McabVjrbsmh4X7s/bHLOdB2VEe5EOB7GlwmhUjjlZ0LlPhMPeG
 qWWg==
X-Gm-Message-State: AOAM530GWIvWa1OkPKo1WNn3Q1xt/4xtksoUmYiheETKsbvF5Ghthh6F
 +2C7V7zDfoC6ZLYW+AqBwcL8NQ==
X-Google-Smtp-Source: ABdhPJxcShAeTRpf1TUgLEfubOBQZZ90/nwfksxqrBB43jrycMr1mv1lYJHhKntT+PHRDW956nfgSA==
X-Received: by 2002:a17:902:b10f:b0:156:612f:318d with SMTP id
 q15-20020a170902b10f00b00156612f318dmr50126545plr.143.1650005128147; 
 Thu, 14 Apr 2022 23:45:28 -0700 (PDT)
Received: from always-x1.bytedance.net ([61.120.150.70])
 by smtp.gmail.com with ESMTPSA id
 d8-20020a056a00198800b004fab740dbe6sm1867385pfl.15.2022.04.14.23.45.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 Apr 2022 23:45:27 -0700 (PDT)
From: zhenwei pi <pizhenwei@bytedance.com>
To: arei.gonglei@huawei.com,
	mst@redhat.com
Subject: [PATCH 3/4] virtio-crypto: adjust dst_len at ops callback
Date: Fri, 15 Apr 2022 14:41:35 +0800
Message-Id: <20220415064136.304661-4-pizhenwei@bytedance.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220415064136.304661-1-pizhenwei@bytedance.com>
References: <20220415064136.304661-1-pizhenwei@bytedance.com>
MIME-Version: 1.0
Cc: lei he <helei@bytedance.com>, helei.sig11@bytedance.com,
 linux-kernel@vger.kernel.org, zhenwei pi <pizhenwei@bytedance.com>,
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

From: lei he <helei@bytedance.com>

For some akcipher operations(eg, decryption of pkcs1pad(rsa)),
the length of returned result maybe less than akcipher_req->dst_len,
we need to recalculate the actual dst_len through the virt-queue
protocol.

Signed-off-by: lei he <helei@bytedance.com>
Signed-off-by: zhenwei pi <pizhenwei@bytedance.com>
---
 drivers/crypto/virtio/virtio_crypto_akcipher_algs.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/crypto/virtio/virtio_crypto_akcipher_algs.c b/drivers/crypto/virtio/virtio_crypto_akcipher_algs.c
index bf7c1aa4be37..7cd932c2d9ee 100644
--- a/drivers/crypto/virtio/virtio_crypto_akcipher_algs.c
+++ b/drivers/crypto/virtio/virtio_crypto_akcipher_algs.c
@@ -90,9 +90,12 @@ static void virtio_crypto_dataq_akcipher_callback(struct virtio_crypto_request *
 	}
 
 	akcipher_req = vc_akcipher_req->akcipher_req;
-	if (vc_akcipher_req->opcode != VIRTIO_CRYPTO_AKCIPHER_VERIFY)
+	if (vc_akcipher_req->opcode != VIRTIO_CRYPTO_AKCIPHER_VERIFY) {
+		/* actuall length maybe less than dst buffer */
+		akcipher_req->dst_len = len - sizeof(vc_req->status);
 		sg_copy_from_buffer(akcipher_req->dst, sg_nents(akcipher_req->dst),
 				    vc_akcipher_req->dst_buf, akcipher_req->dst_len);
+	}
 	virtio_crypto_akcipher_finalize_req(vc_akcipher_req, akcipher_req, error);
 }
 
-- 
2.20.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
