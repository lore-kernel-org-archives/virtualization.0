Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 383B8C4167B
	for <virtualization@archiver.kernel.org>; Tue, 26 Apr 2022 06:33:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id C08D860F5C;
	Tue, 26 Apr 2022 06:33:21 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id wlAKV2nYRpoz; Tue, 26 Apr 2022 06:33:20 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id E8D9E60E85;
	Tue, 26 Apr 2022 06:33:19 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B8C0BC0039;
	Tue, 26 Apr 2022 06:33:19 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 2A829C002D
 for <virtualization@lists.linux-foundation.org>;
 Tue, 26 Apr 2022 06:33:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 0698382C9C
 for <virtualization@lists.linux-foundation.org>;
 Tue, 26 Apr 2022 06:33:18 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=bytedance-com.20210112.gappssmtp.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 0E_vmK9t8BTq
 for <virtualization@lists.linux-foundation.org>;
 Tue, 26 Apr 2022 06:33:16 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com
 [IPv6:2607:f8b0:4864:20::1032])
 by smtp1.osuosl.org (Postfix) with ESMTPS id BD9F482C8F
 for <virtualization@lists.linux-foundation.org>;
 Tue, 26 Apr 2022 06:33:16 +0000 (UTC)
Received: by mail-pj1-x1032.google.com with SMTP id bx5so7800616pjb.3
 for <virtualization@lists.linux-foundation.org>;
 Mon, 25 Apr 2022 23:33:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance-com.20210112.gappssmtp.com; s=20210112;
 h=message-id:date:mime-version:user-agent:subject:content-language:to
 :cc:references:from:in-reply-to:content-transfer-encoding;
 bh=YjjBqaXpNqfLu7b6MZDSbJmbcWhnY30gIpWRyRwDNFo=;
 b=DL+Wk7zj4UAaiNYgOPWg7viH3EvL77Gms1BuDqFesnZqnQLPTffsmu4CpbMSwFXU+T
 W2w0j7qVTL+8w6rgMTHL55oOyVRbH1it3TVSVEHgxFSc5flgRntD1rWx0OtQXcCGF1DJ
 a0rxwJZwSw9x9uJI7LxRYB9333Wlt/XbykgTP1ZyrnuFdPkwCK5m9tk+HOqHv8hZ/4HH
 WM8Wm1/Wtg64c0KzHlgkGFD+leOCY8XmSV+qljapemoHHwVO+41fMbr+Zl69VRjF3xhb
 Pixkra9NS+k2BC575InXb6zsV83FxPbV0bkY+CkbSpJNh5jOToUYt+Knsln1BcqYU4WG
 jRPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=YjjBqaXpNqfLu7b6MZDSbJmbcWhnY30gIpWRyRwDNFo=;
 b=ESIjdYrPK+dkh1NqV/Fygdt1d3er0ST/RMI48MSmQdDcfmbZC5fj1mYb6j5BDa04qb
 qeTBR1kirhZmxYSRcr//Ggskg79D6DIctCDPkQeY015/q6l9hpi52v8ZEc6uCh3sTTRV
 wzZ9ptJRFeCA20JnzIfQuezgfM9tqnpV3jmZWKdPmq80IzqwQsTf9BKai9S7to237upg
 TehGoUUiC8Sy//S2jv7vAnurS41ma/FukOmerle/lg5eTT4xQgbKFX0FyClQlCHtQ5Ec
 PyAq/8aadxZ2KiRg0QIxavzXJcUdupVfZ8/fE/Q4BzRivGQEHrHWGq9dFcaIcppJolHF
 8mZQ==
X-Gm-Message-State: AOAM530gaer5rPguQw95EwXLF7cjbOnz8NW2hOY9J0KIL5GYgc5Dc0Ms
 v2LMXegIoRDZRdLIIbW9hWWNNg==
X-Google-Smtp-Source: ABdhPJyfsUFgidHIqEXYmqyuBYGZ//4FYfSYwuRBo7iGrHqWO92lJjrj9ITWjI4yfeL7SIitOMn+dw==
X-Received: by 2002:a17:903:240f:b0:158:b871:33ac with SMTP id
 e15-20020a170903240f00b00158b87133acmr21747107plo.135.1650954795931; 
 Mon, 25 Apr 2022 23:33:15 -0700 (PDT)
Received: from [10.76.15.169] ([61.120.150.70])
 by smtp.gmail.com with ESMTPSA id
 y20-20020a63de54000000b003ab77b83973sm2468956pgi.33.2022.04.25.23.33.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 25 Apr 2022 23:33:15 -0700 (PDT)
Message-ID: <933d4fed-22b7-a563-e2f0-f659e0997264@bytedance.com>
Date: Tue, 26 Apr 2022 14:29:19 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: Re: [PATCH v4 1/5] virtio-crypto: change code style
Content-Language: en-US
To: Jason Wang <jasowang@redhat.com>, "Gonglei (Arei)"
 <arei.gonglei@huawei.com>
References: <20220424104140.44841-1-pizhenwei@bytedance.com>
 <20220424104140.44841-2-pizhenwei@bytedance.com>
 <CACGkMEu+V6-+OTDnEJH+zORF6SSRhPjVWAyBWQ259RHKtNiShA@mail.gmail.com>
From: zhenwei pi <pizhenwei@bytedance.com>
In-Reply-To: <CACGkMEu+V6-+OTDnEJH+zORF6SSRhPjVWAyBWQ259RHKtNiShA@mail.gmail.com>
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>



On 4/26/22 14:12, Jason Wang wrote:
> On Sun, Apr 24, 2022 at 6:45 PM zhenwei pi <pizhenwei@bytedance.com> wrote:
>>
>> Use temporary variable to make code easy to read and maintain.
>>          /* Pad cipher's parameters */
>>          vcrypto->ctrl.u.sym_create_session.op_type =
>>                  cpu_to_le32(VIRTIO_CRYPTO_SYM_OP_CIPHER);
>>          vcrypto->ctrl.u.sym_create_session.u.cipher.para.algo =
>>                  vcrypto->ctrl.header.algo;
>>          vcrypto->ctrl.u.sym_create_session.u.cipher.para.keylen =
>>                  cpu_to_le32(keylen);
>>          vcrypto->ctrl.u.sym_create_session.u.cipher.para.op =
>>                  cpu_to_le32(op);
>> -->
>>          sym_create_session = &ctrl->u.sym_create_session;
>>          sym_create_session->op_type = cpu_to_le32(VIRTIO_CRYPTO_SYM_OP_CIPHER);
>>          sym_create_session->u.cipher.para.algo = ctrl->header.algo;
>>          sym_create_session->u.cipher.para.keylen = cpu_to_le32(keylen);
>>          sym_create_session->u.cipher.para.op = cpu_to_le32(op);
>>
>> The new style shows more obviously:
>> - the variable we want to operate.
>> - an assignment statement in a single line.
> 
> Still hundreds of lines of changes, I'd leave this change to other
> mainters to dedice.
> 
> Thanks
> 

Thanks to Jason!

Hi, Lei

What's your opinion?

>>
>> Cc: Michael S. Tsirkin <mst@redhat.com>
>> Cc: Jason Wang <jasowang@redhat.com>
>> Cc: Gonglei <arei.gonglei@huawei.com>
>> Signed-off-by: zhenwei pi <pizhenwei@bytedance.com>
>> ---
>>   .../virtio/virtio_crypto_akcipher_algs.c      | 40 ++++++-----
>>   .../virtio/virtio_crypto_skcipher_algs.c      | 72 +++++++++----------
>>   2 files changed, 59 insertions(+), 53 deletions(-)
>>
>> diff --git a/drivers/crypto/virtio/virtio_crypto_akcipher_algs.c b/drivers/crypto/virtio/virtio_crypto_akcipher_algs.c
>> index f3ec9420215e..20901a263fc8 100644
>> --- a/drivers/crypto/virtio/virtio_crypto_akcipher_algs.c
>> +++ b/drivers/crypto/virtio/virtio_crypto_akcipher_algs.c
>> @@ -106,23 +106,27 @@ static int virtio_crypto_alg_akcipher_init_session(struct virtio_crypto_akcipher
>>          unsigned int inlen;
>>          int err;
>>          unsigned int num_out = 0, num_in = 0;
>> +       struct virtio_crypto_op_ctrl_req *ctrl;
>> +       struct virtio_crypto_session_input *input;
>>
>>          pkey = kmemdup(key, keylen, GFP_ATOMIC);
>>          if (!pkey)
>>                  return -ENOMEM;
>>
>>          spin_lock(&vcrypto->ctrl_lock);
>> -       memcpy(&vcrypto->ctrl.header, header, sizeof(vcrypto->ctrl.header));
>> -       memcpy(&vcrypto->ctrl.u, para, sizeof(vcrypto->ctrl.u));
>> -       vcrypto->input.status = cpu_to_le32(VIRTIO_CRYPTO_ERR);
>> +       ctrl = &vcrypto->ctrl;
>> +       memcpy(&ctrl->header, header, sizeof(ctrl->header));
>> +       memcpy(&ctrl->u, para, sizeof(ctrl->u));
>> +       input = &vcrypto->input;
>> +       input->status = cpu_to_le32(VIRTIO_CRYPTO_ERR);
>>
>> -       sg_init_one(&outhdr_sg, &vcrypto->ctrl, sizeof(vcrypto->ctrl));
>> +       sg_init_one(&outhdr_sg, ctrl, sizeof(*ctrl));
>>          sgs[num_out++] = &outhdr_sg;
>>
>>          sg_init_one(&key_sg, pkey, keylen);
>>          sgs[num_out++] = &key_sg;
>>
>> -       sg_init_one(&inhdr_sg, &vcrypto->input, sizeof(vcrypto->input));
>> +       sg_init_one(&inhdr_sg, input, sizeof(*input));
>>          sgs[num_out + num_in++] = &inhdr_sg;
>>
>>          err = virtqueue_add_sgs(vcrypto->ctrl_vq, sgs, num_out, num_in, vcrypto, GFP_ATOMIC);
>> @@ -134,12 +138,12 @@ static int virtio_crypto_alg_akcipher_init_session(struct virtio_crypto_akcipher
>>                 !virtqueue_is_broken(vcrypto->ctrl_vq))
>>                  cpu_relax();
>>
>> -       if (le32_to_cpu(vcrypto->input.status) != VIRTIO_CRYPTO_OK) {
>> +       if (le32_to_cpu(input->status) != VIRTIO_CRYPTO_OK) {
>>                  err = -EINVAL;
>>                  goto out;
>>          }
>>
>> -       ctx->session_id = le64_to_cpu(vcrypto->input.session_id);
>> +       ctx->session_id = le64_to_cpu(input->session_id);
>>          ctx->session_valid = true;
>>          err = 0;
>>
>> @@ -149,7 +153,7 @@ static int virtio_crypto_alg_akcipher_init_session(struct virtio_crypto_akcipher
>>
>>          if (err < 0)
>>                  pr_err("virtio_crypto: Create session failed status: %u\n",
>> -                       le32_to_cpu(vcrypto->input.status));
>> +                       le32_to_cpu(input->status));
>>
>>          return err;
>>   }
>> @@ -161,23 +165,27 @@ static int virtio_crypto_alg_akcipher_close_session(struct virtio_crypto_akciphe
>>          struct virtio_crypto *vcrypto = ctx->vcrypto;
>>          unsigned int num_out = 0, num_in = 0, inlen;
>>          int err;
>> +       struct virtio_crypto_op_ctrl_req *ctrl;
>> +       struct virtio_crypto_inhdr *ctrl_status;
>>
>>          spin_lock(&vcrypto->ctrl_lock);
>>          if (!ctx->session_valid) {
>>                  err = 0;
>>                  goto out;
>>          }
>> -       vcrypto->ctrl_status.status = VIRTIO_CRYPTO_ERR;
>> -       vcrypto->ctrl.header.opcode = cpu_to_le32(VIRTIO_CRYPTO_AKCIPHER_DESTROY_SESSION);
>> -       vcrypto->ctrl.header.queue_id = 0;
>> +       ctrl_status = &vcrypto->ctrl_status;
>> +       ctrl_status->status = VIRTIO_CRYPTO_ERR;
>> +       ctrl = &vcrypto->ctrl;
>> +       ctrl->header.opcode = cpu_to_le32(VIRTIO_CRYPTO_AKCIPHER_DESTROY_SESSION);
>> +       ctrl->header.queue_id = 0;
>>
>> -       destroy_session = &vcrypto->ctrl.u.destroy_session;
>> +       destroy_session = &ctrl->u.destroy_session;
>>          destroy_session->session_id = cpu_to_le64(ctx->session_id);
>>
>> -       sg_init_one(&outhdr_sg, &vcrypto->ctrl, sizeof(vcrypto->ctrl));
>> +       sg_init_one(&outhdr_sg, ctrl, sizeof(*ctrl));
>>          sgs[num_out++] = &outhdr_sg;
>>
>> -       sg_init_one(&inhdr_sg, &vcrypto->ctrl_status.status, sizeof(vcrypto->ctrl_status.status));
>> +       sg_init_one(&inhdr_sg, &ctrl_status->status, sizeof(ctrl_status->status));
>>          sgs[num_out + num_in++] = &inhdr_sg;
>>
>>          err = virtqueue_add_sgs(vcrypto->ctrl_vq, sgs, num_out, num_in, vcrypto, GFP_ATOMIC);
>> @@ -189,7 +197,7 @@ static int virtio_crypto_alg_akcipher_close_session(struct virtio_crypto_akciphe
>>                 !virtqueue_is_broken(vcrypto->ctrl_vq))
>>                  cpu_relax();
>>
>> -       if (vcrypto->ctrl_status.status != VIRTIO_CRYPTO_OK) {
>> +       if (ctrl_status->status != VIRTIO_CRYPTO_OK) {
>>                  err = -EINVAL;
>>                  goto out;
>>          }
>> @@ -201,7 +209,7 @@ static int virtio_crypto_alg_akcipher_close_session(struct virtio_crypto_akciphe
>>          spin_unlock(&vcrypto->ctrl_lock);
>>          if (err < 0) {
>>                  pr_err("virtio_crypto: Close session failed status: %u, session_id: 0x%llx\n",
>> -                       vcrypto->ctrl_status.status, destroy_session->session_id);
>> +                       ctrl_status->status, destroy_session->session_id);
>>          }
>>
>>          return err;
>> diff --git a/drivers/crypto/virtio/virtio_crypto_skcipher_algs.c b/drivers/crypto/virtio/virtio_crypto_skcipher_algs.c
>> index a618c46a52b8..e3c5bc8d6112 100644
>> --- a/drivers/crypto/virtio/virtio_crypto_skcipher_algs.c
>> +++ b/drivers/crypto/virtio/virtio_crypto_skcipher_algs.c
>> @@ -123,6 +123,9 @@ static int virtio_crypto_alg_skcipher_init_session(
>>          int op = encrypt ? VIRTIO_CRYPTO_OP_ENCRYPT : VIRTIO_CRYPTO_OP_DECRYPT;
>>          int err;
>>          unsigned int num_out = 0, num_in = 0;
>> +       struct virtio_crypto_op_ctrl_req *ctrl;
>> +       struct virtio_crypto_session_input *input;
>> +       struct virtio_crypto_sym_create_session_req *sym_create_session;
>>
>>          /*
>>           * Avoid to do DMA from the stack, switch to using
>> @@ -135,24 +138,22 @@ static int virtio_crypto_alg_skcipher_init_session(
>>
>>          spin_lock(&vcrypto->ctrl_lock);
>>          /* Pad ctrl header */
>> -       vcrypto->ctrl.header.opcode =
>> -               cpu_to_le32(VIRTIO_CRYPTO_CIPHER_CREATE_SESSION);
>> -       vcrypto->ctrl.header.algo = cpu_to_le32(alg);
>> +       ctrl = &vcrypto->ctrl;
>> +       ctrl->header.opcode = cpu_to_le32(VIRTIO_CRYPTO_CIPHER_CREATE_SESSION);
>> +       ctrl->header.algo = cpu_to_le32(alg);
>>          /* Set the default dataqueue id to 0 */
>> -       vcrypto->ctrl.header.queue_id = 0;
>> +       ctrl->header.queue_id = 0;
>>
>> -       vcrypto->input.status = cpu_to_le32(VIRTIO_CRYPTO_ERR);
>> +       input = &vcrypto->input;
>> +       input->status = cpu_to_le32(VIRTIO_CRYPTO_ERR);
>>          /* Pad cipher's parameters */
>> -       vcrypto->ctrl.u.sym_create_session.op_type =
>> -               cpu_to_le32(VIRTIO_CRYPTO_SYM_OP_CIPHER);
>> -       vcrypto->ctrl.u.sym_create_session.u.cipher.para.algo =
>> -               vcrypto->ctrl.header.algo;
>> -       vcrypto->ctrl.u.sym_create_session.u.cipher.para.keylen =
>> -               cpu_to_le32(keylen);
>> -       vcrypto->ctrl.u.sym_create_session.u.cipher.para.op =
>> -               cpu_to_le32(op);
>> -
>> -       sg_init_one(&outhdr, &vcrypto->ctrl, sizeof(vcrypto->ctrl));
>> +       sym_create_session = &ctrl->u.sym_create_session;
>> +       sym_create_session->op_type = cpu_to_le32(VIRTIO_CRYPTO_SYM_OP_CIPHER);
>> +       sym_create_session->u.cipher.para.algo = ctrl->header.algo;
>> +       sym_create_session->u.cipher.para.keylen = cpu_to_le32(keylen);
>> +       sym_create_session->u.cipher.para.op = cpu_to_le32(op);
>> +
>> +       sg_init_one(&outhdr, ctrl, sizeof(*ctrl));
>>          sgs[num_out++] = &outhdr;
>>
>>          /* Set key */
>> @@ -160,7 +161,7 @@ static int virtio_crypto_alg_skcipher_init_session(
>>          sgs[num_out++] = &key_sg;
>>
>>          /* Return status and session id back */
>> -       sg_init_one(&inhdr, &vcrypto->input, sizeof(vcrypto->input));
>> +       sg_init_one(&inhdr, input, sizeof(*input));
>>          sgs[num_out + num_in++] = &inhdr;
>>
>>          err = virtqueue_add_sgs(vcrypto->ctrl_vq, sgs, num_out,
>> @@ -180,20 +181,18 @@ static int virtio_crypto_alg_skcipher_init_session(
>>                 !virtqueue_is_broken(vcrypto->ctrl_vq))
>>                  cpu_relax();
>>
>> -       if (le32_to_cpu(vcrypto->input.status) != VIRTIO_CRYPTO_OK) {
>> +       if (le32_to_cpu(input->status) != VIRTIO_CRYPTO_OK) {
>>                  spin_unlock(&vcrypto->ctrl_lock);
>>                  pr_err("virtio_crypto: Create session failed status: %u\n",
>> -                       le32_to_cpu(vcrypto->input.status));
>> +                       le32_to_cpu(input->status));
>>                  kfree_sensitive(cipher_key);
>>                  return -EINVAL;
>>          }
>>
>>          if (encrypt)
>> -               ctx->enc_sess_info.session_id =
>> -                       le64_to_cpu(vcrypto->input.session_id);
>> +               ctx->enc_sess_info.session_id = le64_to_cpu(input->session_id);
>>          else
>> -               ctx->dec_sess_info.session_id =
>> -                       le64_to_cpu(vcrypto->input.session_id);
>> +               ctx->dec_sess_info.session_id = le64_to_cpu(input->session_id);
>>
>>          spin_unlock(&vcrypto->ctrl_lock);
>>
>> @@ -211,30 +210,30 @@ static int virtio_crypto_alg_skcipher_close_session(
>>          struct virtio_crypto *vcrypto = ctx->vcrypto;
>>          int err;
>>          unsigned int num_out = 0, num_in = 0;
>> +       struct virtio_crypto_op_ctrl_req *ctrl;
>> +       struct virtio_crypto_inhdr *ctrl_status;
>>
>>          spin_lock(&vcrypto->ctrl_lock);
>> -       vcrypto->ctrl_status.status = VIRTIO_CRYPTO_ERR;
>> +       ctrl_status = &vcrypto->ctrl_status;
>> +       ctrl_status->status = VIRTIO_CRYPTO_ERR;
>>          /* Pad ctrl header */
>> -       vcrypto->ctrl.header.opcode =
>> -               cpu_to_le32(VIRTIO_CRYPTO_CIPHER_DESTROY_SESSION);
>> +       ctrl = &vcrypto->ctrl;
>> +       ctrl->header.opcode = cpu_to_le32(VIRTIO_CRYPTO_CIPHER_DESTROY_SESSION);
>>          /* Set the default virtqueue id to 0 */
>> -       vcrypto->ctrl.header.queue_id = 0;
>> +       ctrl->header.queue_id = 0;
>>
>> -       destroy_session = &vcrypto->ctrl.u.destroy_session;
>> +       destroy_session = &ctrl->u.destroy_session;
>>
>>          if (encrypt)
>> -               destroy_session->session_id =
>> -                       cpu_to_le64(ctx->enc_sess_info.session_id);
>> +               destroy_session->session_id = cpu_to_le64(ctx->enc_sess_info.session_id);
>>          else
>> -               destroy_session->session_id =
>> -                       cpu_to_le64(ctx->dec_sess_info.session_id);
>> +               destroy_session->session_id = cpu_to_le64(ctx->dec_sess_info.session_id);
>>
>> -       sg_init_one(&outhdr, &vcrypto->ctrl, sizeof(vcrypto->ctrl));
>> +       sg_init_one(&outhdr, ctrl, sizeof(*ctrl));
>>          sgs[num_out++] = &outhdr;
>>
>>          /* Return status and session id back */
>> -       sg_init_one(&status_sg, &vcrypto->ctrl_status.status,
>> -               sizeof(vcrypto->ctrl_status.status));
>> +       sg_init_one(&status_sg, &ctrl_status->status, sizeof(ctrl_status->status));
>>          sgs[num_out + num_in++] = &status_sg;
>>
>>          err = virtqueue_add_sgs(vcrypto->ctrl_vq, sgs, num_out,
>> @@ -249,11 +248,10 @@ static int virtio_crypto_alg_skcipher_close_session(
>>                 !virtqueue_is_broken(vcrypto->ctrl_vq))
>>                  cpu_relax();
>>
>> -       if (vcrypto->ctrl_status.status != VIRTIO_CRYPTO_OK) {
>> +       if (ctrl_status->status != VIRTIO_CRYPTO_OK) {
>>                  spin_unlock(&vcrypto->ctrl_lock);
>>                  pr_err("virtio_crypto: Close session failed status: %u, session_id: 0x%llx\n",
>> -                       vcrypto->ctrl_status.status,
>> -                       destroy_session->session_id);
>> +                       ctrl_status->status, destroy_session->session_id);
>>
>>                  return -EINVAL;
>>          }
>> --
>> 2.20.1
>>
> 

-- 
zhenwei pi
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
