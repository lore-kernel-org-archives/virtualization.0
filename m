Return-Path: <SRS0=rBDE=PJ=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0232DC433EF
	for <virtualization@archiver.kernel.org>; Thu, 21 Oct 2021 09:13:48 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9D67660FE8
	for <virtualization@archiver.kernel.org>; Thu, 21 Oct 2021 09:13:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 9D67660FE8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 67CDD4028B;
	Thu, 21 Oct 2021 09:13:47 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id a-cxibSCuk58; Thu, 21 Oct 2021 09:13:46 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 0F9C040240;
	Thu, 21 Oct 2021 09:13:45 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id DA7EDC001C;
	Thu, 21 Oct 2021 09:13:45 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 7927BC0011
 for <virtualization@lists.linux-foundation.org>;
 Thu, 21 Oct 2021 09:13:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 584EF40590
 for <virtualization@lists.linux-foundation.org>;
 Thu, 21 Oct 2021 09:13:44 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id aB_yeqifIbE9
 for <virtualization@lists.linux-foundation.org>;
 Thu, 21 Oct 2021 09:13:43 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 85BBD4044F
 for <virtualization@lists.linux-foundation.org>;
 Thu, 21 Oct 2021 09:13:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1634807622;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=JSYinOFtwRsFgOxSRSzI9vTSR20INlFSfCZfRqi4WrE=;
 b=Xr4GGTK4sEZ1IrKycuNgeAVBDB1CUZcIXDcGEeK/p/SVmDleZCOuTlhXs85wPHXa950pSU
 ND8/RvPEcxfVhOnZOBTEPXYuOYmlyc8l8AeSqF2zOZ6LlZ5fZXuPrILxFkRLr/TuyNX9m2
 eO19T+3GtXheubxBurquAngeMdFe0Yk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-30-peoWRb9sPDexm_gPO3L0lA-1; Thu, 21 Oct 2021 05:13:38 -0400
X-MC-Unique: peoWRb9sPDexm_gPO3L0lA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 880A2806688;
 Thu, 21 Oct 2021 09:13:37 +0000 (UTC)
Received: from localhost (unknown [10.39.195.42])
 by smtp.corp.redhat.com (Postfix) with ESMTP id BE1815F4F5;
 Thu, 21 Oct 2021 09:13:32 +0000 (UTC)
Date: Thu, 21 Oct 2021 10:13:31 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
To: cgel.zte@gmail.com
Subject: Re: [PATCH] virtio-blk: fixup coccinelle warnings
Message-ID: <YXEvO+agUSTYD9CG@stefanha-x1.localdomain>
References: <20211021065111.1047824-1-ye.guojin@zte.com.cn>
MIME-Version: 1.0
In-Reply-To: <20211021065111.1047824-1-ye.guojin@zte.com.cn>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
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
Content-Type: multipart/mixed; boundary="===============2330743567219048377=="
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>


--===============2330743567219048377==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="4i3IirvxfSp8CV/X"
Content-Disposition: inline


--4i3IirvxfSp8CV/X
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 21, 2021 at 06:51:11AM +0000, cgel.zte@gmail.com wrote:
> From: Ye Guojin <ye.guojin@zte.com.cn>
>=20
> coccicheck complains about the use of snprintf() in sysfs show
> functions:
> WARNING  use scnprintf or sprintf
>=20
> Use sysfs_emit instead of scnprintf or sprintf makes more sense.
>=20
> Reported-by: Zeal Robot <zealci@zte.com.cn>
> Signed-off-by: Ye Guojin <ye.guojin@zte.com.cn>
> ---
>  drivers/block/virtio_blk.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--4i3IirvxfSp8CV/X
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmFxLzsACgkQnKSrs4Gr
c8jSigf+P1fE6QfnIfouWFqWo7v5avT6uxaqhbKNTpHIP4m+rAQpOBz8VmkV4Qgn
tMGnD/dTY1U5meS5Tto0tn4UeKJJYwjF+BZPonvr4b8A2S5uYINslRmfdkdNQyvs
mGs02Ed+v4LoKq/17B17H8LLRCGqHIDD9R+s2l8Ouu4iGxdU3uqRBeoYeXVCL6fg
ywsBov6xUGipCSK8JCXAfqrtBnmTAuCPwkM2e0fUpXbmKFDRJyNaX+glhEnC92i4
dXgjYVk0AjAEAZL9AfdoVpoB96YUVFcCxQcGmIgnw2ujdhrY3RRzzC/deuqvhD5E
vYXwL/thuQXjca4Vl/T0JOr8rZef8A==
=D4TM
-----END PGP SIGNATURE-----

--4i3IirvxfSp8CV/X--


--===============2330743567219048377==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--===============2330743567219048377==--

