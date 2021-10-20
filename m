Return-Path: <SRS0=Bv1r=PI=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF485C433FE
	for <virtualization@archiver.kernel.org>; Wed, 20 Oct 2021 07:55:55 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AB0DB611C6
	for <virtualization@archiver.kernel.org>; Wed, 20 Oct 2021 07:55:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org AB0DB611C6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 6F380404FA;
	Wed, 20 Oct 2021 07:55:55 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id txKyhtgNDZgX; Wed, 20 Oct 2021 07:55:54 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id C272640186;
	Wed, 20 Oct 2021 07:55:53 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8844CC000F;
	Wed, 20 Oct 2021 07:55:53 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1B892C000D
 for <virtualization@lists.linux-foundation.org>;
 Wed, 20 Oct 2021 07:55:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 0B02160ABF
 for <virtualization@lists.linux-foundation.org>;
 Wed, 20 Oct 2021 07:55:53 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id n72YUW2mCSge
 for <virtualization@lists.linux-foundation.org>;
 Wed, 20 Oct 2021 07:55:52 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 53CAC60804
 for <virtualization@lists.linux-foundation.org>;
 Wed, 20 Oct 2021 07:55:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1634716551;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=5VjR3bPcCHRdUMlUAg5b7vcZhP6CummMCmSSquwYdA4=;
 b=em3IYoNPgCPLjzFNo7Jwvi7/a3lIqFYLarjRV3Eax7vmvayN6X7TnozgGdMFmgrKOE+Pln
 e/H1niMYFjaYDp5w1I/SdYBa7R8e5uuWzRCy2kXoJ8jy+ai6W1sfdnMSOEwIsWf/spXcZG
 tbS7Rd7CGjEXspbK1hzNdp76xwdVUig=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-215--WD9zA1vOEa6X7zTFMIzhw-1; Wed, 20 Oct 2021 03:55:47 -0400
X-MC-Unique: -WD9zA1vOEa6X7zTFMIzhw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2C76218125C0;
 Wed, 20 Oct 2021 07:55:46 +0000 (UTC)
Received: from localhost (unknown [10.39.192.128])
 by smtp.corp.redhat.com (Postfix) with ESMTP id E1A5E5DF21;
 Wed, 20 Oct 2021 07:55:34 +0000 (UTC)
Date: Wed, 20 Oct 2021 08:55:33 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH V3 01/10] virtio-blk: validate num_queues during probe
Message-ID: <YW/LdQibVvEP06hI@stefanha-x1.localdomain>
References: <20211019070152.8236-1-jasowang@redhat.com>
 <20211019070152.8236-2-jasowang@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20211019070152.8236-2-jasowang@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Cc: david.kaplan@amd.com, konrad.wilk@oracle.com, f.hetzelt@tu-berlin.de,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 mst@redhat.com, Paolo Bonzini <pbonzini@redhat.com>
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
Content-Type: multipart/mixed; boundary="===============2738360657235524661=="
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>


--===============2738360657235524661==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="NwFJ7yLypb5u6Psm"
Content-Disposition: inline


--NwFJ7yLypb5u6Psm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 19, 2021 at 03:01:43PM +0800, Jason Wang wrote:
> If an untrusted device neogitates BLK_F_MQ but advertises a zero
> num_queues, the driver may end up trying to allocating zero size
> buffers where ZERO_SIZE_PTR is returned which may pass the checking
> against the NULL. This will lead unexpected results.
>=20
> Fixing this by failing the probe in this case.
>=20
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Cc: Stefan Hajnoczi <stefanha@redhat.com>
> Cc: Stefano Garzarella <sgarzare@redhat.com>
> Signed-off-by: Jason Wang <jasowang@redhat.com>
> ---
>  drivers/block/virtio_blk.c | 4 ++++
>  1 file changed, 4 insertions(+)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--NwFJ7yLypb5u6Psm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmFvy3UACgkQnKSrs4Gr
c8hxVQf/SVTtkJjObwCF2iGUpkXg+NjbhBRMuYPz6vpdcE8hkM6QcPTjunwbWU4S
fUv03sI3pv4rshtc32bxBRajdsyMh5KXoeRJzva80Fh+u83CoFA56lOZ0rnXbFo+
LWexYoYjN0Z4F/SZq/M4IowJJFPYtIuti6E3djl9b+jYWcpEySdE4Lz2fmhgVaSQ
xinnT8BP7Xz41dkp6tbM6lI/hR3ItUYQjQMZV8yeMm7FhL2q9RzbQvMR2WYE5xLx
pz2m/87axMgvuwRJyU/5Hr4mMmjwFqXGjPWd237D08GGz5Q/yd+2r6wy7GOS7ccg
da+Vy3aFkpi+kl6DpMBNhIaPrCBnfA==
=GJbH
-----END PGP SIGNATURE-----

--NwFJ7yLypb5u6Psm--


--===============2738360657235524661==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--===============2738360657235524661==--

