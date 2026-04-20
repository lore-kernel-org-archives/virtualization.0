Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F9BB34DB59
	for <virtualization@lists.linux.dev>; Mon, 20 Apr 2026 18:34:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776710070; cv=none; b=FVZ+HuWX8f/VNCZL6GYP65T7ZaEQlFKJG1ZyzsuQ1SQS7hYXfswZu8819J1PnyFOwFCMdISVJk3elejX/CK61tmOllp2XIlDKxL/0BdJUldgyZUPmH4DrXzVKORAplCdcFWE/98HPcyjj1/X8n1sqOesALOOjjhRIefbrH2aEq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776710070; c=relaxed/simple;
	bh=ienUfESzt6vNzLdl8pNwfDx7dxAyw+aVjIBPr3f4Yec=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G6M1Qol3Qy2T2wD0LbdYJVN3tmD6QDJezEAI8LyUCSeFqmCqWBeI0k84SMgXG580eLME5dnC1b/dysOwXMzxsbrcIHq2xSf7im3m8oR3UiyO0I44ygBBD8Tz1UknHTGrsvH81sBuKe3rZPQJKkpvkMSRd1dhCKFgls7jawhyJoc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hHLQ6MT0; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hHLQ6MT0"
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-82cebbdbdccso2054941b3a.1
        for <virtualization@lists.linux.dev>; Mon, 20 Apr 2026 11:34:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776710068; x=1777314868; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=kqExjaso/aiD1XgkyqsZ6VooUNyCznnnKYPwy1DQRPE=;
        b=hHLQ6MT0zWL4ihB/W5TOpvkpcTJPssIDyD4xnfvcAXvi7bQKc9W9ug7FW1+h0PqrVx
         +8LB63w1HXE62IC/K6+jRuU2AR/cG8BGMlcyAH/yFpIzKJcP59evIKg3E8zclfxLiY78
         +IqPJnCFaT8scaU841KEjMqoeiylalSKbMcM+lR6ZQOE6jJMkqITWD2so+c2zBXeLbIF
         PhXqpsUwMRlqD6FNgGm4QDt2UYgC+rhzyVH3ljSnpkQvkXxXg9z0nRs/fDALWDmskiUH
         9lhsYisdQdZwOeuyIhtmqO3T1l6puQuSynTkJsRJbKnvA69Vry6VBNAJ0xmfw7zlzHcj
         PeBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776710068; x=1777314868;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kqExjaso/aiD1XgkyqsZ6VooUNyCznnnKYPwy1DQRPE=;
        b=WlM4g7Ns6FLoaXIp/Q86U8mj4VvGD7rprqlJGAVLlXvL8t8EP0GJ60rORvAXpbk8BW
         hngudoUJzLIYRZ6QKf4sybN6vhaVfWtk7rtK7CsnuJgu3xXAKt8EuuryFHtD6mDwArQY
         9gZi0C8dWqRXDySPrRv76Evhu4SnUiI6DBqrtiCQjh73pz4g2Z7hAuVBhrub0MoIzqfj
         p4pdK6aGFbg5AtAcz3uRb46AL7BjVhUkUw2S5F47ubzp+qIOMNhAMAwRWVG3+H0VaJe7
         q/jx8f4w7p6syVyv91vrMF5nw3/ca5e3jqo1KLsyW7VypkXn1xi3adVYnXV+e1Ohgb0y
         b7tA==
X-Forwarded-Encrypted: i=1; AFNElJ9CVSXH0voCRuBWJxZ5j81BXYaBOQx9HSlpB07P431qLGtshxUcaSq0WZIq6OUNgEIvJnX7vD/r1uSwfkuSTQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Yz/0Nb5Asmive4OjKu+Ho1PF52BG/DPS9oxnPTK/cHV6wpcrnTl
	0RZkVciOBCj1X/IF1A5/xZYr+3WBEsMseuT4PkD5QKiJuYNRe/oFs6wX
X-Gm-Gg: AeBDietihL3+7Md9TsUvxTPZiAlJmKSN2OjHDCwVr7jH04J4GvzS9Q2gOUR1+I8RvSR
	tYwVfq8kPv6W5EnnpbOU5RcWgcasWYwxqZDSyGqTjj5Caoe2sXWTXVUi1z878aAki+IxaOjpOvQ
	MRJl9Gn7nZDXWrl0fV8vkYIjjpSs6A/rfhgmT90lCR6MVkUSzWgxz5GAAPsVG8c1uoZcQMf/JEA
	S4fy3l+CVoQ+r/jXSFqlw5HfiDZgdtkYHNi1lZ7RaqfQ/tu+6fyiZm+fc3biko9aqyBy43pZgVc
	jHsAridJ1+mfzeGAKg/a4AIxk9tRuDYRWAhLGUaNGy2IYYGndR6Gwu4zQGF9pUhgnwoQd3EywTt
	fyhHG2v7I10iPKMkY4Cc4ddZ8XfPGLT4notTOuAtjKW3kEIqT0RWKM/0ouVG+UMtVw87JaGB9K8
	7N4RGMwfaW5WyAKQAqvZ4dfyGyxmWCkA3NJ3VTncg+LXhhSV0HYZr9lg==
X-Received: by 2002:a05:6a00:4c82:b0:82f:7cb7:63c7 with SMTP id d2e1a72fcca58-82f8b384f1amr11355701b3a.11.1776710068332;
        Mon, 20 Apr 2026 11:34:28 -0700 (PDT)
Received: from devvm29614.prn0.facebook.com ([2a03:2880:ff:2::])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82f8e9d35acsm11798580b3a.15.2026.04.20.11.34.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Apr 2026 11:34:27 -0700 (PDT)
Date: Mon, 20 Apr 2026 11:34:25 -0700
From: Bobby Eshleman <bobbyeshleman@gmail.com>
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: netdev@vger.kernel.org, Eric Dumazet <edumazet@google.com>,
	Simon Horman <horms@kernel.org>, kvm@vger.kernel.org,
	Arseniy Krasnov <avkrasnov@salutedevices.com>,
	"David S. Miller" <davem@davemloft.net>,
	Paolo Abeni <pabeni@redhat.com>, Jakub Kicinski <kuba@kernel.org>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>, virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	Yiming Qian <yimingqian591@gmail.com>
Subject: Re: [PATCH net] vsock/virtio: fix MSG_ZEROCOPY pinned-pages
 accounting
Message-ID: <aeZxscYXyE6BE0tY@devvm29614.prn0.facebook.com>
References: <20260420132051.217589-1-sgarzare@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260420132051.217589-1-sgarzare@redhat.com>

On Mon, Apr 20, 2026 at 03:20:51PM +0200, Stefano Garzarella wrote:
> From: Stefano Garzarella <sgarzare@redhat.com>
> 
> virtio_transport_init_zcopy_skb() uses iter->count as the size argument
> for msg_zerocopy_realloc(), which in turn passes it to
> mm_account_pinned_pages() for RLIMIT_MEMLOCK accounting. However, this
> function is called after virtio_transport_fill_skb() has already consumed
> the iterator via __zerocopy_sg_from_iter(), so on the last skb, iter->count
> will be 0, skipping the RLIMIT_MEMLOCK enforcement.
> 
> Pass pkt_len (the total bytes being sent) as an explicit parameter to
> virtio_transport_init_zcopy_skb() instead of reading the already-consumed
> iter->count.
> 
> This matches TCP and UDP, which both call msg_zerocopy_realloc() with
> the original message size.
> 
> Fixes: 581512a6dc93 ("vsock/virtio: MSG_ZEROCOPY flag support")
> Reported-by: Yiming Qian <yimingqian591@gmail.com>
> Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
> ---
>  net/vmw_vsock/virtio_transport_common.c | 11 ++++++++---
>  1 file changed, 8 insertions(+), 3 deletions(-)
> 
> diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
> index 0742091beae7..416d533f493d 100644
> --- a/net/vmw_vsock/virtio_transport_common.c
> +++ b/net/vmw_vsock/virtio_transport_common.c
> @@ -73,6 +73,7 @@ static bool virtio_transport_can_zcopy(const struct virtio_transport *t_ops,
>  static int virtio_transport_init_zcopy_skb(struct vsock_sock *vsk,
>  					   struct sk_buff *skb,
>  					   struct msghdr *msg,
> +					   size_t pkt_len,
>  					   bool zerocopy)
>  {
>  	struct ubuf_info *uarg;
> @@ -81,12 +82,10 @@ static int virtio_transport_init_zcopy_skb(struct vsock_sock *vsk,
>  		uarg = msg->msg_ubuf;
>  		net_zcopy_get(uarg);
>  	} else {
> -		struct iov_iter *iter = &msg->msg_iter;
>  		struct ubuf_info_msgzc *uarg_zc;
>  
>  		uarg = msg_zerocopy_realloc(sk_vsock(vsk),
> -					    iter->count,
> -					    NULL, false);
> +					    pkt_len, NULL, false);
>  		if (!uarg)
>  			return -1;
>  
> @@ -398,11 +397,17 @@ static int virtio_transport_send_pkt_info(struct vsock_sock *vsk,
>  		 * each iteration. If this is last skb for this buffer
>  		 * and MSG_ZEROCOPY mode is in use - we must allocate
>  		 * completion for the current syscall.
> +		 *
> +		 * Pass pkt_len because msg iter is already consumed
> +		 * by virtio_transport_fill_skb(), so iter->count
> +		 * can not be used for RLIMIT_MEMLOCK pinned-pages
> +		 * accounting done by msg_zerocopy_realloc().
>  		 */
>  		if (info->msg && info->msg->msg_flags & MSG_ZEROCOPY &&
>  		    skb_len == rest_len && info->op == VIRTIO_VSOCK_OP_RW) {
>  			if (virtio_transport_init_zcopy_skb(vsk, skb,
>  							    info->msg,
> +							    pkt_len,
>  							    can_zcopy)) {
>  				kfree_skb(skb);
>  				ret = -ENOMEM;
> -- 
> 2.53.0
> 

Reviewed-by: Bobby Eshleman <bobbyeshleman@meta.com>
