Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1057BC433F5
	for <virtualization@archiver.kernel.org>; Thu, 21 Apr 2022 10:44:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 8929841B37;
	Thu, 21 Apr 2022 10:44:17 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id nG02QlReRj6X; Thu, 21 Apr 2022 10:44:16 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id C3A5E4190A;
	Thu, 21 Apr 2022 10:44:15 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 7D0B4C0033;
	Thu, 21 Apr 2022 10:44:15 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1A3FDC002C
 for <virtualization@lists.linux-foundation.org>;
 Thu, 21 Apr 2022 10:44:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 04FEB8278F
 for <virtualization@lists.linux-foundation.org>;
 Thu, 21 Apr 2022 10:44:14 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=bytedance-com.20210112.gappssmtp.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id JMmCSg97rowf
 for <virtualization@lists.linux-foundation.org>;
 Thu, 21 Apr 2022 10:44:13 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com
 [IPv6:2607:f8b0:4864:20::102b])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 6906B813F2
 for <virtualization@lists.linux-foundation.org>;
 Thu, 21 Apr 2022 10:44:13 +0000 (UTC)
Received: by mail-pj1-x102b.google.com with SMTP id
 e62-20020a17090a6fc400b001d2cd8e9b0aso4797296pjk.5
 for <virtualization@lists.linux-foundation.org>;
 Thu, 21 Apr 2022 03:44:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance-com.20210112.gappssmtp.com; s=20210112;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=Soqf3DM2EhHRALM+l3+OvMMOLUa3IL3/z83R4lQAUME=;
 b=MFcgCbgJJ5SK6J0X7stUHJhXJ0mBu8nHN96Z4tvfqDrjvLucvnYZgOGT0QjT597Uby
 X1P1qxXXARFF8wit/aAxMKwfDXO0rZDn3F4cbxwmxkKokfzYB1z7LhuoaTYegIMgyLqv
 ly0HoDdhUXeNpgQ1mwtvXwvP/8FrtIQEvkfMEezAoF7dwPoFpG+VMQ6TQ//imHHxOyBL
 WBSWvxXIsH8lO/KABabvTqewYOam48h/9Eli0b7/wsbHJREAKCSreIl3TDjrsRmS7fZQ
 qwNH4ZZ/D49sflTZ4fn2bPHMvETRXj/qB6rZXBbEbHddeeXH8ZwfU3nfojguPxeKrs06
 SBRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=Soqf3DM2EhHRALM+l3+OvMMOLUa3IL3/z83R4lQAUME=;
 b=azCgnlI7BPFSlmEF5WXVn/giX8JaoZx2IiOnHK3TqFZNwn9EHCacasNrvMbweDU0NM
 x/yez6cY0R8/GRbzQMzkwbevhrQWFS8X5y1LAlCjARq5Rx/6TKY1qDktfWrAlY/EY57T
 IPKvTiVZtwcGUbpe7jl8C36un4akXzPO86giYA1YPHZRf9k7LG/ditCQ5nSdSR+U3ZW7
 FHFbcZlhiJMzKcPdi6peO/zERx+YPk1m/egBJo3Xm4+cqH/47D5X3cqR+z98Dh0NYIbQ
 xjOtmwS0R5wvwYdwYK9707Iuk/EDcaLn7a9umPbnNoj2CFoRb7rGQJUhptEDFR624hIa
 sjwQ==
X-Gm-Message-State: AOAM533Wt0XKWX33E8LAqgn3tSGC4Q9q66PISz9RqPLxBylFbbH3ecQt
 9JnvGreyD2taCD6y0oZffj0pbA==
X-Google-Smtp-Source: ABdhPJwERO7VeCmPyZBwxIsQHqWASpqeFP8RVtxBICGxK+ZjXbAoVUBaCflO3+ba3KBsGrekR9xcJg==
X-Received: by 2002:a17:902:bb92:b0:153:4eae:c77e with SMTP id
 m18-20020a170902bb9200b001534eaec77emr24831615pls.93.1650537852862; 
 Thu, 21 Apr 2022 03:44:12 -0700 (PDT)
Received: from always-x1.bytedance.net ([61.120.150.69])
 by smtp.gmail.com with ESMTPSA id
 w7-20020aa79547000000b0050ad0e82e6dsm3772485pfq.215.2022.04.21.03.44.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 Apr 2022 03:44:12 -0700 (PDT)
From: zhenwei pi <pizhenwei@bytedance.com>
To: arei.gonglei@huawei.com,
	mst@redhat.com
Subject: [PATCH v3 3/5] virtio-crypto: move helpers into virtio_crypto_common.c
Date: Thu, 21 Apr 2022 18:40:14 +0800
Message-Id: <20220421104016.453458-4-pizhenwei@bytedance.com>
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

Move virtcrypto_clear_request and virtcrypto_dataq_callback into
virtio_crypto_common.c to make code clear. Then the xx_core.c
supports:
  - probe/remove/irq affinity seting for a virtio device
  - basic virtio related operations

xx_common.c supports:
  - common helpers/functions for algos

Cc: Michael S. Tsirkin <mst@redhat.com>
Cc: Jason Wang <jasowang@redhat.com>
Cc: Gonglei <arei.gonglei@huawei.com>
Signed-off-by: zhenwei pi <pizhenwei@bytedance.com>
---
 drivers/crypto/virtio/virtio_crypto_common.c | 31 +++++++++++++++++++
 drivers/crypto/virtio/virtio_crypto_common.h |  2 ++
 drivers/crypto/virtio/virtio_crypto_core.c   | 32 --------------------
 3 files changed, 33 insertions(+), 32 deletions(-)

diff --git a/drivers/crypto/virtio/virtio_crypto_common.c b/drivers/crypto/virtio/virtio_crypto_common.c
index 93df73c40dd3..4a23524896fe 100644
--- a/drivers/crypto/virtio/virtio_crypto_common.c
+++ b/drivers/crypto/virtio/virtio_crypto_common.c
@@ -8,6 +8,14 @@
 
 #include "virtio_crypto_common.h"
 
+void virtcrypto_clear_request(struct virtio_crypto_request *vc_req)
+{
+	if (vc_req) {
+		kfree_sensitive(vc_req->req_data);
+		kfree(vc_req->sgs);
+	}
+}
+
 static void virtio_crypto_ctrlq_callback(struct virtio_crypto_ctrl_request *vc_ctrl_req)
 {
 	complete(&vc_ctrl_req->compl);
@@ -59,3 +67,26 @@ void virtcrypto_ctrlq_callback(struct virtqueue *vq)
 	} while (!virtqueue_enable_cb(vq));
 	spin_unlock_irqrestore(&vcrypto->ctrl_lock, flags);
 }
+
+void virtcrypto_dataq_callback(struct virtqueue *vq)
+{
+	struct virtio_crypto *vcrypto = vq->vdev->priv;
+	struct virtio_crypto_request *vc_req;
+	unsigned long flags;
+	unsigned int len;
+	unsigned int qid = vq->index;
+
+	spin_lock_irqsave(&vcrypto->data_vq[qid].lock, flags);
+	do {
+		virtqueue_disable_cb(vq);
+		while ((vc_req = virtqueue_get_buf(vq, &len)) != NULL) {
+			spin_unlock_irqrestore(
+				&vcrypto->data_vq[qid].lock, flags);
+			if (vc_req->alg_cb)
+				vc_req->alg_cb(vc_req, len);
+			spin_lock_irqsave(
+				&vcrypto->data_vq[qid].lock, flags);
+		}
+	} while (!virtqueue_enable_cb(vq));
+	spin_unlock_irqrestore(&vcrypto->data_vq[qid].lock, flags);
+}
diff --git a/drivers/crypto/virtio/virtio_crypto_common.h b/drivers/crypto/virtio/virtio_crypto_common.h
index 25b4f22e8605..4d33ed5593d4 100644
--- a/drivers/crypto/virtio/virtio_crypto_common.h
+++ b/drivers/crypto/virtio/virtio_crypto_common.h
@@ -152,4 +152,6 @@ int virtio_crypto_ctrl_vq_request(struct virtio_crypto *vcrypto, struct scatterl
 				  unsigned int out_sgs, unsigned int in_sgs,
 				  struct virtio_crypto_ctrl_request *vc_ctrl_req);
 
+void virtcrypto_dataq_callback(struct virtqueue *vq);
+
 #endif /* _VIRTIO_CRYPTO_COMMON_H */
diff --git a/drivers/crypto/virtio/virtio_crypto_core.c b/drivers/crypto/virtio/virtio_crypto_core.c
index e668d4b1bc6a..d8edefcb966c 100644
--- a/drivers/crypto/virtio/virtio_crypto_core.c
+++ b/drivers/crypto/virtio/virtio_crypto_core.c
@@ -13,38 +13,6 @@
 #include "virtio_crypto_common.h"
 
 
-void
-virtcrypto_clear_request(struct virtio_crypto_request *vc_req)
-{
-	if (vc_req) {
-		kfree_sensitive(vc_req->req_data);
-		kfree(vc_req->sgs);
-	}
-}
-
-static void virtcrypto_dataq_callback(struct virtqueue *vq)
-{
-	struct virtio_crypto *vcrypto = vq->vdev->priv;
-	struct virtio_crypto_request *vc_req;
-	unsigned long flags;
-	unsigned int len;
-	unsigned int qid = vq->index;
-
-	spin_lock_irqsave(&vcrypto->data_vq[qid].lock, flags);
-	do {
-		virtqueue_disable_cb(vq);
-		while ((vc_req = virtqueue_get_buf(vq, &len)) != NULL) {
-			spin_unlock_irqrestore(
-				&vcrypto->data_vq[qid].lock, flags);
-			if (vc_req->alg_cb)
-				vc_req->alg_cb(vc_req, len);
-			spin_lock_irqsave(
-				&vcrypto->data_vq[qid].lock, flags);
-		}
-	} while (!virtqueue_enable_cb(vq));
-	spin_unlock_irqrestore(&vcrypto->data_vq[qid].lock, flags);
-}
-
 static int virtcrypto_find_vqs(struct virtio_crypto *vi)
 {
 	vq_callback_t **callbacks;
-- 
2.20.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
