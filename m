Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73794C433EF
	for <virtualization@archiver.kernel.org>; Fri, 15 Apr 2022 06:45:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 0CE204098D;
	Fri, 15 Apr 2022 06:45:28 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id cR1kgEbyNzzy; Fri, 15 Apr 2022 06:45:26 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 1E510410C0;
	Fri, 15 Apr 2022 06:45:26 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E0606C002F;
	Fri, 15 Apr 2022 06:45:25 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 632DBC002C
 for <virtualization@lists.linux-foundation.org>;
 Fri, 15 Apr 2022 06:45:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 4FFEA610CB
 for <virtualization@lists.linux-foundation.org>;
 Fri, 15 Apr 2022 06:45:24 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=bytedance-com.20210112.gappssmtp.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id oFdxHQIt2R_l
 for <virtualization@lists.linux-foundation.org>;
 Fri, 15 Apr 2022 06:45:23 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com
 [IPv6:2607:f8b0:4864:20::532])
 by smtp3.osuosl.org (Postfix) with ESMTPS id B9E98610C2
 for <virtualization@lists.linux-foundation.org>;
 Fri, 15 Apr 2022 06:45:23 +0000 (UTC)
Received: by mail-pg1-x532.google.com with SMTP id t13so6661343pgn.8
 for <virtualization@lists.linux-foundation.org>;
 Thu, 14 Apr 2022 23:45:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance-com.20210112.gappssmtp.com; s=20210112;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=HIfkyA0kHsUAS/WiTZijAfUV1CeLSCyZNaoBawxM4dQ=;
 b=bRNhcDrRB4NS8pkIyJ0hmHz8NeqERb22Ss/1ljlGJ1GB7zLBKH9J4g7Q6f6Fy9tDKB
 GVozb8zX2giAR9+DvLMs7bmzTzrFTUwNoNkT+uOLZaiDlcMYge25ogOzrdkN+K3EAmP8
 sQLk25OzbV4bjfS9mTvknf0xWdLd2xCTXnQqG455z+v66utPUCXAhgywZzMjKfUesuVG
 bLYhYFJaj7IePr9CME3+lYjMKRcCFrQQvOFPvE59Pg3wuFK37O3mJzuHslF95TJKtdEe
 pyrWeNT8Nd9b77qtm/fRf6WPvlz2uhClm8PB+XiPfov6ea0fM1jcfTdpfGHs210PA1lV
 V9Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=HIfkyA0kHsUAS/WiTZijAfUV1CeLSCyZNaoBawxM4dQ=;
 b=vtV508nOmgqHMu+dQw68e0YZj2P1zMAoshhHu6pPcaPIZ0SobXFOay8lw56Ju1X+Kg
 32ESLln+BrkANqkgJ0nStFjxl2Of52yp2hbZGPpS3qXIghS50mZt+N8BACMylPttHyRH
 4D8jCM3oCPtvKLSzORGa0bxWDMTQrSFIC0/t6kAnVNgPs/GbzEDsY0f/cxzbXp4xfQO/
 id4M/HKpRaVKlism9i3gRI0Y8RSRmlHArHrKCK/kcNu+meI55Fg544yqhec4tpj1SdOp
 igraXlGMtBVn3bDrrLQJRjO/jz19aAXUoixFF1eyFQzkKN2CtrjoE3qIj7Uic/7H4Z/Z
 He9A==
X-Gm-Message-State: AOAM533KzZVQr+gN7E1Zg7VuaBcZgPa6I2KROSZ0GA/4szpHHA0vWF0O
 PNzhsGbuBQbucwMKEMntOi6FXQ==
X-Google-Smtp-Source: ABdhPJxL1fEBgglkis/EMPLSlJi9UALXaNzImIYVN25Au5p37RRe+JGZt7QPDDzenL0BV+xqlxWkGA==
X-Received: by 2002:a05:6a00:1788:b0:508:70fe:4e62 with SMTP id
 s8-20020a056a00178800b0050870fe4e62mr4175773pfg.70.1650005123188; 
 Thu, 14 Apr 2022 23:45:23 -0700 (PDT)
Received: from always-x1.bytedance.net ([61.120.150.70])
 by smtp.gmail.com with ESMTPSA id
 d8-20020a056a00198800b004fab740dbe6sm1867385pfl.15.2022.04.14.23.45.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 Apr 2022 23:45:22 -0700 (PDT)
From: zhenwei pi <pizhenwei@bytedance.com>
To: arei.gonglei@huawei.com,
	mst@redhat.com
Subject: [PATCH 2/4] virtio-crypto: move helpers into virtio_crypto_common.c
Date: Fri, 15 Apr 2022 14:41:34 +0800
Message-Id: <20220415064136.304661-3-pizhenwei@bytedance.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220415064136.304661-1-pizhenwei@bytedance.com>
References: <20220415064136.304661-1-pizhenwei@bytedance.com>
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
index 125ad2300b83..a003935f91a9 100644
--- a/drivers/crypto/virtio/virtio_crypto_common.h
+++ b/drivers/crypto/virtio/virtio_crypto_common.h
@@ -148,4 +148,6 @@ int virtio_crypto_ctrl_vq_request(struct virtio_crypto *vcrypto, struct scatterl
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
