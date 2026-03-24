Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 905D134EEF5
	for <virtualization@lists.linux.dev>; Tue, 24 Mar 2026 07:46:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.219.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774338408; cv=pass; b=Em0JkbDwheMRFM0zpwj52AGUhOY7TQTZBbtnuKRkX6+QdJ2BHkncDiPfwwslVy8y39xdH3rDKJ87VaS50lYEseLBd3zhKDlfIwnZaazsCtzb3o2NeLdLcrlQZVqO/obphqlLqyc/e41l8JojCVha6btrjnE8JtxDq+WX/eznTn4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774338408; c=relaxed/simple;
	bh=UD2wbaMFnRxKpWf+z6+HfYus07A2S++EQyCRhHJ9cek=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ap2hP29IzSwolqw/a0ej563FCxxOEosWIMNVGsACuPEZucJgLcRevry+pReDypaVqjjzFwvEYFbTghXHona5E9SK1FVCqRd01vdvPiMWCMzlbZUM2mkxUzc7uOvSdXrZRQBdahY3YH/6S2LliBCFn9XJnU9s+e2kRdnzH+YMsdE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qX3P27e1; arc=pass smtp.client-ip=209.85.219.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qX3P27e1"
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-89a000f5adeso61788866d6.3
        for <virtualization@lists.linux.dev>; Tue, 24 Mar 2026 00:46:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774338399; cv=none;
        d=google.com; s=arc-20240605;
        b=aUdPE0ZUWv1pwiTzvVYA9fzEohTn+iMjnVDB0uXs9sM1PSj+W2LPbfijHTZPHCk+M3
         gG/46y127LKR/sRl0XPvZ3KTO7cq0V+bbdZFjBNpqfRbMJMP5vhHEnAyMOsXIoFQetzQ
         7HiXza1I2bf8NiUR37WqNZQZ5FNNVGFqfPYTjLI44vzYdFa9IlILPxr3RVdAELrfOvGc
         Thi5dC6tIhuyRjPQrb84n950MuFC67twMtxS0J1Qdjjn1bLkxd5wLTcwDqsJDNW8XayO
         z7MvnbV9eAfRfxxlJbBrPIr+OIroFrmt+sXnyTYiN/22StbOdg5TppjDItNX5ypP6MAV
         qzCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=xHFEGvyuVueh8l+H85vdxytZmPQSqK2Ng0X2X/FjRmY=;
        fh=ynLZ/T8ZWbDO0OH+DsvIE02Tc3qNZU4YDOp9C3p0GVk=;
        b=bbdQaSHuI4JyCrGqVnG2zW0KtkTW1kS70Z6vrTpSt7UWKstXxoIQp/dw5w4RHVR901
         k8ftiSF3+BBbRY77xFV9TudHMMhgzwl1Z8xCLziZ2RT3uWbWsej/gmM+Jy/N3FbV6rnk
         yXPyH9YsX9P5G8lfZckMG3mbRlPCoGqVmSs7o3Gd9JddFjCeTjn/FlfawCjDH2yJuPma
         0t7Wdh2MsDSyVlTId3+Hxi2bO/VHejEQxgFsivSM1Z6VcqUKiOeWs4PW6psZOtv+4j5y
         OOTFoF+7OWHiVexPevvC4vkL2a6HtArEIl+kOCctYuGnzJgdSoKZtcmbfGISfdFqEZ9x
         Bazw==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1774338399; x=1774943199; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xHFEGvyuVueh8l+H85vdxytZmPQSqK2Ng0X2X/FjRmY=;
        b=qX3P27e1MTOAm/bRL5dI35wpKn8rQ+BWcoJ+GijAO0gcjGrOofsPoLfKTMA41mga03
         LtZMwix0AlHJmfUjKCIT2tPpez3YNmk1dulhKPIPkhgncLKJf8ulF5LWIVZ3cQq/xGfM
         yUxtP4Pglz9S/uGfq2IK/ez4AsxdN4voqMUfDmMhi8ctGIELW5YGXdwaBKbIE34F/Sfu
         +vsWTSDtLormOi0vmmEips6mWsl+Nwamnjvo+BoLBfQWoAa2xZOkZZprjlfoIo44o8vy
         3uWWXE9U2QynSVXUovW0ErshgHkd3v+g0K9wwFNf9BpauKVsWzR1Q/VDoo1SdPB7eMDr
         6WzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774338399; x=1774943199;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=xHFEGvyuVueh8l+H85vdxytZmPQSqK2Ng0X2X/FjRmY=;
        b=f/+YFcxs7SzZRjwAiikfA/dHc292tc148yW+3+1HRDhjXfvwd4iuZeRT8uGM7/cyZk
         joxBMnbw4yIqgTL2wMFbSDFzgNm8uExG/9+kDLOuhcddQJaLJgTEWeq3ORGnJtcR/K3J
         f6kfhsSWIVkwgTFazYhskO9Q33cp6ayC6YQl1k08/tekF4MMILOrK6BI0KvXGhLAeAXq
         2PgsEPif8gmG1ZHX/pwNjnjd2CB2ajsebLD0v6tWjJEDL0hv2BG3c/YKcOwPqfSp5wHT
         Jv6mXZLLV9RD7lqplD2x/UiCqqut7STQHpibP0kxbDwPk9DvO91N2DPmVKgfmD1B8AiG
         /etQ==
X-Forwarded-Encrypted: i=1; AJvYcCVYKwof/Lba+T1dU5DCnI08EjEO0yYRKroI6TTCWdTF9ElzZE2qvODWcsrqE33UlOhD7UzBncqU5Aal2xqpOw==@lists.linux.dev
X-Gm-Message-State: AOJu0Yx5Kpefdc/ir3rNGQqDP9RQjL//CYLa92k5hXUfIRD8L4M6gWL1
	z68Gl7GrIy/QHnxIWAdVHr1EzNV5vx6sa9Y3I8QPFGI0z9E1UdxNuNPYGQpRDeHmBkKtbbidEno
	yad6RpiT5cfwLkk3SIHFqATQR4sWZxpct3fmhNSPs
X-Gm-Gg: ATEYQzx3eOhlDHH6Vj/9KvFdrh+XJkCaRb5N9MLvHGSRHjbakL+pWLrs+HVZpFBnVof
	kUiXwNCtVIhJ4zwn2025tE0z522ctibb0SAITeV4nEJa5w8P11ZzJ4cokfeP96HmSpAbX+9PV/v
	GEl/j1xDuwMNHJd0Oc2AuxV1OqXPf3GeMvEtauD8I+pHksG8p9tmZUFJV+inx0G+JdJfMucdh0T
	U+IjmaCToR2a0YoFeBbZVYZy4lezdvUojXE4FW3fmmPfepo16cOJLoRFrDJ1VG9EwkFA1JRp13V
	bUjYWg==
X-Received: by 2002:ad4:5d62:0:b0:89c:a2c8:a874 with SMTP id
 6a1803df08f44-89ca2c8af85mr111671516d6.41.1774338398191; Tue, 24 Mar 2026
 00:46:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260312025406.15641-1-xietangxin@yeah.net> <1774335943.3427165-1-xuanzhuo@linux.alibaba.com>
In-Reply-To: <1774335943.3427165-1-xuanzhuo@linux.alibaba.com>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 24 Mar 2026 00:46:27 -0700
X-Gm-Features: AaiRm51GA4aV1ym9PHNSS4b7XqpUYygD3yfgSv699tCpajq3gs0b1wqLQ4Ac1Ew
Message-ID: <CANn89iJYj9Jc8-usgAYcFMoSo+Po3aOxsMkhg+F8BA_kME2e9g@mail.gmail.com>
Subject: Re: [PATCH net v2] virtio_net: Fix UAF on dst_ops when
 IFF_XMIT_DST_RELEASE is cleared and napi_tx is false
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: xietangxin <xietangxin@yeah.net>, netdev@vger.kernel.org, 
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org, "Michael S . Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
	"David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 24, 2026 at 12:11=E2=80=AFAM Xuan Zhuo <xuanzhuo@linux.alibaba.=
com> wrote:
>
> On Thu, 12 Mar 2026 10:54:06 +0800, xietangxin <xietangxin@yeah.net> wrot=
e:
> > A UAF issue occurs when the virtio_net driver is configured with napi_t=
x=3DN
> > and the device's IFF_XMIT_DST_RELEASE flag is cleared
> > (e.g., during the configuration of tc route filter rules).
> >
> > When IFF_XMIT_DST_RELEASE is removed from the net_device, the network s=
tack
> > expects the driver to hold the reference to skb->dst until the packet
> > is fully transmitted and freed. In virtio_net with napi_tx=3DN,
> > skbs may remain in the virtio transmit ring for an extended period.
> >
> > If the network namespace is destroyed while these skbs are still pendin=
g,
> > the corresponding dst_ops structure has freed. When a subsequent packet
> > is transmitted, free_old_xmit() is triggered to clean up old skbs.
> > It then calls dst_release() on the skb associated with the stale dst_en=
try.
> > Since the dst_ops (referenced by the dst_entry) has already been freed,
> > a UAF kernel paging request occurs.
>
> Sorry, this sounds a bit off to me. We know that napi_tx=3DN merely prolo=
ngs the
> presence of the skb on the device side. However, even without napi_tx=3DN=
, there
> is no guarantee that the skb will be freed within any specific timeframe.
> Therefore, napi_tx=3DN just makes the issue more reproducible; it is not =
the root
> cause. Also, I'm surprised that the dst could be freed while it is still
> referenced/held. I have a feeling that something is being overlooked here=
.
>
> Thanks.
>
> >
> > fix it by adds skb_dst_drop(skb) in start_xmit to explicitly release
> > the dst reference before the skb is queued in virtio_net.
> >
> > Call Trace:
> >  Unable to handle kernel paging request at virtual address ffff80007e15=
0000
> >  CPU: 2 UID: 0 PID: 6236 Comm: ping Kdump: loaded Not tainted 7.0.0-rc1=
+ #6 PREEMPT
> >   ...
> >   percpu_counter_add_batch+0x3c/0x158 lib/percpu_counter.c:98 (P)
> >   dst_release+0xe0/0x110  net/core/dst.c:177
> >   skb_release_head_state+0xe8/0x108 net/core/skbuff.c:1177
> >   sk_skb_reason_drop+0x54/0x2d8 net/core/skbuff.c:1255
> >   dev_kfree_skb_any_reason+0x64/0x78 net/core/dev.c:3469
> >   napi_consume_skb+0x1c4/0x3a0 net/core/skbuff.c:1527
> >   __free_old_xmit+0x164/0x230  drivers/net/virtio_net.c:611 [virtio_net=
]
> >   free_old_xmit drivers/net/virtio_net.c:1081 [virtio_net]
> >   start_xmit+0x7c/0x530 drivers/net/virtio_net.c:3329 [virtio_net]
> >   ...
> >
> > Reproduction Steps:
> > NETDEV=3D"enp3s0"
> >
> > config_qdisc_route_filter() {
> >     tc qdisc del dev $NETDEV root
> >     tc qdisc add dev $NETDEV root handle 1: prio
> >     tc filter add dev $NETDEV parent 1:0 \
> >       protocol ip prio 100 route to 100 flowid 1:1
> >     ip route add 192.168.1.100/32 dev $NETDEV realm 100
> > }
> >
> > test_ns() {
> >     ip netns add testns
> >     ip link set $NETDEV netns testns
> >     ip netns exec testns ifconfig $NETDEV  10.0.32.46/24
> >     ip netns exec testns ping -c 1 10.0.32.1
> >     ip netns del testns
> > }
> >
> > config_qdisc_route_filter
> >
> > test_ns
> > sleep 2
> > test_ns

I took a stab at this, please look at

https://lore.kernel.org/netdev/20260324073750.1500328-1-edumazet@google.com=
/T/#u
