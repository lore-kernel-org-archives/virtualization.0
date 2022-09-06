Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF896C6FA83
	for <virtualization@archiver.kernel.org>; Tue,  6 Sep 2022 13:30:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 2EFEC41763;
	Tue,  6 Sep 2022 13:30:58 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 2EFEC41763
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=gkZ5VQfW
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 7JWKe3EcGlId; Tue,  6 Sep 2022 13:30:57 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 43C0C416FC;
	Tue,  6 Sep 2022 13:30:56 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 43C0C416FC
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E070FC0033;
	Tue,  6 Sep 2022 13:30:55 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D07A5C002D
 for <virtualization@lists.linux-foundation.org>;
 Tue,  6 Sep 2022 13:30:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id A0C7040C0E
 for <virtualization@lists.linux-foundation.org>;
 Tue,  6 Sep 2022 13:30:53 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org A0C7040C0E
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=gkZ5VQfW
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id bq6oSFCKFZHy
 for <virtualization@lists.linux-foundation.org>;
 Tue,  6 Sep 2022 13:30:53 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org E905640BC4
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id E905640BC4
 for <virtualization@lists.linux-foundation.org>;
 Tue,  6 Sep 2022 13:30:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1662471051;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=bCl6uulMyxrVlr2gxACbm/zfYRoeE0Wcxnn2cAdr1a0=;
 b=gkZ5VQfWmMPHjbuAk/DPmsotts0aIcPmUzcHEL66B+y0uy4bpfRfafwrtc7AKxyS2jUTVL
 9YH9szEyVg9lJrf9zrIeBehTo0f2PAYHZfWywKrfTxHDFGXxByaS2RIZgbVeM1wCa7e2Y2
 qJtqw68fAjFlvUymv2AR6suMzoU+8oY=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-25-jATdod-ZPH2s4yFEqEid-Q-1; Tue, 06 Sep 2022 09:30:46 -0400
X-MC-Unique: jATdod-ZPH2s4yFEqEid-Q-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com
 [10.11.54.2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C750F8039B2;
 Tue,  6 Sep 2022 13:30:45 +0000 (UTC)
Received: from localhost (unknown [10.39.193.96])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 457AE40D296E;
 Tue,  6 Sep 2022 13:30:45 +0000 (UTC)
Date: Tue, 6 Sep 2022 09:30:43 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Deming Wang <wangdeming@inspur.com>
Subject: Re: [PATCH] virtiofs: Drop unnecessary initialization in
 send_forget_request and virtio_fs_get_tree
Message-ID: <YxdLg8tI9OtVjbfe@fedora>
References: <20220906053848.2503-1-wangdeming@inspur.com>
MIME-Version: 1.0
In-Reply-To: <20220906053848.2503-1-wangdeming@inspur.com>
X-Scanned-By: MIMEDefang 2.84 on 10.11.54.2
Cc: linux-fsdevel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 linux-kernel@vger.kernel.org, vgoyal@redhat.com, miklos@szeredi.hu
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
Content-Type: multipart/mixed; boundary="===============8091625565055802605=="
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>


--===============8091625565055802605==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="S+kjWGQJm00xfWBG"
Content-Disposition: inline


--S+kjWGQJm00xfWBG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 06, 2022 at 01:38:48AM -0400, Deming Wang wrote:
> The variable is initialized but it is only used after its assignment.
>=20
> Signed-off-by: Deming Wang <wangdeming@inspur.com>
> ---
>  fs/fuse/virtio_fs.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>=20
> diff --git a/fs/fuse/virtio_fs.c b/fs/fuse/virtio_fs.c
> index 4d8d4f16c..bffe74d44 100644
> --- a/fs/fuse/virtio_fs.c
> +++ b/fs/fuse/virtio_fs.c
> @@ -414,7 +414,7 @@ static int send_forget_request(struct virtio_fs_vq *f=
svq,
>  {
>  	struct scatterlist sg;
>  	struct virtqueue *vq;
> -	int ret =3D 0;
> +	int ret;
>  	bool notify;
>  	struct virtio_fs_forget_req *req =3D &forget->req;
> =20

That causes an uninitialized access in the source tree I'm looking at
(c5e4d5e99162ba8025d58a3af7ad103f155d2df7):

  static int send_forget_request(struct virtio_fs_vq *fsvq,
                     struct virtio_fs_forget *forget,
                     bool in_flight)
  {
      struct scatterlist sg;
      struct virtqueue *vq;
      int ret =3D 0;
      ^^^^^^^
      bool notify;
      struct virtio_fs_forget_req *req =3D &forget->req;
 =20
      spin_lock(&fsvq->lock);
      if (!fsvq->connected) {
          if (in_flight)
              dec_in_flight_req(fsvq);
          kfree(forget);
          goto out;
      ...
      out:
      spin_unlock(&fsvq->lock);
      return ret;
             ^^^
  }

What is the purpose of this patch? Is there a compiler warning (if so,
which compiler and version)? Do you have a static analysis tool that
reported this (if yes, then maybe it's broken)?

Stefan

--S+kjWGQJm00xfWBG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmMXS4MACgkQnKSrs4Gr
c8hAnwgAr+QWzw860ulBE175xxGhGz+svhuLqPnyhkkQWyLQ+SsHglf6wgX8wyJo
3GImaRGa4ntB59O6CORrt1m7YIFLeCAob1b4AooxalOuXeP3st5ryPhMO81RovYL
L3hVXfFQQeDboa2r7KdH8EyT7sJSrzsOpLQpFfDXOrpDfQrdzZPwSRcU4DHr98QW
0ErLih20bpg/tptA1VY8+qfrXJMUYfFZkfcFgWo6F8GLFJGieGKKxEbAzOczz9IS
7mFLUtaRglCb9dDLItuOZwr40Uipgj1jqKx2JweQx2UYdt8hqZ6yRLbbOvxQH3R5
i+axLSVNdiXXrXNKkTGNKETbFwpEfw==
=3X2b
-----END PGP SIGNATURE-----

--S+kjWGQJm00xfWBG--


--===============8091625565055802605==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--===============8091625565055802605==--

