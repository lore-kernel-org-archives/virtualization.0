Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28055C433F5
	for <virtualization@archiver.kernel.org>; Mon, 16 May 2022 08:44:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id B63C161021;
	Mon, 16 May 2022 08:44:32 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id HUtHRpfRzs9z; Mon, 16 May 2022 08:44:31 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id AD8A661004;
	Mon, 16 May 2022 08:44:30 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 7DEBEC0032;
	Mon, 16 May 2022 08:44:30 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 91F99C002D
 for <virtualization@lists.linux-foundation.org>;
 Mon, 16 May 2022 08:44:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 6F70A41720
 for <virtualization@lists.linux-foundation.org>;
 Mon, 16 May 2022 08:44:28 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id b_UOZzOSj0_O
 for <virtualization@lists.linux-foundation.org>;
 Mon, 16 May 2022 08:44:27 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 800C94174E
 for <virtualization@lists.linux-foundation.org>;
 Mon, 16 May 2022 08:44:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1652690666;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=sIh/SA6Lh64JUzXDkOFTJ2gpJyP3Qx/KaUYhX+otn9k=;
 b=hOMitaAJh+pjpEL0/UVbNK1eAbyEJ67uxU70dpdHnMFHujW8se3Icf417F5N65fRNU4TPB
 mCUi6/cS7zmY9BlEVd2T+qXIby+uXT3BfpfN14FEz9HXYFOqUIdwmHSvrBzus5PbF9c+SL
 ttM+J/dfgc4Sav7l/bBqndUw+8PX5q4=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-600-3gGACsz-PrSwxN-6HzPcCQ-1; Mon, 16 May 2022 04:44:25 -0400
X-MC-Unique: 3gGACsz-PrSwxN-6HzPcCQ-1
Received: by mail-wr1-f70.google.com with SMTP id
 k18-20020adfe3d2000000b0020d08dfd471so258809wrm.14
 for <virtualization@lists.linux-foundation.org>;
 Mon, 16 May 2022 01:44:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=sIh/SA6Lh64JUzXDkOFTJ2gpJyP3Qx/KaUYhX+otn9k=;
 b=K/rpUjrYvJtbgAIA2yLqPPgub5XRZSTmdE27XRPajj4Nk9vhZTfQWGLSrHjkAKhL+Y
 ljAbbU7nL5WbRM6Ojeau3dxqQ2kj+nXjpwUzbOFVEjjwf7j6HvT+XnZcyPk+km/0Td9q
 Pn+ErMivaydimMRqYowkrtU8c2f5k9Kgu81nE1BW+T0GIsEBbfn6HS3/kRiv/mt67NLC
 AfeWJFIaoefB10ERdA0ILajKkEZ95qZntmntX85AkfIyDkIkI5UTEnyqIG+KhETnho6E
 mijTLrs7LBGqagS+hBKmd5ffBlUs3Z3gANC6sDV1INQ3nNJcVnAxzWb8VMi/krKQMfM5
 IXTA==
X-Gm-Message-State: AOAM5330sO5Y7cUrlEzTIDUCq6w2LLIbNLlRbl9OC6yzFYf+3nrFsw2F
 B71S1rt/ujsGkj7Y7GruxJ4iYpPcZ+lwetr3T5BPf7g8Enr+a5Yj8IH9oaAtQFbiNUhcfuQUrj/
 duMoc3gL0CKcXymDbQva1/LTm7ye+Tl5YTy4YtGP0Ew==
X-Received: by 2002:adf:d1e7:0:b0:20c:61a7:de2a with SMTP id
 g7-20020adfd1e7000000b0020c61a7de2amr13269783wrd.332.1652690663749; 
 Mon, 16 May 2022 01:44:23 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxbBG8LK3Kh/lhJrrOS7oQF11zBcMwtWlGcaXVik8WHSHfaxvjP441ee8zh05lWN6MkOd+W8g==
X-Received: by 2002:adf:d1e7:0:b0:20c:61a7:de2a with SMTP id
 g7-20020adfd1e7000000b0020c61a7de2amr13269770wrd.332.1652690663494; 
 Mon, 16 May 2022 01:44:23 -0700 (PDT)
Received: from redhat.com ([2.55.141.66]) by smtp.gmail.com with ESMTPSA id
 d3-20020a1c7303000000b003942a244ee6sm9682633wmb.43.2022.05.16.01.44.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 May 2022 01:44:23 -0700 (PDT)
Date: Mon, 16 May 2022 04:44:19 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH] vhost_net: fix double fget()
Message-ID: <20220516044400-mutt-send-email-mst@kernel.org>
References: <20220516084213.26854-1-jasowang@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20220516084213.26854-1-jasowang@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: kvm@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, ebiggers@kernel.org,
 viro@zeniv.linux.org.uk, linux-fsdevel@vger.kernel.org, davem@davemloft.net
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

On Mon, May 16, 2022 at 04:42:13PM +0800, Jason Wang wrote:
> From: Al Viro <viro@zeniv.linux.org.uk>
> 
> Here's another piece of code assuming that repeated fget() will yield the
> same opened file: in vhost_net_set_backend() we have
> 
>         sock = get_socket(fd);
>         if (IS_ERR(sock)) {
>                 r = PTR_ERR(sock);
>                 goto err_vq;
>         }
> 
>         /* start polling new socket */
>         oldsock = vhost_vq_get_backend(vq);
>         if (sock != oldsock) {
> ...
>                 vhost_vq_set_backend(vq, sock);
> ...
>                 if (index == VHOST_NET_VQ_RX)
>                         nvq->rx_ring = get_tap_ptr_ring(fd);
> 
> with
> static struct socket *get_socket(int fd)
> {
>         struct socket *sock;
> 
>         /* special case to disable backend */
>         if (fd == -1)
>                 return NULL;
>         sock = get_raw_socket(fd);
>         if (!IS_ERR(sock))
>                 return sock;
>         sock = get_tap_socket(fd);
>         if (!IS_ERR(sock))
>                 return sock;
>         return ERR_PTR(-ENOTSOCK);
> }
> and
> static struct ptr_ring *get_tap_ptr_ring(int fd)
> {
>         struct ptr_ring *ring;
>         struct file *file = fget(fd);
> 
>         if (!file)
>                 return NULL;
>         ring = tun_get_tx_ring(file);
>         if (!IS_ERR(ring))
>                 goto out;
>         ring = tap_get_ptr_ring(file);
>         if (!IS_ERR(ring))
>                 goto out;
>         ring = NULL;
> out:
>         fput(file);
>         return ring;
> }
> 
> Again, there is no promise that fd will resolve to the same thing for
> lookups in get_socket() and in get_tap_ptr_ring().  I'm not familiar
> enough with the guts of drivers/vhost to tell how easy it is to turn
> into attack, but it looks like trouble.  If nothing else, the pointer
> returned by tun_get_tx_ring() is not guaranteed to be pinned down by
> anything - the reference to sock will _usually_ suffice, but that
> doesn't help any if we get a different socket on that second fget().
> 
> One possible way to fix it would be the patch below; objections?
> 
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> Signed-off-by: Jason Wang <jasowang@redhat.com>

Acked-by: Michael S. Tsirkin <mst@redhat.com>

and this is stable material I guess.

> ---
>  drivers/vhost/net.c | 15 +++++++--------
>  1 file changed, 7 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/vhost/net.c b/drivers/vhost/net.c
> index 28ef323882fb..0bd7d91de792 100644
> --- a/drivers/vhost/net.c
> +++ b/drivers/vhost/net.c
> @@ -1449,13 +1449,9 @@ static struct socket *get_raw_socket(int fd)
>  	return ERR_PTR(r);
>  }
>  
> -static struct ptr_ring *get_tap_ptr_ring(int fd)
> +static struct ptr_ring *get_tap_ptr_ring(struct file *file)
>  {
>  	struct ptr_ring *ring;
> -	struct file *file = fget(fd);
> -
> -	if (!file)
> -		return NULL;
>  	ring = tun_get_tx_ring(file);
>  	if (!IS_ERR(ring))
>  		goto out;
> @@ -1464,7 +1460,6 @@ static struct ptr_ring *get_tap_ptr_ring(int fd)
>  		goto out;
>  	ring = NULL;
>  out:
> -	fput(file);
>  	return ring;
>  }
>  
> @@ -1551,8 +1546,12 @@ static long vhost_net_set_backend(struct vhost_net *n, unsigned index, int fd)
>  		r = vhost_net_enable_vq(n, vq);
>  		if (r)
>  			goto err_used;
> -		if (index == VHOST_NET_VQ_RX)
> -			nvq->rx_ring = get_tap_ptr_ring(fd);
> +		if (index == VHOST_NET_VQ_RX) {
> +			if (sock)
> +				nvq->rx_ring = get_tap_ptr_ring(sock->file);
> +			else
> +				nvq->rx_ring = NULL;
> +		}
>  
>  		oldubufs = nvq->ubufs;
>  		nvq->ubufs = ubufs;
> -- 
> 2.25.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
