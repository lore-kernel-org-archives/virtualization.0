Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794568823;
	b=r8pBJ8+ldHXLMQJgkZBmA9pa5YbfJ3Ap3itnL17WW519U1yB0s+IkftwTVPMqQ6UV5mj
	 iJCbP7x+2KIuByY4xCOS4qlLE/6C+aoQR9f8TgQ3ZoHE8eK8GxAazzx3WdgsIUKBUz0h1
	 8MeC9XrIRCZU3te5xl85AiMbFGNVHOad7284EZFDQxVKXKM507emTyhpJbi15kJWil06f
	 gljaCebwU046W/0FhpRKKggqA5BlLUA6J1UIfELX/WoCvaL9tFxYpUgq0uGO/EW861Bjt
	 afNPoMfCUWsljabxlWZTSUZBIlvWjC8P6rLN1eCZ5O/fZVf+huFVh1SiCvOEJ6I2l6w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794568823;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=f7uqArV1jAtpFrD+qGNcFGks6nXlP6uwZeIFZyLm7/M=;
	b=qaCRGem6/Fm/eDud+n0odzTy8H4WWskMJTKYrYV9jOR/96ijQsiS48yt6x5Qob8IImw7
	 bG5GIKPizC0+xUkr1n76YBN0tjVSmJ5VSgy14FPNW0lKijhil1VY7QRFIpG4xGap9m18C
	 y+SFfsFu9E0VhVQYwrRBXdULzVwPOL64wBNTIjY6bdfOwpY5yYUT0fWnjRVi6cQ/sHZ6N
	 eGpZmukuYm4SOwgm+nI/ExEGPWeywK/gh3/a00zOFuGkaedlfp/FqtnqWOl3c1C0gHcT7
	 foq3dJHtci2YQ9zBGh7Lp2tNs9sWQsYxh/gXG3Sqk6TDIYUZTu7Yj3ZLLMrscMi8pbg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IYtLe9Ox;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD6C1606A333;
	Fri, 13 Nov 2026 11:20:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IYtLe9Ox
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 478BC1F000CA;
	Fri, 13 Nov 2026 11:20:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794568823;
	bh=f7uqArV1jAtpFrD+qGNcFGks6nXlP6uwZeIFZyLm7/M=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=IYtLe9Oxec6Sw6lgS9yWWd39yeq0AH320nbnEmOrPwT7fMmpsqT9J9/WO5rKgBpwv
	 zuAo5DxfWz9aQ9RKmjd1aguwCkZpTacUQL9kISDMnaEXv+nDigU0I4qOwUge74WW+u
	 p11I6Yg82iwjIeR8UqVlIRlBMwY76I3V6MI/KCkW0WMXCtCtyfH6C0QqoWuZIP0NvD
	 b6fB3aRToDDa8l/+lpnwg4LdlZyPJXlkW3NOxCL9919UMNOagmWlrMIB40CiKkNWQt
	 yRuKuyQxkSGJ5zwdxu8AMroq/wvPogaqi2hfbfqY/V0TQ9qcREqeaz4qoxywoRtxQN
	 uXs4qLqVEgFaw==
Message-ID: <sashiko-outbox-212702@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net-next v5 2/9] virtio-net: zero the whole tx header
Reply-To: sashiko-reviews@lists.linux.dev
To: "Steffen Trumtrar" <s.trumtrar@pengutronix.de>
Cc: virtualization@lists.linux.dev, bpf@vger.kernel.org, kvm@vger.kernel.org, "Michael
 S. Tsirkin" <mst@redhat.com>, "Eugenio Perez" <eperezma@redhat.com>
In-Reply-To: <20261112-v6-7-topic-virtio-net-ptp-v5-2-7ab67b572f4f@pengutronix.de>
References: <20261112-v6-7-topic-virtio-net-ptp-v5-0-7ab67b572f4f@pengutronix.de>
 <20261112-v6-7-topic-virtio-net-ptp-v5-2-7ab67b572f4f@pengutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 13 Nov 2026 11:20:22 +0000
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list

Thank you for your contribution! Sashiko AI review found no new issues
in this patch, but noticed 1 related pre-existing issue it does not
introduce:
- [Critical] virtio_net: uninitialized skb->cb read in
  virtnet_receive_done() [1]
--

commit 539d0b476e95c38e08289348fc9e76ffb578e50d
Author: Steffen Trumtrar <s.trumtrar@pengutronix.de>

virtio-net: zero the whole tx header

This commit zeroes the entire negotiated virtio-net transmit header in
xmit_skb() before populating it so that uninitialized skb->cb or headroom
bytes are not sent to the device.

> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index dd2c41ef6fbe7..4c740b403ad1e 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -3326,14 +3326,16 @@ static int xmit_skb(struct send_queue *sq, struct=
 sk_buff *skb, bool orphan)
>  	else
>  		hdr =3D &skb_vnet_common_hdr(skb)->tnl_hdr;
> =20
> +	/* Fields the helper below does not fill in must not carry stale
> +	 * skb->cb or headroom bytes to the device.
> +	 */
> +	memset(hdr, 0, hdr_len);
> +
>  	if (virtio_net_hdr_tnl_from_skb(skb, hdr, vi->tx_tnl,
>  					virtio_is_little_endian(vi->vdev), 0,
>  					false, feature_hdrlen))
>  		return -EPROTO;
> =20
> -	if (vi->mergeable_rx_bufs)
> -		hdr->hash_hdr.hdr.num_buffers =3D 0;
> -

[Severity: Critical]
This problem wasn't introduced by this patch, but can virtnet_receive_done()
read uninitialized skb->cb fields [1] when an XDP program returns
XDP_PASS?

In receive_small_xdp() and receive_mergeable_xdp(), the skb constructed on
XDP_PASS via virtnet_build_skb() or build_skb_from_xdp_buff() does not copy
or zero the virtio-net header in skb_vnet_common_hdr(skb).  When
receive_buf() passes that skb to virtnet_receive_done(), only hdr->hdr.flags
is written before the rest of hdr is read:

drivers/net/virtio_net.c:virtnet_receive_done() {
	...
	hdr =3D skb_vnet_common_hdr(skb);
	if (dev->features & NETIF_F_RXHASH && vi->has_rss_hash_report)
		virtio_skb_set_hash(&hdr->hash_v1_hdr, skb);

	hdr->hdr.flags =3D flags;
	if (virtio_net_handle_csum_offload(skb, &hdr->hdr, vi->rx_tnl_csum)) {
	...
}

virtio_net_handle_csum_offload() and virtio_skb_set_hash() then evaluate
garbage csum_start, csum_offset, gso_type, and hash metadata from skb->cb,
causing corrupted checksums, unexpected packet drops, or bogus skb state.

[1] https://sashiko.dev/#/bug/linux-89f94565-4be5-4c5d-b3a1-d88fa369641f

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261112-v6-7-topic=
-virtio-net-ptp-v5-0-7ab67b572f4f@pengutronix.de?part=3D2
