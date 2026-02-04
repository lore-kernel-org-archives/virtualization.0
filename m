Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06DD2427A1C
	for <virtualization@lists.linux.dev>; Wed,  4 Feb 2026 18:44:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770230679; cv=none; b=SCUfIplAcTd5b1F0dmKCwzSfj/dQuJY0sdeNVs82pf+ENZaajmF5A+CjE0XWeTMVXPBvry362M59bTsdyuSVQ4uR/L8e1vTDXzh5VPJmQkLZiuThbhtDNb1hFflTJN7VKg0tH3yC3HVB2+XkPZ4I0M1jICipCOMUPJL4m/2NRok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770230679; c=relaxed/simple;
	bh=VqLIZNl8jmLGnUXe1BvwJtGoUSDpXd9EP4yjwpGKzII=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=VUXvauad2n2956i62gqgAMouCKSooUc9UsPsQm+wzG+yjq6uh5hLwLvrOnjMgV0eoeHY50+YSWViJ5FIib/z6AThziVTcQ8A9dTvFP9ZlvT4BviP2hl2yLNTBjq4nn7G8L0LzL04V6h5l/coZEE9xQR5yz0a4vkmWU4NGzAXaPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LsCbDJxs; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LsCbDJxs"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1770230678;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7Gcs4Ihi3YzOYzBM/idLTJIxE2q0BSxfyQSiUhfJOsk=;
	b=LsCbDJxsfR/KskTwIfPvN1z9Ea4CV9ibOfqhFT6pxPAzv0Uxay9X0VfM+siHpE6hGJU5Ua
	sUHM6Lt3L9lbBYnkuXcfDA2W4POAHJyOOho2YDzUbmyKApGjoo9enAjdsNiBgGC50PD0SD
	ydyb7vx3IJQqHl1mXxCYU+39dG/gVFU=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-252-cQEaUxjiNa2ueb7DZYhvdQ-1; Wed, 04 Feb 2026 13:44:35 -0500
X-MC-Unique: cQEaUxjiNa2ueb7DZYhvdQ-1
X-Mimecast-MFC-AGG-ID: cQEaUxjiNa2ueb7DZYhvdQ_1770230674
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-4801d21c280so919555e9.1
        for <virtualization@lists.linux.dev>; Wed, 04 Feb 2026 10:44:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770230674; x=1770835474;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7Gcs4Ihi3YzOYzBM/idLTJIxE2q0BSxfyQSiUhfJOsk=;
        b=wgcOgI8DT07s/SC4usOQ1vqGuhlkoRvKdC8clNRSgXK1qPqSFXBKBSylfe+eWNMpPO
         vnbZnXzDNyLheL2AdyRLzIc6ceWiMod+1/jDBn5FeQv8zvlgZzvvfv/N0EWYMIVr3A8X
         mlnEE8Qus0G75szev6yJg0x08I8s+BdgtPoWp95tlEeEOXPirtjHBZ/EtGE2FS9Sq3MT
         TZoaJwJt556q2JRvc/JCIQ1fK6gvwt91Q5XnUH65jUDUxQSZGeWNLvc4wzT7Z9tyWCSC
         L95zvLJm9RlaSQ74rXoVjPb0UCiw0C+bFIEB8NPS7mUibWrHbf+8gstm+4VXfttZiU6x
         YKwQ==
X-Forwarded-Encrypted: i=1; AJvYcCUFns9yUMMfwqzcJdtzODe456R4Wu2nS4jL83dAZJ7v5nAuKzcbU2mn/Wynkg0dp8BQAt2f3gE4zrBCSIlSHA==@lists.linux.dev
X-Gm-Message-State: AOJu0YzNIzh3BgA1Xk+FTlfS+PUW/y31WyMz31hiEM4qtpMxsv34aQ+n
	zhzoZ61jSWkBDwum20IdSqxvXbo/6QzDgD0Rcq5lFwiiUWBgDIzdkS3tB7q7p1ST6omulmaSjX5
	Z6T6SF5XEl8zp+IH1F5S9vir6gId7AbPWF6JSjmgqdA0tAbwfyrMEPmyW0rnagkP4OSbb
X-Gm-Gg: AZuq6aIMbVy6Z/pW7gr5p31VUBygd1w3Dy5w6ERvOfwO8PmL+sv90V7CPkllXdWju+4
	iS6xtqA0tWUIOgnp30PoNPRlZ5d7MVtJVuxsf+u7+g1G29umnupT0fT+5l2U51SSlYCfb/ndQQt
	u1a+68Ew+jgaiNDZnkeQm78O3XEk2x8LRa5TNxlm8Ed23ujqD2TjjM12Jcgl47BpS23wQ9tCzgN
	VNiiKa5m/F+GWYO+tNorkSLuINi80aI4jKW3WSRUXl6J2EwV4obANZPD7vPlahgCTkaUBW4InZY
	YBOeKFd58FLo0l3gHGqNmdnLVDQ5chFEQbS7PBZ+NICmEVw4ucRSX4bBdnfc7x5MmnR7PKesRPu
	s6zPBrBonf94/J4cJpL4vKc2H96+OH7SevQ==
X-Received: by 2002:a05:600c:674a:b0:477:73e9:dbe7 with SMTP id 5b1f17b1804b1-4830e986088mr53052165e9.35.1770230673584;
        Wed, 04 Feb 2026 10:44:33 -0800 (PST)
X-Received: by 2002:a05:600c:674a:b0:477:73e9:dbe7 with SMTP id 5b1f17b1804b1-4830e986088mr53051925e9.35.1770230673144;
        Wed, 04 Feb 2026 10:44:33 -0800 (PST)
Received: from redhat.com (IGLD-80-230-34-155.inter.net.il. [80.230.34.155])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48317d33eddsm3164835e9.4.2026.02.04.10.44.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Feb 2026 10:44:32 -0800 (PST)
Date: Wed, 4 Feb 2026 13:44:29 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: Jason Wang <jasowang@redhat.com>,
	Steffen Trumtrar <s.trumtrar@pengutronix.de>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	virtualization@lists.linux.dev, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC v2 2/2] virtio-net: support receive timestamp
Message-ID: <20260204134257-mutt-send-email-mst@kernel.org>
References: <20260129-v6-7-topic-virtio-net-ptp-v2-0-30a27dc52760@pengutronix.de>
 <20260129-v6-7-topic-virtio-net-ptp-v2-2-30a27dc52760@pengutronix.de>
 <willemdebruijn.kernel.37516e24f10fa@gmail.com>
 <CACGkMEsqobRMhtz3LUuWu3O1njK9jU7oQ65OOyy9vHcZ_QLz4A@mail.gmail.com>
 <willemdebruijn.kernel.302a7f5489992@gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <willemdebruijn.kernel.302a7f5489992@gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: ZheTR_TGjnr2iGMAoeA53BxlVKrETBzfwVbyiGGFfDo_1770230674
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Wed, Feb 04, 2026 at 12:55:59PM -0500, Willem de Bruijn wrote:
> Jason Wang wrote:
> > On Mon, Feb 2, 2026 at 5:06 AM Willem de Bruijn
> > <willemdebruijn.kernel@gmail.com> wrote:
> > >
> > > Steffen Trumtrar wrote:
> > > > Add optional hardware rx timestamp offload for virtio-net.
> > > >
> > > > Introduce virtio feature VIRTIO_NET_F_TSTAMP. If negotiated, the
> > > > virtio-net header is expanded with room for a timestamp.
> > > >
> > > > To get and set the hwtstamp the functions ndo_hwtstamp_set/get need
> > > > to be implemented. This allows filtering the packets and only time stamp
> > > > the packets where the filter matches. This way, the timestamping can
> > > > be en/disabled at runtime.
> > > >
> > > > Tested:
> > > >   guest: ./timestamping eth0 \
> > > >           SOF_TIMESTAMPING_RAW_HARDWARE \
> > > >           SOF_TIMESTAMPING_RX_HARDWARE
> > > >   host: nc -4 -u 192.168.1.1 319
> > > >
> > > > Signed-off-by: Steffen Trumtrar <s.trumtrar@pengutronix.de>
> > > >
> > > > --
> > > >   Changes to last version:
> > > >   - rework series to use flow filters
> > > >   - add new struct virtio_net_hdr_v1_hash_tunnel_ts
> > > >   - original work done by: Willem de Bruijn <willemb@google.com>
> > > > ---
> > > >  drivers/net/virtio_net.c        | 136 ++++++++++++++++++++++++++++++++++++----
> > > >  include/uapi/linux/virtio_net.h |   9 +++
> > > >  2 files changed, 133 insertions(+), 12 deletions(-)
> > > >
> > > > diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> > > > index 1bb3aeca66c6e..4e8d9b20c1b34 100644
> > > > --- a/drivers/net/virtio_net.c
> > > > +++ b/drivers/net/virtio_net.c
> > > > @@ -429,6 +429,9 @@ struct virtnet_info {
> > > >       struct virtio_net_rss_config_trailer rss_trailer;
> > > >       u8 rss_hash_key_data[VIRTIO_NET_RSS_MAX_KEY_SIZE];
> > > >
> > > > +     /* Device passes time stamps from the driver */
> > > > +     bool has_tstamp;
> > > > +
> > > >       /* Has control virtqueue */
> > > >       bool has_cvq;
> > > >
> > > > @@ -475,6 +478,8 @@ struct virtnet_info {
> > > >
> > > >       struct control_buf *ctrl;
> > > >
> > > > +     struct kernel_hwtstamp_config tstamp_config;
> > > > +
> > > >       /* Ethtool settings */
> > > >       u8 duplex;
> > > >       u32 speed;
> > > > @@ -511,6 +516,7 @@ struct virtio_net_common_hdr {
> > > >               struct virtio_net_hdr_mrg_rxbuf mrg_hdr;
> > > >               struct virtio_net_hdr_v1_hash hash_v1_hdr;
> > > >               struct virtio_net_hdr_v1_hash_tunnel tnl_hdr;
> > > > +             struct virtio_net_hdr_v1_hash_tunnel_ts ts_hdr;
> > >
> > > Jason, Michael: creating a new struct for every field is not very
> > > elegant. Is it time to find a more forward looking approach to
> > > expanding with new fields? Like a TLV, or how netlink structs like
> > > tcp_info are extended with support for legacy users that only use
> > > a truncated struct?
> > 
> > I fully agree, we need somebody to work on this.
> 
> Great. I'll take a look when I have some time.
> 
> The current approach infers struct virtio_net_hdr_$VARIANT size from
> negotiated features:
> 
> - virtio_net: virtio_has_feature
> - vhost_net: virtio_features_test_bit
> - tun: tun_vnet_parse_size
> 
> Tuntap however also explicitly negotiates length with TUNSETVNETHDRSZ.
> 
> If we create a struct virtio_net_hdr_ext that can be continuously
> extended going forward, the host and guest will have to negotiate the
> length they both understand, and agree to the min of the two.
> 
> We could use that to implicitly negotiate supported features. E.g.,
> if len is sizeof(virtio_net_hdr_v1_hash_tunnel) then these features
> are supported:
> 
> VIRTIO_NET_F_GUEST_UDP_TUNNEL_GSO
> VIRTIO_NET_F_HOST_UDP_TUNNEL_GSO
> VIRTIO_NET_F_HASH_REPORT
> etc.
> 
> But that would mean that all features up to the length have to be
> supported, no gaps. I think that is probably not preferable? So then
> they still need to negotiate features, as well as length. Does virtio
> have a mechanism to negotiate not boolean feature enable/disable but
> integers such as struct length?
> 
> Else the change will probably be simpler: keep existing negotiation,
> only change the code to once define a struct and keep adding fields.
> Rather than defining new structs with each feature and updating many
> function arguments and variables to switch to the new struct type.

Right I am not sure why we keep doing this. Let's add a VLA at
the end of the struct and declare fields can be added at will.


> Again, for that see as example struct tcp_info, which is UAPI, but has
> been extended many times.


-- 
MST

