Return-Path: <SRS0=ZzT7=N4=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 760E9C433EF
	for <virtualization@archiver.kernel.org>; Mon,  6 Sep 2021 13:25:28 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 37D3660BD3
	for <virtualization@archiver.kernel.org>; Mon,  6 Sep 2021 13:25:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 37D3660BD3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 066BC80EC5;
	Mon,  6 Sep 2021 13:25:28 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Ob8lccaiXoJO; Mon,  6 Sep 2021 13:25:27 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id A44B680ED5;
	Mon,  6 Sep 2021 13:25:26 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 7E696C001C;
	Mon,  6 Sep 2021 13:25:26 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B36FFC001B
 for <virtualization@lists.linux-foundation.org>;
 Mon,  6 Sep 2021 13:25:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id AF71560623
 for <virtualization@lists.linux-foundation.org>;
 Mon,  6 Sep 2021 13:25:25 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id oYD6NAJMYYAf
 for <virtualization@lists.linux-foundation.org>;
 Mon,  6 Sep 2021 13:25:25 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 151C8605F5
 for <virtualization@lists.linux-foundation.org>;
 Mon,  6 Sep 2021 13:25:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1630934724;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=FFpd6/N6m5lgoVk64+1SF9kAP2eThhXGNh0khWWyMZA=;
 b=QAjvep6PycsTJ+rBCOJ9zYMQonB7qM1tljAFIWsB/5gTMdDxMnZfdhDRZ6EDElpTbRIfGs
 6x7RfFbjyu/AERd1rM8GsOXTnGpFTcH1IQUd4hcdq/JZ9m6OrrM/vF9NJ0mb7BKdvMYIIj
 hO0/abAOXjA3Bey7Li/Qm0SfU8Sbi58=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-63-nKGxhU-XNpu_oU6XHcLNPg-1; Mon, 06 Sep 2021 09:25:22 -0400
X-MC-Unique: nKGxhU-XNpu_oU6XHcLNPg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 51AD45139;
 Mon,  6 Sep 2021 13:25:21 +0000 (UTC)
Received: from localhost (unknown [10.39.194.203])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 005E8104328F;
 Mon,  6 Sep 2021 13:25:16 +0000 (UTC)
Date: Mon, 6 Sep 2021 14:25:16 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Stefano Garzarella <sgarzare@redhat.com>
Subject: Re: [PATCH] MAINTAINERS: add VM SOCKETS (AF_VSOCK) entry
Message-ID: <YTYWvPheBop0j9NE@stefanha-x1.localdomain>
References: <20210906091159.66181-1-sgarzare@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20210906091159.66181-1-sgarzare@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Cc: "Michael S . Tsirkin" <mst@redhat.com>, netdev@vger.kernel.org,
 Dexuan Cui <decui@microsoft.com>, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, Jakub Kicinski <kuba@kernel.org>,
 "David S. Miller" <davem@davemloft.net>, Jorgen Hansen <jhansen@vmware.com>
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
Content-Type: multipart/mixed; boundary="===============0626966022954004487=="
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>


--===============0626966022954004487==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="egTLbucVUnkLLRdY"
Content-Disposition: inline


--egTLbucVUnkLLRdY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 06, 2021 at 11:11:59AM +0200, Stefano Garzarella wrote:
> Add a new entry for VM Sockets (AF_VSOCK) that covers vsock core,
> tests, and headers. Move some general vsock stuff from virtio-vsock
> entry into this new more general vsock entry.
>=20
> I've been reviewing and contributing for the last few years,
> so I'm available to help maintain this code.
>=20
> Cc: Dexuan Cui <decui@microsoft.com>
> Cc: Jorgen Hansen <jhansen@vmware.com>
> Cc: Stefan Hajnoczi <stefanha@redhat.com>
> Suggested-by: Michael S. Tsirkin <mst@redhat.com>
> Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
> ---
>=20
> Dexuan, Jorgen, Stefan, would you like to co-maintain or
> be added as a reviewer?
>=20
> Thanks,
> Stefano
> ---
>  MAINTAINERS | 20 +++++++++++++-------
>  1 file changed, 13 insertions(+), 7 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--egTLbucVUnkLLRdY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmE2FrwACgkQnKSrs4Gr
c8jEZQf+Mfd2vZSV6MjdLRiIfXBITs3hKCU0gG5rAyPkHFG9iRC1FHnb9+2Sfdmn
w7Tr84qXtblshpZIT94PeEGboKkJnGrVsF84ddpq+TWwSQFlhpv+N/rT/wn/2Vz5
vcf5dAhkUt/bQb5/6X8JDAjf1SUDuiocPuCoQpbx4wP8XwsODH/bEAhtDaZsquMP
1/HDuG4tud/kaNJgbmvz7bpnqGJz9nt8m94FppYHUOBXPKuRIApKYfT8HYKBWUD9
keN6K0Hl/2382yZa0q/ExA+IsPKwgY2h5fDRxLzUykBqM5uJ1kwBKlVhk5NpPzcx
xdufFwlbUSQO2Ljm+b+w+mcX5A6FSw==
=iOz5
-----END PGP SIGNATURE-----

--egTLbucVUnkLLRdY--


--===============0626966022954004487==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--===============0626966022954004487==--

