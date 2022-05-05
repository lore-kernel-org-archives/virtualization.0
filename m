Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95E44C433F5
	for <virtualization@archiver.kernel.org>; Thu,  5 May 2022 09:28:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 548EE60D59;
	Thu,  5 May 2022 09:28:29 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id njgYOr5FcLZ1; Thu,  5 May 2022 09:28:28 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 04F4160B48;
	Thu,  5 May 2022 09:28:27 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D2E8AC0032;
	Thu,  5 May 2022 09:28:27 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id BA487C002D
 for <virtualization@lists.linux-foundation.org>;
 Thu,  5 May 2022 09:28:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 9BB6382909
 for <virtualization@lists.linux-foundation.org>;
 Thu,  5 May 2022 09:28:26 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=bytedance-com.20210112.gappssmtp.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id FbvzuZmk_AcR
 for <virtualization@lists.linux-foundation.org>;
 Thu,  5 May 2022 09:28:24 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com
 [IPv6:2607:f8b0:4864:20::532])
 by smtp1.osuosl.org (Postfix) with ESMTPS id C373C83F3C
 for <virtualization@lists.linux-foundation.org>;
 Thu,  5 May 2022 09:28:24 +0000 (UTC)
Received: by mail-pg1-x532.google.com with SMTP id v10so3198443pgl.11
 for <virtualization@lists.linux-foundation.org>;
 Thu, 05 May 2022 02:28:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance-com.20210112.gappssmtp.com; s=20210112;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=MWUmfRvGF2BB+VZsTwGLae04hlnLvJ88GBm4mvPdVfY=;
 b=H6GLIk6bwodWrBOYEDm4+3SJj4/BTDn+p3oSwWbxAEs9y8gq3fek8GOJlclMDdwUiv
 dHCe0nAEw4q60SaI6Vv69CYld5DHxwZSv1FTzqAUDuUvgWdtnsTq1bAWD7Rn/HJ9a65K
 MmWUiUEDQVYmZAMyzpzWK8VaqlxJ7HqHCyFFf5L8Plp4mUb5e3sOgAFADcTR/UxPEUvH
 rTgsGzYxMrdowQPHybdiBUZho2Kin9IpZLk7nE8sbllOLvFhPVlQ2SxocQd0wQ8HmulW
 61sQcCyCwlrSToHRrP8m9cP9k4vziMrARbTX2DIG1E39DPCD6eQ7KcerTR0hDdc7McPw
 w7BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=MWUmfRvGF2BB+VZsTwGLae04hlnLvJ88GBm4mvPdVfY=;
 b=Vhi1g2rI1O08ZnUytEJ78hPGj7Z0zCMQtI3N1d66nGv9hlOXg0qHKZUQyQyb+r6qU2
 ptIuCYgHMa8yH2QkZQSXR0JWTCLTUoY4BdWiAtjEEqkGwqb/BGw4KXSNGB/sqySKG1sw
 U4oZQDR8XtOxgbJ1Se9ZQJ8fMrENirP+yA0G/LjvGcFblFD/DINxPFo2KcAU5rGEj2Dh
 S95BJIlntnxhGQUFG6aHq4Ee2DOB+Wp1js1KLlm3aE+3fglXUrlMm6zJ9kRHAzOgnbL5
 PS4X8naVtF75gw+Weilmqc0z9DryXHWsQ27+xwdh0VXkP1R2zMkZ+0ApblIGmoRolptW
 NW6w==
X-Gm-Message-State: AOAM531uIisQ2exY+7UgyLub9vcNU7Yo/rAKjEOXgWum17rcBqX8Ia2/
 +vl/qdmTvHpJbnCao3kbNLbbHA==
X-Google-Smtp-Source: ABdhPJy0arwU8vCS8L/uqGSWrM7EpznmQ61YconxXJuGXjqJbFk5NzLR7b0Un/RvHp3HP83OWpdBFw==
X-Received: by 2002:a05:6a00:22c6:b0:510:3c78:638d with SMTP id
 f6-20020a056a0022c600b005103c78638dmr7293480pfj.54.1651742904156; 
 Thu, 05 May 2022 02:28:24 -0700 (PDT)
Received: from always-x1.www.tendawifi.com ([139.177.225.255])
 by smtp.gmail.com with ESMTPSA id
 t68-20020a625f47000000b0050dc76281dcsm884224pfb.182.2022.05.05.02.28.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 May 2022 02:28:23 -0700 (PDT)
From: zhenwei pi <pizhenwei@bytedance.com>
To: arei.gonglei@huawei.com,
	mst@redhat.com
Subject: [PATCH v5 4/5] virtio-crypto: adjust dst_len at ops callback
Date: Thu,  5 May 2022 17:24:07 +0800
Message-Id: <20220505092408.53692-5-pizhenwei@bytedance.com>
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

For some akcipher operations(eg, decryption of pkcs1pad(rsa)),
the length of returned result maybe less than akcipher_req->dst_len,
we need to recalculate the actual dst_len through the virt-queue
protocol.

Cc: Michael S. Tsirkin <mst@redhat.com>
Cc: Jason Wang <jasowang@redhat.com>
Cc: Gonglei <arei.gonglei@huawei.com>
Signed-off-by: lei he <helei.sig11@bytedance.com>
Signed-off-by: zhenwei pi <pizhenwei@bytedance.com>
---
 drivers/crypto/virtio/virtio_crypto_akcipher_algs.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/crypto/virtio/virtio_crypto_akcipher_algs.c b/drivers/crypto/virtio/virtio_crypto_akcipher_algs.c
index 382ccec9ab12..2a60d0525cde 100644
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
