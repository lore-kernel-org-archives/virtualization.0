Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8F24C433FE
	for <virtualization@archiver.kernel.org>; Tue, 23 Nov 2021 12:49:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 5472D606F1;
	Tue, 23 Nov 2021 12:49:43 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 7vTKrUTPmkon; Tue, 23 Nov 2021 12:49:42 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 1860F60725;
	Tue, 23 Nov 2021 12:49:42 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D7215C001E;
	Tue, 23 Nov 2021 12:49:41 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 03716C0012
 for <virtualization@lists.linux-foundation.org>;
 Tue, 23 Nov 2021 12:49:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id D01BD4018E
 for <virtualization@lists.linux-foundation.org>;
 Tue, 23 Nov 2021 12:49:39 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id qi3rHs1B0gOg
 for <virtualization@lists.linux-foundation.org>;
 Tue, 23 Nov 2021 12:49:39 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id EB5C340163
 for <virtualization@lists.linux-foundation.org>;
 Tue, 23 Nov 2021 12:49:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1637671777;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=qq9RCNwYaWXQoI/gd2Bb1y62RmVls2Lwj4nIew3gKLU=;
 b=UtfPsgN+ZmAPzBs5OnxbiT+UzEa46D1H9aUYaaxFPaDMZojnHgULSo4dRvTqaWqK3QNjBp
 2o3WdDzlmXMjrUSgBVNaV2RgP8CRNIghjK6uRjiaB90cuEXG5kGv2FlaCUC451YywTQk2F
 Dm7lVUrBEPHfryceR6l/deYL+wdkY9Y=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-540-nsYRZ2KOM_2sPYaJknSsCg-1; Tue, 23 Nov 2021 07:49:33 -0500
X-MC-Unique: nsYRZ2KOM_2sPYaJknSsCg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0F55A87953E;
 Tue, 23 Nov 2021 12:49:32 +0000 (UTC)
Received: from localhost (unknown [10.39.195.64])
 by smtp.corp.redhat.com (Postfix) with ESMTP id C74FC5F4E0;
 Tue, 23 Nov 2021 12:49:22 +0000 (UTC)
Date: Tue, 23 Nov 2021 12:49:21 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH] vsock/virtio: suppress used length validation
Message-ID: <YZzjUbM+LE0dwsIi@stefanha-x1.localdomain>
References: <20211122093036.285952-1-mst@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20211122093036.285952-1-mst@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Cc: david.kaplan@amd.com, kvm@vger.kernel.org, konrad.wilk@oracle.com,
 netdev@vger.kernel.org, f.hetzelt@tu-berlin.de, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, Halil Pasic <pasic@linux.ibm.com>,
 Jakub Kicinski <kuba@kernel.org>, "David S. Miller" <davem@davemloft.net>
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
Content-Type: multipart/mixed; boundary="===============8491813174551009708=="
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>


--===============8491813174551009708==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="CQhna4TCfJN2pG2B"
Content-Disposition: inline


--CQhna4TCfJN2pG2B
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 22, 2021 at 04:32:01AM -0500, Michael S. Tsirkin wrote:
> It turns out that vhost vsock violates the virtio spec
> by supplying the out buffer length in the used length
> (should just be the in length).
> As a result, attempts to validate the used length fail with:
> vmw_vsock_virtio_transport virtio1: tx: used len 44 is larger than in buf=
len 0
>=20
> Since vsock driver does not use the length fox tx and
> validates the length before use for rx, it is safe to
> suppress the validation in virtio core for this driver.
>=20
> Reported-by: Halil Pasic <pasic@linux.ibm.com>
> Fixes: 939779f5152d ("virtio_ring: validate used buffer length")
> Cc: "Jason Wang" <jasowang@redhat.com>
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> ---
>  net/vmw_vsock/virtio_transport.c | 1 +
>  1 file changed, 1 insertion(+)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--CQhna4TCfJN2pG2B
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmGc41EACgkQnKSrs4Gr
c8h1hgf/VSC+i/I53x1gWPlapZR23ESGCMVD+7wgM6NTPM5rT+nqyAaq5IPNn9AH
08hZcOtgsKB2hi0yjlqQHhwFfOmsqF/OoEW/iQRkmNfXbNolhpdVojNOGGiKYPyF
BJuI4BLniogr840wowG1cv0QYb2sfhOSRa+Lpm4YcC8+tvB2b8qgIPnAdj24e7Xc
vuAUwNFrWcLImHqdDc/mhI5Tanz32oQn2WWFjJ4SdHK4f0KCnXZbs3dVqAI1BbEw
Ryiy0Y8rBXeO1iOzk+HMiIw+msPkRxJbdqB+7bujClo15eNYZucU9NZuaM8j6ylJ
4/7+vFLiTMW4FaM+59sh925HLVglUA==
=NGnu
-----END PGP SIGNATURE-----

--CQhna4TCfJN2pG2B--


--===============8491813174551009708==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--===============8491813174551009708==--

