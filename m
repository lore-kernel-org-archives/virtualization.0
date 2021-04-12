Return-Path: <SRS0=TAdK=JJ=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B036BC433ED
	for <virtualization@archiver.kernel.org>; Mon, 12 Apr 2021 13:50:38 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 54C196121E
	for <virtualization@archiver.kernel.org>; Mon, 12 Apr 2021 13:50:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 54C196121E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 1B0C483B39;
	Mon, 12 Apr 2021 13:50:38 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id mCZFImx7-QkV; Mon, 12 Apr 2021 13:50:36 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTP id 51DC283ACD;
	Mon, 12 Apr 2021 13:50:36 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 2AB39C000C;
	Mon, 12 Apr 2021 13:50:36 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id AC759C000A
 for <virtualization@lists.linux-foundation.org>;
 Mon, 12 Apr 2021 13:50:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 9B3654020C
 for <virtualization@lists.linux-foundation.org>;
 Mon, 12 Apr 2021 13:50:34 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 6QtOHBY816hg
 for <virtualization@lists.linux-foundation.org>;
 Mon, 12 Apr 2021 13:50:33 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 4F07440205
 for <virtualization@lists.linux-foundation.org>;
 Mon, 12 Apr 2021 13:50:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1618235432;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=q9wXQ5xmF9Z5zuJidBz7OkIfuwfazCt9vmUzUHnDHJs=;
 b=YiAqEGmiYa98NUME0LwfEsEtIa+npEhZv6EOPB/MqcEWBm1xyeU9HCreOv6u1rgbctQOQC
 FHPpOMK99LXvvnniw6XfOXSDI872hr3KOY+WRZqAWThX3gwH5UZLa31NGOEMNHsYE3U28z
 I4hPwTTTVy6WGbIv/KyPZMgL196K/N4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-314-46HcTz2AOGCUZ8EhiI6D-A-1; Mon, 12 Apr 2021 09:50:29 -0400
X-MC-Unique: 46HcTz2AOGCUZ8EhiI6D-A-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E30E6107ACE3;
 Mon, 12 Apr 2021 13:50:26 +0000 (UTC)
Received: from localhost (ovpn-115-66.ams2.redhat.com [10.36.115.66])
 by smtp.corp.redhat.com (Postfix) with ESMTP id CB4BC10023AB;
 Mon, 12 Apr 2021 13:50:18 +0000 (UTC)
Date: Mon, 12 Apr 2021 14:50:17 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
To: "jiang.wang" <jiang.wang@bytedance.com>
Subject: Re: [RFC v2] virtio-vsock: add description for datagram type
Message-ID: <YHRQGSSnkN8Zipy0@stefanha-x1.localdomain>
References: <20210401043602.3510538-1-jiang.wang@bytedance.com>
MIME-Version: 1.0
In-Reply-To: <20210401043602.3510538-1-jiang.wang@bytedance.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=stefanha@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: cong.wang@bytedance.com, duanxiongchun@bytedance.com, mst@redhat.com,
 cohuck@redhat.com, virtualization@lists.linux-foundation.org,
 xieyongji@bytedance.com, arseny.krasnov@kaspersky.com, asias@redhat.com
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
Content-Type: multipart/mixed; boundary="===============2104179070940771331=="
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

--===============2104179070940771331==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="P3WjCv5cfDvo6jD/"
Content-Disposition: inline

--P3WjCv5cfDvo6jD/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 01, 2021 at 04:36:02AM +0000, jiang.wang wrote:
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
> V2 addressed the comments for the previous version.
>=20
>  virtio-vsock.tex | 62 +++++++++++++++++++++++++++++++++++++++++++++++---=
------
>  1 file changed, 52 insertions(+), 10 deletions(-)
>=20
> diff --git a/virtio-vsock.tex b/virtio-vsock.tex
> index da7e641..62c12e0 100644
> --- a/virtio-vsock.tex
> +++ b/virtio-vsock.tex
> @@ -11,12 +11,25 @@ \subsection{Virtqueues}\label{sec:Device Types / Sock=
et Device / Virtqueues}
>  \begin{description}
>  \item[0] rx
>  \item[1] tx
> +\item[2] datagram rx
> +\item[3] datagram tx
> +\item[4] event
> +\end{description}
> +The virtio socket device uses 5 queues if feature bit VIRTIO_VSOCK_F_DRG=
AM is set. Otherwise, it
> +only uses 3 queues, as the following. Rx and tx queues are always used f=
or stream sockets.
> +
> +\begin{description}
> +\item[0] rx
> +\item[1] tx
>  \item[2] event
>  \end{description}
> =20

I suggest renaming "rx" and "tx" to "stream rx" and "stream tx"
virtqueues and also adding this:

  When behavior differs between stream and datagram rx/tx virtqueues
  their full names are used. Common behavior is simply described in
  terms of rx/tx virtqueues and applies to both stream and datagram
  virtqueues.

This way you won't need to duplicate portions of the spec that deal with
populating the virtqueues, for example.

It's also clearer to use a full name for stream rx/tx virtqueues instead
of calling them rx/tx virtqueues now that we have datagram rx/tx
virtqueues.

> +
>  \subsection{Feature bits}\label{sec:Device Types / Socket Device / Featu=
re bits}
> =20
> -There are currently no feature bits defined for this device.
> +\begin{description}
> +\item[VIRTIO_VSOCK_F_DGRAM (0)] Device has support for datagram socket t=
ype.
> +\end{description}
> =20
>  \subsection{Device configuration layout}\label{sec:Device Types / Socket=
 Device / Device configuration layout}
> =20
> @@ -107,6 +120,9 @@ \subsection{Device Operation}\label{sec:Device Types =
/ Socket Device / Device Op
> =20
>  \subsubsection{Virtqueue Flow Control}\label{sec:Device Types / Socket D=
evice / Device Operation / Virtqueue Flow Control}
> =20
> +Flow control applies to stream sockets; datagram sockets do not have
> +flow control.
> +
>  The tx virtqueue carries packets initiated by applications and replies t=
o
>  received packets.  The rx virtqueue carries packets initiated by the dev=
ice and
>  replies to previously transmitted packets.
> @@ -140,12 +156,15 @@ \subsubsection{Addressing}\label{sec:Device Types /=
 Socket Device / Device Opera
>  consists of a (cid, port number) tuple. The header fields used for this =
are
>  \field{src_cid}, \field{src_port}, \field{dst_cid}, and \field{dst_port}=
.
> =20
> -Currently only stream sockets are supported. \field{type} is 1 for strea=
m
> -socket types.
> +Currently stream and datagram (dgram) sockets are supported. \field{type=
} is 1 for stream
> +socket types. \field{type} is 3 for dgram socket types.
> =20
>  Stream sockets provide in-order, guaranteed, connection-oriented deliver=
y
>  without message boundaries.
> =20
> +Datagram sockets provide connectionless unreliable messages of
> +a fixed maximum length.

Plus unordered (?) and with message boundaries. In other words:

  Datagram sockets provide unordered, unreliable, connectionless message
  with message boundaries and a fixed maximum length.

I didn't think of the fixed maximum length aspect before. I guess the
intention is that the rx buffer size is the message size limit? That's
different from UDP messages, which can be fragmented into multiple IP
packets and can be larger than 64KiB:
https://en.wikipedia.org/wiki/User_Datagram_Protocol#UDP_datagram_structure

Is it possible to support large datagram messages in vsock? I'm a little
concerned that applications that run successfully over UDP will not be
portable if vsock has this limitation because it would impose extra
message boundaries that the application protocol might not tolerate.

> +
>  \subsubsection{Buffer Space Management}\label{sec:Device Types / Socket =
Device / Device Operation / Buffer Space Management}
>  \field{buf_alloc} and \field{fwd_cnt} are used for buffer space manageme=
nt of
>  stream sockets. The guest and the device publish how much buffer space i=
s
> @@ -162,7 +181,7 @@ \subsubsection{Buffer Space Management}\label{sec:Dev=
ice Types / Socket Device /
>  u32 peer_free =3D peer_buf_alloc - (tx_cnt - peer_fwd_cnt);
>  \end{lstlisting}
> =20
> -If there is insufficient buffer space, the sender waits until virtqueue =
buffers
> +For stream sockets, if there is insufficient buffer space, the sender wa=
its until virtqueue buffers
>  are returned and checks \field{buf_alloc} and \field{fwd_cnt} again. Sen=
ding
>  the VIRTIO_VSOCK_OP_CREDIT_REQUEST packet queries how much buffer space =
is
>  available. The reply to this query is a VIRTIO_VSOCK_OP_CREDIT_UPDATE pa=
cket.
> @@ -170,16 +189,28 @@ \subsubsection{Buffer Space Management}\label{sec:D=
evice Types / Socket Device /
>  previously receiving a VIRTIO_VSOCK_OP_CREDIT_REQUEST packet. This allow=
s
>  communicating updates any time a change in buffer space occurs.
> =20
> +Unlike stream sockets, dgram sockets do not use VIRTIO_VSOCK_OP_CREDIT_U=
PDATE or
> +VIRTIO_VSOCK_OP_CREDIT_REQUEST packets. The dgram buffer management
> +is split to two parts: tx side and rx side. For the tx side, there is
> +additional buffer space for each socket.

Plus:

  ... according to the the driver and device's available memory
  resources. The amount of tx buffer space is an implementation detail
  of both the device and the driver. It is not visible to the other side
  and may be controlled by the application or administrative resource
  limits.

What I'm trying to describe here is that the additional tx buffer space
isn't part of the device interface.

> +The dgram sender sends packets when the virtqueue or the additional buff=
er is not full.
> +When both are full, the sender
> +MUST return an appropriate error to the upper layer application.

MUST, SHOULD, etc clauses need to go into the
devicenormative/drivernormative sections. They cannot be in regular
text.

> +For the rx side, dgram also uses the \field{buf_alloc}. If it is full, t=
he packet
> +is dropped by the receiver.

UDP is connectionless so any number of other sources can send messages
to the same destination, causing buf_alloc's value to be unpredictable.
Can you explain how buf_alloc works with datagram sockets in more
detail?

>  \drivernormative{\paragraph}{Device Operation: Buffer Space Management}{=
Device Types / Socket Device / Device Operation / Buffer Space Management}
> -VIRTIO_VSOCK_OP_RW data packets MUST only be transmitted when the peer h=
as
> -sufficient free buffer space for the payload.
> +For stream sockets, VIRTIO_VSOCK_OP_RW data packets MUST only be transmi=
tted when the peer has
> +sufficient free buffer space for the payload. For dgram sockets, VIRTIO_=
VSOCK_OP_RW data packets
> +MAY be transmitted when the peer buffer is full. Then the packet will be=
 dropped by the receiver.
> =20
>  All packets associated with a stream flow MUST contain valid information=
 in
>  \field{buf_alloc} and \field{fwd_cnt} fields.
> =20
>  \devicenormative{\paragraph}{Device Operation: Buffer Space Management}{=
Device Types / Socket Device / Device Operation / Buffer Space Management}
> -VIRTIO_VSOCK_OP_RW data packets MUST only be transmitted when the peer h=
as
> -sufficient free buffer space for the payload.
> +For stream sockets, VIRTIO_VSOCK_OP_RW data packets MUST only be transmi=
tted when the peer has
> +sufficient free buffer space for the payload. For dgram sockets, VIRTIO_=
VSOCK_OP_RW data packets
> +MAY be transmitted when the peer buffer is full. Then the packet will be=
 dropped by the receiver.
> =20
>  All packets associated with a stream flow MUST contain valid information=
 in
>  \field{buf_alloc} and \field{fwd_cnt} fields.
> @@ -203,14 +234,14 @@ \subsubsection{Receive and Transmit}\label{sec:Devi=
ce Types / Socket Device / De
>  The \field{guest_cid} configuration field MUST be used as the source CID=
 when
>  sending outgoing packets.
> =20
> -A VIRTIO_VSOCK_OP_RST reply MUST be sent if a packet is received with an
> +For stream sockets, A VIRTIO_VSOCK_OP_RST reply MUST be sent if a packet=
 is received with an
>  unknown \field{type} value.

What about datagram sockets? Please state what must happen and why.

> =20
>  \devicenormative{\paragraph}{Device Operation: Receive and Transmit}{Dev=
ice Types / Socket Device / Device Operation / Receive and Transmit}
> =20
>  The \field{guest_cid} configuration field MUST NOT contain a reserved CI=
D as listed in \ref{sec:Device Types / Socket Device / Device configuration=
 layout}.
> =20
> -A VIRTIO_VSOCK_OP_RST reply MUST be sent if a packet is received with an
> +For stream sockets, A VIRTIO_VSOCK_OP_RST reply MUST be sent if a packet=
 is received with an
>  unknown \field{type} value.
> =20
>  \subsubsection{Stream Sockets}\label{sec:Device Types / Socket Device / =
Device Operation / Stream Sockets}
> @@ -240,6 +271,17 @@ \subsubsection{Stream Sockets}\label{sec:Device Type=
s / Socket Device / Device O
>  destination) address tuple for a new connection while the other peer is =
still
>  processing the old connection.
> =20
> +\subsubsection{Datagram Sockets}\label{sec:Device Types / Socket Device =
/ Device Operation / Stream Sockets}

s/Stream Sockets/Datagram Sockets/

> +
> +Datagram (dgram) sockets are connectionless and unreliable. The sender j=
ust sends
> +a message to the peer and hope it will be delivered. A VIRTIO_VSOCK_OP_R=
ST reply is sent if

s/hope/hopes/

> +a receiving socket does not exist on the destination.
> +If the transmission or receiving buffers are full, the packets
> +are dropped. If the transmission buffer is full, an appropriate error me=
ssage
> +is returned to the caller.

It's unclear whether the caller is the driver/device or something else.
I think you're referring to the application interace, which is outside
the scope of the VIRTIO spec. I suggest dropping the last sentence.

--P3WjCv5cfDvo6jD/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmB0UBkACgkQnKSrs4Gr
c8g++wgAyKnuBwoqgTeENQROWMOlYtb7coP9xBL9EUHVo/ji4oXnRu+FC2V38Fj3
YykM+koz2F2AMc0drhgTPK28zTavicXjAlkkgk3nKk2+fCsw5U0aIuQs52OOe9Am
VXcH1rH82VvOoFQPl3erZWHPaVSPw3E8FLqDdvKaNsWMMwsZ67Gs4QesxaFJNpa+
FAfFQkW5SY+rt8XjmvyMJcs0KW383PneDekIGT87hH2TJa3u9gBV2jJlzyNMPsra
cN1NCLB1JR4pgXEMCRmmXNqlL8V3IU7Zjvlx01OXVMKywQ6L8ORlFlpuHF0VpAp/
gqr3tWEKMYjMMz5aSP7ii5BvTBFARQ==
=4HRg
-----END PGP SIGNATURE-----

--P3WjCv5cfDvo6jD/--


--===============2104179070940771331==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--===============2104179070940771331==--

