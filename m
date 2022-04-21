Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB31DC433EF
	for <virtualization@archiver.kernel.org>; Thu, 21 Apr 2022 10:44:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 7ED7061185;
	Thu, 21 Apr 2022 10:44:22 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ps3Z4f-lStCb; Thu, 21 Apr 2022 10:44:21 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 22FA26117D;
	Thu, 21 Apr 2022 10:44:21 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 01250C0033;
	Thu, 21 Apr 2022 10:44:21 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 57A53C002C
 for <virtualization@lists.linux-foundation.org>;
 Thu, 21 Apr 2022 10:44:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 36D0541B63
 for <virtualization@lists.linux-foundation.org>;
 Thu, 21 Apr 2022 10:44:19 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=bytedance-com.20210112.gappssmtp.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id TIu0AlIdXgNv
 for <virtualization@lists.linux-foundation.org>;
 Thu, 21 Apr 2022 10:44:18 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com
 [IPv6:2607:f8b0:4864:20::102d])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 7DA4841A6B
 for <virtualization@lists.linux-foundation.org>;
 Thu, 21 Apr 2022 10:44:18 +0000 (UTC)
Received: by mail-pj1-x102d.google.com with SMTP id
 w5-20020a17090aaf8500b001d74c754128so149317pjq.0
 for <virtualization@lists.linux-foundation.org>;
 Thu, 21 Apr 2022 03:44:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance-com.20210112.gappssmtp.com; s=20210112;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=6zOuRYVFWDGuC1PrwNUGb6FpSSDkw8m8NU3bhEpx4ck=;
 b=kCpy3srq/EiBanbPyFzUd0w0fdOrd3PL2QHCcbTp7TZh1XfM6gSXBFFrxDXiKzePET
 BwCk62X45XrHU1TRgo+rpF5cPK87lvBqe9Z5X9gX1XXa42IXLMh0wrxSbi/ZzoLCkWyg
 SG7njy+qJTfzPqsl+gQYTHqx+ULb086FwT7Ngo75IOdDDyyoxoL5pgLeUqjDxGNWgG9G
 225aPoSR1vTY6k9fszQ/AZzu6oQaJEoYoAUR+o+wuYp5q30SnukeGjrXpM2hl3VEYIsH
 JgLtg/EZ6VTM4QfR2EGeiOBXfMD7vkr3EurEZ95KVGyPnNSwjYsuJ7l1lwN1LgNM1bFS
 TBag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=6zOuRYVFWDGuC1PrwNUGb6FpSSDkw8m8NU3bhEpx4ck=;
 b=7sqbSkKDUbZfnwdJk/TxIHTwFWKcpyB7ZvAwB4tOLRlvgXLAG2byKQDPghHZ6osfgb
 3uLWoSvsYRO0Gh2WYiHZ1fWqPvqrb0pNFH1ZFcOzba+dhw6rDhNdgkhksaiW7n4PPJix
 w88zdjwAfNdClQROEhh5XJiBRxtprZL9aHcMN9Un8W7GCUxSpROPZgNjUII5IsMULKm3
 Go/92JRwxf4osubw3jwnBxpJobySjxmmfZId1YFpEHJIqbnLgL71BcFJ2vWxhEP3mf/8
 seMJULTpddinC6NM8LMw9nKetulwX8eoOobhGg7ONDFzuqzNuKwCvtdDYnIKD30yY5n3
 Aewg==
X-Gm-Message-State: AOAM532yJNYSFdagNOQUzGNfkBctAPGwM/om8SItyyq41US4W+paxyZt
 I8xBT+2mFZ4xePHzcNzeaw8S4w==
X-Google-Smtp-Source: ABdhPJxu/20L6f4UIu3TjxYb9mGaNdxihBAZzHQCrTg/qmpKmPcYQWNqpuUUco8L1qBhWTdWiI8RRQ==
X-Received: by 2002:a17:90b:15c9:b0:1d2:f2f0:e15e with SMTP id
 lh9-20020a17090b15c900b001d2f2f0e15emr9734310pjb.195.1650537857872; 
 Thu, 21 Apr 2022 03:44:17 -0700 (PDT)
Received: from always-x1.bytedance.net ([61.120.150.69])
 by smtp.gmail.com with ESMTPSA id
 w7-20020aa79547000000b0050ad0e82e6dsm3772485pfq.215.2022.04.21.03.44.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 Apr 2022 03:44:17 -0700 (PDT)
From: zhenwei pi <pizhenwei@bytedance.com>
To: arei.gonglei@huawei.com,
	mst@redhat.com
Subject: [PATCH v3 4/5] virtio-crypto: adjust dst_len at ops callback
Date: Thu, 21 Apr 2022 18:40:15 +0800
Message-Id: <20220421104016.453458-5-pizhenwei@bytedance.com>
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
