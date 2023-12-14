Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2D5B3BB33
	for <virtualization@lists.linux-foundation.org>; Thu, 14 Dec 2023 10:24:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ijj2xQtW"
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 5BDA783CD1
	for <virtualization@lists.linux-foundation.org>; Thu, 14 Dec 2023 10:24:50 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 5BDA783CD1
Authentication-Results: smtp1.osuosl.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=ijj2xQtW
X-Virus-Scanned: amavisd-new at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.099
X-Spam-Level:
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id mBa8IUuFz0Ug
	for <virtualization@lists.linux-foundation.org>;
	Thu, 14 Dec 2023 10:24:49 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 693118177C
	for <virtualization@lists.linux-foundation.org>; Thu, 14 Dec 2023 10:24:49 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 693118177C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1702549488;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=DSSH8LtzM2s/nHi8p5P1p50CtgKbNQDA/Xelk2DiA14=;
	b=ijj2xQtW7klWiHpC6Jyf3UNxDJ4Sy1cUiY+fyHG/gVFPdD7IpKRUvHCxuGc4vjgOKKvd99
	Ed9n0xcKPFzygb67uhIPjZYWXbmZ+GtPpJtccw1kpt5Vs8XDW054J9InhOqUp5oIb6nX64
	PmgWevn2VnePlFQtGGEhTDF8aoqCA9s=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-320-wsXbYdRANEulfrbAjctMwQ-1; Thu, 14 Dec 2023 05:24:46 -0500
X-MC-Unique: wsXbYdRANEulfrbAjctMwQ-1
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-a018014e8e5so439516566b.2
        for <virtualization@lists.linux-foundation.org>; Thu, 14 Dec 2023 02:24:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702549485; x=1703154285;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DSSH8LtzM2s/nHi8p5P1p50CtgKbNQDA/Xelk2DiA14=;
        b=OCOQxODwz7gpWffqHRhNxih0v0my4A74EmT09srrTxg4azYKkB+lDN4cjr69ndXlpx
         qUT7+dm64oQ5S3yL3xKqRtMnMnqq2y+enNhTmBJAWN2iy1p57Vp5EKgfLgaNd9eCYitP
         0c7WyPBvWqT3NAXCiTnfLMiZnwKwuRH+0PsNLYH5wIii3SBxOLAcbr0GFr2YPk6wvX4J
         uJDzi60LL/LAoaAMEgML+1gKgIAa88DGvJov8GTFlVMJ+Fjgagig10F3nL/3cmdeaJx7
         PB7ufyKJEUZL7Fgt38gK02JP85UHaSA3IlFHm2yCO0w0XNrAdGfJJGqOewXNh6qOhSya
         tMyw==
X-Gm-Message-State: AOJu0Yz9DbPSRdEIa2ydX3HwwV/y7OT4Yhprhu3mW+TTQBIKN69ir+TB
	2V8RwDtrBxXuOXmmmJwlLNNGsrTmIXfRwvG4GgjMcZ7IvMrKvB+76DlFe8ImOMJCbrkQ2lNQ2Cv
	FqXvdgSO2o0CO/zrXLbV/4PfHYmHl7XAmrA/dV8QisQ==
X-Received: by 2002:a17:907:3a97:b0:a1f:7352:3c0 with SMTP id fh23-20020a1709073a9700b00a1f735203c0mr4111137ejc.59.1702549485729;
        Thu, 14 Dec 2023 02:24:45 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFJ4mtbeRMe02kWwF6Hh+xBcu1mR/wHuPokTQ+4Rni40u2pBzA16VxW6ly8OowEf1SbmDDVig==
X-Received: by 2002:a17:907:3a97:b0:a1f:7352:3c0 with SMTP id fh23-20020a1709073a9700b00a1f735203c0mr4111122ejc.59.1702549485320;
        Thu, 14 Dec 2023 02:24:45 -0800 (PST)
Received: from redhat.com ([2.52.132.243])
        by smtp.gmail.com with ESMTPSA id vv6-20020a170907a68600b00a1dff479037sm9103575ejc.127.2023.12.14.02.24.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Dec 2023 02:24:44 -0800 (PST)
Date: Thu, 14 Dec 2023 05:24:40 -0500
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
Subject: Re: [PATCH net-next v9 2/4] virtio/vsock: send credit update during
 setting SO_RCVLOWAT
Message-ID: <20231214052234-mutt-send-email-mst@kernel.org>
References: <20231214091947.395892-1-avkrasnov@salutedevices.com>
 <20231214091947.395892-3-avkrasnov@salutedevices.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20231214091947.395892-3-avkrasnov@salutedevices.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Dec 14, 2023 at 12:19:45PM +0300, Arseniy Krasnov wrote:
> Send credit update message when SO_RCVLOWAT is updated and it is bigger
> than number of bytes in rx queue. It is needed, because 'poll()' will
> wait until number of bytes in rx queue will be not smaller than
> SO_RCVLOWAT, so kick sender to send more data. Otherwise mutual hungup
> for tx/rx is possible: sender waits for free space and receiver is
> waiting data in 'poll()'.
> 
> Fixes: b89d882dc9fc ("vsock/virtio: reduce credit update messages")
> Signed-off-by: Arseniy Krasnov <avkrasnov@salutedevices.com>
> Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
> Acked-by: Michael S. Tsirkin <mst@redhat.com>
> ---
>  Changelog:
>  v1 -> v2:
>   * Update commit message by removing 'This patch adds XXX' manner.
>   * Do not initialize 'send_update' variable - set it directly during
>     first usage.
>  v3 -> v4:
>   * Fit comment in 'virtio_transport_notify_set_rcvlowat()' to 80 chars.
>  v4 -> v5:
>   * Do not change callbacks order in transport structures.
>  v5 -> v6:
>   * Reorder callbacks in transport structures.
>   * Do to send credit update when 'fwd_cnt' == 'last_fwd_cnt'.
>  v8 -> v9:
>   * Add 'Fixes' tag.
> 
>  drivers/vhost/vsock.c                   |  1 +
>  include/linux/virtio_vsock.h            |  1 +
>  net/vmw_vsock/virtio_transport.c        |  1 +
>  net/vmw_vsock/virtio_transport_common.c | 30 +++++++++++++++++++++++++
>  net/vmw_vsock/vsock_loopback.c          |  1 +
>  5 files changed, 34 insertions(+)
> 
> diff --git a/drivers/vhost/vsock.c b/drivers/vhost/vsock.c
> index f75731396b7e..ec20ecff85c7 100644
> --- a/drivers/vhost/vsock.c
> +++ b/drivers/vhost/vsock.c
> @@ -449,6 +449,7 @@ static struct virtio_transport vhost_transport = {
>  		.notify_send_pre_enqueue  = virtio_transport_notify_send_pre_enqueue,
>  		.notify_send_post_enqueue = virtio_transport_notify_send_post_enqueue,
>  		.notify_buffer_size       = virtio_transport_notify_buffer_size,
> +		.notify_set_rcvlowat      = virtio_transport_notify_set_rcvlowat,
>  

This needs to be set_rcvlowat.

>  		.read_skb = virtio_transport_read_skb,
>  	},
> diff --git a/include/linux/virtio_vsock.h b/include/linux/virtio_vsock.h
> index ebb3ce63d64d..c82089dee0c8 100644
> --- a/include/linux/virtio_vsock.h
> +++ b/include/linux/virtio_vsock.h
> @@ -256,4 +256,5 @@ void virtio_transport_put_credit(struct virtio_vsock_sock *vvs, u32 credit);
>  void virtio_transport_deliver_tap_pkt(struct sk_buff *skb);
>  int virtio_transport_purge_skbs(void *vsk, struct sk_buff_head *list);
>  int virtio_transport_read_skb(struct vsock_sock *vsk, skb_read_actor_t read_actor);
> +int virtio_transport_notify_set_rcvlowat(struct vsock_sock *vsk, int val);
>  #endif /* _LINUX_VIRTIO_VSOCK_H */
> diff --git a/net/vmw_vsock/virtio_transport.c b/net/vmw_vsock/virtio_transport.c
> index af5bab1acee1..f495b9e5186b 100644
> --- a/net/vmw_vsock/virtio_transport.c
> +++ b/net/vmw_vsock/virtio_transport.c
> @@ -537,6 +537,7 @@ static struct virtio_transport virtio_transport = {
>  		.notify_send_pre_enqueue  = virtio_transport_notify_send_pre_enqueue,
>  		.notify_send_post_enqueue = virtio_transport_notify_send_post_enqueue,
>  		.notify_buffer_size       = virtio_transport_notify_buffer_size,
> +		.notify_set_rcvlowat      = virtio_transport_notify_set_rcvlowat,
>  
>  		.read_skb = virtio_transport_read_skb,
>  	},


This, too.

> diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
> index 7eabe5219ef7..9d2305fdc65c 100644
> --- a/net/vmw_vsock/virtio_transport_common.c
> +++ b/net/vmw_vsock/virtio_transport_common.c
> @@ -1690,6 +1690,36 @@ int virtio_transport_read_skb(struct vsock_sock *vsk, skb_read_actor_t recv_acto
>  }
>  EXPORT_SYMBOL_GPL(virtio_transport_read_skb);
>  
> +int virtio_transport_notify_set_rcvlowat(struct vsock_sock *vsk, int val)
> +{
> +	struct virtio_vsock_sock *vvs = vsk->trans;
> +	bool send_update;
> +
> +	spin_lock_bh(&vvs->rx_lock);
> +
> +	/* If number of available bytes is less than new SO_RCVLOWAT value,
> +	 * kick sender to send more data, because sender may sleep in its
> +	 * 'send()' syscall waiting for enough space at our side. Also
> +	 * don't send credit update when peer already knows actual value -
> +	 * such transmission will be useless.
> +	 */
> +	send_update = (vvs->rx_bytes < val) &&
> +		      (vvs->fwd_cnt != vvs->last_fwd_cnt);
> +
> +	spin_unlock_bh(&vvs->rx_lock);
> +
> +	if (send_update) {
> +		int err;
> +
> +		err = virtio_transport_send_credit_update(vsk);
> +		if (err < 0)
> +			return err;
> +	}
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(virtio_transport_notify_set_rcvlowat);
> +
>  MODULE_LICENSE("GPL v2");
>  MODULE_AUTHOR("Asias He");
>  MODULE_DESCRIPTION("common code for virtio vsock");

I think you need to set sk->sk_rcvlowat here, no?
Follow up patch will move it to transport independent code.


> diff --git a/net/vmw_vsock/vsock_loopback.c b/net/vmw_vsock/vsock_loopback.c
> index 048640167411..6dea6119f5b2 100644
> --- a/net/vmw_vsock/vsock_loopback.c
> +++ b/net/vmw_vsock/vsock_loopback.c
> @@ -96,6 +96,7 @@ static struct virtio_transport loopback_transport = {
>  		.notify_send_pre_enqueue  = virtio_transport_notify_send_pre_enqueue,
>  		.notify_send_post_enqueue = virtio_transport_notify_send_post_enqueue,
>  		.notify_buffer_size       = virtio_transport_notify_buffer_size,
> +		.notify_set_rcvlowat      = virtio_transport_notify_set_rcvlowat,
>  
>  		.read_skb = virtio_transport_read_skb,
>  	},
> -- 
> 2.25.1

