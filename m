Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793004711;
	b=JBPMfsA8O+9NRXjm22ymSMV62W8Z7nqEKXabYBnIMsdgXU6fiNldWeHDEEFIajwttQS3
	 16iFX5TeezCrx3tdfU6cub+deEPsFzNlqEwAlhr5PzliPvgNDvvPwRunWKzR60Wbm2Yvf
	 rZySHtUG+ttEIR5Us7OHcXiV4Sfd/4TV6tlXIFex1LQYPGsrAnXoJpBWdk+ulnCYct7Sx
	 L0ACppisGictuxLvBDmInyNAwH6H7289g+ENbRCClzlMDWWEjD0GP5aSlF7xu4/kGRtVs
	 7zsuzejgYqZPPDZFkf+8lMMaxfcJQ5ru16Xt/HcCZMNilq3O4AwqhrLnOBlYJCKprmA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793004711;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=5P4rRS1DRPSI0zxWWVxffkcVyoVoD1HNQyHCxglVNkg=;
	b=lypjJxK+3xgxLHvYseHF9GQqDiSYGfH9sLE4xDFgcIP+KRK0chOm3nX/jEv5QBfWb2I/
	 bupEum56VQZeAOwlfaa1iNu+vMlsirNPTaZ3F4/cNq0EunIa6mAu+uoBfNEkgolmgRKCl
	 2DpvPacBuB9r1UJt3TIDAdYTNjo0RSRj3gt6xQsG5jKw5pXrVcR792q3c06VUYVSCSgIw
	 RrCQlmoVqrz0/FUWcHB1/Xbrivxsn4d6wX2bKcQrtpBg3vvaFxWvANTBfT3gQdciQ7yQS
	 bKoz31OQ/GMNNqoyosTzFbIsy6Gb1iKqod5VB1xQYu5EP32xvN5GfSYkeZihuxMKqQw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GVSsSDNO;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A17CA606A32C;
	Mon, 26 Oct 2026 08:51:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GVSsSDNO
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD0BE1F01828;
	Mon, 26 Oct 2026 08:51:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793004711;
	bh=5P4rRS1DRPSI0zxWWVxffkcVyoVoD1HNQyHCxglVNkg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=GVSsSDNOmJcE9hHiZdW7K/sOwwSLw33BIY4nEzCOXxBloSn2gbywB1iQ/r2KcCpvg
	 o5tnESc5RFx1DfB/+sIrye9yLGxc0yTv73uTEm9OEPkTOKkJ+rqB1knHxT1bA3oTLH
	 SF4cyMzcfTUu3ECaK2i/Uia88Ea4EAwOEJVwqsYDJkksa+JYmo9ovwNGXHgvRzTTXh
	 mdNksmO2sCwooHSa3MJLtVVuyrHYsGHnrOoiTm9Skp1uGdI1pmDUJ4n504r0hdiPar
	 jIyZdl66ne6HbnD+LMMKeAIfkvAgY6cWjM+K+JK05jgdvYpp+kGTuXSPuwqB0NHyaW
	 19c4UwGr5YfKQ==
Message-ID: <sashiko-outbox-184700@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC v4 2/6] virtio-net: support receive timestamp
Reply-To: sashiko-reviews@lists.linux.dev
To: "Steffen Trumtrar" <s.trumtrar@pengutronix.de>
Cc: virtualization@lists.linux.dev, bpf@vger.kernel.org, kvm@vger.kernel.org, "Michael
 S. Tsirkin" <mst@redhat.com>, "Eugenio Perez" <eperezma@redhat.com>
In-Reply-To: <20261026-v6-7-topic-virtio-net-ptp-v4-2-008af03cd43b@pengutronix.de>
References: <20261026-v6-7-topic-virtio-net-ptp-v4-0-008af03cd43b@pengutronix.de>
 <20261026-v6-7-topic-virtio-net-ptp-v4-2-008af03cd43b@pengutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 26 Oct 2026 08:51:50 +0000
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] virtio-net: incomplete TX header zeroing in xmit_skb() leaks skb=
 memory
--

commit 33c9a34145febcaa0e50429953d991f89f3ffb19
Author: Steffen Trumtrar <s.trumtrar@pengutronix.de>

virtio-net: support receive timestamp

This commit adds optional hardware RX timestamp offload support via the
VIRTIO_NET_F_RX_TSTAMP feature, extending struct virtio_net_common_hdr to
40 bytes to carry a 64-bit TAI receive timestamp and wiring up the
ethtool and netdev hardware timestamping callbacks.

> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index 17d3e32eed9d6..23af10c613b48 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
[ ... ]
> @@ -3303,6 +3333,10 @@ static int xmit_skb(struct send_queue *sq, struct =
sk_buff *skb, bool orphan)
>  					false, feature_hdrlen))
>  		return -EPROTO;
> =20
> +	/* Don't leak skb->cb or headroom; the device expects tstamp to be 0 */
> +	if (hdr_len > sizeof(*hdr))
> +		memset((u8 *)hdr + sizeof(*hdr), 0, hdr_len - sizeof(*hdr));
> +
>  	if (vi->mergeable_rx_bufs)
>  		hdr->hash_hdr.hdr.num_buffers =3D 0;

[Severity: Medium]
Can this leave bytes in the middle of the transmitted header uninitialized
and leak stale skb->cb or headroom memory to the device?

When VIRTIO_NET_F_RX_TSTAMP is negotiated, virtnet_probe() sets vi->hdr_len
to 40 bytes (offsetofend(struct virtio_net_common_hdr, tstamp)), even if
hash reporting, UDP tunnel GSO, or mergeable RX buffers were not
negotiated.

In xmit_skb(), hdr has type struct virtio_net_hdr_v1_hash_tunnel *
(sizeof(*hdr) is 24 bytes) and points either into skb headroom or to
&skb_vnet_common_hdr(skb)->tnl_hdr (aliasing skb->cb). When xmit_skb()
calls virtio_net_hdr_tnl_from_skb() for a packet without UDP tunnel GSO, it
returns early after calling virtio_net_hdr_from_skb():

include/linux/virtio_net.h:virtio_net_hdr_tnl_from_skb() {
	tnl_gso_type =3D skb_shinfo(skb)->gso_type & (SKB_GSO_UDP_TUNNEL |
						    SKB_GSO_UDP_TUNNEL_CSUM);
	if (!tnl_gso_type) {
		ret =3D virtio_net_hdr_from_skb(skb, hdr, little_endian,
					      has_data_valid, vlan_hlen);
		if (ret)
			return ret;

		if (feature_hdrlen && hdr->hdr_len)
			__virtio_net_set_hdrlen(skb, hdr, little_endian);

		return ret;
	}
}

Because virtio_net_hdr_from_skb() takes a struct virtio_net_hdr * argument,
its memset(hdr, 0, sizeof(*hdr)) only zeroes the first 10 bytes (offsets
0..9).

The new memset((u8 *)hdr + sizeof(*hdr), 0, hdr_len - sizeof(*hdr)) starts
at offset 24 and zeroes offsets 24..39, while hdr->hash_hdr.hdr.num_buffers
=3D 0 only zeroes offsets 10..11 when vi->mergeable_rx_bufs is set. As a
result, offsets 12..23 (hash_value_lo, hash_value_hi, hash_report, padding,
outer_th_offset, inner_nh_offset) and offsets 10..11 (when
!vi->mergeable_rx_bufs) are never zeroed before all 40 bytes are mapped into
sq->sg and passed to the device.

Additionally, when !can_push, hdr points to the 24-byte tnl_hdr member
sub-object inside struct virtio_net_common_hdr, so writing past sizeof(*hdr)
via hdr writes across the sub-object boundary into sibling fields of
struct virtio_net_common_hdr.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261026-v6-7-topic=
-virtio-net-ptp-v4-0-008af03cd43b@pengutronix.de?part=3D2
