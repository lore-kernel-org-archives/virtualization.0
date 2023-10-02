Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8716E7490C
	for <virtualization@archiver.kernel.org>; Mon,  2 Oct 2023 18:54:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 34E6E610EF;
	Mon,  2 Oct 2023 18:54:39 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 34E6E610EF
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=XSdrwSJa
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id sj5LRUlOoqB0; Mon,  2 Oct 2023 18:54:38 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id D5F6360F6E;
	Mon,  2 Oct 2023 18:54:37 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org D5F6360F6E
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B97F6C0039;
	Mon,  2 Oct 2023 18:54:37 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 08A70C0032
 for <virtualization@lists.linux-foundation.org>;
 Mon,  2 Oct 2023 18:54:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id D7EC160FB0
 for <virtualization@lists.linux-foundation.org>;
 Mon,  2 Oct 2023 18:54:35 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org D7EC160FB0
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id meJ8ugTWq3EQ
 for <virtualization@lists.linux-foundation.org>;
 Mon,  2 Oct 2023 18:54:35 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 096F560F6E
 for <virtualization@lists.linux-foundation.org>;
 Mon,  2 Oct 2023 18:54:34 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 096F560F6E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696272873;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=dmM5ZNDegeZhf5s/Nz9vdWgDVovgTarUhb8l/wE2St4=;
 b=XSdrwSJaicJYyAySZzt/xmufOHU47CmBYUQOXu70Vt10zRiUzEiBj5Yr7pxl1N7pbOs1sU
 X8w/hm4stU0jQwQIPoR4MNFVFYKYtShbCy71WxA6iDy2HTCx996sHdnrtxvbSZr+5Me+DH
 rOmGWgTesHJIAKyj+ZttuYAr1heMh+g=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-584-W4uLBja-N5WWgJ9pUCQOhA-1; Mon, 02 Oct 2023 14:54:22 -0400
X-MC-Unique: W4uLBja-N5WWgJ9pUCQOhA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
 [10.11.54.3])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 24FD3101A59B;
 Mon,  2 Oct 2023 18:54:22 +0000 (UTC)
Received: from localhost (unknown [10.39.192.67])
 by smtp.corp.redhat.com (Postfix) with ESMTP id A0BD310EE402;
 Mon,  2 Oct 2023 18:54:21 +0000 (UTC)
Date: Mon, 2 Oct 2023 14:54:20 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Geert Uytterhoeven <geert+renesas@glider.be>
Subject: Re: [PATCH] vhost-scsi: Spelling s/preceeding/preceding/g
Message-ID: <20231002185420.GB1059748@fedora>
References: <b57b882675809f1f9dacbf42cf6b920b2bea9cba.1695903476.git.geert+renesas@glider.be>
MIME-Version: 1.0
In-Reply-To: <b57b882675809f1f9dacbf42cf6b920b2bea9cba.1695903476.git.geert+renesas@glider.be>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
Cc: kvm@vger.kernel.org, "Michael S . Tsirkin" <mst@redhat.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, Paolo Bonzini <pbonzini@redhat.com>
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
Content-Type: multipart/mixed; boundary="===============4150048735041616764=="
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>


--===============4150048735041616764==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="fuzmqqeB7+mI12HN"
Content-Disposition: inline


--fuzmqqeB7+mI12HN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 28, 2023 at 02:18:33PM +0200, Geert Uytterhoeven wrote:
> Fix a misspelling of "preceding".
>=20
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
>  drivers/vhost/scsi.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--fuzmqqeB7+mI12HN
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEyBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmUbEdwACgkQnKSrs4Gr
c8jm3wf3SybCVag7HhsRlbQBB2qCWSsI12mkvW0sXMAwLbLvfBANqEWmTzmywolz
wzPqtLEJrTAScwq8jHk8r9R+V8Sq+thDzpNdI08PCGDVriCt8LBEgDIjvs0EvSNP
rAhQxFxP5ciDKCRnnVq3cdXdzwPdkKNifj02HiaXQknBCE99vXD71LTwYLY4MBXI
fIfva8/FlebeJYdBU91I9alORHAnlmgE7xZWh3j9QN8b+hT6TQKbcVKan2Z+/Zj+
uEsjUWce8P3nTF8jd1AkjFDTegRXSmc9TKX2iqiglCBRZPUT8Ya2pSacmGdk2Lm/
mNLVJfYcDmicuRAkTrTsok4iECvw
=P1kz
-----END PGP SIGNATURE-----

--fuzmqqeB7+mI12HN--


--===============4150048735041616764==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--===============4150048735041616764==--

