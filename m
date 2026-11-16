Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794837309;
	b=eqHvUpRop4NL/S9JUNUNG/4UY7nYNPNwzJxjXO6UClTXHwHxHmH/pxu0ctv/vmlblyxO
	 se/xbyLze50QV7htEmr2fCjYMuCtIDdtTER38RQXQq9Wzv/22AbYyoC8S//vY+zB4wpo5
	 /rF+4Tf5OKpjR2hqj3f7PzsaNzu2Tm/ChCnfOJZscdRpv/pT9Yrwod24x0UJyW9XH5SY1
	 6hKSlypKyb9il6DTPDYLZ78ZQriqsueMACd3DSpkOpPMCyZ4JbieWQ8f6PanRPfBJ5P6m
	 jA6tE42DC9SdSlt7azBUSl7MRx7zwbj0XmhAZAS/EycitUn+idzdTr0CSUfEuQieNQg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794837309;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=tfjYQFYpkytc82LeFrqvPRD/cCN3o6h7XjL0XvsdNrM=;
	b=TM8lFRLT7RObRuL++SnSOXM1k6OUzNgUS6kBA/i+Fb6P07TxBz59j4IBRalvExlZWCub
	 HXzd976PURbQoHBBF6pqJwc03NC+TmmcmHjEOmftEbY/DklQWhMO/4uzwCwRsHEby+Ciw
	 X55TvUCEhzOzOSD+xWYlqSSH/JHoVB3jVPJN1O+k0oOQczfCHEr4EipXKFnMdHLSVGocP
	 Cdw2buLM0hxptYlWSgowUnCtXTvIpLAaZPSSB423DTLqevIEhEvCG1iFYXbwBRJ4ZT6cW
	 mh4tmoAXpq96DshRX7xw7hU9Qf/6d+PScSL19fPjCcqvQgFSyhFnsTFdCUXHpJDj0UA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XgA8Abrt;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A495606A881;
	Mon, 16 Nov 2026 13:55:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XgA8Abrt
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ADDD01F000C5;
	Mon, 16 Nov 2026 13:55:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794837309;
	bh=tfjYQFYpkytc82LeFrqvPRD/cCN3o6h7XjL0XvsdNrM=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=XgA8AbrtFprnJjQ4xMBE9KanjGxZZnKS8nxLy8/IO17rz0H2AE/r2U6CfimAiaurg
	 ULRsQNORS31dlX1CrjlprKEMbMjnGyxiSXMMQJM3sDsYdLxUlKQ5PKwQ8YRrwHpaxB
	 WpCxO2GfmqwSy+L21LQj6+WoyxhK0ksk1d/8ByXeKZ5FubJPu/Lm5zyTVMpmDsbGet
	 YATKQ8OcIPA9ZkpxZBP5o/n70oaL9vcBV+8leiKIcZcso0Qh3ZvtLS5AKPts5I7eQ3
	 RTFU63kcmsyR3zMi8v0YbnwChX410rFhosDpZSUZEqdY7YeIgMTwQsO7qz94s+uPXk
	 6D+MURG1+KP5A==
Subject: Re: [PATCH net-next v5 7/9] vhost-net: support VIRTIO_NET_F_RX_TSTAMP
From: netdev-bot+sashiko@kernel.org
To: s.trumtrar@pengutronix.de
Cc: mst@redhat.com, xuanzhuo@linux.alibaba.com, davem@davemloft.net,
 kuba@kernel.org, pabeni@redhat.com, richardcochran@gmail.com,
 willemdebruijn.kernel@gmail.com, andrew+netdev@lunn.ch, eperezma@redhat.com,
 jasowangio@gmail.com, ast@kernel.org, daniel@iogearbox.net, hawk@kernel.org,
 john.fastabend@gmail.com, sdf@fomichev.me, edumazet@kernel.org,
 andrew@lunn.ch, horms@kernel.org, kory.maincent@bootlin.com,
 liangchen.linux@gmail.com, hengqi@linux.alibaba.com,
 virtualization@lists.linux.dev, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org, kvm@vger.kernel.org,
 kernel@pengutronix.de
Date: Mon, 16 Nov 2026 13:55:07 +0000
Message-ID: <179483730723.3136.9748134612882994107@kernel.org>
In-Reply-To: <20261112-v6-7-topic-virtio-net-ptp-v5-7-7ab67b572f4f@pengutronix.de>
References: <20261112-v6-7-topic-virtio-net-ptp-v5-7-7ab67b572f4f@pengutronix.de>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 2 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 2 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] vhost-net now always offers VIRTIO_NET_F_RX_TSTAMP ("Device
  sends TAI receive time") through VHOST_GET_FEATURES…
- [Medium] Sizing the vnet header to 40 bytes for VIRTIO_NET_F_RX_TSTAMP
  alone (vhost_net_set_features(), drivers/vhost/net.c:1702-1704) breaks…

--

vhost-net: support VIRTIO_NET_F_RX_TSTAMP

This commit advertises VIRTIO_NET_F_RX_TSTAMP from vhost-net and sizes the
vnet header to 40 bytes when the feature is negotiated. When vhost supplies
the header itself, everything behind the fields it fills in is zeroed, so
the timestamp is left at 0.

> diff --git a/drivers/vhost/net.c b/drivers/vhost/net.c
> index 435d8ed3851f3..1b171af105a22 100644
> --- a/drivers/vhost/net.c
> +++ b/drivers/vhost/net.c
> @@ -77,7 +77,8 @@ static const int vhost_net_bits[] = {
>  	VIRTIO_F_RING_RESET,
>  	VIRTIO_F_IN_ORDER,
>  	VIRTIO_NET_F_GUEST_UDP_TUNNEL_GSO,
> -	VIRTIO_NET_F_HOST_UDP_TUNNEL_GSO
> +	VIRTIO_NET_F_HOST_UDP_TUNNEL_GSO,
> +	VIRTIO_NET_F_RX_TSTAMP
>  };

[Severity: Medium]
Should VIRTIO_NET_F_RX_TSTAMP be offered unconditionally through
VHOST_GET_FEATURES when nothing in the RX path writes a timestamp?

With VHOST_NET_F_VIRTIO_NET_HDR, the new block in handle_rx() zeroes every
byte after hdr_filled, so tstamp is always 0:

    if (unlikely(vhost_hlen > hdr_filled)) {
        size_t rest = vhost_hlen - hdr_filled;

        if (iov_iter_zero(rest, &fixup) != rest) {

With a socket-supplied header, the commit message says tun fills in the
timestamp. But __tun_vnet_hdr_put() in drivers/net/tun_vnet.h copies only
tun_vnet_parse_size(features) bytes (10 or 24) and zeroes the rest:

    unsigned int parsed_size = tun_vnet_parse_size(features);
    ...
    if (iov_iter_zero(sz - parsed_size, iter) != sz - parsed_size)
        return -EFAULT;

tun.c, tap.c and tun_vnet.h don't reference tstamp at all.

The last patch in the series, "tun: add rx timestamp to the vnet header",
is labeled as not intended to be merged. Even with that patch applied, only
tun_put_user() fills in the timestamp. tun_put_user_xdp() and tap_put_user()
still go through tun_vnet_hdr_put() with a zero-initialized
virtio_net_common_hdr, so tstamp stays 0 on those paths.

On the guest side, negotiating the bit sets vi->rx_tstamp_supported.
virtnet_get_ts_info() then reports:

    if (vi->rx_tstamp_supported) {
        info->so_timestamping |=
            SOF_TIMESTAMPING_RX_HARDWARE |
            SOF_TIMESTAMPING_RAW_HARDWARE;

virtnet_hwtstamp_set() also accepts HWTSTAMP_FILTER_ALL. Since every
timestamp is 0, no skb ever gets a hwtstamp. A guest PTP stack that turns
on hardware RX timestamping because of the advertised capability will
never receive any timestamps.

Once the bit is in vhost_net_bits[] it is visible to userspace. Could the
feature be offered only when the attached backend can actually produce a
timestamp?

[ ... ]

> @@ -1684,6 +1699,10 @@ static int vhost_net_set_features(struct vhost_net *n, const u64 *features)
>  				     VIRTIO_NET_F_GUEST_UDP_TUNNEL_GSO))
>  		hdr_len = sizeof(struct virtio_net_hdr_v1_hash_tunnel);
>  
> +	/* The header layout is cumulative, tstamp sits behind all other fields. */
> +	if (virtio_features_test_bit(features, VIRTIO_NET_F_RX_TSTAMP))
> +		hdr_len = offsetofend(struct virtio_net_common_hdr, tstamp);
> +

[Severity: Medium]
Does a 40 byte header for RX_TSTAMP alone break the way tun guesses the
guest features?

tun_vnet_hdr_guest_features() in drivers/net/tun_vnet.h infers the tunnel
features from the header size:

    /*
     * Tun is not aware of the negotiated guest features, guess them from the
     * virtio net hdr size
     */
    static inline netdev_features_t tun_vnet_hdr_guest_features(int vnet_hdr_sz)
    {
        if (vnet_hdr_sz >= TUN_VNET_TNL_SIZE)
            return NETIF_F_GSO_UDP_TUNNEL | NETIF_F_GSO_UDP_TUNNEL_CSUM;
        return 0;
    }

Take socket-header mode with a guest that negotiates RX_TSTAMP but neither
HOST_UDP_TUNNEL_GSO nor GUEST_UDP_TUNNEL_GSO. It gets sock_hlen = 40, so
the tap's vnet_hdr_sz is 40. Both guest TX paths then treat the tunnel
features as negotiated:

    tun_get_user()
        features = tun_vnet_hdr_guest_features(vnet_hdr_sz);
        hdr_len = __tun_vnet_hdr_get(vnet_hdr_sz, tun->flags,
                                     features, from, gso);

    vhost_net_build_xdp() ... tun_sendmsg()->tun_xdp_one()
        features = tun_vnet_hdr_guest_features(READ_ONCE(tun->vnet_hdr_sz));
        ...
        tun_vnet_hdr_tnl_to_skb(tun->flags, features, skb, tnl_hdr)

This passes tnl_hdr_negotiated = true and tnl_csum_negotiated = true into
virtio_net_hdr_tnl_to_skb(). As a result, the -EINVAL check for a header
that asks for tunnel GSO without negotiating it is skipped. The
VIRTIO_NET_HDR_F_UDP_TUNNEL_CSUM check is skipped as well.

Could a guest then get UDP tunnel GSO packets, and the tunnel csum flag,
accepted by the host even when the VMM left host UDP tunnel GSO disabled?

Before this patch, only the tunnel features made the vhost-net header 24
bytes or larger, so the heuristic held. Nothing else in the series updates
tun.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261112-v6-7-topic-virtio-net-ptp-v5-0-7ab67b572f4f%40pengutronix.de
