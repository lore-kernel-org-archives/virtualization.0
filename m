Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5034DC433EF
	for <virtualization@archiver.kernel.org>; Wed, 23 Mar 2022 13:46:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id E4B1360E8A;
	Wed, 23 Mar 2022 13:46:16 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 0nVdjtuXSefl; Wed, 23 Mar 2022 13:46:16 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 9337A60BA3;
	Wed, 23 Mar 2022 13:46:15 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 65796C001A;
	Wed, 23 Mar 2022 13:46:15 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id AC799C000B
 for <virtualization@lists.linux-foundation.org>;
 Wed, 23 Mar 2022 13:46:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 88C5961351
 for <virtualization@lists.linux-foundation.org>;
 Wed, 23 Mar 2022 13:46:13 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id N--tK-_XOhTO
 for <virtualization@lists.linux-foundation.org>;
 Wed, 23 Mar 2022 13:46:13 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id F215660E8A
 for <virtualization@lists.linux-foundation.org>;
 Wed, 23 Mar 2022 13:46:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1648043171;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=r2ArAPXvrv/TTXw/O+6dULKaF/VEo7lLXu9ib9rAig8=;
 b=W1vfZgOOh1gVfjv72Bachv283YjdRNe//c8ObNeCqBSS7N/zN+638wT7Dc5FhYm34G2OQc
 YvX3pVYRy1IgLje8UurtA3LGtDhWLkhUJQU84af3v+JvoUEZT+D/LeAqUyGVdbonLxlKvm
 FmBslAEGtIE1LKS/89c8jXVRH6/8TDM=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-346-8o8tsRP4MC2v1RG4MwKmcg-1; Wed, 23 Mar 2022 09:46:08 -0400
X-MC-Unique: 8o8tsRP4MC2v1RG4MwKmcg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 738921066543;
 Wed, 23 Mar 2022 13:46:07 +0000 (UTC)
Received: from localhost (unknown [10.39.194.72])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 16012778A;
 Wed, 23 Mar 2022 13:45:47 +0000 (UTC)
Date: Wed, 23 Mar 2022 13:45:47 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Stefano Garzarella <sgarzare@redhat.com>
Subject: Re: [PATCH net v2 3/3] vsock/virtio: read the negotiated features
 before using VQs
Message-ID: <Yjski+9n4i2yO6Y7@stefanha-x1.localdomain>
References: <20220323084954.11769-1-sgarzare@redhat.com>
 <20220323084954.11769-4-sgarzare@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20220323084954.11769-4-sgarzare@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.11.54.5
Cc: kvm@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, Asias He <asias@redhat.com>,
 Jakub Kicinski <kuba@kernel.org>,
 Arseny Krasnov <arseny.krasnov@kaspersky.com>, Paolo Abeni <pabeni@redhat.com>,
 "David S. Miller" <davem@davemloft.net>
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
Content-Type: multipart/mixed; boundary="===============3675786638985509766=="
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>


--===============3675786638985509766==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="ESZNlMKuoNvVk3FN"
Content-Disposition: inline


--ESZNlMKuoNvVk3FN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 23, 2022 at 09:49:54AM +0100, Stefano Garzarella wrote:
> Complete the driver configuration, reading the negotiated features,
> before using the VQs and tell the device that the driver is ready in
> the virtio_vsock_probe().
>=20
> Fixes: 53efbba12cc7 ("virtio/vsock: enable SEQPACKET for transport")
> Suggested-by: Michael S. Tsirkin <mst@redhat.com>
> Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
> ---
>  net/vmw_vsock/virtio_transport.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--ESZNlMKuoNvVk3FN
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEyBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmI7JIoACgkQnKSrs4Gr
c8gQjQf3XP5ygWafG+PULHBzIbODxXHMVdsbdByn8Vs7iFXLFZgffOrT6fOd00fy
x+bBG0sfrh6i4ziAVbttjUElrWbypPpAq3dHdq+SATGbffeICKTG7lpbJD1jtNAl
jS0al9PKbdCSwFoGjincI7vjn2lPclN7kxpftZq3LfZVTbSfSektQVPmTMYvx9gI
LjKsZxB/3iNdfO+xgR1P0fd0tBbDW6VT3PURtkRh6itzvz38d26oO98YcfIStE8T
aUZv2Zjsh/96htGWRHd+QAP0KlKXVtDPpNPQ7yrXsZJDTGhkeAmlmb4ZzCVIjIe2
SZzyEJ1EhRIV0re1X49ARKqQ8hM0
=O+3Q
-----END PGP SIGNATURE-----

--ESZNlMKuoNvVk3FN--


--===============3675786638985509766==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--===============3675786638985509766==--

