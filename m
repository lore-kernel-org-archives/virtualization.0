Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0D9EC433F5
	for <virtualization@archiver.kernel.org>; Tue, 23 Nov 2021 12:54:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 6603E40222;
	Tue, 23 Nov 2021 12:54:33 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ipLN2DBqDn4Q; Tue, 23 Nov 2021 12:54:32 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id DAB08401F4;
	Tue, 23 Nov 2021 12:54:31 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8DF81C001E;
	Tue, 23 Nov 2021 12:54:31 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 28CF0C0012
 for <virtualization@lists.linux-foundation.org>;
 Tue, 23 Nov 2021 12:54:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 01D734026F
 for <virtualization@lists.linux-foundation.org>;
 Tue, 23 Nov 2021 12:54:30 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Z7aJ7IfhK4gS
 for <virtualization@lists.linux-foundation.org>;
 Tue, 23 Nov 2021 12:54:29 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id EC63C40163
 for <virtualization@lists.linux-foundation.org>;
 Tue, 23 Nov 2021 12:54:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1637672067;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=zSBeYlFZ9tIzOUFtiUDS2YmhqY7uIJxs/7Wl4E4qfNM=;
 b=VoR9CQdACIloDI1jbuemrLwkOtSkL7ozwebVen9X8MFrYholFL67xb/4E0cJkptsEZQc5a
 Ya5pDNnmxscgSi6lAeeUxk5MBok2+mS0dYwvoNAx/msx+c+Ir7nXnSY3zvIwm+r3PuNKvt
 R2MhBI+y1sOH/QVzpiS0r/4QuDAr1G4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-41-i7zeWf8rOeyCoTdXX0-upw-1; Tue, 23 Nov 2021 07:54:26 -0500
X-MC-Unique: i7zeWf8rOeyCoTdXX0-upw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2321787950C;
 Tue, 23 Nov 2021 12:54:25 +0000 (UTC)
Received: from localhost (unknown [10.39.195.64])
 by smtp.corp.redhat.com (Postfix) with ESMTP id AAE125DF5E;
 Tue, 23 Nov 2021 12:54:19 +0000 (UTC)
Date: Tue, 23 Nov 2021 12:54:18 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Stefano Garzarella <sgarzare@redhat.com>
Subject: Re: [PATCH 0/2] vhost/vsock: fix used length and cleanup in
 vhost_vsock_handle_tx_kick()
Message-ID: <YZzketMjpZ+Pn9aA@stefanha-x1.localdomain>
References: <20211122163525.294024-1-sgarzare@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20211122163525.294024-1-sgarzare@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Cc: kvm@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, Halil Pasic <pasic@linux.ibm.com>,
 Asias He <asias@redhat.com>
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
Content-Type: multipart/mixed; boundary="===============6608761296208314189=="
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>


--===============6608761296208314189==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="127DMsQtX8lXRxGZ"
Content-Disposition: inline


--127DMsQtX8lXRxGZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 22, 2021 at 05:35:23PM +0100, Stefano Garzarella wrote:
> This is a follow-up to Micheal's patch [1] and the discussion with Halil =
and
> Jason [2].
>=20
> I made two patches, one to fix the problem and one for cleanup. This shou=
ld
> simplify the backport of the fix because we've had the problem since
> vhost-vsock was introduced (v4.8) and that part has been touched a bit
> recently.
>=20
> Thanks,
> Stefano
>=20
> [1] https://lore.kernel.org/virtualization/20211122105822.onarsa4sydzxqyn=
u@steredhat/T/#t
> [2] https://lore.kernel.org/virtualization/20211027022107.14357-1-jasowan=
g@redhat.com/T/#t
>=20
> Stefano Garzarella (2):
>   vhost/vsock: fix incorrect used length reported to the guest
>   vhost/vsock: cleanup removing `len` variable
>=20
>  drivers/vhost/vsock.c | 8 ++------
>  1 file changed, 2 insertions(+), 6 deletions(-)
>=20
> --=20
> 2.31.1
>=20

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--127DMsQtX8lXRxGZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmGc5HoACgkQnKSrs4Gr
c8ifrQf/c6D901ykYKUMEDHveFY4zXcj69oxyDMaGCumQCFh/XD4Oaj7yRcBZW/y
BdVkAHqsHa2rnkv5P4fWW0gk9JkZlk2eEmC/IaJsr2F1YdyF8VOMcpOPPGTDQQt1
MRxMr7VFZWcZDyxnntmdzYSuej1eHhriTz9VpM/hC8hklvoLavhSmYR1ZcsplnFp
KqO/RLiprEDWUDXXp1npmD8g+SIdBfMA/N6+2+ud/p94JRXk1+gfaB8kNnJOmsYc
25ygN1s1JyzJMkq+HWMe2EcZtIoZ3v0X5wLg/bMU4QssS/DjmiQ0El9MJY1O/iQh
jU9LGwY1MwTgrqVVZoNhYiepyT1ZFg==
=YxZO
-----END PGP SIGNATURE-----

--127DMsQtX8lXRxGZ--


--===============6608761296208314189==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--===============6608761296208314189==--

