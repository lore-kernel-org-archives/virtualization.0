Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47C8EC4332F
	for <virtualization@archiver.kernel.org>; Thu, 10 Nov 2022 20:19:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id A979640111;
	Thu, 10 Nov 2022 20:19:03 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org A979640111
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=MBXaTgB1
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id YxWigZkFp4al; Thu, 10 Nov 2022 20:19:03 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 400EF40164;
	Thu, 10 Nov 2022 20:19:02 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 400EF40164
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 0C260C0033;
	Thu, 10 Nov 2022 20:19:02 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id BF13CC002D
 for <virtualization@lists.linux-foundation.org>;
 Thu, 10 Nov 2022 20:19:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 85AD740164
 for <virtualization@lists.linux-foundation.org>;
 Thu, 10 Nov 2022 20:19:00 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 85AD740164
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id vjuyIk-gsrlF
 for <virtualization@lists.linux-foundation.org>;
 Thu, 10 Nov 2022 20:19:00 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org D0EF540111
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id D0EF540111
 for <virtualization@lists.linux-foundation.org>;
 Thu, 10 Nov 2022 20:18:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1668111538;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=RgL5/7r9Wym/g+B0pjsz3dgQTgEurnPH1LtAMA+rvcc=;
 b=MBXaTgB14CUWLrsbKpweD/Q5IOd5C3FapkESpmDr8I6BNujP8EZrXMdBm5xPzRQf0vaqYi
 00rfQusXVEZlQFcAPov4KvoGB7AEoJgF+IW4oge3Mg7CYZOcm/MQyGflcwd+qBqI8BlCP3
 EMyka305+O+mBypDGPpV6svg/JlxgWY=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-29-x0G0q06wN6qNKRWnBYHEWQ-1; Thu, 10 Nov 2022 15:18:41 -0500
X-MC-Unique: x0G0q06wN6qNKRWnBYHEWQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
 [10.11.54.3])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 013238582B9;
 Thu, 10 Nov 2022 20:18:41 +0000 (UTC)
Received: from localhost (unknown [10.39.192.6])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 768171121330;
 Thu, 10 Nov 2022 20:18:39 +0000 (UTC)
Date: Thu, 10 Nov 2022 15:18:38 -0500
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Angus Chen <angus.chen@jaguarmicro.com>
Subject: Re: [PATCH] virtio_blk: use UINT_MAX instead of -1U
Message-ID: <Y21cnhr1q6e6oNhp@fedora>
References: <20221110030124.1986-1-angus.chen@jaguarmicro.com>
MIME-Version: 1.0
In-Reply-To: <20221110030124.1986-1-angus.chen@jaguarmicro.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
Cc: axboe@kernel.dk, mst@redhat.com, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, linux-block@vger.kernel.org,
 pbonzini@redhat.com
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
Content-Type: multipart/mixed; boundary="===============1447628809522835005=="
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>


--===============1447628809522835005==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="EAV7xN6Mtl16GRtO"
Content-Disposition: inline


--EAV7xN6Mtl16GRtO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 10, 2022 at 11:01:23AM +0800, Angus Chen wrote:
> We use UINT_MAX to limit max_discard_sectors in virtblk_probe,
> we can use UINT_MAX to limit max_hw_sectors for consistencies.
>=20
> No functional change intended.
>=20
> Signed-off-by: Angus Chen <angus.chen@jaguarmicro.com>
> ---
>  drivers/block/virtio_blk.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--EAV7xN6Mtl16GRtO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmNtXJ4ACgkQnKSrs4Gr
c8hFTgf/VUUpU5e4Be8XmTk5FyYOu+JeRz6prpVZEnfw7rKvvZc4O2NVtavIYV/7
LbYA3WCbconInnqACqX1fCZ300zS0cWIYx9qFWTCcekj5eTJx2iM//3PWz605Lld
kA/B4A8Y9uJphud/8BLpVb58J8QGHPbLL5iSY9Ql/8jivezW8hniEQZVYoGjqECJ
84BZ1KIZ7ZdTGucZq7a3f1qLrafA5f5uTRQ9qk9dEwPJlBSSZauu+k1ehQQYdNv4
thqgGOkGl7Kygq2sGDAGP0DOTQ9f6jIACqZlaYPEPBLvXy4r4440QQt1e8gib3EN
qUqPkkgeCxv108rW7NWZKdwYsvYtsQ==
=L5h/
-----END PGP SIGNATURE-----

--EAV7xN6Mtl16GRtO--


--===============1447628809522835005==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--===============1447628809522835005==--

