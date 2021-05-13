Return-Path: <SRS0=J7l7=KI=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61083C433B4
	for <virtualization@archiver.kernel.org>; Thu, 13 May 2021 14:58:12 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 05E3C61433
	for <virtualization@archiver.kernel.org>; Thu, 13 May 2021 14:58:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 05E3C61433
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id B0A00403D1;
	Thu, 13 May 2021 14:58:11 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id VS643vprf7HT; Thu, 13 May 2021 14:58:10 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTP id 3648E40140;
	Thu, 13 May 2021 14:58:10 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 153F6C000D;
	Thu, 13 May 2021 14:58:10 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id AEEC3C0001
 for <virtualization@lists.linux-foundation.org>;
 Thu, 13 May 2021 14:58:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 94ADE84411
 for <virtualization@lists.linux-foundation.org>;
 Thu, 13 May 2021 14:58:08 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id OXK0vObIR_RC
 for <virtualization@lists.linux-foundation.org>;
 Thu, 13 May 2021 14:58:07 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id B59A78450F
 for <virtualization@lists.linux-foundation.org>;
 Thu, 13 May 2021 14:58:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1620917886;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=zn2h4D9E/y/aCwy7omlGL26Cf2itsstM3zoju6R/20k=;
 b=HI0aQg17rh3WGmg5fu8d/2pbikW3ysz2meKffMmQmi+DX9eBFTpno43dWmuzG0LaCbd6y7
 pDjZv7YTpHDXBu2mS4TKFSWwU10tehRb0HmbYu6WczNxyGnmV5VYrhwEcCnlT0hnEq2IFp
 e2WPQBSPDyykTbywz56vPJFjLC3oX5E=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-390-VXgNGerUN7eVRrwtKPGAYQ-1; Thu, 13 May 2021 10:58:02 -0400
X-MC-Unique: VXgNGerUN7eVRrwtKPGAYQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6D1A2801817;
 Thu, 13 May 2021 14:58:01 +0000 (UTC)
Received: from localhost (ovpn-113-21.ams2.redhat.com [10.36.113.21])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 9F516189A5;
 Thu, 13 May 2021 14:57:53 +0000 (UTC)
Date: Thu, 13 May 2021 15:57:52 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
To: "Jiang Wang ." <jiang.wang@bytedance.com>
Subject: Re: [External] Re: [RFC v2] virtio-vsock: add description for
 datagram type
Message-ID: <YJ0+cClrEyamHt+y@stefanha-x1.localdomain>
References: <20210401043602.3510538-1-jiang.wang@bytedance.com>
 <YHRQGSSnkN8Zipy0@stefanha-x1.localdomain>
 <CAP_N_Z-OMqQtnV04Wpynr7GhZooz1iQQ+0To-P8xPEnA0+sZgQ@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAP_N_Z-OMqQtnV04Wpynr7GhZooz1iQQ+0To-P8xPEnA0+sZgQ@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
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
Content-Type: multipart/mixed; boundary="===============9146797435801927759=="
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

--===============9146797435801927759==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="lH0P2SJHEdTH/t2E"
Content-Disposition: inline

--lH0P2SJHEdTH/t2E
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 12, 2021 at 03:39:36PM -0700, Jiang Wang . wrote:
> On Mon, Apr 12, 2021 at 6:50 AM Stefan Hajnoczi <stefanha@redhat.com> wro=
te:
> > On Thu, Apr 01, 2021 at 04:36:02AM +0000, jiang.wang wrote:
> > > +For the rx side, dgram also uses the \field{buf_alloc}. If it is ful=
l, the packet
> > > +is dropped by the receiver.
> >
> > UDP is connectionless so any number of other sources can send messages
> > to the same destination, causing buf_alloc's value to be unpredictable.
> > Can you explain how buf_alloc works with datagram sockets in more
> > detail?
>=20
> In the linux kernel in my prototype, datagram sockets also use
> virtio_transport_inc_rx_pkt() and virtio_transport_dec_rx_pkt() to update
> vvs->rx_bytes and compare it with vvs->buf_alloc. virtio_transport_inc_rx=
_pkt
> is called when enqueuing the datagram packets.
> virtio_transport_dec_rx_pkt is called when dequeuing those packets.
>=20
> If multiple sources send messages to the same destination, they will shar=
e
> the same buf_alloc. Do you want something with more control?
> Maybe somehow allocate a buffer for each remote CID and port? But I
> feel that is a little bit overkill. Any other suggestions?

The opposite, I want less control :). It's not possible to track buffer
space accurately with connectionless sockets, so let's not try.

A real example is the iperf3 networking benchmark where you need to set
target bitrate for UDP sockets because there is no flow control (buffer
space) mechanism in UDP. That's how UDP applications work and for
similar reasons I don't think it's possible to achieve flow control with
vsock's buf_alloc.

> > >  \drivernormative{\paragraph}{Device Operation: Buffer Space Manageme=
nt}{Device Types / Socket Device / Device Operation / Buffer Space Manageme=
nt}
> > > -VIRTIO_VSOCK_OP_RW data packets MUST only be transmitted when the pe=
er has
> > > -sufficient free buffer space for the payload.
> > > +For stream sockets, VIRTIO_VSOCK_OP_RW data packets MUST only be tra=
nsmitted when the peer has
> > > +sufficient free buffer space for the payload. For dgram sockets, VIR=
TIO_VSOCK_OP_RW data packets
> > > +MAY be transmitted when the peer buffer is full. Then the packet wil=
l be dropped by the receiver.
> > >
> > >  All packets associated with a stream flow MUST contain valid informa=
tion in
> > >  \field{buf_alloc} and \field{fwd_cnt} fields.
> > >
> > >  \devicenormative{\paragraph}{Device Operation: Buffer Space Manageme=
nt}{Device Types / Socket Device / Device Operation / Buffer Space Manageme=
nt}
> > > -VIRTIO_VSOCK_OP_RW data packets MUST only be transmitted when the pe=
er has
> > > -sufficient free buffer space for the payload.
> > > +For stream sockets, VIRTIO_VSOCK_OP_RW data packets MUST only be tra=
nsmitted when the peer has
> > > +sufficient free buffer space for the payload. For dgram sockets, VIR=
TIO_VSOCK_OP_RW data packets
> > > +MAY be transmitted when the peer buffer is full. Then the packet wil=
l be dropped by the receiver.
> > >
> > >  All packets associated with a stream flow MUST contain valid informa=
tion in
> > >  \field{buf_alloc} and \field{fwd_cnt} fields.
> > > @@ -203,14 +234,14 @@ \subsubsection{Receive and Transmit}\label{sec:=
Device Types / Socket Device / De
> > >  The \field{guest_cid} configuration field MUST be used as the source=
 CID when
> > >  sending outgoing packets.
> > >
> > > -A VIRTIO_VSOCK_OP_RST reply MUST be sent if a packet is received wit=
h an
> > > +For stream sockets, A VIRTIO_VSOCK_OP_RST reply MUST be sent if a pa=
cket is received with an
> > >  unknown \field{type} value.
> >
> > What about datagram sockets? Please state what must happen and why.
>=20
> I think datagram sockets should do the same thing as the stream to
> return a VIRTIO_VSOCK_OP_RST?
> Any other ideas?

Sounds good to me. I just wanted to check and request that you add that
to the spec.

--lH0P2SJHEdTH/t2E
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEyBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmCdPnAACgkQnKSrs4Gr
c8jH/gf4jTgx9JC/XtWIKW9KkylcwkkirMcieHDD5CLmAw8v/YQ+/AbbAYi2debP
kGSdiTIHV1HCQpaVXgnwr8h0w9/+P+mRormjfcpTmC6e9qcVbEGLJ47RxWirJJsv
+P3neA9wlsYdZ3hTA6BN4eb2PH2/BUbJaB6oe/vWpSMogtv/bpIwjvjfAUlPA/uF
vyyA5dzzHPU3wHsN5GvITgDsDivd/3eF+89Mz6YQ1noBHWyQT/HxaqiZhJZahpJV
0Mb0va24fKJJ+tOKVJtKSk1bO87kQgiTJzxXtTJLn+NTY0PvVNGldUzsRKTO5RHL
1Sg8xnMBLsVZoGNzsDyLOv15FB4v
=4Z57
-----END PGP SIGNATURE-----

--lH0P2SJHEdTH/t2E--


--===============9146797435801927759==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--===============9146797435801927759==--

