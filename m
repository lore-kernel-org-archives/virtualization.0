Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53C8F5788E
	for <virtualization@lists.linux-foundation.org>; Tue, 12 Dec 2023 08:57:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="P2wjb/y5"
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id BF5C641621
	for <virtualization@lists.linux-foundation.org>; Tue, 12 Dec 2023 08:57:04 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org BF5C641621
Authentication-Results: smtp4.osuosl.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=P2wjb/y5
X-Virus-Scanned: amavisd-new at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.099
X-Spam-Level:
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id reROL-9Ju9mv
	for <virtualization@lists.linux-foundation.org>;
	Tue, 12 Dec 2023 08:57:04 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by smtp4.osuosl.org (Postfix) with ESMTPS id EC6574163E
	for <virtualization@lists.linux-foundation.org>; Tue, 12 Dec 2023 08:57:03 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org EC6574163E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1702371422;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+DYsFoZHtER6WKTlmJtvh956H3bsUBDuNP4h+dQhswI=;
	b=P2wjb/y5ymsI+/pOG/8sBHAS2dN3s4wq+0OEOZ7jAtNV/ydX75CUQw3HvC70AkpqxdlIOU
	hC+TL6KXSwFxp0Ab+Pswkkph+H5BA9zqyoILqzZwWVoKuDtEqVVVv7/ojhxIZ1R9nDh7xm
	iSWcTkrVwTaD+pOyzz4LB/Gh9Jdh4nE=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-428-4S6BCmNkNuGqmVJv-8EDwQ-1; Tue, 12 Dec 2023 03:57:01 -0500
X-MC-Unique: 4S6BCmNkNuGqmVJv-8EDwQ-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-40c412c62d8so19491745e9.2
        for <virtualization@lists.linux-foundation.org>; Tue, 12 Dec 2023 00:57:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702371420; x=1702976220;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+DYsFoZHtER6WKTlmJtvh956H3bsUBDuNP4h+dQhswI=;
        b=UjyU+RavVrZMiqOvcR3yIBIZPehMbgcEBJenuGJLnHqCBcqG76vdDZjKqLvBTmrgmC
         +AJF5v31wedLS6d8RaRu5VHt+seYsBKEtKd/pXCqQ2sKYlFHwnNhak+AXBJ59XmzjwX2
         0v4fSawEgnfCnGz2QnPEJxwuU/WC/j6dH37GolAY8ToK63FXGw6L5XcVLYVTG8lAvv7S
         7rE0weM5pNI2muVYShppGVdFSI6gCUL04nmCjZroVCnXt04XKhWe4g1ohozG4v+4VvK8
         E2gpYjvBClgG+XuKuk0X4Jie3v8nrEoSqtuLGHg6n1oCrc1AUyRrFrfMFmzOAkLTDQG9
         aXuQ==
X-Gm-Message-State: AOJu0YxJNqzqMmBQIhdUnF6HFygnL0nDVajuG5ixyoYO40lLuKWsY234
	DffQFOVZ4HnDvQTy+1L+bfd3qvaTDaAQnbYKdvjlI2J4jplZ1w9tN7pgAzOfEseELDfKq6olOX5
	4+r3rXnFOpptQYFHW7iaGkSll9u2tEAXPXmR7G7sjaQ==
X-Received: by 2002:a05:600c:3b26:b0:40c:224a:4450 with SMTP id m38-20020a05600c3b2600b0040c224a4450mr3229521wms.37.1702371420266;
        Tue, 12 Dec 2023 00:57:00 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEIvN7jWx6yzro4Qv1kFQ+dgRjl2IrdvJ4STo7PXBwwt5ZmQf8etAfWpYSWHF1NH+upAURrYw==
X-Received: by 2002:a05:600c:3b26:b0:40c:224a:4450 with SMTP id m38-20020a05600c3b2600b0040c224a4450mr3229507wms.37.1702371419828;
        Tue, 12 Dec 2023 00:56:59 -0800 (PST)
Received: from sgarzare-redhat ([193.207.128.35])
        by smtp.gmail.com with ESMTPSA id d13-20020a05600c34cd00b0040c496c64cfsm5430442wmq.12.2023.12.12.00.56.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Dec 2023 00:56:59 -0800 (PST)
Date: Tue, 12 Dec 2023 09:56:45 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Arseniy Krasnov <avkrasnov@salutedevices.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	"Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
	Bobby Eshleman <bobby.eshleman@bytedance.com>, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, kernel@sberdevices.ru, 
	oxffffaa@gmail.com
Subject: Re: [PATCH net-next v8 3/4] virtio/vsock: fix logic which reduces
 credit update messages
Message-ID: <5wewycputeafvvgehioon3j75hlwxeliyni6nt4qtw3ch5rlt4@o7yncdbcyoc4>
References: <20231211211658.2904268-1-avkrasnov@salutedevices.com>
 <20231211211658.2904268-4-avkrasnov@salutedevices.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20231211211658.2904268-4-avkrasnov@salutedevices.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

On Tue, Dec 12, 2023 at 12:16:57AM +0300, Arseniy Krasnov wrote:
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
> Changelog:
> v6 -> v7:
>  * Handle wrap of 'fwd_cnt'.
>  * Do to send credit update when 'fwd_cnt' == 'last_fwd_cnt'.
> v7 -> v8:
>  * Remove unneeded/wrong handling of wrap for 'fwd_cnt'.
>
> net/vmw_vsock/virtio_transport_common.c | 13 ++++++++++---
> 1 file changed, 10 insertions(+), 3 deletions(-)

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

Thanks!
Stefano

>
>diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
>index e137d740804e..8572f94bba88 100644
>--- a/net/vmw_vsock/virtio_transport_common.c
>+++ b/net/vmw_vsock/virtio_transport_common.c
>@@ -558,6 +558,8 @@ virtio_transport_stream_do_dequeue(struct vsock_sock *vsk,
> 	struct virtio_vsock_sock *vvs = vsk->trans;
> 	size_t bytes, total = 0;
> 	struct sk_buff *skb;
>+	u32 fwd_cnt_delta;
>+	bool low_rx_bytes;
> 	int err = -EFAULT;
> 	u32 free_space;
>
>@@ -601,7 +603,10 @@ virtio_transport_stream_do_dequeue(struct vsock_sock *vsk,
> 		}
> 	}
>
>-	free_space = vvs->buf_alloc - (vvs->fwd_cnt - vvs->last_fwd_cnt);
>+	fwd_cnt_delta = vvs->fwd_cnt - vvs->last_fwd_cnt;
>+	free_space = vvs->buf_alloc - fwd_cnt_delta;
>+	low_rx_bytes = (vvs->rx_bytes <
>+			sock_rcvlowat(sk_vsock(vsk), 0, INT_MAX));
>
> 	spin_unlock_bh(&vvs->rx_lock);
>
>@@ -611,9 +616,11 @@ virtio_transport_stream_do_dequeue(struct vsock_sock *vsk,
> 	 * too high causes extra messages. Too low causes transmitter
> 	 * stalls. As stalls are in theory more expensive than extra
> 	 * messages, we set the limit to a high value. TODO: experiment
>-	 * with different values.
>+	 * with different values. Also send credit update message when
>+	 * number of bytes in rx queue is not enough to wake up reader.
> 	 */
>-	if (free_space < VIRTIO_VSOCK_MAX_PKT_BUF_SIZE)
>+	if (fwd_cnt_delta &&
>+	    (free_space < VIRTIO_VSOCK_MAX_PKT_BUF_SIZE || low_rx_bytes))
> 		virtio_transport_send_credit_update(vsk);
>
> 	return total;
>-- 
>2.25.1
>

