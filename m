Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794503068;
	b=ltEzaZDDx6wmN5dO2XL7/nMNYayoECX2SCFe6UThTLXFBA3oIUhnbasJLz1pl13LG96y
	 nCzJdcqs4VxB+/Cp5wELftwmMGOe32pKcTk0BO7RzSijBCeCVg2ngMXBDPtMBAKargSSE
	 kyGfEZnaUnC7cqtDces1QUJUfOgYFJL+VsbOIPu4nVFszK3vq/0NAcvL5mp8IBRfq03N0
	 IPMLWtA+GxExwlT/o3FZjmoubidsQslq0yMM7aAlM8uJ1z1RxthSVc4P64j5pLfwSikHk
	 QhhTXHZkMstu/3p+pTw+q47/K345kWkXVHtNna/yF2OtJAc/DEnyANDN1FIrFA5UwCg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794503068;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:
	 In-Reply-To:References:MIME-Version:Date:X-Gm-Features:Message-ID:
	 Subject:To:Cc:X-Mimecast-Spam-Score:X-Mimecast-MFC-PROC-ID:
	 X-Mimecast-Originator:Content-Type;
	bh=snSHFcywNjYaU+V8VNJTtf/b2PyC3xXSLz2Yl9hABOc=;
	b=XjOUB7C4GYwWMftCvmt+hd1/TgComwvCzEwU/r6LhgEecLLuS9rRKq655vmBjlxBY7g0
	 m5jzDaelMZW6QztJNjtKAChjE0zWzZ2vYrcjqXBF7zMn9671zzovOVxQ+Iv9wwWAoo9vW
	 Sbdn7USKeu0sUh/3xAA8mvEVuVqljSqwmjNnDEvZ1vMCZtVrcZY//vysS+xRUTbuw0biz
	 NeRgd4FDn52hINBrxGjSkGcrNGgj0wi7gPFRzrNECaLo7xxsylDdtOZie4HURhFiWY2/d
	 Y46ZVAPkmPpd7nsiRSww6tOcWUMAuWLcp5iapkwcyZkyGAKtf21Sie2Xeu+b4YH3sLw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=RSM4jfOy;
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38608606A334
	for <virtualization@lists.linux.dev>; Thu, 12 Nov 2026 17:04:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 38608606A334
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=RSM4jfOy
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1794503066;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=snSHFcywNjYaU+V8VNJTtf/b2PyC3xXSLz2Yl9hABOc=;
	b=RSM4jfOySxzjJPJjdouIzY7aahn6xYwmwQ426+YBqQwkDoWHGLgeqj8QRmvU57NPACXmsh
	zlikkXlCu202+ypjIEik6t9BI6oNtWjvXMqD6ktYDAPqn115ugNa+3Ye+Ves2Fl+fDHFmo
	IiZSu2po3bI721tRDFzdUrROBgpMv/E=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-414-heAW3e4APjy9ToiPlv8mDQ-1; Thu, 12 Nov 2026 12:04:24 -0500
X-MC-Unique: heAW3e4APjy9ToiPlv8mDQ-1
X-Mimecast-MFC-AGG-ID: heAW3e4APjy9ToiPlv8mDQ_1794503064
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-91ebc622dc8so890916d6.0
        for <virtualization@lists.linux.dev>; Thu, 12 Nov 2026 09:04:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794503064; x=1795107864;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=snSHFcywNjYaU+V8VNJTtf/b2PyC3xXSLz2Yl9hABOc=;
        b=LTALicic0+QSK4/6rX7moN9tSsoca0/2EsR/yfmfK5KhpwX8ytnokKhulUO1iCvepL
         cMSFrDowkJbCbWwvf06+PrVvk1nG4VvKcyyaduOuKWr029PgZE+uTYuFhGzIwyTnIGs3
         u1ESxw6amy2+KMHmL3RmJjWHv4jcc+SHdoa1c3pvXeWnhRPrNzExdZrMK/Urf9CjCEAK
         SeaMihFfnl4tHEpqf7RERd+oFji1O9trdF7ZCQ8Hm+F4Fl4214ZR0wR9aRtcLv5Co4LD
         GZeNiNXvQO6V47XmY04WG14P8t4Si9h01v3494iYaRz1l6CSr7e3ot7WO8CftWfPveCw
         GFpw==
X-Gm-Message-State: APuU4Z9UqZMEBCBy+daVYvv7PfB6/mPkWTa/th24QVBTzAT4uaqrqx5e
	0bOL/KsVhXrYAYOGhbJJAJRIVR2h0WF4Oq15POIbUHhzGGZj7iJUW2fENPxxMgOLuG9FLE7xoPu
	u56IVPGg88jxolFR9VZfHd2y9tAbxW2GJ3k6nVWOtZsClG/egSq9cnviwh+lYZj4soAJIl+uwXc
	xqZB6q+CbK7ZGze+wf7jiCbxqYykK6Z5QjHwlL6Iiodrk=
X-Gm-Gg: AYBFou2pInp2x4zP7wxhKRHerJq/qsDWE8tzvztw0TUO/DqzJ3fNeerIqVamj54k7aO
	xIs7APUOw7S2IKm3HKQWOolIJv+yGCJKl89Ve9w+h2hp5gbS0R4lMEgBV1rCFpo4kr2ClawD0Vo
	YpxcNqH8vuM9ElrZa2cKHZtl47nXaGuhjJ3z2WQ0Fzbdmi/CfmK7j0NeQ=
X-Received: by 2002:a05:6214:3d11:b0:91c:79eb:ea55 with SMTP id 6a1803df08f44-91f040c0da4mr105357366d6.28.1794503064002;
        Thu, 12 Nov 2026 09:04:24 -0800 (PST)
X-Received: by 2002:a05:6214:3d11:b0:91c:79eb:ea55 with SMTP id
 6a1803df08f44-91f040c0da4mr105356616d6.28.1794503063345; Thu, 12 Nov 2026
 09:04:23 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 12 Nov 2026 11:04:22 -0600
From: Sergio Lopez Pascual <slp@redhat.com>
In-Reply-To: <DMGNAV67LK3F.2FNLTD5NVHDEA@gmail.com>
References: <20261028-vsock-dgram-support-v1-0-e457cf7cee78@sinrega.org> <DMGNAV67LK3F.2FNLTD5NVHDEA@gmail.com>
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Date: Thu, 12 Nov 2026 11:04:22 -0600
X-Gm-Features: AclHuK8-kXlDfbY9EpdjADOfLMjXVcZNZptS66ye_0dxL9--qQit5gRpAYjKWyc
Message-ID: <CAAiTLFVrvmrLoFxAdJ+ObY5trjgKvNJW5im7XaRQ+K1PG-_M-Q@mail.gmail.com>
Subject: Re: [PATCH RFC 0/8] vsock: add datagram support to virtio and vhost
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>, Stefano Garzarella <sgarzare@redhat.com>, 
	Bobby Eshleman <bobbyeshleman@meta.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, Bryan Tan <bryan-bt.tan@broadcom.com>, 
	Vishnu Dasa <vishnu.dasa@broadcom.com>, 
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
	Stefan Hajnoczi <stefanha@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowangio@gmail.com>, 
	=?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Haiyang Zhang <haiyangz@microsoft.com>, 
	Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>
Cc: virtualization@lists.linux.dev, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, kvm@vger.kernel.org, bpf@vger.kernel.org, 
	linux-hyperv@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: tyV5f4pRbnswsOQVLx6IsoR7srIEvrubJ07plFT1vWs_1794503064
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"

"Alexei Starovoitov" <alexei.starovoitov@gmail.com> writes:

> On Wed, Oct 28, 2026 at 09:04 AM Sergio Lopez <slp@redhat.com> wrote:
>> This series implements SOCK_DGRAM support for virtio-vsock and
>> vhost-vsock, allowing applications to exchange connectionless messages
>> through the existing AF_VSOCK datagram API.
>
> The cover doesn't say who needs it.
>
> Bobby and Amery took the same feature to v6:
> https://lore.kernel.org/all/20240710212555.1617795-1-amery.hung@bytedance.com/
> Stefano said there that it can work well and that the virtio spec change
> is the next step. The last mails of the thread have Amery's v7 WIP and a
> short list of what is left.
> The cover doesn't mention it. The spec change is still missing.
>
> Why not finish v7 instead ?

The previous series is more that two years old, and vsock has changed
significantly since then. I thought this deserved a complete refresh.

I should have linked the old series in the cover, though. I'll do that
in v2.

As for the spec, I asked Stefano and we agreed it'd be better to have a
series that's pretty close to be merged before sending the spec change,
and I agree that's a good idea. In fact, adopting SEQPACKET's strategy
for splitting up packets in the vq would have an impact on the spec.

> This RFC goes the other way in these places:
>
>   what               v6                        this RFC
>   -----------------  ------------------------  ----------------------------
>   (cid, port) space  own bind table for dgram  shared with stream. The 2nd
>                                                bind() gets EADDRINUSE
>   vsk->transport     empty until connect(),    g2h or h2g, picked in
>                      lookup per packet         socket(). -ENODEV with
>                                                vsock_loopback only
>   routing            one helper for stream     2nd copy of the chain in
>                      and dgram                 vsock_assign_transport()
>   recvmsg()          in af_vsock.c,            dgram_dequeue() stays,
>                      no dgram_dequeue()        dgram_payload_len() is new
>   VMCI               fallback                  first. No virtio dgram when
>                                                its module is loaded
>   dgram > RX buffer  drop, EHOSTUNREACH in     every RX buffer is 64K
>                      the error queue
>
>> Datagrams use destination-based routing across guest-to-host,
>> host-to-guest and loopback transports while retaining the socket's
>> transport state. VMCI keeps priority as the dedicated datagram
>
> A dgram socket uses two members of struct virtio_vsock_sock: tx_lock and
> bytes_unsent. They serve SIOCOUTQ only.
> virtio_transport_alloc_skb() does skb_set_owner_w() already.
> udp_ioctl() returns sk_wmem_alloc_get() for SIOCOUTQ.
>
> Without them a dgram socket has no transport state, like in v6.
> Then no need for the owner transport, dgram_transport_match(),
> fallback_transport, tx_accounted, the skb destructor, etc.
>
>> transport.  Guest RX buffers accommodate complete messages when
>> datagrams are negotiated, preserving message boundaries.
>
> That's 64K per RX buffer instead of 4K, for stream and seqpacket too.
> It undoes commit 03a92f036a04 ("vsock/virtio: Resize receive buffers so
> that each SKB fits in a 4K page").
>
> pskb_trim_unique() doesn't reduce skb->truesize. So a datagram of 1 byte
> charges more than 64K to sk_rmem_alloc of the guest socket.
> The default sk_rcvbuf is about 208K on x86-64. The 5th datagram in the
> queue is dropped.

Thanks for the review, I'm putting together a v2 addressing these
concerns.

Cheers,
Sergio.

