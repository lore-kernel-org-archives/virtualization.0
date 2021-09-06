Return-Path: <SRS0=ZzT7=N4=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E0FBC433EF
	for <virtualization@archiver.kernel.org>; Mon,  6 Sep 2021 13:24:47 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CDB7E60F6B
	for <virtualization@archiver.kernel.org>; Mon,  6 Sep 2021 13:24:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org CDB7E60F6B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 985A940242;
	Mon,  6 Sep 2021 13:24:46 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id TmKRlmdFHJwA; Mon,  6 Sep 2021 13:24:45 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 5ABE640229;
	Mon,  6 Sep 2021 13:24:45 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 3BCD4C001C;
	Mon,  6 Sep 2021 13:24:45 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 09313C001B
 for <virtualization@lists.linux-foundation.org>;
 Mon,  6 Sep 2021 13:24:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id DF21E80EC5
 for <virtualization@lists.linux-foundation.org>;
 Mon,  6 Sep 2021 13:24:43 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 1SiGOhPyMmA1
 for <virtualization@lists.linux-foundation.org>;
 Mon,  6 Sep 2021 13:24:43 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 19A9480E4F
 for <virtualization@lists.linux-foundation.org>;
 Mon,  6 Sep 2021 13:24:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1630934682;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=KpGb85w8gQcgfPRHBY1c5nljJLmxAZ2B+i0uFEYG7dE=;
 b=UGubOZpXOssb+mphw+e/x4ioEX41YXdH/m7NRG0Q75CvRDO0BxukwSbPZ6i/7MV4Wjgzol
 m4zBvxk0fP0cblGA/8iZ/jMZf2jHxkKqiqElIlUKH8Unr6wY4GSZidqrKm1QpZEa61ASic
 Y8XAc/1hk4uznILXvVYqfynCOpPY9cA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-247-ZtEtZBdDPTGGlzYQ_rTNKw-1; Mon, 06 Sep 2021 09:24:40 -0400
X-MC-Unique: ZtEtZBdDPTGGlzYQ_rTNKw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 740D510054F6;
 Mon,  6 Sep 2021 13:24:39 +0000 (UTC)
Received: from localhost (unknown [10.39.194.203])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 3C8835C22B;
 Mon,  6 Sep 2021 13:24:35 +0000 (UTC)
Date: Mon, 6 Sep 2021 14:24:34 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Stefano Garzarella <sgarzare@redhat.com>
Subject: Re: [PATCH] MAINTAINERS: add VM SOCKETS (AF_VSOCK) entry
Message-ID: <YTYWkupSYR29IMuM@stefanha-x1.localdomain>
References: <20210906091159.66181-1-sgarzare@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20210906091159.66181-1-sgarzare@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
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
Content-Type: multipart/mixed; boundary="===============8303850138464943222=="
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>


--===============8303850138464943222==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="rgq6+WKf0E8dVAr9"
Content-Disposition: inline


--rgq6+WKf0E8dVAr9
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

Please skip me for now. I'm available if you take an extended period of
time off and other special situations but don't have enough time to play
an active role.

Thanks,
Stefan

--rgq6+WKf0E8dVAr9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmE2FpIACgkQnKSrs4Gr
c8h+dAgAgaznoT/gv3/pwLS4I0vUZFmrU8gfnCt9njexTIR3/p2nwq3kt6smttke
PxIsIDO9CuBUhktBZTOBQcm1CCMJ89uus3PzzpUEI/CxKLxupWW1ZSAjFVLDg1AR
KuRW9T5KW9lZKIwq++RLWMCAl+qu/kx6rxuD6opi7zpda6yTDL5i4EKov1Iq/yWL
MLeJDqcvTyEKsaR6eMuE+3uJpqVreZBns1hUpmJb3dql3JtKTQls08TIv/CCnmSw
KsOl2OIZ9m5c5XkJ2gY0ZkLU8UMpn4gqAEs/4M//WiA1jHb7OKEZwNB5HTHs6BOV
8RAAzszVVesp0VG0mrrFr3i5E7YC3g==
=0Br2
-----END PGP SIGNATURE-----

--rgq6+WKf0E8dVAr9--


--===============8303850138464943222==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--===============8303850138464943222==--

