Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0E7748CFF
	for <virtualization@lists.linux-foundation.org>; Thu, 30 Nov 2023 14:11:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CXD7Fv6J"
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 53AE66F722
	for <virtualization@lists.linux-foundation.org>; Thu, 30 Nov 2023 14:11:32 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 53AE66F722
Authentication-Results: smtp3.osuosl.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=CXD7Fv6J
X-Virus-Scanned: amavisd-new at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -0.599
X-Spam-Level:
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id UWaS7wfbVOhF
	for <virtualization@lists.linux-foundation.org>;
	Thu, 30 Nov 2023 14:11:31 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 7BFED60EED
	for <virtualization@lists.linux-foundation.org>; Thu, 30 Nov 2023 14:11:31 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 7BFED60EED
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1701353490;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0JHFyrzFFSVseEAuy8d9d1o1TV5uCDqg9dQOvXKmVYk=;
	b=CXD7Fv6J/QgnNOCWUDQPlI/xWrvwjFEbIICPUH/mN5MLWIB8TmYl4qqdA1hna/OSB/K/Qy
	RHZc1miTRfar51yP796L1IzmM96QtslydJ1aUcy6f/0sE3nHoNDqFjuaD9grhy/7damA6e
	XF3dUxodtNEjCoMayXtLTuSOknw9/4I=
Received: from mail-ot1-f72.google.com (mail-ot1-f72.google.com
 [209.85.210.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-619-9GJOPTVVO3Sfw5YQB8hi-w-1; Thu, 30 Nov 2023 09:11:28 -0500
X-MC-Unique: 9GJOPTVVO3Sfw5YQB8hi-w-1
Received: by mail-ot1-f72.google.com with SMTP id 46e09a7af769-6d853a19e1fso1030657a34.1
        for <virtualization@lists.linux-foundation.org>; Thu, 30 Nov 2023 06:11:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701353488; x=1701958288;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0JHFyrzFFSVseEAuy8d9d1o1TV5uCDqg9dQOvXKmVYk=;
        b=AgozGcnIr4w1KRak1oY0Z31T5zgVuY3r02l9KdpSR3uXMVLTL99GAT6b9Pb7MIYXrc
         55T6klKnWPy7I4jT3pUF9AqlWLF9SMUiJHA4qOuTeDE46/vsuQqV1rhBq3hDSyb3HopR
         CYUcWF/30tbaj9GoAgbYNQEkdWYniWsRpCgUjIZz+V2vF/iQM/1o2tzs2gmlIArrKKDT
         iFazM65busse/RiRS8+io3ozXCiFpKd02wEXU2SW03DQJXMP9Tnu1GcwoV9eJkH19L0m
         1lbkuI2WCDqkHP2q0SXNZXFFwUCp/U4duXumIJPnXFYsix+cDRXuEkyPMFfbjMwCaM0c
         1iuw==
X-Gm-Message-State: AOJu0Yzi7Jueeq9nuYHTNfcoErlbjGWWVDgm/rOAe25y34/gyawLEtZ6
	fBtGS77RzmCKImHANLLeutn0hJvcKN/0wr7U3KybKTMy9LuHWqSkDXZmqeo2JwaeBIhshCNWEY/
	CQc+o21ttmBZZO/PEE9gAm3iTgwRmuOcgoxaQZwQaZg==
X-Received: by 2002:a05:6830:4181:b0:6d8:55d5:f13e with SMTP id r1-20020a056830418100b006d855d5f13emr5269603otu.33.1701353487817;
        Thu, 30 Nov 2023 06:11:27 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHXDFX1KaLB1lzyO/Yep+9vBMw9UWIDs7s+W+eej29V7OLIhsFM68x1mC9y+nS/Grcj83DJyA==
X-Received: by 2002:a05:6830:4181:b0:6d8:55d5:f13e with SMTP id r1-20020a056830418100b006d855d5f13emr5269552otu.33.1701353487498;
        Thu, 30 Nov 2023 06:11:27 -0800 (PST)
Received: from sgarzare-redhat (host-79-46-200-199.retail.telecomitalia.it. [79.46.200.199])
        by smtp.gmail.com with ESMTPSA id m6-20020a0cac46000000b0067a27108513sm530315qvb.67.2023.11.30.06.11.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Nov 2023 06:11:27 -0800 (PST)
Date: Thu, 30 Nov 2023 15:11:19 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Arseniy Krasnov <avkrasnov@salutedevices.com>, 
	Stefan Hajnoczi <stefanha@redhat.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Jason Wang <jasowang@redhat.com>, 
	Bobby Eshleman <bobby.eshleman@bytedance.com>, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, kernel@sberdevices.ru, 
	oxffffaa@gmail.com
Subject: Re: [PATCH net-next v5 2/3] virtio/vsock: send credit update during
 setting SO_RCVLOWAT
Message-ID: <pbkiwezwlf6dmogx7exur6tjrtcfzxyn7eqlehqxivqifbkojv@xlziiuzekon4>
References: <20231130130840.253733-1-avkrasnov@salutedevices.com>
 <20231130130840.253733-3-avkrasnov@salutedevices.com>
 <20231130084044-mutt-send-email-mst@kernel.org>
 <02de8982-ec4a-b3b2-e8e5-1bca28cfc01b@salutedevices.com>
 <20231130085445-mutt-send-email-mst@kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20231130085445-mutt-send-email-mst@kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

On Thu, Nov 30, 2023 at 08:58:58AM -0500, Michael S. Tsirkin wrote:
>On Thu, Nov 30, 2023 at 04:43:34PM +0300, Arseniy Krasnov wrote:
>>
>>
>> On 30.11.2023 16:42, Michael S. Tsirkin wrote:
>> > On Thu, Nov 30, 2023 at 04:08:39PM +0300, Arseniy Krasnov wrote:
>> >> Send credit update message when SO_RCVLOWAT is updated and it is bigger
>> >> than number of bytes in rx queue. It is needed, because 'poll()' will
>> >> wait until number of bytes in rx queue will be not smaller than
>> >> SO_RCVLOWAT, so kick sender to send more data. Otherwise mutual hungup
>> >> for tx/rx is possible: sender waits for free space and receiver is
>> >> waiting data in 'poll()'.
>> >>
>> >> Signed-off-by: Arseniy Krasnov <avkrasnov@salutedevices.com>
>> >> ---
>> >>  Changelog:
>> >>  v1 -> v2:
>> >>   * Update commit message by removing 'This patch adds XXX' manner.
>> >>   * Do not initialize 'send_update' variable - set it directly during
>> >>     first usage.
>> >>  v3 -> v4:
>> >>   * Fit comment in 'virtio_transport_notify_set_rcvlowat()' to 80 chars.
>> >>  v4 -> v5:
>> >>   * Do not change callbacks order in transport structures.
>> >>
>> >>  drivers/vhost/vsock.c                   |  1 +
>> >>  include/linux/virtio_vsock.h            |  1 +
>> >>  net/vmw_vsock/virtio_transport.c        |  1 +
>> >>  net/vmw_vsock/virtio_transport_common.c | 27 +++++++++++++++++++++++++
>> >>  net/vmw_vsock/vsock_loopback.c          |  1 +
>> >>  5 files changed, 31 insertions(+)
>> >>
>> >> diff --git a/drivers/vhost/vsock.c b/drivers/vhost/vsock.c
>> >> index f75731396b7e..4146f80db8ac 100644
>> >> --- a/drivers/vhost/vsock.c
>> >> +++ b/drivers/vhost/vsock.c
>> >> @@ -451,6 +451,7 @@ static struct virtio_transport vhost_transport = {
>> >>  		.notify_buffer_size       = virtio_transport_notify_buffer_size,
>> >>
>> >>  		.read_skb = virtio_transport_read_skb,
>> >> +		.notify_set_rcvlowat      = virtio_transport_notify_set_rcvlowat
>> >>  	},
>> >>
>> >>  	.send_pkt = vhost_transport_send_pkt,
>> >> diff --git a/include/linux/virtio_vsock.h b/include/linux/virtio_vsock.h
>> >> index ebb3ce63d64d..c82089dee0c8 100644
>> >> --- a/include/linux/virtio_vsock.h
>> >> +++ b/include/linux/virtio_vsock.h
>> >> @@ -256,4 +256,5 @@ void virtio_transport_put_credit(struct virtio_vsock_sock *vvs, u32 credit);
>> >>  void virtio_transport_deliver_tap_pkt(struct sk_buff *skb);
>> >>  int virtio_transport_purge_skbs(void *vsk, struct sk_buff_head *list);
>> >>  int virtio_transport_read_skb(struct vsock_sock *vsk, skb_read_actor_t read_actor);
>> >> +int virtio_transport_notify_set_rcvlowat(struct vsock_sock *vsk, int val);
>> >>  #endif /* _LINUX_VIRTIO_VSOCK_H */
>> >> diff --git a/net/vmw_vsock/virtio_transport.c b/net/vmw_vsock/virtio_transport.c
>> >> index af5bab1acee1..8007593a3a93 100644
>> >> --- a/net/vmw_vsock/virtio_transport.c
>> >> +++ b/net/vmw_vsock/virtio_transport.c
>> >> @@ -539,6 +539,7 @@ static struct virtio_transport virtio_transport = {
>> >>  		.notify_buffer_size       = virtio_transport_notify_buffer_size,
>> >>
>> >>  		.read_skb = virtio_transport_read_skb,
>> >> +		.notify_set_rcvlowat      = virtio_transport_notify_set_rcvlowat
>> >>  	},
>> >>
>> >>  	.send_pkt = virtio_transport_send_pkt,
>> >> diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
>> >> index f6dc896bf44c..1cb556ad4597 100644
>> >> --- a/net/vmw_vsock/virtio_transport_common.c
>> >> +++ b/net/vmw_vsock/virtio_transport_common.c
>> >> @@ -1684,6 +1684,33 @@ int virtio_transport_read_skb(struct vsock_sock *vsk, skb_read_actor_t recv_acto
>> >>  }
>> >>  EXPORT_SYMBOL_GPL(virtio_transport_read_skb);
>> >>
>> >> +int virtio_transport_notify_set_rcvlowat(struct vsock_sock *vsk, 
>> >> int val)
>> >> +{
>> >> +	struct virtio_vsock_sock *vvs = vsk->trans;
>> >> +	bool send_update;
>> >> +
>> >> +	spin_lock_bh(&vvs->rx_lock);
>> >> +
>> >> +	/* If number of available bytes is less than new SO_RCVLOWAT value,
>> >> +	 * kick sender to send more data, because sender may sleep in 
>> >> its
>> >> +	 * 'send()' syscall waiting for enough space at our side.
>> >> +	 */
>> >> +	send_update = vvs->rx_bytes < val;
>> >> +
>> >> +	spin_unlock_bh(&vvs->rx_lock);
>> >> +
>> >> +	if (send_update) {
>> >> +		int err;
>> >> +
>> >> +		err = virtio_transport_send_credit_update(vsk);
>> >> +		if (err < 0)
>> >> +			return err;
>> >> +	}
>> >> +
>> >> +	return 0;
>> >> +}
>> >
>> >
>> > I find it strange that this will send a credit update
>> > even if nothing changed since this was called previously.
>> > I'm not sure whether this is a problem protocol-wise,
>> > but it certainly was not envisioned when the protocol was
>> > built. WDYT?
>>
>> >From virtio spec I found:
>>
>> It is also valid to send a VIRTIO_VSOCK_OP_CREDIT_UPDATE packet without previously receiving a
>> VIRTIO_VSOCK_OP_CREDIT_REQUEST packet. This allows communicating updates any time a change
>> in buffer space occurs.
>> So I guess there is no limitations to send such type of packet, e.g. it is not
>> required to be a reply for some another packet. Please, correct me if im wrong.
>>
>> Thanks, Arseniy
>
>
>Absolutely. My point was different - with this patch it is possible
>that you are not adding any credits at all since the previous
>VIRTIO_VSOCK_OP_CREDIT_UPDATE.

I think the problem we're solving here is that since as an optimization 
we avoid sending the update for every byte we consume, but we put a 
threshold, then we make sure we update the peer.

A credit update contains a snapshot and sending it the same as the 
previous one should not create any problem.

My doubt now is that we only do this when we set RCVLOWAT , should we 
also do something when we consume bytes to avoid the optimization we 
have?

Stefano

