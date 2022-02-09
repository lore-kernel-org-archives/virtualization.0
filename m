Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD80CC433F5
	for <virtualization@archiver.kernel.org>; Wed,  9 Feb 2022 09:40:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 6633540382;
	Wed,  9 Feb 2022 09:40:01 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id IJpolQ56mqRM; Wed,  9 Feb 2022 09:40:00 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 20A96403CA;
	Wed,  9 Feb 2022 09:40:00 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E1D19C001A;
	Wed,  9 Feb 2022 09:39:59 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 7F735C000B
 for <virtualization@lists.linux-foundation.org>;
 Wed,  9 Feb 2022 09:39:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 51A80825B1
 for <virtualization@lists.linux-foundation.org>;
 Wed,  9 Feb 2022 09:39:58 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id uSW3CbEQg8eX
 for <virtualization@lists.linux-foundation.org>;
 Wed,  9 Feb 2022 09:39:57 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 9AB7F81AF3
 for <virtualization@lists.linux-foundation.org>;
 Wed,  9 Feb 2022 09:39:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1644399596;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=nrZaO1QLhXCKNSnMpSxxsA2uM/u3n5wse6OBdbYb6VM=;
 b=XzLUD1ubwbw/VHNv+KhD6SdqXCS2Jo4m35WqhPXwcQpv+K++uQqbs9AO47puZKejIbtD53
 tBEtpW6d++p8o/R+32JYtjldKiNB9fKtJkhUQISeQ/dDnabLKuGIOjprIyMF0j2k0XZyDw
 iMevnLbNPzuOKgM6Lll3UQhdszaKUMM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-576-IBZ2QZvUPNi116_lJZriTA-1; Wed, 09 Feb 2022 04:39:53 -0500
X-MC-Unique: IBZ2QZvUPNi116_lJZriTA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6D82985B6C8;
 Wed,  9 Feb 2022 09:39:50 +0000 (UTC)
Received: from localhost (unknown [10.39.193.233])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 90BBE6C196;
 Wed,  9 Feb 2022 09:39:34 +0000 (UTC)
Date: Wed, 9 Feb 2022 09:38:32 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 5/5] virtio_blk: simplify refcounting
Message-ID: <YgOLmLOCNZQS3EYG@stefanha-x1.localdomain>
References: <20220209082121.2628452-1-hch@lst.de>
 <20220209082121.2628452-6-hch@lst.de>
MIME-Version: 1.0
In-Reply-To: <20220209082121.2628452-6-hch@lst.de>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Cc: Jens Axboe <axboe@kernel.dk>, Maxim Levitsky <maximlevitsky@gmail.com>,
 Alex Dubov <oakad@yahoo.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 linux-mmc@vger.kernel.org, virtualization@lists.linux-foundation.org,
 linux-block@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>
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
Content-Type: multipart/mixed; boundary="===============1146053269110671878=="
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>


--===============1146053269110671878==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="cXxZwQ9bZyPfG1Md"
Content-Disposition: inline


--cXxZwQ9bZyPfG1Md
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 09, 2022 at 09:21:20AM +0100, Christoph Hellwig wrote:
> Implement the ->free_disk method to free the virtio_blk structure only
> once the last gendisk reference goes away instead of keeping a local
> refcount.
>=20
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  drivers/block/virtio_blk.c | 74 +++++++++++---------------------------
>  1 file changed, 21 insertions(+), 53 deletions(-)

Thanks!

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--cXxZwQ9bZyPfG1Md
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmIDi5cACgkQnKSrs4Gr
c8g2sAgAp/NAAO/juuKgvBUzwYfw+VgLihgtcRdyhBUc5WnO+Aev/sb2TqEGOP5c
UzY4CDswetq1vNZ9WitzwDaseUPVipRQtooSPmJwRFfLj2PQPeB/6MdLQljq4F67
CIjaudo4PEP1jXUkX8dmaTpx8R0pfF7MGRHI759J5/6hWntvd0P7GQaiGU8EzHJh
P5CA2pJvoXn5czUsigfT7DXqOEmRExrrNk2CnhATs/LQ49xLiDwEi5ysXMhNxKeR
4VTbRo6WiONe1hpT71b0g199I0/4o2o9rLy1kCaqMjUKZetL2q7UeqCBFuBWpFgp
X5DGkOtiZp8xt56ZheqqWQjrE8uuBA==
=7zac
-----END PGP SIGNATURE-----

--cXxZwQ9bZyPfG1Md--


--===============1146053269110671878==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--===============1146053269110671878==--

