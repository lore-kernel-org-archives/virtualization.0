Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF180C433F5
	for <virtualization@archiver.kernel.org>; Sun, 24 Apr 2022 10:45:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 6D60581B60;
	Sun, 24 Apr 2022 10:45:58 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ALLQg6KEiI5s; Sun, 24 Apr 2022 10:45:57 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 081FB81B98;
	Sun, 24 Apr 2022 10:45:56 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id CF7A5C0039;
	Sun, 24 Apr 2022 10:45:56 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 7C286C002D
 for <virtualization@lists.linux-foundation.org>;
 Sun, 24 Apr 2022 10:45:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 5C184415E6
 for <virtualization@lists.linux-foundation.org>;
 Sun, 24 Apr 2022 10:45:55 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=bytedance-com.20210112.gappssmtp.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id X6Pecq1GafWd
 for <virtualization@lists.linux-foundation.org>;
 Sun, 24 Apr 2022 10:45:54 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com
 [IPv6:2607:f8b0:4864:20::42d])
 by smtp4.osuosl.org (Postfix) with ESMTPS id B77F441673
 for <virtualization@lists.linux-foundation.org>;
 Sun, 24 Apr 2022 10:45:54 +0000 (UTC)
Received: by mail-pf1-x42d.google.com with SMTP id i24so12243116pfa.7
 for <virtualization@lists.linux-foundation.org>;
 Sun, 24 Apr 2022 03:45:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance-com.20210112.gappssmtp.com; s=20210112;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=px4I+RzeTWMMtdZKLYUD3e7jp1xURuzvNJsO7o4S7ms=;
 b=FGf98dBpvjagNdKAx1gz/khVHlDbxcMtXIymcpOlEQTvZ7bDLmKT4Am04RCOVey8Vt
 ieGah75ezFTyLKCImJc/u1A+PEJXMcGbrz5onNQN0C9vxShlPewcKN/5Ryd1YXtSvtIa
 NbsMhtvFrK6Pb855hBBaau4Z+Pwtyom6hj4VMqBa7wWsKrEEc4mw+ACkPzUoN5nGN8aR
 HIG/MNh++NR7fj1uegbKiu5GlAsttsouG6C0RMx8eb9QqW6Zm3lFD010+iPRoOIkDRZZ
 v8LTF+Q1IkD4In2BRjHr/E3Kqm1MOKQiJTTwbuuwjoBldmWmgQMOYfVCoWcTvPyzq/Bo
 vvrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=px4I+RzeTWMMtdZKLYUD3e7jp1xURuzvNJsO7o4S7ms=;
 b=DrqBC/18O3Poj92BAeobwnNzfaT7zGCbdNrzfzUmhCDZwx/xGquhpBn1kmpVDVAyka
 YuyPZ2Vl2zC5c3VipFK4t7iA43fZI1//GeDZnqwJVPbAtwG6qNLw53TfmFRi9+x5CjkF
 rJA56g0eZbV+YwqyYOZMYm8KoM4GG9ha8ZllIcIIe+BFRltPyYRzNtvKO1O20swCsOwk
 26zUDoDeyuWSz5HblsWuJU8m2KSOEEV9g+1BKIpmz6tEFaWUgnISEPBOBwYtMn4XnYme
 FjdxepBDKIn62FJIvV3Uy8Bgn++HYlJzx6L902e6apDCtCRZ8WjrpLi0YClgsL/lGe+n
 7Ljw==
X-Gm-Message-State: AOAM532wJpcMsG92JBj7NmLjz4MhpHPz+9LiwPWD24pLeQ4SjyhvhmDS
 Om69yPwzzn8uxcTMa7FIeR4XHw==
X-Google-Smtp-Source: ABdhPJwJx/jeBsrcyfzqw3BwOB5hWkRSrCnP2UooawE0svZYmbsKlXo42bKGvoqpZSZOVMWjI3ks0w==
X-Received: by 2002:aa7:9041:0:b0:4fe:3d6c:1739 with SMTP id
 n1-20020aa79041000000b004fe3d6c1739mr13689501pfo.13.1650797154126; 
 Sun, 24 Apr 2022 03:45:54 -0700 (PDT)
Received: from always-x1.bytedance.net ([61.120.150.70])
 by smtp.gmail.com with ESMTPSA id
 y2-20020a056a00190200b004fa865d1fd3sm8287295pfi.86.2022.04.24.03.45.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 24 Apr 2022 03:45:53 -0700 (PDT)
From: zhenwei pi <pizhenwei@bytedance.com>
To: arei.gonglei@huawei.com,
	mst@redhat.com,
	jasowang@redhat.com
Subject: [PATCH v4 4/5] virtio-crypto: adjust dst_len at ops callback
Date: Sun, 24 Apr 2022 18:41:39 +0800
Message-Id: <20220424104140.44841-5-pizhenwei@bytedance.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220424104140.44841-1-pizhenwei@bytedance.com>
References: <20220424104140.44841-1-pizhenwei@bytedance.com>
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
index 1e98502830cf..1892901d2a71 100644
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
