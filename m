Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793005441;
	b=RVVgOrgvhsDyuf/hBFp9irLv/Ftd8YkswOHRbvdizD4jA0PorC0cwE+62f2dCqREyA6y
	 7fhRp0cwI62ICcxoApvHSrVZt3Eb7SvprsklojjVrAKutzNdzLQ6Ys1PWIfzoUn70K6P1
	 7xQHqeCWfQOrFKBj760p35aTAjpvHfh3RaFP3BJyS3wtZ08XxhqQLojwYIuku7iudXmPX
	 DPLM+1VAZ6/wywIk/xN4TiUtQm8AuE0QiUDDP7MYPuQJNPLxaXQaLvc8jhD571STFRRcj
	 GOe/MlojDa63BeGKUkr6BlVdJCFHDT96s0pEC/qqPMbQ8JnFEstsd0u768ioFFpb0nA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793005441;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=SjrKCS1IPYsIx6ZwmedhiYRwNF3yTKQbRR/BABZtZEo=;
	b=y24eRrdYINlDXrWrfnG0aN54NZc5ghk5zt+VMTaMXzJrnWZulLlwMXe3xZ6A3nSC3fVQ
	 ywJioK6HNkTqz8x2srU7Rxgee01L1l6jRfrhrnJU7oHanjZySYizVRI8tu2pxLovdzWfA
	 dktZjRMKQAPKclqFDhEGfNfZdMZWvstqyd/WDG6QfL5bqyS/wLO9C5h6LGkfJ4a84ToaU
	 WPm/XipmTl2NNDKUbiSMHhDYJtI5RUsNaVoPe5aCb6LO9dk5qCc0wU3HZZKttD2f2nFjV
	 5DiHgGptKuKaucMXOzYabidtc4qBkpTAdNDa/kDscoGZeNmYQ4FLJXxOEyamlkAj3yQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EWL0uDOq;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91052606A31A;
	Mon, 26 Oct 2026 09:04:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EWL0uDOq
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7CD61F01825;
	Mon, 26 Oct 2026 09:04:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793005441;
	bh=SjrKCS1IPYsIx6ZwmedhiYRwNF3yTKQbRR/BABZtZEo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=EWL0uDOq4bimtB16yiSeFqejESn2omWGVl4pbrgDI5BPyVpKFiuFPe6BPMOFFeLoK
	 4wwEDFIMjCY08dVepRRWIIjTKJUOinl1M5/CG5XBAGCc/72cC4HPCpXqYd+uOKAEHF
	 1ZqlVz99SRCt4NvT/siYkyXxifZMbJa2+LuChteYlpymWnwe9xqoK5MnYR73yA1AEe
	 3ju8PUj5d+krZvWDS4XmcUtiyQ4jgkjtoiQZwws+/8ArqsVJL1Uf2WKCby39kMaxHC
	 4hfE+J2LMx3pbi5XIYr8yeQK5ZqgXNMYt9vidQPtg9+h/BS9DDIdEGC8gK1dh6Yxyf
	 cZWdCSECd1GJw==
Message-ID: <sashiko-outbox-184725@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC v4 5/6] virtio-net: add XDP rx timestamp metadata
Reply-To: sashiko-reviews@lists.linux.dev
To: "Steffen Trumtrar" <s.trumtrar@pengutronix.de>
Cc: virtualization@lists.linux.dev, bpf@vger.kernel.org, kvm@vger.kernel.org, "Michael
 S. Tsirkin" <mst@redhat.com>, "Eugenio Perez" <eperezma@redhat.com>
In-Reply-To: <20261026-v6-7-topic-virtio-net-ptp-v4-5-008af03cd43b@pengutronix.de>
References: <20261026-v6-7-topic-virtio-net-ptp-v4-0-008af03cd43b@pengutronix.de>
 <20261026-v6-7-topic-virtio-net-ptp-v4-5-008af03cd43b@pengutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 26 Oct 2026 09:04:00 +0000
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
- [High] virtio-net: virtnet_xdp_rx_timestamp() reads header overlapping XD=
P data_meta
--

commit 232ef11034e0a6c3f2481ceaa1291cc9268f328c
Author: Steffen Trumtrar <s.trumtrar@pengutronix.de>

virtio-net: add XDP rx timestamp metadata

This commit implements the xmo_rx_timestamp XDP metadata callback in
virtio_net so XDP programs can read hardware receive timestamps via
bpf_xdp_metadata_rx_timestamp(). It also installs virtnet_xdp_metadata_ops
when VIRTIO_NET_F_RX_TSTAMP is negotiated.

> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index 23af10c613b48..e79b65653fad7 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -6848,8 +6848,30 @@ static int virtnet_xdp_rx_hash(const struct xdp_md=
 *_ctx, u32 *hash,
>  	return 0;
>  }
> =20
> +static int virtnet_xdp_rx_timestamp(const struct xdp_md *_ctx, u64 *time=
stamp)
> +{
> +	const struct xdp_buff *xdp =3D (void *)_ctx;
> +	const struct virtio_net_common_hdr *hdr;
> +	struct virtnet_info *vi;
> +	u64 tstamp;
> +
> +	vi =3D netdev_priv(xdp->rxq->dev);
> +	if (!READ_ONCE(vi->hwts_rx_en))
> +		return -ENODATA;
> +
> +	hdr =3D (const struct virtio_net_common_hdr *)(xdp->data - vi->hdr_len);
> +	tstamp =3D get_unaligned_le64(hdr->tstamp);

[Severity: High]
Can reading hdr->tstamp in place from xdp->data - vi->hdr_len collide with
the XDP data_meta region when an XDP program uses bpf_xdp_adjust_meta()?

When VIRTIO_NET_F_RX_TSTAMP is negotiated and hardware rx timestamping is
enabled via virtnet_hwtstamp_set(), virtnet_probe() sets vi->hdr_len to 40
bytes:

drivers/net/virtio_net.c:virtnet_probe() {
	if (vi->has_rx_tstamp)
		vi->hdr_len =3D offsetofend(struct virtio_net_common_hdr, tstamp);
}

In the XDP receive paths (receive_small_xdp(), receive_mergeable_xdp() ->
virtnet_build_xdp_buff_mrg(), and virtnet_receive_xsk_buf()), the
virtio_net_common_hdr remains in the headroom immediately preceding
xdp->data, spanning [xdp->data - 40, xdp->data). Within that header,
hdr->tstamp sits at [xdp->data - 8, xdp->data) and hdr->hash_v1_hdr sits at
[xdp->data - 28, xdp->data - 20).

Documentation/networking/xdp-rx-metadata.rst notes that drivers must move
device-reserved metadata out of the [xdp->data_meta, xdp->data) area before
running the XDP program because XDP programs call bpf_xdp_adjust_meta()
first and then populate their custom metadata structure in [xdp->data_meta,
xdp->data) using the xdp_metadata kfuncs.

For example, in tools/testing/selftests/bpf/progs/xdp_hw_metadata.c:rx(),
where struct xdp_meta is 32 bytes:

	err =3D bpf_xdp_adjust_meta(ctx, -(int)sizeof(struct xdp_meta));
	if (err)
		return XDP_PASS;

	data =3D (void *)(long)ctx->data;
	meta =3D (void *)(long)ctx->data_meta;
	if (meta + 1 > data)
		return XDP_PASS;

	meta->hint_valid =3D 0;

	meta->xdp_timestamp =3D bpf_ktime_get_tai_ns();
	err =3D bpf_xdp_metadata_rx_timestamp(ctx, &meta->rx_timestamp);
	if (err)
		meta->rx_timestamp_err =3D err;
	else
		meta->hint_valid |=3D XDP_META_FIELD_TS;

	err =3D bpf_xdp_metadata_rx_hash(ctx, &meta->rx_hash,
				       &meta->rx_hash_type);

Here, initializing meta->hint_valid =3D 0 writes to [xdp->data - 4,
xdp->data), which overwrites the upper 32 bits of hdr->tstamp before
bpf_xdp_metadata_rx_timestamp() calls virtnet_xdp_rx_timestamp(). Then,
writing meta->xdp_timestamp and meta->rx_timestamp at [xdp->data - 32,
xdp->data - 16) overwrites hdr->hash_v1_hdr at [xdp->data - 28,
xdp->data - 22) before bpf_xdp_metadata_rx_hash() calls
virtnet_xdp_rx_hash().

Unlike the skb paths (receive_buf() and virtnet_receive_xsk_buf()), which
save the timestamp via virtnet_record_rx_tstamp() before invoking the XDP
program, virtnet_xdp_rx_timestamp() reads from the live buffer during XDP
execution. Should the driver extract or preserve the rx metadata outside
the [xdp->data_meta, xdp->data) region before running the XDP program?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261026-v6-7-topic=
-virtio-net-ptp-v4-0-008af03cd43b@pengutronix.de?part=3D5
