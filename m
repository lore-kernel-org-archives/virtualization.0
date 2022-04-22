Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0886C433F5
	for <virtualization@archiver.kernel.org>; Mon, 25 Apr 2022 08:22:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 5ED3C60A89;
	Mon, 25 Apr 2022 08:22:23 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ezun_PbzyoPR; Mon, 25 Apr 2022 08:22:22 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id D715B606C6;
	Mon, 25 Apr 2022 08:22:21 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 96E3FC0032;
	Mon, 25 Apr 2022 08:22:21 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id EDD52C002D
 for <virtualization@lists.linux-foundation.org>;
 Mon, 25 Apr 2022 08:22:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id DCA418151E
 for <virtualization@lists.linux-foundation.org>;
 Mon, 25 Apr 2022 08:22:19 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id gTGo1moWUb7A
 for <virtualization@lists.linux-foundation.org>;
 Mon, 25 Apr 2022 08:22:18 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 9485781501
 for <virtualization@lists.linux-foundation.org>;
 Mon, 25 Apr 2022 08:22:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1650874937;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=pSx9DFRN+NXzO8KvmEpZt/ZmLB7PjIvaUwAyvIlr/DI=;
 b=AFspNctmlC1K8DTOPdLk8UpIAqIIym+IAqQfj/xdZydLZgnk0cixVt2/Wkx0aEZjowqjDi
 QMjU6ShVy/FLc6SQEBUebR/pmbSUk/BUQ25qeM1ZvO23ifTZQ+6bTNRg3JpMVLBsBNAM3U
 jYbQb2bqQLuF+9nZGIxbQUfOLVwAEF0=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-623-cp8a_Ih8M3q73QxAWEZlxg-1; Mon, 25 Apr 2022 04:22:12 -0400
X-MC-Unique: cp8a_Ih8M3q73QxAWEZlxg-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com
 [10.11.54.10])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 1993783396B;
 Mon, 25 Apr 2022 08:22:09 +0000 (UTC)
Received: from localhost (unknown [10.39.192.194])
 by smtp.corp.redhat.com (Postfix) with ESMTP id A5DFF40314F;
 Mon, 25 Apr 2022 08:22:08 +0000 (UTC)
Date: Fri, 22 Apr 2022 15:56:55 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Chaitanya Kulkarni <chaitanyak@nvidia.com>
Subject: Re: [PATCH 0/4] virtio-blk: small cleanup
Message-ID: <YmLCN9EHA9R05xmC@stefanha-x1.localdomain>
References: <20220420041053.7927-1-kch@nvidia.com>
 <6c21dd2d-830a-8842-428e-6fc60966b73e@nvidia.com>
MIME-Version: 1.0
In-Reply-To: <6c21dd2d-830a-8842-428e-6fc60966b73e@nvidia.com>
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.10
Cc: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>,
 "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>, "mst@redhat.com" <mst@redhat.com>
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
Content-Type: multipart/mixed; boundary="===============4187189021940388415=="
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>


--===============4187189021940388415==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="g0839ppuCZya34th"
Content-Disposition: inline


--g0839ppuCZya34th
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 21, 2022 at 09:56:28PM +0000, Chaitanya Kulkarni wrote:
> On 4/19/22 21:10, Chaitanya Kulkarni wrote:
> > Hi,
> >=20
> > This has some nit fixes and code cleanups along with removing
> > deprecated API fir ida_simple_XXX().
> >=20
> > -ck
> >=20
> > Chaitanya Kulkarni (4):
> >    virtio-blk: remove additional check in fast path
> >    virtio-blk: don't add a new line
> >    virtio-blk: avoid function call in the fast path
> >    virtio-blk: remove deprecated ida_simple_XXX()
> >=20
> >   drivers/block/virtio_blk.c | 38 +++++++++++++++++---------------------
> >   1 file changed, 17 insertions(+), 21 deletions(-)
> >=20
>=20
> Thanks for the review, I'll send out a V2 and drop patches that
> lacks the quantitative data..

Thank you!

Stefan

--g0839ppuCZya34th
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmJiwjYACgkQnKSrs4Gr
c8jOhQf+NAjIxbIpz49jBiC5oSMiAQdLKLILSvVFZq0bkyFlj+B7kDypj1S8pyEp
vlu/io8j5B8VNVZMjxj8s14OnwQ7e2H1rFrlwLh9uxDz4x4JSZ4d2+XpVuxgXzr7
HZUqWc9nSBbop4XoylU3rr+ASVoUZVi9HRO3cai37kGQrRNt+0L94D1JWWt1UAG5
qAMoQyHfrWA/wK1tcvvHO0i65OuFFwa6vtzyiiNrhnBWkDjU7s3D6qRrahFN41fv
2NsBCqS0seVGF+kDmGxADZqGl2p38uPSz4lkZhDBl//iDkPgn+/Ch363laWq0xWi
gWC1jD+U+9I2/sjh+7jlcnNPKzFTrQ==
=0s2z
-----END PGP SIGNATURE-----

--g0839ppuCZya34th--


--===============4187189021940388415==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--===============4187189021940388415==--

