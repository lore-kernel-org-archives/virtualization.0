Return-Path: <SRS0=byTZ=IU=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 752F5C433C1
	for <virtualization@archiver.kernel.org>; Mon, 22 Mar 2021 11:52:36 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EF63C61992
	for <virtualization@archiver.kernel.org>; Mon, 22 Mar 2021 11:52:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EF63C61992
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 92D5D401F0;
	Mon, 22 Mar 2021 11:52:35 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 2nXxU9EGJ8xW; Mon, 22 Mar 2021 11:52:34 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTP id 3022340122;
	Mon, 22 Mar 2021 11:52:34 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 05B94C000B;
	Mon, 22 Mar 2021 11:52:34 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 43E84C0001
 for <virtualization@lists.linux-foundation.org>;
 Mon, 22 Mar 2021 11:52:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 25CCD401E6
 for <virtualization@lists.linux-foundation.org>;
 Mon, 22 Mar 2021 11:52:33 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id TwsSESehjYzr
 for <virtualization@lists.linux-foundation.org>;
 Mon, 22 Mar 2021 11:52:31 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [63.128.21.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 91C7040122
 for <virtualization@lists.linux-foundation.org>;
 Mon, 22 Mar 2021 11:52:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1616413950;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=qKoSkNl/UDo9DPKkctm6MZbnlGmxdA4F/C0bXzOhbO4=;
 b=IRRf34Q5wSrtcNd8f8QzPSMR0LOe9jS9Or0KhygSeiSANVU1Y2CJFtHt5xYCYEOK7N2SyG
 5vZUqb6qeOoyimK463ebrtsDXHIOEB4LKhhgs37soQAawSGlKxzHrJ/ZS7D4M/K6HE81jT
 pdLb9x53js5qJWEc6mAiLUOHy7J26IE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-558-iKM1doz8NX2uNquPJxKehw-1; Mon, 22 Mar 2021 07:52:28 -0400
X-MC-Unique: iKM1doz8NX2uNquPJxKehw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C530E81620;
 Mon, 22 Mar 2021 11:52:26 +0000 (UTC)
Received: from localhost (ovpn-114-89.ams2.redhat.com [10.36.114.89])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 2250C5C1A3;
 Mon, 22 Mar 2021 11:52:22 +0000 (UTC)
Date: Mon, 22 Mar 2021 11:52:22 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Arseny Krasnov <arseny.krasnov@kaspersky.com>
Subject: Re: [RFC PATCH v1] virtio-vsock: use C style defines for constants
Message-ID: <YFiE9opnZ976hwbP@stefanha-x1.localdomain>
References: <20210322063804.641923-1-arseny.krasnov@kaspersky.com>
MIME-Version: 1.0
In-Reply-To: <20210322063804.641923-1-arseny.krasnov@kaspersky.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=stefanha@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: Andra Paraschiv <andraprs@amazon.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, cohuck@redhat.com,
 Colin Ian King <colin.king@canonical.com>,
 Norbert Slusarek <nslusarek@gmx.net>, oxffffaa@gmail.com,
 virtio-comment@lists.oasis-open.org, Jakub Kicinski <kuba@kernel.org>,
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
Content-Type: multipart/mixed; boundary="===============8723284032274748392=="
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

--===============8723284032274748392==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="AohRnOcLqTUwnZup"
Content-Disposition: inline

--AohRnOcLqTUwnZup
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 22, 2021 at 09:37:59AM +0300, Arseny Krasnov wrote:
> This:
> 1) Replaces enums with C style defines.

Why?

> 2) Adds defines for some constants.

Definitions need to be referenced somewhere to explain their use. It's
not enough to add a constant, some text in the spec should mention that
constant. (The exception to this might be a group of constants where
individual constants don't need to be mentioned explicitly.)

> Signed-off-by: Arseny Krasnov <arseny.krasnov@kaspersky.com>
> ---
>  virtio-vsock.tex | 42 ++++++++++++++++++++++--------------------
>  1 file changed, 22 insertions(+), 20 deletions(-)
>=20
> diff --git a/virtio-vsock.tex b/virtio-vsock.tex
> index da7e641..62ab6b3 100644
> --- a/virtio-vsock.tex
> +++ b/virtio-vsock.tex
> @@ -86,23 +86,18 @@ \subsection{Device Operation}\label{sec:Device Types =
/ Socket Device / Device Op
>  operation constants:
> =20
>  \begin{lstlisting}
> -enum {
> -=09VIRTIO_VSOCK_OP_INVALID =3D 0,
> -
> -=09/* Connect operations */
> -=09VIRTIO_VSOCK_OP_REQUEST =3D 1,
> -=09VIRTIO_VSOCK_OP_RESPONSE =3D 2,
> -=09VIRTIO_VSOCK_OP_RST =3D 3,
> -=09VIRTIO_VSOCK_OP_SHUTDOWN =3D 4,
> -
> -=09/* To send payload */
> -=09VIRTIO_VSOCK_OP_RW =3D 5,
> -
> -=09/* Tell the peer our credit info */
> -=09VIRTIO_VSOCK_OP_CREDIT_UPDATE =3D 6,
> -=09/* Request the peer to send the credit info to us */
> -=09VIRTIO_VSOCK_OP_CREDIT_REQUEST =3D 7,
> -};
> +#define VIRTIO_VSOCK_OP_INVALID        0
> +/* Connect operations */
> +#define VIRTIO_VSOCK_OP_REQUEST        1
> +#define VIRTIO_VSOCK_OP_RESPONSE       2
> +#define VIRTIO_VSOCK_OP_RST            3
> +#define VIRTIO_VSOCK_OP_SHUTDOWN       4
> +/* To send payload */
> +#define VIRTIO_VSOCK_OP_RW             5
> +/* Tell the peer our credit info */
> +#define VIRTIO_VSOCK_OP_CREDIT_UPDATE  6
> +/* Request the peer to send the credit info to us */
> +#define VIRTIO_VSOCK_OP_CREDIT_REQUEST 7
>  \end{lstlisting}
> =20
>  \subsubsection{Virtqueue Flow Control}\label{sec:Device Types / Socket D=
evice / Device Operation / Virtqueue Flow Control}
> @@ -143,6 +138,10 @@ \subsubsection{Addressing}\label{sec:Device Types / =
Socket Device / Device Opera
>  Currently only stream sockets are supported. \field{type} is 1 for strea=
m
>  socket types.
> =20
> +\begin{lstlisting}
> +#define VIRTIO_VSOCK_TYPE_STREAM 1
> +\end{lstlisting}
> +
>  Stream sockets provide in-order, guaranteed, connection-oriented deliver=
y
>  without message boundaries.
> =20
> @@ -227,6 +226,11 @@ \subsubsection{Stream Sockets}\label{sec:Device Type=
s / Socket Device / Device O
>  hints are permanent once sent and successive packets with bits clear do =
not
>  reset them.
> =20
> +\begin{lstlisting}
> +#define VIRTIO_VSOCK_SHUTDOWN_RECEIVE_BIT 0
> +#define VIRTIO_VSOCK_SHUTDOWN_SEND_BIT    1
> +\end{lstlisting}

The spec has no other _BIT constants. It uses bitmasks instead. I
suggest following that for consistency:

  #define VIRTIO_VSOCK_SHUTDOWN_RECEIVE (1 << 0)
  #define VIRTIO_VSOCK_SHUTDOWN_SEND    (1 << 1)

--AohRnOcLqTUwnZup
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmBYhPUACgkQnKSrs4Gr
c8hHHgf/Y+oGWc7oJ7zvInvvxLX96EynLgt56Btj0GMeOSp4PKh/tVSp50F8d4QU
oj7ABFDmUOMUoO8UXf0ZYb02j9/XwlAJ2409hEIsR7H+fdapjvXlz3EEECKK+kTj
B+bcI+wYNfmVnFp1Q/JHgdTje2CeObGWiJdzIi8qwE80aNZvsd4hSSQ2os7LkGpR
bxe8rzPi10vQw2OfjDeCg/gdRrEFZ1041f+IKyAiyjbXMm5pFmwtzgB6akNBX55f
jxqSTAAhEHQg0ST+KSxDmkeedeeccoLvQOBXeDyb4kitPb/vXtw73pWeNftrGm1T
XsY7nW7bsQP6FZFoeivvUbfL1kPgUQ==
=DTps
-----END PGP SIGNATURE-----

--AohRnOcLqTUwnZup--


--===============8723284032274748392==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--===============8723284032274748392==--

