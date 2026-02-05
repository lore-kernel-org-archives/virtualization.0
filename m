Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9CD72BEC30
	for <virtualization@lists.linux.dev>; Thu,  5 Feb 2026 02:52:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770259961; cv=none; b=ut0uVQOe7jYVoXJbfwJEreZ4+nQYcGwiohk8KGmB7XXv8lctLgS4RGzt5NZZl8IGUDYZ6mHOGRwlpHMN8SZTm+A0vZqkwhkdBIgeLHFmPNHgl/94WtHV1qZe4fYc2XVckO+VMfFogCMIld4rK1Ue50sYRHrl28DPXq5ljClfb60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770259961; c=relaxed/simple;
	bh=SFxsix8N3tZ9wZkZUiCVZ5WxVG4k+p3CMehdG3exSl4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TS5LZ85W8ooLtupjLmXNncyqCM9ILqaeiYy/fzyGdCeaWe5v7dLGA08qeT2er8UWCSEgbt3XC0LnfF4zdYxPYk/o6FaUM8lBxnFaHByTYbw8+oFNRVZfe/i5nabnGLH8NyrpjBlTYz0DtD2Gjf/R0J1TmGTsmvS4ceWwtodywHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gZcwgHK9; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gZcwgHK9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1770259959;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QpIKSJSO3ObJk6nWSzgXQPDBc3nfYRy7QFNzxUTyPWk=;
	b=gZcwgHK9o2KDOTrcBKzGvHuunI696a19w8BEcYfK9ZeCa23RNUrAAKaWPsaq/KWEFQdk+n
	+Ju12SFjj/PGC0CQzAmCMgsO5K6rkcndgqbDbHs52Rxg9tLZI8VBrSbS48QPivgO+pS8xq
	QU/NpqvqcWxN7BNpdU+aGZUoIu9H/xs=
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-632-1qHpmBXAOsq66LiNT8DuyQ-1; Wed, 04 Feb 2026 21:52:38 -0500
X-MC-Unique: 1qHpmBXAOsq66LiNT8DuyQ-1
X-Mimecast-MFC-AGG-ID: 1qHpmBXAOsq66LiNT8DuyQ_1770259958
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-b5edecdf94eso1150038a12.2
        for <virtualization@lists.linux.dev>; Wed, 04 Feb 2026 18:52:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770259957; x=1770864757;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=QpIKSJSO3ObJk6nWSzgXQPDBc3nfYRy7QFNzxUTyPWk=;
        b=J4Yp9D+AeJ/EQOguquo5JOuBnF6B1mXfI/Ns00oWdH54mJO3vYS2Ic7ECOepUZDLEq
         xMYtq3lFmniBALDvuJdal/JoNc8OTLBI76Vm1GtdjvviwgJYVE1x/3RAxSDQzYlSj5Kx
         BWVSy4QYIatHCb6o+/i0nodjQ9vDNlCqRxQM4Ihyoa2jE4awYBcweeB5/N+GolGmNi6T
         e5Tq30PLPZuG+fN8RUe8vRBsOXbDlD/+B/RAIjKZ4Qyo5Sl/QD4dlRPv6KG/fJjDEzuk
         XiCYdt99YpbQvl/HJExh1zTp1cHQ3Pk/0636/WqHqGmuSG38p7713vqLqFvWuHOU2xZo
         AX2w==
X-Forwarded-Encrypted: i=1; AJvYcCUBQwHcmEJHpOXdmcApjiiBsQZG8tg7vvjmxDKIT8gJji1bkM3Goro+31+aBWbhEQgbLU7JS/f+0UatgpNNHg==@lists.linux.dev
X-Gm-Message-State: AOJu0Yz09QM4bW7pcMvctEunXgKfEQECj4k9laxpNAoIVkfZcXrhgOue
	0jhBpXSMXgT60YS31OmUHnJ6a4ofjix4BD4I9GymsBQf3MrIV6ZC56hdHKFocNGQqYqUaS7kXUz
	NvNRSdYYihpwQqz/2FcH9UT+OLtBwlK76D3Rdc3jeqVscoKwYolFe0wo9oECphsT/hC25iFotYX
	7gUlGcBmKsYWkYzxKIyIn9G7YpC5GiQd/LS2yYg+iHF7s=
X-Gm-Gg: AZuq6aI07SBfDMmZJhIkWCbrBDckPkX4aM+B6Ws2nRCMebpdPAFMSbrv6gkXsppps6q
	k38xqIyg55rI5cuESBvcZEjjuz56S0ANV3EgBpRa4G4G3Zva7PMeUcnL88N1Q5wb8WLeYZvE9fK
	8IpER5WI5ivtVsbZRmVl1WcXNbQtL3RX6ANUWb7fDcmlhCu3bugkqWIi7VBCw6ycicAg==
X-Received: by 2002:a05:6a21:6490:b0:38d:f226:49d2 with SMTP id adf61e73a8af0-39372119dc9mr5264223637.35.1770259957568;
        Wed, 04 Feb 2026 18:52:37 -0800 (PST)
X-Received: by 2002:a05:6a21:6490:b0:38d:f226:49d2 with SMTP id
 adf61e73a8af0-39372119dc9mr5264210637.35.1770259957165; Wed, 04 Feb 2026
 18:52:37 -0800 (PST)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260129-v6-7-topic-virtio-net-ptp-v2-0-30a27dc52760@pengutronix.de>
 <20260129-v6-7-topic-virtio-net-ptp-v2-2-30a27dc52760@pengutronix.de>
 <willemdebruijn.kernel.37516e24f10fa@gmail.com> <CACGkMEsqobRMhtz3LUuWu3O1njK9jU7oQ65OOyy9vHcZ_QLz4A@mail.gmail.com>
 <willemdebruijn.kernel.302a7f5489992@gmail.com> <20260204134257-mutt-send-email-mst@kernel.org>
In-Reply-To: <20260204134257-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 5 Feb 2026 10:52:22 +0800
X-Gm-Features: AZwV_QheVEsP5Y4RAFgv_O1W-jMjSmC4wlbqTv1DMlT9lfcD-74-qPxxWpVnIe0
Message-ID: <CACGkMEsP5bv2j5Fx7f3jL=F8oyzA2h_BQZyBZyhwy7DzQzB-SA@mail.gmail.com>
Subject: Re: [PATCH RFC v2 2/2] virtio-net: support receive timestamp
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
	Steffen Trumtrar <s.trumtrar@pengutronix.de>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Richard Cochran <richardcochran@gmail.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	=?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	virtualization@lists.linux.dev, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: xI6R1XcJmLRHbzwkX_Ws5N1Dg7ITjKI_4lTQagVNsNA_1770259958
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 5, 2026 at 2:44=E2=80=AFAM Michael S. Tsirkin <mst@redhat.com> =
wrote:
>
> On Wed, Feb 04, 2026 at 12:55:59PM -0500, Willem de Bruijn wrote:
> > Jason Wang wrote:
> > > On Mon, Feb 2, 2026 at 5:06=E2=80=AFAM Willem de Bruijn
> > > <willemdebruijn.kernel@gmail.com> wrote:
> > > >
> > > > Steffen Trumtrar wrote:
> > > > > Add optional hardware rx timestamp offload for virtio-net.
> > > > >
> > > > > Introduce virtio feature VIRTIO_NET_F_TSTAMP. If negotiated, the
> > > > > virtio-net header is expanded with room for a timestamp.
> > > > >
> > > > > To get and set the hwtstamp the functions ndo_hwtstamp_set/get ne=
ed
> > > > > to be implemented. This allows filtering the packets and only tim=
e stamp
> > > > > the packets where the filter matches. This way, the timestamping =
can
> > > > > be en/disabled at runtime.
> > > > >
> > > > > Tested:
> > > > >   guest: ./timestamping eth0 \
> > > > >           SOF_TIMESTAMPING_RAW_HARDWARE \
> > > > >           SOF_TIMESTAMPING_RX_HARDWARE
> > > > >   host: nc -4 -u 192.168.1.1 319
> > > > >
> > > > > Signed-off-by: Steffen Trumtrar <s.trumtrar@pengutronix.de>
> > > > >
> > > > > --
> > > > >   Changes to last version:
> > > > >   - rework series to use flow filters
> > > > >   - add new struct virtio_net_hdr_v1_hash_tunnel_ts
> > > > >   - original work done by: Willem de Bruijn <willemb@google.com>
> > > > > ---
> > > > >  drivers/net/virtio_net.c        | 136 ++++++++++++++++++++++++++=
++++++++++----
> > > > >  include/uapi/linux/virtio_net.h |   9 +++
> > > > >  2 files changed, 133 insertions(+), 12 deletions(-)
> > > > >
> > > > > diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> > > > > index 1bb3aeca66c6e..4e8d9b20c1b34 100644
> > > > > --- a/drivers/net/virtio_net.c
> > > > > +++ b/drivers/net/virtio_net.c
> > > > > @@ -429,6 +429,9 @@ struct virtnet_info {
> > > > >       struct virtio_net_rss_config_trailer rss_trailer;
> > > > >       u8 rss_hash_key_data[VIRTIO_NET_RSS_MAX_KEY_SIZE];
> > > > >
> > > > > +     /* Device passes time stamps from the driver */
> > > > > +     bool has_tstamp;
> > > > > +
> > > > >       /* Has control virtqueue */
> > > > >       bool has_cvq;
> > > > >
> > > > > @@ -475,6 +478,8 @@ struct virtnet_info {
> > > > >
> > > > >       struct control_buf *ctrl;
> > > > >
> > > > > +     struct kernel_hwtstamp_config tstamp_config;
> > > > > +
> > > > >       /* Ethtool settings */
> > > > >       u8 duplex;
> > > > >       u32 speed;
> > > > > @@ -511,6 +516,7 @@ struct virtio_net_common_hdr {
> > > > >               struct virtio_net_hdr_mrg_rxbuf mrg_hdr;
> > > > >               struct virtio_net_hdr_v1_hash hash_v1_hdr;
> > > > >               struct virtio_net_hdr_v1_hash_tunnel tnl_hdr;
> > > > > +             struct virtio_net_hdr_v1_hash_tunnel_ts ts_hdr;
> > > >
> > > > Jason, Michael: creating a new struct for every field is not very
> > > > elegant. Is it time to find a more forward looking approach to
> > > > expanding with new fields? Like a TLV, or how netlink structs like
> > > > tcp_info are extended with support for legacy users that only use
> > > > a truncated struct?
> > >
> > > I fully agree, we need somebody to work on this.
> >
> > Great. I'll take a look when I have some time.
> >
> > The current approach infers struct virtio_net_hdr_$VARIANT size from
> > negotiated features:
> >
> > - virtio_net: virtio_has_feature
> > - vhost_net: virtio_features_test_bit
> > - tun: tun_vnet_parse_size
> >
> > Tuntap however also explicitly negotiates length with TUNSETVNETHDRSZ.
> >
> > If we create a struct virtio_net_hdr_ext that can be continuously
> > extended going forward, the host and guest will have to negotiate the
> > length they both understand, and agree to the min of the two.
> >
> > We could use that to implicitly negotiate supported features. E.g.,
> > if len is sizeof(virtio_net_hdr_v1_hash_tunnel) then these features
> > are supported:
> >
> > VIRTIO_NET_F_GUEST_UDP_TUNNEL_GSO
> > VIRTIO_NET_F_HOST_UDP_TUNNEL_GSO
> > VIRTIO_NET_F_HASH_REPORT
> > etc.
> >
> > But that would mean that all features up to the length have to be
> > supported, no gaps. I think that is probably not preferable? So then
> > they still need to negotiate features, as well as length. Does virtio
> > have a mechanism to negotiate not boolean feature enable/disable but
> > integers such as struct length?

I think not.

> >
> > Else the change will probably be simpler: keep existing negotiation,
> > only change the code to once define a struct and keep adding fields.
> > Rather than defining new structs with each feature and updating many
> > function arguments and variables to switch to the new struct type.
>
> Right I am not sure why we keep doing this. Let's add a VLA at
> the end of the struct and declare fields can be added at will.
>
>
> > Again, for that see as example struct tcp_info, which is UAPI, but has
> > been extended many times.
>
>

Yes.

Thanks

> --
> MST
>

