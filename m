Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93051482F9
	for <virtualization@lists.linux-foundation.org>; Thu, 30 Nov 2023 13:59:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gtAUgSX6"
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 2285C84572
	for <virtualization@lists.linux-foundation.org>; Thu, 30 Nov 2023 13:59:09 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 2285C84572
Authentication-Results: smtp1.osuosl.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=gtAUgSX6
X-Virus-Scanned: amavisd-new at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.099
X-Spam-Level:
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id BSy4EM8YxrJ0
	for <virtualization@lists.linux-foundation.org>;
	Thu, 30 Nov 2023 13:59:08 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 127C08456E
	for <virtualization@lists.linux-foundation.org>; Thu, 30 Nov 2023 13:59:07 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 127C08456E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1701352746;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/uda2OoXWZFrWrKrJB2e3oA9p9YZZZPgmKwHuRaVzhs=;
	b=gtAUgSX6JKQXeq4V5WteYMjm22zLBBejsPr2SUcGOnc6aEM4s0VA+OCrnIv6Kye2PO4AXi
	7WXaz6k4OrwkRBVFZVzt2ywB8Om0Q268ZLmPgn0kfJqR/DRvHeP8Hofs3VIa/yKkb96N/W
	zHkwg79O7LjaHPSCpwUpxv711YEdts0=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-375-Tjoiqqa4MtGF8ygO2efN_w-1; Thu, 30 Nov 2023 08:59:04 -0500
X-MC-Unique: Tjoiqqa4MtGF8ygO2efN_w-1
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-3331258269fso1010712f8f.1
        for <virtualization@lists.linux-foundation.org>; Thu, 30 Nov 2023 05:59:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701352743; x=1701957543;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/uda2OoXWZFrWrKrJB2e3oA9p9YZZZPgmKwHuRaVzhs=;
        b=JA6yTfKylqrygiGLWaTp6WWU+oRctaSDGi8tZNDDTbrvTh12WWcHqkiMirhaCif5u7
         L9tNafqBpwPwJsSiGIEcWjOvjJ+75P29leHVZfa2+1eXKviwGzstBoaA2WcTChu+NlQ7
         py91WIQzlS09vDWg3amGhjb7zV8VsR8In6u/jeK/LNY8cT3eRZHZOKlXzEXKcpzDSiBz
         w5w2W1U06tiz4QdianLHJQAr3y0ar2KCk1o7jTe5JrBjzayW3v+bXsIZeBUpY+gnZqQG
         wk/2788G5LwUYYYlbMpHz+x6v3FisCuuMOwgbKEYwKACZx/zyrKdsN6K61sfA+h66Sf9
         YQSA==
X-Gm-Message-State: AOJu0Yxw5iZbYzfLQ7OEq4q2UpxXa776P8ElPQw50fO0jGA9EDvEV1jf
	yyH19O+SHIS/ddZahc+zGnw5rCQR58xc/zMiptFKA8dds2Qhm9AGX0P9o42Kgp+KANIsYTJg6zT
	4whS+zXoRctwdfUo81V/r43tfMj4zJ1jhRcHERzfGdQ==
X-Received: by 2002:adf:ec83:0:b0:332:ef1e:bb99 with SMTP id z3-20020adfec83000000b00332ef1ebb99mr13949221wrn.26.1701352743405;
        Thu, 30 Nov 2023 05:59:03 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFH4PpTRoBpdxxMudyT8DYADIaNEbwtS9Mz//7m0f6heYFXMJsx86J63u6mQnwoWb4XVKTMIg==
X-Received: by 2002:adf:ec83:0:b0:332:ef1e:bb99 with SMTP id z3-20020adfec83000000b00332ef1ebb99mr13949197wrn.26.1701352743025;
        Thu, 30 Nov 2023 05:59:03 -0800 (PST)
Received: from redhat.com ([2.55.10.128])
        by smtp.gmail.com with ESMTPSA id m10-20020a5d6a0a000000b00332eb96cb73sm1629406wru.73.2023.11.30.05.59.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Nov 2023 05:59:02 -0800 (PST)
Date: Thu, 30 Nov 2023 08:58:58 -0500
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
Subject: Re: [PATCH net-next v5 2/3] virtio/vsock: send credit update during
 setting SO_RCVLOWAT
Message-ID: <20231130085445-mutt-send-email-mst@kernel.org>
References: <20231130130840.253733-1-avkrasnov@salutedevices.com>
 <20231130130840.253733-3-avkrasnov@salutedevices.com>
 <20231130084044-mutt-send-email-mst@kernel.org>
 <02de8982-ec4a-b3b2-e8e5-1bca28cfc01b@salutedevices.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <02de8982-ec4a-b3b2-e8e5-1bca28cfc01b@salutedevices.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Nov 30, 2023 at 04:43:34PM +0300, Arseniy Krasnov wrote:
> 
> 
> On 30.11.2023 16:42, Michael S. Tsirkin wrote:
> > On Thu, Nov 30, 2023 at 04:08:39PM +0300, Arseniy Krasnov wrote:
> >> Send credit update message when SO_RCVLOWAT is updated and it is bigger
> >> than number of bytes in rx queue. It is needed, because 'poll()' will
> >> wait until number of bytes in rx queue will be not smaller than
> >> SO_RCVLOWAT, so kick sender to send more data. Otherwise mutual hungup
> >> for tx/rx is possible: sender waits for free space and receiver is
> >> waiting data in 'poll()'.
> >>
> >> Signed-off-by: Arseniy Krasnov <avkrasnov@salutedevices.com>
> >> ---
> >>  Changelog:
> >>  v1 -> v2:
> >>   * Update commit message by removing 'This patch adds XXX' manner.
> >>   * Do not initialize 'send_update' variable - set it directly during
> >>     first usage.
> >>  v3 -> v4:
> >>   * Fit comment in 'virtio_transport_notify_set_rcvlowat()' to 80 chars.
> >>  v4 -> v5:
> >>   * Do not change callbacks order in transport structures.
> >>
> >>  drivers/vhost/vsock.c                   |  1 +
> >>  include/linux/virtio_vsock.h            |  1 +
> >>  net/vmw_vsock/virtio_transport.c        |  1 +
> >>  net/vmw_vsock/virtio_transport_common.c | 27 +++++++++++++++++++++++++
> >>  net/vmw_vsock/vsock_loopback.c          |  1 +
> >>  5 files changed, 31 insertions(+)
> >>
> >> diff --git a/drivers/vhost/vsock.c b/drivers/vhost/vsock.c
> >> index f75731396b7e..4146f80db8ac 100644
> >> --- a/drivers/vhost/vsock.c
> >> +++ b/drivers/vhost/vsock.c
> >> @@ -451,6 +451,7 @@ static struct virtio_transport vhost_transport = {
> >>  		.notify_buffer_size       = virtio_transport_notify_buffer_size,
> >>  
> >>  		.read_skb = virtio_transport_read_skb,
> >> +		.notify_set_rcvlowat      = virtio_transport_notify_set_rcvlowat
> >>  	},
> >>  
> >>  	.send_pkt = vhost_transport_send_pkt,
> >> diff --git a/include/linux/virtio_vsock.h b/include/linux/virtio_vsock.h
> >> index ebb3ce63d64d..c82089dee0c8 100644
> >> --- a/include/linux/virtio_vsock.h
> >> +++ b/include/linux/virtio_vsock.h
> >> @@ -256,4 +256,5 @@ void virtio_transport_put_credit(struct virtio_vsock_sock *vvs, u32 credit);
> >>  void virtio_transport_deliver_tap_pkt(struct sk_buff *skb);
> >>  int virtio_transport_purge_skbs(void *vsk, struct sk_buff_head *list);
> >>  int virtio_transport_read_skb(struct vsock_sock *vsk, skb_read_actor_t read_actor);
> >> +int virtio_transport_notify_set_rcvlowat(struct vsock_sock *vsk, int val);
> >>  #endif /* _LINUX_VIRTIO_VSOCK_H */
> >> diff --git a/net/vmw_vsock/virtio_transport.c b/net/vmw_vsock/virtio_transport.c
> >> index af5bab1acee1..8007593a3a93 100644
> >> --- a/net/vmw_vsock/virtio_transport.c
> >> +++ b/net/vmw_vsock/virtio_transport.c
> >> @@ -539,6 +539,7 @@ static struct virtio_transport virtio_transport = {
> >>  		.notify_buffer_size       = virtio_transport_notify_buffer_size,
> >>  
> >>  		.read_skb = virtio_transport_read_skb,
> >> +		.notify_set_rcvlowat      = virtio_transport_notify_set_rcvlowat
> >>  	},
> >>  
> >>  	.send_pkt = virtio_transport_send_pkt,
> >> diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
> >> index f6dc896bf44c..1cb556ad4597 100644
> >> --- a/net/vmw_vsock/virtio_transport_common.c
> >> +++ b/net/vmw_vsock/virtio_transport_common.c
> >> @@ -1684,6 +1684,33 @@ int virtio_transport_read_skb(struct vsock_sock *vsk, skb_read_actor_t recv_acto
> >>  }
> >>  EXPORT_SYMBOL_GPL(virtio_transport_read_skb);
> >>  
> >> +int virtio_transport_notify_set_rcvlowat(struct vsock_sock *vsk, int val)
> >> +{
> >> +	struct virtio_vsock_sock *vvs = vsk->trans;
> >> +	bool send_update;
> >> +
> >> +	spin_lock_bh(&vvs->rx_lock);
> >> +
> >> +	/* If number of available bytes is less than new SO_RCVLOWAT value,
> >> +	 * kick sender to send more data, because sender may sleep in its
> >> +	 * 'send()' syscall waiting for enough space at our side.
> >> +	 */
> >> +	send_update = vvs->rx_bytes < val;
> >> +
> >> +	spin_unlock_bh(&vvs->rx_lock);
> >> +
> >> +	if (send_update) {
> >> +		int err;
> >> +
> >> +		err = virtio_transport_send_credit_update(vsk);
> >> +		if (err < 0)
> >> +			return err;
> >> +	}
> >> +
> >> +	return 0;
> >> +}
> > 
> > 
> > I find it strange that this will send a credit update
> > even if nothing changed since this was called previously.
> > I'm not sure whether this is a problem protocol-wise,
> > but it certainly was not envisioned when the protocol was
> > built. WDYT?
> 
> >From virtio spec I found:
> 
> It is also valid to send a VIRTIO_VSOCK_OP_CREDIT_UPDATE packet without previously receiving a
> VIRTIO_VSOCK_OP_CREDIT_REQUEST packet. This allows communicating updates any time a change
> in buffer space occurs.
> So I guess there is no limitations to send such type of packet, e.g. it is not
> required to be a reply for some another packet. Please, correct me if im wrong.
> 
> Thanks, Arseniy


Absolutely. My point was different - with this patch it is possible
that you are not adding any credits at all since the previous
VIRTIO_VSOCK_OP_CREDIT_UPDATE.

> 
> > 
> > 
> >> +EXPORT_SYMBOL_GPL(virtio_transport_notify_set_rcvlowat);
> >> +
> >>  MODULE_LICENSE("GPL v2");
> >>  MODULE_AUTHOR("Asias He");
> >>  MODULE_DESCRIPTION("common code for virtio vsock");
> >> diff --git a/net/vmw_vsock/vsock_loopback.c b/net/vmw_vsock/vsock_loopback.c
> >> index 048640167411..9f4b814fbbc7 100644
> >> --- a/net/vmw_vsock/vsock_loopback.c
> >> +++ b/net/vmw_vsock/vsock_loopback.c
> >> @@ -98,6 +98,7 @@ static struct virtio_transport loopback_transport = {
> >>  		.notify_buffer_size       = virtio_transport_notify_buffer_size,
> >>  
> >>  		.read_skb = virtio_transport_read_skb,
> >> +		.notify_set_rcvlowat      = virtio_transport_notify_set_rcvlowat
> >>  	},
> >>  
> >>  	.send_pkt = vsock_loopback_send_pkt,
> >> -- 
> >> 2.25.1
> > 

