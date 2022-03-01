Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6AB01C433F5
	for <virtualization@archiver.kernel.org>; Tue,  1 Mar 2022 09:07:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id F113340207;
	Tue,  1 Mar 2022 09:07:19 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id GHr4nFdA-agA; Tue,  1 Mar 2022 09:07:17 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id AD5BB400F6;
	Tue,  1 Mar 2022 09:07:16 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 79715C0077;
	Tue,  1 Mar 2022 09:07:16 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B3E7BC001A
 for <virtualization@lists.linux-foundation.org>;
 Tue,  1 Mar 2022 09:07:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id A49EF41299
 for <virtualization@lists.linux-foundation.org>;
 Tue,  1 Mar 2022 09:07:14 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id rMSpN8IakUE1
 for <virtualization@lists.linux-foundation.org>;
 Tue,  1 Mar 2022 09:07:13 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 0310F41295
 for <virtualization@lists.linux-foundation.org>;
 Tue,  1 Mar 2022 09:07:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1646125631;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=C9yUIg5j65w+qFKrB2q98qn+HFOuWpxbJH81ykhBbNU=;
 b=NJTfIJvm0pPEjChV5JfaQ/vFuQzff5ffXfSy0yYVcJ/tookKukIr0W/URLZ2mS9Ck5ogE3
 Nqmd/wBQWzRfOdGYaT+qumR8QpTOSP0SlpujSH8C531FQRTwTgEiBlVHPsfbGZckbreCal
 OfrgDPzTvRZMg5HT0JpIfzpR0ubKRdo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-36-PNX7isssMnCg8DTO-XnzpQ-1; Tue, 01 Mar 2022 04:07:08 -0500
X-MC-Unique: PNX7isssMnCg8DTO-XnzpQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 31ACB801AB2;
 Tue,  1 Mar 2022 09:07:07 +0000 (UTC)
Received: from localhost (unknown [10.39.194.231])
 by smtp.corp.redhat.com (Postfix) with ESMTP id ADCA51038AC5;
 Tue,  1 Mar 2022 09:07:00 +0000 (UTC)
Date: Tue, 1 Mar 2022 09:06:59 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Akihiko Odaki <akihiko.odaki@gmail.com>
Subject: Re: [PATCH] virtio-blk: Assign discard_granularity
Message-ID: <Yh3iMymdtD6rGYzs@stefanha-x1.localdomain>
References: <20220224093802.11348-1-akihiko.odaki@gmail.com>
 <YhypTNtWpcgh3gb2@stefanha-x1.localdomain>
 <e306700c-3153-9422-974c-1f5f10e232d6@gmail.com>
MIME-Version: 1.0
In-Reply-To: <e306700c-3153-9422-974c-1f5f10e232d6@gmail.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
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
Content-Type: multipart/mixed; boundary="===============4486377235561028142=="
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>


--===============4486377235561028142==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="QjNeH+KS6pqTHNut"
Content-Disposition: inline


--QjNeH+KS6pqTHNut
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 01, 2022 at 02:43:55PM +0900, Akihiko Odaki wrote:
> On 2022/02/28 19:51, Stefan Hajnoczi wrote:
> > On Thu, Feb 24, 2022 at 06:38:02PM +0900, Akihiko Odaki wrote:
> > > Virtual I/O Device (VIRTIO) Version 1.1
> > > https://docs.oasis-open.org/virtio/virtio/v1.1/csprd01/virtio-v1.1-cs=
prd01.html
> > > > discard_sector_alignment can be used by OS when splitting a request
> > > > based on alignment.
> > >=20
> > > According to Documentation/ABI/stable/sysfs-block, the corresponding
> > > field in the kernel is, confusingly, discard_granularity, not
> > > discard_alignment.
> >=20
> > Good catch, struct virtio_blk_config->discard_sector_alignment is Linux
> > q->limits.discard_granularity.
> >=20
> > >=20
> > > Signed-off-by: Akihiko Odaki <akihiko.odaki@gmail.com>
> > > ---
> > >   drivers/block/virtio_blk.c | 4 +---
> > >   1 file changed, 1 insertion(+), 3 deletions(-)
> > >=20
> > > diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
> > > index c443cd64fc9b..1fb3c89900e3 100644
> > > --- a/drivers/block/virtio_blk.c
> > > +++ b/drivers/block/virtio_blk.c
> > > @@ -913,11 +913,9 @@ static int virtblk_probe(struct virtio_device *v=
dev)
> > >   		blk_queue_io_opt(q, blk_size * opt_io_size);
> > >   	if (virtio_has_feature(vdev, VIRTIO_BLK_F_DISCARD)) {
> > > -		q->limits.discard_granularity =3D blk_size;
> > > -
> > >   		virtio_cread(vdev, struct virtio_blk_config,
> > >   			     discard_sector_alignment, &v);
> > > -		q->limits.discard_alignment =3D v ? v << SECTOR_SHIFT : 0;
> >=20
> > Should we use struct virtio_blk_config->topology.alignment_offset
> > ("offset of first aligned logical block" and used for Linux
> > blk_queue_alignment_offset()) for q->limits.discard_alignment?
>=20
> Maybe but I'm not sure. I had looked at the code of QEMU
> (commit 5c1ee569660d4a205dced9cb4d0306b907fb7599) but it apparently always
> sets 0 for virtio_blk_config->topology.alignment_offset.
> I don't have a hardware which requires discard_alignment either so I cann=
ot
> test it.
>=20
> I'd like to leave this patch as is since I cannot deny the possibility th=
at
> the host has a different alignment offset for discarding and other
> operations.

Fair enough. To do it properly we'd need to add a new configuration
space field to virtio-blk.

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--QjNeH+KS6pqTHNut
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmId4jMACgkQnKSrs4Gr
c8hVTQf/fK2GjZF044xLZweZrpcjLJNrkExfCsyHEH1Ah4G4APuU/5PSDiiYm6XX
EWrQanPgZ7Js5AkKfqsj5BslgH6HuTGUUfdP96Ww3uOxGG1jXpN3ifmN6vnLLUuR
+KQjF89iI6zAl8yuV1OvGWl7+KgT0zmGEyFlY2t2ELov/TihbI872+kohZxpUCf4
/7ZkXj7EL7BJxRmez/82PlVNzp1rqM7WsO9E+exIRL5uedb1w2lO8U96h9B7FO0i
eCJCD3MH8bTQ5q30xXMdEueNrRanBEnaXtteAmnAyrgXhK43mYGgvklxigXq2wrG
2ehNobgts6blVTE4GekOllSvt+9ZBw==
=qaMg
-----END PGP SIGNATURE-----

--QjNeH+KS6pqTHNut--


--===============4486377235561028142==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--===============4486377235561028142==--

