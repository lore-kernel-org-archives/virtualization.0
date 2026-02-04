Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31BD534B691
	for <virtualization@lists.linux.dev>; Wed,  4 Feb 2026 17:56:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770227762; cv=none; b=Hv4eZBMEKXMX6cteemNbpiZ2qH1nesdhVjOcIlwztfhQgquHNlRl1KmMIvnKBZzHfgSmwZeNnPiFnttUA5ILjAEaEF+/+scYp7kc9cGSbmU7ZuMiZY9V0CrYHxX2qNkWViU2OTPP9Omy5vn4NRlxlEHLqe1LnmFrxZPgKi2aYAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770227762; c=relaxed/simple;
	bh=Wrs8v3Ibl/2UVhDWKQ0wbPiQLOnTpSRd8XznyUqhHLY=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=JVU1v5vvK+5rg83wV3rwM152arRbY5tquXhCv2dYXKY5wd4J/xfSkKMEU8ULqSZWhqpeAnOgjhLTUs9E1HSCb2FGhP83810EtRehK43xVHStWkyh3vyDa86TNTlbNdhS29njb0G/Lgrop0NkQ+rFJHsa1hazMdfgYgLwQQ/ey1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=klcfVZaJ; arc=none smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="klcfVZaJ"
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-7948e902fadso219257b3.1
        for <virtualization@lists.linux.dev>; Wed, 04 Feb 2026 09:56:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770227761; x=1770832561; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N/QoYdN54LYW2mp+h4jl0HE9exyW7dgtn+9C6PPxWXs=;
        b=klcfVZaJpSc3dzi9Mzn309blodjUUbPFI6hxB2I+bkpwoOHtjm6ZzVv12C5zHqJixg
         RKt7YnRLWB4i8aeMY46kB64S0YZaBsgk3Cc+ZQKPrnlZQOWlqCmeT2mUcLATzDyR37x4
         6COjwZLKUq/yYR3VuQbvak47y/jE46AUACVxbPjnFvajPXO6NIsUFykR50oVXaoGg/LC
         qMOdJgeFAHTkX1LPgx7qwqDykQpXdGDMKs8VCqHO59kVqBXapnWYWAVuf064j0WwwrYZ
         NsZhgJlaVEN+JzXROX2Ni8Ws/8ddRTs5x0BObnMx512pmF9sX461BFkz3M/OjOXoOJpm
         vdZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770227761; x=1770832561;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=N/QoYdN54LYW2mp+h4jl0HE9exyW7dgtn+9C6PPxWXs=;
        b=EMZ85gMlPs6DL3wzSsvOWcSNA3ClBXg6TQah+Jxfj8GRuEvBs/i9Bt7TftEb2gC87t
         XxVJqBGinjConmVczZkFwnT3jdQEAX2jXyXE/BiazdfYVDdz4A/U4HeTPNzXBMjvzu+Q
         nJhIZmBwL1l5+yq1K5sJg15kd/JrsjcM5wKY51gOs4j7b3DYw/dNsTernvWhBz5KFVUF
         TCImrcFXNz5xHtBXBwN4Kucy/GqeAjcgOqGmQXBGsbQTSa2f0UmDa79naghOT2rLh9Aq
         ZCuc4AyV1bXyyAa0kVvQOfNHwWW5AiILmxv3E1scIiJ5wmY6YLNG0A8aWJ7dGeL4iUlz
         mqoQ==
X-Forwarded-Encrypted: i=1; AJvYcCVphHGGLBZZc3xsNs0TsqrPMb1bPS7ogXFD4k6Rlst1H8dedxPXUeHWeopic2u2xI/TlsYK0a/dmk+O8fY69g==@lists.linux.dev
X-Gm-Message-State: AOJu0YyaETYLsS0nEIYfNU06Oj98vk4vSvfTij3ge0l78gY74jiW7M7l
	igBUEaSJ3R1Gt7gBCqttikdBGcKvOQZWkOp9OZkJioJa454XxpBSHxxI
X-Gm-Gg: AZuq6aIvFJrdayN4JitQY1JzCV3zsh5KNJKL8EqxEpSzv6gaePXKmR/JhxmgLsqT9/a
	zrSYBgP1z50woVNzlBaM/4Nu6SuEEnpZSIzhQp+yCIA/FcsvSHovOWsBmodaoORSBmTvT8ebKT3
	m7d70Hgl2izpN+e7J3MOPjnZny6TD2+x72XrMReRfs2LhFfJU2wArFg7/nMzLub6+7qqUz6izV5
	XizKpoaPR2MbGnRqRgkLmNDwfOgwS/h9GxGeEEcn2Vtfx/X6Ce2nZHGTghDw+hHv5VH2eNfKv5b
	VrshzRmXRyGuQYyheRaevxK+mXhxybJE00OHhFW98HLpl1rdAqCTxu8mLCd1AWQ1/y9iEgkC1P3
	6f1Q/WDz7Luj75DcoL27TuCCfFYtH1UyhrpC/bF1FKlyJLxBGSeacpFCtgKPyxQLg4NK6z1Fr4i
	8EK7HKkU3nl+HGJcdjdXbg7Rx55xm8AJA9IvYWGV3goHswTwH1xjrwHWrGC+0=
X-Received: by 2002:a05:690c:e3cb:b0:794:fb91:9221 with SMTP id 00721157ae682-794fe7d208cmr36871737b3.56.1770227761009;
        Wed, 04 Feb 2026 09:56:01 -0800 (PST)
Received: from gmail.com (21.33.48.34.bc.googleusercontent.com. [34.48.33.21])
        by smtp.gmail.com with UTF8SMTPSA id 00721157ae682-794feeaefaesm26690287b3.20.2026.02.04.09.56.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Feb 2026 09:56:00 -0800 (PST)
Date: Wed, 04 Feb 2026 12:55:59 -0500
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Jason Wang <jasowang@redhat.com>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: Steffen Trumtrar <s.trumtrar@pengutronix.de>, 
 "Michael S. Tsirkin" <mst@redhat.com>, 
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
 "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, 
 Richard Cochran <richardcochran@gmail.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 =?UTF-8?B?RXVnZW5pbyBQw6lyZXo=?= <eperezma@redhat.com>, 
 virtualization@lists.linux.dev, 
 netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org
Message-ID: <willemdebruijn.kernel.302a7f5489992@gmail.com>
In-Reply-To: <CACGkMEsqobRMhtz3LUuWu3O1njK9jU7oQ65OOyy9vHcZ_QLz4A@mail.gmail.com>
References: <20260129-v6-7-topic-virtio-net-ptp-v2-0-30a27dc52760@pengutronix.de>
 <20260129-v6-7-topic-virtio-net-ptp-v2-2-30a27dc52760@pengutronix.de>
 <willemdebruijn.kernel.37516e24f10fa@gmail.com>
 <CACGkMEsqobRMhtz3LUuWu3O1njK9jU7oQ65OOyy9vHcZ_QLz4A@mail.gmail.com>
Subject: Re: [PATCH RFC v2 2/2] virtio-net: support receive timestamp
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

Jason Wang wrote:
> On Mon, Feb 2, 2026 at 5:06=E2=80=AFAM Willem de Bruijn
> <willemdebruijn.kernel@gmail.com> wrote:
> >
> > Steffen Trumtrar wrote:
> > > Add optional hardware rx timestamp offload for virtio-net.
> > >
> > > Introduce virtio feature VIRTIO_NET_F_TSTAMP. If negotiated, the
> > > virtio-net header is expanded with room for a timestamp.
> > >
> > > To get and set the hwtstamp the functions ndo_hwtstamp_set/get need=

> > > to be implemented. This allows filtering the packets and only time =
stamp
> > > the packets where the filter matches. This way, the timestamping ca=
n
> > > be en/disabled at runtime.
> > >
> > > Tested:
> > >   guest: ./timestamping eth0 \
> > >           SOF_TIMESTAMPING_RAW_HARDWARE \
> > >           SOF_TIMESTAMPING_RX_HARDWARE
> > >   host: nc -4 -u 192.168.1.1 319
> > >
> > > Signed-off-by: Steffen Trumtrar <s.trumtrar@pengutronix.de>
> > >
> > > --
> > >   Changes to last version:
> > >   - rework series to use flow filters
> > >   - add new struct virtio_net_hdr_v1_hash_tunnel_ts
> > >   - original work done by: Willem de Bruijn <willemb@google.com>
> > > ---
> > >  drivers/net/virtio_net.c        | 136 ++++++++++++++++++++++++++++=
++++++++----
> > >  include/uapi/linux/virtio_net.h |   9 +++
> > >  2 files changed, 133 insertions(+), 12 deletions(-)
> > >
> > > diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> > > index 1bb3aeca66c6e..4e8d9b20c1b34 100644
> > > --- a/drivers/net/virtio_net.c
> > > +++ b/drivers/net/virtio_net.c
> > > @@ -429,6 +429,9 @@ struct virtnet_info {
> > >       struct virtio_net_rss_config_trailer rss_trailer;
> > >       u8 rss_hash_key_data[VIRTIO_NET_RSS_MAX_KEY_SIZE];
> > >
> > > +     /* Device passes time stamps from the driver */
> > > +     bool has_tstamp;
> > > +
> > >       /* Has control virtqueue */
> > >       bool has_cvq;
> > >
> > > @@ -475,6 +478,8 @@ struct virtnet_info {
> > >
> > >       struct control_buf *ctrl;
> > >
> > > +     struct kernel_hwtstamp_config tstamp_config;
> > > +
> > >       /* Ethtool settings */
> > >       u8 duplex;
> > >       u32 speed;
> > > @@ -511,6 +516,7 @@ struct virtio_net_common_hdr {
> > >               struct virtio_net_hdr_mrg_rxbuf mrg_hdr;
> > >               struct virtio_net_hdr_v1_hash hash_v1_hdr;
> > >               struct virtio_net_hdr_v1_hash_tunnel tnl_hdr;
> > > +             struct virtio_net_hdr_v1_hash_tunnel_ts ts_hdr;
> >
> > Jason, Michael: creating a new struct for every field is not very
> > elegant. Is it time to find a more forward looking approach to
> > expanding with new fields? Like a TLV, or how netlink structs like
> > tcp_info are extended with support for legacy users that only use
> > a truncated struct?
> =

> I fully agree, we need somebody to work on this.

Great. I'll take a look when I have some time.

The current approach infers struct virtio_net_hdr_$VARIANT size from
negotiated features:

- virtio_net: virtio_has_feature
- vhost_net: virtio_features_test_bit
- tun: tun_vnet_parse_size

Tuntap however also explicitly negotiates length with TUNSETVNETHDRSZ.

If we create a struct virtio_net_hdr_ext that can be continuously
extended going forward, the host and guest will have to negotiate the
length they both understand, and agree to the min of the two.

We could use that to implicitly negotiate supported features. E.g.,
if len is sizeof(virtio_net_hdr_v1_hash_tunnel) then these features
are supported:

VIRTIO_NET_F_GUEST_UDP_TUNNEL_GSO
VIRTIO_NET_F_HOST_UDP_TUNNEL_GSO
VIRTIO_NET_F_HASH_REPORT
etc.

But that would mean that all features up to the length have to be
supported, no gaps. I think that is probably not preferable? So then
they still need to negotiate features, as well as length. Does virtio
have a mechanism to negotiate not boolean feature enable/disable but
integers such as struct length?

Else the change will probably be simpler: keep existing negotiation,
only change the code to once define a struct and keep adding fields.
Rather than defining new structs with each feature and updating many
function arguments and variables to switch to the new struct type.

Again, for that see as example struct tcp_info, which is UAPI, but has
been extended many times.=
