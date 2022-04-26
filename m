Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6D1EC433F5
	for <virtualization@archiver.kernel.org>; Tue, 26 Apr 2022 06:13:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 79CEC8143F;
	Tue, 26 Apr 2022 06:13:09 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id OTMq79pB-NLK; Tue, 26 Apr 2022 06:13:08 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id AE30B81446;
	Tue, 26 Apr 2022 06:13:07 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 75B65C0039;
	Tue, 26 Apr 2022 06:13:07 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id AAC4EC002D
 for <virtualization@lists.linux-foundation.org>;
 Tue, 26 Apr 2022 06:13:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 88E1581446
 for <virtualization@lists.linux-foundation.org>;
 Tue, 26 Apr 2022 06:13:06 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id kd557kzyJw92
 for <virtualization@lists.linux-foundation.org>;
 Tue, 26 Apr 2022 06:13:04 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 4A2FD8143F
 for <virtualization@lists.linux-foundation.org>;
 Tue, 26 Apr 2022 06:13:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1650953582;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=IgcCC54HWlFAQ3ErnpZAkoxSmmx2K6ZzpSDRxVFvmN0=;
 b=a02P7hfV8YQKv0+t+DnzTFYWhueJlaeqHNMwhuyeorZA5V0L2LcA8AHgVmxfVtDGRLuPaQ
 SkWe0qIp+LuvUmd2TUjvvQzV7IWJj4HuV4Xsu9k2m07K2IR/qT7VxnUqeCZyH+h2Uoip4g
 EST7LHUGu9PwKznMVxjg6U7ZQ8bidjs=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-460-XxwXXOBdPy2i43adcBcTvw-1; Tue, 26 Apr 2022 02:13:00 -0400
X-MC-Unique: XxwXXOBdPy2i43adcBcTvw-1
Received: by mail-lj1-f199.google.com with SMTP id
 h22-20020a2e9016000000b0024dbafdc47bso4213196ljg.23
 for <virtualization@lists.linux-foundation.org>;
 Mon, 25 Apr 2022 23:13:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=IgcCC54HWlFAQ3ErnpZAkoxSmmx2K6ZzpSDRxVFvmN0=;
 b=nAhajYP+ORBbtE7x9CTcDQhFtqqtaWloaWtj1sy5rU457uJlbteBpQlH4KCvrlXg/v
 WcEt4xiaIltGQc6g18+riG2GCda9vqP1PQr3veDI97G4GYdnESw9c3SuLerz9e17mv02
 NXb6rY9WA9QwtmG9kYys2E2Ziax1j6gilX/xqo/bs3mWs9zBJxFPDqZ9/4qjh5Q335QN
 xPLv8cZPMA90UpJZmyq+Y7v0Ef8hnawDtUsTPMqp+QX0rFy3yD87KvtInG0E54qUgmVc
 aF+UTZLHVr0DkNKk5JnXwnylfB19BULvzHu6Zu+zXlwRICAKImTivT4uqrBf6JPR7ceT
 pytw==
X-Gm-Message-State: AOAM531mX+aAtMjxaiJpdfTUYvSt4zBnEGfjrP7XSNxGzDk//Ab6Gad3
 nlEPSpg1it1+bAm45GILCgdxvfwPi2kyyZCmWBkgmUuxni8G/NDFpBbBMzWchD4x6hStyIuhiLx
 TITEzpWqf++T62dFY71WWg89T5TQRlWqTDtisUIF+Ad7I/iRUasGCAr8RAw==
X-Received: by 2002:a05:6512:1395:b0:446:d382:79a5 with SMTP id
 p21-20020a056512139500b00446d38279a5mr15311155lfa.210.1650953579363; 
 Mon, 25 Apr 2022 23:12:59 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwmOmSK4d0erkiX3LcwazyGWu55/BLRoP/5cllUj+Rcjf7WbhkerrOUWV1AhC8Rspd9uYKFT8uXgYeiP46dGSM=
X-Received: by 2002:a05:6512:1395:b0:446:d382:79a5 with SMTP id
 p21-20020a056512139500b00446d38279a5mr15311140lfa.210.1650953579139; Mon, 25
 Apr 2022 23:12:59 -0700 (PDT)
MIME-Version: 1.0
References: <20220424104140.44841-1-pizhenwei@bytedance.com>
 <20220424104140.44841-2-pizhenwei@bytedance.com>
In-Reply-To: <20220424104140.44841-2-pizhenwei@bytedance.com>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 26 Apr 2022 14:12:47 +0800
Message-ID: <CACGkMEu+V6-+OTDnEJH+zORF6SSRhPjVWAyBWQ259RHKtNiShA@mail.gmail.com>
Subject: Re: [PATCH v4 1/5] virtio-crypto: change code style
To: zhenwei pi <pizhenwei@bytedance.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: Herbert Xu <herbert@gondor.apana.org.au>, mst <mst@redhat.com>,
 linux-kernel <linux-kernel@vger.kernel.org>,
 virtualization <virtualization@lists.linux-foundation.org>,
 linux-crypto@vger.kernel.org, davem <davem@davemloft.net>,
 helei.sig11@bytedance.com
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

On Sun, Apr 24, 2022 at 6:45 PM zhenwei pi <pizhenwei@bytedance.com> wrote:
>
> Use temporary variable to make code easy to read and maintain.
>         /* Pad cipher's parameters */
>         vcrypto->ctrl.u.sym_create_session.op_type =
>                 cpu_to_le32(VIRTIO_CRYPTO_SYM_OP_CIPHER);
>         vcrypto->ctrl.u.sym_create_session.u.cipher.para.algo =
>                 vcrypto->ctrl.header.algo;
>         vcrypto->ctrl.u.sym_create_session.u.cipher.para.keylen =
>                 cpu_to_le32(keylen);
>         vcrypto->ctrl.u.sym_create_session.u.cipher.para.op =
>                 cpu_to_le32(op);
> -->
>         sym_create_session = &ctrl->u.sym_create_session;
>         sym_create_session->op_type = cpu_to_le32(VIRTIO_CRYPTO_SYM_OP_CIPHER);
>         sym_create_session->u.cipher.para.algo = ctrl->header.algo;
>         sym_create_session->u.cipher.para.keylen = cpu_to_le32(keylen);
>         sym_create_session->u.cipher.para.op = cpu_to_le32(op);
>
> The new style shows more obviously:
> - the variable we want to operate.
> - an assignment statement in a single line.

Still hundreds of lines of changes, I'd leave this change to other
mainters to dedice.

Thanks

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
> diff --git a/drivers/crypto/virtio/virtio_crypto_akcipher_algs.c b/drivers/crypto/virtio/virtio_crypto_akcipher_algs.c
> index f3ec9420215e..20901a263fc8 100644
> --- a/drivers/crypto/virtio/virtio_crypto_akcipher_algs.c
> +++ b/drivers/crypto/virtio/virtio_crypto_akcipher_algs.c
> @@ -106,23 +106,27 @@ static int virtio_crypto_alg_akcipher_init_session(struct virtio_crypto_akcipher
>         unsigned int inlen;
>         int err;
>         unsigned int num_out = 0, num_in = 0;
> +       struct virtio_crypto_op_ctrl_req *ctrl;
> +       struct virtio_crypto_session_input *input;
>
>         pkey = kmemdup(key, keylen, GFP_ATOMIC);
>         if (!pkey)
>                 return -ENOMEM;
>
>         spin_lock(&vcrypto->ctrl_lock);
> -       memcpy(&vcrypto->ctrl.header, header, sizeof(vcrypto->ctrl.header));
> -       memcpy(&vcrypto->ctrl.u, para, sizeof(vcrypto->ctrl.u));
> -       vcrypto->input.status = cpu_to_le32(VIRTIO_CRYPTO_ERR);
> +       ctrl = &vcrypto->ctrl;
> +       memcpy(&ctrl->header, header, sizeof(ctrl->header));
> +       memcpy(&ctrl->u, para, sizeof(ctrl->u));
> +       input = &vcrypto->input;
> +       input->status = cpu_to_le32(VIRTIO_CRYPTO_ERR);
>
> -       sg_init_one(&outhdr_sg, &vcrypto->ctrl, sizeof(vcrypto->ctrl));
> +       sg_init_one(&outhdr_sg, ctrl, sizeof(*ctrl));
>         sgs[num_out++] = &outhdr_sg;
>
>         sg_init_one(&key_sg, pkey, keylen);
>         sgs[num_out++] = &key_sg;
>
> -       sg_init_one(&inhdr_sg, &vcrypto->input, sizeof(vcrypto->input));
> +       sg_init_one(&inhdr_sg, input, sizeof(*input));
>         sgs[num_out + num_in++] = &inhdr_sg;
>
>         err = virtqueue_add_sgs(vcrypto->ctrl_vq, sgs, num_out, num_in, vcrypto, GFP_ATOMIC);
> @@ -134,12 +138,12 @@ static int virtio_crypto_alg_akcipher_init_session(struct virtio_crypto_akcipher
>                !virtqueue_is_broken(vcrypto->ctrl_vq))
>                 cpu_relax();
>
> -       if (le32_to_cpu(vcrypto->input.status) != VIRTIO_CRYPTO_OK) {
> +       if (le32_to_cpu(input->status) != VIRTIO_CRYPTO_OK) {
>                 err = -EINVAL;
>                 goto out;
>         }
>
> -       ctx->session_id = le64_to_cpu(vcrypto->input.session_id);
> +       ctx->session_id = le64_to_cpu(input->session_id);
>         ctx->session_valid = true;
>         err = 0;
>
> @@ -149,7 +153,7 @@ static int virtio_crypto_alg_akcipher_init_session(struct virtio_crypto_akcipher
>
>         if (err < 0)
>                 pr_err("virtio_crypto: Create session failed status: %u\n",
> -                       le32_to_cpu(vcrypto->input.status));
> +                       le32_to_cpu(input->status));
>
>         return err;
>  }
> @@ -161,23 +165,27 @@ static int virtio_crypto_alg_akcipher_close_session(struct virtio_crypto_akciphe
>         struct virtio_crypto *vcrypto = ctx->vcrypto;
>         unsigned int num_out = 0, num_in = 0, inlen;
>         int err;
> +       struct virtio_crypto_op_ctrl_req *ctrl;
> +       struct virtio_crypto_inhdr *ctrl_status;
>
>         spin_lock(&vcrypto->ctrl_lock);
>         if (!ctx->session_valid) {
>                 err = 0;
>                 goto out;
>         }
> -       vcrypto->ctrl_status.status = VIRTIO_CRYPTO_ERR;
> -       vcrypto->ctrl.header.opcode = cpu_to_le32(VIRTIO_CRYPTO_AKCIPHER_DESTROY_SESSION);
> -       vcrypto->ctrl.header.queue_id = 0;
> +       ctrl_status = &vcrypto->ctrl_status;
> +       ctrl_status->status = VIRTIO_CRYPTO_ERR;
> +       ctrl = &vcrypto->ctrl;
> +       ctrl->header.opcode = cpu_to_le32(VIRTIO_CRYPTO_AKCIPHER_DESTROY_SESSION);
> +       ctrl->header.queue_id = 0;
>
> -       destroy_session = &vcrypto->ctrl.u.destroy_session;
> +       destroy_session = &ctrl->u.destroy_session;
>         destroy_session->session_id = cpu_to_le64(ctx->session_id);
>
> -       sg_init_one(&outhdr_sg, &vcrypto->ctrl, sizeof(vcrypto->ctrl));
> +       sg_init_one(&outhdr_sg, ctrl, sizeof(*ctrl));
>         sgs[num_out++] = &outhdr_sg;
>
> -       sg_init_one(&inhdr_sg, &vcrypto->ctrl_status.status, sizeof(vcrypto->ctrl_status.status));
> +       sg_init_one(&inhdr_sg, &ctrl_status->status, sizeof(ctrl_status->status));
>         sgs[num_out + num_in++] = &inhdr_sg;
>
>         err = virtqueue_add_sgs(vcrypto->ctrl_vq, sgs, num_out, num_in, vcrypto, GFP_ATOMIC);
> @@ -189,7 +197,7 @@ static int virtio_crypto_alg_akcipher_close_session(struct virtio_crypto_akciphe
>                !virtqueue_is_broken(vcrypto->ctrl_vq))
>                 cpu_relax();
>
> -       if (vcrypto->ctrl_status.status != VIRTIO_CRYPTO_OK) {
> +       if (ctrl_status->status != VIRTIO_CRYPTO_OK) {
>                 err = -EINVAL;
>                 goto out;
>         }
> @@ -201,7 +209,7 @@ static int virtio_crypto_alg_akcipher_close_session(struct virtio_crypto_akciphe
>         spin_unlock(&vcrypto->ctrl_lock);
>         if (err < 0) {
>                 pr_err("virtio_crypto: Close session failed status: %u, session_id: 0x%llx\n",
> -                       vcrypto->ctrl_status.status, destroy_session->session_id);
> +                       ctrl_status->status, destroy_session->session_id);
>         }
>
>         return err;
> diff --git a/drivers/crypto/virtio/virtio_crypto_skcipher_algs.c b/drivers/crypto/virtio/virtio_crypto_skcipher_algs.c
> index a618c46a52b8..e3c5bc8d6112 100644
> --- a/drivers/crypto/virtio/virtio_crypto_skcipher_algs.c
> +++ b/drivers/crypto/virtio/virtio_crypto_skcipher_algs.c
> @@ -123,6 +123,9 @@ static int virtio_crypto_alg_skcipher_init_session(
>         int op = encrypt ? VIRTIO_CRYPTO_OP_ENCRYPT : VIRTIO_CRYPTO_OP_DECRYPT;
>         int err;
>         unsigned int num_out = 0, num_in = 0;
> +       struct virtio_crypto_op_ctrl_req *ctrl;
> +       struct virtio_crypto_session_input *input;
> +       struct virtio_crypto_sym_create_session_req *sym_create_session;
>
>         /*
>          * Avoid to do DMA from the stack, switch to using
> @@ -135,24 +138,22 @@ static int virtio_crypto_alg_skcipher_init_session(
>
>         spin_lock(&vcrypto->ctrl_lock);
>         /* Pad ctrl header */
> -       vcrypto->ctrl.header.opcode =
> -               cpu_to_le32(VIRTIO_CRYPTO_CIPHER_CREATE_SESSION);
> -       vcrypto->ctrl.header.algo = cpu_to_le32(alg);
> +       ctrl = &vcrypto->ctrl;
> +       ctrl->header.opcode = cpu_to_le32(VIRTIO_CRYPTO_CIPHER_CREATE_SESSION);
> +       ctrl->header.algo = cpu_to_le32(alg);
>         /* Set the default dataqueue id to 0 */
> -       vcrypto->ctrl.header.queue_id = 0;
> +       ctrl->header.queue_id = 0;
>
> -       vcrypto->input.status = cpu_to_le32(VIRTIO_CRYPTO_ERR);
> +       input = &vcrypto->input;
> +       input->status = cpu_to_le32(VIRTIO_CRYPTO_ERR);
>         /* Pad cipher's parameters */
> -       vcrypto->ctrl.u.sym_create_session.op_type =
> -               cpu_to_le32(VIRTIO_CRYPTO_SYM_OP_CIPHER);
> -       vcrypto->ctrl.u.sym_create_session.u.cipher.para.algo =
> -               vcrypto->ctrl.header.algo;
> -       vcrypto->ctrl.u.sym_create_session.u.cipher.para.keylen =
> -               cpu_to_le32(keylen);
> -       vcrypto->ctrl.u.sym_create_session.u.cipher.para.op =
> -               cpu_to_le32(op);
> -
> -       sg_init_one(&outhdr, &vcrypto->ctrl, sizeof(vcrypto->ctrl));
> +       sym_create_session = &ctrl->u.sym_create_session;
> +       sym_create_session->op_type = cpu_to_le32(VIRTIO_CRYPTO_SYM_OP_CIPHER);
> +       sym_create_session->u.cipher.para.algo = ctrl->header.algo;
> +       sym_create_session->u.cipher.para.keylen = cpu_to_le32(keylen);
> +       sym_create_session->u.cipher.para.op = cpu_to_le32(op);
> +
> +       sg_init_one(&outhdr, ctrl, sizeof(*ctrl));
>         sgs[num_out++] = &outhdr;
>
>         /* Set key */
> @@ -160,7 +161,7 @@ static int virtio_crypto_alg_skcipher_init_session(
>         sgs[num_out++] = &key_sg;
>
>         /* Return status and session id back */
> -       sg_init_one(&inhdr, &vcrypto->input, sizeof(vcrypto->input));
> +       sg_init_one(&inhdr, input, sizeof(*input));
>         sgs[num_out + num_in++] = &inhdr;
>
>         err = virtqueue_add_sgs(vcrypto->ctrl_vq, sgs, num_out,
> @@ -180,20 +181,18 @@ static int virtio_crypto_alg_skcipher_init_session(
>                !virtqueue_is_broken(vcrypto->ctrl_vq))
>                 cpu_relax();
>
> -       if (le32_to_cpu(vcrypto->input.status) != VIRTIO_CRYPTO_OK) {
> +       if (le32_to_cpu(input->status) != VIRTIO_CRYPTO_OK) {
>                 spin_unlock(&vcrypto->ctrl_lock);
>                 pr_err("virtio_crypto: Create session failed status: %u\n",
> -                       le32_to_cpu(vcrypto->input.status));
> +                       le32_to_cpu(input->status));
>                 kfree_sensitive(cipher_key);
>                 return -EINVAL;
>         }
>
>         if (encrypt)
> -               ctx->enc_sess_info.session_id =
> -                       le64_to_cpu(vcrypto->input.session_id);
> +               ctx->enc_sess_info.session_id = le64_to_cpu(input->session_id);
>         else
> -               ctx->dec_sess_info.session_id =
> -                       le64_to_cpu(vcrypto->input.session_id);
> +               ctx->dec_sess_info.session_id = le64_to_cpu(input->session_id);
>
>         spin_unlock(&vcrypto->ctrl_lock);
>
> @@ -211,30 +210,30 @@ static int virtio_crypto_alg_skcipher_close_session(
>         struct virtio_crypto *vcrypto = ctx->vcrypto;
>         int err;
>         unsigned int num_out = 0, num_in = 0;
> +       struct virtio_crypto_op_ctrl_req *ctrl;
> +       struct virtio_crypto_inhdr *ctrl_status;
>
>         spin_lock(&vcrypto->ctrl_lock);
> -       vcrypto->ctrl_status.status = VIRTIO_CRYPTO_ERR;
> +       ctrl_status = &vcrypto->ctrl_status;
> +       ctrl_status->status = VIRTIO_CRYPTO_ERR;
>         /* Pad ctrl header */
> -       vcrypto->ctrl.header.opcode =
> -               cpu_to_le32(VIRTIO_CRYPTO_CIPHER_DESTROY_SESSION);
> +       ctrl = &vcrypto->ctrl;
> +       ctrl->header.opcode = cpu_to_le32(VIRTIO_CRYPTO_CIPHER_DESTROY_SESSION);
>         /* Set the default virtqueue id to 0 */
> -       vcrypto->ctrl.header.queue_id = 0;
> +       ctrl->header.queue_id = 0;
>
> -       destroy_session = &vcrypto->ctrl.u.destroy_session;
> +       destroy_session = &ctrl->u.destroy_session;
>
>         if (encrypt)
> -               destroy_session->session_id =
> -                       cpu_to_le64(ctx->enc_sess_info.session_id);
> +               destroy_session->session_id = cpu_to_le64(ctx->enc_sess_info.session_id);
>         else
> -               destroy_session->session_id =
> -                       cpu_to_le64(ctx->dec_sess_info.session_id);
> +               destroy_session->session_id = cpu_to_le64(ctx->dec_sess_info.session_id);
>
> -       sg_init_one(&outhdr, &vcrypto->ctrl, sizeof(vcrypto->ctrl));
> +       sg_init_one(&outhdr, ctrl, sizeof(*ctrl));
>         sgs[num_out++] = &outhdr;
>
>         /* Return status and session id back */
> -       sg_init_one(&status_sg, &vcrypto->ctrl_status.status,
> -               sizeof(vcrypto->ctrl_status.status));
> +       sg_init_one(&status_sg, &ctrl_status->status, sizeof(ctrl_status->status));
>         sgs[num_out + num_in++] = &status_sg;
>
>         err = virtqueue_add_sgs(vcrypto->ctrl_vq, sgs, num_out,
> @@ -249,11 +248,10 @@ static int virtio_crypto_alg_skcipher_close_session(
>                !virtqueue_is_broken(vcrypto->ctrl_vq))
>                 cpu_relax();
>
> -       if (vcrypto->ctrl_status.status != VIRTIO_CRYPTO_OK) {
> +       if (ctrl_status->status != VIRTIO_CRYPTO_OK) {
>                 spin_unlock(&vcrypto->ctrl_lock);
>                 pr_err("virtio_crypto: Close session failed status: %u, session_id: 0x%llx\n",
> -                       vcrypto->ctrl_status.status,
> -                       destroy_session->session_id);
> +                       ctrl_status->status, destroy_session->session_id);
>
>                 return -EINVAL;
>         }
> --
> 2.20.1
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
