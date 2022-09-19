Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E288ECAAD3
	for <virtualization@archiver.kernel.org>; Mon, 19 Sep 2022 17:33:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 1B2EC605DB;
	Mon, 19 Sep 2022 17:33:49 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 1B2EC605DB
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=WQQKunWO
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id gCnivPuobfQL; Mon, 19 Sep 2022 17:33:48 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id BBABA605B5;
	Mon, 19 Sep 2022 17:33:47 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org BBABA605B5
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 6DECEC0033;
	Mon, 19 Sep 2022 17:33:47 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id CB83FC002D
 for <virtualization@lists.linux-foundation.org>;
 Mon, 19 Sep 2022 17:33:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id A6799605B5
 for <virtualization@lists.linux-foundation.org>;
 Mon, 19 Sep 2022 17:33:46 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org A6799605B5
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id AfHMmSzmg9Ha
 for <virtualization@lists.linux-foundation.org>;
 Mon, 19 Sep 2022 17:33:45 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 38F3C6058B
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 38F3C6058B
 for <virtualization@lists.linux-foundation.org>;
 Mon, 19 Sep 2022 17:33:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1663608824;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=6sK70mhDq9uV850PUULkvi4HRj6+ugLGy+X1u9Wx5Yc=;
 b=WQQKunWOM7vOmNSvKjK3IXs90vwWhfBpzN4qNz3SOj+dQaI+G5PRNJ8ksJOmqoe0jPokmO
 ouM0RvS718/CaW0i/8BpTIUh8zqIdCO8pnaMR/4lKZI0Z918zKrg5DfREBS29ZKXhHYGyT
 5GevXFz5nmjwvfcdc1tD+IpO+hqmXc8=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-88-4-B5O2LQOhWtg4dyhC8Mxg-1; Mon, 19 Sep 2022 13:33:42 -0400
X-MC-Unique: 4-B5O2LQOhWtg4dyhC8Mxg-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com
 [10.11.54.10])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E816D29ABA11;
 Mon, 19 Sep 2022 17:33:41 +0000 (UTC)
Received: from localhost (unknown [10.39.192.78])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 4BF8E492B09;
 Mon, 19 Sep 2022 17:33:41 +0000 (UTC)
Date: Mon, 19 Sep 2022 13:33:39 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Alvaro Karsz <alvaro.karsz@solid-run.com>
Subject: Re: [PATCH v2] virtio_blk: add SECURE ERASE command support
Message-ID: <Yyin8zSKJb3GPFno@fedora>
References: <20220829082313.419220-1-alvaro.karsz@solid-run.com>
MIME-Version: 1.0
In-Reply-To: <20220829082313.419220-1-alvaro.karsz@solid-run.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
Cc: Jens Axboe <axboe@kernel.dk>, Paolo Bonzini <pbonzini@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 virtualization@lists.linux-foundation.org
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
Content-Type: multipart/mixed; boundary="===============1726507251105943782=="
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>


--===============1726507251105943782==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="LTi4vT2WX1CwQQ9+"
Content-Disposition: inline


--LTi4vT2WX1CwQQ9+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 29, 2022 at 11:23:13AM +0300, Alvaro Karsz wrote:
> @@ -1075,6 +1068,57 @@ static int virtblk_probe(struct virtio_device *vde=
v)
>  		blk_queue_max_write_zeroes_sectors(q, v ? v : UINT_MAX);
>  	}
> =20
> +	if (virtio_has_feature(vdev, VIRTIO_BLK_F_SECURE_ERASE)) {
> +		/* The discard alignment value should be the minimum between
> +		 * secure_erase_sector_alignment and discard_sector_alignment
> +		 * (if VIRTIO_BLK_F_DISCARD is negotiated).
> +		 */
> +		virtio_cread(vdev, struct virtio_blk_config,
> +			     secure_erase_sector_alignment, &v);
> +		if (v) {
> +			if (discard_granularity)
> +				discard_granularity =3D min(discard_granularity, v);
> +			else
> +				discard_granularity =3D v;

This can be simplified with min_not_zero().

> +		}
> +
> +		virtio_cread(vdev, struct virtio_blk_config,
> +			     max_secure_erase_sectors, &v);
> +		blk_queue_max_secure_erase_sectors(q, v ? v : UINT_MAX);
> +
> +		/* The max discard segments value should be the minimum between
> +		 * max_secure_erase_seg and max_discard_seg (if VIRTIO_BLK_F_DISCARD
> +		 * is negotiated).
> +		 */
> +		virtio_cread(vdev, struct virtio_blk_config,
> +			     max_secure_erase_seg, &v);
> +		if (v) {
> +			if (max_discard_segs)
> +				max_discard_segs =3D min(max_discard_segs, v);
> +			else
> +				max_discard_segs =3D v;

Same here.

> +		}
> +	}
> +
> +	if (virtio_has_feature(vdev, VIRTIO_BLK_F_DISCARD) ||
> +	    virtio_has_feature(vdev, VIRTIO_BLK_F_SECURE_ERASE)) {

It's worth including a comment here that the discard and secure erase
limits are combined because the Linux block layer only has one limit
value. If the block layer supported independent limit values we wouldn't
need to do this.

--LTi4vT2WX1CwQQ9+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmMop/IACgkQnKSrs4Gr
c8h/KwgAsXq5jLJ//Aga3I+p79D4pGwiLUP/X4Dn5vx2WFmYTCzaqIQBmc+xP1JA
y41rrEh9mYroPLiPUsN2W/62uEOT4YLZqhcg/vNv8u36DJ+dwI2Fl1KpvZMRK+Dh
qdW831Xy0EPmUtWR4cpu7ChbWQC38bXkpdh2ijZkQrw845wsfXq1JBsia82SNUHg
5p7fIhDYyMvNh0U5MMyCiCv+7cytPP1FeIMgBT0DkORLbFu5SZ5RCIk2nvk+hXC9
3ss51P6T8RtcLAfmAcslO1imeEtwCGRMV8dzrtHD5zcleHfBBDFi0yh+SVWZ3yVN
UYf6FTS/n6dKpyN95sij52qRAVmkNg==
=qtXe
-----END PGP SIGNATURE-----

--LTi4vT2WX1CwQQ9+--


--===============1726507251105943782==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--===============1726507251105943782==--

