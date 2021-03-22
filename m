Return-Path: <SRS0=byTZ=IU=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA45FC433C1
	for <virtualization@archiver.kernel.org>; Mon, 22 Mar 2021 14:30:24 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 41AA06196C
	for <virtualization@archiver.kernel.org>; Mon, 22 Mar 2021 14:30:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 41AA06196C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id D93AE6067B;
	Mon, 22 Mar 2021 14:30:23 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id mhDI6pSM0pWn; Mon, 22 Mar 2021 14:30:22 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTP id E3A37605C6;
	Mon, 22 Mar 2021 14:30:21 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B8991C000A;
	Mon, 22 Mar 2021 14:30:21 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 6A3AFC0001
 for <virtualization@lists.linux-foundation.org>;
 Mon, 22 Mar 2021 14:30:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 4BAA860659
 for <virtualization@lists.linux-foundation.org>;
 Mon, 22 Mar 2021 14:30:20 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id KpBpxfq1UYPO
 for <virtualization@lists.linux-foundation.org>;
 Mon, 22 Mar 2021 14:30:19 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 3587B605C6
 for <virtualization@lists.linux-foundation.org>;
 Mon, 22 Mar 2021 14:30:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1616423417;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=mzrdjm2h8iME3PHtwMUliNJ6ceBGyzKoZgpATCCTPs0=;
 b=dxhwdeKlhfvPMMBvEW5wv+f1PTxtWNHRiRzZNK71LCHkLh3oGcaTj+lLZkO81hzrJ3fhWD
 RLJkpOIOQpZFgvMqU4zqg1FKSu/Ke2fOw7/94WHVUBZMrHYDe6PvHlXzvAhOPcgCGWyi/Q
 qSU0ZCbylxEJaIrStlFimDTt6ONJUD4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-193-1txcawI9MtGCrVvhOKPosg-1; Mon, 22 Mar 2021 10:30:15 -0400
X-MC-Unique: 1txcawI9MtGCrVvhOKPosg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CDBDC81620;
 Mon, 22 Mar 2021 14:30:13 +0000 (UTC)
Received: from localhost (ovpn-114-89.ams2.redhat.com [10.36.114.89])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 2252560936;
 Mon, 22 Mar 2021 14:30:10 +0000 (UTC)
Date: Mon, 22 Mar 2021 14:30:09 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [RFC PATCH v1] virtio-vsock: use C style defines for constants
Message-ID: <YFip8VVJOXy2EpjH@stefanha-x1.localdomain>
References: <20210322063804.641923-1-arseny.krasnov@kaspersky.com>
 <YFiE9opnZ976hwbP@stefanha-x1.localdomain>
 <20210322092547-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
In-Reply-To: <20210322092547-mutt-send-email-mst@kernel.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=stefanha@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: Andra Paraschiv <andraprs@amazon.com>, cohuck@redhat.com,
 Colin Ian King <colin.king@canonical.com>,
 Norbert Slusarek <nslusarek@gmx.net>, oxffffaa@gmail.com,
 virtio-comment@lists.oasis-open.org, Jakub Kicinski <kuba@kernel.org>,
 Arseny Krasnov <arseny.krasnov@kaspersky.com>,
 virtualization@lists.linux-foundation.org,
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
Content-Type: multipart/mixed; boundary="===============1837498623587320535=="
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

--===============1837498623587320535==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="m0kjr1Hpbh7R4BU3"
Content-Disposition: inline

--m0kjr1Hpbh7R4BU3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 22, 2021 at 09:34:58AM -0400, Michael S. Tsirkin wrote:
> On Mon, Mar 22, 2021 at 11:52:22AM +0000, Stefan Hajnoczi wrote:
> > On Mon, Mar 22, 2021 at 09:37:59AM +0300, Arseny Krasnov wrote:
> > > @@ -227,6 +226,11 @@ \subsubsection{Stream Sockets}\label{sec:Device =
Types / Socket Device / Device O
> > >  hints are permanent once sent and successive packets with bits clear=
 do not
> > >  reset them.
> > > =20
> > > +\begin{lstlisting}
> > > +#define VIRTIO_VSOCK_SHUTDOWN_RECEIVE_BIT 0
> > > +#define VIRTIO_VSOCK_SHUTDOWN_SEND_BIT    1
> > > +\end{lstlisting}
> >=20
> > The spec has no other _BIT constants.
>=20
> True. Sometimes there's an _F_ somewhere there instead.

You're right, I missed the virtio-net bit constants:

  #define VIRTIO_NET_F_GUEST_TSO4 7

Compared to:

  #define VIRTQ_DESC_F_AVAIL     (1 << 7)

or

  #define VIRTQ_DESC_F_WRITE     2

It's an inconsistent mix :). Hard to tell them apart when they aren't
bitmask constants with '<<'.

Can we use '<<' for clarity on new constants?

--m0kjr1Hpbh7R4BU3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmBYqfEACgkQnKSrs4Gr
c8jGwwf/VHvg4GcJFI4sGd8lRQb16ehd3TeYlmvchAeSZrJQWyxpuCoLsyCHgX7k
naA9dJOdp7WLduYgjOlpkS6jV1iX9Wwe1yKnMMEdJ27+SD8Q9FQlTYgOg5UkrBJb
gHSeRX4lneVDmWublPBAHaKnQuMQp+0z4y+sqaPRYJOQZDwcetJ1aXELOzDL9tt1
2f0qLskrnns+tt9UrIqqvvtPYU4O//dF8fgxN17bemA94lxjVMu+Kkg4JXPjR3Gq
/QpmmJrD7Bg4urDB/xNdvTS2j6pYMP+BPckPeGQphweyxhZ4gxBEoHK40l8C570G
nkn6UVafkUdooCHM91TDcdTW4ZQ6zQ==
=T+k4
-----END PGP SIGNATURE-----

--m0kjr1Hpbh7R4BU3--


--===============1837498623587320535==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--===============1837498623587320535==--

