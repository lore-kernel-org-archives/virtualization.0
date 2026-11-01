Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.217.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793545049;
	b=1i/KY8RVfVUCw5HpaGVl/X2fVJ8qJdLg6idCyqF6xxjzxte4us1Kwv8DLgFJWIvqirTV
	 OW5MLBJtsG6nJ9h9iQS1y96ZIK4CoEobN5FMNJsWfoM7Am6II52IvjXJNl8t23cm0//T4
	 d5+2HCWdzW8AEDALvzGHv7H/HM1rHibhPEQq5aiu0BREsDkoNCrt/7SeVD3K9ZWaemPof
	 P6zcn8eVjCGSWdlQnfehSqrtsnJEwLwLnrHh1itTz9cmsfeTeNy7irRABBe1i0Q+aA0N+
	 oXlGEAIjIWLNZPEugOTbP59jelMZpsLwOCfDJgQTgucq83WsmFjHOiw9H2dcBJWsNJw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793545049;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=PGMqY+oZ0RvA46OKAo95DoA/lt7CWx4VsMgHlnaoQfk=;
	b=YdzwsnKQdWJNLrZyyG0+k2t+UCVRemjkc9H6HIdi7fEmz80qemsJ7T1FfAhSb38vqSMS
	 sdKaty1JAgxoELZBcWQiw5TUeEBrg1fft/A02sUPcFeKAk64OGaaqljs+FByDMnnWFzz3
	 XqUwU5Y5X8BHySA7udlxWM2JqswQbNp4OafcVqedxixCB5auOPM/+isGObhtaR9X/xPBH
	 JmW/0N6zau7ONAMoqtgyULHOqt+DNApNCda2Iy5/4+SVecisHF8FntURpydREDjmbj3Ub
	 d5UUNY8aKaCz5Yz+YNdnJcVeLNKkwA4UE5RDCpFVmzjXWCBxzVGToqK+K1i37zB7y7g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=gmq5HQwz;
	arc=none smtp.remote-ip=209.85.217.43
Received: from mail-vs1-f43.google.com (mail-vs1-f43.google.com [209.85.217.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05251606A325
	for <virtualization@lists.linux.dev>; Sun,  1 Nov 2026 14:57:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 05251606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=gmq5HQwz
Received: by mail-vs1-f43.google.com with SMTP id ada2fe7eead31-7cc0e865dd1so701724137.1
        for <virtualization@lists.linux.dev>; Sun, 01 Nov 2026 06:57:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793545048; x=1794149848; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=PGMqY+oZ0RvA46OKAo95DoA/lt7CWx4VsMgHlnaoQfk=;
        b=gmq5HQwzHCCgRPdFxXYzD1DKal9QpHbObb16JjD/M/Ok5Je55jGZz8iwD9FQ3Ujqke
         sLphPijbfpkoJdHatwvriGEGNvPhiKeYZ/ndJhKOWHIqvSAdRn4SO/VgyNjeqRy+9WEd
         qCFFvTrU6MTKwxBCQcruPzPEuOHu3xMDMEq5DybMwvzn09ykCoL4bosH6iztXCl9AnXc
         vK94KJHLt4rdUshA8HfFukfEG/jKLHPq5SwJoq3IGw68+R6c8o/5Z2+qNZ7iVAstp588
         XEyEVSFBaA4h/0ZB8YVaVqfb6a8uNb/nyE/Aix0RYdGJS5yUpEURVv/kegrSh4mPtBKd
         RW4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793545048; x=1794149848;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=PGMqY+oZ0RvA46OKAo95DoA/lt7CWx4VsMgHlnaoQfk=;
        b=sCPHHqteedOu9fTjRRERUw8PwR7w++eXshBTtL7J1e6b+UAdAXDt6v2PjzjJ6sP1H+
         3iDin8CAa+MZKWhSHQYYkdImdTotrg8X13ZqNtLceiA9j4BjgQ2ZLQLgGOrNbYhf9kMS
         f8wPhrPqu6iSdwqxxaUI0iENZ0ujXhqRyKdE6Bf87g3dKyTMWTLL2A/P7X/V0Kwq6BF5
         wJr7nmhtdBt6rt2CJRW55lTOix1/qy+WsNOZJrB9FbSeMej6liaARPZhl+0YF/M4k04f
         V6J6iX6TL1KjNo8tsvY+b8UBuS678pm2I2acefFYAFUx72f+3NtaT13wCA5FWkyz44vn
         RyQA==
X-Forwarded-Encrypted: i=1; AKwUvBxDRd8IPiUFMOaST7jw2m1Wa3prrOw0zkCOaCxHWhFfFhkBzEXrDGTcVMfvJQ2ahD93bYOxwgOPy3ZiSYqofg==@lists.linux.dev
X-Gm-Message-State: AFq9FYJ64cvnsbIxiFxh+AKj207LeddQg6MaeXo8vxUJjYuZwuFvSgLe
	OfinqGg/oyKZe6etqIsPJ9s8h3Qz9DAG6iy1RdZ8cngW43xbfkQXLnkv
X-Gm-Gg: AYBFou1mKSsv2M3+F6aLQWuM9lOI6x8wCEtjHpdq4cXOJ9U4LghRaM7mQYaRfCxgw4F
	cCBxfN6XLEMH8IyzQjme4GFscryW4yTioQycZaTIFVnpMu1XAxkcJyAzjF8VkBxw55Vg3ji7N9M
	QRfplbz+J3wokANyvAmmK79fAbUCQkX+pXGFVwKUw7+loGiFVrfte/4iMpQ9n6iVoYUaMQy2F0O
	FI7OKzaH6rrfiph8lQLERMM9x2jgipYHhG3pUQQ8N4Nu04kLeFXsHNIhn2MGCdYClK9EqIbuEQN
	GQt+patMRf/FYS5ZEHaphSb83Y/8Euau+hLewMFnwLMfexSg3yxaS65nIUwMwP1cFQ0vk3KfszY
	LKvatZQXVO/owGxYQybaUIa6rOTrmXdUwIqR7dsnL09ZK3+95hqAfN+qz6nWtjfVOWgJNslI3LN
	BUfbRAz+ZR3by1NKUM/CTNdo36lE1VmKiu1tGYha0TFLnTGEUiVn/Z5/fFPyAIJbP1OAitlZxmI
	Xebi+zKWndHPp8EvlEEzBPidecsvPDB5Y94PlbTLzwIUxXExk3ac7GVfAiZkinZQ6f2ujELKSUn
	yCzD9GCyt4UoLw+S27phR8jsEhxZ38d4Cwl0HVXZiIxOsr+whDyqlFrzqfk/xzgw8FaWo5IbgYU
	AX2CW5W5ZlYN2xhAllPK6/W7HXvonpne9bcapLxteyN8d8qWugWfRzsgwS8WroE5huGQ7
X-Received: by 2002:a05:6102:5709:b0:7c1:f530:2d8e with SMTP id ada2fe7eead31-7d072d33bbemr3289437137.35.1793545047921;
        Sun, 01 Nov 2026 06:57:27 -0800 (PST)
Received: from gmail.com (111.46.245.35.bc.googleusercontent.com. [35.245.46.111])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-992edfb5511sm9722277241.0.2026.11.01.06.57.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Nov 2026 06:57:27 -0800 (PST)
Date: Sun, 01 Nov 2026 09:57:26 -0500
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Steffen Trumtrar <s.trumtrar@pengutronix.de>, 
 "Michael S. Tsirkin" <mst@redhat.com>, 
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
 "David S. Miller" <davem@davemloft.net>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, 
 Richard Cochran <richardcochran@gmail.com>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 =?UTF-8?B?RXVnZW5pbyBQw6lyZXo=?= <eperezma@redhat.com>, 
 Jason Wang <jasowangio@gmail.com>, 
 Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, 
 Jesper Dangaard Brouer <hawk@kernel.org>, 
 John Fastabend <john.fastabend@gmail.com>, 
 Stanislav Fomichev <sdf@fomichev.me>, 
 Eric Dumazet <edumazet@kernel.org>
Cc: Steffen Trumtrar <s.trumtrar@pengutronix.de>, 
 virtualization@lists.linux.dev, 
 netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 bpf@vger.kernel.org, 
 kvm@vger.kernel.org
Message-ID: <willemdebruijn.kernel.1d6388f036c46@gmail.com>
In-Reply-To: <20261026-v6-7-topic-virtio-net-ptp-v4-0-008af03cd43b@pengutronix.de>
References: <20261026-v6-7-topic-virtio-net-ptp-v4-0-008af03cd43b@pengutronix.de>
Subject: Re: [PATCH RFC v4 0/6] virtio-net: add receive timestamp support
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

Steffen Trumtrar wrote:
> This series picks up Willem de Bruijn's work on a virtio-net receive
> timestamp. The device puts the time of arrival (TAI, ns) into the
> virtio-net header so the guest can use it for PTP and RTT estimation
> without taking the timestamp itself after the host-to-guest latency.
> =

> The series is an RFC. I am mostly interested in feedback on the
> approach and on the wire format:

At a high level +1 from me.

Some comments inline.
> =

>  - The timestamp is a new field at the end of virtio_net_common_hdr
>    after outer_nh_offset and ipsec, offset 32 (see virtio spec),
>    negotiated with VIRTIO_NET_F_RX_TSTAMP (bit 49). Header size now 40
>    bytes.
>    Willem noted on v3 that virtio_net_common_hdr was not meant to be
>    extended this way; I kept it as the simplest approach, but a
>    separate struct for the timestamp header is an option.
>  - Timestamping is enabled at runtime with SIOCSHWTSTAMP; all
>    supported rx filters behave the same for now.
>  - XDP programs can read the timestamp with
>    bpf_xdp_metadata_rx_timestamp().
>  - vhost-net passes the feature through; the timestamp itself is
>    written by tun. The tun patch is only meant as a reference
>    implementation for the device side.
>  - The timestamp is in TAI.

Is this a requirement? It is common for PHCs to be synced to TAI,
but not 100% the case. Does virtio need to specify this.

>    The driver reports it as
>    SOF_TIMESTAMPING_RAW_HARDWARE without a PTP clock (phc_index -1),
>    so userspace cannot tell which clock it refers to and may compare
>    it against CLOCK_REALTIME (currently off by 37s). Options I see:
>    convert to the guest's system time in the driver (correct only if
>    host and guest agree on the TAI offset), expose a PHC so the
>    time base is explicit, or keep the raw TAI value and leave the
>    conversion to userspace. Which one is preferred?
>  - Like the existing rx_hash, the XDP timestamp callback locates the
>    header relative to xdp->data, so it must be called before
>    bpf_xdp_adjust_head().
> =

> A virtio spec change is needed as well and not yet proposed.
> =

> Testing: the feature needs a QEMU that knows VIRTIO_NET_F_RX_TSTAMP and=

> sets the matching vnet header size; see
> https://github.com/strumtrar/qemu/tree/v11.0.1/virtio-rx-stamps
> =

> Performance: I measured the receive rate with 64 byte UDP packets in
> a nested QEMU/KVM setup with vhost-net. The variance between runs is
> larger than any difference between the variants (without the series,
> series without the feature, feature negotiated, feature enabled), so
> I cannot show a measurable cost or the absence of one. Numbers from
> bare metal will follow with a non-RFC version.

This does not seem performance sensitive to me. And it is opt-in.
IMHO no need for extensive testing for performance regressions.


> Signed-off-by: Steffen Trumtrar <s.trumtrar@pengutronix.de>
> ---
> Changes in v4:
> - zero the header beyond the known fields on tx and in vhost
> - grow padded_vnet_hdr for the 40 byte header (big packets)
> - install xdp_metadata_ops if only RX_TSTAMP is negotiated
> - rename VIRTIO_NET_F_TSTAMP to VIRTIO_NET_F_RX_TSTAMP
> - move tstamp to offset 32 (header size 40) to match virtio spec layout=

> - drop XDP restriction for SIOCSHWTSTAMP, add xmo_rx_timestamp
> - add static_asserts for header sizes
> - add support in vhost
> - move virtio_net_common_hdr to virtio_net.h
> - Link to v3: https://patch.msgid.link/20260921-v6-7-topic-virtio-net-p=
tp-v3-0-3350851c4f88@pengutronix.de
> Changes in v3:
> - rework to use virtio_net_common_hdr instead of adding new struct
> Changes in v2:
> - rework patches to use flow filter instead of feature flag
> - Link to v1: https://lore.kernel.org/r/20231218-v6-7-topic-virtio-net-=
ptp-v1-0-cac92b2d8532@pengutronix.de
> =

> To: Michael S. Tsirkin <mst@redhat.com>
> To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> To: David S. Miller <davem@davemloft.net>
> To: Jakub Kicinski <kuba@kernel.org>
> To: Paolo Abeni <pabeni@redhat.com>
> To: Richard Cochran <richardcochran@gmail.com>
> To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
> To: Andrew Lunn <andrew+netdev@lunn.ch>
> To: Eugenio P=C3=A9rez <eperezma@redhat.com>
> To: Jason Wang <jasowangio@gmail.com>
> To: Alexei Starovoitov <ast@kernel.org>
> To: Daniel Borkmann <daniel@iogearbox.net>
> To: Jesper Dangaard Brouer <hawk@kernel.org>
> To: John Fastabend <john.fastabend@gmail.com>
> To: Stanislav Fomichev <sdf@fomichev.me>
> To: Eric Dumazet <edumazet@kernel.org>
> Cc: virtualization@lists.linux.dev
> Cc: netdev@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Cc: bpf@vger.kernel.org
> Cc: kvm@vger.kernel.org
> =

> ---
> Steffen Trumtrar (6):
>       virtio-net: move virtio_net_common_hdr to virtio_net.h
>       virtio-net: support receive timestamp
>       virtio-net: assert header sizes
>       vhost-net: support VIRTIO_NET_F_RX_TSTAMP
>       virtio-net: add XDP rx timestamp metadata
>       tun: add rx timestamp to the vnet header
> =

>  drivers/net/tun.c               |  14 ++--
>  drivers/net/tun_vnet.h          |  18 +++--
>  drivers/net/virtio_net.c        | 171 ++++++++++++++++++++++++++++++++=
++------
>  drivers/vhost/net.c             |  17 +++-
>  include/linux/virtio_net.h      |  30 +++++++
>  include/uapi/linux/virtio_net.h |   1 +
>  6 files changed, 214 insertions(+), 37 deletions(-)
> ---
> base-commit: c03c1a14507dfaf8b856c2608f9ac216021fc222
> change-id: 20231218-v6-7-topic-virtio-net-ptp-3df023bc4f4d
> =

> Best regards,
> --  =

> Steffen Trumtrar <s.trumtrar@pengutronix.de>
> =



