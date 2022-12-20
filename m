Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 005EEC4167B
	for <virtualization@archiver.kernel.org>; Tue, 20 Dec 2022 19:51:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 8BEE281F28;
	Tue, 20 Dec 2022 19:51:48 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 8BEE281F28
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=BrbY4+Wg
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id MeljJfOH6WkI; Tue, 20 Dec 2022 19:51:47 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 3131481F22;
	Tue, 20 Dec 2022 19:51:47 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 3131481F22
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 0D120C0032;
	Tue, 20 Dec 2022 19:51:47 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 75083C002D
 for <virtualization@lists.linux-foundation.org>;
 Tue, 20 Dec 2022 19:51:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 433BE60B45
 for <virtualization@lists.linux-foundation.org>;
 Tue, 20 Dec 2022 19:51:45 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 433BE60B45
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=BrbY4+Wg
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id TD6GpAv72khl
 for <virtualization@lists.linux-foundation.org>;
 Tue, 20 Dec 2022 19:51:44 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 872DD60ACE
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 872DD60ACE
 for <virtualization@lists.linux-foundation.org>;
 Tue, 20 Dec 2022 19:51:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1671565903;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=vD/zGthR9y9cp0sBA0D/PFJmbt+XTjArn3I7GDki5rA=;
 b=BrbY4+WgruwoaEnxK7tzAVMLoOpua73RBwq1kt6cL6RtzIoOHqsvTh6avaNwmcfACqiijq
 QPT2pqvvj9LSr4dRd53aSS/6n8OpsrH0VnkEDpwLYEUvMCYVDOj5wCPJRn/cvC+JvqH5zn
 AGg+Yz3t4NXoALS4M+um9dvqApqoIHc=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-36-pQZLdXApOFCL6zTarZfEYA-1; Tue, 20 Dec 2022 14:51:39 -0500
X-MC-Unique: pQZLdXApOFCL6zTarZfEYA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
 [10.11.54.6])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 47F3685C064;
 Tue, 20 Dec 2022 19:51:39 +0000 (UTC)
Received: from localhost (unknown [10.39.192.41])
 by smtp.corp.redhat.com (Postfix) with ESMTP id ABD9B2166B26;
 Tue, 20 Dec 2022 19:51:38 +0000 (UTC)
Date: Tue, 20 Dec 2022 14:51:37 -0500
From: Stefan Hajnoczi <stefanha@redhat.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH] virtio_blk: zone append in header type tweak
Message-ID: <Y6ISSd9KO/H7PnzU@fedora>
References: <20221220125154.564265-1-mst@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20221220125154.564265-1-mst@redhat.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
Cc: Jens Axboe <axboe@kernel.dk>, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, linux-block@vger.kernel.org,
 Paolo Bonzini <pbonzini@redhat.com>
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
Content-Type: multipart/mixed; boundary="===============7882707196885490348=="
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>


--===============7882707196885490348==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="W0kG+D50n8NSuIM5"
Content-Disposition: inline


--W0kG+D50n8NSuIM5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 20, 2022 at 07:52:01AM -0500, Michael S. Tsirkin wrote:
> virtio blk returns a 64 bit append_sector in an input buffer,
> in LE format. This field is not tagged as LE correctly, so
> even though the generated code is ok, we get warnings from sparse:
>=20
> drivers/block/virtio_blk.c:332:33: sparse: sparse: cast to restricted __l=
e64
>=20
> Make sparse happy by using the correct type.
>=20
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> ---
>  drivers/block/virtio_blk.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--W0kG+D50n8NSuIM5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmOiEkgACgkQnKSrs4Gr
c8iNRQgAt/Ziu/OblXb2XoKR+f7qPFmOtVHoJhXnIfcjUk86QzcjWhpFOeW4l2T9
WX0xeNUJhbGB7wUgM63B/uGl/d058Y8EV2iws20GQAdc4mNTIwPbJR0rPzCkgzJs
EGo4+XWbtjleadgdBjInSupNjDe8zaH9cTdNpioqrB4N/RRU31tCR8HGnkDF4M16
Fu84ReQmb+B83dJQGL4og+3gfTvRfOGaDwoEJA/opcUblmO0/U/M/+lom/+NqiOw
hAdtpKE42PtZ+pOYxg93Yzg4v44+WsrrRFJqHswOC6DTGO1d/4BQimvrin2+m5yT
989ihIDLHsIAEGnKz+HSp9EHpbUAlA==
=xJHb
-----END PGP SIGNATURE-----

--W0kG+D50n8NSuIM5--


--===============7882707196885490348==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--===============7882707196885490348==--

