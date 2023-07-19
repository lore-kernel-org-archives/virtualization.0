Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 179DEEB64DA
	for <virtualization@archiver.kernel.org>; Wed, 19 Jul 2023 14:43:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 7F29B418DB;
	Wed, 19 Jul 2023 14:43:43 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 7F29B418DB
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=hc6mqrRb
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Z-aN1rcfhPTc; Wed, 19 Jul 2023 14:43:42 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id CD72141899;
	Wed, 19 Jul 2023 14:43:41 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org CD72141899
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A1FB8C0072;
	Wed, 19 Jul 2023 14:43:41 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 9BAFEC0032
 for <virtualization@lists.linux-foundation.org>;
 Wed, 19 Jul 2023 14:43:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 6E6C58200B
 for <virtualization@lists.linux-foundation.org>;
 Wed, 19 Jul 2023 14:43:40 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 6E6C58200B
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=hc6mqrRb
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id QvrXxy_LRdOT
 for <virtualization@lists.linux-foundation.org>;
 Wed, 19 Jul 2023 14:43:39 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id ABF508200A
 for <virtualization@lists.linux-foundation.org>;
 Wed, 19 Jul 2023 14:43:39 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org ABF508200A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1689777818;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=YRoA4WICi7nFi4CtHRjJNI33rRm2mX2J7fAF1VoxDkg=;
 b=hc6mqrRb5lQFHQ5EHxaxg/1AMN7x228VH2QcNYCryuNmUEeRtlBrD2J7ZSloN0DFrRpI1E
 Eun1ordaHPyrSFLS60Cfoxc7FEk9/nrs+R/WHNhe2xIdCPlMj560S3Cc2yYaWJgFu5mhJn
 AeCkf5rPLWdAjaCAKJ4ernmFSql8JYE=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-179-qYiUJO4dNJimjvPQqE5RSg-1; Wed, 19 Jul 2023 10:42:29 -0400
X-MC-Unique: qYiUJO4dNJimjvPQqE5RSg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com
 [10.11.54.1])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 89F2D936D29;
 Wed, 19 Jul 2023 14:42:29 +0000 (UTC)
Received: from localhost (unknown [10.39.194.239])
 by smtp.corp.redhat.com (Postfix) with ESMTP id D2BA040C2070;
 Wed, 19 Jul 2023 14:42:28 +0000 (UTC)
Date: Wed, 19 Jul 2023 10:42:27 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Mike Christie <michael.christie@oracle.com>
Subject: Re: [PATCH 1/1] MAINTAINERS: add vhost-scsi entry and myself as a
 co-maintainer
Message-ID: <20230719144227.GD100053@fedora>
References: <20230715142027.5572-1-michael.christie@oracle.com>
MIME-Version: 1.0
In-Reply-To: <20230715142027.5572-1-michael.christie@oracle.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
Cc: pbonzini@redhat.com, virtualization@lists.linux-foundation.org,
 mst@redhat.com
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
Content-Type: multipart/mixed; boundary="===============3794888461154345629=="
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>


--===============3794888461154345629==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="P2e+WBmdTyi3kh/I"
Content-Disposition: inline


--P2e+WBmdTyi3kh/I
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Jul 15, 2023 at 09:20:27AM -0500, Mike Christie wrote:
> I've been doing a lot of the development on vhost-scsi the last couple of
> years, so per Michael T's suggestion this adds me as co-maintainer.
>=20
> Signed-off-by: Mike Christie <michael.christie@oracle.com>
> ---
>  MAINTAINERS | 11 ++++++++++-
>  1 file changed, 10 insertions(+), 1 deletion(-)

Acked-by: Stefan Hajnoczi <stefanha@redhat.com>

--P2e+WBmdTyi3kh/I
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmS39lMACgkQnKSrs4Gr
c8jSnwgAsee8ToPCYlNgk/+H6Fg5COQ/eklyojhnpTCSWLOMoXkYomf5xIqEKDcb
IkfU3MF68plWynhTR4WTh8YkhaMf2g0ddjBckLdA3Xlp3t4G/pZVfl+8EmaO3Dth
r5EsEMNThfeF7K1FGfZf1NZp7AYJ3qao17d6Hm2LsSlxCT6Ffdq+BgkYTxVqzq/b
Ty9AnL41lYWfA7JkAQKbVOzV5TPayxMdBSP3spTNEYYFPv67AXeMJRLhhZjiX8/6
w/7Eusoblr3xfOl3l8LTpsrIskHmSBTJgm3FpXrgNBJ7b1p92wku264dNOoViOFt
ih8GlG1YsnaxBzfOc01JZEFu34Dt+g==
=eiqt
-----END PGP SIGNATURE-----

--P2e+WBmdTyi3kh/I--


--===============3794888461154345629==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--===============3794888461154345629==--

