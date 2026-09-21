Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F7B14A49B5;
	Mon, 21 Sep 2026 14:57:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790002643; cv=none; b=sSVAxrwQrscICDHDioscWI9yTC+2sl3KEh1LqvZhkAliMvG+xUqyDJo2CSl6kRgRoFJfgzlgHhTVhSCb10T1WfJaXq33AfdF+yDPHki5/12ijRBYShsKDzw/HZyntcn+Ogmt+nI5LfIQ/276uXaMNhYsTRBq9Sxuy9iKAIpQudo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790002643; c=relaxed/simple;
	bh=V7hH/x2g+kzPIPkAjPiUEdVxrGDoZLCkQ9RcFHB7aBM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=BZAYlEQoEt9Tw31ajjdqh7lP7NGelj+CWb7XgXHq0N9ZRAaNDGSZIFN6RXMP1+sNDp4MnefhkXok0A5tT+vTMM4HojxZs2eGet0R/yfw6Jti19vIFZK1rw3u6C6zCB0pI9bOiAQqtd9tKChcc8TLEHpHi8IQg+e+B/oVBe60XBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bl7KFB4Q; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bl7KFB4Q"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F4141F000FF;
	Mon, 21 Sep 2026 14:57:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790002634;
	bh=gT17G4nuRQeQGGc/erpzcQ/m2R9h+lB6HcPo9OiizCY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=bl7KFB4Q145SbGq91cVqKExgAWECLyYNIrEo6efofUbI12E8m4s8IcTvhkcl9EF2m
	 LHyRD9lEO/9bMuHIOoVvhmJ01dlt2SIvZisF9Xk8TwmptmFfureq5swoSIcQP11IBQ
	 tWqbTfas6bs6UBELL55MkHWEmmzmK0Pd5PnpcoO2yMtv9RzeHaIaf1tDbc+DFFgil3
	 sJJpok6oEj8OYgygpGsBaSfi+zqaGpzWRegQqRbnMHct1LpLXFH81aLabUqfCT45tV
	 J1mgdsPmIm83G2j/BvVhigzDurFe8spK1D4nTPdAAk7tOkHtEwqjN+uWbj3yzsGUWq
	 CKTT1eicczgZA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC v3 1/2] virtio-net: support receive timestamp
Reply-To: sashiko-reviews@lists.linux.dev
To: "Steffen Trumtrar" <s.trumtrar@pengutronix.de>
Cc: bpf@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio
 Perez" <eperezma@redhat.com>, virtualization@lists.linux.dev
In-Reply-To: <20260921-v6-7-topic-virtio-net-ptp-v3-1-3350851c4f88@pengutronix.de>
References: <20260921-v6-7-topic-virtio-net-ptp-v3-0-3350851c4f88@pengutronix.de>
 <20260921-v6-7-topic-virtio-net-ptp-v3-1-3350851c4f88@pengutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 21 Sep 2026 14:57:14 +0000
Message-Id: <20260921145714.8F4141F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [Critical] virtio-net: VIRTIO_NET_F_TSTAMP hardcodes header length to 32 =
bytes, corrupting packet data
- [High] virtio-net: enabling XDP silently drops active hardware timestamps
- [Medium] virtio-net: virtnet_hwtstamp_set silently ignores TX requests an=
d violates RX filter API
--

commit 15f4245460ab5be4391d81d6596e3464857cb226
Author: Steffen Trumtrar <s.trumtrar@pengutronix.de>

virtio-net: support receive timestamp

This commit adds optional hardware RX timestamp offload support for virtio-=
net
by introducing the VIRTIO_NET_F_TSTAMP feature. It expands the virtio-net
header and provides implementation for ndo_hwtstamp_set and get.

> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index e34c52d059d39..ef6238cb336b9 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -499,6 +505,8 @@ struct virtio_net_common_hdr {
>  		struct virtio_net_hdr_v1_hash hash_v1_hdr;
>  		struct virtio_net_hdr_v1_hash_tunnel tnl_hdr;
>  	};
> +
> +	__le16 tstamp[4];	/* 64-bit timestamp, 2-byte aligned */
>  };

[Severity: Critical]
Does appending tstamp after the union statically pin its offset to 24 bytes
(the size of virtio_net_hdr_v1_hash_tunnel)? If smaller headers are
negotiated, this layout does not appear to match the actual hardware format.

[ ... ]

> @@ -2590,6 +2619,9 @@ static void receive_buf(struct virtnet_info *vi, st=
ruct receive_queue *rq,
>  	if (unlikely(!skb))
>  		return;
> =20
> +	if (likely(skb) && likely(!vi->xdp_enabled) && READ_ONCE(vi->hwts_rx_en=
))
> +		virtnet_record_rx_tstamp(vi, skb);
> +
>  	virtnet_receive_done(vi, rq, skb, flags);
>  }

[Severity: High]
While virtnet_hwtstamp_set() prevents enabling hardware timestamps if XDP is
already loaded, does the reverse sequence leave the system in an inconsiste=
nt
state?

If a user enables hardware timestamping first, and then loads an XDP progra=
m,
virtnet_xdp_set() does not check vi->hwts_rx_en. Once vi->xdp_enabled becom=
es
true, receive_buf() will silently drop all hardware timestamps without
returning an error to userspace.

[ ... ]

> @@ -6212,6 +6268,61 @@ static void virtnet_tx_timeout(struct net_device *=
dev, unsigned int txqueue)
[ ... ]
> +static int virtnet_hwtstamp_set(struct net_device *dev,
> +				struct kernel_hwtstamp_config *config,
> +				struct netlink_ext_ack *extack)
> +{
> +	struct virtnet_info *vi =3D netdev_priv(dev);
> +
> +	if (!netif_running(dev))
> +		return -EINVAL;
> +
> +	if (!vi->has_tstamp)
> +		return -EOPNOTSUPP;
> +
> +	config->tx_type =3D HWTSTAMP_TX_OFF;

[Severity: Medium]
Since this overwrites the requested tx_type without returning an error code
like -ERANGE, will this silently drop TX timestamp requests and mislead
userspace applications into assuming their TX configuration was applied?

> +
> +	if (unlikely(vi->xdp_enabled))
> +		return -EOPNOTSUPP;
> +
> +	switch (config->rx_filter) {
> +	case HWTSTAMP_FILTER_NONE:
> +		WRITE_ONCE(vi->hwts_rx_en, false);
> +		break;
> +	case HWTSTAMP_FILTER_PTP_V1_L4_SYNC:
> +	case HWTSTAMP_FILTER_PTP_V1_L4_DELAY_REQ:
> +	case HWTSTAMP_FILTER_PTP_V2_L4_DELAY_REQ:
> +	case HWTSTAMP_FILTER_PTP_V2_L4_SYNC:
> +	case HWTSTAMP_FILTER_PTP_V2_EVENT:
> +		WRITE_ONCE(vi->hwts_rx_en, true);
> +		break;
> +	case HWTSTAMP_FILTER_ALL:
> +	default:
> +		config->rx_filter =3D HWTSTAMP_FILTER_NONE;
> +		return -ERANGE;
> +	}

[Severity: Medium]
When specific PTP RX filters are requested, the driver enables vi->hwts_rx_=
en,
and receive_buf() then unconditionally reads timestamps for all packets.

Since the driver effectively implements HWTSTAMP_FILTER_ALL semantics,
shouldn't it accept HWTSTAMP_FILTER_ALL and upgrade specific PTP filters to
it, rather than rejecting it with -ERANGE?

[ ... ]

> @@ -6922,6 +7038,12 @@ static int virtnet_probe(struct virtio_device *vde=
v)
>  	else
>  		vi->hdr_len =3D sizeof(struct virtio_net_hdr);
> =20
> +	if (vi->has_tstamp)
> +		vi->hdr_len =3D offsetof(struct virtio_net_common_hdr, tstamp) +
> +			      sizeof_field(struct virtio_net_common_hdr, tstamp);
> +

[Severity: Critical]
Does setting the header length to 32 bytes unconditionally here break the
dynamic header sizing for other feature combinations?

If a device negotiates VIRTIO_NET_F_TSTAMP and VIRTIO_NET_F_MRG_RXBUF but
not HASH or TUNNEL, the hardware sends a 20-byte header, but the driver now
assumes 32 bytes. Will this cause the receive path to consume 12 bytes of
payload as part of the header, and the transmit path to push 12 bytes of
padding into the device, leading to data corruption?

> +	vi->hwts_rx_en =3D false;
> +
>  	if (virtio_has_feature(vdev, VIRTIO_NET_F_GUEST_UDP_TUNNEL_GSO_CSUM))
>  		vi->rx_tnl_csum =3D true;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260921-v6-7-topic=
-virtio-net-ptp-v3-0-3350851c4f88@pengutronix.de?part=3D1
