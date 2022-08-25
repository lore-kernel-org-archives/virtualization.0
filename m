Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C91A9C64990
	for <virtualization@archiver.kernel.org>; Thu, 25 Aug 2022 13:47:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 3E3E583486;
	Thu, 25 Aug 2022 13:47:48 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 3E3E583486
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=EuQ27P03
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id pSmru7gYOwN9; Thu, 25 Aug 2022 13:47:47 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id E2D7C833A8;
	Thu, 25 Aug 2022 13:47:46 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org E2D7C833A8
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B4739C0033;
	Thu, 25 Aug 2022 13:47:46 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0D3FFC002D
 for <virtualization@lists.linux-foundation.org>;
 Thu, 25 Aug 2022 13:47:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id CDE2F8336D
 for <virtualization@lists.linux-foundation.org>;
 Thu, 25 Aug 2022 13:47:45 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org CDE2F8336D
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id sFGZ8xyH3f03
 for <virtualization@lists.linux-foundation.org>;
 Thu, 25 Aug 2022 13:47:41 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 43C28833A8
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 43C28833A8
 for <virtualization@lists.linux-foundation.org>;
 Thu, 25 Aug 2022 13:47:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1661435260;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=BaLae3KOeYK61FAvdLlIGgkqVx6X7XEZRTUd7obFn9w=;
 b=EuQ27P03u80qR/EU0k+uoyFcBTgYQtJn/HV8q/73kMepnW3ANcbbVVPRI+/GJ3aPGDovEB
 VJLFAY83vRcNwtrHVne48C820GpKKHpAlTRvvpMH7LhSbImKTI5Rtl9xHuz63TGc6fKaUN
 FJb3UOY5yl9O9S8H0WQfdxZcCkxb4tY=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-351-dk8X5lnUNjGaoTRm6kQ8Lg-1; Thu, 25 Aug 2022 09:47:38 -0400
X-MC-Unique: dk8X5lnUNjGaoTRm6kQ8Lg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
 [10.11.54.3])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 2C931811E90;
 Thu, 25 Aug 2022 13:47:37 +0000 (UTC)
Received: from localhost (unknown [10.39.193.236])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 8C91D1121315;
 Thu, 25 Aug 2022 13:47:36 +0000 (UTC)
Date: Thu, 25 Aug 2022 09:47:34 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Alvaro Karsz <alvaro.karsz@solid-run.com>
Subject: Re: [PATCH] virtio_blk: add SECURE ERASE command support
Message-ID: <Ywd9dvDw0uNXgGz8@fedora>
References: <20220822162055.634854-1-alvaro.karsz@solid-run.com>
 <YwUueWHKi5YmQeGP@fedora>
 <CAJs=3_C9Bm=zsDUXuGXnDmZEKmSYfj-44UvuuyT1_SgbSXJoYQ@mail.gmail.com>
 <YwZwB9BlGeA08Hmn@fedora>
 <CAJs=3_CUf_QQ1uy-uE1VA_Y=5G=_9D8MeRiPLFEOQnj4n04=Aw@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAJs=3_CUf_QQ1uy-uE1VA_Y=5G=_9D8MeRiPLFEOQnj4n04=Aw@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.3
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
Content-Type: multipart/mixed; boundary="===============4678489557278608131=="
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>


--===============4678489557278608131==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="o1zmBFutRdkat3sL"
Content-Disposition: inline


--o1zmBFutRdkat3sL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 24, 2022 at 10:48:30PM +0300, Alvaro Karsz wrote:
> > How about calculating the minimum of the limits?
>=20
> Sounds reasonable.
> Should I add it to this patch (as v2)?
> Or maybe it can be a follow up patch, and it can include the write
> zeros command as well.

If you can include it in a v2 series that would be nice.

Thanks,
Stefan

--o1zmBFutRdkat3sL
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmMHfXYACgkQnKSrs4Gr
c8h3PQgAxvZ8TlYESvktvJqGIEuxhxeCefaQNgB+eKqfpR1ak8p0D/OP/KRzrzwG
9ZRbklArbh3QGTshbv0lL9+Bjo0qOFu02/LC63OlewEjjpDGa9Jc7hmU7BRvskPq
fhoTOnKcthT0imdDPMGMNDTj5PRQ8jkaaoID1fuDR7FoV1aYANSKSw/gOcGp97Ht
nrJj4DhJ/GgSBFzlxwYKQd5CWHMcZ/gJttJ3AaMBS2eTbtWhXXKKJ6S4mDdwMYV2
VKotXnS6sv/Y8cIh90lTTAWkqcgrtjZycfq1JpJ4u2+yA6Gt/0MAjCTSeWuXw2lC
zcdj//nSMMMQIXRz0UPQXmzSNMMxxg==
=YC+Y
-----END PGP SIGNATURE-----

--o1zmBFutRdkat3sL--


--===============4678489557278608131==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--===============4678489557278608131==--

