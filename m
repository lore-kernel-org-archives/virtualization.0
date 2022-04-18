Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B173C433F5
	for <virtualization@archiver.kernel.org>; Mon, 18 Apr 2022 09:04:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id C5715400C6;
	Mon, 18 Apr 2022 09:04:47 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Symm7C9hSG2C; Mon, 18 Apr 2022 09:04:46 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 4C74940FFD;
	Mon, 18 Apr 2022 09:04:46 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 171EBC002F;
	Mon, 18 Apr 2022 09:04:46 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 2FDFCC002C
 for <virtualization@lists.linux-foundation.org>;
 Mon, 18 Apr 2022 09:04:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 1BE3C61214
 for <virtualization@lists.linux-foundation.org>;
 Mon, 18 Apr 2022 09:04:45 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=bytedance-com.20210112.gappssmtp.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id fSyRHAGoiGg0
 for <virtualization@lists.linux-foundation.org>;
 Mon, 18 Apr 2022 09:04:44 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com
 [IPv6:2607:f8b0:4864:20::631])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 4B29A60B03
 for <virtualization@lists.linux-foundation.org>;
 Mon, 18 Apr 2022 09:04:44 +0000 (UTC)
Received: by mail-pl1-x631.google.com with SMTP id be5so11841200plb.13
 for <virtualization@lists.linux-foundation.org>;
 Mon, 18 Apr 2022 02:04:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance-com.20210112.gappssmtp.com; s=20210112;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=qGycGFvEc/grEUwBLjN4FrsuSMK10Ph1TJa/0rHLB00=;
 b=SyqgyxdXATvl1tqV7yph+r4Ov29FnV+LuEYRD3cNUQbaEnKLSOmMXI7R9KN2yxV6OR
 LjumbVKsA9Bzn676oEXHvjHFXu1CDjVvtFd6wJxz/NOtDrfukBxwmRP2wwHWScH+hGgh
 hbWTgSDqaLGqkLhNPNYBZNqiR2ZnSJ5R3Mft1zvXK05rWjuGXmJMH3srjGuX4D834G/E
 YrASL7u82Pj5BEv1wNW/7TMbIO+uC9JFCvPe6cwD0wYb9NXyFVAw20WUL8v7oQrlwg+y
 ZoF45RADFCEW+dDKIM+plRx6Bloo7DSGc6vK6v/Ckv2g3S++SN80sfYi5E0N+MDY4bSi
 SKsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=qGycGFvEc/grEUwBLjN4FrsuSMK10Ph1TJa/0rHLB00=;
 b=n1IU4QIOZV7LPjqcp7QVKZOJMvz5CL+1YxbutouMxyyY9ODzLbTismiUig59qBjuFj
 HgjuDtYtL79ON9DGiF3yMz+IsmbPtJ3sLNXIkyTRGEsUdPyjURZYPcxphAOo1Oexgj2W
 1FnKqjRm8WHBoVJDOZOl5P2BgchMg64ny0epnFvLUTctfvUhXqSMPZ0lhhrR447c5Vml
 4nXx8B8sxSld9TKoOOHVnCZcIOP1x2R1p5aLvQV++LiV3HpdvLO+sc7QK1SMbChWOMEW
 4DbJgtLtWS9jW3xBw1hBCgSHCou8MnTDmpZUD8knZ1HReoLtmFl42Hg6aUEdGPVtbXDV
 Tf/w==
X-Gm-Message-State: AOAM530MV+UktYCxtWSjZyP+sZxJ9B0PGStwwFrse4n5E5cchyzHby7A
 upXp0hdgFmEWNOe21/pPnldTX2VN55fv1w==
X-Google-Smtp-Source: ABdhPJzl0keGE9CDZ9JEYQSKw/oJDMmcnJw0PJyud+pyqmk6lmwwYeDI+kw+cMA+ac6eAWEccD+O7g==
X-Received: by 2002:a17:903:40ce:b0:158:8178:8563 with SMTP id
 t14-20020a17090340ce00b0015881788563mr9800299pld.167.1650272683819; 
 Mon, 18 Apr 2022 02:04:43 -0700 (PDT)
Received: from always-x1.bytedance.net ([61.120.150.70])
 by smtp.gmail.com with ESMTPSA id
 m21-20020a17090a7f9500b001c97c6bcaf4sm16408071pjl.39.2022.04.18.02.04.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 18 Apr 2022 02:04:43 -0700 (PDT)
From: zhenwei pi <pizhenwei@bytedance.com>
To: arei.gonglei@huawei.com,
	mst@redhat.com
Subject: [PATCH v2 3/4] virtio-crypto: adjust dst_len at ops callback
Date: Mon, 18 Apr 2022 17:00:50 +0800
Message-Id: <20220418090051.372803-4-pizhenwei@bytedance.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220418090051.372803-1-pizhenwei@bytedance.com>
References: <20220418090051.372803-1-pizhenwei@bytedance.com>
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
index 9561bc2df62b..82db86e088c2 100644
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
