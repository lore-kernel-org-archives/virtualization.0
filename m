Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52EAEC00140
	for <virtualization@archiver.kernel.org>; Wed, 24 Aug 2022 18:38:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id C2CE582C35;
	Wed, 24 Aug 2022 18:38:10 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org C2CE582C35
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=PTQ1Yz1J
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id IiYZjlXP38kv; Wed, 24 Aug 2022 18:38:10 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 49D9682C38;
	Wed, 24 Aug 2022 18:38:09 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 49D9682C38
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 0797CC0033;
	Wed, 24 Aug 2022 18:38:09 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 918B1C002D
 for <virtualization@lists.linux-foundation.org>;
 Wed, 24 Aug 2022 18:38:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 669D440198
 for <virtualization@lists.linux-foundation.org>;
 Wed, 24 Aug 2022 18:38:06 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 669D440198
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=PTQ1Yz1J
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id BJ1LaZK7KaMW
 for <virtualization@lists.linux-foundation.org>;
 Wed, 24 Aug 2022 18:38:05 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 8F36A400EC
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 8F36A400EC
 for <virtualization@lists.linux-foundation.org>;
 Wed, 24 Aug 2022 18:38:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1661366284;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ZlqNeeiWPt5Flo1BeTTvrGsOnzYBCYlJI8p2JIGoxlc=;
 b=PTQ1Yz1JFccBirT3wsJKGBYGMtmt7J+6qAdmCSFbd2KrmP4utt7vlsPemOd77k+uU37fKv
 noawBaNH1jTxBaclM6CgvsB/3z2J1loJ4AX3s9d+NlQAN18tZpYb50jSuBy7VPKaSvn0xM
 sD9rOJAZvMFSgHifuRaEVdo3wmsJokM=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-182-CCm3N7KLM4aD0tNThk0QkQ-1; Wed, 24 Aug 2022 14:38:02 -0400
X-MC-Unique: CCm3N7KLM4aD0tNThk0QkQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com
 [10.11.54.2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 2D6623C0E227;
 Wed, 24 Aug 2022 18:38:02 +0000 (UTC)
Received: from localhost (unknown [10.39.192.66])
 by smtp.corp.redhat.com (Postfix) with ESMTP id A5DC640D2830;
 Wed, 24 Aug 2022 18:38:01 +0000 (UTC)
Date: Wed, 24 Aug 2022 14:37:59 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Alvaro Karsz <alvaro.karsz@solid-run.com>
Subject: Re: [PATCH] virtio_blk: add SECURE ERASE command support
Message-ID: <YwZwB9BlGeA08Hmn@fedora>
References: <20220822162055.634854-1-alvaro.karsz@solid-run.com>
 <YwUueWHKi5YmQeGP@fedora>
 <CAJs=3_C9Bm=zsDUXuGXnDmZEKmSYfj-44UvuuyT1_SgbSXJoYQ@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAJs=3_C9Bm=zsDUXuGXnDmZEKmSYfj-44UvuuyT1_SgbSXJoYQ@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.84 on 10.11.54.2
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
Content-Type: multipart/mixed; boundary="===============6587418344809496283=="
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>


--===============6587418344809496283==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="55qehEB/JuehSaZV"
Content-Disposition: inline


--55qehEB/JuehSaZV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 24, 2022 at 09:45:57AM +0300, Alvaro Karsz wrote:
> > What about max_secure_erase_seg and secure_erase_sector_alignment?
>=20
> Hi Stefan,
> If I understand correctly, the Linux kernel uses the same "max
> segments" value for a discard and a secure erase command.
>=20
> > unsigned int blk_recalc_rq_segments(struct request *rq)
> > {
> >     unsigned int nr_phys_segs =3D 0;
> >     unsigned int bytes =3D 0;
> >     struct req_iterator iter;
> >     struct bio_vec bv;
> >
> >
> >     if (!rq->bio)
> >         return 0;
> >
> >
> >     switch (bio_op(rq->bio)) {
> >     case REQ_OP_DISCARD:
> >     case REQ_OP_SECURE_ERASE:
> >         if (queue_max_discard_segments(rq->q) > 1) {
> >             struct bio *bio =3D rq->bio;
> >
> >
> >             for_each_bio(bio)
> >                 nr_phys_segs++;
> >             return nr_phys_segs;
> >         }
> >
> > ....
>=20
>=20
> > struct bio *__bio_split_to_limits(struct bio *bio, struct queue_limits =
*lim,
> >       unsigned int *nr_segs)
> > {
> >     struct bio_set *bs =3D &bio->bi_bdev->bd_disk->bio_split;
> >     struct bio *split;
> >
> >
> >     switch (bio_op(bio)) {
> >     case REQ_OP_DISCARD:
> >     case REQ_OP_SECURE_ERASE:
> >         split =3D bio_split_discard(bio, lim, nr_segs, bs);
> >
> >         break;
> >
> > ...
>=20
> What do you suggest?
>=20
> BTW, the same happens for the write zeros command implementation.
> max_write_zeroes_seg and write_zeroes_may_unmap are ignored in the Linux =
kernel.

How about calculating the minimum of the limits?

Stefan

--55qehEB/JuehSaZV
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmMGcAcACgkQnKSrs4Gr
c8hUdgf/avkDdvdaItWMXMLx///si/d3gnw9zYC35PDRfGaD5ubWU4gO+x0kHNUB
bTyoS6z7NivUjSj1Wzxh61yMqYgPBT2kKYmDug6ojeTPweaaYtMZQworRrx2aS3w
twNct4cgTzBe3/5Wz7M2vf4yRrovI7gNSvMsv26N6je+8jcW3Uq/w99vcySFHgql
G3EBZxFeav/yJMiLEyZZO6eDYs0jMpHLmPbbSaC4JgMmWtyQt3HyEIEPWPYRqPCT
ifQ1by3hbpkkhGR1b6Iztl+urPCleP/LvNkYB5eG+RVH+Yji+ieFajelEDQi40CR
jUNKtTR31uC2NIuFA7yfnBXvKJ8/FQ==
=DiCz
-----END PGP SIGNATURE-----

--55qehEB/JuehSaZV--


--===============6587418344809496283==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--===============6587418344809496283==--

