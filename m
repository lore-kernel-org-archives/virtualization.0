Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795157265;
	b=r5nJI91HZVf9st0gYHXTq25JdpaakdQm6gHS1TNyTbljhS6MtmizNOUvvcKzprfNHCyF
	 E7PKuF/KlMkTvpgztFl0qPSy8RFgCLF0ClwAAX7ED4bFD3oxUx1eBAyo7dnWkTE6JYyQl
	 sU2s0VL83QO+uIKEAJB4L8Gdw6l3ln/fP8Iqyoi0PgzpCyHdkrVhvb1PkcTiOL8E84GGa
	 lV9hZnNvezTyP3DEdf+jkUjXF/Vb9WBBTvgnhbmNyFuoHPeLL2xTAm8D8F53ZzVQhacV6
	 Er1djFErCqPSWeJZkHU6WTrx6DuHhHxsFI7z5CHsNgFLJ0S6hjR42mk40TZNbCTWwwQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795157265;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=VB+j8v0JQ20N98gDavEgqfBPm+ZfHMa1TwICwadVbvY=;
	b=EiSJ8rJUMkbNb+OrfOqG3dLa5jKmt3V9Xbrbudew3qjW64aal4xNt657AJ64Op+Lhr7P
	 EvDzUx2Egq94NqVorPwqX4DjkndZWGK2J0FnUIiGIEcn5RdZx0I64xsoDRE027J7jAgFn
	 3qlgp80tY5qJK9n1HmKXC+H4rDgYuJTpRriJbTYCaHiidPA2Ufum76FwdcFeVKT8vPEDt
	 cO+uzVUSZfjQY/w8MCZrTNb7Xc1MBUD8PmCGgHtNvuRn5qzSdkSoHfQ86Mr9fK8AtPnF+
	 hTdHfZ7GK9gGEpCqbMgi4LYjiht3+59Un1HkTixAdgI8H6AG5aVjR0BRPgwErTRUc3A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GkU2hrzL;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72F59606A320
	for <virtualization@lists.linux.dev>; Fri, 20 Nov 2026 06:47:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GkU2hrzL
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BAF561F000C4;
	Fri, 20 Nov 2026 06:47:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795157265;
	bh=VB+j8v0JQ20N98gDavEgqfBPm+ZfHMa1TwICwadVbvY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=GkU2hrzLvamgIsF6fZNOeQCQvaxm2LgEQJRjECj4ZiWWC6QNU0XFKkiwfcSFVpyu5
	 qHmxMYduDEABNdTdVullHuPF+TVWeOvA8ZID7mCdmtvxceNBOMoUr7xMSXvVQLrabf
	 5KbV0ndTjQa2cLIUWDXdbS20P7Apj0SEW90+YMjXwfpqsdXKqzwqMDAEAMHz0L3F7L
	 tYdB4anWwvjUewfwX6BtaV6yo8kJLfMwDfpsUIhXVTL4UWjlw/nxJhF+tVKguY4YK6
	 ISkRLdgHqekNKslJySJZHM32UMoNqp09sChWVUCv9jzSSqrWsZvO++5x2fJ1MTbvhi
	 5tupaoQfBxzKw==
Message-ID: <sashiko-outbox-224582@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] virtio_blk: validate zone append sector from device
Reply-To: sashiko-reviews@lists.linux.dev
To: "Annie Kim" <pulpannie@gmail.com>
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <20261120063039.4155597-1-pulpannie@gmail.com>
References: <20261120063039.4155597-1-pulpannie@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 20 Nov 2026 06:47:44 +0000
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [Medium] virtio_blk: double virtblk_update_zone_append_sector() call
  in virtblk_poll()
It also noticed 1 related pre-existing issue this patch does not
introduce:
- [Critical] virtio-blk: null pointer dereference in virtblk_poll() [1]
--

commit 9e4aa32cc96237b908b67c8c0ca12ebb3020f3a1
Author: Hyokyung Kim <pulpannie@gmail.com>

virtio_blk: validate zone append sector from device

This commit validates the device-reported starting sector on
REQ_OP_ZONE_APPEND completions in both the normal and polled completion
paths before updating req->__sector, failing out-of-range completions with
BLK_STS_IOERR.

> diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
> index 2b462005cdb68..8f88570b4f0e5 100644
> --- a/drivers/block/virtio_blk.c
> +++ b/drivers/block/virtio_blk.c
> @@ -331,15 +331,45 @@ static inline u8 virtblk_vbr_status(struct virtblk_=
req *vbr)
>  	return *((u8 *)&vbr->in_hdr + vbr->in_hdr_len - 1);
>  }
> =20
> -static inline void virtblk_update_zone_append_sector(struct request *req,
> -						     struct virtblk_req *vbr)
> +#ifdef CONFIG_BLK_DEV_ZONED
> +static inline blk_status_t
> +virtblk_update_zone_append_sector(struct request *req,
> +				  struct virtblk_req *vbr,
> +				  blk_status_t status)
>  {
>  	struct virtio_blk *vblk =3D req->mq_hctx->queue->queuedata;
> +	sector_t req_start, sector, zone_end;
> +	unsigned int nr_sectors;
> +
> +	if (req_op(req) !=3D REQ_OP_ZONE_APPEND || status !=3D BLK_STS_OK)
> +		return status;
> +
> +	req_start =3D blk_rq_pos(req);
> +	sector =3D virtio64_to_cpu(vblk->vdev, vbr->in_hdr.zone_append.sector);
> +	nr_sectors =3D blk_rq_sectors(req);
> +	zone_end =3D req_start + disk_zone_capacity(vblk->disk, req_start);
> +
> +	if (zone_end < req_start || sector < req_start || sector >=3D zone_end =
||
> +	    nr_sectors > zone_end - sector) {
> +		dev_err_ratelimited(&vblk->vdev->dev,
> +				    "zone append sector %llu + %u outside valid range [%llu, %llu)\n=
",
> +				    (u64)sector, nr_sectors,
> +				    (u64)req_start, (u64)zone_end);
> +		return BLK_STS_IOERR;
> +	}
> =20
> -	if (req_op(req) =3D=3D REQ_OP_ZONE_APPEND)
> -		req->__sector =3D virtio64_to_cpu(vblk->vdev,
> -						vbr->in_hdr.zone_append.sector);
> +	req->__sector =3D sector;
> +	return status;
>  }
> +#else
> +static inline blk_status_t
> +virtblk_update_zone_append_sector(struct request *req,
> +				  struct virtblk_req *vbr,
> +				  blk_status_t status)
> +{
> +	return status;
> +}
> +#endif
> =20
>  static inline void virtblk_request_done(struct request *req)
>  {
> @@ -349,7 +379,7 @@ static inline void virtblk_request_done(struct reques=
t *req)
>  	virtblk_unmap_data(req, vbr);
>  	virtblk_cleanup_cmd(req);
> =20
> -	virtblk_update_zone_append_sector(req, vbr);
> +	status =3D virtblk_update_zone_append_sector(req, vbr, status);
> =20
>  	blk_mq_end_request(req, status);
>  }

[ ... ]

> @@ -1260,11 +1289,14 @@ static int virtblk_poll(struct blk_mq_hw_ctx *hct=
x, struct io_comp_batch *iob)
> =20
>  	while ((vbr =3D virtqueue_get_buf(vq->vq, &len)) !=3D NULL) {
>  		struct request *req =3D blk_mq_rq_from_pdu(vbr);
> -		u8 status =3D virtblk_vbr_status(vbr);
> +		blk_status_t status;
> +
> +		status =3D virtblk_result(virtblk_vbr_status(vbr));
> +		status =3D virtblk_update_zone_append_sector(req, vbr, status);
> =20
>  		found++;
>  		if (!blk_mq_complete_request_remote(req) &&
> -		    !blk_mq_add_to_batch(req, iob, status !=3D VIRTIO_BLK_S_OK,
> +		    !blk_mq_add_to_batch(req, iob, status !=3D BLK_STS_OK,
>  					 virtblk_complete_batch))
>  			virtblk_request_done(req);
>  	}

[Severity: Medium]
Does calling virtblk_update_zone_append_sector() in virtblk_poll() before
falling back to virtblk_request_done() run the validation and update a
second time after req->__sector has already been overwritten?

When a polled REQ_OP_ZONE_APPEND request is not batched (for example when
an I/O scheduler is attached so RQF_SCHED_TAGS is set, when req->end_io is
set, or when validation itself returns BLK_STS_IOERR), virtblk_poll()
calls virtblk_request_done(), which recomputes status from vbr and calls
virtblk_update_zone_append_sector() again with req_start =3D blk_rq_pos(req)
now equal to the updated mid-zone sector rather than the zone start:

include/linux/blkdev.h:disk_zone_capacity() {
	sector_t zone_sectors =3D disk->queue->limits.chunk_sectors;

	if (sector + zone_sectors >=3D get_capacity(disk))
		return disk->last_zone_capacity;
	return disk->zone_capacity;
}

For a valid append in the second-to-last zone landing past the start of
that zone on a disk with a smaller last zone, sector + zone_sectors >=3D
get_capacity(disk) is true on the second call, so disk_zone_capacity()
returns last_zone_capacity and falsely fails the request with
BLK_STS_IOERR when nr_sectors > last_zone_capacity.  Even when all zones
have equal capacity, the second call shifts zone_end to sector +
zone_capacity and re-reads vbr->in_hdr from device memory, and any invalid
polled append logs dev_err_ratelimited() twice.

[Severity: Critical]
This problem wasn't introduced by this patch, but can virtblk_poll() hit a
NULL pointer dereference [1] on vq->lock if polled I/O runs after
init_vq() fails during device resume?

When virtio_find_vqs() fails in init_vq() (for instance if the hypervisor
reduces the ring size on resume), init_vq() frees vblk->vqs and sets it to
NULL while leaving the request queue quiesced but not frozen.  Because
blk_mq_poll() does not check whether the queue is quiesced, a userspace
polled read (such as preadv2() with RWF_HIPRI) calls virtblk_poll(), where
get_virtio_blk_vq() indexes the NULL vblk->vqs pointer and
spin_lock_irqsave(&vq->lock, flags) dereferences it.

[1] https://sashiko.dev/#/bug/linux-c7b06d8d-b2d5-4a94-acf6-9b1cf7480add

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261120063039.4155=
597-1-pulpannie@gmail.com?part=3D1
