Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794568833;
	b=puwM6S/QLGJX647+VhGhJxYeFxy5qczxcVz1IrJ0ZaBwPJicgyLUiU/Rud/DPeaiiwq0
	 voL9kYBWMuolmI/Fl85TWfH6aV0Z7kmmMPfGPVLYK7RuWJ/d8ZqgNApBlJWPK6EXOoG/L
	 TF473CcN0FptkgFOjccNNjkL8zZ8ZiApeyM9LQpUMNXYrK1jMBTkndl1TGjTgYAT/FZ/a
	 K/kRUmcewZS6jQ964BK+xM6EbhkpAxWZEwo1g1QssHnss3Nehvs1LT9XUpypAFCJ2YSnz
	 89Tmaz0pBj5Gr2jonoN1cTatZ3EUDV96Sn43ET2Q+PfDALCoMe6FmBhU/gn19f5vuqA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794568833;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=BEvNlOJ/dh2tY56h/KmKJEcmm7trs2W9no0Z7P+hsLA=;
	b=z9PdL6dCJ74TttlG0fPPpGu4rSNKWbECfQwo3OkGioT18gE/NC/zQQ923H/uOUPCqcsf
	 oQcnD/Y1a9fgQycNvAk9TSQwEX0iO33Kz3+l+IQXFN08297hZcAT9+jf9TE0ln3LXEhTD
	 J4rLH+0ZJ9NVz2tkP33N8TlR4OEjrQiwKGQ1zVRUp0m4n/bxIp4rzc7ZGy0Pxmb1m2BMD
	 Dp4AgMAFkE9MEbYDokd+1XNpG9gd/xPZ0MoVu9F/0wJC2yiAu8KQNes4QIL+U/7OdiLq3
	 YhFzQky2NdrRyn9zwUM1+RyaLQZ3bKqz+qVJbFVtpUkiM1IIQpO9VkqgKxIq6v6AEYg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ms5aYCW7;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCA7C606A880;
	Fri, 13 Nov 2026 11:20:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ms5aYCW7
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 372E21F000C4;
	Fri, 13 Nov 2026 11:20:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794568833;
	bh=BEvNlOJ/dh2tY56h/KmKJEcmm7trs2W9no0Z7P+hsLA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ms5aYCW7rWMP3UKnq2j3vKfjttPTJ4PV7EQSxvx5vjsclqtUmzqvMVVLUVZaXov+/
	 6B2kEJXuB5/Qf2L0P2NdLlf+NP8rEXoXdwlwlMb8jTVxdDgm2+kEtueVl+w3KJSYhT
	 tdOQuz9ua2DQu0UP58aAOrDO4f7XBkEEZMoiL+t8LtormB7rto1rw9g5vJQYIo5Xnh
	 ZIy+QrUfBJdwBNbbSN+LpYCtnPunQJv5Px6lZT1z0AuARtajMebuOfp7a81V1KVChy
	 ECVBpzRwTK+ynNacMaWK5VkovgYmDEHdHXRMwNxCQv97V1a4vFL7tMbIopooOjoj/T
	 L2inb2mBo46aA==
Message-ID: <sashiko-outbox-212709@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net-next v5 9/9] tun: add rx timestamp to the vnet
 header
Reply-To: sashiko-reviews@lists.linux.dev
To: "Steffen Trumtrar" <s.trumtrar@pengutronix.de>
Cc: virtualization@lists.linux.dev, bpf@vger.kernel.org, kvm@vger.kernel.org, "Michael
 S. Tsirkin" <mst@redhat.com>, "Eugenio Perez" <eperezma@redhat.com>
In-Reply-To: <20261112-v6-7-topic-virtio-net-ptp-v5-9-7ab67b572f4f@pengutronix.de>
References: <20261112-v6-7-topic-virtio-net-ptp-v5-0-7ab67b572f4f@pengutronix.de>
 <20261112-v6-7-topic-virtio-net-ptp-v5-9-7ab67b572f4f@pengutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 13 Nov 2026 11:20:32 +0000
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list

Thank you for your contribution! Sashiko AI review found 3 potential
issues to consider:
- [Medium] tun: missing TUNSETOFFLOAD negotiation for rx timestamp in
  tun_put_user()
- [Medium] tun: missing rx timestamp in tun_vnet_hdr_put() for XDP and
  tap paths
- [Medium] tun: vnet_hdr_sz for rx timestamp enables tunnel GSO in
  tun_get_user()
--

commit d550e223b215243ce50180a91000fc2227098b26
Author: Steffen Trumtrar <s.trumtrar@pengutronix.de>

tun: add rx timestamp to the vnet header

This commit writes the current TAI timestamp into the virtio-net header in
tun_put_user() when the configured vnet_hdr_sz covers the tstamp field, and
updates __tun_vnet_hdr_put() to accept struct virtio_net_common_hdr.

> diff --git a/drivers/net/tun.c b/drivers/net/tun.c
> index 8920c797acfd7..1a8c3377753d7 100644
> --- a/drivers/net/tun.c
> +++ b/drivers/net/tun.c
[ ... ]
> @@ -2168,12 +2169,16 @@ static ssize_t tun_put_user(struct tun_struct *tu=
n,
>  	}
> =20
>  	if (vnet_hdr_sz) {
> -		struct virtio_net_hdr_v1_hash_tunnel hdr;
> -		struct virtio_net_hdr *gso;
> +		struct virtio_net_common_hdr hdr;
> =20
>  		memset(&hdr, 0, sizeof(hdr));
> +
> +		/* The configured header covers the tstamp field */
> +		if (vnet_hdr_sz >=3D offsetofend(struct virtio_net_common_hdr, tstamp))
> +			put_unaligned_le64(ktime_get_clocktai_ns(), hdr.tstamp);

[Severity: Medium]
Should rx timestamp generation be negotiated via a TUN_F_* flag in
TUNSETOFFLOAD rather than gated solely on vnet_hdr_sz?

TUNSETVNETHDRSZ in tun_vnet_ioctl() already accepts any header size >=3D
sizeof(struct virtio_net_hdr) and zero-fills trailing bytes, so a VMM cannot
use it to probe whether the host kernel supports VIRTIO_NET_F_RX_TSTAMP.
Because struct virtio_net_common_hdr uses a cumulative wire layout, any fut=
ure
feature placed after tstamp that sets vnet_hdr_sz > 40 without negotiating
VIRTIO_NET_F_RX_TSTAMP will also cause tun_put_user() to write timestamps i=
nto
hdr.tstamp on every packet.

[Severity: Medium]
Does configuring vnet_hdr_sz for VIRTIO_NET_F_RX_TSTAMP also unintentionally
enable UDP tunnel GSO on the guest TX path?

drivers/net/tun_vnet.h:tun_vnet_hdr_guest_features() {
	if (vnet_hdr_sz >=3D TUN_VNET_TNL_SIZE)
		return NETIF_F_GSO_UDP_TUNNEL | NETIF_F_GSO_UDP_TUNNEL_CSUM;
	return 0;
}

Setting vnet_hdr_sz to 40 for rx timestamps satisfies vnet_hdr_sz >=3D
TUN_VNET_TNL_SIZE (24), causing tun_get_user() and tun_xdp_one() to parse t=
he
24-byte tunnel header and accept UDP-tunneled GSO packets from the guest ev=
en
when VIRTIO_NET_F_HOST_UDP_TUNNEL_GSO was not negotiated.

> diff --git a/drivers/net/tun_vnet.h b/drivers/net/tun_vnet.h
> index f4c652b1fa44d..d4cc56dac98d6 100644
> --- a/drivers/net/tun_vnet.h
> +++ b/drivers/net/tun_vnet.h
[ ... ]
> @@ -174,7 +176,11 @@ static inline int __tun_vnet_hdr_put(int sz, netdev_=
features_t features,
>  static inline int tun_vnet_hdr_put(int sz, struct iov_iter *iter,
>  				   const struct virtio_net_hdr *hdr)
>  {
> -	return __tun_vnet_hdr_put(sz, 0, iter, hdr);
> +	struct virtio_net_common_hdr common_hdr =3D {};
> +
> +	common_hdr.hdr =3D *hdr;
> +
> +	return __tun_vnet_hdr_put(sz, 0, iter, &common_hdr);
>  }

[Severity: Medium]
Does tun_vnet_hdr_put() leave common_hdr.tstamp zeroed when vnet_hdr_sz cov=
ers
the tstamp field?

Both tun_put_user_xdp() and tap_put_user() write the virtio-net header via
tun_vnet_hdr_put(), so XDP frames read from a tun device and packets read f=
rom
tap/macvtap interfaces never receive an rx timestamp.  In addition,
tun_put_user() samples ktime_get_clocktai_ns() when dequeuing from
tfile->tx_ring rather than using skb_hwtstamps(skb)->hwtstamp or timestampi=
ng
on packet arrival in tun_net_xmit(), which includes ring queuing delay in t=
he
reported rx timestamp.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261112-v6-7-topic=
-virtio-net-ptp-v5-0-7ab67b572f4f@pengutronix.de?part=3D9
