Return-Path: <SRS0=J7vq=KX=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_RED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB3B4C4707F
	for <virtualization@archiver.kernel.org>; Fri, 28 May 2021 02:55:23 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 48880610FA
	for <virtualization@archiver.kernel.org>; Fri, 28 May 2021 02:55:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 48880610FA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=bytedance.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 6587A4055F;
	Fri, 28 May 2021 02:55:22 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id jKNmc7omaDwm; Fri, 28 May 2021 02:55:19 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTP id 6EB89401E2;
	Fri, 28 May 2021 02:55:18 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 374FAC000E;
	Fri, 28 May 2021 02:55:18 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3C107C0001
 for <virtualization@lists.linux-foundation.org>;
 Fri, 28 May 2021 02:55:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 30C1860DB6
 for <virtualization@lists.linux-foundation.org>;
 Fri, 28 May 2021 02:55:16 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=bytedance-com.20150623.gappssmtp.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id F1H3hAub7xtd
 for <virtualization@lists.linux-foundation.org>;
 Fri, 28 May 2021 02:55:14 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com
 [IPv6:2607:f8b0:4864:20::32c])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 1543760DB3
 for <virtualization@lists.linux-foundation.org>;
 Fri, 28 May 2021 02:55:13 +0000 (UTC)
Received: by mail-ot1-x32c.google.com with SMTP id
 i14-20020a9d624e0000b029033683c71999so2214661otk.5
 for <virtualization@lists.linux-foundation.org>;
 Thu, 27 May 2021 19:55:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance-com.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=dBlbQCUudh/ENY3pLUV3KI4XR20aSRJFQtH2DtpB/ng=;
 b=KTIDyx9LxIsu2OX1PzSM1/D6KBdEBpb+rVdKz22HB5Z6n+QsasMoaH0z40eCifw8YY
 dhVAfWEqyo2FxrHhkTTM1+ATH7QqYuPBJttvJYZK49vP3x0osYqS3CU2nMmyjZlorwEz
 IjP6qHMLkBEuccBC77pkJN2aKsD+SUZzNV+13ySHNLlP4SQKG0RByU4tEd8ANA2ujCAN
 DPHJp/syDMNy2W/e0OqsKMdnB2JiAaoXe39Q+LTBhM4JY7rb5vUaJGvC3fiPUgmtwFBt
 SaFdCxxeTMBg4xQLL32NLzwt+OJ5MtYMcrqiuz+7N3pH+ByXJr6U3esFVCI9BnXbB6f1
 6LCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=dBlbQCUudh/ENY3pLUV3KI4XR20aSRJFQtH2DtpB/ng=;
 b=olAJfffvBr1cJdi6m4oialkS/qxhIP56i5dMVZlF+IeGHa1rhnN3sEKF09Gq7kgVTR
 eZisvuOA7fHMQ2hb7S/RWE7M5/B8pHYXwcBmBI3Nl/OXO95Jw9TbOxHIj55Uju1S2M1t
 O2QuOgBM0WKvWvz7+m3Md5wDKi8FVXijRjbQN9Jwvtp59W20U4/Gbhx4bXFZWpeHA1aS
 SVtfr9mI9IFDHIrDssYvENSbYyjrX4VdpVZBWVImeo0QOweaOPIVWyk+pGOVi86NwKJN
 okqs2FHIZpR29XB+Oc0rCinQiZrvlIthteWWDm2tdbSXwvSqpif/TkS/Jn8yqp6wlXHr
 v1Tw==
X-Gm-Message-State: AOAM530oHpQQ2BjD+BdCCs0J8WeEtxifW5elP7qHbt48mGLWR5Ry6hgL
 VPeluc8Mqw9GeBLDOQCOigHtDekV4TVNZ3GQpAB9ow==
X-Google-Smtp-Source: ABdhPJxX8FYERs9u0opj2op6AHd5RCWqAIYG3+EIyqvWIGtyME/Jtf8QCOdcIzAsW/ZdubJJc6+DOaZrhWFi29Ag9YM=
X-Received: by 2002:a9d:62d0:: with SMTP id z16mr5185182otk.180.1622170512781; 
 Thu, 27 May 2021 19:55:12 -0700 (PDT)
MIME-Version: 1.0
References: <20210526175035.1873294-1-jiang.wang@bytedance.com>
 <20210527132106.ovwbecznb6knrhig@steredhat>
In-Reply-To: <20210527132106.ovwbecznb6knrhig@steredhat>
From: "Jiang Wang ." <jiang.wang@bytedance.com>
Date: Thu, 27 May 2021 19:55:02 -0700
Message-ID: <CAP_N_Z9PoddimmUEL7=+_i+rAEyYYobn2s4YbZDrdOq3+5bW5w@mail.gmail.com>
Subject: Re: Re: [virtio-comment] [RFC v3] virtio-vsock: add description for
 datagram type
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: cong.wang@bytedance.com, Xiongchun Duan <duanxiongchun@bytedance.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, cohuck@redhat.com,
 virtualization@lists.linux-foundation.org,
 Yongji Xie <xieyongji@bytedance.com>,
 =?UTF-8?B?5p+056iz?= <chaiwen.cc@bytedance.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, virtio-comment@lists.oasis-open.org,
 asias@redhat.com, Arseny Krasnov <arseny.krasnov@kaspersky.com>,
 Jorgen Hansen <jhansen@vmware.com>
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

On Thu, May 27, 2021 at 6:21 AM Stefano Garzarella <sgarzare@redhat.com> wrote:
>
> Re-send my thoughts on this new series...
>
> On Wed, May 26, 2021 at 05:50:35PM +0000, Jiang Wang wrote:
> >From: "jiang.wang" <jiang.wang@bytedance.com>
> >
> >Add supports for datagram type for virtio-vsock. Datagram
> >sockets are connectionless and unreliable. To avoid contention
> >with stream and other sockets, add two more virtqueues and
> >a new feature bit to identify if those two new queues exist or not.
> >
> >Also add descriptions for resource management of datagram, which
> >does not use the existing credit update mechanism associated with
> >stream sockets.
> >
> >Signed-off-by: Jiang Wang <jiang.wang@bytedance.com>
> >---
> >V2: addressed the comments for the previous version.
> >V3: add description for the mergeable receive buffer.
> >
> >btw: send the same patch again to include virtio-comment@
> >
> > virtio-vsock.tex | 137 +++++++++++++++++++++++++++++++++++++++++++++++++------
> > 1 file changed, 124 insertions(+), 13 deletions(-)
> >
> >diff --git a/virtio-vsock.tex b/virtio-vsock.tex
> >index da7e641..7eb3596 100644
> >--- a/virtio-vsock.tex
> >+++ b/virtio-vsock.tex
> >@@ -9,14 +9,36 @@ \subsection{Device ID}\label{sec:Device Types / Socket Device / Device ID}
> >
> > \subsection{Virtqueues}\label{sec:Device Types / Socket Device / Virtqueues}
> > \begin{description}
> >-\item[0] rx
> >-\item[1] tx
> >+\item[0] stream rx
> >+\item[1] stream tx
> >+\item[2] datagram rx
> >+\item[3] datagram tx
> >+\item[4] event
> >+\end{description}
> >+The virtio socket device uses 5 queues if feature bit VIRTIO_VSOCK_F_DRGAM is set. Otherwise, it
> >+only uses 3 queues, as the following.
> >+
> >+\begin{description}
> >+\item[0] stream rx
> >+\item[1] stream tx
> > \item[2] event
> > \end{description}
> >
> >+When behavior differs between stream and datagram rx/tx virtqueues
> >+their full names are used. Common behavior is simply described in
> >+terms of rx/tx virtqueues and applies to both stream and datagram
> >+virtqueues.
> >+
> > \subsection{Feature bits}\label{sec:Device Types / Socket Device / Feature bits}
> >
> >-There are currently no feature bits defined for this device.
> >+\begin{description}
> >+\item[VIRTIO_VSOCK_F_DGRAM (0)] Device has support for datagram socket type.
> >+\end{description}
>
> As suggested by Michael here [1] we should add also a feature bit for
> stream, and maybe is better to reserve bit 0 for it.
>
> Arseny already sent an implementation of SEQPACKET using bit 1 for
> VIRTIO_VSOCK_F_SEQPACKET, so I think we can use bit 2 for DGRAM and bit
> 3 for MRG_RXBUF.
>
> [1]
> https://lists.oasis-open.org/archives/virtio-comment/202104/msg00016.html

Sure.

> >+
> >+\begin{description}
> >+\item[VIRTIO_VSOCK_F_MRG_RXBUF (1)] Driver can merge receive buffers.
> >+\end{description}
> >+
> >
> > \subsection{Device configuration layout}\label{sec:Device Types / Socket Device / Device configuration layout}
> >
> >@@ -64,6 +86,8 @@ \subsection{Device Operation}\label{sec:Device Types / Socket Device / Device Op
> >
> > Packets transmitted or received contain a header before the payload:
> >
> >+If feature VIRTIO_VSOCK_F_MRG_RXBUF is not negotiated, use the following header.
> >+
> > \begin{lstlisting}
> > struct virtio_vsock_hdr {
> >       le64 src_cid;
> >@@ -79,6 +103,15 @@ \subsection{Device Operation}\label{sec:Device Types / Socket Device / Device Op
> > };
> > \end{lstlisting}
> >
> >+If feature VIRTIO_VSOCK_F_MRG_RXBUF is negotianted, use the following header.
> >+\begin{lstlisting}
> >+struct virtio_vsock_hdr_mrg_rxbuf {
> >+      struct virtio_vsock_hdr hdr;
> >+      le16 num_buffers;
> >+};
> >+\end{lstlisting}
> >+
> >+
> > The upper 32 bits of src_cid and dst_cid are reserved and zeroed.
> >
> > Most packets simply transfer data but control packets are also used for
> >@@ -107,6 +140,9 @@ \subsection{Device Operation}\label{sec:Device Types / Socket Device / Device Op
> >
> > \subsubsection{Virtqueue Flow Control}\label{sec:Device Types / Socket Device / Device Operation / Virtqueue Flow Control}
> >
> >+Flow control applies to stream sockets; datagram sockets do not have
> >+flow control.
> >+
> > The tx virtqueue carries packets initiated by applications and replies to
> > received packets.  The rx virtqueue carries packets initiated by the device and
> > replies to previously transmitted packets.
> >@@ -140,12 +176,15 @@ \subsubsection{Addressing}\label{sec:Device Types / Socket Device / Device Opera
> > consists of a (cid, port number) tuple. The header fields used for this are
> > \field{src_cid}, \field{src_port}, \field{dst_cid}, and \field{dst_port}.
> >
> >-Currently only stream sockets are supported. \field{type} is 1 for stream
> >-socket types.
> >+Currently stream and datagram (dgram) sockets are supported. \field{type} is 1 for stream
> >+socket types. \field{type} is 3 for dgram socket types.
> >
> > Stream sockets provide in-order, guaranteed, connection-oriented delivery
> > without message boundaries.
> >
> >+Datagram sockets provide unordered, unreliable, connectionless messages
> >+with message boundaries and a maximum length.
> >+
> > \subsubsection{Buffer Space Management}\label{sec:Device Types / Socket Device / Device Operation / Buffer Space Management}
> > \field{buf_alloc} and \field{fwd_cnt} are used for buffer space management of
> > stream sockets. The guest and the device publish how much buffer space is
> >@@ -162,7 +201,7 @@ \subsubsection{Buffer Space Management}\label{sec:Device Types / Socket Device /
> > u32 peer_free = peer_buf_alloc - (tx_cnt - peer_fwd_cnt);
> > \end{lstlisting}
> >
> >-If there is insufficient buffer space, the sender waits until virtqueue buffers
> >+For stream sockets, if there is insufficient buffer space, the sender waits until virtqueue buffers
> > are returned and checks \field{buf_alloc} and \field{fwd_cnt} again. Sending
> > the VIRTIO_VSOCK_OP_CREDIT_REQUEST packet queries how much buffer space is
> > available. The reply to this query is a VIRTIO_VSOCK_OP_CREDIT_UPDATE packet.
> >@@ -170,22 +209,52 @@ \subsubsection{Buffer Space Management}\label{sec:Device Types / Socket Device /
> > previously receiving a VIRTIO_VSOCK_OP_CREDIT_REQUEST packet. This allows
> > communicating updates any time a change in buffer space occurs.
> >
> >+Unlike stream sockets, dgram sockets do not use VIRTIO_VSOCK_OP_CREDIT_UPDATE or
> >+VIRTIO_VSOCK_OP_CREDIT_REQUEST packets. The dgram buffer management
> >+is split to two parts: tx side and rx side. For the tx side, if the
> >+virtqueue is full, the packet will be dropped.
> >+For the rx side, dgram also uses the \field{buf_alloc}. If it is full, the packet
> >+is dropped by the receiver.
> >+
> >+\drivernormative{\paragraph}{Device Operation: Buffer Space Management}{Device Types / Socket Device / Device Operation / Setting Up Receive Buffers}
> >+\begin{itemize}
> >+\item If VIRTIO_VSOCK_F_MRG_RXBUF is not negotiated, the driver SHOULD populate the receive queue(s)
> >+      with buffers of at least 1526 bytes for stream sockets and 4096 bytes for datagram sockets.
> >+\item If VIRTIO_VSOCK_F_MRG_RXBUF is negotiated, each buffer MUST be at
> >+least the size of the struct virtio_vsock_hdr.
>                                 ^
>                                 Should it be virtio_vsock_hdr_mrg_rxbuf?

Yes. You are right.

> >+\end{itemize}
> >+
> >+\begin{note}
> >+Obviously each buffer can be split across multiple descriptor elements.
> >+\end{note}
> >+
> >+\devicenormative{\paragraph}{Device Operation: Buffer Space Management}{Device Types / Socket Device / Device Operation / Setting Up Receive Buffers}
> >+The device MUST set \field{num_buffers} to the number of descriptors used when
> >+transmitting the  packet.
> >+
> >+The device MUST use only a single descriptor if VIRTIO_VSOCK_F_MRG_RXBUF
> >+is not negotiated.
> >+
> > \drivernormative{\paragraph}{Device Operation: Buffer Space Management}{Device Types / Socket Device / Device Operation / Buffer Space Management}
> >-VIRTIO_VSOCK_OP_RW data packets MUST only be transmitted when the peer has
> >-sufficient free buffer space for the payload.
> >+For stream sockets, VIRTIO_VSOCK_OP_RW data packets MUST only be transmitted when the peer has
> >+sufficient free buffer space for the payload. For dgram sockets, VIRTIO_VSOCK_OP_RW data packets
> >+MAY be transmitted when the peer rx buffer is full. Then the packet will be dropped by the peer,
> >+and driver will not get any notification.
> >
> > All packets associated with a stream flow MUST contain valid information in
> > \field{buf_alloc} and \field{fwd_cnt} fields.
> >
> > \devicenormative{\paragraph}{Device Operation: Buffer Space Management}{Device Types / Socket Device / Device Operation / Buffer Space Management}
> >-VIRTIO_VSOCK_OP_RW data packets MUST only be transmitted when the peer has
> >-sufficient free buffer space for the payload.
> >+For stream sockets, VIRTIO_VSOCK_OP_RW data packets MUST only be transmitted when the peer has
> >+sufficient free buffer space for the payload. For dgram sockets, VIRTIO_VSOCK_OP_RW data packets
> >+MAY be transmitted when the peer rx buffer is full. Then the packet will be dropped by the peer,
> >+and the device will not get any notification.
> >
> > All packets associated with a stream flow MUST contain valid information in
> > \field{buf_alloc} and \field{fwd_cnt} fields.
> >
> > \subsubsection{Receive and Transmit}\label{sec:Device Types / Socket Device / Device Operation / Receive and Transmit}
> >-The driver queues outgoing packets on the tx virtqueue and incoming packet
> >+The driver queues outgoing packets on the tx virtqueue and allocates incoming packet
> > receive buffers on the rx virtqueue. Packets are of the following form:
> >
> > \begin{lstlisting}
> >@@ -198,21 +267,55 @@ \subsubsection{Receive and Transmit}\label{sec:Device Types / Socket Device / De
> > Virtqueue buffers for outgoing packets are read-only. Virtqueue buffers for
> > incoming packets are write-only.
> >
> >+When transmitting packets to the device, \field{num_buffers} is not used.
>
> Should we add a new `struct virtio_vsock_packet` description used when
> VIRTIO_VSOCK_F_MRG_RXBUF is negotiated?
>
OK. I think the only difference will be the header part. Will add.

> >+
> >+\begin{enumerate}
> >+\item \field{num_buffers} indicates how many descriptors
> >+  this packet is spread over (including this one): this will
> >+  always be 1 if VIRTIO_VSOCK_F_MRG_RXBUF was not negotiated.
>
> If VIRTIO_VSOCK_F_MRG_RXBUF was not negotiated, we use only
> virtio_vsock_hdr where there isn't `num_buffers`, so it is not clear to
> me this statement.

Yeah. I agree. I copied that part from virtio-net. I will just remove
that sentence.

Thanks.

Jiang

> Thanks,
> Stefano
>
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
