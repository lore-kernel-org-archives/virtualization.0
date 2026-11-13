Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794568832;
	b=psv7oev7tSM2vBtmPWEEZH2uxwWYPKkFetRYCnbXTIARx/gJjdo3/GE7hhMNVhP0X/3K
	 0KJSIwDOebrncb3YnEyzh+bKUcBfWDF8FOkMjRrXcPwUudQk69vIWjugeBrumH6ds+sMY
	 9xScJwy0vZFGpsECar+f59mhKhQreGoLhRAfATz78xKe+BDuEED2vO2eyETgGw/lAqg15
	 +5/YswlJ8aejTwxFlYwUIaXMR70sxajL+8HEgTMJ9wxSxilt2ErvRfT6RejPJ3P1STEvb
	 Ic7sEeGO3mAJMdQm1u19jeB10jr9G/dstDklWehQbOd241KYiaLku3bhXB9faYeTcGQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794568832;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=yo3tGqQEfXTm9RsguiJAW1SqNi5Hd+PsnelrxCbKnJE=;
	b=sazL8kD06Cf+HAbnm5BejibzRf/XTei2oIZYDwOgiJPl01B511po17cjNhnhwkjr3mhy
	 tPwsXPZqnr8uppgAJoVxgz62Vtr30XTV+ElKwkhHvGXj0NgT+kyMddX8swIPGdlle0/dA
	 SeKMpewW17YcBN18aItiJ8YtqSL/wonrxG02VH15C79I2/uNXPpePYledcryTfpOP/3nw
	 wpvap+b+BYRyWolsYkS/lDFtG5Uc0reNRSvhaMmlL1c0FOymzYRmmGzRZRfZ7prEHdup+
	 9WuJps0gpLhKp7s75lImyCG7QJM6ceQHOjQqgChpA5vg1AyfwKBgBf1pJt1nSnWGveQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nx3yLL75;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 288E9606A895;
	Fri, 13 Nov 2026 11:20:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nx3yLL75
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6D031F000C9;
	Fri, 13 Nov 2026 11:20:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794568832;
	bh=yo3tGqQEfXTm9RsguiJAW1SqNi5Hd+PsnelrxCbKnJE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=nx3yLL75i94/sUYoNSDsxAcEEVxiD5o7r5ZJ9BfHMygF3DfFcnZN6bnBf2sga296o
	 Cb+3Ql/uPo9+HNroCE4Q5+LIOv3UMhOCVQdXKEuMzYofMIXbk8zS10fd6MSyK97loI
	 azTNvZxyLW45ejm13rW7cc+ya4N8RByq4vcyc1C11DvVFJwafm6RXxjeOlPddA6OqT
	 8/Ip/NR54pUS41HurMCvLnbBsKkRTE2r+E6CwGWM2kA/7AiIDjqm2rWRWHaKUNoTD/
	 InrpKds3oarU018YYHRkWOi4ucYcrqk3B2wv/85Xv4aW/4vOxBohFXEtq/qnkNd5+O
	 rasEkokBAYZSA==
Message-ID: <sashiko-outbox-212707@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net-next v5 7/9] vhost-net: support
 VIRTIO_NET_F_RX_TSTAMP
Reply-To: sashiko-reviews@lists.linux.dev
To: "Steffen Trumtrar" <s.trumtrar@pengutronix.de>
Cc: virtualization@lists.linux.dev, bpf@vger.kernel.org, kvm@vger.kernel.org, "Michael
 S. Tsirkin" <mst@redhat.com>, "Eugenio Perez" <eperezma@redhat.com>
In-Reply-To: <20261112-v6-7-topic-virtio-net-ptp-v5-7-7ab67b572f4f@pengutronix.de>
References: <20261112-v6-7-topic-virtio-net-ptp-v5-0-7ab67b572f4f@pengutronix.de>
 <20261112-v6-7-topic-virtio-net-ptp-v5-7-7ab67b572f4f@pengutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 13 Nov 2026 11:20:31 +0000
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
- [Medium] vhost-net: descriptor leak on vnet_hdr copy failure in
  handle_rx() [1]
--

commit 454489b63f879c752d31f70af8fbc748e0db8e54
Author: Steffen Trumtrar <s.trumtrar@pengutronix.de>

vhost-net: support VIRTIO_NET_F_RX_TSTAMP

This commit advertises VIRTIO_NET_F_RX_TSTAMP to userspace, sizes the
virtio-net header to include the receive timestamp field when negotiated,
and zeroes the remaining header bytes in handle_rx() when vhost supplies
the header.

> diff --git a/drivers/vhost/net.c b/drivers/vhost/net.c
> index 435d8ed3851f3..1b171af105a22 100644
> --- a/drivers/vhost/net.c
> +++ b/drivers/vhost/net.c

[ ... ]

> @@ -1278,6 +1283,16 @@ static void handle_rx(struct vhost_net *net)
>  			vhost_discard_vq_desc(vq, headcount, ndesc);
>  			goto out;
>  		}
> +		/* Zero the rest of a header supplied by vhost, e.g. tstamp */
> +		if (unlikely(vhost_hlen > hdr_filled)) {
> +			size_t rest =3D vhost_hlen - hdr_filled;
> +
> +			if (iov_iter_zero(rest, &fixup) !=3D rest) {
> +				vq_err(vq, "Failed vnet_hdr zeroing");
> +				vhost_discard_vq_desc(vq, headcount, ndesc);
> +				goto out;
> +			}
> +		}

[Severity: Medium]
This problem wasn't introduced by this patch, but does the error path
just above this hunk leak RX descriptors [1] when copying hdr fails?

drivers/vhost/net.c:handle_rx() {
	...
		if (unlikely(vhost_hlen)) {
			if (copy_to_iter(&hdr, sizeof(hdr),
					 &fixup) !=3D sizeof(hdr)) {
				vq_err(vq, "Unable to write vnet_hdr "
				       "at addr %p\n", vq->iov->iov_base);
				goto out;
			}
	...
}

Unlike the num_buffers and iov_iter_zero() failure paths, jumping to out
there skips vhost_discard_vq_desc(vq, headcount, ndesc), so the
descriptors consumed by get_rx_bufs() are neither rolled back nor
signalled as used.

[1] https://sashiko.dev/#/bug/linux-a8cbb3ff-e3eb-42fc-9cbf-3422af552e28

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261112-v6-7-topic=
-virtio-net-ptp-v5-0-7ab67b572f4f@pengutronix.de?part=3D7
