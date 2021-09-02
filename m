Return-Path: <SRS0=fDOL=NY=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C669C4320A
	for <virtualization@archiver.kernel.org>; Thu,  2 Sep 2021 14:07:45 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 07A88610CE
	for <virtualization@archiver.kernel.org>; Thu,  2 Sep 2021 14:07:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 07A88610CE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id B5FED82CDE;
	Thu,  2 Sep 2021 14:07:44 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id E09rliCM4566; Thu,  2 Sep 2021 14:07:40 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 4B0C382CD3;
	Thu,  2 Sep 2021 14:07:40 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 1F1C2C001A;
	Thu,  2 Sep 2021 14:07:40 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E8581C000E
 for <virtualization@lists.linux-foundation.org>;
 Thu,  2 Sep 2021 14:07:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id E39C5614E6
 for <virtualization@lists.linux-foundation.org>;
 Thu,  2 Sep 2021 14:07:38 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id oVy_4FSCGy5E
 for <virtualization@lists.linux-foundation.org>;
 Thu,  2 Sep 2021 14:07:38 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 3390D60595
 for <virtualization@lists.linux-foundation.org>;
 Thu,  2 Sep 2021 14:07:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1630591657;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=RWE8073BwqcRlxCHnt1DDkp3XQojVNPk2cBeJFtiNJE=;
 b=WD1fHjylzCOwLve/eXnXA1YvF33/x5SkCh1fu8U7LK31h0ViOU2WDj6iDe3iAOwkyEjDCu
 3SZww0dDkjDEMtWmab67HZ+puBJLq0mpYDNCYsxL68HzeFAzColKB55JxLF3GvemwyL5UU
 1cdLIEDQTjUSGFN6DvhbOJGtRc2Ep5Q=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-492-HdrDWvs8MnOT3GrTSaVv5g-1; Thu, 02 Sep 2021 10:07:34 -0400
X-MC-Unique: HdrDWvs8MnOT3GrTSaVv5g-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9D31518FF449;
 Thu,  2 Sep 2021 14:07:32 +0000 (UTC)
Received: from localhost (unknown [10.39.194.169])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 640365C23A;
 Thu,  2 Sep 2021 14:07:24 +0000 (UTC)
Date: Thu, 2 Sep 2021 15:07:23 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Jiang Wang <jiang.wang@bytedance.com>
Subject: Re: [PATCH v5] virtio-vsock: add description for datagram type
Message-ID: <YTDam7jdjRz686bp@stefanha-x1.localdomain>
References: <20210610181203.979686-1-jiang.wang@bytedance.com>
MIME-Version: 1.0
In-Reply-To: <20210610181203.979686-1-jiang.wang@bytedance.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=stefanha@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: cong.wang@bytedance.com, duanxiongchun@bytedance.com, mst@redhat.com,
 cohuck@redhat.com, virtualization@lists.linux-foundation.org,
 xieyongji@bytedance.com, chaiwen.cc@bytedance.com,
 virtio-comment@lists.oasis-open.org, asias@redhat.com,
 arseny.krasnov@kaspersky.com, jhansen@vmware.com
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
Content-Type: multipart/mixed; boundary="===============6261538846526587102=="
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

--===============6261538846526587102==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="xHaviDlxe6Te8LV4"
Content-Disposition: inline

--xHaviDlxe6Te8LV4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 10, 2021 at 06:12:03PM +0000, Jiang Wang wrote:
> Add supports for datagram type for virtio-vsock. Datagram
> sockets are connectionless and unreliable. To avoid contention
> with stream and other sockets, add two more virtqueues and
> a new feature bit to identify if those two new queues exist or not.
>=20
> Also add descriptions for resource management of datagram, which
> does not use the existing credit update mechanism associated with
> stream sockets.
>=20
> Signed-off-by: Jiang Wang <jiang.wang@bytedance.com>
> ---

Overall this looks good. The tricky thing will be implementing dgram
sockets in a way that minimizes dropped packets and provides some degree
of fairness between senders. Those are implementation issues though and
not visible at the device specification level.

> diff --git a/virtio-vsock.tex b/virtio-vsock.tex
> index da7e641..26a62ac 100644
> --- a/virtio-vsock.tex
> +++ b/virtio-vsock.tex
> @@ -9,14 +9,37 @@ \subsection{Device ID}\label{sec:Device Types / Socket =
Device / Device ID}
> =20
>  \subsection{Virtqueues}\label{sec:Device Types / Socket Device / Virtque=
ues}
>  \begin{description}
> -\item[0] rx
> -\item[1] tx
> +\item[0] stream rx
> +\item[1] stream tx
> +\item[2] datagram rx
> +\item[3] datagram tx
> +\item[4] event
> +\end{description}
> +The virtio socket device uses 5 queues if feature bit VIRTIO_VSOCK_F_DRG=
AM is set. Otherwise, it
> +only uses 3 queues, as the following.

s/as the following/as follows:/

> +
> +\begin{description}
> +\item[0] stream rx
> +\item[1] stream tx
>  \item[2] event
>  \end{description}
> =20
> +When behavior differs between stream and datagram rx/tx virtqueues
> +their full names are used. Common behavior is simply described in
> +terms of rx/tx virtqueues and applies to both stream and datagram
> +virtqueues.
> +
>  \subsection{Feature bits}\label{sec:Device Types / Socket Device / Featu=
re bits}
> =20
> -There are currently no feature bits defined for this device.
> +\begin{description}
> +\item[VIRTIO_VSOCK_F_STREAM (0)] Device has support for stream socket ty=
pe.
> +\end{description}
> +
> +\begin{description}
> +\item[VIRTIO_VSOCK_F_DGRAM (2)] Device has support for datagram socket t=
ype.

Is this really bit 2 or did you mean bit 1 (value 0x2)?

What happens to the virtqueue layout when VIRTIO_VSOCK_F_DGRAM is
present and VIRTIO_VSOCK_F_STREAM is absent? The virtqueue section above
implies that VIRTIO_VSOCK_F_STREAM is always present.

> +\end{description}
> +
> +If no feature bits are defined, assume device only supports stream socke=
t type.

It's cleaner to define VIRTIO_VSOCK_F_NO_STREAM (0) instead. When the
bit is set the stream socket type is not available and the stream_rx/tx
virtqueues are absent.

This way it's not necessary to define special behavior depending on
certain combinations of feature bits.

>  \subsubsection{Receive and Transmit}\label{sec:Device Types / Socket Dev=
ice / Device Operation / Receive and Transmit}
> -The driver queues outgoing packets on the tx virtqueue and incoming pack=
et
> +The driver queues outgoing packets on the tx virtqueue and allocates inc=
oming packet
>  receive buffers on the rx virtqueue. Packets are of the following form:

This change seems unrelated to dgram sockets. I don't think adding the
word "allocates" makes things clearer or more precise. The driver may
reuse receive buffers rather than allocating fresh buffers. I suggest
dropping this change.

> =20
>  \begin{lstlisting}
> @@ -195,6 +235,7 @@ \subsubsection{Receive and Transmit}\label{sec:Device=
 Types / Socket Device / De
>  };
>  \end{lstlisting}
> =20
> +
>  Virtqueue buffers for outgoing packets are read-only. Virtqueue buffers =
for
>  incoming packets are write-only.
> =20

Unnecessary whitespace change. Please drop.

--xHaviDlxe6Te8LV4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmEw2poACgkQnKSrs4Gr
c8jACAgAvWJK8PjstqxPl8/1Pq9uERWqlGzHJXHhwqwtbZpANKpmvKYA/JJrWUfZ
Qs4zBtlpWQw4q8GcUG/c0MYtTxuhqaMbgmEPWlu1jxnQbgndrZp/K1VdHxpHacON
hqZugtMkiqGF7+zppwU8BX3eS4Jz6Omoddds7JkSXaQ2Y0AK6Xn3Rq2dig2S+CZp
synKbLsBYrEm+9CCO0UkCgSfOrO1MdO9UZj9Jv3NeMkXtrk1OYSpF4vA/lHlt177
ye6urw3lIyNvQY9D7qKLIg8ZrH9KB1Vx01UobCaOLdW09E7B5dyDGENWz22KoAbC
rLIPLc5GGmsvsA9WpZmFEX/ZmM9y/g==
=x61w
-----END PGP SIGNATURE-----

--xHaviDlxe6Te8LV4--


--===============6261538846526587102==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--===============6261538846526587102==--

