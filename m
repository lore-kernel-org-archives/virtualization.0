Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 913CFC433EF
	for <virtualization@archiver.kernel.org>; Thu,  5 May 2022 09:28:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 5299B41973;
	Thu,  5 May 2022 09:28:14 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id qSybXOgzJpwV; Thu,  5 May 2022 09:28:12 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 3380B408E3;
	Thu,  5 May 2022 09:28:12 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 18304C0032;
	Thu,  5 May 2022 09:28:12 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id CBDE4C002D
 for <virtualization@lists.linux-foundation.org>;
 Thu,  5 May 2022 09:28:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id AC233414CA
 for <virtualization@lists.linux-foundation.org>;
 Thu,  5 May 2022 09:28:10 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id p7aYdrty3P7E
 for <virtualization@lists.linux-foundation.org>;
 Thu,  5 May 2022 09:28:09 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com
 [IPv6:2607:f8b0:4864:20::102c])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 859B1408E3
 for <virtualization@lists.linux-foundation.org>;
 Thu,  5 May 2022 09:28:09 +0000 (UTC)
Received: by mail-pj1-x102c.google.com with SMTP id
 l11-20020a17090a49cb00b001d923a9ca99so3602495pjm.1
 for <virtualization@lists.linux-foundation.org>;
 Thu, 05 May 2022 02:28:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance-com.20210112.gappssmtp.com; s=20210112;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=wZYZZokAYbHkoKNpRYcwId0oz7EL0chjkDT9m64Fs88=;
 b=frO0QTqQXRV8E6KGCzVWlcEM1m1UhQ4TJEualmfLMhWKVHeD9bQjGbFDa9vzYPUuka
 DeGYLwpgyIWguNfVCUiawol+ONYQQkIOy1D4AgzVvZH6JMfhehtgEQ79N3b9vrs7aMZm
 tZgP45sGboQOWU/O9DHfTYsJTT+HN5DxYL9tEeWDfMyidE942J9gtMG4RCjLoo9ZItTS
 /4YeQ4COn9FR9fxhQXGcVx2Nycfahw6gAyGLs5ToPr/apCyS/KiHsA/S3lOrGGIafymD
 3d8rRjRUYXLw9g0T+PgkqBV/F5+BSf+cvCl2lA5oQ0fif/hrULyKmFu6GtfqrObuZHiG
 QU9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=wZYZZokAYbHkoKNpRYcwId0oz7EL0chjkDT9m64Fs88=;
 b=i/bOkwLCCZWeXfoowOEGO7gLdUL/S66tFT0aCdhZUClu8bweNh3T+2Eu94/BGvbSFk
 rAsdNCb3Sjk3d5sZNOtFyr7RU2cnb6t5XEsN69OjElhVmtsVajn/LZftAEajKpIg5xs0
 XZu/k/4slLOL7DbSCTO01tiHG5GV+TWKZUm6LuUdtz2dK0WmibYa/OWZh6xlLuNYH8H3
 mnqPDaXXz1ckEHUOpAdFRImIl4+oM/4AwluPkUcBo/S+Y84RXz3yVzCig/tzeINUJbvg
 sP6at7t9EXiwbAVSm3f2SEhKU+sVkQZAFLvfYm2XAmSXjOs3N6o1pFDHXMWHMTnV5nFc
 rnRg==
X-Gm-Message-State: AOAM530Nk3k6dOABkZ8I9Ic4nVUIiTFCWzg70npKN/ZZ83buqHfNNM19
 7mAtlVbr1ns932Um4ZnKVokJng==
X-Google-Smtp-Source: ABdhPJyRhLD8aVEulYsSZpHbptbu0aq6Evj2kroR4kaUsEEuicOm6LJ0kDXiTRRvBaX9yj4McIl5XA==
X-Received: by 2002:a17:90a:a509:b0:1ca:c48e:a795 with SMTP id
 a9-20020a17090aa50900b001cac48ea795mr4842210pjq.165.1651742888960; 
 Thu, 05 May 2022 02:28:08 -0700 (PDT)
Received: from always-x1.www.tendawifi.com ([139.177.225.255])
 by smtp.gmail.com with ESMTPSA id
 t68-20020a625f47000000b0050dc76281dcsm884224pfb.182.2022.05.05.02.28.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 May 2022 02:28:08 -0700 (PDT)
From: zhenwei pi <pizhenwei@bytedance.com>
To: arei.gonglei@huawei.com,
	mst@redhat.com
Subject: [PATCH v5 1/5] virtio-crypto: change code style
Date: Thu,  5 May 2022 17:24:04 +0800
Message-Id: <20220505092408.53692-2-pizhenwei@bytedance.com>
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

Use temporary variable to make code easy to read and maintain.
	/* Pad cipher's parameters */
        vcrypto->ctrl.u.sym_create_session.op_type =
                cpu_to_le32(VIRTIO_CRYPTO_SYM_OP_CIPHER);
        vcrypto->ctrl.u.sym_create_session.u.cipher.para.algo =
                vcrypto->ctrl.header.algo;
        vcrypto->ctrl.u.sym_create_session.u.cipher.para.keylen =
                cpu_to_le32(keylen);
        vcrypto->ctrl.u.sym_create_session.u.cipher.para.op =
                cpu_to_le32(op);
-->
	sym_create_session = &ctrl->u.sym_create_session;
	sym_create_session->op_type = cpu_to_le32(VIRTIO_CRYPTO_SYM_OP_CIPHER);
	sym_create_session->u.cipher.para.algo = ctrl->header.algo;
	sym_create_session->u.cipher.para.keylen = cpu_to_le32(keylen);
	sym_create_session->u.cipher.para.op = cpu_to_le32(op);

The new style shows more obviously:
- the variable we want to operate.
- an assignment statement in a single line.

Cc: Michael S. Tsirkin <mst@redhat.com>
Cc: Jason Wang <jasowang@redhat.com>
Cc: Gonglei <arei.gonglei@huawei.com>
Signed-off-by: zhenwei pi <pizhenwei@bytedance.com>
---
 .../virtio/virtio_crypto_akcipher_algs.c      | 40 ++++++-----
 .../virtio/virtio_crypto_skcipher_algs.c      | 72 +++++++++----------
 2 files changed, 59 insertions(+), 53 deletions(-)

diff --git a/drivers/crypto/virtio/virtio_crypto_akcipher_algs.c b/drivers/crypto/virtio/virtio_crypto_akcipher_algs.c
index f3ec9420215e..20901a263fc8 100644
--- a/drivers/crypto/virtio/virtio_crypto_akcipher_algs.c
+++ b/drivers/crypto/virtio/virtio_crypto_akcipher_algs.c
@@ -106,23 +106,27 @@ static int virtio_crypto_alg_akcipher_init_session(struct virtio_crypto_akcipher
 	unsigned int inlen;
 	int err;
 	unsigned int num_out = 0, num_in = 0;
+	struct virtio_crypto_op_ctrl_req *ctrl;
+	struct virtio_crypto_session_input *input;
 
 	pkey = kmemdup(key, keylen, GFP_ATOMIC);
 	if (!pkey)
 		return -ENOMEM;
 
 	spin_lock(&vcrypto->ctrl_lock);
-	memcpy(&vcrypto->ctrl.header, header, sizeof(vcrypto->ctrl.header));
-	memcpy(&vcrypto->ctrl.u, para, sizeof(vcrypto->ctrl.u));
-	vcrypto->input.status = cpu_to_le32(VIRTIO_CRYPTO_ERR);
+	ctrl = &vcrypto->ctrl;
+	memcpy(&ctrl->header, header, sizeof(ctrl->header));
+	memcpy(&ctrl->u, para, sizeof(ctrl->u));
+	input = &vcrypto->input;
+	input->status = cpu_to_le32(VIRTIO_CRYPTO_ERR);
 
-	sg_init_one(&outhdr_sg, &vcrypto->ctrl, sizeof(vcrypto->ctrl));
+	sg_init_one(&outhdr_sg, ctrl, sizeof(*ctrl));
 	sgs[num_out++] = &outhdr_sg;
 
 	sg_init_one(&key_sg, pkey, keylen);
 	sgs[num_out++] = &key_sg;
 
-	sg_init_one(&inhdr_sg, &vcrypto->input, sizeof(vcrypto->input));
+	sg_init_one(&inhdr_sg, input, sizeof(*input));
 	sgs[num_out + num_in++] = &inhdr_sg;
 
 	err = virtqueue_add_sgs(vcrypto->ctrl_vq, sgs, num_out, num_in, vcrypto, GFP_ATOMIC);
@@ -134,12 +138,12 @@ static int virtio_crypto_alg_akcipher_init_session(struct virtio_crypto_akcipher
 	       !virtqueue_is_broken(vcrypto->ctrl_vq))
 		cpu_relax();
 
-	if (le32_to_cpu(vcrypto->input.status) != VIRTIO_CRYPTO_OK) {
+	if (le32_to_cpu(input->status) != VIRTIO_CRYPTO_OK) {
 		err = -EINVAL;
 		goto out;
 	}
 
-	ctx->session_id = le64_to_cpu(vcrypto->input.session_id);
+	ctx->session_id = le64_to_cpu(input->session_id);
 	ctx->session_valid = true;
 	err = 0;
 
@@ -149,7 +153,7 @@ static int virtio_crypto_alg_akcipher_init_session(struct virtio_crypto_akcipher
 
 	if (err < 0)
 		pr_err("virtio_crypto: Create session failed status: %u\n",
-			le32_to_cpu(vcrypto->input.status));
+			le32_to_cpu(input->status));
 
 	return err;
 }
@@ -161,23 +165,27 @@ static int virtio_crypto_alg_akcipher_close_session(struct virtio_crypto_akciphe
 	struct virtio_crypto *vcrypto = ctx->vcrypto;
 	unsigned int num_out = 0, num_in = 0, inlen;
 	int err;
+	struct virtio_crypto_op_ctrl_req *ctrl;
+	struct virtio_crypto_inhdr *ctrl_status;
 
 	spin_lock(&vcrypto->ctrl_lock);
 	if (!ctx->session_valid) {
 		err = 0;
 		goto out;
 	}
-	vcrypto->ctrl_status.status = VIRTIO_CRYPTO_ERR;
-	vcrypto->ctrl.header.opcode = cpu_to_le32(VIRTIO_CRYPTO_AKCIPHER_DESTROY_SESSION);
-	vcrypto->ctrl.header.queue_id = 0;
+	ctrl_status = &vcrypto->ctrl_status;
+	ctrl_status->status = VIRTIO_CRYPTO_ERR;
+	ctrl = &vcrypto->ctrl;
+	ctrl->header.opcode = cpu_to_le32(VIRTIO_CRYPTO_AKCIPHER_DESTROY_SESSION);
+	ctrl->header.queue_id = 0;
 
-	destroy_session = &vcrypto->ctrl.u.destroy_session;
+	destroy_session = &ctrl->u.destroy_session;
 	destroy_session->session_id = cpu_to_le64(ctx->session_id);
 
-	sg_init_one(&outhdr_sg, &vcrypto->ctrl, sizeof(vcrypto->ctrl));
+	sg_init_one(&outhdr_sg, ctrl, sizeof(*ctrl));
 	sgs[num_out++] = &outhdr_sg;
 
-	sg_init_one(&inhdr_sg, &vcrypto->ctrl_status.status, sizeof(vcrypto->ctrl_status.status));
+	sg_init_one(&inhdr_sg, &ctrl_status->status, sizeof(ctrl_status->status));
 	sgs[num_out + num_in++] = &inhdr_sg;
 
 	err = virtqueue_add_sgs(vcrypto->ctrl_vq, sgs, num_out, num_in, vcrypto, GFP_ATOMIC);
@@ -189,7 +197,7 @@ static int virtio_crypto_alg_akcipher_close_session(struct virtio_crypto_akciphe
 	       !virtqueue_is_broken(vcrypto->ctrl_vq))
 		cpu_relax();
 
-	if (vcrypto->ctrl_status.status != VIRTIO_CRYPTO_OK) {
+	if (ctrl_status->status != VIRTIO_CRYPTO_OK) {
 		err = -EINVAL;
 		goto out;
 	}
@@ -201,7 +209,7 @@ static int virtio_crypto_alg_akcipher_close_session(struct virtio_crypto_akciphe
 	spin_unlock(&vcrypto->ctrl_lock);
 	if (err < 0) {
 		pr_err("virtio_crypto: Close session failed status: %u, session_id: 0x%llx\n",
-			vcrypto->ctrl_status.status, destroy_session->session_id);
+			ctrl_status->status, destroy_session->session_id);
 	}
 
 	return err;
diff --git a/drivers/crypto/virtio/virtio_crypto_skcipher_algs.c b/drivers/crypto/virtio/virtio_crypto_skcipher_algs.c
index a618c46a52b8..e3c5bc8d6112 100644
--- a/drivers/crypto/virtio/virtio_crypto_skcipher_algs.c
+++ b/drivers/crypto/virtio/virtio_crypto_skcipher_algs.c
@@ -123,6 +123,9 @@ static int virtio_crypto_alg_skcipher_init_session(
 	int op = encrypt ? VIRTIO_CRYPTO_OP_ENCRYPT : VIRTIO_CRYPTO_OP_DECRYPT;
 	int err;
 	unsigned int num_out = 0, num_in = 0;
+	struct virtio_crypto_op_ctrl_req *ctrl;
+	struct virtio_crypto_session_input *input;
+	struct virtio_crypto_sym_create_session_req *sym_create_session;
 
 	/*
 	 * Avoid to do DMA from the stack, switch to using
@@ -135,24 +138,22 @@ static int virtio_crypto_alg_skcipher_init_session(
 
 	spin_lock(&vcrypto->ctrl_lock);
 	/* Pad ctrl header */
-	vcrypto->ctrl.header.opcode =
-		cpu_to_le32(VIRTIO_CRYPTO_CIPHER_CREATE_SESSION);
-	vcrypto->ctrl.header.algo = cpu_to_le32(alg);
+	ctrl = &vcrypto->ctrl;
+	ctrl->header.opcode = cpu_to_le32(VIRTIO_CRYPTO_CIPHER_CREATE_SESSION);
+	ctrl->header.algo = cpu_to_le32(alg);
 	/* Set the default dataqueue id to 0 */
-	vcrypto->ctrl.header.queue_id = 0;
+	ctrl->header.queue_id = 0;
 
-	vcrypto->input.status = cpu_to_le32(VIRTIO_CRYPTO_ERR);
+	input = &vcrypto->input;
+	input->status = cpu_to_le32(VIRTIO_CRYPTO_ERR);
 	/* Pad cipher's parameters */
-	vcrypto->ctrl.u.sym_create_session.op_type =
-		cpu_to_le32(VIRTIO_CRYPTO_SYM_OP_CIPHER);
-	vcrypto->ctrl.u.sym_create_session.u.cipher.para.algo =
-		vcrypto->ctrl.header.algo;
-	vcrypto->ctrl.u.sym_create_session.u.cipher.para.keylen =
-		cpu_to_le32(keylen);
-	vcrypto->ctrl.u.sym_create_session.u.cipher.para.op =
-		cpu_to_le32(op);
-
-	sg_init_one(&outhdr, &vcrypto->ctrl, sizeof(vcrypto->ctrl));
+	sym_create_session = &ctrl->u.sym_create_session;
+	sym_create_session->op_type = cpu_to_le32(VIRTIO_CRYPTO_SYM_OP_CIPHER);
+	sym_create_session->u.cipher.para.algo = ctrl->header.algo;
+	sym_create_session->u.cipher.para.keylen = cpu_to_le32(keylen);
+	sym_create_session->u.cipher.para.op = cpu_to_le32(op);
+
+	sg_init_one(&outhdr, ctrl, sizeof(*ctrl));
 	sgs[num_out++] = &outhdr;
 
 	/* Set key */
@@ -160,7 +161,7 @@ static int virtio_crypto_alg_skcipher_init_session(
 	sgs[num_out++] = &key_sg;
 
 	/* Return status and session id back */
-	sg_init_one(&inhdr, &vcrypto->input, sizeof(vcrypto->input));
+	sg_init_one(&inhdr, input, sizeof(*input));
 	sgs[num_out + num_in++] = &inhdr;
 
 	err = virtqueue_add_sgs(vcrypto->ctrl_vq, sgs, num_out,
@@ -180,20 +181,18 @@ static int virtio_crypto_alg_skcipher_init_session(
 	       !virtqueue_is_broken(vcrypto->ctrl_vq))
 		cpu_relax();
 
-	if (le32_to_cpu(vcrypto->input.status) != VIRTIO_CRYPTO_OK) {
+	if (le32_to_cpu(input->status) != VIRTIO_CRYPTO_OK) {
 		spin_unlock(&vcrypto->ctrl_lock);
 		pr_err("virtio_crypto: Create session failed status: %u\n",
-			le32_to_cpu(vcrypto->input.status));
+			le32_to_cpu(input->status));
 		kfree_sensitive(cipher_key);
 		return -EINVAL;
 	}
 
 	if (encrypt)
-		ctx->enc_sess_info.session_id =
-			le64_to_cpu(vcrypto->input.session_id);
+		ctx->enc_sess_info.session_id = le64_to_cpu(input->session_id);
 	else
-		ctx->dec_sess_info.session_id =
-			le64_to_cpu(vcrypto->input.session_id);
+		ctx->dec_sess_info.session_id = le64_to_cpu(input->session_id);
 
 	spin_unlock(&vcrypto->ctrl_lock);
 
@@ -211,30 +210,30 @@ static int virtio_crypto_alg_skcipher_close_session(
 	struct virtio_crypto *vcrypto = ctx->vcrypto;
 	int err;
 	unsigned int num_out = 0, num_in = 0;
+	struct virtio_crypto_op_ctrl_req *ctrl;
+	struct virtio_crypto_inhdr *ctrl_status;
 
 	spin_lock(&vcrypto->ctrl_lock);
-	vcrypto->ctrl_status.status = VIRTIO_CRYPTO_ERR;
+	ctrl_status = &vcrypto->ctrl_status;
+	ctrl_status->status = VIRTIO_CRYPTO_ERR;
 	/* Pad ctrl header */
-	vcrypto->ctrl.header.opcode =
-		cpu_to_le32(VIRTIO_CRYPTO_CIPHER_DESTROY_SESSION);
+	ctrl = &vcrypto->ctrl;
+	ctrl->header.opcode = cpu_to_le32(VIRTIO_CRYPTO_CIPHER_DESTROY_SESSION);
 	/* Set the default virtqueue id to 0 */
-	vcrypto->ctrl.header.queue_id = 0;
+	ctrl->header.queue_id = 0;
 
-	destroy_session = &vcrypto->ctrl.u.destroy_session;
+	destroy_session = &ctrl->u.destroy_session;
 
 	if (encrypt)
-		destroy_session->session_id =
-			cpu_to_le64(ctx->enc_sess_info.session_id);
+		destroy_session->session_id = cpu_to_le64(ctx->enc_sess_info.session_id);
 	else
-		destroy_session->session_id =
-			cpu_to_le64(ctx->dec_sess_info.session_id);
+		destroy_session->session_id = cpu_to_le64(ctx->dec_sess_info.session_id);
 
-	sg_init_one(&outhdr, &vcrypto->ctrl, sizeof(vcrypto->ctrl));
+	sg_init_one(&outhdr, ctrl, sizeof(*ctrl));
 	sgs[num_out++] = &outhdr;
 
 	/* Return status and session id back */
-	sg_init_one(&status_sg, &vcrypto->ctrl_status.status,
-		sizeof(vcrypto->ctrl_status.status));
+	sg_init_one(&status_sg, &ctrl_status->status, sizeof(ctrl_status->status));
 	sgs[num_out + num_in++] = &status_sg;
 
 	err = virtqueue_add_sgs(vcrypto->ctrl_vq, sgs, num_out,
@@ -249,11 +248,10 @@ static int virtio_crypto_alg_skcipher_close_session(
 	       !virtqueue_is_broken(vcrypto->ctrl_vq))
 		cpu_relax();
 
-	if (vcrypto->ctrl_status.status != VIRTIO_CRYPTO_OK) {
+	if (ctrl_status->status != VIRTIO_CRYPTO_OK) {
 		spin_unlock(&vcrypto->ctrl_lock);
 		pr_err("virtio_crypto: Close session failed status: %u, session_id: 0x%llx\n",
-			vcrypto->ctrl_status.status,
-			destroy_session->session_id);
+			ctrl_status->status, destroy_session->session_id);
 
 		return -EINVAL;
 	}
-- 
2.20.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
