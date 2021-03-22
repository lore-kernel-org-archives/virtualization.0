Return-Path: <SRS0=byTZ=IU=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE0CAC433DB
	for <virtualization@archiver.kernel.org>; Mon, 22 Mar 2021 16:51:14 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 42F4061990
	for <virtualization@archiver.kernel.org>; Mon, 22 Mar 2021 16:51:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 42F4061990
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id B43BF60792;
	Mon, 22 Mar 2021 16:51:13 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id jxi5pTOoxTZc; Mon, 22 Mar 2021 16:51:12 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTP id BC1EE605A2;
	Mon, 22 Mar 2021 16:51:11 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 9C956C000A;
	Mon, 22 Mar 2021 16:51:11 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1A5D6C0001
 for <virtualization@lists.linux-foundation.org>;
 Mon, 22 Mar 2021 16:51:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 0382240180
 for <virtualization@lists.linux-foundation.org>;
 Mon, 22 Mar 2021 16:51:10 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id qZJpqPlbfFfH
 for <virtualization@lists.linux-foundation.org>;
 Mon, 22 Mar 2021 16:51:07 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 9759E40166
 for <virtualization@lists.linux-foundation.org>;
 Mon, 22 Mar 2021 16:51:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1616431866;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=WbCjgpX8h5ixU8hwcLryc5jXXRz1k7otXbYzuFXmRkI=;
 b=O7SRPN6xlyaiFzOLNP84H+5ST3TZ5WxxbzAMDaCteENv8fArFVwnUhkCIypLYHWHcnabhB
 xRucp0VlKxYt+8gvp3S0yToeKQ8rqwAcQWhoFNGQZcO3XPTcr8B9Dr00PWiBK9xUtnbay/
 EKrHfwE3zkWlRpfGShi9RIiDWscPW3k=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-139-tjGJiGq-Po-Nr33nPtzO0w-1; Mon, 22 Mar 2021 12:51:03 -0400
X-MC-Unique: tjGJiGq-Po-Nr33nPtzO0w-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CA221100A254;
 Mon, 22 Mar 2021 16:51:01 +0000 (UTC)
Received: from localhost (ovpn-114-89.ams2.redhat.com [10.36.114.89])
 by smtp.corp.redhat.com (Postfix) with ESMTP id E0C8D5B6A8;
 Mon, 22 Mar 2021 16:50:53 +0000 (UTC)
Date: Mon, 22 Mar 2021 16:50:52 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
To: "Jiang Wang ." <jiang.wang@bytedance.com>
Subject: Re: [External] Re: [RFC PATCH] virtio-vsock: add description for
 datagram type
Message-ID: <YFjK7MkmJOFaUvgz@stefanha-x1.localdomain>
References: <20210316215644.2254177-1-jiang.wang@bytedance.com>
 <YFIj+FQQzZmVAqWw@stefanha-x1.localdomain>
 <CAP_N_Z857fnkc4GejHt_t_nxnhXC60=S51i_XQ-AdgXO2NipFA@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAP_N_Z857fnkc4GejHt_t_nxnhXC60=S51i_XQ-AdgXO2NipFA@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=stefanha@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: cong.wang@bytedance.com, Xiongchun Duan <duanxiongchun@bytedance.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, cohuck@redhat.com,
 virtualization@lists.linux-foundation.org, xieyongji@bytedance.com,
 Arseny Krasnov <arseny.krasnov@kaspersky.com>, asias@redhat.com
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
Content-Type: multipart/mixed; boundary="===============1651850442179689792=="
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

--===============1651850442179689792==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="cvi196XnfQN9OVlU"
Content-Disposition: inline

--cvi196XnfQN9OVlU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 18, 2021 at 10:59:20AM -0700, Jiang Wang . wrote:
> On Wed, Mar 17, 2021 at 8:45 AM Stefan Hajnoczi <stefanha@redhat.com> wro=
te:
> >
> > On Tue, Mar 16, 2021 at 09:56:44PM +0000, jiang.wang wrote:
> > > Add supports for datagram type for virtio-vsock. Datagram
> > > sockets are connectionless and unreliable. To avoid contention
> > > with stream and other sockets, add two more virtqueues and
> > > a new feature bit to identify if those two new queues exist or not.
> > >
> > > Also add descriptions for resouce management of datagram, which
> > > does not use the existing credit update mechanism associated with
> > > stream sockets.
> > >
> > > Signed-off-by: Jiang Wang <jiang.wang@bytedance.com>
> > > ---
> > >  virtio-vsock.tex | 72 ++++++++++++++++++++++++++++++++++++++++++++++=
++--------
> > >  1 file changed, 62 insertions(+), 10 deletions(-)
> > >
> > > diff --git a/virtio-vsock.tex b/virtio-vsock.tex
> > > index da7e641..a2ff0a4 100644
> > > --- a/virtio-vsock.tex
> > > +++ b/virtio-vsock.tex
> > > @@ -9,14 +9,27 @@ \subsection{Device ID}\label{sec:Device Types / Soc=
ket Device / Device ID}
> > >
> > >  \subsection{Virtqueues}\label{sec:Device Types / Socket Device / Vir=
tqueues}
> > >  \begin{description}
> > > +\item[0] stream rx
> > > +\item[1] stream tx
> > > +\item[2] dgram rx
> > > +\item[3] dgram tx
> > > +\item[4] event
> > > +\end{description}
> > > +The virtio socket device uses 5 queues if feature bit VIRTIO_VSOCK_D=
RGAM is set. Otherwise, it
> > > +only uses 3 queues, as the following.
> > > +
> > > +\begin{description}
> > >  \item[0] rx
> > >  \item[1] tx
> > >  \item[2] event
> > >  \end{description}
> > >
> > > +
> > >  \subsection{Feature bits}\label{sec:Device Types / Socket Device / F=
eature bits}
> > >
> > > -There are currently no feature bits defined for this device.
> > > +\begin{description}
> > > +\item[VIRTIO_VSOCK_DGRAM (0)] Device has support for datagram socket=
s type.
> > > +\end{description}
> >
> > By convention feature bits are named VIRTIO_<device>_F_<feature>. Pleas=
e
> > add the "_F_".
> >
> Sure.
>=20
> > >
> > >  \subsection{Device configuration layout}\label{sec:Device Types / So=
cket Device / Device configuration layout}
> > >
> > > @@ -76,6 +89,7 @@ \subsection{Device Operation}\label{sec:Device Type=
s / Socket Device / Device Op
> > >       le32 flags;
> > >       le32 buf_alloc;
> > >       le32 fwd_cnt;
> > > +     le64 timestamp;
> >
> > Adding this field breaks old devices and drivers. Please make this fiel=
d
> > conditional on the dgram socket type or the VIRTIO_VSOCK_F_DGRAM featur=
e
> > bit.
> >
> > Also, are all the other fields still used with dgram sockets? Maybe you
> > can use a union instead to reuse some space?
>=20
> I will make this new field depending on the dgram socket type.
>=20
> For the union idea, could I change the order of those fields? Dgram does =
not use
> flags and fwd_cnt fields, and I want to put them together with a union
> of a le64 timestamp.
> Something like:
>=20
> struct virtio_vsock_hdr {
>   le64 src_cid;
>   le64 dst_cid;
>   le32 src_port;
>   le32 dst_port;
>   le32 len;
>   le16 type;
>   le16 op;
>   le32 buf_alloc;
>  union {
>         struct {
>               le32 flags;
>               le32 fwd_cnt;
>         } stream;
>         le64 dgram_timestamp;
>      } internal; // or a better name
> };

Unfortunately reordering the fields would break existing devices and
drivers since they access flags and fwd_cnt at a specific offset in
struct virtio_vsock_hdr.

Thinking more about the union idea, I think it's more trouble than it is
worth. You could just write dgram_timestamp accessor functions that
split/join the le64 value into the existing le32 flags and fwd_cnt
fields.

>=20
> > >  };
> > >  \end{lstlisting}
> > >
> > > @@ -121,11 +135,14 @@ \subsubsection{Virtqueue Flow Control}\label{se=
c:Device Types / Socket Device /
> > >  packets.  With additional resources, it becomes possible to process =
incoming
> > >  packets even when outgoing packets cannot be sent.
> > >
> > > -Eventually even the additional resources will be exhausted and furth=
er
> > > +For stream type, eventually even the additional resources will be ex=
hausted and further
> > >  processing is not possible until the other side processes the virtqu=
eue that
> > >  it has neglected.  This stop to processing prevents one side from ca=
using
> > >  unbounded resource consumption in the other side.
> > >
> > > +For datagram type, the additional resources have a fixed size limit =
to prevent
> > > +unbounded resource consumption.
> > > +
> > >  \drivernormative{\paragraph}{Device Operation: Virtqueue Flow Contro=
l}{Device Types / Socket Device / Device Operation / Virtqueue Flow Control=
}
> > >
> > >  The rx virtqueue MUST be processed even when the tx virtqueue is ful=
l so long as there are additional resources available to hold packets outsi=
de the tx virtqueue.
> > > @@ -140,12 +157,15 @@ \subsubsection{Addressing}\label{sec:Device Typ=
es / Socket Device / Device Opera
> > >  consists of a (cid, port number) tuple. The header fields used for t=
his are
> > >  \field{src_cid}, \field{src_port}, \field{dst_cid}, and \field{dst_p=
ort}.
> > >
> > > -Currently only stream sockets are supported. \field{type} is 1 for s=
tream
> > > -socket types.
> > > +Currently stream and datagram (dgram) sockets are supported. \field{=
type} is 1 for stream
> > > +socket types. \field{type} is 3 for dgram socket types.
> > >
> > >  Stream sockets provide in-order, guaranteed, connection-oriented del=
ivery
> > >  without message boundaries.
> > >
> > > +Datagram socekts provide connectionless unreliable messages of
> >
> > s/socekts/sockets/
> >
> > > +a fixed maximum length.
> > > +
> > >  \subsubsection{Buffer Space Management}\label{sec:Device Types / Soc=
ket Device / Device Operation / Buffer Space Management}
> > >  \field{buf_alloc} and \field{fwd_cnt} are used for buffer space mana=
gement of
> > >  stream sockets. The guest and the device publish how much buffer spa=
ce is
> > > @@ -170,20 +190,41 @@ \subsubsection{Buffer Space Management}\label{s=
ec:Device Types / Socket Device /
> > >  previously receiving a VIRTIO_VSOCK_OP_CREDIT_REQUEST packet. This a=
llows
> > >  communicating updates any time a change in buffer space occurs.
> > >
> > > +For datagram sockets, \field{buf_alloc} is also used on the rx side.=
 Unlike stream
> > > +sockets, dgram sockets do not use VIRTIO_VSOCK_OP_CREDIT_UPDATE or
> > > +VIRTIO_VSOCK_OP_CREDIT_REQUEST packets. The dgram sender does not ch=
eck if
> > > +the \field{buf_alloc} of the peer is full or not. If it is full, the=
 packet
> > > +will be dropped. To limit resouce usage of the sender, \field{dgram_=
tx_bytes}
> >
> > s/resouce/resource/
> >
> > \field{dgram_tx_bytes} is not included in any struct definition?
>=20
> dgram_tx_bytes is a field in struct vhost_vsock and virtio_vsock. But
> I don't see them
> mentioned in the spec.

The VIRTIO specification does not depend on the internals of device
implementations. Someone reading the spec must be able to implement a
driver or a device without knowledge of the Linux virtio_vsock or
vhost_vsock implementations.

If dgram_tx_bytes is a new concept that device implementations must
incorporate, then please describe it fully in the spec.

>=20
> > > +is used for each VM and host. Only payload bytes are counted and hea=
der bytes are not
> >
> > Please use the VIRTIO specification terms "driver" and "device" instead
> > of VM and host.
> Sure.
>=20
> > It's not clear to me what "used" means. What exactly do the driver and
> > device need to do?
>=20
> In the  Linux and KVM case, I added the dgram_tx_bytes to vhost_vsock
> and virtio_vsock.
> Then in virtio_transport_send_pkt() and vhost_transport_send_pkt(),
> the code will increase and check
> dgram_tx_bytes first. If dgram_tx_bytes is no less than
> VIRTIO_VSOCK_MAX_DGRAM_BUF_SIZE,
> the function will free the pkt with virtio_transport_free_pkt() and
> then return. The dgram_tx_bytes
> is decreased in vhost_transport_do_send_pkt, just before each
> virtio_transport_free_pkt() is called.
> It is similar for the device case.
>=20
> The goal is to limit the memory usage for the vsock. Since dgram does
> not use credit, the sender
> can send far more packets than the receiver can handle. If we don't
> add the above check, the
> sender can use lots of memory and cause OOM in the Linux kernel.
>=20
> I am not sure if these details are too much for a spec or not. But I
> think it will be good to
> add some description. Or we can just say that the sender ( device or
> the driver ) must not use
> unlimited resources.

I'm not sure why this mechanism is needed since the virtqueue has a
fixed size and the receiver has socket buffers (rcvbuf) of fixed sizes.
Memory usage is bounded so I don't understand how OOM can occur.

I would have expected the following:
1. When sending, drop VIRTIO_VSOCK_OP_RW packets instead of sending if
   the virtqueue is full.
2. When receiving, drop VIRTIO_VSOCK_OP_RW packets if the socket rcvbuf
   is full.

That's all. No additional accounting mechanism is necessary for
unreliable delivery.

> > > +included. If \field{dgram_tx_bytes} is equal to VIRTIO_VSOCK_MAX_DGR=
AM_BUF_SIZE,
> > > +the send will fail.
> >
> > Does the device reject dgram packets or does the driver refuse to send
> > more dgram packets?
>=20
> The sender will drop the packets. This one is independent of the rx
> side. If the device is the
> sender, device will drop the packets. If the driver is the sender, the
> driver will drop the packets.
>=20
> > > +
> > > +For dgram, since \field{dgram_tx_byte} is shared within a VM or host=
, a tx_timeout and
> > > +a timer are used for each outgoing packet. If a packet is not delive=
red within
> > > +tx_timeout, it will be dropped to make free space for other dgram so=
ckets.
> >
> > What does this mean? Does the timeout cause the device to drop packets
> > that haven't been handled yet (e.g. read by a host userspace process)?
>=20
> This is on the sender side (regardless of the driver or the device ).
> This  is similar to
> above mentioned dgram_tx_bytes. Dgram_tx_bytes only makes sure if the mem=
ory
> usage reaches a limit, the sender will not consume more memory. But
> dgram_tx_bytes
> is shared among different dgram sockets for a device or the driver, a
> misbehave or
> malicious dgram socket can potentially use all memory and block other
> dgram sockets.
> from sending any new packets. To handle this case,
> the tx_timeout is used to free some space from the sender's memory pool, =
so that
> other dgram sockets can continue to send some packets.

Why is the timestamp included in the header? It seems to only be used by
the side that is sending so it's not obvious to me that it needs to be
sent to the other side.

How does timestamp ensure fairness? It seems like the malicious sending
could simple send more packets in order to exhaust all available memory
again when its old packets expire.

>=20
> > POSIX Sockets have a receive socket buffer (rcvbuf) that is used for
> > memory accounting and dropping packets. Operating systems implementing
> > POSIX Sockets would use that to decide when incoming packets are
> > dropped. It seems like dgram_tx_byte does something similar at the
> > device level and I'm not sure why it's necessary?
>=20
> dgram_tx_byte is for the tx (sender) side. The receive buffer you mention=
ed
> is on the receiving side.

POSIX Sockets have a send socket buffer (sndbuf) for that. The sender
should use a similar approach to how UDP sockets work.

> Thanks for all the comments. I will fix those spelling errors and use
> a spell check
> next time. I hope I answered all your questions. Please let me know if I =
missed
> any questions or anything still not clear.

To summarize:

1. Why is dgram_tx_bytes needed since the virtqueue already has a finite
   size?

2. Does the timestamp field provide fairness between senders? I don't
   understand its purpose.

3. vsock dgram should probably follow the UDP approach to memory
   accounting instead of inventing new mechanisms. Applications and
   developers will probably be happiest with UDP-like behavior.

Stefan

--cvi196XnfQN9OVlU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmBYyuwACgkQnKSrs4Gr
c8i9aQf9G+z4VO1RjT/3i05121dlcuSY1P25WTZz391jNhkk9fYjVg/FllO6CblL
82XN7l3gdxFiyeK4c/Clzq24T0OCIxy5wfjVpLqAb1qDbu5a8Duth9x2yoaTYT2O
u7IwMEMVLcqR//VO90NUZah+QCvmRQmd7Gris+7jWP2ftK9JDxOeWpLcT7KNaOVD
iUtwenF8Jt3vZo3+1O9xNHkZJYrEFBO5hD/HcLs1lP19hy3EZu2aiONUfTN6SoAi
uKeg+AfNsvqWjv05sPIYlnXb+xX6KCUy7tEqTiT1SjdMElCgSnqF45qxU/aO1dCa
q31cJ6YvKKVlBR5jhnm3Yc+POs9q2g==
=sVO1
-----END PGP SIGNATURE-----

--cvi196XnfQN9OVlU--


--===============1651850442179689792==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--===============1651850442179689792==--

