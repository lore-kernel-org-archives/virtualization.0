Return-Path: <SRS0=FCrO=F7=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D789C433E0
	for <virtualization@archiver.kernel.org>; Sun, 27 Dec 2020 11:23:24 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CBD032078B
	for <virtualization@archiver.kernel.org>; Sun, 27 Dec 2020 11:23:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CBD032078B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 7E5F386FDB;
	Sun, 27 Dec 2020 11:23:23 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id K8bw-55KT96S; Sun, 27 Dec 2020 11:23:22 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id E264B86DC6;
	Sun, 27 Dec 2020 11:23:22 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B60E1C1787;
	Sun, 27 Dec 2020 11:23:22 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 04161C0891
 for <virtualization@lists.linux-foundation.org>;
 Sun, 27 Dec 2020 11:23:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id E82EE86055
 for <virtualization@lists.linux-foundation.org>;
 Sun, 27 Dec 2020 11:23:20 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id RJJ11LKJUsxH
 for <virtualization@lists.linux-foundation.org>;
 Sun, 27 Dec 2020 11:23:19 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by whitealder.osuosl.org (Postfix) with ESMTPS id B28188602E
 for <virtualization@lists.linux-foundation.org>;
 Sun, 27 Dec 2020 11:23:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1609068198;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Carv6zqFCxj0J5YQLwT4wyQy1B7lV2HXgXZ8v+ZCP0I=;
 b=OL/MhxivORzdsyx4BQbph6288QAB5ZRdLy7Od/eCMpD7sBIwjeS7O15EHHLUzWebZrDEnc
 CB/BHRnlLkdoZQLxG8XkpgF3EZVu67SkKVSUjQoKIImEwVlnqK5B7r5KQMdyBQaOAgFuyC
 /PhRQJztUyEThv7N8ESDlUG46wX7+v8=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-215-BQuKja3YNLWS1ttdzpbUoA-1; Sun, 27 Dec 2020 06:23:16 -0500
X-MC-Unique: BQuKja3YNLWS1ttdzpbUoA-1
Received: by mail-wr1-f72.google.com with SMTP id o17so5034666wra.8
 for <virtualization@lists.linux-foundation.org>;
 Sun, 27 Dec 2020 03:23:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=Carv6zqFCxj0J5YQLwT4wyQy1B7lV2HXgXZ8v+ZCP0I=;
 b=Q5CKxpXcd13vOQ9MF815UYWPp1a0IuHT6c2sMZ6P7/0A0D0OlpLwmmQ70lj8si3gll
 HfOY6fLzhAZyk65BQTt0W1laWEdmylcmvt4zVzsYc0dKstQZFJLxRqmBJiovS9EYekOE
 Q60tCpdojEsVBRSAqJ3206h3LH3fdFhWynkFPJYNMChnPH4F3VmHBDn29jecRkueSUc1
 m+7D6O/ahktAfmKdLeEI6s++ib65UmoXj8KiRPhFf1nVXKuCKgmotGwCY/fJDz69Puv3
 rwljat2jvZiEZswYE3ub8KeENr7zR3RILMrEP32PeninfdNPAfHaZHMsTYsFdCzsPMxB
 sLmA==
X-Gm-Message-State: AOAM530k53QFD7j/mBVeJzeNgLZS7JnQzc8SMW1XRAR71Dc2KGipC5EP
 UPx+0WfuW9UPg1NCIRpmHTALhXNfvxzHKXtKyhjXqPyLEX1P9ZYEzgzl/nD3qidtfK2QjwW0Jln
 zkAYCELtwEM6EGjXh4WKKek0oit5V38FLLmhUWtXryw==
X-Received: by 2002:a5d:43c3:: with SMTP id v3mr45690456wrr.184.1609068195563; 
 Sun, 27 Dec 2020 03:23:15 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxVsbhQmBiDdexctHvz3t2WDXdLYzGebQwsNHSMiEt3Oqou/yS9LHj6OLmpHQCoqKyVAkhaMQ==
X-Received: by 2002:a5d:43c3:: with SMTP id v3mr45690436wrr.184.1609068195387; 
 Sun, 27 Dec 2020 03:23:15 -0800 (PST)
Received: from redhat.com (bzq-79-178-32-166.red.bezeqint.net. [79.178.32.166])
 by smtp.gmail.com with ESMTPSA id b13sm49362684wrt.31.2020.12.27.03.23.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 27 Dec 2020 03:23:14 -0800 (PST)
Date: Sun, 27 Dec 2020 06:23:11 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: wangyunjian <wangyunjian@huawei.com>
Subject: Re: [PATCH net v5 1/2] vhost_net: fix ubuf refcount incorrectly when
 sendmsg fails
Message-ID: <20201227062220-mutt-send-email-mst@kernel.org>
References: <1608881065-7572-1-git-send-email-wangyunjian@huawei.com>
MIME-Version: 1.0
In-Reply-To: <1608881065-7572-1-git-send-email-wangyunjian@huawei.com>
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

On Fri, Dec 25, 2020 at 03:24:25PM +0800, wangyunjian wrote:
> From: Yunjian Wang <wangyunjian@huawei.com>
> 
> Currently the vhost_zerocopy_callback() maybe be called to decrease
> the refcount when sendmsg fails in tun. The error handling in vhost
> handle_tx_zerocopy() will try to decrease the same refcount again.
> This is wrong. To fix this issue, we only call vhost_net_ubuf_put()
> when vq->heads[nvq->desc].len == VHOST_DMA_IN_PROGRESS.
> 
> Fixes: 0690899b4d45 ("tun: experimental zero copy tx support")

Are you sure about this tag? the patch in question only affects
tun, while the fix only affects vhost.

> Signed-off-by: Yunjian Wang <wangyunjian@huawei.com>
> Acked-by: Willem de Bruijn <willemb@google.com>
> Acked-by: Michael S. Tsirkin <mst@redhat.com>
> Acked-by: Jason Wang <jasowang@redhat.com>
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
