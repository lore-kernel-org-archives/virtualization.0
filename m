Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58A62C433EF
	for <virtualization@archiver.kernel.org>; Wed, 20 Apr 2022 15:20:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id E22E1409A2;
	Wed, 20 Apr 2022 15:20:07 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Vbn389yU1xTq; Wed, 20 Apr 2022 15:20:06 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 3B3CF40992;
	Wed, 20 Apr 2022 15:20:06 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E9390C002F;
	Wed, 20 Apr 2022 15:20:05 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 19036C002C
 for <virtualization@lists.linux-foundation.org>;
 Wed, 20 Apr 2022 15:20:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id E449582B34
 for <virtualization@lists.linux-foundation.org>;
 Wed, 20 Apr 2022 15:20:03 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id GA_giXI11JZp
 for <virtualization@lists.linux-foundation.org>;
 Wed, 20 Apr 2022 15:20:03 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 4A3AB8283D
 for <virtualization@lists.linux-foundation.org>;
 Wed, 20 Apr 2022 15:20:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1650468002;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Vr65kK48b4IYGWq3LEsb2mA5/gjqSSqZxbsyzjsVrlA=;
 b=EeYu7IpQbe7eufVlQDw5v3ue0fJPdTo8hGZV+xptfXFOszng4b/CYqf75mK/e5u6vRx5vE
 0px6l3zLHJDKcV4UlGKGHIXJE8PtxJrJz0VCUYkuy+8J2rVtaO48+/bopSazqskgwcSWQW
 QFJOmg/xk3MS0sS3QZrFnsKxRRnWrWQ=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-106-JOxFjWwfNxejb_ux5u4Oxw-1; Wed, 20 Apr 2022 11:20:00 -0400
X-MC-Unique: JOxFjWwfNxejb_ux5u4Oxw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
 [10.11.54.6])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 19E761C05142;
 Wed, 20 Apr 2022 15:20:00 +0000 (UTC)
Received: from localhost (unknown [10.39.194.99])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 0ABEE2166B44;
 Wed, 20 Apr 2022 15:19:53 +0000 (UTC)
Date: Wed, 20 Apr 2022 17:19:51 +0200
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Chaitanya Kulkarni <kch@nvidia.com>
Subject: Re: [PATCH 4/4] virtio-blk: remove deprecated ida_simple_XXX()
Message-ID: <YmAklxLSkwiijfxV@stefanha-x1.localdomain>
References: <20220420041053.7927-1-kch@nvidia.com>
 <20220420041053.7927-5-kch@nvidia.com>
MIME-Version: 1.0
In-Reply-To: <20220420041053.7927-5-kch@nvidia.com>
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
Content-Type: multipart/mixed; boundary="===============8964742087311061340=="
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>


--===============8964742087311061340==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="n2ti8gPJk9PvKj1M"
Content-Disposition: inline


--n2ti8gPJk9PvKj1M
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 19, 2022 at 09:10:53PM -0700, Chaitanya Kulkarni wrote:
> Replace deprecated ida_simple_get() and ida_simple_remove() with
> ida_alloc_max() and ida_free().
>=20
> Signed-off-by: Chaitanya Kulkarni <kch@nvidia.com>
> ---
>  drivers/block/virtio_blk.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--n2ti8gPJk9PvKj1M
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmJgJJcACgkQnKSrs4Gr
c8giFQf/bIt70RKS9GLawcbAsbUw996Yx8V9PyZRRGJopQZ9K8AixFN7Vi0NJskQ
qYFvP0yIn8ZwXDbGoQmZ/iH+zDvTingGGhb1kB4hm5eZa3qMy8X84ZuvhmNNcpbO
jtJa3rl7kqL++9m54XnGelL9M/g4pYPiLKqalh6Ri+HZ2VyVtFhhbbMftcSjRj0h
PE5iN9neP545tsu2k+lm1IJaOd2vSC5dG7HrqnHPYsRbiGUx9wrzcSIXew6AZlJd
19Pp8ZGhK0JBhxoTW6OUU0xDAQnR4/yyBbKxwdBxn7W1hFbR5+UUM/yuGrppa4IG
PSJbUB49PVdLzKTxoIHiGsDUmujkcQ==
=WzxC
-----END PGP SIGNATURE-----

--n2ti8gPJk9PvKj1M--


--===============8964742087311061340==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--===============8964742087311061340==--

