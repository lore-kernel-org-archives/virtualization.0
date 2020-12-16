Return-Path: <SRS0=2z8p=FU=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA63AC4361B
	for <virtualization@archiver.kernel.org>; Wed, 16 Dec 2020 20:57:01 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 29AE3238E9
	for <virtualization@archiver.kernel.org>; Wed, 16 Dec 2020 20:57:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 29AE3238E9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 62D97871E3;
	Wed, 16 Dec 2020 20:57:00 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id gE6hm8DYzZ62; Wed, 16 Dec 2020 20:56:58 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 82FA787135;
	Wed, 16 Dec 2020 20:56:58 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 6A4E2C088E;
	Wed, 16 Dec 2020 20:56:58 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D3CEFC013B
 for <virtualization@lists.linux-foundation.org>;
 Wed, 16 Dec 2020 20:56:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id C1D9D86BA8
 for <virtualization@lists.linux-foundation.org>;
 Wed, 16 Dec 2020 20:56:56 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id MMhRAhHyO8Fl
 for <virtualization@lists.linux-foundation.org>;
 Wed, 16 Dec 2020 20:56:56 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by whitealder.osuosl.org (Postfix) with ESMTPS id C366586BA0
 for <virtualization@lists.linux-foundation.org>;
 Wed, 16 Dec 2020 20:56:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1608152214;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=2AkrCNpZXe4Sp+a6ZR/50L3fZGo/5s0uMtMrwkWOaLw=;
 b=ClkG1j1CEzVGI3f3hB1R7hHXmmTbqQodb4DQvHDwWVN4TEEFsnFbkextOKzLYGhLWLA/+V
 nutK0eIztpUnHwHulwl4BtymPvujITsEC/FFQF9XZZQZNkBea87AgKFGmt2Z8pZy3JmYnN
 N4fOEqdrsGtn5jUvNDY0rvjh7lqqkac=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-25-yrVfxT51NTC-TnQ6dXD0pQ-1; Wed, 16 Dec 2020 15:56:50 -0500
X-MC-Unique: yrVfxT51NTC-TnQ6dXD0pQ-1
Received: by mail-wr1-f69.google.com with SMTP id w5so7666990wrl.9
 for <virtualization@lists.linux-foundation.org>;
 Wed, 16 Dec 2020 12:56:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=2AkrCNpZXe4Sp+a6ZR/50L3fZGo/5s0uMtMrwkWOaLw=;
 b=iisSaNV4S/ALl4nOlj8glzBxv9ipqRviHYx9bd1Yd0cyGgYMew6xbj8/d+d8R1T3tp
 QQzVcWvDqgJzsOrz7wnjPC3YATLwiWjCif/6jCsUBGkHEfx8/hKEnsfjouwYqXOGX+gx
 6+Jgds67n12R7RbvuLeftbnqZlUdr41WKXB3mg0gP9OTmoNhTd9Sul03WYWTKNXd+7wF
 KRSXuQDR7ZohdGhHgYdIaSMZxmOu5lEfSP+lC0IgSsUzDS1M38qSeJG8xr/kU2/yyddZ
 97Tx074qh9dh6IbzQ+mM8bQcl5aNIFu4XRqjKlVye0JHxnBc7jdze5a8FWADuRqlzLC4
 8LIg==
X-Gm-Message-State: AOAM532RMFXNF4HhkjVzLMs+z+4NShUaDr8VYMSC781JHlvmNbJLWa0r
 gSWhMBDnjZO3rT0ogTzrf+l19xusw59deGxz60h3i6sKPctuRenI20e6zduwUFKJW87ZTm92XEb
 VGyiEzwJ75kZayuTOVYi9nsFRC2w45jrTzPwKOJa6YQ==
X-Received: by 2002:a05:600c:242:: with SMTP id
 2mr5223302wmj.144.1608152209296; 
 Wed, 16 Dec 2020 12:56:49 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxuOrbflTOE4VJXzLJkCUB2ptnIdthXN1ODGiPBIoluhRZebmLZsZznPpZ8UMh6Pb4Df5ucMA==
X-Received: by 2002:a05:600c:242:: with SMTP id
 2mr5223287wmj.144.1608152209125; 
 Wed, 16 Dec 2020 12:56:49 -0800 (PST)
Received: from redhat.com (bzq-109-67-15-113.red.bezeqint.net. [109.67.15.113])
 by smtp.gmail.com with ESMTPSA id o13sm4139491wmc.44.2020.12.16.12.56.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Dec 2020 12:56:48 -0800 (PST)
Date: Wed, 16 Dec 2020 15:56:45 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: wangyunjian <wangyunjian@huawei.com>
Subject: Re: [PATCH net v2 1/2] vhost_net: fix ubuf refcount incorrectly when
 sendmsg fails
Message-ID: <20201216155633-mutt-send-email-mst@kernel.org>
References: <cover.1608065644.git.wangyunjian@huawei.com>
 <62db7d3d2af50f379ec28452921b3261af33db0b.1608065644.git.wangyunjian@huawei.com>
MIME-Version: 1.0
In-Reply-To: <62db7d3d2af50f379ec28452921b3261af33db0b.1608065644.git.wangyunjian@huawei.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: willemdebruijn.kernel@gmail.com, netdev@vger.kernel.org,
 jerry.lilijun@huawei.com, virtualization@lists.linux-foundation.org,
 xudingke@huawei.com, brian.huangbin@huawei.com, chenchanghu@huawei.com
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

On Wed, Dec 16, 2020 at 04:20:20PM +0800, wangyunjian wrote:
> From: Yunjian Wang <wangyunjian@huawei.com>
> 
> Currently the vhost_zerocopy_callback() maybe be called to decrease
> the refcount when sendmsg fails in tun. The error handling in vhost
> handle_tx_zerocopy() will try to decrease the same refcount again.
> This is wrong. To fix this issue, we only call vhost_net_ubuf_put()
> when vq->heads[nvq->desc].len == VHOST_DMA_IN_PROGRESS.
> 
> Fixes: 0690899b4d45 ("tun: experimental zero copy tx support")
> 
> Signed-off-by: Yunjian Wang <wangyunjian@huawei.com>

Acked-by: Michael S. Tsirkin <mst@redhat.com>

> ---
>  drivers/vhost/net.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/vhost/net.c b/drivers/vhost/net.c
> index 531a00d703cd..c8784dfafdd7 100644
> --- a/drivers/vhost/net.c
> +++ b/drivers/vhost/net.c
> @@ -863,6 +863,7 @@ static void handle_tx_zerocopy(struct vhost_net *net, struct socket *sock)
>  	size_t len, total_len = 0;
>  	int err;
>  	struct vhost_net_ubuf_ref *ubufs;
> +	struct ubuf_info *ubuf;
>  	bool zcopy_used;
>  	int sent_pkts = 0;
>  
> @@ -895,9 +896,7 @@ static void handle_tx_zerocopy(struct vhost_net *net, struct socket *sock)
>  
>  		/* use msg_control to pass vhost zerocopy ubuf info to skb */
>  		if (zcopy_used) {
> -			struct ubuf_info *ubuf;
>  			ubuf = nvq->ubuf_info + nvq->upend_idx;
> -
>  			vq->heads[nvq->upend_idx].id = cpu_to_vhost32(vq, head);
>  			vq->heads[nvq->upend_idx].len = VHOST_DMA_IN_PROGRESS;
>  			ubuf->callback = vhost_zerocopy_callback;
> @@ -927,7 +926,8 @@ static void handle_tx_zerocopy(struct vhost_net *net, struct socket *sock)
>  		err = sock->ops->sendmsg(sock, &msg, len);
>  		if (unlikely(err < 0)) {
>  			if (zcopy_used) {
> -				vhost_net_ubuf_put(ubufs);
> +				if (vq->heads[ubuf->desc].len == VHOST_DMA_IN_PROGRESS)
> +					vhost_net_ubuf_put(ubufs);
>  				nvq->upend_idx = ((unsigned)nvq->upend_idx - 1)
>  					% UIO_MAXIOV;
>  			}
> -- 
> 2.23.0

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
