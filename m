Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6CD96C433EF
	for <virtualization@archiver.kernel.org>; Wed, 20 Apr 2022 14:54:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 0AE13419E2;
	Wed, 20 Apr 2022 14:54:32 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id idFQ1Yp_PIRC; Wed, 20 Apr 2022 14:54:31 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 5EE22419B6;
	Wed, 20 Apr 2022 14:54:30 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 3BFE2C0033;
	Wed, 20 Apr 2022 14:54:30 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B2CE1C002C
 for <virtualization@lists.linux-foundation.org>;
 Wed, 20 Apr 2022 14:54:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 9893440503
 for <virtualization@lists.linux-foundation.org>;
 Wed, 20 Apr 2022 14:54:28 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id f8NlFWZTaxc8
 for <virtualization@lists.linux-foundation.org>;
 Wed, 20 Apr 2022 14:54:27 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 6E41A4021C
 for <virtualization@lists.linux-foundation.org>;
 Wed, 20 Apr 2022 14:54:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1650466465;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=mZjsCa5DWmSw7wQX/1kGElLyptDOSI/bENhlaa110to=;
 b=NuHsRcXvNNwM+7vpOfKpPsMmpvve+kshwIHrh8AvvmrHmSwVz3hNs/cKwofkQIcsaR233i
 ILsnTqk29PRQpNAh21DabYzdex8AgclRU/73TqYkAneOBACIRMQG59bx/tfsNRgAzDph5B
 PFFm9b86D1FOQXS/F4MDOTba6Om/2e8=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-104-3W6PvLbqNz-KpSL3KWsmMg-1; Wed, 20 Apr 2022 10:54:22 -0400
X-MC-Unique: 3W6PvLbqNz-KpSL3KWsmMg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
 [10.11.54.6])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id CE3C029AA3BD;
 Wed, 20 Apr 2022 14:54:21 +0000 (UTC)
Received: from localhost (unknown [10.39.194.99])
 by smtp.corp.redhat.com (Postfix) with ESMTP id B4D7C2166B44;
 Wed, 20 Apr 2022 14:54:13 +0000 (UTC)
Date: Wed, 20 Apr 2022 16:54:11 +0200
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Chaitanya Kulkarni <kch@nvidia.com>
Subject: Re: [PATCH 1/4] virtio-blk: remove additional check in fast path
Message-ID: <YmAekwHPRy8sfaEs@stefanha-x1.localdomain>
References: <20220420041053.7927-1-kch@nvidia.com>
 <20220420041053.7927-2-kch@nvidia.com>
MIME-Version: 1.0
In-Reply-To: <20220420041053.7927-2-kch@nvidia.com>
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.6
Cc: linux-block@vger.kernel.org, pbonzini@redhat.com,
 virtualization@lists.linux-foundation.org, mst@redhat.com
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
Content-Type: multipart/mixed; boundary="===============2402288147004940880=="
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>


--===============2402288147004940880==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="WNcOvVsFLKxLTK9e"
Content-Disposition: inline


--WNcOvVsFLKxLTK9e
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 19, 2022 at 09:10:50PM -0700, Chaitanya Kulkarni wrote:
> The function virtblk_setup_cmd() calls
> virtblk_setup_discard_write_zeroes() once we process the block layer
> request operation setup in the switch. Even though it saves duplicate
> call for REQ_OP_DISCARD and REQ_OP_WRITE_ZEROES it adds additional check
> in the fast path that is redundent since we already have a switch case
> for both REQ_OP_DISCARD and REQ_OP_WRITE_ZEROES.
>=20
> Move the call virtblk_setup_discard_write_zeroes() into switch case
> label of REQ_OP_DISCARD and REQ_OP_WRITE_ZEROES and avoid duplicate
> branch in the fast path.
>=20
> Signed-off-by: Chaitanya Kulkarni <kch@nvidia.com>
> ---
>  drivers/block/virtio_blk.c | 9 ++++-----
>  1 file changed, 4 insertions(+), 5 deletions(-)

Is there data that shows the performance effect of moving the code out
of the fast path?

> diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
> index 6ccf15253dee..b77711e73422 100644
> --- a/drivers/block/virtio_blk.c
> +++ b/drivers/block/virtio_blk.c
> @@ -223,10 +223,14 @@ static blk_status_t virtblk_setup_cmd(struct virtio=
_device *vdev,
>  		break;
>  	case REQ_OP_DISCARD:
>  		type =3D VIRTIO_BLK_T_DISCARD;
> +		if (virtblk_setup_discard_write_zeroes(req, unmap))

unmap is never true here. The variable obscures what is going on:

s/unmap/false/

--WNcOvVsFLKxLTK9e
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmJgHpMACgkQnKSrs4Gr
c8hIkAgAk7J4MkB5WFrMUnpKJVCj0ms73q3tUwebLmjKe+twZuJSJdotXWrMDgUO
NGL64GlQUB351DkeCl5A7Djgt//qcuM4ygdP91/BEywwAFY7iFT7oedxyvxYMOt4
4Qz/7+OCUjTt3ZbbGDKr3Oo151IwsLxQ3Q3Zvwmh9vGkKOCUJdpF0GjQh4EDY0+b
sgSw1YIgNPq+tfzHuxPKccw+n20PoVhBNIcVriHquSGwiFq3hjtYqkwPUhoF3VdC
1unhI9dyDAvZl1h8ZLDo85hhsNctRgSb7cXRqPpV3tUs5b3N7emzTNKJj+iwrQ6h
wJy1wBTCL2YAwhSDWbu6fdyqX5GEUQ==
=gl2/
-----END PGP SIGNATURE-----

--WNcOvVsFLKxLTK9e--


--===============2402288147004940880==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--===============2402288147004940880==--

