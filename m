Return-Path: <SRS0=L1Zq=IV=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_RED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8839FC433C1
	for <virtualization@archiver.kernel.org>; Tue, 23 Mar 2021 12:44:01 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 09123619B1
	for <virtualization@archiver.kernel.org>; Tue, 23 Mar 2021 12:44:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 09123619B1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id A2E7482796;
	Tue, 23 Mar 2021 12:44:00 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id iGrZmQK-NxCQ; Tue, 23 Mar 2021 12:44:00 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTP id 6477E82A9D;
	Tue, 23 Mar 2021 12:43:59 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 1A1A8C000B;
	Tue, 23 Mar 2021 12:43:59 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D309CC0001
 for <virtualization@lists.linux-foundation.org>;
 Tue, 23 Mar 2021 12:43:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id C5BC4402D1
 for <virtualization@lists.linux-foundation.org>;
 Tue, 23 Mar 2021 12:43:57 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id VZk4MFQX8fJ3
 for <virtualization@lists.linux-foundation.org>;
 Tue, 23 Mar 2021 12:43:57 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 27671402C3
 for <virtualization@lists.linux-foundation.org>;
 Tue, 23 Mar 2021 12:43:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1616503435;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=LbdABaTIDh8IYF0VwFYSNf4ZAPfTaDeGG04JOVTLe/U=;
 b=ANj1i8kbKlQ3BfNOPR1/IXvuGJj5Ht9vSOo8NifrJA3daLTvsHcornK5TadfSWCKITQQxq
 8cVEuA9My/HSINFep64F/gO8+5WzjQe8207iP1sbwZw0GoLRo7wI6JKaeZdwVS3Qr3kcek
 7HS1artUUGeqBVf7ewCrCHBhUoJy05M=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-425-u8RTTW45P1mby6kHfaiuIA-1; Tue, 23 Mar 2021 08:43:51 -0400
X-MC-Unique: u8RTTW45P1mby6kHfaiuIA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 96396108BD06;
 Tue, 23 Mar 2021 12:43:49 +0000 (UTC)
Received: from localhost (ovpn-114-89.ams2.redhat.com [10.36.114.89])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 59CBD5D6AD;
 Tue, 23 Mar 2021 12:43:45 +0000 (UTC)
Date: Tue, 23 Mar 2021 12:43:44 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Arseny Krasnov <arseny.krasnov@kaspersky.com>
Subject: Re: [RFC PATCH v2] virtio-vsock: use C style defines for constants
Message-ID: <YFnigCXUZrOUzi+G@stefanha-x1.localdomain>
References: <20210323090449.527947-1-arseny.krasnov@kaspersky.com>
MIME-Version: 1.0
In-Reply-To: <20210323090449.527947-1-arseny.krasnov@kaspersky.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=stefanha@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: Andra Paraschiv <andraprs@amazon.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Jeff Vander Stoep <jeffv@google.com>,
 cohuck@redhat.com, Colin Ian King <colin.king@canonical.com>,
 Norbert Slusarek <nslusarek@gmx.net>, oxffffaa@gmail.com,
 virtio-comment@lists.oasis-open.org, Jakub Kicinski <kuba@kernel.org>,
 Alexander Popov <alex.popov@linux.com>,
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
Content-Type: multipart/mixed; boundary="===============0315716526915537317=="
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

--===============0315716526915537317==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="7++bOigjThu86mds"
Content-Disposition: inline

--7++bOigjThu86mds
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 23, 2021 at 12:04:44PM +0300, Arseny Krasnov wrote:
> This:
> 1) Replaces enums with C style defines.

Why? Please include the rationale for this change in the commit
description.

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

Please reference these constants in the text.

--7++bOigjThu86mds
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmBZ4oAACgkQnKSrs4Gr
c8grbwf/QpQv0yclIltRjvbToaCHTiL/3nYDrNvSutUYYhF2GBLL9EHgW6XB0OzT
4hxEChT5d/LfUmcab8CIZ87k2W2y+mjQls08EsByAHAE26LQBqkXp7vI02H7oaWe
jf5DUL6he4WujzbJ0q351tIKEcZ0mFpu7F1td95MRWtvqB0gWLy1TIYrS7VOUD1F
+pxF98q5UaDUJ14cas8hPZLLbxILlUrISR9518eszizN0lXW3r2FW8y7lxyMwGZY
48ar0mhlEZRljR+BBiKDIHMv42YUOYEFII/4QtwuXdsbckgajA+xJWAOaB7H0HeK
m1aQVN4/RghQSpDxRnS6mrvr8weEQg==
=hbs5
-----END PGP SIGNATURE-----

--7++bOigjThu86mds--


--===============0315716526915537317==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--===============0315716526915537317==--

