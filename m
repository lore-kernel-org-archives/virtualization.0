Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794698943;
	b=r4vQDPIPHiiUayjv5f5hglGLKMnwGP+YPzFhZK4ESj9af4nBWruo7ZbgRskdXWnxyO35
	 oeGIw+O5j9LX/vtZik3AmoNayyYVTgpzVU/q/L/gdFn+ogHfx9ZO2ULlZa2LPzvWvmIJr
	 RuQ8Pjw8DYNxQj4/nLfPEmSLinr4etB031tCcFeeIfNBETexvvLwLDlGnhkJmUW+ouAJ0
	 jtY81G102j82CJBjnak93dQIDn9MjtKn3zkLJ3EabRQoKMRkW2gVptkK1RyWdgcx+UQgs
	 C8orIW1htgXbw4Zr68KZFZGRVu7EAJVWLHccRPkRfJxHI6UOzC4IF8bhF8SO5bvnWsw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794698943;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=bRH/TacH8dOz70rq9aw6RE8h70NG6XrZSxT38CWyrSs=;
	b=deacIjir0/+TvaC4jojifQOUGjrhNKQcrWXMmNyO4ch3Wli5Xo5G0ql51/e1WbXpxAri
	 Pdy0QIN+FUZexKtXDK5ZO1jv75FNhUYOUlIOy9VAPdgq50/vwXuClT8u8vLkr9CMIFVd6
	 hC45lwfR89cfaeEfm8cqBCpxGUykysXAMkm8ytxUaSmhAWVN4mYXc8uE7PWdQRYXHqJvw
	 HP7hppgiANWJ1AYX3YnEP5Hu1KMAvhbBhuxAr11gAgXbRA4sxp2dBWLkjm2yL4xMVm4Am
	 Et6dnpa5z3cZu3fpJnheRQPZ6Xxu/FDcXRIwOnMYEQQfT1Wz+gm7pxnSSwgT0UDa9Qg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=F9+HNOCQ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BE04606A327;
	Sat, 14 Nov 2026 23:29:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=F9+HNOCQ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 862971F000CB;
	Sat, 14 Nov 2026 23:29:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794698942;
	bh=bRH/TacH8dOz70rq9aw6RE8h70NG6XrZSxT38CWyrSs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=F9+HNOCQAr+aE/ylCMHLdvVZPaAYEzwRO0EEILONaz9LufGLNMYmDkmQ/Tq0Zwqfq
	 mfoJ+Jmr1pKOEJkKQMVHNYHxawDGkjJ5PZOCT3U4a9i9SxZuNl+L7A+A1Td7LR/JfL
	 sE7X2HzhBtD2q5ap2aGNfvqDStJpI1iWKNBdK+IFqnedDrm85UUwY66Y4Y2ArOq3M6
	 GJ5d+DNJabo+BWe1SOBgnVTb8FUioLMZ097L86Pzqk1Spi8LudrsbiT60cl2+2/yc1
	 oLp45E4wbyXHJ/GGFoRSR0kcUX3+v/vDhZHnoQuVnSmCy8kRB4zqiUIb/hXNh+IoB3
	 nT1l+ERDuS/BQ==
Message-ID: <sashiko-outbox-215112@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net] tun: complete the zerocopy buffer of packets
 consumed by XDP
Reply-To: sashiko-reviews@lists.linux.dev
To: "Antonio Quartulli" <antonio@mandelbit.com>
Cc: virtualization@lists.linux.dev, bpf@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <20261113232843.2338734-1-antonio@mandelbit.com>
References: <20261113232843.2338734-1-antonio@mandelbit.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 14 Nov 2026 23:29:02 +0000
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
- [Critical] tun: type confusion in tun_napi_alloc_frags() [1]
--

commit 432dd92fb61360561c1a6f28a7f9ecf8e823ad4c
Author: Antonio Quartulli <antonio@mandelbit.com>

tun: complete the zerocopy buffer of packets consumed by XDP

This commit completes the caller's zerocopy ubuf_info as copied when
tun_build_skb() copies the packet and native XDP consumes it.

Link: https://sashiko.dev/#/bug/linux-f9997fb6-303f-41d6-93e2-60c392b1856f

> diff --git a/drivers/net/tun.c b/drivers/net/tun.c
> index 86fd44e107550..9271968407253 100644
> --- a/drivers/net/tun.c
> +++ b/drivers/net/tun.c
> @@ -1871,8 +1871,15 @@ static ssize_t tun_get_user(struct tun_struct *tun=
, struct tun_file *tfile,
>  		err =3D PTR_ERR_OR_ZERO(skb);
>  		if (err)
>  			goto drop;
> -		if (!skb)
> +		if (!skb) {
> +			/* consumed by XDP, after copying */
> +			if (msg_control) {
> +				struct ubuf_info *uarg =3D msg_control;
> +
> +				uarg->ops->complete(NULL, uarg, false);
> +			}
>  			return total_len;
> +		}
>  	} else {
>  		if (!zerocopy) {
>  			copylen =3D len;

[Severity: Critical]
This problem wasn't introduced by this patch, but can
tun_napi_alloc_frags() in the adjacent else branch corrupt memory when
tun_get_user() is called with a non-iovec iterator [1]?

drivers/net/tun.c:tun_get_user() {
    ...
		if (frags) {
			mutex_lock(&tfile->napi_mutex);
			skb =3D tun_napi_alloc_frags(tfile, copylen, from);
    ...
}

drivers/net/tun.c:tun_napi_alloc_frags() {
    ...
	for (i =3D 1; i < it->nr_segs; i++) {
		const struct iovec *iov =3D iter_iov(it) + i;
		size_t fragsz =3D iov->iov_len;
    ...
		frag =3D netdev_alloc_frag(fragsz);
    ...
}

When IFF_NAPI_FRAGS is enabled and a caller writes to the tun device using
an ITER_BVEC iterator (for example via splice() or io_uring),
tun_napi_alloc_frags() treats the bio_vec array as an iovec array via
iter_iov(it). Reading iov->iov_len from a struct bio_vec produces a bogus
fragment size from bv_len and bv_offset, causing skb_copy_datagram_from_ite=
r()
to overflow the allocated skb fragments.

[1] https://sashiko.dev/#/bug/linux-ddceb3c7-6f22-48cf-b390-d7b534490c8f

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261113232843.2338=
734-1-antonio@mandelbit.com?part=3D1
