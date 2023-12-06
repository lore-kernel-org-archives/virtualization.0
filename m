Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2126495F2
	for <virtualization@lists.linux-foundation.org>; Wed,  6 Dec 2023 21:53:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GJk/280L"
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 70F78435AC
	for <virtualization@lists.linux-foundation.org>; Wed,  6 Dec 2023 21:53:56 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 70F78435AC
Authentication-Results: smtp2.osuosl.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=GJk/280L
X-Virus-Scanned: amavisd-new at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.099
X-Spam-Level:
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id vXM9Vj0gkM4i
	for <virtualization@lists.linux-foundation.org>;
	Wed,  6 Dec 2023 21:53:55 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 4D28E435A5
	for <virtualization@lists.linux-foundation.org>; Wed,  6 Dec 2023 21:53:55 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 4D28E435A5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1701899633;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=yOEpllxAwSl6tZ982lozHOqBhkjhw8aoaRRTDnS4iew=;
	b=GJk/280LlJst+5PdwtFNpIOq0peVUbLvvj/pF2CZUUd90M9ECfLGK2RwamDl1Yo8gUNWGk
	eX1ckphjB66zpSbJ6urLbmsKryoGm7ZUujH8D98YCU3t2Dg0L8KZAQfuiz/LaVMn3naiZL
	B8lLXXpL8pwDxx9xFtXsOGpnJ4+9YE4=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-634-OjNmZxIzOAqnF11A8V_ASA-1; Wed, 06 Dec 2023 16:53:52 -0500
X-MC-Unique: OjNmZxIzOAqnF11A8V_ASA-1
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-3334e56554bso225962f8f.0
        for <virtualization@lists.linux-foundation.org>; Wed, 06 Dec 2023 13:53:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701899631; x=1702504431;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yOEpllxAwSl6tZ982lozHOqBhkjhw8aoaRRTDnS4iew=;
        b=R1HwC7hLJj8bB6LlAeq9PZF4w+ZtadOQYCcKBvG6pwO359q22zeM4x1Ll7O0zcKh3A
         NaEuSBgjdcdmQKDoEiwKik4JPADhwpjJEPazzK1rM1vYsbEVtQH7/x1441IODzGwI4HK
         cX0JLSmo/7O4QsI0iIUSfi5H9G+xKIS3oG1Z0jhweWFxrvuAZBhKX7hNDG9zB7e/aoOr
         5CCI2rzCcPdnmI9mgWHuNlYAhAH1YFr8AeHm9yDebZ4bZYCDVJMvz94il7T0gHB6Tkuc
         opIdt8FLr2wnaW6cAowNfS/dNPAA3ej5nMpswDCBEhsbuRymEpkRTo1RPtqIHxdn+EFu
         IfRw==
X-Gm-Message-State: AOJu0Yxt/cMff6/lJ6WcQ3Kr3sdEamaoiYLnhqJgVb1o3EMKVxzN2xk+
	Q28vxZ2eU1GigFf9M/kXSptDZ3Z+n7SCF6M3ECtvdqQxH/a0OqaCZF8B4dxAl8LdRAYGlWpQlHa
	fRk5ZqRZ4hGIpqy373NnNuukEBmsYuAaw4yIeLm1IlQ==
X-Received: by 2002:a1c:720c:0:b0:40c:25c7:b323 with SMTP id n12-20020a1c720c000000b0040c25c7b323mr416132wmc.125.1701899631160;
        Wed, 06 Dec 2023 13:53:51 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHKupXK9Nk8V+FfPP14UqB6ekz3NO+3af+wasE4pH9WneljAze4p+zMe4/8H113wgoXLXea/w==
X-Received: by 2002:a1c:720c:0:b0:40c:25c7:b323 with SMTP id n12-20020a1c720c000000b0040c25c7b323mr416114wmc.125.1701899630826;
        Wed, 06 Dec 2023 13:53:50 -0800 (PST)
Received: from redhat.com ([2.55.57.48])
        by smtp.gmail.com with ESMTPSA id l9-20020a1709066b8900b00a1d8626d650sm435564ejr.208.2023.12.06.13.53.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Dec 2023 13:53:50 -0800 (PST)
Date: Wed, 6 Dec 2023 16:53:44 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Arseniy Krasnov <avkrasnov@salutedevices.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>,
	Stefano Garzarella <sgarzare@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Bobby Eshleman <bobby.eshleman@bytedance.com>, kvm@vger.kernel.org,
	virtualization@lists.linux-foundation.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel@sberdevices.ru,
	oxffffaa@gmail.com
Subject: Re: [PATCH net-next v7 3/4] virtio/vsock: fix logic which reduces
 credit update messages
Message-ID: <20231206165045-mutt-send-email-mst@kernel.org>
References: <20231206211849.2707151-1-avkrasnov@salutedevices.com>
 <20231206211849.2707151-4-avkrasnov@salutedevices.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20231206211849.2707151-4-avkrasnov@salutedevices.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Dec 07, 2023 at 12:18:48AM +0300, Arseniy Krasnov wrote:
> Add one more condition for sending credit update during dequeue from
> stream socket: when number of bytes in the rx queue is smaller than
> SO_RCVLOWAT value of the socket. This is actual for non-default value
> of SO_RCVLOWAT (e.g. not 1) - idea is to "kick" peer to continue data
> transmission, because we need at least SO_RCVLOWAT bytes in our rx
> queue to wake up user for reading data (in corner case it is also
> possible to stuck both tx and rx sides, this is why 'Fixes' is used).
> Also handle case when 'fwd_cnt' wraps, while 'last_fwd_cnt' is still
> not.
> 
> Fixes: b89d882dc9fc ("vsock/virtio: reduce credit update messages")
> Signed-off-by: Arseniy Krasnov <avkrasnov@salutedevices.com>
> ---
>  Changelog:
>  v6 -> v7:
>   * Handle wrap of 'fwd_cnt'.
>   * Do to send credit update when 'fwd_cnt' == 'last_fwd_cnt'.
> 
>  net/vmw_vsock/virtio_transport_common.c | 18 +++++++++++++++---
>  1 file changed, 15 insertions(+), 3 deletions(-)
> 
> diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
> index e137d740804e..39f8660d825d 100644
> --- a/net/vmw_vsock/virtio_transport_common.c
> +++ b/net/vmw_vsock/virtio_transport_common.c
> @@ -558,6 +558,8 @@ virtio_transport_stream_do_dequeue(struct vsock_sock *vsk,
>  	struct virtio_vsock_sock *vvs = vsk->trans;
>  	size_t bytes, total = 0;
>  	struct sk_buff *skb;
> +	u32 fwd_cnt_delta;
> +	bool low_rx_bytes;
>  	int err = -EFAULT;
>  	u32 free_space;
>  
> @@ -601,7 +603,15 @@ virtio_transport_stream_do_dequeue(struct vsock_sock *vsk,
>  		}
>  	}
>  
> -	free_space = vvs->buf_alloc - (vvs->fwd_cnt - vvs->last_fwd_cnt);
> +	/* Handle wrap of 'fwd_cnt'. */
> +	if (vvs->fwd_cnt < vvs->last_fwd_cnt)
> +		fwd_cnt_delta = vvs->fwd_cnt + (U32_MAX - vvs->last_fwd_cnt);

Are you sure there's no off by one here? for example if fwd_cnt is 0
and last_fwd_cnt is 0xfffffffff then apparently delta is 0.


> +	else
> +		fwd_cnt_delta = vvs->fwd_cnt - vvs->last_fwd_cnt;

I actually don't see what is wrong with just
	fwd_cnt_delta = vvs->fwd_cnt - vvs->last_fwd_cnt
32 bit unsigned math will I think handle wrap around correctly.

And given buf_alloc is also u32 - I don't see where the bug is in
the original code.


> +
> +	free_space = vvs->buf_alloc - fwd_cnt_delta;
> +	low_rx_bytes = (vvs->rx_bytes <
> +			sock_rcvlowat(sk_vsock(vsk), 0, INT_MAX));
>  
>  	spin_unlock_bh(&vvs->rx_lock);
>  
> @@ -611,9 +621,11 @@ virtio_transport_stream_do_dequeue(struct vsock_sock *vsk,
>  	 * too high causes extra messages. Too low causes transmitter
>  	 * stalls. As stalls are in theory more expensive than extra
>  	 * messages, we set the limit to a high value. TODO: experiment
> -	 * with different values.
> +	 * with different values. Also send credit update message when
> +	 * number of bytes in rx queue is not enough to wake up reader.
>  	 */
> -	if (free_space < VIRTIO_VSOCK_MAX_PKT_BUF_SIZE)
> +	if (fwd_cnt_delta &&
> +	    (free_space < VIRTIO_VSOCK_MAX_PKT_BUF_SIZE || low_rx_bytes))
>  		virtio_transport_send_credit_update(vsk);
>  
>  	return total;
> -- 
> 2.25.1

