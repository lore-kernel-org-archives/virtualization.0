Return-Path: <SRS0=MC01=FN=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2DFDC4361B
	for <virtualization@archiver.kernel.org>; Wed,  9 Dec 2020 14:43:57 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 33D01233A2
	for <virtualization@archiver.kernel.org>; Wed,  9 Dec 2020 14:43:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 33D01233A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id D2D52875CF;
	Wed,  9 Dec 2020 14:43:56 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 8XUjiZ9nUoyO; Wed,  9 Dec 2020 14:43:56 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 25B71875DD;
	Wed,  9 Dec 2020 14:43:56 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 0C5D3C0FA7;
	Wed,  9 Dec 2020 14:43:56 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1DD35C013B
 for <virtualization@lists.linux-foundation.org>;
 Wed,  9 Dec 2020 14:43:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 0B2D386B92
 for <virtualization@lists.linux-foundation.org>;
 Wed,  9 Dec 2020 14:43:55 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id jhw9IFEr3PSi
 for <virtualization@lists.linux-foundation.org>;
 Wed,  9 Dec 2020 14:43:53 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-vk1-f195.google.com (mail-vk1-f195.google.com
 [209.85.221.195])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 89FD086B83
 for <virtualization@lists.linux-foundation.org>;
 Wed,  9 Dec 2020 14:43:53 +0000 (UTC)
Received: by mail-vk1-f195.google.com with SMTP id v185so384914vkf.8
 for <virtualization@lists.linux-foundation.org>;
 Wed, 09 Dec 2020 06:43:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=7Q6KcYtQg5u1UB7CZSEvhSXseIPsOcn669yzRvM9CMI=;
 b=MlNvVPUG7US7xBW3iVErIuZr+AX7nU82hgF0ulmmxukBGxZ+1aH8RSAISrlziE8ohP
 3rHT2hclrFaH7fVYUBoXUOstwt+bc9QYX3X8ALTg6X5lBTkgBf8WxhMvrd08q9pIuE2E
 ROIhSWl9U3bbWNiEFECJDGApOqjDZgiCLU6BhfPfQaHVd+/ludibgxNig9Ga2clSkxLL
 XDF2E73bcHhgNStuIvVz04fkXa+eJsA1t64j3S3SVLso9HivnYtXI7dqrH6syofZZiOK
 cueIh3qC39Qd2tHI+caBJ6vq9g2IuSR9SalaG0NVyUu4JBRCWQ6SMFlpXefbPZ+E680/
 e2LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=7Q6KcYtQg5u1UB7CZSEvhSXseIPsOcn669yzRvM9CMI=;
 b=RsXS8TggPyTORXEZ+ziqaltgf7i1P4f5OE9hvFop8Ams34gqPd52Ms1nyYS2smAFrS
 eDnqaYDMyWoICFSUUzjG+DvY/dQD0oYSOh1VkHmY8DDwrzU1UEyzNbXu8BcMF5gZG8G6
 9322KiFcR3reiUA+/4Iit+f1iisTIM9MfV/x1jWFp3m9z0ncWofpZMnpRuOay6vAFQ11
 RQb8UVBM+jY+32XbPO3fRJhMdpM9W/6+11FWa+znFJtdS/h1n6kzes6yeh6MfW/0Zahc
 G3naiJ9WGCOJev/Qr46OjrejWf8cgqazO5ZZt8gTbJVz6MWL0kEY288drm4O12cFMOOs
 IGeg==
X-Gm-Message-State: AOAM530sg3nHF6+HaCLBPfCXjOqQ5j8MUuuCm5qhMlfBEIAYsk8l3b2Y
 kdP+tiMCZbmCkYhKlCd/D8GS2k5/bYU=
X-Google-Smtp-Source: ABdhPJx2zr81tWTOmGLT1Zr/Euh+/qaHMG7rP+7Bg9Z5diQAICwUZ/sXO/OYF6/FcrHtTdsLg8xmWg==
X-Received: by 2002:ac5:c995:: with SMTP id e21mr2260925vkm.5.1607525032139;
 Wed, 09 Dec 2020 06:43:52 -0800 (PST)
Received: from mail-ua1-f41.google.com (mail-ua1-f41.google.com.
 [209.85.222.41])
 by smtp.gmail.com with ESMTPSA id b23sm169925vsa.11.2020.12.09.06.43.50
 for <virtualization@lists.linux-foundation.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 09 Dec 2020 06:43:51 -0800 (PST)
Received: by mail-ua1-f41.google.com with SMTP id w7so555155uap.13
 for <virtualization@lists.linux-foundation.org>;
 Wed, 09 Dec 2020 06:43:50 -0800 (PST)
X-Received: by 2002:a9f:2356:: with SMTP id 80mr1832051uae.92.1607525030374;
 Wed, 09 Dec 2020 06:43:50 -0800 (PST)
MIME-Version: 1.0
References: <1606982459-41752-1-git-send-email-wangyunjian@huawei.com>
 <1607517703-18472-1-git-send-email-wangyunjian@huawei.com>
In-Reply-To: <1607517703-18472-1-git-send-email-wangyunjian@huawei.com>
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Date: Wed, 9 Dec 2020 09:43:13 -0500
X-Gmail-Original-Message-ID: <CA+FuTSfQoDr0jd76xBXSvchhyihQaL2UQXeCR6frJ7hyXxbmVA@mail.gmail.com>
Message-ID: <CA+FuTSfQoDr0jd76xBXSvchhyihQaL2UQXeCR6frJ7hyXxbmVA@mail.gmail.com>
Subject: Re: [PATCH net v2] tun: fix ubuf refcount incorrectly on error path
To: wangyunjian <wangyunjian@huawei.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 Network Development <netdev@vger.kernel.org>, jerry.lilijun@huawei.com,
 virtualization@lists.linux-foundation.org, xudingke@huawei.com,
 chenchanghu@huawei.com
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

On Wed, Dec 9, 2020 at 8:03 AM wangyunjian <wangyunjian@huawei.com> wrote:
>
> From: Yunjian Wang <wangyunjian@huawei.com>
>
> After setting callback for ubuf_info of skb, the callback
> (vhost_net_zerocopy_callback) will be called to decrease
> the refcount when freeing skb. But when an exception occurs

With exception, you mean if tun_get_user returns an error that
propagates to the sendmsg call in vhost handle_tx, correct?

> afterwards, the error handling in vhost handle_tx() will
> try to decrease the same refcount again. This is wrong and
> fix this by delay copying ubuf_info until we're sure
> there's no errors.

I think the right approach is to address this in the error paths,
rather than complicate the normal datapath.

Is it sufficient to suppress the call to vhost_net_ubuf_put in the
handle_tx sendmsg error path, given that vhost_zerocopy_callback
will be called on kfree_skb?

Or alternatively clear the destructor in drop:

>
> Fixes: 4477138fa0ae ("tun: properly test for IFF_UP")
> Fixes: 90e33d459407 ("tun: enable napi_gro_frags() for TUN/TAP driver")
>
> Signed-off-by: Yunjian Wang <wangyunjian@huawei.com>
> ---
> v2:
>    Updated code, fix by delay copying ubuf_info
> ---
>  drivers/net/tun.c | 29 +++++++++++++++++++----------
>  1 file changed, 19 insertions(+), 10 deletions(-)
>
> diff --git a/drivers/net/tun.c b/drivers/net/tun.c
> index 2dc1988a8973..2ea822328e73 100644
> --- a/drivers/net/tun.c
> +++ b/drivers/net/tun.c
> @@ -1637,6 +1637,20 @@ static struct sk_buff *tun_build_skb(struct tun_struct *tun,
>         return NULL;
>  }
>
> +/* copy ubuf_info for callback when skb has no error */
> +static inline void tun_copy_ubuf_info(struct sk_buff *skb, bool zerocopy, void *msg_control)
> +{
> +       if (zerocopy) {
> +               skb_shinfo(skb)->destructor_arg = msg_control;
> +               skb_shinfo(skb)->tx_flags |= SKBTX_DEV_ZEROCOPY;
> +               skb_shinfo(skb)->tx_flags |= SKBTX_SHARED_FRAG;
> +       } else if (msg_control) {
> +               struct ubuf_info *uarg = msg_control;
> +
> +               uarg->callback(uarg, false);
> +       }
> +}
> +
>  /* Get packet from user space buffer */
>  static ssize_t tun_get_user(struct tun_struct *tun, struct tun_file *tfile,
>                             void *msg_control, struct iov_iter *from,
> @@ -1812,16 +1826,6 @@ static ssize_t tun_get_user(struct tun_struct *tun, struct tun_file *tfile,
>                 break;
>         }
>
> -       /* copy skb_ubuf_info for callback when skb has no error */
> -       if (zerocopy) {
> -               skb_shinfo(skb)->destructor_arg = msg_control;
> -               skb_shinfo(skb)->tx_flags |= SKBTX_DEV_ZEROCOPY;
> -               skb_shinfo(skb)->tx_flags |= SKBTX_SHARED_FRAG;
> -       } else if (msg_control) {
> -               struct ubuf_info *uarg = msg_control;
> -               uarg->callback(uarg, false);
> -       }
> -
>         skb_reset_network_header(skb);
>         skb_probe_transport_header(skb);
>         skb_record_rx_queue(skb, tfile->queue_index);
> @@ -1830,6 +1834,7 @@ static ssize_t tun_get_user(struct tun_struct *tun, struct tun_file *tfile,
>                 struct bpf_prog *xdp_prog;
>                 int ret;
>
> +               tun_copy_ubuf_info(skb, zerocopy, msg_control);
>                 local_bh_disable();
>                 rcu_read_lock();
>                 xdp_prog = rcu_dereference(tun->xdp_prog);
> @@ -1881,6 +1886,7 @@ static ssize_t tun_get_user(struct tun_struct *tun, struct tun_file *tfile,
>                         return -ENOMEM;
>                 }
>
> +               tun_copy_ubuf_info(skb, zerocopy, msg_control);
>                 local_bh_disable();
>                 napi_gro_frags(&tfile->napi);
>                 local_bh_enable();
> @@ -1889,6 +1895,7 @@ static ssize_t tun_get_user(struct tun_struct *tun, struct tun_file *tfile,
>                 struct sk_buff_head *queue = &tfile->sk.sk_write_queue;
>                 int queue_len;
>
> +               tun_copy_ubuf_info(skb, zerocopy, msg_control);
>                 spin_lock_bh(&queue->lock);
>                 __skb_queue_tail(queue, skb);
>                 queue_len = skb_queue_len(queue);
> @@ -1899,8 +1906,10 @@ static ssize_t tun_get_user(struct tun_struct *tun, struct tun_file *tfile,
>
>                 local_bh_enable();
>         } else if (!IS_ENABLED(CONFIG_4KSTACKS)) {
> +               tun_copy_ubuf_info(skb, zerocopy, msg_control);
>                 tun_rx_batched(tun, tfile, skb, more);
>         } else {
> +               tun_copy_ubuf_info(skb, zerocopy, msg_control);
>                 netif_rx_ni(skb);
>         }
>         rcu_read_unlock();
> --
> 2.23.0
>
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
