Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07876C433EF
	for <virtualization@archiver.kernel.org>; Fri,  6 May 2022 13:21:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 9AE2C6112D;
	Fri,  6 May 2022 13:21:13 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id jMekzY2_u67G; Fri,  6 May 2022 13:21:12 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id F09EA61102;
	Fri,  6 May 2022 13:21:11 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id BF8DAC0039;
	Fri,  6 May 2022 13:21:11 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 85648C002D
 for <virtualization@lists.linux-foundation.org>;
 Fri,  6 May 2022 13:21:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 6654B61102
 for <virtualization@lists.linux-foundation.org>;
 Fri,  6 May 2022 13:21:10 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id c9T-0OwDBoUz
 for <virtualization@lists.linux-foundation.org>;
 Fri,  6 May 2022 13:21:09 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com
 [IPv6:2607:f8b0:4864:20::633])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 73ED161132
 for <virtualization@lists.linux-foundation.org>;
 Fri,  6 May 2022 13:21:09 +0000 (UTC)
Received: by mail-pl1-x633.google.com with SMTP id c11so7395658plg.13
 for <virtualization@lists.linux-foundation.org>;
 Fri, 06 May 2022 06:21:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance-com.20210112.gappssmtp.com; s=20210112;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=AvEGrrZmHBTew/Xb4dK3Q06lksETBCrs8O5XD+mD/UI=;
 b=6g3JtXGtxQKKmxovklJPc/q6dNF9+SE3MKOKxNNA8l2/ZUrR4Ac7+r6i7AthCGaQuH
 NpLy5HHa32eYeMtpyaHea/tDd2zqApF2OI80Sxi/haMKCgKAHGNfmcOEdrh73OI89TCz
 zfQOH63iCRApNbkwbrWNk4q5LKYcCl3tqekrFg5pYa0fOQVEKisx5BWpeJ6+bR0JLTTM
 Ybwl8Bswn0mPkMlZq2RgKrox1/2nAa1gHJ65pZvr7x7Epaw4hpiKICZ1tP1vz/Hg3p7r
 R5J0/J8pAXlGAxX+91ihK2OxdCU/p8jd4/6RIhdzUuf9/v45jeOsvis5pruMtgiTnMzA
 6mqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=AvEGrrZmHBTew/Xb4dK3Q06lksETBCrs8O5XD+mD/UI=;
 b=PS1+JQ2LRTAbHVE9G03r6hPwv+itypB4PJ49p6uvwlaK1LzQCU2Zys7GabtgI0l850
 X7ayvgEIzIPkUDb5ZlD8w8kXDXZaLRsDDsP4urq2gU2JhmYJxO7EByLCiVr+NeGJbp/v
 4Z9CfQnhXOa9jwATVPV3uwP6kcEvc/2eeMfFAvB4/2NH1NkPrMEk5My0+LZQG/LpDyv+
 3eiYorDOU7MFOZv0TH6eTJx1dw6dxPdJMJNAk7Oeatyg7b49sHSs5c3MI2OTg+YZbm8Q
 x18O3BacTkvo2rB2HdoI77a6qvGRNpVqytZD65mMJcij/N68l6/mls1gIWrPKTxXKLNI
 IWqw==
X-Gm-Message-State: AOAM533Vie73hkUjgp9Mkn6aaUSLX5lLC0V8HsLNvJjmEx4CGavaN/uM
 E/dHrG/sNmNZxAmguXct1oSO/A==
X-Google-Smtp-Source: ABdhPJzFOyIcQJuc+gZF/agXu7BMN8K++eSd8bhAEO+cLSiWlxz4cjcBI+Ut1GwL+jy8Oii9UJHvTQ==
X-Received: by 2002:a17:903:32d0:b0:15e:8cbc:fd39 with SMTP id
 i16-20020a17090332d000b0015e8cbcfd39mr3730198plr.95.1651843268856; 
 Fri, 06 May 2022 06:21:08 -0700 (PDT)
Received: from always-x1.www.tendawifi.com ([139.177.225.255])
 by smtp.gmail.com with ESMTPSA id
 i22-20020a63e916000000b003c14af50643sm3256986pgh.91.2022.05.06.06.21.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 May 2022 06:21:08 -0700 (PDT)
From: zhenwei pi <pizhenwei@bytedance.com>
To: arei.gonglei@huawei.com,
	mst@redhat.com
Subject: [PATCH v6 3/5] virtio-crypto: wait ctrl queue instead of busy polling
Date: Fri,  6 May 2022 21:16:25 +0800
Message-Id: <20220506131627.180784-4-pizhenwei@bytedance.com>
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

To improve the performance of control queue, a request on control queue
waits completion instead of busy polling to reduce lock racing, and gets
completed by control queue callback.
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
Reviewed-by: Gonglei <arei.gonglei@huawei.com>
Signed-off-by: zhenwei pi <pizhenwei@bytedance.com>
---
 .../virtio/virtio_crypto_akcipher_algs.c      | 29 ++---------
 drivers/crypto/virtio/virtio_crypto_common.h  |  4 ++
 drivers/crypto/virtio/virtio_crypto_core.c    | 52 ++++++++++++++++++-
 .../virtio/virtio_crypto_skcipher_algs.c      | 34 ++----------
 4 files changed, 64 insertions(+), 55 deletions(-)

diff --git a/drivers/crypto/virtio/virtio_crypto_akcipher_algs.c b/drivers/crypto/virtio/virtio_crypto_akcipher_algs.c
index 698ea57e2649..382ccec9ab12 100644
--- a/drivers/crypto/virtio/virtio_crypto_akcipher_algs.c
+++ b/drivers/crypto/virtio/virtio_crypto_akcipher_algs.c
@@ -103,7 +103,6 @@ static int virtio_crypto_alg_akcipher_init_session(struct virtio_crypto_akcipher
 	struct scatterlist outhdr_sg, key_sg, inhdr_sg, *sgs[3];
 	struct virtio_crypto *vcrypto = ctx->vcrypto;
 	uint8_t *pkey;
-	unsigned int inlen;
 	int err;
 	unsigned int num_out = 0, num_in = 0;
 	struct virtio_crypto_op_ctrl_req *ctrl;
@@ -135,18 +134,9 @@ static int virtio_crypto_alg_akcipher_init_session(struct virtio_crypto_akcipher
 	sg_init_one(&inhdr_sg, input, sizeof(*input));
 	sgs[num_out + num_in++] = &inhdr_sg;
 
-	spin_lock(&vcrypto->ctrl_lock);
-	err = virtqueue_add_sgs(vcrypto->ctrl_vq, sgs, num_out, num_in, vcrypto, GFP_ATOMIC);
-	if (err < 0) {
-		spin_unlock(&vcrypto->ctrl_lock);
+	err = virtio_crypto_ctrl_vq_request(vcrypto, sgs, num_out, num_in, vc_ctrl_req);
+	if (err < 0)
 		goto out;
-	}
-
-	virtqueue_kick(vcrypto->ctrl_vq);
-	while (!virtqueue_get_buf(vcrypto->ctrl_vq, &inlen) &&
-	       !virtqueue_is_broken(vcrypto->ctrl_vq))
-		cpu_relax();
-	spin_unlock(&vcrypto->ctrl_lock);
 
 	if (le32_to_cpu(input->status) != VIRTIO_CRYPTO_OK) {
 		pr_err("virtio_crypto: Create session failed status: %u\n",
@@ -171,7 +161,7 @@ static int virtio_crypto_alg_akcipher_close_session(struct virtio_crypto_akciphe
 	struct scatterlist outhdr_sg, inhdr_sg, *sgs[2];
 	struct virtio_crypto_destroy_session_req *destroy_session;
 	struct virtio_crypto *vcrypto = ctx->vcrypto;
-	unsigned int num_out = 0, num_in = 0, inlen;
+	unsigned int num_out = 0, num_in = 0;
 	int err;
 	struct virtio_crypto_op_ctrl_req *ctrl;
 	struct virtio_crypto_inhdr *ctrl_status;
@@ -199,18 +189,9 @@ static int virtio_crypto_alg_akcipher_close_session(struct virtio_crypto_akciphe
 	sg_init_one(&inhdr_sg, &ctrl_status->status, sizeof(ctrl_status->status));
 	sgs[num_out + num_in++] = &inhdr_sg;
 
-	spin_lock(&vcrypto->ctrl_lock);
-	err = virtqueue_add_sgs(vcrypto->ctrl_vq, sgs, num_out, num_in, vcrypto, GFP_ATOMIC);
-	if (err < 0) {
-		spin_unlock(&vcrypto->ctrl_lock);
+	err = virtio_crypto_ctrl_vq_request(vcrypto, sgs, num_out, num_in, vc_ctrl_req);
+	if (err < 0)
 		goto out;
-	}
-
-	virtqueue_kick(vcrypto->ctrl_vq);
-	while (!virtqueue_get_buf(vcrypto->ctrl_vq, &inlen) &&
-	       !virtqueue_is_broken(vcrypto->ctrl_vq))
-		cpu_relax();
-	spin_unlock(&vcrypto->ctrl_lock);
 
 	if (ctrl_status->status != VIRTIO_CRYPTO_OK) {
 		pr_err("virtio_crypto: Close session failed status: %u, session_id: 0x%llx\n",
diff --git a/drivers/crypto/virtio/virtio_crypto_common.h b/drivers/crypto/virtio/virtio_crypto_common.h
index 2422237ec4e6..59a4c0259456 100644
--- a/drivers/crypto/virtio/virtio_crypto_common.h
+++ b/drivers/crypto/virtio/virtio_crypto_common.h
@@ -90,6 +90,7 @@ struct virtio_crypto_ctrl_request {
 	struct virtio_crypto_op_ctrl_req ctrl;
 	struct virtio_crypto_session_input input;
 	struct virtio_crypto_inhdr ctrl_status;
+	struct completion compl;
 };
 
 struct virtio_crypto_request;
@@ -141,5 +142,8 @@ int virtio_crypto_skcipher_algs_register(struct virtio_crypto *vcrypto);
 void virtio_crypto_skcipher_algs_unregister(struct virtio_crypto *vcrypto);
 int virtio_crypto_akcipher_algs_register(struct virtio_crypto *vcrypto);
 void virtio_crypto_akcipher_algs_unregister(struct virtio_crypto *vcrypto);
+int virtio_crypto_ctrl_vq_request(struct virtio_crypto *vcrypto, struct scatterlist *sgs[],
+				  unsigned int out_sgs, unsigned int in_sgs,
+				  struct virtio_crypto_ctrl_request *vc_ctrl_req);
 
 #endif /* _VIRTIO_CRYPTO_COMMON_H */
diff --git a/drivers/crypto/virtio/virtio_crypto_core.c b/drivers/crypto/virtio/virtio_crypto_core.c
index c6f482db0bc0..60490ffa3df1 100644
--- a/drivers/crypto/virtio/virtio_crypto_core.c
+++ b/drivers/crypto/virtio/virtio_crypto_core.c
@@ -22,6 +22,56 @@ virtcrypto_clear_request(struct virtio_crypto_request *vc_req)
 	}
 }
 
+static void virtio_crypto_ctrlq_callback(struct virtio_crypto_ctrl_request *vc_ctrl_req)
+{
+	complete(&vc_ctrl_req->compl);
+}
+
+static void virtcrypto_ctrlq_callback(struct virtqueue *vq)
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
+			virtio_crypto_ctrlq_callback(vc_ctrl_req);
+			spin_lock_irqsave(&vcrypto->ctrl_lock, flags);
+		}
+		if (unlikely(virtqueue_is_broken(vq)))
+			break;
+	} while (!virtqueue_enable_cb(vq));
+	spin_unlock_irqrestore(&vcrypto->ctrl_lock, flags);
+}
+
+int virtio_crypto_ctrl_vq_request(struct virtio_crypto *vcrypto, struct scatterlist *sgs[],
+		unsigned int out_sgs, unsigned int in_sgs,
+		struct virtio_crypto_ctrl_request *vc_ctrl_req)
+{
+	int err;
+	unsigned long flags;
+
+	init_completion(&vc_ctrl_req->compl);
+
+	spin_lock_irqsave(&vcrypto->ctrl_lock, flags);
+	err = virtqueue_add_sgs(vcrypto->ctrl_vq, sgs, out_sgs, in_sgs, vc_ctrl_req, GFP_ATOMIC);
+	if (err < 0) {
+		spin_unlock_irqrestore(&vcrypto->ctrl_lock, flags);
+		return err;
+	}
+
+	virtqueue_kick(vcrypto->ctrl_vq);
+	spin_unlock_irqrestore(&vcrypto->ctrl_lock, flags);
+
+	wait_for_completion(&vc_ctrl_req->compl);
+
+	return 0;
+}
+
 static void virtcrypto_dataq_callback(struct virtqueue *vq)
 {
 	struct virtio_crypto *vcrypto = vq->vdev->priv;
@@ -73,7 +123,7 @@ static int virtcrypto_find_vqs(struct virtio_crypto *vi)
 		goto err_names;
 
 	/* Parameters for control virtqueue */
-	callbacks[total_vqs - 1] = NULL;
+	callbacks[total_vqs - 1] = virtcrypto_ctrlq_callback;
 	names[total_vqs - 1] = "controlq";
 
 	/* Allocate/initialize parameters for data virtqueues */
diff --git a/drivers/crypto/virtio/virtio_crypto_skcipher_algs.c b/drivers/crypto/virtio/virtio_crypto_skcipher_algs.c
index 6aaf0869b211..e553ccadbcbc 100644
--- a/drivers/crypto/virtio/virtio_crypto_skcipher_algs.c
+++ b/drivers/crypto/virtio/virtio_crypto_skcipher_algs.c
@@ -118,7 +118,6 @@ static int virtio_crypto_alg_skcipher_init_session(
 		int encrypt)
 {
 	struct scatterlist outhdr, key_sg, inhdr, *sgs[3];
-	unsigned int tmp;
 	struct virtio_crypto *vcrypto = ctx->vcrypto;
 	int op = encrypt ? VIRTIO_CRYPTO_OP_ENCRYPT : VIRTIO_CRYPTO_OP_DECRYPT;
 	int err;
@@ -170,23 +169,9 @@ static int virtio_crypto_alg_skcipher_init_session(
 	sg_init_one(&inhdr, input, sizeof(*input));
 	sgs[num_out + num_in++] = &inhdr;
 
-	spin_lock(&vcrypto->ctrl_lock);
-	err = virtqueue_add_sgs(vcrypto->ctrl_vq, sgs, num_out,
-				num_in, vcrypto, GFP_ATOMIC);
-	if (err < 0) {
-		spin_unlock(&vcrypto->ctrl_lock);
+	err = virtio_crypto_ctrl_vq_request(vcrypto, sgs, num_out, num_in, vc_ctrl_req);
+	if (err < 0)
 		goto out;
-	}
-	virtqueue_kick(vcrypto->ctrl_vq);
-
-	/*
-	 * Trapping into the hypervisor, so the request should be
-	 * handled immediately.
-	 */
-	while (!virtqueue_get_buf(vcrypto->ctrl_vq, &tmp) &&
-	       !virtqueue_is_broken(vcrypto->ctrl_vq))
-		cpu_relax();
-	spin_unlock(&vcrypto->ctrl_lock);
 
 	if (le32_to_cpu(input->status) != VIRTIO_CRYPTO_OK) {
 		pr_err("virtio_crypto: Create session failed status: %u\n",
@@ -212,7 +197,6 @@ static int virtio_crypto_alg_skcipher_close_session(
 		int encrypt)
 {
 	struct scatterlist outhdr, status_sg, *sgs[2];
-	unsigned int tmp;
 	struct virtio_crypto_destroy_session_req *destroy_session;
 	struct virtio_crypto *vcrypto = ctx->vcrypto;
 	int err;
@@ -247,19 +231,9 @@ static int virtio_crypto_alg_skcipher_close_session(
 	sg_init_one(&status_sg, &ctrl_status->status, sizeof(ctrl_status->status));
 	sgs[num_out + num_in++] = &status_sg;
 
-	spin_lock(&vcrypto->ctrl_lock);
-	err = virtqueue_add_sgs(vcrypto->ctrl_vq, sgs, num_out,
-			num_in, vcrypto, GFP_ATOMIC);
-	if (err < 0) {
-		spin_unlock(&vcrypto->ctrl_lock);
+	err = virtio_crypto_ctrl_vq_request(vcrypto, sgs, num_out, num_in, vc_ctrl_req);
+	if (err < 0)
 		goto out;
-	}
-	virtqueue_kick(vcrypto->ctrl_vq);
-
-	while (!virtqueue_get_buf(vcrypto->ctrl_vq, &tmp) &&
-	       !virtqueue_is_broken(vcrypto->ctrl_vq))
-		cpu_relax();
-	spin_unlock(&vcrypto->ctrl_lock);
 
 	if (ctrl_status->status != VIRTIO_CRYPTO_OK) {
 		pr_err("virtio_crypto: Close session failed status: %u, session_id: 0x%llx\n",
-- 
2.20.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
