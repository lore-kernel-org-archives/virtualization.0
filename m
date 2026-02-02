Received: from mail-yx1-f45.google.com (mail-yx1-f45.google.com [74.125.224.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EB0B3876A0
	for <virtualization@lists.linux.dev>; Mon,  2 Feb 2026 17:40:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770054040; cv=none; b=WL5kZrda6RO6e/j9xn6nnUScHSC8zOTjkKe1+aVgSkxzXJlaX3HbWdGkgSqQZbGTdEFAdhRR/Rw/b6/pW1YFPlbiURxU4t6tQodLMwZU8HXFBCuO+oibseZJKjT5mP72dRIoXHkBsEVkuZxYUz0wD+xSHAiHubommTOjuFX+hnk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770054040; c=relaxed/simple;
	bh=VRCx+c4hexJbmDKx+kICIYWJ1xdiJDc4rP2eOiSEuIU=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=kMRo6Zp2poR7k1swYteDucdXsAj8wqfOUwSSCqrgTwnr2FE8IXyV3am+YkLeDO3QGXXBgALomb9U6hMwSr9WtvKcLbzyezpbmAt4vz+KrPi1a3oqIucpcpvLQJa1k7yDFJ/RMMv+xF/+MJiEEmTKyJTGdl6xKDUeUxs84p/PEpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bk+Dm4k8; arc=none smtp.client-ip=74.125.224.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bk+Dm4k8"
Received: by mail-yx1-f45.google.com with SMTP id 956f58d0204a3-64942ebf1a3so4283551d50.3
        for <virtualization@lists.linux.dev>; Mon, 02 Feb 2026 09:40:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770054037; x=1770658837; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Lr0owY/HcJsxUU3YNVxCg49UjG1nqp/rA/XqNsApWS4=;
        b=bk+Dm4k8L8mXp+ZjAK0mhiygblxx8zLVms7bZ6FG8XYxhGnl6VLwx7J73vFpIq77GG
         ma2fO5hal7ngRJ3rBhVCQVExWhJblejg4gUBr41GC7Dal3FBBeyw6ZMr5E+uqfKUYwUt
         EJIRUcrv4jbXo322AoVPaowXjBJ1Dm70cfg3gffIbO30c7uI3iqEdayscqZP+1Aiqxpo
         e1Oz3fihhEnlufptMaQLU1hJAhUmODT4xv4I2kcltYXEy9D8zTXuHAklDEmIALb6Ya6g
         g5IWvprU9ochs1Jequ/YMVtblEtUDU1GLJzIkpSQr/6BaMIkB+6I9krS3OB/StKo4Uop
         yTgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770054037; x=1770658837;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Lr0owY/HcJsxUU3YNVxCg49UjG1nqp/rA/XqNsApWS4=;
        b=IBHIHFhITiV9rRZyCdYIKK/og2Y2mvG+Nwzkf3BGsganIV6T6kYcYZY8jxoAQI8IC/
         rO+/++304HrDVp8d65e2TJKrgEih3otxtm2Y/0AdM9+OYsRJQnM3a0FSnSTPijT2Ojba
         JN9Yr0h9unAvP6Ge0E8g/DK+haWaSSGogrVtQ6QCnXmgxR04fY9IZkrL6YXiPWJmbQo9
         khBqGWiEcJSHQkGBCjlVjdsB4S048k4dMs/8wfTQBapRUpMyD28I5335Kx4zzljqA7ql
         snz59xfzNO6uIhl4znhRULmM+/VqVGTXuwI06z7b6wI1Phk0nDAZNcQvpFFnlzoIZrFl
         9HTg==
X-Forwarded-Encrypted: i=1; AJvYcCUW5i/l++E6IHyS7C0M9/HPhk8Prrs9aePqYiMduMIA3OITANWNFRX21/Uw5cIZtLnGfLYaG17YOxPS7AkLBg==@lists.linux.dev
X-Gm-Message-State: AOJu0YxKtVNw0pvvNYpa1UjlZ/o5JEMHi4r1LfirU+HtisvhPdm1/EpO
	A1vBZcDCpOwmv6xwxSwOX9/lu9AjGaUf3h1PAfIZpPMGTrdBTYdyQkz8
X-Gm-Gg: AZuq6aKE06fQJIIjeQWE7LrlM1X4wMigd7cTnFH1DsL16LHBHoSQ72RC+Y9Y/el6WcJ
	aaZc7oQeqaX6Ye1fMKkarqMu291uolW9MV27GA6dIUAScITT55whfYPu83wmnCBL4JDnej/0Ik5
	HQo/k/ShJN7Y9MBZez2q9ovQ1kU0CaFoe/EmlCb52C9iG59aapKKV5mYnbjj27VqBsqP2rRq9AY
	NV1nf+O9mpsBStd31vAB6SY1xc+eTj40k26QX0AFA0gsGNMHV5I3Jzf28cyRt/+zSHqZBYwr/mi
	VhbxhBmyX8XgRc5AKOB7jpY01HMqXhLIXKJcMWfN1UfuIkTxD8zqE1zk0DZN0lD/9lKze+Je31w
	SUtTvDbPfkRadCn4lMVvAUhZSIuhzilJKcoLJIypDrayZUHIlBsphc252BpUzTt+rlvbu7QIAPi
	mvUtT2Yh62eHHvS5Ak2QGxfySBouwBJHmMZmWj4rIoQk90UbhmG2ZctbVhUsk=
X-Received: by 2002:a05:690e:c49:b0:649:66c5:74ec with SMTP id 956f58d0204a3-649a849ef90mr9532381d50.56.1770054037437;
        Mon, 02 Feb 2026 09:40:37 -0800 (PST)
Received: from gmail.com (21.33.48.34.bc.googleusercontent.com. [34.48.33.21])
        by smtp.gmail.com with UTF8SMTPSA id 956f58d0204a3-64996063a24sm9718869d50.5.2026.02.02.09.40.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Feb 2026 09:40:36 -0800 (PST)
Date: Mon, 02 Feb 2026 12:40:36 -0500
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: "Michael S. Tsirkin" <mst@redhat.com>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: Steffen Trumtrar <s.trumtrar@pengutronix.de>, 
 Jason Wang <jasowang@redhat.com>, 
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
Message-ID: <willemdebruijn.kernel.16b0979449c84@gmail.com>
In-Reply-To: <20260202025322-mutt-send-email-mst@kernel.org>
References: <20260129-v6-7-topic-virtio-net-ptp-v2-0-30a27dc52760@pengutronix.de>
 <20260129-v6-7-topic-virtio-net-ptp-v2-2-30a27dc52760@pengutronix.de>
 <willemdebruijn.kernel.37516e24f10fa@gmail.com>
 <20260202025322-mutt-send-email-mst@kernel.org>
Subject: Re: [PATCH RFC v2 2/2] virtio-net: support receive timestamp
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Michael S. Tsirkin wrote:
> On Sun, Feb 01, 2026 at 04:05:54PM -0500, Willem de Bruijn wrote:
> > Steffen Trumtrar wrote:
> > > Add optional hardware rx timestamp offload for virtio-net.
> > > 
> > > Introduce virtio feature VIRTIO_NET_F_TSTAMP. If negotiated, the
> > > virtio-net header is expanded with room for a timestamp.
> > > 
> > > To get and set the hwtstamp the functions ndo_hwtstamp_set/get need
> > > to be implemented. This allows filtering the packets and only time stamp
> > > the packets where the filter matches. This way, the timestamping can
> > > be en/disabled at runtime.
> > > 
> > > Tested:
> > >   guest: ./timestamping eth0 \
> > >           SOF_TIMESTAMPING_RAW_HARDWARE \
> > >           SOF_TIMESTAMPING_RX_HARDWARE
> > >   host: nc -4 -u 192.168.1.1 319
> > > 
> > > Signed-off-by: Steffen Trumtrar <s.trumtrar@pengutronix.de>

> > > @@ -475,6 +478,8 @@ struct virtnet_info {
> > >  
> > >  	struct control_buf *ctrl;
> > >  
> > > +	struct kernel_hwtstamp_config tstamp_config;
> > > +
> > >  	/* Ethtool settings */
> > >  	u8 duplex;
> > >  	u32 speed;
> > > @@ -511,6 +516,7 @@ struct virtio_net_common_hdr {
> > >  		struct virtio_net_hdr_mrg_rxbuf	mrg_hdr;
> > >  		struct virtio_net_hdr_v1_hash hash_v1_hdr;
> > >  		struct virtio_net_hdr_v1_hash_tunnel tnl_hdr;
> > > +		struct virtio_net_hdr_v1_hash_tunnel_ts ts_hdr;
> > 
> > Jason, Michael: creating a new struct for every field is not very
> > elegant. Is it time to find a more forward looking approach to
> > expanding with new fields? Like a TLV, or how netlink structs like
> > tcp_info are extended with support for legacy users that only use
> > a truncated struct?
> 
> I certainly wouldn't mind, though I suspect tlv is too complex as
> hardware implementations can't efficiently follow linked lists.  I'll
> try to ping some hardware designers for what works well for offloads.

Great thanks.

Agreed that TLV was probably the wrong suggestion.

We can definitely have a required order of fields. My initial thought
is as said like many user/kernel structures: where both sides agree on
the basic order of the struct, and pass along the length, so that they
agree only to process the min of both their supported lengths. New
fields are added at the tail of the struct. See for instance getsockopt
TCP_INFO.
