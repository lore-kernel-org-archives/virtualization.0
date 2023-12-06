Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D44A256392
	for <virtualization@lists.linux-foundation.org>; Wed,  6 Dec 2023 22:08:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LP0ayxyb"
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 4ABC440874
	for <virtualization@lists.linux-foundation.org>; Wed,  6 Dec 2023 22:08:13 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 4ABC440874
Authentication-Results: smtp4.osuosl.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=LP0ayxyb
X-Virus-Scanned: amavisd-new at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.099
X-Spam-Level:
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Dcj62yPWeb6J
	for <virtualization@lists.linux-foundation.org>;
	Wed,  6 Dec 2023 22:08:12 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 779374086B
	for <virtualization@lists.linux-foundation.org>; Wed,  6 Dec 2023 22:08:12 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 779374086B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1701900491;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3cM3G3IxJYLM5tCOwlfSEThSnIq2Ia0o8pmJScU+oeA=;
	b=LP0ayxybCAMjGUkLBJUNs2htBzsetpzYMQ6kAeuKXcQ1DOky651j49kha21z8RksbePzAJ
	bp3yj0KJObKkI7m6YU0RALQP0u+229gchUauIFREiyStzy8ujZjmhq6ISGGVhkZg9+d4ph
	nmn6lE6ksgeEb4zFfOzAJmsNNedzksk=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-538-CHFFWTq0Od--tjZH8WOOig-1; Wed, 06 Dec 2023 17:08:09 -0500
X-MC-Unique: CHFFWTq0Od--tjZH8WOOig-1
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-a1df15ec5ffso13419966b.3
        for <virtualization@lists.linux-foundation.org>; Wed, 06 Dec 2023 14:08:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701900488; x=1702505288;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3cM3G3IxJYLM5tCOwlfSEThSnIq2Ia0o8pmJScU+oeA=;
        b=teThcNmGsojE8u/GJbBUALfIJrubt/sAqX1+EI5MPO5I9N/30k1KmFsMTizK4LJdVS
         D1wZZw06Yn1mqyrFVgjfqnB1ukaskNoeKqNGGVpQ9MP8gF2RioOEde+j6byzMCM6AXgH
         2km92ahAzpUPlZURlbkrIUPc1Z5I6iJJAYLqH+CIOjZaeEZV0bg6EcrVJbUd7F7q19hJ
         m1wPpQzgK7WdPkQxfVyjUGa5+R/Tw8JxBlPwKeHFRP1eCT3r6+6wc0dvi+h/7sAJirX7
         rDZWHX0jbnXNKLpVLdZNjihbQZtgoprb5OSYwx70l/XdqP0TcmKNKWA2KUshCQ255NON
         wI7g==
X-Gm-Message-State: AOJu0YyQgMKVJipAbwsDSqJUsGRk8GVRLjEfLx4rbkO4aDdgccbBELB4
	sc4g1I4zhak2fyhNITecRiJAx+yVBgl38Btz1OrH9qGK14qMjwelQCRUVvv5ikfuZC+2A6qqP6f
	Ott20GhuVZQ7lj30hCO+znwet+lgBBt5Zw+SDfdkQtw==
X-Received: by 2002:a17:906:225a:b0:a01:9d8b:db17 with SMTP id 26-20020a170906225a00b00a019d8bdb17mr1089774ejr.15.1701900488772;
        Wed, 06 Dec 2023 14:08:08 -0800 (PST)
X-Google-Smtp-Source: AGHT+IELc1CseN/Lgd5NWinZpBx+NzuVrz10mseWrWKMVnwyTe6bCu+laowzD1kdbkuuvmu6nxMTFQ==
X-Received: by 2002:a17:906:225a:b0:a01:9d8b:db17 with SMTP id 26-20020a170906225a00b00a019d8bdb17mr1089759ejr.15.1701900488420;
        Wed, 06 Dec 2023 14:08:08 -0800 (PST)
Received: from redhat.com ([2.55.11.67])
        by smtp.gmail.com with ESMTPSA id d25-20020a170906371900b00a1d754b30a9sm462436ejc.86.2023.12.06.14.08.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Dec 2023 14:08:07 -0800 (PST)
Date: Wed, 6 Dec 2023 17:08:02 -0500
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
Message-ID: <20231206170640-mutt-send-email-mst@kernel.org>
References: <20231206211849.2707151-1-avkrasnov@salutedevices.com>
 <20231206211849.2707151-4-avkrasnov@salutedevices.com>
 <20231206165045-mutt-send-email-mst@kernel.org>
 <d9d1ec6a-dd9b-61d9-9211-52e9437cbb1f@salutedevices.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <d9d1ec6a-dd9b-61d9-9211-52e9437cbb1f@salutedevices.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Dec 07, 2023 at 12:52:51AM +0300, Arseniy Krasnov wrote:
> 
> 
> On 07.12.2023 00:53, Michael S. Tsirkin wrote:
> > On Thu, Dec 07, 2023 at 12:18:48AM +0300, Arseniy Krasnov wrote:
> >> Add one more condition for sending credit update during dequeue from
> >> stream socket: when number of bytes in the rx queue is smaller than
> >> SO_RCVLOWAT value of the socket. This is actual for non-default value
> >> of SO_RCVLOWAT (e.g. not 1) - idea is to "kick" peer to continue data
> >> transmission, because we need at least SO_RCVLOWAT bytes in our rx
> >> queue to wake up user for reading data (in corner case it is also
> >> possible to stuck both tx and rx sides, this is why 'Fixes' is used).
> >> Also handle case when 'fwd_cnt' wraps, while 'last_fwd_cnt' is still
> >> not.
> >>
> >> Fixes: b89d882dc9fc ("vsock/virtio: reduce credit update messages")
> >> Signed-off-by: Arseniy Krasnov <avkrasnov@salutedevices.com>
> >> ---
> >>  Changelog:
> >>  v6 -> v7:
> >>   * Handle wrap of 'fwd_cnt'.
> >>   * Do to send credit update when 'fwd_cnt' == 'last_fwd_cnt'.
> >>
> >>  net/vmw_vsock/virtio_transport_common.c | 18 +++++++++++++++---
> >>  1 file changed, 15 insertions(+), 3 deletions(-)
> >>
> >> diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
> >> index e137d740804e..39f8660d825d 100644
> >> --- a/net/vmw_vsock/virtio_transport_common.c
> >> +++ b/net/vmw_vsock/virtio_transport_common.c
> >> @@ -558,6 +558,8 @@ virtio_transport_stream_do_dequeue(struct vsock_sock *vsk,
> >>  	struct virtio_vsock_sock *vvs = vsk->trans;
> >>  	size_t bytes, total = 0;
> >>  	struct sk_buff *skb;
> >> +	u32 fwd_cnt_delta;
> >> +	bool low_rx_bytes;
> >>  	int err = -EFAULT;
> >>  	u32 free_space;
> >>  
> >> @@ -601,7 +603,15 @@ virtio_transport_stream_do_dequeue(struct vsock_sock *vsk,
> >>  		}
> >>  	}
> >>  
> >> -	free_space = vvs->buf_alloc - (vvs->fwd_cnt - vvs->last_fwd_cnt);
> >> +	/* Handle wrap of 'fwd_cnt'. */
> >> +	if (vvs->fwd_cnt < vvs->last_fwd_cnt)
> >> +		fwd_cnt_delta = vvs->fwd_cnt + (U32_MAX - vvs->last_fwd_cnt);
> > 
> > Are you sure there's no off by one here? for example if fwd_cnt is 0
> > and last_fwd_cnt is 0xfffffffff then apparently delta is 0.
> 
> Seems yes, I need +1 here

And then you will get a nop, because assigning U32_MAX + 1 to u32
gives you 0. Adding () does nothing to change the result,
+ and - are commutative.


> > 
> > 
> >> +	else
> >> +		fwd_cnt_delta = vvs->fwd_cnt - vvs->last_fwd_cnt;
> > 
> > I actually don't see what is wrong with just
> > 	fwd_cnt_delta = vvs->fwd_cnt - vvs->last_fwd_cnt
> > 32 bit unsigned math will I think handle wrap around correctly.
> > 
> > And given buf_alloc is also u32 - I don't see where the bug is in
> > the original code.
> 
> I think problem is when fwd_cnt wraps, while last_fwd_cnt is not. In this
> case fwd_cnt_delta will be too big, so we won't send credit update which
> leads to stall for sender
> 
> Thanks, Arseniy

Care coming up with an example?


> > 
> > 
> >> +
> >> +	free_space = vvs->buf_alloc - fwd_cnt_delta;
> >> +	low_rx_bytes = (vvs->rx_bytes <
> >> +			sock_rcvlowat(sk_vsock(vsk), 0, INT_MAX));
> >>  
> >>  	spin_unlock_bh(&vvs->rx_lock);
> >>  
> >> @@ -611,9 +621,11 @@ virtio_transport_stream_do_dequeue(struct vsock_sock *vsk,
> >>  	 * too high causes extra messages. Too low causes transmitter
> >>  	 * stalls. As stalls are in theory more expensive than extra
> >>  	 * messages, we set the limit to a high value. TODO: experiment
> >> -	 * with different values.
> >> +	 * with different values. Also send credit update message when
> >> +	 * number of bytes in rx queue is not enough to wake up reader.
> >>  	 */
> >> -	if (free_space < VIRTIO_VSOCK_MAX_PKT_BUF_SIZE)
> >> +	if (fwd_cnt_delta &&
> >> +	    (free_space < VIRTIO_VSOCK_MAX_PKT_BUF_SIZE || low_rx_bytes))
> >>  		virtio_transport_send_credit_update(vsk);
> >>  
> >>  	return total;
> >> -- 
> >> 2.25.1
> > 

