Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 661EF2FE59C
	for <virtualization@lists.linux.dev>; Sat, 12 Sep 2026 19:30:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789241455; cv=none; b=bRvrk0nqxQND9vzcvqIgLrLIQrMpx8H1KxRwh5K3Ll9y1Sty99loQl6r53H0RLz2OrbZ6OAJCl4euJ5aEAvul0TXziCgVWi3P9I5qe/+Q0CL9nsX6I64RmVFQ0vqtJkGyLsBdmCuOA6Ls7zZxjONi0PFpyGh6M+p2yu9NcZ7+/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789241455; c=relaxed/simple;
	bh=ojC3q3C8iw+lqhy/pjwmjLBh5GjahkK3aJ3SM/pqC60=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=mcmrk6JJnR6i+HzuHg3G2i/T/12dkTcZ9ZO2cPJw2Tv1+Gea9609p9jwmVXE9pRkS2BkKHbR7DWmdqEd9a4NOru+XFpRXJy69FVy3r543NYsoBFfs/4HZXmvEtcKrpF1ZZ0+O1muGGL1pmmyp7fajqlGJqUdj8r/HCruqWsKwHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=irw5wrxF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="irw5wrxF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F096D1F00893;
	Sat, 12 Sep 2026 19:30:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789241454;
	bh=9VRA+oL9eeWKnwk/nffcCaoN2A66dv1J1CXlGYVMaQY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=irw5wrxF+z34atA4K9R7fj7UncuVBM3d2v5Zp/TXO5uCJh7lnBf5KWmvumSC16G0s
	 cuEFZfMhyIJOLFNxc2FYdH6oyWwLLgP/cjhNVN3yIZSbkmV3cBzemp/HbbOhUL6yQM
	 V9SRE9ndnLOxOdbLVQeYUzRjw16nAenAeC3CUD/xJLshGQjE2rYcZp2Pcd/lrWfpXc
	 Kelfom262REpjfYm4alfOrnF/3bixubSIWy5IVF6X6p9gCyjYM0hKKdd/Zd56az4GR
	 A5hbJmWGI7H7rlZRWgQqJuHKYUwHLrYc6QZQIAoDg40JDgKym9mkJZKHAmDpONW98u
	 +FnoI79A3D35w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] spi: virtio: Use the per-transfer bits per word
Reply-To: sashiko-reviews@lists.linux.dev
To: "Hao-Qun Huang" <alvinhuang0603@gmail.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, virtualization@lists.linux.dev, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <20260913032049.11209.alvinhuang0603@gmail.com>
References: <20260913032049.11209.alvinhuang0603@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 12 Sep 2026 19:30:53 +0000
Message-Id: <20260912193053.F096D1F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] The driver unconditionally uses sg_init_one() on xfer->tx_buf and =
xfer->rx_buf, causing a crash or memory corruption if the SPI buffers are a=
llocated via vmalloc.
--

commit c48c32e667f00c40f450ecae1a3af2defbfd7bc2
Author: Hao-Qun Huang <alvinhuang0603@gmail.com>

spi: virtio: Use the per-transfer bits per word

This commit updates the virtio SPI driver to correctly use the per-transfer
bits_per_word value instead of the device default. This ensures that
transfers with specific word sizes are not sent with partial words that the
backend might reject.

> diff --git a/drivers/spi/spi-virtio.c b/drivers/spi/spi-virtio.c
> index 2256dfec5407d..3e181bd8bc94b 100644
> --- a/drivers/spi/spi-virtio.c
> +++ b/drivers/spi/spi-virtio.c
> @@ -168,7 +168,7 @@ static int virtio_spi_transfer_one(struct spi_control=
ler *ctrl,
> =20
>  	/* Fill struct spi_transfer_head */
>  	th->chip_select_id =3D spi_get_chipselect(spi, 0);
> -	th->bits_per_word =3D spi->bits_per_word;
> +	th->bits_per_word =3D xfer->bits_per_word;
>  	th->cs_change =3D xfer->cs_change;
>  	th->tx_nbits =3D xfer->tx_nbits;
>  	th->rx_nbits =3D xfer->rx_nbits;

[Severity: High]
This is a pre-existing issue, but looking further down in
virtio_spi_transfer_one(), the driver unconditionally passes the transfer
buffers to sg_init_one():

    if (spi_req->tx_buf) {
        sg_init_one(&sg_out_payload, spi_req->tx_buf, xfer->len);
        ...
    }

    if (spi_req->rx_buf) {
        sg_init_one(&sg_in_payload, spi_req->rx_buf, xfer->len);
        ...
    }

Does this cause memory corruption or a kernel crash if the SPI buffers are
allocated via vmalloc?

The SPI core automatically bounce-buffers vmalloc memory into scatterlists,
but only if the driver indicates DMA support by implementing the can_dma
callback.

Since spi-virtio does not implement can_dma, __spi_map_msg() skips mapping
and passes the virtual addresses directly to virtio_spi_transfer_one().

If a SPI client passes a vmalloc'd buffer, passing it to sg_init_one() will
use virt_to_page() to compute an invalid struct page pointer.

When virtqueue_add_sgs() maps this scatterlist for DMA, would it calculate
a bogus physical address based on this invalid page, causing the virtio
device to overwrite or read from arbitrary physical memory, or triggering
an IOMMU fault?

Would this mean any in-kernel client submitting a vmalloc'd SPI buffer could
trigger this issue, leading to an unsafe DMA mapping that compromises kernel
integrity?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260913032049.1120=
9.alvinhuang0603@gmail.com?part=3D1
