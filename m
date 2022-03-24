Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7458C433FE
	for <virtualization@archiver.kernel.org>; Thu, 24 Mar 2022 09:20:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 71DB041C2B;
	Thu, 24 Mar 2022 09:20:42 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 5SMKCGjjcQuK; Thu, 24 Mar 2022 09:20:40 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 1A80B41C27;
	Thu, 24 Mar 2022 09:20:40 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id DD81FC0012;
	Thu, 24 Mar 2022 09:20:39 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B12BCC000B
 for <virtualization@lists.linux-foundation.org>;
 Thu, 24 Mar 2022 09:20:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id A895B41C27
 for <virtualization@lists.linux-foundation.org>;
 Thu, 24 Mar 2022 09:20:38 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id iv7BGaPkqjku
 for <virtualization@lists.linux-foundation.org>;
 Thu, 24 Mar 2022 09:20:37 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 6521441C26
 for <virtualization@lists.linux-foundation.org>;
 Thu, 24 Mar 2022 09:20:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1648113636;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=m6cTh4I7UZgOvgJZg1g3+MamKX/v6MrkfYevPTqDtOQ=;
 b=T3dzAKokgF24odxQyjCqAf2BZNNdTP+Vc7dnEea7pfyYY+0fQVqwB0bKpNPf1OSgdW6gzo
 h/M1kPsP4lqJNqUOWCG2oDnfQ0q5tNOfmrFWWg6kM+CNCOK/k6XUvLO1ZspzyFb//2joU3
 uqHBvmUMywGtdxoRkXP43bBiAyw6MI0=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-251-gVDYTvbPMXGAN7VyNstF0A-1; Thu, 24 Mar 2022 05:20:32 -0400
X-MC-Unique: gVDYTvbPMXGAN7VyNstF0A-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com
 [10.11.54.7])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 360163806648;
 Thu, 24 Mar 2022 09:20:32 +0000 (UTC)
Received: from localhost (unknown [10.39.195.77])
 by smtp.corp.redhat.com (Postfix) with ESMTP id AD764140262B;
 Thu, 24 Mar 2022 09:20:31 +0000 (UTC)
Date: Thu, 24 Mar 2022 09:20:30 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Stefano Garzarella <sgarzare@redhat.com>
Subject: Re: [PATCH net v3 0/3] vsock/virtio: enable VQs early on probe and
 finish the setup before using them
Message-ID: <Yjw33hb1u4Da6pKK@stefanha-x1.localdomain>
References: <20220323173625.91119-1-sgarzare@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20220323173625.91119-1-sgarzare@redhat.com>
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.7
Cc: kvm@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org,
 "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Asias He <asias@redhat.com>, Paolo Abeni <pabeni@redhat.com>,
 Arseny Krasnov <arseny.krasnov@kaspersky.com>
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
Content-Type: multipart/mixed; boundary="===============4487341091933336526=="
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>


--===============4487341091933336526==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="eKzvWnn8+0FZDZiL"
Content-Disposition: inline


--eKzvWnn8+0FZDZiL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 23, 2022 at 06:36:22PM +0100, Stefano Garzarella wrote:
> The first patch fixes a virtio-spec violation. The other two patches
> complete the driver configuration before using the VQs in the probe.
>=20
> The patch order should simplify backporting in stable branches.
>=20
> v3:
> - re-ordered the patch to improve bisectability [MST]
>=20
> v2: https://lore.kernel.org/netdev/20220323084954.11769-1-sgarzare@redhat=
=2Ecom/
> v1: https://lore.kernel.org/netdev/20220322103823.83411-1-sgarzare@redhat=
=2Ecom/
>=20
> Stefano Garzarella (3):
>   vsock/virtio: initialize vdev->priv before using VQs
>   vsock/virtio: read the negotiated features before using VQs
>   vsock/virtio: enable VQs early on probe
>=20
>  net/vmw_vsock/virtio_transport.c | 11 +++++++----
>  1 file changed, 7 insertions(+), 4 deletions(-)
>=20
> --=20
> 2.35.1
>=20

A subtle point is that we still drop events and rx packets during the
window where DRIVER_OK has been set but vqs haven't been filled.
This is acceptable because it's unavoidable and equivalent to events
happening before DRIVER_OK is set. What this revision *does* fix is that
vq used buffer notifications are no longer lost. Good.

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--eKzvWnn8+0FZDZiL
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmI8N94ACgkQnKSrs4Gr
c8j+jAgAl3SNYonulML5v3KQQY538H3xIog/TepsoHOzV9JYFRnvHbKd45XUy9uQ
/SWZsBt1J4gXz73ejgF+aNpMhfy5rNvFzEETQhsdm8Jd9Nsdh9bmh53GBaYzXm8M
SzhrB2Zje+VAVpemGrAWfpSSIuc8ZbZYUOb2eQzpWelR2GKiVyqAXdjyZzbr5CLI
n0T9fgrzNIejcl6AQ0sGKNw8a60ArlWdU0EHQzaT5hmeDbUF3dsZ9lfGT5IFrxpu
ksdPyCe5vidOQye9dRAvRQVXhVpo9MPAL83jcKY09QWpSrsz3UJZZbYAbULbOQhO
IrbJvaefmdbRXxr1Ylv8d1qhJ9pWXA==
=bbzl
-----END PGP SIGNATURE-----

--eKzvWnn8+0FZDZiL--


--===============4487341091933336526==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--===============4487341091933336526==--

