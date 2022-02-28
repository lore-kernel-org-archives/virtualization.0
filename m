Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8173DC433EF
	for <virtualization@archiver.kernel.org>; Mon, 28 Feb 2022 10:52:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 0E4BE817ED;
	Mon, 28 Feb 2022 10:52:12 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ld6ktcLNi5GB; Mon, 28 Feb 2022 10:52:11 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 9B191817B5;
	Mon, 28 Feb 2022 10:52:10 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 6C68FC0033;
	Mon, 28 Feb 2022 10:52:10 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id ACD3CC001A
 for <virtualization@lists.linux-foundation.org>;
 Mon, 28 Feb 2022 10:52:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 8C6A1605AE
 for <virtualization@lists.linux-foundation.org>;
 Mon, 28 Feb 2022 10:52:08 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id wZgSKNdpAcYm
 for <virtualization@lists.linux-foundation.org>;
 Mon, 28 Feb 2022 10:52:07 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 44191600B4
 for <virtualization@lists.linux-foundation.org>;
 Mon, 28 Feb 2022 10:52:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1646045525;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=IVYeDVfzq28sn8+/lq8Z6rjLomlALnQoJ59O71VHfzQ=;
 b=EhTInOkhnU/wnIENO0TgsgBtMuj23jdbyIL4rKq67DWHtv1KzCyyyEAD5FZwk+zbg+b3mX
 HkOMMAe1UkJxOoU3CWHVmmM7xTac0siLNjfdSgfWt2bUFNwHqg4X20WvA6Jgp5XJjvRPGg
 PY9j3UpWR02997hmTU3yNBQP/+Xtz/Q=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-92-q7kWgGG-NKuf4SMC_VkNLg-1; Mon, 28 Feb 2022 05:52:01 -0500
X-MC-Unique: q7kWgGG-NKuf4SMC_VkNLg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 499E651E0;
 Mon, 28 Feb 2022 10:52:00 +0000 (UTC)
Received: from localhost (unknown [10.39.193.171])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 9241182E57;
 Mon, 28 Feb 2022 10:51:57 +0000 (UTC)
Date: Mon, 28 Feb 2022 10:51:56 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Akihiko Odaki <akihiko.odaki@gmail.com>
Subject: Re: [PATCH] virtio-blk: Assign discard_granularity
Message-ID: <YhypTNtWpcgh3gb2@stefanha-x1.localdomain>
References: <20220224093802.11348-1-akihiko.odaki@gmail.com>
MIME-Version: 1.0
In-Reply-To: <20220224093802.11348-1-akihiko.odaki@gmail.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Cc: Jens Axboe <axboe@kernel.dk>, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, linux-block@vger.kernel.org,
 Paolo Bonzini <pbonzini@redhat.com>, Christoph Hellwig <hch@lst.de>
X-BeenThere: virtualization@lists.linux-foundation.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: Linux virtualization <virtualization.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>, 
 <mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>, 
 <mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============5755531925787025672=="
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>


--===============5755531925787025672==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="o6KFt0EAQYlUHcer"
Content-Disposition: inline


--o6KFt0EAQYlUHcer
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 24, 2022 at 06:38:02PM +0900, Akihiko Odaki wrote:
> Virtual I/O Device (VIRTIO) Version 1.1
> https://docs.oasis-open.org/virtio/virtio/v1.1/csprd01/virtio-v1.1-csprd0=
1.html
> > discard_sector_alignment can be used by OS when splitting a request
> > based on alignment.
>=20
> According to Documentation/ABI/stable/sysfs-block, the corresponding
> field in the kernel is, confusingly, discard_granularity, not
> discard_alignment.

Good catch, struct virtio_blk_config->discard_sector_alignment is Linux
q->limits.discard_granularity.

>=20
> Signed-off-by: Akihiko Odaki <akihiko.odaki@gmail.com>
> ---
>  drivers/block/virtio_blk.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
>=20
> diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
> index c443cd64fc9b..1fb3c89900e3 100644
> --- a/drivers/block/virtio_blk.c
> +++ b/drivers/block/virtio_blk.c
> @@ -913,11 +913,9 @@ static int virtblk_probe(struct virtio_device *vdev)
>  		blk_queue_io_opt(q, blk_size * opt_io_size);
> =20
>  	if (virtio_has_feature(vdev, VIRTIO_BLK_F_DISCARD)) {
> -		q->limits.discard_granularity =3D blk_size;
> -
>  		virtio_cread(vdev, struct virtio_blk_config,
>  			     discard_sector_alignment, &v);
> -		q->limits.discard_alignment =3D v ? v << SECTOR_SHIFT : 0;

Should we use struct virtio_blk_config->topology.alignment_offset
("offset of first aligned logical block" and used for Linux
blk_queue_alignment_offset()) for q->limits.discard_alignment?

--o6KFt0EAQYlUHcer
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmIcqUsACgkQnKSrs4Gr
c8gvvgf8CUBI66KzLI88mzNHI2Vrynk7iPeOE+nt95l0+w7br24PncTRvUQCHPko
u1d/0UZcCsOAG9cW5CSwRRQedrVbCrhNaJm6KywnghK/41SCcMHDJEAwQNyX9GCy
FvmYghT9oHxhkucTD91oVuD0Sk714G2ikPNleZmijh/+kn224gCy1eP/3/S/KWGr
/edZF24TIDpujQNdR9emr+UF7eLoWBC3n/ldoDVU+fmgXaCIT2DjZXbsqiu6Cjir
ytI7KakJsyjFuWMXTSEIg9RKV0GRJTj/YYLspFMNEDZGv2ikaMatl/MNxDNpDvln
+bylNvU54z5CWo7wObRdwWmybWOTzw==
=Ldv1
-----END PGP SIGNATURE-----

--o6KFt0EAQYlUHcer--


--===============5755531925787025672==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--===============5755531925787025672==--

