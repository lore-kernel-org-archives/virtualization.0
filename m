Return-Path: <SRS0=tvPF=IP=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_RED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22A2CC433E0
	for <virtualization@archiver.kernel.org>; Wed, 17 Mar 2021 15:45:22 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7892A64F8F
	for <virtualization@archiver.kernel.org>; Wed, 17 Mar 2021 15:45:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7892A64F8F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id E97C16F96C;
	Wed, 17 Mar 2021 15:45:20 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id lgageBuKUNhc; Wed, 17 Mar 2021 15:45:19 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTP id 1B7276F95E;
	Wed, 17 Mar 2021 15:45:19 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id EF6ACC000A;
	Wed, 17 Mar 2021 15:45:18 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 29F02C0001
 for <virtualization@lists.linux-foundation.org>;
 Wed, 17 Mar 2021 15:45:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 944486F95E
 for <virtualization@lists.linux-foundation.org>;
 Wed, 17 Mar 2021 15:45:16 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id BSElrfRcTakA
 for <virtualization@lists.linux-foundation.org>;
 Wed, 17 Mar 2021 15:45:14 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [63.128.21.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 66B176F96B
 for <virtualization@lists.linux-foundation.org>;
 Wed, 17 Mar 2021 15:45:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1615995913;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=VdOFTxVJnygUPUUZTjKifRDJ0BC1KHudH9acnY0VlDM=;
 b=LpAL5LSf1PFtfDgZl4rwX/rVaVxPTS+eh8xJfthHRWLf+lGxPou3ONJFeoLBHVguyAtb88
 b0wh66pBUpU5RkKIAIIngdG0wrmKY/3VhizamnnlAaRHFrZ2ZysZoGsCqBFa8TB5tbEjAe
 DLhQjTLsGJRHC7Ga/Hg1PUlbn0nlsTA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-602-blwFbexJOFSiDJQ2UUHPBw-1; Wed, 17 Mar 2021 11:45:07 -0400
X-MC-Unique: blwFbexJOFSiDJQ2UUHPBw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 78D8683DD23;
 Wed, 17 Mar 2021 15:45:06 +0000 (UTC)
Received: from localhost (ovpn-114-113.ams2.redhat.com [10.36.114.113])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 369BC1007625;
 Wed, 17 Mar 2021 15:44:57 +0000 (UTC)
Date: Wed, 17 Mar 2021 15:44:56 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
To: "jiang.wang" <jiang.wang@bytedance.com>
Subject: Re: [RFC PATCH] virtio-vsock: add description for datagram type
Message-ID: <YFIj+FQQzZmVAqWw@stefanha-x1.localdomain>
References: <20210316215644.2254177-1-jiang.wang@bytedance.com>
MIME-Version: 1.0
In-Reply-To: <20210316215644.2254177-1-jiang.wang@bytedance.com>
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
Content-Type: multipart/mixed; boundary="===============2706143918405909884=="
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

--===============2706143918405909884==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="GhmToHBpwFIx7MJw"
Content-Disposition: inline

--GhmToHBpwFIx7MJw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 16, 2021 at 09:56:44PM +0000, jiang.wang wrote:
> Add supports for datagram type for virtio-vsock. Datagram
> sockets are connectionless and unreliable. To avoid contention
> with stream and other sockets, add two more virtqueues and
> a new feature bit to identify if those two new queues exist or not.
>=20
> Also add descriptions for resouce management of datagram, which
> does not use the existing credit update mechanism associated with
> stream sockets.
>=20
> Signed-off-by: Jiang Wang <jiang.wang@bytedance.com>
> ---
>  virtio-vsock.tex | 72 ++++++++++++++++++++++++++++++++++++++++++++++++--=
------
>  1 file changed, 62 insertions(+), 10 deletions(-)
>=20
> diff --git a/virtio-vsock.tex b/virtio-vsock.tex
> index da7e641..a2ff0a4 100644
> --- a/virtio-vsock.tex
> +++ b/virtio-vsock.tex
> @@ -9,14 +9,27 @@ \subsection{Device ID}\label{sec:Device Types / Socket =
Device / Device ID}
> =20
>  \subsection{Virtqueues}\label{sec:Device Types / Socket Device / Virtque=
ues}
>  \begin{description}
> +\item[0] stream rx
> +\item[1] stream tx
> +\item[2] dgram rx
> +\item[3] dgram tx
> +\item[4] event
> +\end{description}
> +The virtio socket device uses 5 queues if feature bit VIRTIO_VSOCK_DRGAM=
 is set. Otherwise, it
> +only uses 3 queues, as the following.
> +
> +\begin{description}
>  \item[0] rx
>  \item[1] tx
>  \item[2] event
>  \end{description}
> =20
> +
>  \subsection{Feature bits}\label{sec:Device Types / Socket Device / Featu=
re bits}
> =20
> -There are currently no feature bits defined for this device.
> +\begin{description}
> +\item[VIRTIO_VSOCK_DGRAM (0)] Device has support for datagram sockets ty=
pe.
> +\end{description}

By convention feature bits are named VIRTIO_<device>_F_<feature>. Please
add the "_F_".

> =20
>  \subsection{Device configuration layout}\label{sec:Device Types / Socket=
 Device / Device configuration layout}
> =20
> @@ -76,6 +89,7 @@ \subsection{Device Operation}\label{sec:Device Types / =
Socket Device / Device Op
>  =09le32 flags;
>  =09le32 buf_alloc;
>  =09le32 fwd_cnt;
> +=09le64 timestamp;

Adding this field breaks old devices and drivers. Please make this field
conditional on the dgram socket type or the VIRTIO_VSOCK_F_DGRAM feature
bit.

Also, are all the other fields still used with dgram sockets? Maybe you
can use a union instead to reuse some space?

>  };
>  \end{lstlisting}
> =20
> @@ -121,11 +135,14 @@ \subsubsection{Virtqueue Flow Control}\label{sec:De=
vice Types / Socket Device /
>  packets.  With additional resources, it becomes possible to process inco=
ming
>  packets even when outgoing packets cannot be sent.
> =20
> -Eventually even the additional resources will be exhausted and further
> +For stream type, eventually even the additional resources will be exhaus=
ted and further
>  processing is not possible until the other side processes the virtqueue =
that
>  it has neglected.  This stop to processing prevents one side from causin=
g
>  unbounded resource consumption in the other side.
> =20
> +For datagram type, the additional resources have a fixed size limit to p=
revent
> +unbounded resource consumption.
> +
>  \drivernormative{\paragraph}{Device Operation: Virtqueue Flow Control}{D=
evice Types / Socket Device / Device Operation / Virtqueue Flow Control}
> =20
>  The rx virtqueue MUST be processed even when the tx virtqueue is full so=
 long as there are additional resources available to hold packets outside t=
he tx virtqueue.
> @@ -140,12 +157,15 @@ \subsubsection{Addressing}\label{sec:Device Types /=
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
> +Datagram socekts provide connectionless unreliable messages of

s/socekts/sockets/

> +a fixed maximum length.
> +
>  \subsubsection{Buffer Space Management}\label{sec:Device Types / Socket =
Device / Device Operation / Buffer Space Management}
>  \field{buf_alloc} and \field{fwd_cnt} are used for buffer space manageme=
nt of
>  stream sockets. The guest and the device publish how much buffer space i=
s
> @@ -170,20 +190,41 @@ \subsubsection{Buffer Space Management}\label{sec:D=
evice Types / Socket Device /
>  previously receiving a VIRTIO_VSOCK_OP_CREDIT_REQUEST packet. This allow=
s
>  communicating updates any time a change in buffer space occurs.
> =20
> +For datagram sockets, \field{buf_alloc} is also used on the rx side. Unl=
ike stream=20
> +sockets, dgram sockets do not use VIRTIO_VSOCK_OP_CREDIT_UPDATE or=20
> +VIRTIO_VSOCK_OP_CREDIT_REQUEST packets. The dgram sender does not check =
if
> +the \field{buf_alloc} of the peer is full or not. If it is full, the pac=
ket
> +will be dropped. To limit resouce usage of the sender, \field{dgram_tx_b=
ytes}

s/resouce/resource/

\field{dgram_tx_bytes} is not included in any struct definition?

> +is used for each VM and host. Only payload bytes are counted and header =
bytes are not

Please use the VIRTIO specification terms "driver" and "device" instead
of VM and host.

It's not clear to me what "used" means. What exactly do the driver and
device need to do?

> +included. If \field{dgram_tx_bytes} is equal to VIRTIO_VSOCK_MAX_DGRAM_B=
UF_SIZE,
> +the send will fail.

Does the device reject dgram packets or does the driver refuse to send
more dgram packets?

> +
> +For dgram, since \field{dgram_tx_byte} is shared within a VM or host, a =
tx_timeout and
> +a timer are used for each outgoing packet. If a packet is not delivered =
within
> +tx_timeout, it will be dropped to make free space for other dgram socket=
s.

What does this mean? Does the timeout cause the device to drop packets
that haven't been handled yet (e.g. read by a host userspace process)?

POSIX Sockets have a receive socket buffer (rcvbuf) that is used for
memory accounting and dropping packets. Operating systems implementing
POSIX Sockets would use that to decide when incoming packets are
dropped. It seems like dgram_tx_byte does something similar at the
device level and I'm not sure why it's necessary?

In the POSIX Sockets model the virtio-vsock tx virtqueue is processed by
the device and packets are read into socket rcvbuf. They do not stay in
the virtqueue. This involves an extra data copy but it keeps the
virtqueue as empty as possible so that further communication is
possible.

> +
>  \drivernormative{\paragraph}{Device Operation: Buffer Space Management}{=
Device Types / Socket Device / Device Operation / Buffer Space Management}
> -VIRTIO_VSOCK_OP_RW data packets MUST only be transmitted when the peer h=
as
> -sufficient free buffer space for the payload.
> +For stream sockets, VIRTIO_VSOCK_OP_RW data packets MUST only be transmi=
tted when the peer has
> +sufficient free buffer space for the payload. For dgram sockets, VIRTIO_=
VSOCK_OP_RW data packets
> +can be transmitted when the peer buffer is full. Then the pacekt will be=
 dropped.

s/can/MAY/

s/pacekt/packet/

"Then the packet will be dropped" is not clear to me. Is it saying the
device drops packets when buffer space has exceeded?

> =20
>  All packets associated with a stream flow MUST contain valid information=
 in
>  \field{buf_alloc} and \field{fwd_cnt} fields.
> =20
> +All packets associated with a dgram flow MUST contain valid information =
in
> +\field{timestamp} field, which will be used to check for tx timeout.

What are the units of the timestamp field?

> +
>  \devicenormative{\paragraph}{Device Operation: Buffer Space Management}{=
Device Types / Socket Device / Device Operation / Buffer Space Management}
> -VIRTIO_VSOCK_OP_RW data packets MUST only be transmitted when the peer h=
as
> -sufficient free buffer space for the payload.
> +For stream sockets, VIRTIO_VSOCK_OP_RW data packets MUST only be transmi=
tted when the peer has
> +sufficient free buffer space for the payload. For dgram sockets, VIRTIO_=
VSOCK_OP_RW data packets
> +can be transmitted when the peer buffer is full. Then the pacekt will be=
 dropped.
> =20
>  All packets associated with a stream flow MUST contain valid information=
 in
>  \field{buf_alloc} and \field{fwd_cnt} fields.
> =20
> +All packets associated with a dgram flow MUST contain valid information =
in
> +\field{timestamp} field.
> +
>  \subsubsection{Receive and Transmit}\label{sec:Device Types / Socket Dev=
ice / Device Operation / Receive and Transmit}
>  The driver queues outgoing packets on the tx virtqueue and incoming pack=
et
>  receive buffers on the rx virtqueue. Packets are of the following form:
> @@ -203,14 +244,14 @@ \subsubsection{Receive and Transmit}\label{sec:Devi=
ce Types / Socket Device / De
>  The \field{guest_cid} configuration field MUST be used as the source CID=
 when
>  sending outgoing packets.
> =20
> -A VIRTIO_VSOCK_OP_RST reply MUST be sent if a packet is received with an
> +For stream socekts, A VIRTIO_VSOCK_OP_RST reply MUST be sent if a packet=
 is received with an
>  unknown \field{type} value.
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
> @@ -240,6 +281,17 @@ \subsubsection{Stream Sockets}\label{sec:Device Type=
s / Socket Device / Device O
>  destination) address tuple for a new connection while the other peer is =
still
>  processing the old connection.
> =20
> +\subsubsection{Datagram Sockets}\label{sec:Device Types / Socket Device =
/ Device Operation / Stream Sockets}
> +
> +Datagram (dgram) sockets are connectionless and unreliable. The sender j=
ust send=20
> +a message to the peer and hope it will be delivered. If there is no sock=
et binds the=20
> +address on the other end, or the transmision or receving buffers are ful=
l, the packets=20
> +will be droped. Each packet may have a source cid and=20

s/dropped/

Please stick to UDP semantics as much as possible so that applications
can be ported easily and developers aren't surprised by unexpected
behavior. UDP packets sent to a destination that has no listen socket
result in a Connection Refused error. vsock dgrams should behave in the
same way.

> +source port, the receiver can use them to send back a reply message.

The VIRTIO specification avoids using the word "may" (as well as "must"
and "should") outside the normative sections of the specification.

It's unclear what this sentence means: can the driver set the source cid
and source port to zero or an arbitary number if it does not need a
reply? (I guess the answer is "no" but the sentence implies setting the
source cid and source port is optional.)

> +
> +Dgram sockets preserve the message boundaries. A message is either sent =
or dropped.

What does "a message is either sent or dropped" mean? Does it mean
messages are delivered once or not at all, but they are never
duplicated?

--GhmToHBpwFIx7MJw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmBSI/gACgkQnKSrs4Gr
c8gILwgAwonDMZhz2Cw+HqeGl2GSNfDaMRZBnRX1FklChSyICxxxwVzkUDb7ukKG
tmTnzgP+agUmQmFBSgqtBHyeX0+4xbImZ4Yd1KDMzxi6209ByOI9IPy6gc9rrN0M
UqMRZGuIET0J1ZMulwfDz2TDr146Z+z/OYr8IBiAtyHa5RGeksqImofx+mFCBr2d
YNflwX9215Mpq8EXe+xUKdZ2TylmB0syNS4GTyNlgdhnCb8e1yW1+xDnMFhmFLPz
BnvTnaMeEukIaKtLMSCetfguxux1XJ+3SbAm2MJgKZal7pEhza44XTAAsbLx+10Y
rH+GTlvWMVcP8DC7qgi+nII3qSx8jQ==
=xjVL
-----END PGP SIGNATURE-----

--GhmToHBpwFIx7MJw--


--===============2706143918405909884==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--===============2706143918405909884==--

