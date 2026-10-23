Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792771798;
	b=ge+qCahPvzTIPBO5gRe797iF7r5eJ0rPErmhIfpDzjk+HH1t+W/OSFex2WlMkpZD64vh
	 71TiZtIqFjJsvMCoaSLFemn7A1IMHgUm4VY5ZSVuld2I7Hq1QLGlLjeOxlooB/0RLfga4
	 3d2eyVSFx3+GjSW554b5/9yQVUuWC567DjaPkHNZ94O26WX2zMR7Jiw0dWOBE686LVmj0
	 K5qyvQ9QxrAgXneMtHiryI7TksX5VgQEVfWjq1wlPmK6dh3pWvgT0dpDV80iy2weXhbXb
	 Oadyzv+mZOSRA3/VpiiZKEv4JPXebKZgwpOh3xNjteB7rxHhnkH8ZcGkQJjmH+tsoTQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792771798;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=kCTwwhL6ohZT7GawzzqnUJaPWTDSKbO6N/tUvWyEtGI=;
	b=x219iYd5fToyGQwdDNxaTYTntiKktMEOd6SGJpUa63qeIlK9q+OfkcDaK9zfN+WodASp
	 Oc+Bm5hkTorevXYYZn75zIQmRKWCcS8exaLRnmc7ZoqLHdEv96tBJfyOc+6e8eRCssrLF
	 e2PlzAU9LXiHBlFGezY51SgUVsAfg7CpNSictH0vWDHqeEKzTdGbikqgd5FCehFXGl88U
	 FQNB3/mEknmb3ML9OCpZjCI3Ipn4UdcJs8wVZMwmFiTPMybl0BmPOEhH644pgYSVMVXS4
	 vb+0J+5pN8ToBhWJIJTgsW1aQYawguNYaxdK6XfUTAxi4jwNnfvMM5jsTxHQVU8zmcA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=I4N2q1FB;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FCFC606A321
	for <virtualization@lists.linux.dev>; Fri, 23 Oct 2026 16:09:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=I4N2q1FB
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9DD41F031E2;
	Fri, 23 Oct 2026 16:09:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792771798;
	bh=kCTwwhL6ohZT7GawzzqnUJaPWTDSKbO6N/tUvWyEtGI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=I4N2q1FBLHV/L9RVdtfyEjGVbFHVCtvg/NEgjNAiDtae+X18AE5Lw0UycXIatnEFe
	 eDNK8WEDzbT7EhtXkIMCJ00b36PImbrcDhaq/8QkSgMNUyXa5V/POjHXSrhy+byOao
	 sD3JAhZAZZmm24QyTCP28aAhR1496mPCruDJFlSrbdFb0fHcsDpP3tIg13uEiKiEYP
	 S2lIJ1jSFZnpquHutRQDrTpTqgxYQiRwiJ8HskUaFY/ILoOkhCOs72tkJrCop5KbFT
	 qrpuCuw/Yke8C5jHXbXmGid/VkYbn1yeGEHKKG8rXl2SxhdRXnWh9OryC/8UxJcOjw
	 qkV+QSp/rWY8Q==
Message-ID: <sashiko-outbox-182939@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net] net: virtio_net: decode tunnel csum_start as
 little-endian
Reply-To: sashiko-reviews@lists.linux.dev
To: "Cheng Yongkang" <teel4res@gmail.com>, virtualization@lists.linux.dev
Cc: "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio Perez" <eperezma@redhat.com>
In-Reply-To: <179268538303.70821.1734486381476363942@gmail.com>
References: <179268538303.70821.1734486381476363942@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 23 Oct 2026 16:09:57 +0000
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
- [Low] net: virtio_net: sparse __virtio16 mismatch in virtio_net_hdr_tnl_t=
o_skb()
--

commit ba7ce0ae4b2dfb77c6b110ada68faaf66de9237f
Author: Cheng Yongkang <teel4res@gmail.com>

net: virtio_net: decode tunnel csum_start as little-endian

This commit changes virtio_net_hdr_tnl_to_skb() in include/linux/virtio_net=
.h
to always decode hdr->csum_start as little-endian during tunnel header offs=
et
validation, matching the subsequent call to __virtio_net_hdr_to_skb().

> diff --git a/include/linux/virtio_net.h b/include/linux/virtio_net.h
> index d6466f96cdd00..ddc6341747e53 100644
> --- a/include/linux/virtio_net.h
> +++ b/include/linux/virtio_net.h
> @@ -324,7 +324,7 @@ virtio_net_hdr_tnl_to_skb(struct sk_buff *skb,
>  	inner_l3min =3D virtio_l3min(inner_isv6);
>  	outer_l3min =3D ETH_HLEN + virtio_l3min(outer_isv6);
> =20
> -	inner_th =3D __virtio16_to_cpu(little_endian, hdr->csum_start);
> +	inner_th =3D le16_to_cpu(hdr->csum_start);
>  	inner_nh =3D le16_to_cpu(vhdr->inner_nh_offset);
>  	outer_th =3D le16_to_cpu(vhdr->outer_th_offset);
>  	if (outer_th < outer_l3min ||

[Severity: Low]
Does passing hdr->csum_start directly to le16_to_cpu() in
virtio_net_hdr_tnl_to_skb() trigger sparse endianness warnings when building
callers such as drivers/net/virtio_net.c and drivers/net/tun.c with C=3D1?

Unlike vhdr->inner_nh_offset and vhdr->outer_th_offset, which are declared =
as
__le16 in struct virtio_net_hdr_v1_hash_tunnel, hdr->csum_start is declared=
 as
__virtio16 in include/uapi/linux/virtio_net.h:

struct virtio_net_hdr {
	...
	__virtio16 csum_start;	/* Position to start checksumming from */
	__virtio16 csum_offset;	/* Offset after that to place checksum */
};

In include/linux/virtio_byteorder.h, __virtio16_to_cpu() performs the forced
cast from __virtio16 to __le16 before calling le16_to_cpu():

static inline u16 __virtio16_to_cpu(bool little_endian, __virtio16 val)
{
	if (little_endian)
		return le16_to_cpu((__force __le16)val);
	else
		return be16_to_cpu((__force __be16)val);
}

Should this use __virtio16_to_cpu(true, hdr->csum_start) instead, matching =
the
__virtio_net_hdr_to_skb(skb, hdr, true, ...) call below and
__cpu_to_virtio16(true, hdr_len) in __virtio_net_set_tnl_hdrlen()?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/179268538303.70821.=
1734486381476363942@gmail.com?part=3D1
