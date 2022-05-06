Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3408BC433F5
	for <virtualization@archiver.kernel.org>; Fri,  6 May 2022 08:46:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id CF2B582AC8;
	Fri,  6 May 2022 08:46:14 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id nbnyFwuQssmX; Fri,  6 May 2022 08:46:13 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 24E9283E2B;
	Fri,  6 May 2022 08:46:13 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id EFE6AC0032;
	Fri,  6 May 2022 08:46:12 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D8C95C002D
 for <virtualization@lists.linux-foundation.org>;
 Fri,  6 May 2022 08:46:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id B83F760BF1
 for <virtualization@lists.linux-foundation.org>;
 Fri,  6 May 2022 08:46:11 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id i1iOsBD2woUL
 for <virtualization@lists.linux-foundation.org>;
 Fri,  6 May 2022 08:46:10 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 3007760BDE
 for <virtualization@lists.linux-foundation.org>;
 Fri,  6 May 2022 08:46:10 +0000 (UTC)
Received: from kwepemi100011.china.huawei.com (unknown [172.30.72.55])
 by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4Kvkfk4HRdzhYsr;
 Fri,  6 May 2022 16:45:34 +0800 (CST)
Received: from dggpemm500006.china.huawei.com (7.185.36.236) by
 kwepemi100011.china.huawei.com (7.221.188.134) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Fri, 6 May 2022 16:46:05 +0800
Received: from dggpemm500006.china.huawei.com ([7.185.36.236]) by
 dggpemm500006.china.huawei.com ([7.185.36.236]) with mapi id 15.01.2375.024;
 Fri, 6 May 2022 16:46:05 +0800
To: zhenwei pi <pizhenwei@bytedance.com>, "mst@redhat.com" <mst@redhat.com>
Subject: RE: [PATCH v5 1/5] virtio-crypto: change code style
Thread-Topic: [PATCH v5 1/5] virtio-crypto: change code style
Thread-Index: AQHYYGJyKlbG6BEKlEqTBv/8O69Kua0RioCQ
Date: Fri, 6 May 2022 08:46:05 +0000
Message-ID: <86a52ae52f9a4d9988daf56a3ebf8c5e@huawei.com>
References: <20220505092408.53692-1-pizhenwei@bytedance.com>
 <20220505092408.53692-2-pizhenwei@bytedance.com>
In-Reply-To: <20220505092408.53692-2-pizhenwei@bytedance.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.174.149.11]
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Cc: "helei.sig11@bytedance.com" <helei.sig11@bytedance.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>,
 "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
 "davem@davemloft.net" <davem@davemloft.net>,
 "herbert@gondor.apana.org.au" <herbert@gondor.apana.org.au>
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
From: "Gonglei \(Arei\) via Virtualization"
 <virtualization@lists.linux-foundation.org>
Reply-To: "Gonglei \(Arei\)" <arei.gonglei@huawei.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>



> -----Original Message-----
> From: zhenwei pi [mailto:pizhenwei@bytedance.com]
> Sent: Thursday, May 5, 2022 5:24 PM
> To: Gonglei (Arei) <arei.gonglei@huawei.com>; mst@redhat.com
> Cc: jasowang@redhat.com; herbert@gondor.apana.org.au;
> linux-kernel@vger.kernel.org; virtualization@lists.linux-foundation.org;
> linux-crypto@vger.kernel.org; helei.sig11@bytedance.com;
> pizhenwei@bytedance.com; davem@davemloft.net
> Subject: [PATCH v5 1/5] virtio-crypto: change code style
> 
> Use temporary variable to make code easy to read and maintain.
> 	/* Pad cipher's parameters */
>         vcrypto->ctrl.u.sym_create_session.op_type =
>                 cpu_to_le32(VIRTIO_CRYPTO_SYM_OP_CIPHER);
>         vcrypto->ctrl.u.sym_create_session.u.cipher.para.algo =
>                 vcrypto->ctrl.header.algo;
>         vcrypto->ctrl.u.sym_create_session.u.cipher.para.keylen =
>                 cpu_to_le32(keylen);
>         vcrypto->ctrl.u.sym_create_session.u.cipher.para.op =
>                 cpu_to_le32(op);
> -->
> 	sym_create_session = &ctrl->u.sym_create_session;
> 	sym_create_session->op_type =
> cpu_to_le32(VIRTIO_CRYPTO_SYM_OP_CIPHER);
> 	sym_create_session->u.cipher.para.algo = ctrl->header.algo;
> 	sym_create_session->u.cipher.para.keylen = cpu_to_le32(keylen);
> 	sym_create_session->u.cipher.para.op = cpu_to_le32(op);
> 
> The new style shows more obviously:
> - the variable we want to operate.
> - an assignment statement in a single line.
> 
> Cc: Michael S. Tsirkin <mst@redhat.com>
> Cc: Jason Wang <jasowang@redhat.com>
> Cc: Gonglei <arei.gonglei@huawei.com>
> Signed-off-by: zhenwei pi <pizhenwei@bytedance.com>
> ---
>  .../virtio/virtio_crypto_akcipher_algs.c      | 40 ++++++-----
>  .../virtio/virtio_crypto_skcipher_algs.c      | 72 +++++++++----------
>  2 files changed, 59 insertions(+), 53 deletions(-)
> 

Reviewed-by: Gonglei <arei.gonglei@huawei.com>

Regards,
-Gonglei

> diff --git a/drivers/crypto/virtio/virtio_crypto_akcipher_algs.c
> b/drivers/crypto/virtio/virtio_crypto_akcipher_algs.c
> index f3ec9420215e..20901a263fc8 100644
> --- a/drivers/crypto/virtio/virtio_crypto_akcipher_algs.c
> +++ b/drivers/crypto/virtio/virtio_crypto_akcipher_algs.c
> @@ -106,23 +106,27 @@ static int
> virtio_crypto_alg_akcipher_init_session(struct virtio_crypto_akcipher
>  	unsigned int inlen;
>  	int err;
>  	unsigned int num_out = 0, num_in = 0;
> +	struct virtio_crypto_op_ctrl_req *ctrl;
> +	struct virtio_crypto_session_input *input;
> 
>  	pkey = kmemdup(key, keylen, GFP_ATOMIC);
>  	if (!pkey)
>  		return -ENOMEM;
> 
>  	spin_lock(&vcrypto->ctrl_lock);
> -	memcpy(&vcrypto->ctrl.header, header, sizeof(vcrypto->ctrl.header));
> -	memcpy(&vcrypto->ctrl.u, para, sizeof(vcrypto->ctrl.u));
> -	vcrypto->input.status = cpu_to_le32(VIRTIO_CRYPTO_ERR);
> +	ctrl = &vcrypto->ctrl;
> +	memcpy(&ctrl->header, header, sizeof(ctrl->header));
> +	memcpy(&ctrl->u, para, sizeof(ctrl->u));
> +	input = &vcrypto->input;
> +	input->status = cpu_to_le32(VIRTIO_CRYPTO_ERR);
> 
> -	sg_init_one(&outhdr_sg, &vcrypto->ctrl, sizeof(vcrypto->ctrl));
> +	sg_init_one(&outhdr_sg, ctrl, sizeof(*ctrl));
>  	sgs[num_out++] = &outhdr_sg;
> 
>  	sg_init_one(&key_sg, pkey, keylen);
>  	sgs[num_out++] = &key_sg;
> 
> -	sg_init_one(&inhdr_sg, &vcrypto->input, sizeof(vcrypto->input));
> +	sg_init_one(&inhdr_sg, input, sizeof(*input));
>  	sgs[num_out + num_in++] = &inhdr_sg;
> 
>  	err = virtqueue_add_sgs(vcrypto->ctrl_vq, sgs, num_out, num_in, vcrypto,
> GFP_ATOMIC); @@ -134,12 +138,12 @@ static int
> virtio_crypto_alg_akcipher_init_session(struct virtio_crypto_akcipher
>  	       !virtqueue_is_broken(vcrypto->ctrl_vq))
>  		cpu_relax();
> 
> -	if (le32_to_cpu(vcrypto->input.status) != VIRTIO_CRYPTO_OK) {
> +	if (le32_to_cpu(input->status) != VIRTIO_CRYPTO_OK) {
>  		err = -EINVAL;
>  		goto out;
>  	}
> 
> -	ctx->session_id = le64_to_cpu(vcrypto->input.session_id);
> +	ctx->session_id = le64_to_cpu(input->session_id);
>  	ctx->session_valid = true;
>  	err = 0;
> 
> @@ -149,7 +153,7 @@ static int
> virtio_crypto_alg_akcipher_init_session(struct virtio_crypto_akcipher
> 
>  	if (err < 0)
>  		pr_err("virtio_crypto: Create session failed status: %u\n",
> -			le32_to_cpu(vcrypto->input.status));
> +			le32_to_cpu(input->status));
> 
>  	return err;
>  }
> @@ -161,23 +165,27 @@ static int
> virtio_crypto_alg_akcipher_close_session(struct virtio_crypto_akciphe
>  	struct virtio_crypto *vcrypto = ctx->vcrypto;
>  	unsigned int num_out = 0, num_in = 0, inlen;
>  	int err;
> +	struct virtio_crypto_op_ctrl_req *ctrl;
> +	struct virtio_crypto_inhdr *ctrl_status;
> 
>  	spin_lock(&vcrypto->ctrl_lock);
>  	if (!ctx->session_valid) {
>  		err = 0;
>  		goto out;
>  	}
> -	vcrypto->ctrl_status.status = VIRTIO_CRYPTO_ERR;
> -	vcrypto->ctrl.header.opcode =
> cpu_to_le32(VIRTIO_CRYPTO_AKCIPHER_DESTROY_SESSION);
> -	vcrypto->ctrl.header.queue_id = 0;
> +	ctrl_status = &vcrypto->ctrl_status;
> +	ctrl_status->status = VIRTIO_CRYPTO_ERR;
> +	ctrl = &vcrypto->ctrl;
> +	ctrl->header.opcode =
> cpu_to_le32(VIRTIO_CRYPTO_AKCIPHER_DESTROY_SESSION);
> +	ctrl->header.queue_id = 0;
> 
> -	destroy_session = &vcrypto->ctrl.u.destroy_session;
> +	destroy_session = &ctrl->u.destroy_session;
>  	destroy_session->session_id = cpu_to_le64(ctx->session_id);
> 
> -	sg_init_one(&outhdr_sg, &vcrypto->ctrl, sizeof(vcrypto->ctrl));
> +	sg_init_one(&outhdr_sg, ctrl, sizeof(*ctrl));
>  	sgs[num_out++] = &outhdr_sg;
> 
> -	sg_init_one(&inhdr_sg, &vcrypto->ctrl_status.status,
> sizeof(vcrypto->ctrl_status.status));
> +	sg_init_one(&inhdr_sg, &ctrl_status->status,
> +sizeof(ctrl_status->status));
>  	sgs[num_out + num_in++] = &inhdr_sg;
> 
>  	err = virtqueue_add_sgs(vcrypto->ctrl_vq, sgs, num_out, num_in, vcrypto,
> GFP_ATOMIC); @@ -189,7 +197,7 @@ static int
> virtio_crypto_alg_akcipher_close_session(struct virtio_crypto_akciphe
>  	       !virtqueue_is_broken(vcrypto->ctrl_vq))
>  		cpu_relax();
> 
> -	if (vcrypto->ctrl_status.status != VIRTIO_CRYPTO_OK) {
> +	if (ctrl_status->status != VIRTIO_CRYPTO_OK) {
>  		err = -EINVAL;
>  		goto out;
>  	}
> @@ -201,7 +209,7 @@ static int
> virtio_crypto_alg_akcipher_close_session(struct virtio_crypto_akciphe
>  	spin_unlock(&vcrypto->ctrl_lock);
>  	if (err < 0) {
>  		pr_err("virtio_crypto: Close session failed status: %u, session_id:
> 0x%llx\n",
> -			vcrypto->ctrl_status.status, destroy_session->session_id);
> +			ctrl_status->status, destroy_session->session_id);
>  	}
> 
>  	return err;
> diff --git a/drivers/crypto/virtio/virtio_crypto_skcipher_algs.c
> b/drivers/crypto/virtio/virtio_crypto_skcipher_algs.c
> index a618c46a52b8..e3c5bc8d6112 100644
> --- a/drivers/crypto/virtio/virtio_crypto_skcipher_algs.c
> +++ b/drivers/crypto/virtio/virtio_crypto_skcipher_algs.c
> @@ -123,6 +123,9 @@ static int virtio_crypto_alg_skcipher_init_session(
>  	int op = encrypt ? VIRTIO_CRYPTO_OP_ENCRYPT :
> VIRTIO_CRYPTO_OP_DECRYPT;
>  	int err;
>  	unsigned int num_out = 0, num_in = 0;
> +	struct virtio_crypto_op_ctrl_req *ctrl;
> +	struct virtio_crypto_session_input *input;
> +	struct virtio_crypto_sym_create_session_req *sym_create_session;
> 
>  	/*
>  	 * Avoid to do DMA from the stack, switch to using @@ -135,24 +138,22
> @@ static int virtio_crypto_alg_skcipher_init_session(
> 
>  	spin_lock(&vcrypto->ctrl_lock);
>  	/* Pad ctrl header */
> -	vcrypto->ctrl.header.opcode =
> -		cpu_to_le32(VIRTIO_CRYPTO_CIPHER_CREATE_SESSION);
> -	vcrypto->ctrl.header.algo = cpu_to_le32(alg);
> +	ctrl = &vcrypto->ctrl;
> +	ctrl->header.opcode =
> cpu_to_le32(VIRTIO_CRYPTO_CIPHER_CREATE_SESSION);
> +	ctrl->header.algo = cpu_to_le32(alg);
>  	/* Set the default dataqueue id to 0 */
> -	vcrypto->ctrl.header.queue_id = 0;
> +	ctrl->header.queue_id = 0;
> 
> -	vcrypto->input.status = cpu_to_le32(VIRTIO_CRYPTO_ERR);
> +	input = &vcrypto->input;
> +	input->status = cpu_to_le32(VIRTIO_CRYPTO_ERR);
>  	/* Pad cipher's parameters */
> -	vcrypto->ctrl.u.sym_create_session.op_type =
> -		cpu_to_le32(VIRTIO_CRYPTO_SYM_OP_CIPHER);
> -	vcrypto->ctrl.u.sym_create_session.u.cipher.para.algo =
> -		vcrypto->ctrl.header.algo;
> -	vcrypto->ctrl.u.sym_create_session.u.cipher.para.keylen =
> -		cpu_to_le32(keylen);
> -	vcrypto->ctrl.u.sym_create_session.u.cipher.para.op =
> -		cpu_to_le32(op);
> -
> -	sg_init_one(&outhdr, &vcrypto->ctrl, sizeof(vcrypto->ctrl));
> +	sym_create_session = &ctrl->u.sym_create_session;
> +	sym_create_session->op_type =
> cpu_to_le32(VIRTIO_CRYPTO_SYM_OP_CIPHER);
> +	sym_create_session->u.cipher.para.algo = ctrl->header.algo;
> +	sym_create_session->u.cipher.para.keylen = cpu_to_le32(keylen);
> +	sym_create_session->u.cipher.para.op = cpu_to_le32(op);
> +
> +	sg_init_one(&outhdr, ctrl, sizeof(*ctrl));
>  	sgs[num_out++] = &outhdr;
> 
>  	/* Set key */
> @@ -160,7 +161,7 @@ static int virtio_crypto_alg_skcipher_init_session(
>  	sgs[num_out++] = &key_sg;
> 
>  	/* Return status and session id back */
> -	sg_init_one(&inhdr, &vcrypto->input, sizeof(vcrypto->input));
> +	sg_init_one(&inhdr, input, sizeof(*input));
>  	sgs[num_out + num_in++] = &inhdr;
> 
>  	err = virtqueue_add_sgs(vcrypto->ctrl_vq, sgs, num_out, @@ -180,20
> +181,18 @@ static int virtio_crypto_alg_skcipher_init_session(
>  	       !virtqueue_is_broken(vcrypto->ctrl_vq))
>  		cpu_relax();
> 
> -	if (le32_to_cpu(vcrypto->input.status) != VIRTIO_CRYPTO_OK) {
> +	if (le32_to_cpu(input->status) != VIRTIO_CRYPTO_OK) {
>  		spin_unlock(&vcrypto->ctrl_lock);
>  		pr_err("virtio_crypto: Create session failed status: %u\n",
> -			le32_to_cpu(vcrypto->input.status));
> +			le32_to_cpu(input->status));
>  		kfree_sensitive(cipher_key);
>  		return -EINVAL;
>  	}
> 
>  	if (encrypt)
> -		ctx->enc_sess_info.session_id =
> -			le64_to_cpu(vcrypto->input.session_id);
> +		ctx->enc_sess_info.session_id = le64_to_cpu(input->session_id);
>  	else
> -		ctx->dec_sess_info.session_id =
> -			le64_to_cpu(vcrypto->input.session_id);
> +		ctx->dec_sess_info.session_id = le64_to_cpu(input->session_id);
> 
>  	spin_unlock(&vcrypto->ctrl_lock);
> 
> @@ -211,30 +210,30 @@ static int virtio_crypto_alg_skcipher_close_session(
>  	struct virtio_crypto *vcrypto = ctx->vcrypto;
>  	int err;
>  	unsigned int num_out = 0, num_in = 0;
> +	struct virtio_crypto_op_ctrl_req *ctrl;
> +	struct virtio_crypto_inhdr *ctrl_status;
> 
>  	spin_lock(&vcrypto->ctrl_lock);
> -	vcrypto->ctrl_status.status = VIRTIO_CRYPTO_ERR;
> +	ctrl_status = &vcrypto->ctrl_status;
> +	ctrl_status->status = VIRTIO_CRYPTO_ERR;
>  	/* Pad ctrl header */
> -	vcrypto->ctrl.header.opcode =
> -		cpu_to_le32(VIRTIO_CRYPTO_CIPHER_DESTROY_SESSION);
> +	ctrl = &vcrypto->ctrl;
> +	ctrl->header.opcode =
> +cpu_to_le32(VIRTIO_CRYPTO_CIPHER_DESTROY_SESSION);
>  	/* Set the default virtqueue id to 0 */
> -	vcrypto->ctrl.header.queue_id = 0;
> +	ctrl->header.queue_id = 0;
> 
> -	destroy_session = &vcrypto->ctrl.u.destroy_session;
> +	destroy_session = &ctrl->u.destroy_session;
> 
>  	if (encrypt)
> -		destroy_session->session_id =
> -			cpu_to_le64(ctx->enc_sess_info.session_id);
> +		destroy_session->session_id =
> +cpu_to_le64(ctx->enc_sess_info.session_id);
>  	else
> -		destroy_session->session_id =
> -			cpu_to_le64(ctx->dec_sess_info.session_id);
> +		destroy_session->session_id =
> +cpu_to_le64(ctx->dec_sess_info.session_id);
> 
> -	sg_init_one(&outhdr, &vcrypto->ctrl, sizeof(vcrypto->ctrl));
> +	sg_init_one(&outhdr, ctrl, sizeof(*ctrl));
>  	sgs[num_out++] = &outhdr;
> 
>  	/* Return status and session id back */
> -	sg_init_one(&status_sg, &vcrypto->ctrl_status.status,
> -		sizeof(vcrypto->ctrl_status.status));
> +	sg_init_one(&status_sg, &ctrl_status->status,
> +sizeof(ctrl_status->status));
>  	sgs[num_out + num_in++] = &status_sg;
> 
>  	err = virtqueue_add_sgs(vcrypto->ctrl_vq, sgs, num_out, @@ -249,11
> +248,10 @@ static int virtio_crypto_alg_skcipher_close_session(
>  	       !virtqueue_is_broken(vcrypto->ctrl_vq))
>  		cpu_relax();
> 
> -	if (vcrypto->ctrl_status.status != VIRTIO_CRYPTO_OK) {
> +	if (ctrl_status->status != VIRTIO_CRYPTO_OK) {
>  		spin_unlock(&vcrypto->ctrl_lock);
>  		pr_err("virtio_crypto: Close session failed status: %u, session_id:
> 0x%llx\n",
> -			vcrypto->ctrl_status.status,
> -			destroy_session->session_id);
> +			ctrl_status->status, destroy_session->session_id);
> 
>  		return -EINVAL;
>  	}
> --
> 2.20.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
