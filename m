Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE3AA3BB20
	for <virtualization@lists.linux-foundation.org>; Tue,  5 Dec 2023 10:54:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="f9TZZegL"
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 605DC61060
	for <virtualization@lists.linux-foundation.org>; Tue,  5 Dec 2023 10:54:51 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 605DC61060
Authentication-Results: smtp3.osuosl.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=f9TZZegL
X-Virus-Scanned: amavisd-new at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.099
X-Spam-Level:
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ruVT-1ndRvSV
	for <virtualization@lists.linux-foundation.org>;
	Tue,  5 Dec 2023 10:54:50 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 9FC2160B94
	for <virtualization@lists.linux-foundation.org>; Tue,  5 Dec 2023 10:54:50 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 9FC2160B94
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1701773689;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=KllSGKKQDmwXLtuWN3ZHoV9RXfPGuqYv1YKTnXjA8w8=;
	b=f9TZZegLG7pVchX2NAMrjRL2cM1oz7ho5Ir1vQCRheJqL503zBnCNwKL97y3U11q5jucIq
	OctMV7tulnK8d5pLo/+BpClBXX14l/aBO2R/KJoKiibkragdGA6sW7uQNKKrRDqruBY0+I
	ca6UEa0t1/XmVxSOHgcAe+60RnQAx3k=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-596-NuQFBJlRMUa8lVKQGd0WWg-1; Tue, 05 Dec 2023 05:54:45 -0500
X-MC-Unique: NuQFBJlRMUa8lVKQGd0WWg-1
Received: by mail-lj1-f198.google.com with SMTP id 38308e7fff4ca-2ca0fbea7efso8599431fa.2
        for <virtualization@lists.linux-foundation.org>; Tue, 05 Dec 2023 02:54:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701773684; x=1702378484;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KllSGKKQDmwXLtuWN3ZHoV9RXfPGuqYv1YKTnXjA8w8=;
        b=P9eK2w22JV9sKf4WqVuw0w67cWnxnmaVlbBNu+Bw8Vba0fD/hK77NPKe/A4svMSJcg
         mN9fKjA8aBIu6HWHI4/2InXEWo1vHBdseoorhJaTDGjhFqFM37n5HHrC04xStdplPUyT
         qkB32h56XJRVmygGHw0TvdRih4ZZ0Pepdp1MV7PQDBdTGkVbofUIsc+4SUzEnOeLj29C
         r2JijSvWPeRJGCerdQfeIjEhVcLFgTzksapuLTSAPnwO5AYitcHB/Uv734qdhPGpelQc
         p4ZxfnMUJbnC5Cd+E9HroGwFDbewVg5qLKhQwaVas0hvM9oQrX17tH+sRK/rXj4zUPkz
         92OA==
X-Gm-Message-State: AOJu0Ywc/jjYFZP2uLTVJlQ5bxTIIdxAEw9mkNFsmYLT1bsli10GlQck
	lE+yNfImaXnU+ON4JTCWVDT+Ql5WyInyxobM5QvqsnP/mPpnJ0gahJWIrbgSvPy2Y8iWH1SuEC2
	bal8cTMvfbmi8MUxjWeZot05UmfbHRO2fB9rNaYrnWA==
X-Received: by 2002:a2e:8488:0:b0:2ca:b91:6e0f with SMTP id b8-20020a2e8488000000b002ca0b916e0fmr1176644ljh.100.1701773683923;
        Tue, 05 Dec 2023 02:54:43 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG1uczRGKwr7AEuhaoO8GRb1dLh2uTnNgWHFUpQaDfB0N2+1jhIW7CG1zbJ7bYnPIhI2iFz2w==
X-Received: by 2002:a2e:8488:0:b0:2ca:b91:6e0f with SMTP id b8-20020a2e8488000000b002ca0b916e0fmr1176626ljh.100.1701773683580;
        Tue, 05 Dec 2023 02:54:43 -0800 (PST)
Received: from sgarzare-redhat (host-79-46-200-125.retail.telecomitalia.it. [79.46.200.125])
        by smtp.gmail.com with ESMTPSA id uz14-20020a170907118e00b00a0a2cb33ee0sm6450734ejb.203.2023.12.05.02.54.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Dec 2023 02:54:42 -0800 (PST)
Date: Tue, 5 Dec 2023 11:54:37 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Arseniy Krasnov <avkrasnov@salutedevices.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	"Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
	Bobby Eshleman <bobby.eshleman@bytedance.com>, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, kernel@sberdevices.ru, 
	oxffffaa@gmail.com
Subject: Re: [PATCH net-next v6 3/4] virtio/vsock: fix logic which reduces
 credit update messages
Message-ID: <v335g4fjrn5f6tsw4nysztaklze2obnjwpezps3jgb2xickpge@ea5woxob52nc>
References: <20231205064806.2851305-1-avkrasnov@salutedevices.com>
 <20231205064806.2851305-4-avkrasnov@salutedevices.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20231205064806.2851305-4-avkrasnov@salutedevices.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

On Tue, Dec 05, 2023 at 09:48:05AM +0300, Arseniy Krasnov wrote:
>Add one more condition for sending credit update during dequeue from
>stream socket: when number of bytes in the rx queue is smaller than
>SO_RCVLOWAT value of the socket. This is actual for non-default value
>of SO_RCVLOWAT (e.g. not 1) - idea is to "kick" peer to continue data
>transmission, because we need at least SO_RCVLOWAT bytes in our rx
>queue to wake up user for reading data (in corner case it is also
>possible to stuck both tx and rx sides, this is why 'Fixes' is used).
>
>Fixes: b89d882dc9fc ("vsock/virtio: reduce credit update messages")
>Signed-off-by: Arseniy Krasnov <avkrasnov@salutedevices.com>
>---
> net/vmw_vsock/virtio_transport_common.c | 9 +++++++--
> 1 file changed, 7 insertions(+), 2 deletions(-)
>
>diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
>index e137d740804e..461c89882142 100644
>--- a/net/vmw_vsock/virtio_transport_common.c
>+++ b/net/vmw_vsock/virtio_transport_common.c
>@@ -558,6 +558,7 @@ virtio_transport_stream_do_dequeue(struct vsock_sock *vsk,
> 	struct virtio_vsock_sock *vvs = vsk->trans;
> 	size_t bytes, total = 0;
> 	struct sk_buff *skb;
>+	bool low_rx_bytes;
> 	int err = -EFAULT;
> 	u32 free_space;
>
>@@ -602,6 +603,8 @@ virtio_transport_stream_do_dequeue(struct vsock_sock *vsk,
> 	}
>
> 	free_space = vvs->buf_alloc - (vvs->fwd_cnt - vvs->last_fwd_cnt);
>+	low_rx_bytes = (vvs->rx_bytes <
>+			sock_rcvlowat(sk_vsock(vsk), 0, INT_MAX));

As in the previous patch, should we avoid the update it if `fwd_cnt` and 
`last_fwd_cnt` are the same?

Now I'm thinking if it is better to add that check directly in 
virtio_transport_send_credit_update().

Stefano

>
> 	spin_unlock_bh(&vvs->rx_lock);
>
>@@ -611,9 +614,11 @@ virtio_transport_stream_do_dequeue(struct vsock_sock *vsk,
> 	 * too high causes extra messages. Too low causes transmitter
> 	 * stalls. As stalls are in theory more expensive than extra
> 	 * messages, we set the limit to a high value. TODO: experiment
>-	 * with different values.
>+	 * with different values. Also send credit update message when
>+	 * number of bytes in rx queue is not enough to wake up reader.
> 	 */
>-	if (free_space < VIRTIO_VSOCK_MAX_PKT_BUF_SIZE)
>+	if (free_space < VIRTIO_VSOCK_MAX_PKT_BUF_SIZE ||
>+	    low_rx_bytes)
> 		virtio_transport_send_credit_update(vsk);
>
> 	return total;
>-- 
>2.25.1
>

