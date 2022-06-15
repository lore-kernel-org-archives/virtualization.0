Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70ED8C43334
	for <virtualization@archiver.kernel.org>; Wed, 15 Jun 2022 15:54:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 00BA5409AB;
	Wed, 15 Jun 2022 15:54:21 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id KUkQzsw694zA; Wed, 15 Jun 2022 15:54:20 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 7966D409A1;
	Wed, 15 Jun 2022 15:54:19 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 49B85C0039;
	Wed, 15 Jun 2022 15:54:19 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 332ADC002D
 for <virtualization@lists.linux-foundation.org>;
 Wed, 15 Jun 2022 15:54:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 29C25409B1
 for <virtualization@lists.linux-foundation.org>;
 Wed, 15 Jun 2022 15:54:18 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id i-kRW1SGcnYD
 for <virtualization@lists.linux-foundation.org>;
 Wed, 15 Jun 2022 15:54:16 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id E33C4409A1
 for <virtualization@lists.linux-foundation.org>;
 Wed, 15 Jun 2022 15:54:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1655308454;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=TEmJ1fJ8Yf6oDfx0MBc+zDdacxWq2un2XNoeG1V4KKU=;
 b=gRVEJIQvjFkRl0fNvCtv1CyVwDbt/nG6wbkKn3mUxoZtWFoXCdyu1mxunMOYVGP1g1FlRB
 LmfVnv98zIC19yV2nwGGG/Nr2okZ879LdfQS0MevBHQxVJldELKOoAfkH22Q8dBwbjDMlb
 Vza0B7EjWb/3edjPdsvzY9VBXvxqLVI=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-58-D_983ZWxOxWyh_k1LNsgaw-1; Wed, 15 Jun 2022 11:54:10 -0400
X-MC-Unique: D_983ZWxOxWyh_k1LNsgaw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com
 [10.11.54.7])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 5728B38005CB;
 Wed, 15 Jun 2022 15:54:10 +0000 (UTC)
Received: from localhost (unknown [10.39.192.100])
 by smtp.corp.redhat.com (Postfix) with ESMTP id E2EE51415107;
 Wed, 15 Jun 2022 15:54:09 +0000 (UTC)
Date: Wed, 15 Jun 2022 14:54:29 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Deming Wang <wangdeming@inspur.com>
Subject: Re: [PATCH] virtiofs: delete unused parameter for
 virtio_fs_cleanup_vqs
Message-ID: <YqnklWCUQBamzmJJ@stefanha-x1.localdomain>
References: <20220610020838.1543-1-wangdeming@inspur.com>
MIME-Version: 1.0
In-Reply-To: <20220610020838.1543-1-wangdeming@inspur.com>
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.7
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
Content-Type: multipart/mixed; boundary="===============0395649570624971657=="
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>


--===============0395649570624971657==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="VSfWJTB4dTlkafrv"
Content-Disposition: inline


--VSfWJTB4dTlkafrv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 09, 2022 at 10:08:38PM -0400, Deming Wang wrote:
> fs parameter not used. So, it needs to be deleted.
>=20
> Signed-off-by: Deming Wang <wangdeming@inspur.com>
> ---
>  fs/fuse/virtio_fs.c | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--VSfWJTB4dTlkafrv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmKp5JUACgkQnKSrs4Gr
c8i8ogf+JVNIK5wafiTY0HlfRmCOIhYMJ8AbK4vwM0rKJeoQc+tgLDPQHHCVMGDM
lqtAdpnNzCHGOTTe8+sbTVhxhH+THmJvh1c7fX630vgW6MQWQICOT1ablFIJN/jF
4snTGcSXXaPWMp9B4YJp4n+LBkH3WPHLYGuy1tzgDSYRCnv7ofeKitJ5b3BVWhuc
zBgS6VNklGbEycPII0gUR8doCeW3laSbHT/3Cai3lVs6iqfZlv/wfvpG8gszeHqm
IFb5Y93cFAWvxZg11kx8g8Ps3GirNj/y1tq/USKPaQ1PlbQmSZKrSW/6eku2RMXO
yvOmooxFHUf/aUVMw/BqAynlUDfLLg==
=BmCq
-----END PGP SIGNATURE-----

--VSfWJTB4dTlkafrv--


--===============0395649570624971657==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--===============0395649570624971657==--

