Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68B29C433EF
	for <virtualization@archiver.kernel.org>; Thu, 21 Apr 2022 10:44:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 168A86117F;
	Thu, 21 Apr 2022 10:44:14 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id SliAJeM-MVHp; Thu, 21 Apr 2022 10:44:13 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 5B6126117D;
	Thu, 21 Apr 2022 10:44:12 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 4053BC0033;
	Thu, 21 Apr 2022 10:44:12 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 39B0FC002C
 for <virtualization@lists.linux-foundation.org>;
 Thu, 21 Apr 2022 10:44:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 27221405B9
 for <virtualization@lists.linux-foundation.org>;
 Thu, 21 Apr 2022 10:44:11 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=bytedance-com.20210112.gappssmtp.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id MmIZH7sdwjR6
 for <virtualization@lists.linux-foundation.org>;
 Thu, 21 Apr 2022 10:44:10 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com
 [IPv6:2607:f8b0:4864:20::632])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 60DAA40338
 for <virtualization@lists.linux-foundation.org>;
 Thu, 21 Apr 2022 10:44:10 +0000 (UTC)
Received: by mail-pl1-x632.google.com with SMTP id b7so4479930plh.2
 for <virtualization@lists.linux-foundation.org>;
 Thu, 21 Apr 2022 03:44:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance-com.20210112.gappssmtp.com; s=20210112;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=+wRkA/MgdpGcvHCj6EQvY7xr281zOQma1KCz2azqeQs=;
 b=jegRWHwuhvBJz/GaSZkEzZ6hoEymXfQqnPcmwCl69wJvDDeaoqtr1Cgv89p6+Zcojk
 nqtq+U/nuH3bT2ntZlFkEkovPtp+1wfbLu9/yCpKyD550W3fMB/CAVm3c2UQ8ahpqHBb
 SCHYt7KMoslj6+KDnJh+IQ4kas56WDt/nv4AWtcqZlzM5p78Nzxzw2qQwvAdOtqhvhrr
 O36N1xKrj/jUQU1FB0MSDuDfiz2tYYeK7p+y7d3jKZWsa2swIVBfYs3mTV4kAHgMRVJh
 QN+otgEZFGMeADO0yF8zoVJ9skQhWhoJsU/4ofHlv/e5JUgI8Iua5xrOPMsU3mtEMHwP
 5EDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=+wRkA/MgdpGcvHCj6EQvY7xr281zOQma1KCz2azqeQs=;
 b=xSXSFrkPpGbyROoIVLxwG2vtz5/WU+Hkpz6bC3Itk1xByd4pfu9S4GHXXVZ2JGz5F5
 wtAFEu3hobE3iWoUGEl1W566fyrXzIoJxeJm8+Jo+ZPkpHJCgvVtjUtPZjjXuGqvX28W
 /CwP/jrSAZHVZ1QhpmzfAG2/BTiUk3bB/JB+K2+261fYpAIABhHtux8U2AmpIvc7r82L
 Bnl3lvqHIcvRtlvzHli0L2OmssKsETmyT2ng/wqwSB1En9DnsgZxySFrJjMKfn+tubAp
 94/A/Nd6AhznhnHT6bNgW9Umg8lh4cGtwgQI59Cp7C3wZTZZleSKOB3C/smR4/a29CCC
 34tA==
X-Gm-Message-State: AOAM530RIHVpwAQlRGfESbmQbgOxqaqPb9i+PNseFG53nLPibR89fk0Q
 rMe+tiJmnz8zglOeCvr/BdfHGA==
X-Google-Smtp-Source: ABdhPJwIFNIZf4tx34yay+SImO1/KmEBVip2rmWSTb1FmjkUcJBqELt5K2q2XgxFhv5sfIC42zJwrQ==
X-Received: by 2002:a17:902:e8c6:b0:158:f809:311f with SMTP id
 v6-20020a170902e8c600b00158f809311fmr20858174plg.4.1650537848321; 
 Thu, 21 Apr 2022 03:44:08 -0700 (PDT)
Received: from always-x1.bytedance.net ([61.120.150.69])
 by smtp.gmail.com with ESMTPSA id
 w7-20020aa79547000000b0050ad0e82e6dsm3772485pfq.215.2022.04.21.03.44.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 Apr 2022 03:44:07 -0700 (PDT)
From: zhenwei pi <pizhenwei@bytedance.com>
To: arei.gonglei@huawei.com,
	mst@redhat.com
Subject: [PATCH v3 2/5] virtio-crypto: wait ctrl queue instead of busy polling
Date: Thu, 21 Apr 2022 18:40:13 +0800
Message-Id: <20220421104016.453458-3-pizhenwei@bytedance.com>
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

Originally, after submitting request into virtio crypto control
queue, the guest side polls the result from the virt queue. This
works like following:
    CPU0   CPU1               ...             CPUx  CPUy
     |      |                                  |     |
     \      \                                  /     /
      \--------spin_lock(&vcrypto->ctrl_lock)-------/
                           |
                 virtqueue add & kick
                           |
                  busy poll virtqueue
                           |
              spin_unlock(&vcrypto->ctrl_lock)
                          ...

There are two problems:
1, The queue depth is always 1, the performance of a virtio crypto
   device gets limited. Multi user processes share a single control
   queue, and hit spin lock race from control queue. Test on Intel
   Platinum 8260, a single worker gets ~35K/s create/close session
   operations, and 8 workers get ~40K/s operations with 800% CPU
   utilization.
2, The control request is supposed to get handled immediately, but
   in the current implementation of QEMU(v6.2), the vCPU thread kicks
   another thread to do this work, the latency also gets unstable.
   Tracking latency of virtio_crypto_alg_akcipher_close_session in 5s:
        usecs               : count     distribution
         0 -> 1          : 0        |                        |
         2 -> 3          : 7        |                        |
         4 -> 7          : 72       |                        |
         8 -> 15         : 186485   |************************|
        16 -> 31         : 687      |                        |
        32 -> 63         : 5        |                        |
        64 -> 127        : 3        |                        |
       128 -> 255        : 1        |                        |
       256 -> 511        : 0        |                        |
       512 -> 1023       : 0        |                        |
      1024 -> 2047       : 0        |                        |
      2048 -> 4095       : 0        |                        |
      4096 -> 8191       : 0        |                        |
      8192 -> 16383      : 2        |                        |
   This means that a CPU may hold vcrypto->ctrl_lock as long as 8192~16383us.

To improve the performance of control queue, a request on control queue waits
completion instead of busy polling to reduce lock racing, and gets completed by
control queue callback.
    CPU0   CPU1               ...             CPUx  CPUy
     |      |                                  |     |
     \      \                                  /     /
      \--------spin_lock(&vcrypto->ctrl_lock)-------/
                           |
                 virtqueue add & kick
                           |
      ---------spin_unlock(&vcrypto->ctrl_lock)------
     /      /                                  \     \
     |      |                                  |     |
    wait   wait                               wait  wait

Test this patch, the guest side get ~200K/s operations with 300% CPU
utilization.

Cc: Michael S. Tsirkin <mst@redhat.com>
Cc: Jason Wang <jasowang@redhat.com>
Cc: Gonglei <arei.gonglei@huawei.com>
Signed-off-by: zhenwei pi <pizhenwei@bytedance.com>
---
 drivers/crypto/virtio/virtio_crypto_common.c | 42 +++++++++++++++-----
 drivers/crypto/virtio/virtio_crypto_common.h |  8 ++++
 drivers/crypto/virtio/virtio_crypto_core.c   |  2 +-
 3 files changed, 41 insertions(+), 11 deletions(-)

diff --git a/drivers/crypto/virtio/virtio_crypto_common.c b/drivers/crypto/virtio/virtio_crypto_common.c
index e65125a74db2..93df73c40dd3 100644
--- a/drivers/crypto/virtio/virtio_crypto_common.c
+++ b/drivers/crypto/virtio/virtio_crypto_common.c
@@ -8,14 +8,21 @@
 
 #include "virtio_crypto_common.h"
 
+static void virtio_crypto_ctrlq_callback(struct virtio_crypto_ctrl_request *vc_ctrl_req)
+{
+	complete(&vc_ctrl_req->compl);
+}
+
 int virtio_crypto_ctrl_vq_request(struct virtio_crypto *vcrypto, struct scatterlist *sgs[],
 				  unsigned int out_sgs, unsigned int in_sgs,
 				  struct virtio_crypto_ctrl_request *vc_ctrl_req)
 {
 	int err;
-	unsigned int inlen;
 	unsigned long flags;
 
+	init_completion(&vc_ctrl_req->compl);
+	vc_ctrl_req->ctrl_cb =  virtio_crypto_ctrlq_callback;
+
 	spin_lock_irqsave(&vcrypto->ctrl_lock, flags);
 	err = virtqueue_add_sgs(vcrypto->ctrl_vq, sgs, out_sgs, in_sgs, vc_ctrl_req, GFP_ATOMIC);
 	if (err < 0) {
@@ -24,16 +31,31 @@ int virtio_crypto_ctrl_vq_request(struct virtio_crypto *vcrypto, struct scatterl
 	}
 
 	virtqueue_kick(vcrypto->ctrl_vq);
-
-	/*
-	 * Trapping into the hypervisor, so the request should be
-	 * handled immediately.
-	 */
-	while (!virtqueue_get_buf(vcrypto->ctrl_vq, &inlen) &&
-		!virtqueue_is_broken(vcrypto->ctrl_vq))
-		cpu_relax();
-
 	spin_unlock_irqrestore(&vcrypto->ctrl_lock, flags);
 
+	wait_for_completion(&vc_ctrl_req->compl);
+
 	return 0;
 }
+
+void virtcrypto_ctrlq_callback(struct virtqueue *vq)
+{
+	struct virtio_crypto *vcrypto = vq->vdev->priv;
+	struct virtio_crypto_ctrl_request *vc_ctrl_req;
+	unsigned long flags;
+	unsigned int len;
+
+	spin_lock_irqsave(&vcrypto->ctrl_lock, flags);
+	do {
+		virtqueue_disable_cb(vq);
+		while ((vc_ctrl_req = virtqueue_get_buf(vq, &len)) != NULL) {
+			spin_unlock_irqrestore(&vcrypto->ctrl_lock, flags);
+			if (vc_ctrl_req->ctrl_cb)
+				vc_ctrl_req->ctrl_cb(vc_ctrl_req);
+			spin_lock_irqsave(&vcrypto->ctrl_lock, flags);
+		}
+		if (unlikely(virtqueue_is_broken(vq)))
+			break;
+	} while (!virtqueue_enable_cb(vq));
+	spin_unlock_irqrestore(&vcrypto->ctrl_lock, flags);
+}
diff --git a/drivers/crypto/virtio/virtio_crypto_common.h b/drivers/crypto/virtio/virtio_crypto_common.h
index d2a20fe6e13e..25b4f22e8605 100644
--- a/drivers/crypto/virtio/virtio_crypto_common.h
+++ b/drivers/crypto/virtio/virtio_crypto_common.h
@@ -81,6 +81,10 @@ struct virtio_crypto_sym_session_info {
 	__u64 session_id;
 };
 
+struct virtio_crypto_ctrl_request;
+typedef void (*virtio_crypto_ctrl_callback)
+		(struct virtio_crypto_ctrl_request *vc_ctrl_req);
+
 /*
  * Note: there are padding fields in request, clear them to zero before sending to host,
  * Ex, virtio_crypto_ctrl_request::ctrl::u::destroy_session::padding[48]
@@ -89,6 +93,8 @@ struct virtio_crypto_ctrl_request {
 	struct virtio_crypto_op_ctrl_req ctrl;
 	struct virtio_crypto_session_input input;
 	struct virtio_crypto_inhdr ctrl_status;
+	virtio_crypto_ctrl_callback ctrl_cb;
+	struct completion compl;
 };
 
 struct virtio_crypto_request;
@@ -141,7 +147,9 @@ void virtio_crypto_skcipher_algs_unregister(struct virtio_crypto *vcrypto);
 int virtio_crypto_akcipher_algs_register(struct virtio_crypto *vcrypto);
 void virtio_crypto_akcipher_algs_unregister(struct virtio_crypto *vcrypto);
 
+void virtcrypto_ctrlq_callback(struct virtqueue *vq);
 int virtio_crypto_ctrl_vq_request(struct virtio_crypto *vcrypto, struct scatterlist *sgs[],
 				  unsigned int out_sgs, unsigned int in_sgs,
 				  struct virtio_crypto_ctrl_request *vc_ctrl_req);
+
 #endif /* _VIRTIO_CRYPTO_COMMON_H */
diff --git a/drivers/crypto/virtio/virtio_crypto_core.c b/drivers/crypto/virtio/virtio_crypto_core.c
index c6f482db0bc0..e668d4b1bc6a 100644
--- a/drivers/crypto/virtio/virtio_crypto_core.c
+++ b/drivers/crypto/virtio/virtio_crypto_core.c
@@ -73,7 +73,7 @@ static int virtcrypto_find_vqs(struct virtio_crypto *vi)
 		goto err_names;
 
 	/* Parameters for control virtqueue */
-	callbacks[total_vqs - 1] = NULL;
+	callbacks[total_vqs - 1] = virtcrypto_ctrlq_callback;
 	names[total_vqs - 1] = "controlq";
 
 	/* Allocate/initialize parameters for data virtqueues */
-- 
2.20.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
