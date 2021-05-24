Return-Path: <SRS0=LFKT=KT=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53E33C04FF3
	for <virtualization@archiver.kernel.org>; Mon, 24 May 2021 14:29:39 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D3185610FA
	for <virtualization@archiver.kernel.org>; Mon, 24 May 2021 14:29:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D3185610FA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 8DB6060690;
	Mon, 24 May 2021 14:29:38 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id HhVVu3uQh4Y3; Mon, 24 May 2021 14:29:37 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTP id 18D6F608CE;
	Mon, 24 May 2021 14:29:37 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D5F2EC000D;
	Mon, 24 May 2021 14:29:36 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 7A510C0001
 for <virtualization@lists.linux-foundation.org>;
 Mon, 24 May 2021 14:29:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 544B98282C
 for <virtualization@lists.linux-foundation.org>;
 Mon, 24 May 2021 14:29:35 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Cmkl0L-qWqjo
 for <virtualization@lists.linux-foundation.org>;
 Mon, 24 May 2021 14:29:34 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 50AEF827FB
 for <virtualization@lists.linux-foundation.org>;
 Mon, 24 May 2021 14:29:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1621866573;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=WT13q1pMxHOhrrWd66febvDPXSe0YMHyXf+o6UoqnWM=;
 b=Ln/Q2ILl0PqukuLoiT4y/9vQ6VWMpIZuz1lGJEWuqFFFVrESqL8wGc7oqIdARFEloFq1cc
 5mkgVyR8vosA2PsUl5u+3J/kgUIU4vtOYiQmVSsND59OX2T27Nmu8PNsYVt7jgU8Odd4de
 CSUXMptwuExQG7njChpybtv0JY2gkeA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-584-Bu9yS_usP0uBE5ud2dBIOQ-1; Mon, 24 May 2021 10:29:30 -0400
X-MC-Unique: Bu9yS_usP0uBE5ud2dBIOQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 89B23A40C4;
 Mon, 24 May 2021 14:29:28 +0000 (UTC)
Received: from localhost (ovpn-113-244.ams2.redhat.com [10.36.113.244])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 7F27D5C541;
 Mon, 24 May 2021 14:29:23 +0000 (UTC)
Date: Mon, 24 May 2021 15:29:22 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Yury Kamenev <damtev@yandex-team.ru>
Subject: Re: [PATCH 1/1] virtio: disable partitions scanning for no
 partitions block
Message-ID: <YKu4Qovv1KMplifY@stefanha-x1.localdomain>
References: <20210520133908.98891-1-damtev@yandex-team.ru>
 <20210520133908.98891-2-damtev@yandex-team.ru>
MIME-Version: 1.0
In-Reply-To: <20210520133908.98891-2-damtev@yandex-team.ru>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Cc: axboe@kernel.dk, mst@redhat.com, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, linux-block@vger.kernel.org,
 pbonzini@redhat.com, Christoph Hellwig <hch@lst.de>
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
Content-Type: multipart/mixed; boundary="===============5669918433091635963=="
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>


--===============5669918433091635963==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="zLquBuJmN54dXDIQ"
Content-Disposition: inline


--zLquBuJmN54dXDIQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 20, 2021 at 04:39:08PM +0300, Yury Kamenev wrote:

Hi,
Is there a VIRTIO spec change for the new VIRTIO_BLK_F_NO_PS feature
bit? Please send one:
https://www.oasis-open.org/committees/tc_home.php?wg_abbrev=3Dvirtio#feedba=
ck

GENHD_FL_NO_PART_SCAN is not used much in other drivers. This makes me
wonder if the same use case is addressed through other means with SCSI,
NVMe, etc devices. Maybe Christoph or Jens can weigh in on whether
adding a bit to disable partition scanning for a virtio-blk fits into
the big picture?

Is your goal to avoid accidentally detecting partitions because it's
confusing when that happens?

VIRTIO is currently undergoing auditing and changes to support untrusted
devices. From that perspective adding a device feature bit to disable
partition scanning does not help protect the guest from an untrusted
disk. The guest cannot trust the device, instead the guest itself would
need to be configured to avoid partition scanning of untrusted devices.

Stefan

> Signed-off-by: Yury Kamenev <damtev@yandex-team.ru>
> ---
>  drivers/block/virtio_blk.c      | 6 ++++++
>  include/uapi/linux/virtio_blk.h | 1 +
>  2 files changed, 7 insertions(+)
>=20
> diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
> index b9fa3ef5b57c..17edcfee2208 100644
> --- a/drivers/block/virtio_blk.c
> +++ b/drivers/block/virtio_blk.c
> @@ -799,6 +799,10 @@ static int virtblk_probe(struct virtio_device *vdev)
>  	vblk->disk->flags |=3D GENHD_FL_EXT_DEVT;
>  	vblk->index =3D index;
> =20
> +	/*Disable partitions scanning for no-partitions block*/

Formatting cleanup and rephrasing:

  /* Disable partition scanning for devices with no partitions */

> +	if (virtio_has_feature(vdev, VIRTIO_BLK_F_NO_PS))

I suggest user a more obvious name:

  VIRTIO_BLK_F_NO_PART_SCAN

> +		vblk->disk->flags |=3D GENHD_FL_NO_PART_SCAN;
> +
>  	/* configure queue flush support */
>  	virtblk_update_cache_mode(vdev);
> =20
> @@ -977,6 +981,7 @@ static unsigned int features_legacy[] =3D {
>  	VIRTIO_BLK_F_RO, VIRTIO_BLK_F_BLK_SIZE,
>  	VIRTIO_BLK_F_FLUSH, VIRTIO_BLK_F_TOPOLOGY, VIRTIO_BLK_F_CONFIG_WCE,
>  	VIRTIO_BLK_F_MQ, VIRTIO_BLK_F_DISCARD, VIRTIO_BLK_F_WRITE_ZEROES,
> +	VIRTIO_BLK_F_NO_PS,
>  }
>  ;
>  static unsigned int features[] =3D {
> @@ -984,6 +989,7 @@ static unsigned int features[] =3D {
>  	VIRTIO_BLK_F_RO, VIRTIO_BLK_F_BLK_SIZE,
>  	VIRTIO_BLK_F_FLUSH, VIRTIO_BLK_F_TOPOLOGY, VIRTIO_BLK_F_CONFIG_WCE,
>  	VIRTIO_BLK_F_MQ, VIRTIO_BLK_F_DISCARD, VIRTIO_BLK_F_WRITE_ZEROES,
> +	VIRTIO_BLK_F_NO_PS,
>  };
> =20
>  static struct virtio_driver virtio_blk =3D {
> diff --git a/include/uapi/linux/virtio_blk.h b/include/uapi/linux/virtio_=
blk.h
> index d888f013d9ff..f197d07afb05 100644
> --- a/include/uapi/linux/virtio_blk.h
> +++ b/include/uapi/linux/virtio_blk.h
> @@ -40,6 +40,7 @@
>  #define VIRTIO_BLK_F_MQ		12	/* support more than one vq */
>  #define VIRTIO_BLK_F_DISCARD	13	/* DISCARD is supported */
>  #define VIRTIO_BLK_F_WRITE_ZEROES	14	/* WRITE ZEROES is supported */
> +#define VIRTIO_BLK_F_NO_PS      16      /* No partitions */
> =20
>  /* Legacy feature bits */
>  #ifndef VIRTIO_BLK_NO_LEGACY
> --=20
> 2.24.3 (Apple Git-128)
>=20

--zLquBuJmN54dXDIQ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmCruEIACgkQnKSrs4Gr
c8jBKwf9EQa5eUR/4seJCa67VG756y4R9NM95IBcvVn0OU/yJRJPlhUrvYmvqYly
fGXQnsctO6HpG6VSEPgaT3FUUfnfqJKhz8Mif+rpP+wA6ilDiPgNqnfcqJGagx60
PmQcO8pTH/AiWYJl945ybGjSm3yK9LlpZjnudzeFC4ZRdQZ+RB3GxzPGbzXxrLD+
RMa+sbim+BRi/RxDgY+wYiQISSKLRVuiSpFh5eqXECu9yfuLQd3Y1DDQIO+I4VX0
yefE9jnCpvlJghlT3v9JkdJdOkh+GNnnn3+QFpspsv360V11nba0n0ZGZN+hiPnZ
GVNaSjRbcEytBn2ZNgX9u58ThW/wSA==
=UvdY
-----END PGP SIGNATURE-----

--zLquBuJmN54dXDIQ--


--===============5669918433091635963==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--===============5669918433091635963==--

