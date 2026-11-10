Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794338595;
	b=inqBye+uc/hx+NxhMNiF06GeC5K6CuDs2RUYZ9oynmiaBV267tnuyS9Bg2FnFLn49IM5
	 qVvrfo64876YApEVYNgfap0Xm1hj/4SeGXadM/oaUX2VVWGFMn8/+yPkP3nYomWAagRxF
	 YZIbcGxZxg8/6Vf6k7xOZoorz0/cyhpoHO9VaWsJZvmlO6S24Br//iEwyz8ozFrISXP8W
	 HgBiY3+Ie9WDoEnTmkuvHFRcjRwQiZWyvOuD2za6xs6znisNDReORkj+6VWX19ptRb1WJ
	 Lp1/aWDfwy5gMZc5E+EnlUlWNFgGH1lSXSPjZ+PNyd+zesbyvzO5zcuDG4rMiN2+CgQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794338595;
	h=DMARC-Filter:Received:DKIM-Signature:From:To:Cc:Subject:In-Reply-To:
	 References:User-Agent:Date:Message-ID:MIME-Version:Content-Type;
	bh=iPKx18V270dl9l4OtB/Y/MxcQ9Z2Zk3biIxOyRYrkNI=;
	b=xEO6o++sz8RYS82V4QsMFCxgoV7EfG09waFUoyBUWz3NQbfNSD+7m9HbCA1WSYQhIp8n
	 KA6hszb7rdPonD3lKnu/L2KgYOxLdSPWRmRh/WWeZMgeiBrWpRX+RC2QC9wjT8hvy6GwR
	 pJLiRngOTHDpCQvhjrO2lg4wgsa3Qoq4kFxJMlFGuiQm4961DGTCWXfEoNyyWHihVCFpf
	 qCX6mndXQIoWf9kvqMAJOpsrqz2aotXSgyWnQItdW3kP/841l+0VXYBZJPPZFuy/p8DGQ
	 mrD/a+v5NV96kygZrXqSjavYNcHasoFabUUJvEA+2n2wJ5FHLSzdtHjHMcFrg8D6DqQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=pengutronix.de;
	spf=pass smtp.mailfrom=pengutronix.de;
	dkim=pass header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=ad2kTkaY;
	arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70452606A325
	for <virtualization@lists.linux.dev>; Tue, 10 Nov 2026 19:23:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 70452606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=ad2kTkaY
Received: from ratatoskr.pengutronix.de (unknown [IPv6:2a00:1f:f805:2b01:a03:2f4:308a:7b52])
	(Authenticated sender: str@pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id 62C69200912;
	Tue, 10 Nov 2026 20:23:07 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1794338587;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=iPKx18V270dl9l4OtB/Y/MxcQ9Z2Zk3biIxOyRYrkNI=;
	b=ad2kTkaY76tsMkTt+onWR5PN2aKA0XKobO4S8lvFuJok+4OvS3TNiT02awZnsn0LN7UnMl
	zEuj9RQPeQ/Ek2iWA+c+Tbnglyzcjtt1KWInsRHTLBv+fZC6wKfkHgLOo+n43brFpzAKCh
	mwjf0g1GKgO6QyN0NRLMsn0x+G7EdOqWU4paXBCvcSa+GIKO2JyWnhB3FsNrdzOiRWoaVF
	LrJg/8S0/Szi0KICni0p5/FiYFTM9Loif1FDPjyNNQV66jbnRa7H9RBPr6CXRItOfMP4S2
	N/m7gZ23QU6nss06fH2RawV+9J+Q6AdqjWDN32ST0JX7sZEppYuc0HS0DgAJaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1794338587;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=iPKx18V270dl9l4OtB/Y/MxcQ9Z2Zk3biIxOyRYrkNI=;
	b=DZhaii5FfLOmOJSKmF1ZdtDdw0FP+NcYWPZ87oXuBOT7oT51WkJ3e+pvWPSXDDGOqfVz7B
	0zGf0Cizh0awSB0MJmE1ZCbR+R8RbO+rmfPpqxyz+nBFgP6G0Ff4LbZPlHQreabSR43Phu
	aGaRIWQQ8T+OMJFAoTPjBvagS6g2vjyD2W6e03FBpLiHWPRCcFEakpdbhQ3BrMHPNGVYr6
	s4E7hJ84jKKOxyS0ViV9ItVCsyCaahSCiNSdHy5Nsf8qdkJ0Aus0qXV+jZXv1GZc6cBfm6
	XncupiZVOg9WhVzKhtr6kdQtlPBHARGroupu2ZeRz40f8hiXfBe6vBlaXpKAuw==
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1794338587; a=rsa-sha256;
	cv=none;
	b=Gv1TfpYWYNfgkfi+YH0dunOFKrJ9Ove7jvwVoYUyUJVUEY5dZoP4XPggYN8odgpD8XN8Zz
	3vroncbnCpIptWLEOkAgFDSIg9X+FhKwsnIAqkaaaSWvLWbgbIZNPvZtLdUh36RsNwl7xP
	X0S4uA0WR8otMcdCdgzS/x2ytzLGNcg/oJxqA1J4PGMG8NgTs7n4TbbCAzNsDYvEZrZ1D7
	h0iAM9EJ4bfFnktXSZ4bl+PdTeAVVXjlNSGjgwswtDpIdaGydsrm91HX01+LiGoU6a4nLD
	RbSEkS2BP+234M+rHpH4lQTLlhF1V4a46G2b6Fr461f2KCLC4/vAmy/QdPHNgw==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=str@pengutronix.de smtp.mailfrom=s.trumtrar@pengutronix.de
From: Steffen Trumtrar <s.trumtrar@pengutronix.de>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>,  Xuan Zhuo
 <xuanzhuo@linux.alibaba.com>,  "David S. Miller" <davem@davemloft.net>,
  Jakub Kicinski <kuba@kernel.org>,  Paolo Abeni <pabeni@redhat.com>,
  Richard Cochran <richardcochran@gmail.com>,  Andrew Lunn
 <andrew+netdev@lunn.ch>,  Eugenio =?utf-8?Q?P=C3=A9rez?=
 <eperezma@redhat.com>,  Jason Wang
 <jasowangio@gmail.com>,  Alexei Starovoitov <ast@kernel.org>,  Daniel
 Borkmann <daniel@iogearbox.net>,  Jesper Dangaard Brouer
 <hawk@kernel.org>,  John Fastabend <john.fastabend@gmail.com>,  Stanislav
 Fomichev <sdf@fomichev.me>,  Eric Dumazet <edumazet@kernel.org>,
  virtualization@lists.linux.dev,  netdev@vger.kernel.org,
  linux-kernel@vger.kernel.org,  bpf@vger.kernel.org,  kvm@vger.kernel.org
Subject: Re: [PATCH RFC v4 2/6] virtio-net: support receive timestamp
In-Reply-To: <willemdebruijn.kernel.2adf5c78ee0e8@gmail.com>
References: <20261026-v6-7-topic-virtio-net-ptp-v4-0-008af03cd43b@pengutronix.de>
	<20261026-v6-7-topic-virtio-net-ptp-v4-2-008af03cd43b@pengutronix.de>
	<willemdebruijn.kernel.2adf5c78ee0e8@gmail.com>
User-Agent: mu4e 1.14.3; emacs 31.1
Date: Tue, 10 Nov 2026 20:23:06 +0100
Message-ID: <87v764ze1x.fsf@pengutronix.de>
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain

On 2026-11-01 at 10:04 -05, Willem de Bruijn <willemdebruijn.kernel@gmail.com> wrote:

> Steffen Trumtrar wrote:
> > Add optional hardware rx timestamp offload for virtio-net.
> > 
> > Introduce the virtio feature VIRTIO_NET_F_RX_TSTAMP. If negotiated, the
> > virtio-net header grows by room for a 64 bit TAI timestamp (header
> > size 40 bytes), stored in struct virtio_net_common_hdr. The layout is
> > cumulative: the field is at the same offset whether or not the
> > features before it were negotiated. The fixed layout needs
> > VIRTIO_F_VERSION_1, so the feature is cleared without it.
> > 
> > Implement ndo_hwtstamp_get/set so the timestamping can be enabled
> > and disabled at runtime with SIOCSHWTSTAMP. The driver cannot filter
> > what the device timestamps, so any rx filter other than NONE becomes
> > ALL. The timestamp is read before the packet is handed to the XDP
> > program or the stack, and attached to the skb with skb_hwtstamps().
> > It is a raw TAI value; there is no PHC.
> > 
> > The header size is negotiated per device and also applies to
> > transmitted packets. On transmit, zero the header behind the fields
> > the driver fills in, so the device sees a zero tstamp and no stale
> > skb->cb or headroom bytes.
> > 
> > On receive in big packet mode, the header is placed in front of the
> > data in the first page. Grow padded_vnet_hdr to 48 bytes so the
> > 40 byte header still fits there.
> > 
> > Tested in a guest with a patched QEMU:
> >   guest: ./timestamping eth0 \
> >           SOF_TIMESTAMPING_RAW_HARDWARE \
> >           SOF_TIMESTAMPING_RX_HARDWARE
> >   host:  nc -4 -u 192.168.1.1 319
> > 
> > Based on work by Willem de Bruijn.
> > 
> > Signed-off-by: Steffen Trumtrar <s.trumtrar@pengutronix.de>
> > Assisted-by: Claude:claude-opus-5-5
> > ---
> >  drivers/net/virtio_net.c        | 136 +++++++++++++++++++++++++++++++++++-----
> >  include/linux/virtio_net.h      |  10 +++
> >  include/uapi/linux/virtio_net.h |   1 +
> >  3 files changed, 131 insertions(+), 16 deletions(-)
> > 
> > diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> > index 17d3e32eed9d6..23af10c613b48 100644
> > --- a/drivers/net/virtio_net.c
> > +++ b/drivers/net/virtio_net.c
> > @@ -20,6 +20,7 @@
> >  #include <linux/filter.h>
> >  #include <linux/kernel.h>
> >  #include <linux/dim.h>
> > +#include <linux/unaligned.h>
> >  #include <net/route.h>
> >  #include <net/xdp.h>
> >  #include <net/net_failover.h>
> > @@ -416,6 +417,12 @@ struct virtnet_info {
> >  	u32 rss_hash_types_supported;
> >  	u32 rss_hash_types_saved;
> >  
> > +	/* Device passes time stamps to the driver */
> > +	bool has_rx_tstamp;
> > +	bool hwts_rx_en;
> 
> nit: cryptic name. rx_tstamp_supported and rx_tstamp_enabled or so?

Sure, I'll rename them.

> > +
> > +	struct kernel_hwtstamp_config tstamp_config;
> > +
> >  	/* Has control virtqueue */
> >  	bool has_cvq;  
> 
> > +static int virtnet_get_ts_info(struct net_device *dev,
> > +			       struct kernel_ethtool_ts_info *info)
> > +{
> > +	struct virtnet_info *vi = netdev_priv(dev);
> > +
> > +	/* setup default software timestamp */
> > +	ethtool_op_get_ts_info(dev, info);
> > +
> > +	if (vi->has_rx_tstamp) {
> > +		info->so_timestamping |=
> > +			SOF_TIMESTAMPING_RX_HARDWARE |
> > +			SOF_TIMESTAMPING_RAW_HARDWARE;
> > +
> > +		info->tx_types = BIT(HWTSTAMP_TX_OFF);
> > +		info->rx_filters = BIT(HWTSTAMP_FILTER_NONE) |
> > +				   BIT(HWTSTAMP_FILTER_ALL);
> > +	}
> 
>     `ethtool_op_get_ts_info()` leaves `info->phc_index = -1`, which breaks Ethtool
>     Netlink `ETHTOOL_MSG_TSCONFIG_GET` and `ETHTOOL_MSG_TSCONFIG_SET`
>     (`ethtool --show-hwtstamp-cfg` / `--set-hwtstamp-cfg`): `tsconfig_prepare_data()`
>     in `net/ethtool/tsconfig.c` rejects `ts_info.phc_index == -1` with `-ENODEV`.
> 
>     Either `net/ethtool/tsconfig.c` must be taught to allow PHC-less `ndo_hwtstamp_*`
>     drivers, or the device needs an associated PHC (e.g. `virtio_rtc`).
>

Right. (explanation mostly for myself to understand the problem)
The PHC-less case looks easy to allow in tsconfig: tsconfig_reply_size()
and tsconfig_fill_reply() already leave out
ETHTOOL_A_TSCONFIG_HWTSTAMP_PROVIDER when the index is -1, only
tsconfig_prepare_data() refuses it with -ENODEV.

For TSCONFIG_SET it is worse than for GET: ethnl_set_tsconfig() calls
dev_set_hwtstamp_phylib(), so the driver's ndo_hwtstamp_set() has
already applied the config, and only then tsconfig_send_reply() fails
in tsconfig_prepare_data(). Userspace gets -ENODEV although
timestamping is now on.

virtio-net is not the only one there: ngbe/txgbe (libwx) report
hardware timestamping with phc_index -1 if CONFIG_PTP_1588_CLOCK=n,
and dpaa does the same without a ptimer-handle. I can send that as a
separate patch.

Which clock the timestamps are in is a separate question, see my answer
to the cover letter.

> 
> > @@ -7250,7 +7353,8 @@ static struct virtio_device_id id_table[] = {
> >  	VIRTIO_NET_F_SPEED_DUPLEX, VIRTIO_NET_F_STANDBY, \
> >  	VIRTIO_NET_F_RSS, VIRTIO_NET_F_HASH_REPORT, VIRTIO_NET_F_NOTF_COAL, \
> >  	VIRTIO_NET_F_VQ_NOTF_COAL, \
> > -	VIRTIO_NET_F_GUEST_HDRLEN, VIRTIO_NET_F_DEVICE_STATS
> > +	VIRTIO_NET_F_GUEST_HDRLEN, VIRTIO_NET_F_DEVICE_STATS, \
> > +	VIRTIO_NET_F_RX_TSTAMP
> 
>     `VIRTNET_FEATURES` expands into `features_legacy[]` as well as `features[]`.
>     Legacy virtio only supports 32 feature bits (`0..31`) and never has
>     `VIRTIO_F_VERSION_1`. Move `VIRTIO_NET_F_RX_TSTAMP` (bit 49) into `features[]`
>     alongside `VIRTIO_NET_F_*_UDP_TUNNEL_GSO*`.
>

Oops, yes. Will move it to features[].


Steffen

-- 
Pengutronix e.K.                | Dipl.-Inform. Steffen Trumtrar |
Steuerwalder Str. 21            | https://www.pengutronix.de/    |
31137 Hildesheim, Germany       | Phone: +49-5121-206917-0       |
Amtsgericht Hildesheim, HRA 2686| Fax:   +49-5121-206917-5555    |
