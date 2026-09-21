Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 554E04AAC6D;
	Mon, 21 Sep 2026 14:57:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790002655; cv=none; b=gI9DqQQSaBYZi161VbgBkRCJMezEMMrHIHrRuSwZlaokRu7wEH4KJ7BJ2MfaEpgfrPjlqTXJABRcMD8OasZ4ZNEgtEMG/RWWuD34dNYAIfj4LgKJZ/ZPTHkyHGPAm0t5MpS7ghXZi67rYGuP2W6zDTnY/6D95ChtarpOC4fk+RU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790002655; c=relaxed/simple;
	bh=3gOyPAAyRM14ppvX9qybOzAOjaNGAodcNKPhkswsOVU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=etb04JjOvxfvcOvclRqPVE4+ceOtguBgI2Jj22ENldNvERAKMDC/FA7tPr1dW3F9BLpwQ2t2pNjCjXp3G/ktgohJtlLpcwC2s3dStvcxF0ik1J9bVHdjF2VOxs5XMrCerQF9YQ4UYJzD0s5E77RLWfkQvI8pTTBTIZyoAimNLoc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kyBEG052; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kyBEG052"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C61A1F00893;
	Mon, 21 Sep 2026 14:57:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790002651;
	bh=qsVGzYTxLq6Dv3XSWGte/36iDt1vGem0gxVwLaOTeck=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=kyBEG052qh3xVqmNRteq6D99wUF5/UPDqE4hhvvtwyrEraePwjKCFE1byOSLVgEJK
	 9/xfc8SGInVFRrHkXYHVS+PE2g/uQ9t3eynnxt1x8gM0hbPGg2pRCop7NhLWy8UQu8
	 u5/lYYa3kq8suESCr40XjD+F7rCwaJXCTNc5nYzFXQKH38y1Dy9xXEkjpTkdX1gf8P
	 EI62N9804GUtBEDEglsebDBLkdYgCw0Fa+otZE86Akkg1E4EfCbW7cerXzg1m65cWW
	 bYoldwtWc8sTWgjwzthwdQhIWmmIo+86cQPTHo2pGHtWagp7IxnRpyrwhNqnHqP2Po
	 /D8cAjXHm8DfQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC v3 2/2] tun: support rx-tstamp
Reply-To: sashiko-reviews@lists.linux.dev
To: "Steffen Trumtrar" <s.trumtrar@pengutronix.de>
Cc: virtualization@lists.linux.dev, "Eugenio Perez" <eperezma@redhat.com>, bpf@vger.kernel.org, "Michael
 S. Tsirkin" <mst@redhat.com>
In-Reply-To: <20260921-v6-7-topic-virtio-net-ptp-v3-2-3350851c4f88@pengutronix.de>
References: <20260921-v6-7-topic-virtio-net-ptp-v3-0-3350851c4f88@pengutronix.de>
 <20260921-v6-7-topic-virtio-net-ptp-v3-2-3350851c4f88@pengutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 21 Sep 2026 14:57:30 +0000
Message-Id: <20260921145731.1C61A1F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [High] net: info leak via out-of-bounds stack read in __tun_vnet_hdr_put()
- [High] net: truncation of extended virtio-net headers breaks offloads in =
__tun_vnet_hdr_get()
- [Medium] net: incorrect endianness when storing virtio-net timestamp in t=
un_put_user()
--

commit f6ec01e41ac769b584380d489021709a59d0a180
Author: Steffen Trumtrar <s.trumtrar@pengutronix.de>

tun: support rx-tstamp

Demonstrate support for new virtio-net features
VIRTIO_NET_HDR_F_TSTAMP

[ ... ]

> diff --git a/drivers/net/tun.c b/drivers/net/tun.c
> index 5a302709a68aa..924784771b6b7 100644
> --- a/drivers/net/tun.c
> +++ b/drivers/net/tun.c
> @@ -2157,12 +2157,23 @@ static ssize_t tun_put_user(struct tun_struct *tu=
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
> +		/* hdr has at least the size up to and including the tstamp field. */
> +		if (vnet_hdr_sz >=3D offsetof(struct virtio_net_common_hdr, tstamp) +
> +				   sizeof_field(struct virtio_net_common_hdr, tstamp)) {
> +			u64 tstamp =3D ktime_get_clocktai_ns();
> +
> +			hdr.tstamp[0] =3D (tstamp & 0x000000000000ffffULL) >> 0;
> +			hdr.tstamp[1] =3D (tstamp & 0x00000000ffff0000ULL) >> 16;
> +			hdr.tstamp[2] =3D (tstamp & 0x0000ffff00000000ULL) >> 32;
> +			hdr.tstamp[3] =3D (tstamp & 0xffff000000000000ULL) >> 48;

[Severity: Medium]
Since tstamp is defined as a __virtio16 array, does this need to use
cpu_to_tun_vnet16() for byte swapping?

Assigning a host-endian value directly using native 16-bit shifts could cor=
rupt
the timestamp when read by the guest if the negotiated virtio endianness di=
ffers
from the host native endianness.

> +		}
> +
>  		ret =3D tun_vnet_hdr_tnl_from_skb(tun->flags, tun->dev, skb,

[ ... ]

> diff --git a/drivers/net/tun_vnet.h b/drivers/net/tun_vnet.h
> index f4c652b1fa44d..0a7fe1ce889b5 100644
> --- a/drivers/net/tun_vnet.h
> +++ b/drivers/net/tun_vnet.h
> @@ -122,15 +119,20 @@ static inline int __tun_vnet_hdr_get(int sz, unsign=
ed int flags,
>  				     struct iov_iter *from,
>  				     struct virtio_net_hdr *hdr)
>  {
> -	unsigned int parsed_size =3D tun_vnet_parse_size(features);
> +	unsigned int parsed_size =3D tun_vnet_parse_size(sz);
> +	u8 tmp[sizeof(struct virtio_net_common_hdr)]; // temp buffer with known=
 size
>  	u16 hdr_len;
> =20
>  	if (iov_iter_count(from) < sz)
>  		return -EINVAL;
> =20
> -	if (!copy_from_iter_full(hdr, parsed_size, from))
> +	/* copy parsed size data to the tmp buffer, otherwise compiler will com=
plain */
> +	if (!copy_from_iter_full(tmp, parsed_size, from))
>  		return -EFAULT;
> =20
> +	/* now copy the relevant data from tmp to hdr */
> +	memcpy(hdr, tmp, min(parsed_size, sizeof(*hdr)));

[Severity: High]
Does this artificially limit the copy to exactly 10 bytes?

Because hdr is passed as a pointer to struct virtio_net_hdr, sizeof(*hdr)
evaluates statically to 10 bytes.

Callers like tun_get_user() might allocate a larger structure, but they will
only receive 10 bytes, causing extended virtio-net header fields (such as h=
ash
values or tunnel offsets) to be silently dropped.

> +
>  	hdr_len =3D tun_vnet16_to_cpu(flags, hdr->hdr_len);
> =20
>  	if (hdr->flags & VIRTIO_NET_HDR_F_NEEDS_CSUM) {
> @@ -155,14 +157,17 @@ static inline int tun_vnet_hdr_get(int sz, unsigned=
 int flags,
> =20
>  static inline int __tun_vnet_hdr_put(int sz, netdev_features_t features,
>  				     struct iov_iter *iter,
> -				     const struct virtio_net_hdr *hdr)
> +				     const struct virtio_net_common_hdr *hdr)
>  {
> -	unsigned int parsed_size =3D tun_vnet_parse_size(features);
> +	unsigned int parsed_size =3D tun_vnet_parse_size(sz);
> +	u8 buf[sizeof(*hdr)];
> =20
>  	if (unlikely(iov_iter_count(iter) < sz))
>  		return -EINVAL;
> =20
> -	if (unlikely(copy_to_iter(hdr, parsed_size, iter) !=3D parsed_size))
> +	memcpy(buf, hdr, parsed_size);

[Severity: High]
Could this copy leak uninitialized kernel stack memory to userspace?

Callers like tap_put_user() and tun_put_user_xdp() allocate a 10-byte
struct virtio_net_hdr on the kernel stack and pass its pointer to
tun_vnet_hdr_put().

Because tun_vnet_hdr_put() casts the 10-byte pointer to the 32-byte
struct virtio_net_common_hdr:

    return __tun_vnet_hdr_put(sz, 0, iter, (struct virtio_net_common_hdr *)=
hdr);

and parsed_size can be up to 32 bytes (depending on vnet_hdr_sz), this
memcpy could read 22 bytes past the end of the 10-byte struct.

> +
> +	if (unlikely(copy_to_iter(buf, parsed_size, iter) !=3D parsed_size))
>  		return -EFAULT;
>

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260921-v6-7-topic=
-virtio-net-ptp-v3-0-3350851c4f88@pengutronix.de?part=3D2
