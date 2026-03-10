Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE2C63A872B
	for <virtualization@lists.linux.dev>; Tue, 10 Mar 2026 03:03:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773111793; cv=none; b=p7Z+hYRXfPGfnt/o1/JVXeCLZB3rRPYJ/d7C8Ni3gnlY9P67XWis2wkhXIpa691oSKC1/XGKSjON+5MViQMALXie/rGkRLbYR0zhAVKUKTHba6V/hoxFiuSlXlw7IOkppTuM1pEmehUwuTgp1zUhgbrO0WAJvjT4k8IXe+snN8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773111793; c=relaxed/simple;
	bh=0v2K0W2zP+AM5y+fHVEDnet++UbxfEr4lS8iB4tGChw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Vv5Ge256UnxJ+0d79BXEv7eBYQuA5PaEywq0g9rB16zF+ukbXRxv4vmRSz4rFoms22aJZKUE3DEsD6IH0Mb0oQV9Hdxykm5Cxk8dYt7+qxGDaDfQiI6jTxVpU2wxsekiX8jGZ/txjY/dKfiSwXloFO+pWeLMYDJBDwi9K1pOZkU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cQWR9FM0; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cQWR9FM0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1773111790;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IJQ2dCfDYTqoMx6naowXS2cizlpAXMvHukUkaPemtzc=;
	b=cQWR9FM0esD5lI0x/aP3m6oaLBHZ4tqcStDW8lA/ktl5VviQdyZoT+jqB1mpQrckMWnKCk
	kgImWN/SsI0ziJRCChFZlVpzNeSSQtzHrN7iWAHecx95/1Uae9HYXwMOMJNtH4DoZLzKdS
	9XXyL+jVWB1ldPSfBYTkQ5zQaK48yyw=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-640-COzW4d1wMGGZDk2kyZRbdg-1; Mon, 09 Mar 2026 23:03:09 -0400
X-MC-Unique: COzW4d1wMGGZDk2kyZRbdg-1
X-Mimecast-MFC-AGG-ID: COzW4d1wMGGZDk2kyZRbdg_1773111789
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-35842aa350fso58206244a91.0
        for <virtualization@lists.linux.dev>; Mon, 09 Mar 2026 20:03:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773111788; x=1773716588;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=IJQ2dCfDYTqoMx6naowXS2cizlpAXMvHukUkaPemtzc=;
        b=rVwHwjXq+sJSEics+LBxrA41862GEcA0gm0E222VwWzIyHYQhKDIpWnVbmtFsADZh9
         p9k+T0fP7QC81omZBfjS3ZpQlytAjaAkB06VGd8+UMu2CBRUeVN0XBYBfSgRkoaVApwe
         KZ7bIn3dWcHg7+G7Dc5r49Tjft83oVrHqSNljrIiwoWaQs6b2blNiGYdPPgGLqOjB3ha
         zYx/qtK0FLP4cZ1PuSUQuMfEf8h3A8rNqRBR3cRrqnGnlXTfIJacfEEsDfQyE5/73Xqj
         NEhP2/cJ9/g4Qf79Ksumph6qt8Tj5zu710+y1m+Q3e1hVsg+l2qmWdlCe5xT100Do0nW
         hctQ==
X-Forwarded-Encrypted: i=1; AJvYcCV1q+ZeRF0L971K/z4JmGRMtSpjD4EIaCCAnnsdxl/0qxy9eZtWnYnhlKDK9Bk09ICYxw3FGCm12DVlt06kdQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YyPqnuQ3AoU0e4UBKE8fTmIrJ/Yp6aahNI+qUlDOh+SeFLK9Al+
	++VKWDxKDgw9zuHXVjA7K/5Azg7IlrFmqJVA06S5kRK6IRVFMiUY0/Sv+ux5ZnqDYwYz9eVMjOB
	lVuwO1ROgBzPJPPdnqU8d8rA8F8XJuNrWnQ0ev0EebJT7eiqBuVW8RDiWRXs4jPS9YTBxr/d7Dn
	XgzpWJyvV1EhgUyHmdsMr1Wh25QXQur33NwhPWkY2bqvOIVNdGBTE=
X-Gm-Gg: ATEYQzx6tV68aDwjQy0bLGy9oeFFK2LgnYWTszxy0uX7uFg0qiBnIJN+vRq5s7T+s/9
	ceuGkPJwfxfIDuNywwevnplAPo241rDulhkTJmqr4GJN/oQmzOO7U+oR4Gt1Omsmut3gQyi187S
	3RtuoGs6uqfTcR7tjRBjgvMdJ8uJ1pBGg00KuSxCuWLo1JgzJTdHhOsqVFR8VksYHZzST+aIwk/
	ybrlVYG
X-Received: by 2002:a17:90b:5410:b0:352:ba0f:fb28 with SMTP id 98e67ed59e1d1-359be23398cmr12298993a91.1.1773111788400;
        Mon, 09 Mar 2026 20:03:08 -0700 (PDT)
X-Received: by 2002:a17:90b:5410:b0:352:ba0f:fb28 with SMTP id
 98e67ed59e1d1-359be23398cmr12298960a91.1.1773111787935; Mon, 09 Mar 2026
 20:03:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260307035110.7121-1-xietangxin@yeah.net> <CACGkMEtBS3M6P9xFM-kfPHyjwHgvCrfHM5H1242AQPi54ETqEw@mail.gmail.com>
 <4b8a6182-da50-4edb-a34a-b75ed784f1e2@yeah.net>
In-Reply-To: <4b8a6182-da50-4edb-a34a-b75ed784f1e2@yeah.net>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 10 Mar 2026 11:02:55 +0800
X-Gm-Features: AaiRm509qPpH0vS0k_Y0y1HeOHRnsQKlnDDd-ndbgXxaWrw72LfUJL_pWWgEATA
Message-ID: <CACGkMEuguforqrFH+wy2eG-W+ufHmqA_6+LSRPTyxDC-4UYFAQ@mail.gmail.com>
Subject: Re: [PATCH] virtio_net: Fix UAF on dst_ops when IFF_XMIT_DST_RELEASE
 is cleared and napi_tx is false
To: xietangxin <xietangxin@yeah.net>
Cc: "Michael S . Tsirkin" <mst@redhat.com>, "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	=?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, netdev@vger.kernel.org, 
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 8y9dsEbvo6EKyrJqpvJypMuV2ZStOfsL6q7RAZQ0Pkw_1773111789
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 9, 2026 at 7:37=E2=80=AFPM xietangxin <xietangxin@yeah.net> wro=
te:
>
>
>
> On 3/9/2026 11:42 AM, Jason Wang wrote:
> > On Sat, Mar 7, 2026 at 11:53=E2=80=AFAM xietangxin <xietangxin@yeah.net=
> wrote:
> >>
> >> A UAF issue occurs when the virtio_net driver is configured with napi_=
tx=3DN
> >> and the device's IFF_XMIT_DST_RELEASE flag is cleared
> >> (e.g., during the configuration of tc route filter rules).
> >>
> >> When IFF_XMIT_DST_RELEASE is removed from the net_device, the network =
stack
> >> expects the driver to hold the reference to skb->dst until the packet
> >> is fully transmitted and freed. In virtio_net with napi_tx=3DN,
> >> skbs may remain in the virtio transmit ring for an extended period.
> >>
> >> If the network namespace is destroyed while these skbs are still pendi=
ng,
> >> the corresponding dst_ops structure has freed. When a subsequent packe=
t
> >> is transmitted, free_old_xmit() is triggered to clean up old skbs.
> >> It then calls dst_release() on the skb associated with the stale dst_e=
ntry.
> >> Since the dst_ops (referenced by the dst_entry) has already been freed=
,
> >> a UAF kernel paging request occurs.
> >>
> >> fix it by adds skb_dst_drop(skb) in start_xmit to explicitly release
> >> the dst reference before the skb is queued in virtio_net.
> >>
> >> Call Trace:
> >>  Unable to handle kernel paging request at virtual address ffff80007e1=
50000
> >>  CPU: 2 UID: 0 PID: 6236 Comm: ping Kdump: loaded Not tainted 7.0.0-rc=
1+ #6 PREEMPT
> >>   ...
> >>   percpu_counter_add_batch+0x3c/0x158 lib/percpu_counter.c:98 (P)
> >>   dst_release+0xe0/0x110  net/core/dst.c:177
> >>   skb_release_head_state+0xe8/0x108 net/core/skbuff.c:1177
> >>   sk_skb_reason_drop+0x54/0x2d8 net/core/skbuff.c:1255
> >>   dev_kfree_skb_any_reason+0x64/0x78 net/core/dev.c:3469
> >>   napi_consume_skb+0x1c4/0x3a0 net/core/skbuff.c:1527
> >>   __free_old_xmit+0x164/0x230  drivers/net/virtio_net.c:611 [virtio_ne=
t]
> >>   free_old_xmit drivers/net/virtio_net.c:1081 [virtio_net]
> >>   start_xmit+0x7c/0x530 drivers/net/virtio_net.c:3329 [virtio_net]
> >>   ...
> >>
> >> Reproduction Steps:
> >> NETDEV=3D"enp3s0"
> >>
> >> config_qdisc_route_filter() {
> >>     tc qdisc del dev $NETDEV root
> >>     tc qdisc add dev $NETDEV root handle 1: prio
> >>     tc filter add dev $NETDEV parent 1:0 protocol ip prio 100 route to=
 100 flowid 1:1
> >>     ip route add 192.168.1.100/32 dev $NETDEV realm 100
> >> }
> >>
> >> test_ns() {
> >>     ip netns add testns
> >>     ip link set $NETDEV netns testns
> >>     ip netns exec testns ifconfig $NETDEV  10.0.32.46/24
> >>     ip netns exec testns ping -c 1 10.0.32.1
> >>     ip netns del testns
> >> }
> >>
> >> config_qdisc_route_filter
> >>
> >> test_ns
> >> sleep 2
> >> test_ns
> >>
> >> Signed-off-by: xietangxin <xietangxin@yeah.net>
> >> ---
> >
> > This is needed for stable I think.
> >
> > And do we need to fix tun_net_xmit() as well?
> >
> > Thanks
> Hi Jason,
>
> I have analyzed the tun driver and concluded that it don't suffer from th=
is UAF issue.
>
> The netns containing a tun interface cannot be destroyed until all proces=
ses
> holding the tun file descriptor have exited.

Note that you can close all the file descriptors but tun device is still th=
ere.

> When the file descriptor is closed,
> tun_chr_close() is called, which immediately free all skbs in the tx_ring=
.
> This happens before cleanup_net() destroys the dst_ops. Therefore, no skb=
s referencing freeed dst_ops.
> Unlike virtio_net, where skbs can remain in the TX queue even if the ns i=
s deleted.
>
> I believe the fix is only necessary for virtio_net. What do you think?
>
> Best regards,
>
> Tangxin Xie
>

Thanks

