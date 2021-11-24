Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88746C433EF
	for <virtualization@archiver.kernel.org>; Wed, 24 Nov 2021 15:38:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 11CCB61605;
	Wed, 24 Nov 2021 15:38:23 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id LeaMlNYij8Q1; Wed, 24 Nov 2021 15:38:21 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id AF464615F9;
	Wed, 24 Nov 2021 15:38:20 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 6B8C3C001E;
	Wed, 24 Nov 2021 15:38:20 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 26D01C0012
 for <virtualization@lists.linux-foundation.org>;
 Wed, 24 Nov 2021 15:38:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 0EC364015A
 for <virtualization@lists.linux-foundation.org>;
 Wed, 24 Nov 2021 15:38:19 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id gchNiAO2w_eM
 for <virtualization@lists.linux-foundation.org>;
 Wed, 24 Nov 2021 15:38:17 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 818564011C
 for <virtualization@lists.linux-foundation.org>;
 Wed, 24 Nov 2021 15:38:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1637768295;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=46y3rdu6iUG1CYH2wKUqw8yXte9uDTkV/SHmghHQmB8=;
 b=OwXW7mDsLNB3+zrqhqg81hLKfxHXsQ4Uchm208QvNHNqBJe+Qv255dkfQDFsIrmCfyBHeP
 hGlGLpnmyR/ThAkYTmoIQdzk9HyZQrosYc6axyznpLvv0Z94WpHwSSAFwBkuiRM0YpuS0y
 dzI9v84fDOqjW25aAgpHpT1Bv9rZt2c=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-409-CEOnUjgdP3ulP_N-adU-Ig-1; Wed, 24 Nov 2021 10:38:12 -0500
X-MC-Unique: CEOnUjgdP3ulP_N-adU-Ig-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 909C91800D41;
 Wed, 24 Nov 2021 15:38:10 +0000 (UTC)
Received: from localhost (unknown [10.39.195.62])
 by smtp.corp.redhat.com (Postfix) with ESMTP id EB99A79457;
 Wed, 24 Nov 2021 15:37:57 +0000 (UTC)
Date: Wed, 24 Nov 2021 15:37:56 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
To: cgel.zte@gmail.com
Subject: Re: [PATCH] virtio-blk: modify the value type of num in
 virtio_queue_rq()
Message-ID: <YZ5cVCy+bdvdcgxc@stefanha-x1.localdomain>
References: <20211117063955.160777-1-ye.guojin@zte.com.cn>
MIME-Version: 1.0
In-Reply-To: <20211117063955.160777-1-ye.guojin@zte.com.cn>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Cc: axboe@kernel.dk, mst@redhat.com, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, linux-block@vger.kernel.org,
 Ye Guojin <ye.guojin@zte.com.cn>, pbonzini@redhat.com,
 Zeal Robot <zealci@zte.com.cn>
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
Content-Type: multipart/mixed; boundary="===============2146393555668699581=="
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>


--===============2146393555668699581==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="4qNBzmFiqXAJam7g"
Content-Disposition: inline


--4qNBzmFiqXAJam7g
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 17, 2021 at 06:39:55AM +0000, cgel.zte@gmail.com wrote:
> From: Ye Guojin <ye.guojin@zte.com.cn>
>=20
> This was found by coccicheck:
> ./drivers/block/virtio_blk.c, 334, 14-17, WARNING Unsigned expression
> compared with zero  num < 0
>=20
> Reported-by: Zeal Robot <zealci@zte.com.cn>
> Signed-off-by: Ye Guojin <ye.guojin@zte.com.cn>
> ---
>  drivers/block/virtio_blk.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--4qNBzmFiqXAJam7g
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmGeXFQACgkQnKSrs4Gr
c8gkVwf/VP0Wcpg/NeC/3ubkg6ohgMgZ1GkS53l+f6cG9/aKWHuGmGvyXrjBXaiU
jFwsVz+f322Ip7s0lFbTlvDhknlv/5jG6Sd6uSAXRYiDS7bU55AazAWtMVe0yaRo
qcoRyogRn20jCrb5t1C/ukBMf4giPeHPY+U4rZCZmlZ3n9JOtPe0KPMA2f0tBMp4
4lj/4O7hlmx3Un9bkskeJ9zfIwLA7K06cQ2u2Cjfiz136Y3gXSMSKBHX/z4+pjAB
bJYlFe0QLQDLhPOB0vocSpeexr/lZjsIDlKH2jo1IE1Y29AXmTKTH2M2BDOMjrRS
mc12UmSpgULbXSygbOVXqEYFnYarog==
=pXYE
-----END PGP SIGNATURE-----

--4qNBzmFiqXAJam7g--


--===============2146393555668699581==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--===============2146393555668699581==--

