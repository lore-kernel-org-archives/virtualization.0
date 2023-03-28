Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C76ADC6FD18
	for <virtualization@archiver.kernel.org>; Tue, 28 Mar 2023 14:51:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 4DFDD408AE;
	Tue, 28 Mar 2023 14:51:59 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 4DFDD408AE
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=U3irXoSN
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id psqqxRV53QMT; Tue, 28 Mar 2023 14:51:58 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id DCE9841792;
	Tue, 28 Mar 2023 14:51:57 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org DCE9841792
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B776DC0036;
	Tue, 28 Mar 2023 14:51:57 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 6E940C002F
 for <virtualization@lists.linux-foundation.org>;
 Tue, 28 Mar 2023 14:51:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 3CE6782094
 for <virtualization@lists.linux-foundation.org>;
 Tue, 28 Mar 2023 14:51:56 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 3CE6782094
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=U3irXoSN
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id I71c0p39RieS
 for <virtualization@lists.linux-foundation.org>;
 Tue, 28 Mar 2023 14:51:55 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 4C12581FBB
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 4C12581FBB
 for <virtualization@lists.linux-foundation.org>;
 Tue, 28 Mar 2023 14:51:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1680015114;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=0cR29LyY11JQFvMX2a2zTEiw5p1+i0O8ayeeXYSH/LE=;
 b=U3irXoSNvuV4KJv8XDA6uOFRVh5LXk4UGMNeu2j2i1gf+O+LgMjBMjojjRQ94lsCSATYeB
 Uowiwbs4GI3W1cj39tSfOZhfYKxtzPKZU6+29l6PZ8aU5OLUJfQ5VI3e/7KzMyp0IktGWb
 o4gOcPCk3J3p41UJ6EvrbuCZbjcBIBg=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-9-RPfPPF6wPLmSOhF3zAx9_w-1; Tue, 28 Mar 2023 10:51:48 -0400
X-MC-Unique: RPfPPF6wPLmSOhF3zAx9_w-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
 [10.11.54.3])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 64D4685A5B1;
 Tue, 28 Mar 2023 14:51:47 +0000 (UTC)
Received: from localhost (unknown [10.39.195.24])
 by smtp.corp.redhat.com (Postfix) with ESMTP id D51B51121330;
 Tue, 28 Mar 2023 14:51:46 +0000 (UTC)
Date: Tue, 28 Mar 2023 10:51:45 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Dmitry Fomichev <dmitry.fomichev@wdc.com>
Subject: Re: [virtio-dev] [PATCH 1/2] virtio-blk: migrate to the latest
 patchset version
Message-ID: <20230328145145.GB1623159@fedora>
References: <20230328022928.1003996-1-dmitry.fomichev@wdc.com>
 <20230328022928.1003996-2-dmitry.fomichev@wdc.com>
MIME-Version: 1.0
In-Reply-To: <20230328022928.1003996-2-dmitry.fomichev@wdc.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
Cc: Jens Axboe <axboe@kernel.dk>, virtio-dev@lists.oasis-open.org,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Damien Le Moal <damien.lemoal@opensource.wdc.com>,
 Sam Li <faithilikerun@gmail.com>, virtualization@lists.linux-foundation.org,
 linux-block@vger.kernel.org
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
Content-Type: multipart/mixed; boundary="===============3913616412420281891=="
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>


--===============3913616412420281891==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="W+f9eOPTmKJwgc15"
Content-Disposition: inline


--W+f9eOPTmKJwgc15
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 27, 2023 at 10:29:27PM -0400, Dmitry Fomichev wrote:
> The merged patch series to support zoned block devices in virtio-blk
> is not the most up to date version. The merged patch can be found at
>=20
> https://lore.kernel.org/linux-block/20221016034127.330942-3-dmitry.fomich=
ev@wdc.com/
>=20
> , but the latest and reviewed version is
>=20
> https://lore.kernel.org/linux-block/20221110053952.3378990-3-dmitry.fomic=
hev@wdc.com/
>=20
> The differences between the two are mostly cleanups, but there is one
> change that is very important in terms of compatibility with the
> approved virtio-zbd specification.
>=20
> Before it was approved, the OASIS virtio spec had a change in
> VIRTIO_BLK_T_ZONE_APPEND request layout that is not reflected in the
> current virtio-blk driver code. In the running code, the status is
> the first byte of the in-header that is followed by some pad bytes
> and the u64 that carries the sector at which the data has been written
> to the zone back to the driver, aka the append sector.
>=20
> This layout turned out to be problematic for implementing in QEMU and
> the request status byte has been eventually made the last byte of the
> in-header. The current code doesn't expect that and this causes the
> append sector value always come as zero to the block layer. This needs
> to be fixed ASAP.
>=20
> Fixes: 95bfec41bd3d ("virtio-blk: add support for zoned block devices")
> Cc: stable@vger.kernel.org
> Signed-off-by: Dmitry Fomichev <dmitry.fomichev@wdc.com>
> ---
>  drivers/block/virtio_blk.c      | 238 +++++++++++++++++++++-----------
>  include/uapi/linux/virtio_blk.h |  18 +--
>  2 files changed, 165 insertions(+), 91 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--W+f9eOPTmKJwgc15
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmQi/wEACgkQnKSrs4Gr
c8imZggAhJA5G85LLc28etjnXDmkF7WtvrUc4MoHpgxVUys1SEaxhlmAsh+EIrd5
oSIHcBTkAv6xkMA44ogTyq+Ewl0J4e8Ma46s+HE9Pn0XXuHpOZKeVxJxLvyYUkkS
9RbxlExUCi68vdHy4JKqS8u+iisGRILKXCu06B5Ce3wD1o07kuvYlkZcOKyaJMUs
1Z1ifmiTphIsUT7KHMJ13GsR1QhgBr0+1LH2uCTJu8faD3UGGTJHtH9r+wmFVKbt
AKQ7DsQuhIUfreukTh4AOK1LOAjTgtNyf9mhkQl4js1KkKKoiedxmGqVV9RlHbZw
WFTFCtcjbgVhBQi4SvLAlAgy0yC++g==
=KqDZ
-----END PGP SIGNATURE-----

--W+f9eOPTmKJwgc15--


--===============3913616412420281891==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--===============3913616412420281891==--

