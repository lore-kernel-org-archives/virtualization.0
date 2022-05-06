Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E67D1C433EF
	for <virtualization@archiver.kernel.org>; Fri,  6 May 2022 13:21:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 95D7540BD0;
	Fri,  6 May 2022 13:21:17 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 7acABmiV28TY; Fri,  6 May 2022 13:21:16 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 3CD7C40C1A;
	Fri,  6 May 2022 13:21:16 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 0C19CC0039;
	Fri,  6 May 2022 13:21:16 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 8EC54C002D
 for <virtualization@lists.linux-foundation.org>;
 Fri,  6 May 2022 13:21:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 7C98B8409D
 for <virtualization@lists.linux-foundation.org>;
 Fri,  6 May 2022 13:21:14 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=bytedance-com.20210112.gappssmtp.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id JmIW4doFGfH5
 for <virtualization@lists.linux-foundation.org>;
 Fri,  6 May 2022 13:21:14 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com
 [IPv6:2607:f8b0:4864:20::1035])
 by smtp1.osuosl.org (Postfix) with ESMTPS id F03248409B
 for <virtualization@lists.linux-foundation.org>;
 Fri,  6 May 2022 13:21:13 +0000 (UTC)
Received: by mail-pj1-x1035.google.com with SMTP id
 w5-20020a17090aaf8500b001d74c754128so10844771pjq.0
 for <virtualization@lists.linux-foundation.org>;
 Fri, 06 May 2022 06:21:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance-com.20210112.gappssmtp.com; s=20210112;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=5edDtm3ClDj2Ih4shfC7v+UW75qeVSKJFNdIatinSe4=;
 b=Uk0uXOW5WRqRK2VTpgFyRJQIfmCllW+gzKZ2xs8e38Byyi/sOBdnh8zgRA2lcnrGCp
 MbpJ6070kITrxcF0rmmRClG32eCpQhdvZnLOw7NLyTPxN17z9kfcUDGoISZ+d6HUt5GC
 GVJC143IRGMeIeiMMdCszdGtCr5lKVFZAUq5kJjXPyWZJcE/9kdtn0fobMio59+w9sa2
 V/jA6HOPPwfzAulbD2NmBLMojuItt8BegWaY3H53J4ZqG4FkyZNtgmc4blc4AX3OYc9I
 JFHSNhwzkd2cerBOdCNcSJ/O1sx3tYQCe2VhoYJcoIR2cwtxRpscHgemetzFMfVdAioF
 n3kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=5edDtm3ClDj2Ih4shfC7v+UW75qeVSKJFNdIatinSe4=;
 b=dMzn5VDxeTBjw6aNEfC8bDWeHyq5keJlC8EmRqZ4WnsQwPFMSheSB2RnyWDngy2eOl
 jwKO9ieM2wWzN+dn3JUs/qmvCPmesWVoV8w/pnsWmlzj/ty/X+G1H/71Mw+Oau7rLq2T
 8pV8iMTkOIHb44oLSLLBRuja7tmniC44J2eG38IMj0CR7LUFR157NRkW1OsiS3LIQmTc
 OGBfs8jUDloUZ/XVlF3SNH37Ii6/CJ4JfdC4XrnSHCj4YuMdCMnmtY2W7O8E72XfyCWn
 a8RNmPJpE8rvf6hRQK9Z7K8YaZufFM9c76HOoSn3si5jugISQd7VihRfsUggqzzJZ79e
 pXQA==
X-Gm-Message-State: AOAM530tjfv5erXGP2flSTToHu7tiTGVBZRXZexQRq9Wrez9kbRkJ/jC
 m5gURECbSQBQ5pyLJulUaZmVQg==
X-Google-Smtp-Source: ABdhPJwmOLNxQkSjP7G9cCAfAFBzJustpWCljWo7emBIKpuY9vdl/bdTDNTkpES1Me8znMuFza7RlQ==
X-Received: by 2002:a17:90b:1c04:b0:1dc:4dfd:5a43 with SMTP id
 oc4-20020a17090b1c0400b001dc4dfd5a43mr12535457pjb.160.1651843273430; 
 Fri, 06 May 2022 06:21:13 -0700 (PDT)
Received: from always-x1.www.tendawifi.com ([139.177.225.255])
 by smtp.gmail.com with ESMTPSA id
 i22-20020a63e916000000b003c14af50643sm3256986pgh.91.2022.05.06.06.21.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 May 2022 06:21:12 -0700 (PDT)
From: zhenwei pi <pizhenwei@bytedance.com>
To: arei.gonglei@huawei.com,
	mst@redhat.com
Subject: [PATCH v6 4/5] virtio-crypto: adjust dst_len at ops callback
Date: Fri,  6 May 2022 21:16:26 +0800
Message-Id: <20220506131627.180784-5-pizhenwei@bytedance.com>
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

For some akcipher operations(eg, decryption of pkcs1pad(rsa)),
the length of returned result maybe less than akcipher_req->dst_len,
we need to recalculate the actual dst_len through the virt-queue
protocol.

Cc: Michael S. Tsirkin <mst@redhat.com>
Cc: Jason Wang <jasowang@redhat.com>
Cc: Gonglei <arei.gonglei@huawei.com>
Reviewed-by: Gonglei <arei.gonglei@huawei.com>
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
