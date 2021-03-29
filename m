Return-Path: <SRS0=wWNv=I3=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E58DC433E1
	for <virtualization@archiver.kernel.org>; Mon, 29 Mar 2021 16:12:47 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BD26661582
	for <virtualization@archiver.kernel.org>; Mon, 29 Mar 2021 16:12:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BD26661582
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 6123C606D5;
	Mon, 29 Mar 2021 16:12:46 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id MstfBpT2b2CX; Mon, 29 Mar 2021 16:12:45 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTP id B292B606F5;
	Mon, 29 Mar 2021 16:12:44 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 82410C000C;
	Mon, 29 Mar 2021 16:12:44 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4423BC000A
 for <virtualization@lists.linux-foundation.org>;
 Mon, 29 Mar 2021 16:12:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 1C5E083842
 for <virtualization@lists.linux-foundation.org>;
 Mon, 29 Mar 2021 16:12:43 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id oWliILM6o23C
 for <virtualization@lists.linux-foundation.org>;
 Mon, 29 Mar 2021 16:12:40 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 2ADA8835A7
 for <virtualization@lists.linux-foundation.org>;
 Mon, 29 Mar 2021 16:12:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1617034359;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=66bMU6rydU5kY8mhADHd9QIbx2qwvBtjR77Sh3S9VO0=;
 b=da/uksujAz0FgZxdDrwdMllC3QIonjloV5LmgCALB1FfR1XsnAMg6u8apNdkuZjGt5fsvD
 Ugbp9JAGGevRPdOg18PvI6is3QOD7xRhpZRkq17PAaNfG7MP04Y5R1xPXIYu8wTCAZ8tyN
 zdna7Jp9VI7O1MoEfblVrZsG1CT7BI0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-184-FH7NhItlO_mqMr4zOej4Iw-1; Mon, 29 Mar 2021 12:11:21 -0400
X-MC-Unique: FH7NhItlO_mqMr4zOej4Iw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D28851005D5E;
 Mon, 29 Mar 2021 16:11:19 +0000 (UTC)
Received: from localhost (ovpn-114-227.ams2.redhat.com [10.36.114.227])
 by smtp.corp.redhat.com (Postfix) with ESMTP id E48C45D9F0;
 Mon, 29 Mar 2021 16:11:15 +0000 (UTC)
Date: Mon, 29 Mar 2021 17:11:14 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Arseny Krasnov <arseny.krasnov@kaspersky.com>
Subject: Re: [virtio-comment] [RFC PATCH v4 2/2] virtio-vsock: SOCK_SEQPACKET
 description
Message-ID: <YGH8IqLRdh5JCZyT@stefanha-x1.localdomain>
References: <20210326090154.1144100-1-arseny.krasnov@kaspersky.com>
 <20210326090254.1144486-1-arseny.krasnov@kaspersky.com>
MIME-Version: 1.0
In-Reply-To: <20210326090254.1144486-1-arseny.krasnov@kaspersky.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=stefanha@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: Andra Paraschiv <andraprs@amazon.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, cohuck@redhat.com,
 Colin Ian King <colin.king@canonical.com>,
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
Content-Type: multipart/mixed; boundary="===============8017403542918806455=="
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

--===============8017403542918806455==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="xeRT9Ca9nRFlG2L/"
Content-Disposition: inline

--xeRT9Ca9nRFlG2L/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 26, 2021 at 12:02:50PM +0300, Arseny Krasnov wrote:
> This adds description of SOCK_SEQPACKET socket type
> support for virtio-vsock.
>=20
> Signed-off-by: Arseny Krasnov <arseny.krasnov@kaspersky.com>
> ---
>  virtio-vsock.tex | 65 +++++++++++++++++++++++++++++++++++++++++++-----
>  1 file changed, 59 insertions(+), 6 deletions(-)
>=20
> diff --git a/virtio-vsock.tex b/virtio-vsock.tex
> index ad57f9d..c366de7 100644
> --- a/virtio-vsock.tex
> +++ b/virtio-vsock.tex
> @@ -17,6 +17,10 @@ \subsection{Virtqueues}\label{sec:Device Types / Socke=
t Device / Virtqueues}
>  \subsection{Feature bits}\label{sec:Device Types / Socket Device / Featu=
re bits}
> =20
>  There are currently no feature bits defined for this device.

^ This line is now out of date :)

> +\begin{description}
> +\item VIRTIO_VSOCK_F_SEQPACKET (0) SOCK_SEQPACKET socket type is
> +    supported.
> +\end{description}
> =20
>  \subsection{Device configuration layout}\label{sec:Device Types / Socket=
 Device / Device configuration layout}
> =20
> @@ -98,6 +102,10 @@ \subsection{Device Operation}\label{sec:Device Types =
/ Socket Device / Device Op
>  #define VIRTIO_VSOCK_OP_CREDIT_UPDATE  6
>  /* Request the peer to send the credit info to us */
>  #define VIRTIO_VSOCK_OP_CREDIT_REQUEST 7
> +/* Message begin for SOCK_SEQPACKET */
> +#define VIRTIO_VSOCK_OP_SEQ_BEGIN      8
> +/* Message end for SOCK_SEQPACKET */
> +#define VIRTIO_VSOCK_OP_SEQ_END        9

The struct virtio_vsock_hdr->flags field is le32 and currently unused.
Could 24 bits be used for a unique message id and 8 bits for flags? 1
flag bit could be used for end-of-message and the remaining 7 bits could
be reserved. That way SEQ_BEGIN and SEQ_END are not necessary. Pressure
on the virtqueue would be reduced and performance should be comparable
to SOCK_STREAM.

>  \end{lstlisting}
> =20
>  \subsubsection{Virtqueue Flow Control}\label{sec:Device Types / Socket D=
evice / Device Operation / Virtqueue Flow Control}
> @@ -135,15 +143,16 @@ \subsubsection{Addressing}\label{sec:Device Types /=
 Socket Device / Device Opera
>  consists of a (cid, port number) tuple. The header fields used for this =
are
>  \field{src_cid}, \field{src_port}, \field{dst_cid}, and \field{dst_port}=
.
> =20
> -Currently only stream sockets are supported. \field{type} is 1 (VIRTIO_V=
SOCK_TYPE_STREAM)
> -for stream socket types.
> +Currently stream and seqpacket sockets are supported. \field{type} is 1 =
(VIRTIO_VSOCK_TYPE_STREAM)
> +for stream socket types, and 2 (VIRTIO_VSOCK_TYPE_SEQPACKET) for seqpack=
et socket types.
> =20
>  \begin{lstlisting}
> -#define VIRTIO_VSOCK_TYPE_STREAM 1
> +#define VIRTIO_VSOCK_TYPE_STREAM    1
> +#define VIRTIO_VSOCK_TYPE_SEQPACKET 2
>  \end{lstlisting}
> =20
>  Stream sockets provide in-order, guaranteed, connection-oriented deliver=
y
> -without message boundaries.
> +without message boundaries. Seqpacket sockets also provide message bound=
aries.

"also" is ambiguous, I guess it means "is the same except ..." here. I
suggest writing out the characteristics of seqpacket sockets in full:

  Seqpacket sockets provide in-order, guaranteed, connection-oriented
  delivery with message boundaries.

If "also" is intended to mean that message boundaries are optional, then
my understanding is that they are mandatory, not optional. Seqpacket
sockets deliver entire messages and therefore communication is
impossible without message boundaries.

> =20
>  \subsubsection{Buffer Space Management}\label{sec:Device Types / Socket =
Device / Device Operation / Buffer Space Management}
>  \field{buf_alloc} and \field{fwd_cnt} are used for buffer space manageme=
nt of
> @@ -170,8 +179,10 @@ \subsubsection{Buffer Space Management}\label{sec:De=
vice Types / Socket Device /
>  communicating updates any time a change in buffer space occurs.
> =20
>  \drivernormative{\paragraph}{Device Operation: Buffer Space Management}{=
Device Types / Socket Device / Device Operation / Buffer Space Management}
> -VIRTIO_VSOCK_OP_RW data packets MUST only be transmitted when the peer h=
as
> -sufficient free buffer space for the payload.
> +VIRTIO_VSOCK_OP_RW data packets as well as VIRTIO_VSOCK_OP_SEQ_BEGIN and
> +VIRTIO_VSOCK_OP_SEQ_END message boundary packets MUST only be
> +transmitted when the peer has sufficient free buffer space for the
> +payload.
> =20
>  All packets associated with a stream flow MUST contain valid information=
 in
>  \field{buf_alloc} and \field{fwd_cnt} fields.
> @@ -244,6 +255,48 @@ \subsubsection{Stream Sockets}\label{sec:Device Type=
s / Socket Device / Device O
>  destination) address tuple for a new connection while the other peer is =
still
>  processing the old connection.
> =20
> +\subsubsection{Seqpacket Sockets}\label{sec:Device Types / Socket Device=
 / Device Operation / Seqpacket Sockets}
> +
> +\paragraph{Message boundaries}\label{sec:Device Types / Socket Device / =
Device Operation / Seqpacket Sockets / Message boundaries}
> +
> +Seqpacket sockets differ from stream sockets only in data transmission w=
ay: in

s/in data transmission way/in how data is transmitted/

> +stream sockets all data is sent using only VIRTIO_VSOCK_OP_RW packets. I=
n
> +seqpacket sockets, to provide message boundaries, every sequence of
> +VIRTIO_VSOCK_OP_RW packets of each message MUST be headed with
> +VIRTIO_VSOCK_OP_SEQ_BEGIN and tailed with VIRTIO_VSOCK_OP_SEQ_END packet=
s.
> +Both VIRTIO_VSOCK_OP_SEQ_BEGIN and VIRTIO_VSOCK_OP_SEQ_END packets MUST =
carry

s/MUST//

MUST/MAY/CAN/SHOULD/etc are only used in normative sections of the spec.

> +special structure in payload:

s/carry special structure in payload/carry the following payload/

> +
> +\begin{lstlisting}
> +struct virtio_vsock_seq_hdr {
> +=09__le32  msg_id;
> +=09__le32  msg_len;
> +};
> +\end{lstlisting}
> +
> +This data MUST be placed starting from the first byte of payload and no =
more

s/MUST be/is/

s/starting from/starting at/

> +data is allowed to be beyond it. Also payload of such packet MUST be tra=
nsmitted

s/to be//

s/MUST be/is/

Which "payload" is this sentence referring to? The previous sentence
referred to the payload of
VIRTIO_VSOCK_OP_SEQ_BEGIN/VIRTIO_VSOCK_OP_SEQ_END packets, but here I'm
not sure if the text is referring to VIRTIO_VSOCK_OP_RW packets.

> +without fragmentation. \field{len} of packet header MUST be set to the s=
ize of

The word "fragmentation" is not used in the Socket device section and
it's not clear to me what it means. It seems like SEQ_BEGIN is followed
by one or more RW packets and then SEQ_END. But does splitting a message
across multiple RW packets count as "fragmentation"?

s/\field{len} of packet header/The packet header \field{len} field/

s/MUST be/is/

> +the struct virtio_vsock_seq_hdr.
> +
> +\field{msg_id} is value to identify message. It MUST be same for pair of

s/is value to identify message/is a unique valid to identify a message/

s/MUST be/is the/

s/for pair/for a pair/

> +VIRTIO_VSOCK_OP_SEQ_BEGIN and VIRTIO_VSOCK_OP_SEQ_END of one message, an=
d MUST

s/of one message/packets related to one message/

> +differ in next messages. \field{msg_len} contains message length. This h=
eader

"MUST differ in next messages" can be removed here. If we describe
msg_id as "unique" above the the intent is clear and sentence can be
added to the driver normative section indicating that all msg_id values
in use at a given time MUST be unique.

s/contains message length/contains the message length/

> +is used to check integrity of each message: message is valid if length o=
f data

s/check integrity/check the integrity/

s/if length/if the total length/

(I suggest adding "total" to make it clear that the lengths of all RW
packets is summed. This rules out the interpretation that each RW
packet's length must be msg_len.)

> +in VIRTIO_VSOCK_OP_RW packets is equal to \field{msg_len} of prepending

s/in VIRTIO_VSOCK_OP_RW packets/in the VIRTIO_VSOCK_OP_RW packets/

s/prepending/the corresponding/

> +VIRTIO_VSOCK_OP_SEQ_BEGIN and \field{msg_id} of VIRTIO_VSOCK_OP_SEQ_END =
is equal
> +to \field{msg_id} of VIRTIO_VSOCK_OP_SEQ_BEGIN.
> +
> +\paragraph{POSIX MSG_EOR flag}\label{sec:Device Types / Socket Device / =
Device Operation / Seqpacket Sockets / MSG_EOR flag}
> +
> +When message is sent using one of POSIX functions: send(), sendto() or s=
endmsg() and
> +MSG_EOR flag is set in \field{flags} parameter of these functions, then =
all VIRTIO_VSOCK_OP_RW
> +packets of this message MUST have \field{flags} field in header set to s=
pecial constanst:
> +
> +\begin{lstlisting}
> +#define VIRTIO_VSOCK_RW_EOR 1
> +\end{lstlisting}

I'm not familiar with MSG_EOR. It seems to be a hint to send buffered
data with Linux TCP sockets and it's not implemented for Linux AF_UNIX
sockets.

How is MSG_EOR useful if SEQ_END already deliminates message boundaries?

It seems like passing the MSG_EOR flag in this way provides an
additional layer on top of message boundaries? It's not clear to me that
MSG_EOR has to work like that according to POSIX. Do you have a link to
the POSIX spec pages that describe how MSG_EOR works?

--xeRT9Ca9nRFlG2L/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmBh/CIACgkQnKSrs4Gr
c8gcdQgAkbhF3uRjnxvBoF+hPrnutBm/yM4p01Xbe2+szxYOfPd5PijfVhbg8TmH
Qx7Fq1axQm7DLryuwYzSQpFdqf8s94+tXstn8gApvdJ31oX1knph2KHL5awArvzN
qut6ZUWVAyTgtcSLONDZKY8TK/daqNP5Yfr28oENKbgCSrezWNILwSQ0FrpK4OKJ
1FLPOcc2m6n8Am275MnWplQN2TGb5+dQt3gBFFXdvwlg1TUtwU8DFg2LLGqkABiL
8xDAoR5F9nEE1RMS5+NtNk+mjtFeJyongzAWBF+LUvSOOIWiE3763oX9go/wFHHA
a+MyRxdiQgSSxvoit1jELBfCztCgHw==
=9gv0
-----END PGP SIGNATURE-----

--xeRT9Ca9nRFlG2L/--


--===============8017403542918806455==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--===============8017403542918806455==--

