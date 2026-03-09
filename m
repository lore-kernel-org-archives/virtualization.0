Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7025C259C84
	for <virtualization@lists.linux.dev>; Mon,  9 Mar 2026 03:42:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773027759; cv=none; b=nrOTmQ71fv5mpliy6UQVDTSypm2MzXRUgFSIhHMdxmX5jJ3e1Jf9/TkazoESvWO6I57qm/19MM/fMVJQ0y2s+Keffxwbu6Yims2sFJ4d2e4xDMBOjXneI06g3CFayQ9HYztifYGhddKpUX6l5E+J0vDO5eLf3yYVCgRuHeQa/B8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773027759; c=relaxed/simple;
	bh=h59yI8Twx8xwQ62XEvBZjiCdd7nRoGrUhzZvhcRhIhU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CzmL3y1NO+wMadJKH7sCL86+LXx2GR145DhuhhK6OFnqHmaZb6OQePUNH3IS9a0kV4pWf3R3UXoWy4fe9TcnXWwIDKuJdNDZu3VTygnyJEiPFoAXDNc8adFypWLE+Rxw9SKWHpkhk59myP7Nug42BNpzupysIWuNLSGbF6GgnSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gb6FJSP4; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gb6FJSP4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1773027757;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=c6tbQG6ku1sTC/Bo8+JB48V19ro4mcVnhtT2Tfv1uWk=;
	b=gb6FJSP4pfx2rberXTbwlQF9SZXwuhn9NZAO25F8hAIZ2PfoxVmUL6GrMtE1lU6a8A/CRX
	D41lctAqxhHyIVh6OO+et+fprVyqQoD3034CiZzmC9Lsk48TBb5kdPX3hEm8a5y/9bx/Ar
	qGBcFmNsoMnd3fLrT+J+eGffFNPRWVM=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-593-yQrNAnasNsefuEu2450Ewg-1; Sun, 08 Mar 2026 23:42:36 -0400
X-MC-Unique: yQrNAnasNsefuEu2450Ewg-1
X-Mimecast-MFC-AGG-ID: yQrNAnasNsefuEu2450Ewg_1773027755
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-35845fcf0f5so12749679a91.0
        for <virtualization@lists.linux.dev>; Sun, 08 Mar 2026 20:42:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773027755; x=1773632555;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=c6tbQG6ku1sTC/Bo8+JB48V19ro4mcVnhtT2Tfv1uWk=;
        b=mj+F3/TJSIyue1IPSABJdfCi89EeAw87zDPC5L+rKW/nhV33c/hbLeN0Dn0Vnk18mQ
         aRua33cgEvGeSscU8sEuU+86OsWh1ZPDqh5w9KK7Fa7UZBsZP5Dg841u4oqaU2tQ84iU
         0ioNM9NMe7yKWGnii3FGLJ8TG5OkzIK6p3K9dcu4O+xsMzmI9MAwUQJCm9Om0tus17Bx
         XGjwD/lmsVbJUs7tctxDuMcY/CfwtO2t0TUR7BjgsSD/pRqqjcWBFzjy89TxZOH3EyzC
         ztSO1ox6qOzdMP39mPeQ/ozIWwC53+vKQW0LjfuWUUmRUz7FszpCjjBMT9FKbh0jnett
         lp4g==
X-Forwarded-Encrypted: i=1; AJvYcCVDOBcqEGCBc8A/Nsq7nVkGhAaDmv1VGz/NLg+HqVpo4nG0K3K71zI5ExONPJxQjwZ3xXMgoV/t3Jp5lObU0Q==@lists.linux.dev
X-Gm-Message-State: AOJu0Yz5ygooCeypE+H68nDD+DMgPfShuZH9E6trZqHvPWfAKRAF/sf5
	CtCz7t1VW1eLcXQp4RVV/tKdhL43xreR74GernX64spiP7MgE44qnUA2WChF2iDitHlfETYNpnx
	kYkBbsg+lxCJGEjywCzuKozHfpTwfeiDs8kjsz5Ra1NuyCPFjOMwsFyxifzzVwiiT5nIV18DMJk
	hisCuCet9qFtmM3pK1GszkuEA17SkkdaXUKLtLlnq1eyc=
X-Gm-Gg: ATEYQzxn7TAPIiUD9uEda/WBNy+XLfTI17NuwBmSF/4CsYyOOj1Bd5cZrpKgBXZlhwh
	KHCRTuilD9X+6kep32lZx80Fy5wVk7RbaB+mbp2VRfEePRXxlY+bOASrs3hZB7pxA2r8yA7nK2v
	H2sPLbWXAIIsj8LqXEYD3UHMMrpIPT15guRoj4A4BGoCprNXC9DZrPs2lbmdBOK6sq10YWR/Wzn
	7pnP3RV
X-Received: by 2002:a17:90b:2d8c:b0:358:ed1d:2834 with SMTP id 98e67ed59e1d1-359be2cacf5mr8230077a91.6.1773027755243;
        Sun, 08 Mar 2026 20:42:35 -0700 (PDT)
X-Received: by 2002:a17:90b:2d8c:b0:358:ed1d:2834 with SMTP id
 98e67ed59e1d1-359be2cacf5mr8230069a91.6.1773027754791; Sun, 08 Mar 2026
 20:42:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260307035110.7121-1-xietangxin@yeah.net>
In-Reply-To: <20260307035110.7121-1-xietangxin@yeah.net>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 9 Mar 2026 11:42:23 +0800
X-Gm-Features: AaiRm515o09shxwU_vdeElMuc1lZuriMjuJEkBKKXciJg6H8s9RUT3AneTah6Xk
Message-ID: <CACGkMEtBS3M6P9xFM-kfPHyjwHgvCrfHM5H1242AQPi54ETqEw@mail.gmail.com>
Subject: Re: [PATCH] virtio_net: Fix UAF on dst_ops when IFF_XMIT_DST_RELEASE
 is cleared and napi_tx is false
To: xietangxin <xietangxin@yeah.net>
Cc: "Michael S . Tsirkin" <mst@redhat.com>, "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	=?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, netdev@vger.kernel.org, 
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: RltN94M7u_A-49A3d1m2WF2nizQ_UC8tsEkZhLo-Xzo_1773027755
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Mar 7, 2026 at 11:53=E2=80=AFAM xietangxin <xietangxin@yeah.net> wr=
ote:
>
> A UAF issue occurs when the virtio_net driver is configured with napi_tx=
=3DN
> and the device's IFF_XMIT_DST_RELEASE flag is cleared
> (e.g., during the configuration of tc route filter rules).
>
> When IFF_XMIT_DST_RELEASE is removed from the net_device, the network sta=
ck
> expects the driver to hold the reference to skb->dst until the packet
> is fully transmitted and freed. In virtio_net with napi_tx=3DN,
> skbs may remain in the virtio transmit ring for an extended period.
>
> If the network namespace is destroyed while these skbs are still pending,
> the corresponding dst_ops structure has freed. When a subsequent packet
> is transmitted, free_old_xmit() is triggered to clean up old skbs.
> It then calls dst_release() on the skb associated with the stale dst_entr=
y.
> Since the dst_ops (referenced by the dst_entry) has already been freed,
> a UAF kernel paging request occurs.
>
> fix it by adds skb_dst_drop(skb) in start_xmit to explicitly release
> the dst reference before the skb is queued in virtio_net.
>
> Call Trace:
>  Unable to handle kernel paging request at virtual address ffff80007e1500=
00
>  CPU: 2 UID: 0 PID: 6236 Comm: ping Kdump: loaded Not tainted 7.0.0-rc1+ =
#6 PREEMPT
>   ...
>   percpu_counter_add_batch+0x3c/0x158 lib/percpu_counter.c:98 (P)
>   dst_release+0xe0/0x110  net/core/dst.c:177
>   skb_release_head_state+0xe8/0x108 net/core/skbuff.c:1177
>   sk_skb_reason_drop+0x54/0x2d8 net/core/skbuff.c:1255
>   dev_kfree_skb_any_reason+0x64/0x78 net/core/dev.c:3469
>   napi_consume_skb+0x1c4/0x3a0 net/core/skbuff.c:1527
>   __free_old_xmit+0x164/0x230  drivers/net/virtio_net.c:611 [virtio_net]
>   free_old_xmit drivers/net/virtio_net.c:1081 [virtio_net]
>   start_xmit+0x7c/0x530 drivers/net/virtio_net.c:3329 [virtio_net]
>   ...
>
> Reproduction Steps:
> NETDEV=3D"enp3s0"
>
> config_qdisc_route_filter() {
>     tc qdisc del dev $NETDEV root
>     tc qdisc add dev $NETDEV root handle 1: prio
>     tc filter add dev $NETDEV parent 1:0 protocol ip prio 100 route to 10=
0 flowid 1:1
>     ip route add 192.168.1.100/32 dev $NETDEV realm 100
> }
>
> test_ns() {
>     ip netns add testns
>     ip link set $NETDEV netns testns
>     ip netns exec testns ifconfig $NETDEV  10.0.32.46/24
>     ip netns exec testns ping -c 1 10.0.32.1
>     ip netns del testns
> }
>
> config_qdisc_route_filter
>
> test_ns
> sleep 2
> test_ns
>
> Signed-off-by: xietangxin <xietangxin@yeah.net>
> ---

This is needed for stable I think.

And do we need to fix tun_net_xmit() as well?

Thanks

