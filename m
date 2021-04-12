Return-Path: <SRS0=TAdK=JJ=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18B62C433ED
	for <virtualization@archiver.kernel.org>; Mon, 12 Apr 2021 22:39:57 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 910476121E
	for <virtualization@archiver.kernel.org>; Mon, 12 Apr 2021 22:39:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 910476121E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=bytedance.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 563E360B16;
	Mon, 12 Apr 2021 22:39:56 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id OxQsZFA4haBx; Mon, 12 Apr 2021 22:39:55 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTP id 886C86070C;
	Mon, 12 Apr 2021 22:39:54 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 50FCBC000B;
	Mon, 12 Apr 2021 22:39:54 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 29284C000A
 for <virtualization@lists.linux-foundation.org>;
 Mon, 12 Apr 2021 22:39:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 0F08C404F4
 for <virtualization@lists.linux-foundation.org>;
 Mon, 12 Apr 2021 22:39:52 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=bytedance-com.20150623.gappssmtp.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id QCwkLbMg0RFn
 for <virtualization@lists.linux-foundation.org>;
 Mon, 12 Apr 2021 22:39:49 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com
 [IPv6:2607:f8b0:4864:20::329])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 9A1C6404F2
 for <virtualization@lists.linux-foundation.org>;
 Mon, 12 Apr 2021 22:39:49 +0000 (UTC)
Received: by mail-ot1-x329.google.com with SMTP id
 k14-20020a9d7dce0000b02901b866632f29so14376566otn.1
 for <virtualization@lists.linux-foundation.org>;
 Mon, 12 Apr 2021 15:39:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance-com.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=0TFIdOpLuQUTZpTypXAmeFouLcxK17j+xEJW+v2yGz8=;
 b=SGs9KHzXP17JLH+6GvAjgoWxKCPrH1tVPLafnFiBxVfcj8TEozZTtZf7Tx1vGiEnQB
 fpLAjYi+4jGy6VCnDVYwngOY14Zt50r44lTCTQotDS1sC7vbng4NKWbEXfen1kFQkclo
 oMpKYEE/ky/SMKdBLS1KTtsgKjrBRoqxD8JWYUMSZLsDj05kvO/82kYT8WR4zIFcAj7e
 g9ABJIt6e8L9GE390LQV/Dxdgvu2I9fUn3G9O8o0D7YZd5xJ+iTb8RR7ScObrcaJe5XH
 NiyJVr8xRRudg/UHd/uhhFZ91iWoz/nnlTOq2utS/E1ss5CKb/RZ6ihZH/j/A/L96JuR
 jXug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=0TFIdOpLuQUTZpTypXAmeFouLcxK17j+xEJW+v2yGz8=;
 b=HsE35QuimFpUMbLJhWfkadue63Lzsu3YeW87CuQ1Zv4SACeWYHgGvZ7gF0t5TYPWQr
 P6qxn7C+wVPnkmuuqVGPSLmzKZn++C0YcQN3TAxzo3qBHbqOxT5Wi7DPlfELAunarDJV
 aPe9JOM8eIH7+Sce1XuY8xGwb7OL900yPSAHjDvS/eXXnnD/3ClFH3hk0YibI7IjrjOt
 ceVaTimGeJoc9Sdj32AAaGFGZ6oc7ZoTufTTK04c2g/twom1Cszw93fBMsEt/RqRcL5c
 1aZR+CS5L/pIkWO0mJL8tWOIJUITiOer5904w9miDfR06TbcdG6KKUF687Nht4bDhxGL
 ql3A==
X-Gm-Message-State: AOAM533Ocg/xdby0oBrz56V3/ahwZ2RMnvLkT01YJWmhOKP8IBdgmQhN
 o+IXcsi7q8VodlhX4WBViBqHunSSrdR9x6va2D5TiQ==
X-Google-Smtp-Source: ABdhPJx6gCHewWMB03fzZd+k7SfmE37OeywApo/4o9uPjHWAZ+ML3LwAsLgQYMgXYtLtJkiAHZ/xzfTXO3J7wheGJZQ=
X-Received: by 2002:a05:6830:22c3:: with SMTP id
 q3mr25402486otc.56.1618267187927; 
 Mon, 12 Apr 2021 15:39:47 -0700 (PDT)
MIME-Version: 1.0
References: <20210401043602.3510538-1-jiang.wang@bytedance.com>
 <YHRQGSSnkN8Zipy0@stefanha-x1.localdomain>
In-Reply-To: <YHRQGSSnkN8Zipy0@stefanha-x1.localdomain>
From: "Jiang Wang ." <jiang.wang@bytedance.com>
Date: Mon, 12 Apr 2021 15:39:36 -0700
Message-ID: <CAP_N_Z-OMqQtnV04Wpynr7GhZooz1iQQ+0To-P8xPEnA0+sZgQ@mail.gmail.com>
Subject: Re: [External] Re: [RFC v2] virtio-vsock: add description for
 datagram type
To: Stefan Hajnoczi <stefanha@redhat.com>
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

On Mon, Apr 12, 2021 at 6:50 AM Stefan Hajnoczi <stefanha@redhat.com> wrote:
>
> On Thu, Apr 01, 2021 at 04:36:02AM +0000, jiang.wang wrote:
> > Add supports for datagram type for virtio-vsock. Datagram
> > sockets are connectionless and unreliable. To avoid contention
> > with stream and other sockets, add two more virtqueues and
> > a new feature bit to identify if those two new queues exist or not.
> >
> > Also add descriptions for resource management of datagram, which
> > does not use the existing credit update mechanism associated with
> > stream sockets.
> >
> > Signed-off-by: Jiang Wang <jiang.wang@bytedance.com>
> > ---
> > V2 addressed the comments for the previous version.
> >
> >  virtio-vsock.tex | 62 +++++++++++++++++++++++++++++++++++++++++++++++---------
> >  1 file changed, 52 insertions(+), 10 deletions(-)
> >
> > diff --git a/virtio-vsock.tex b/virtio-vsock.tex
> > index da7e641..62c12e0 100644
> > --- a/virtio-vsock.tex
> > +++ b/virtio-vsock.tex
> > @@ -11,12 +11,25 @@ \subsection{Virtqueues}\label{sec:Device Types / Socket Device / Virtqueues}
> >  \begin{description}
> >  \item[0] rx
> >  \item[1] tx
> > +\item[2] datagram rx
> > +\item[3] datagram tx
> > +\item[4] event
> > +\end{description}
> > +The virtio socket device uses 5 queues if feature bit VIRTIO_VSOCK_F_DRGAM is set. Otherwise, it
> > +only uses 3 queues, as the following. Rx and tx queues are always used for stream sockets.
> > +
> > +\begin{description}
> > +\item[0] rx
> > +\item[1] tx
> >  \item[2] event
> >  \end{description}
> >
>
> I suggest renaming "rx" and "tx" to "stream rx" and "stream tx"
> virtqueues and also adding this:

OK

>   When behavior differs between stream and datagram rx/tx virtqueues
>   their full names are used. Common behavior is simply described in
>   terms of rx/tx virtqueues and applies to both stream and datagram
>   virtqueues.

OK

> This way you won't need to duplicate portions of the spec that deal with
> populating the virtqueues, for example.
>
> It's also clearer to use a full name for stream rx/tx virtqueues instead
> of calling them rx/tx virtqueues now that we have datagram rx/tx
> virtqueues.

Sure.

> > +
> >  \subsection{Feature bits}\label{sec:Device Types / Socket Device / Feature bits}
> >
> > -There are currently no feature bits defined for this device.
> > +\begin{description}
> > +\item[VIRTIO_VSOCK_F_DGRAM (0)] Device has support for datagram socket type.
> > +\end{description}
> >
> >  \subsection{Device configuration layout}\label{sec:Device Types / Socket Device / Device configuration layout}
> >
> > @@ -107,6 +120,9 @@ \subsection{Device Operation}\label{sec:Device Types / Socket Device / Device Op
> >
> >  \subsubsection{Virtqueue Flow Control}\label{sec:Device Types / Socket Device / Device Operation / Virtqueue Flow Control}
> >
> > +Flow control applies to stream sockets; datagram sockets do not have
> > +flow control.
> > +
> >  The tx virtqueue carries packets initiated by applications and replies to
> >  received packets.  The rx virtqueue carries packets initiated by the device and
> >  replies to previously transmitted packets.
> > @@ -140,12 +156,15 @@ \subsubsection{Addressing}\label{sec:Device Types / Socket Device / Device Opera
> >  consists of a (cid, port number) tuple. The header fields used for this are
> >  \field{src_cid}, \field{src_port}, \field{dst_cid}, and \field{dst_port}.
> >
> > -Currently only stream sockets are supported. \field{type} is 1 for stream
> > -socket types.
> > +Currently stream and datagram (dgram) sockets are supported. \field{type} is 1 for stream
> > +socket types. \field{type} is 3 for dgram socket types.
> >
> >  Stream sockets provide in-order, guaranteed, connection-oriented delivery
> >  without message boundaries.
> >
> > +Datagram sockets provide connectionless unreliable messages of
> > +a fixed maximum length.
>
> Plus unordered (?) and with message boundaries. In other words:
>
>   Datagram sockets provide unordered, unreliable, connectionless message
>   with message boundaries and a fixed maximum length.

OK. Will do. In my implementation, the order is preserved because
there is only one virtqueue. But I think we can put unordered in the spec.

> I didn't think of the fixed maximum length aspect before. I guess the
> intention is that the rx buffer size is the message size limit? That's
> different from UDP messages, which can be fragmented into multiple IP
> packets and can be larger than 64KiB:
> https://en.wikipedia.org/wiki/User_Datagram_Protocol#UDP_datagram_structure
>
> Is it possible to support large datagram messages in vsock? I'm a little
> concerned that applications that run successfully over UDP will not be
> portable if vsock has this limitation because it would impose extra
> message boundaries that the application protocol might not tolerate.
>
OK. I think one way is to support fragmentation as suggested by Stefano.

> > +
> >  \subsubsection{Buffer Space Management}\label{sec:Device Types / Socket Device / Device Operation / Buffer Space Management}
> >  \field{buf_alloc} and \field{fwd_cnt} are used for buffer space management of
> >  stream sockets. The guest and the device publish how much buffer space is
> > @@ -162,7 +181,7 @@ \subsubsection{Buffer Space Management}\label{sec:Device Types / Socket Device /
> >  u32 peer_free = peer_buf_alloc - (tx_cnt - peer_fwd_cnt);
> >  \end{lstlisting}
> >
> > -If there is insufficient buffer space, the sender waits until virtqueue buffers
> > +For stream sockets, if there is insufficient buffer space, the sender waits until virtqueue buffers
> >  are returned and checks \field{buf_alloc} and \field{fwd_cnt} again. Sending
> >  the VIRTIO_VSOCK_OP_CREDIT_REQUEST packet queries how much buffer space is
> >  available. The reply to this query is a VIRTIO_VSOCK_OP_CREDIT_UPDATE packet.
> > @@ -170,16 +189,28 @@ \subsubsection{Buffer Space Management}\label{sec:Device Types / Socket Device /
> >  previously receiving a VIRTIO_VSOCK_OP_CREDIT_REQUEST packet. This allows
> >  communicating updates any time a change in buffer space occurs.
> >
> > +Unlike stream sockets, dgram sockets do not use VIRTIO_VSOCK_OP_CREDIT_UPDATE or
> > +VIRTIO_VSOCK_OP_CREDIT_REQUEST packets. The dgram buffer management
> > +is split to two parts: tx side and rx side. For the tx side, there is
> > +additional buffer space for each socket.
>
> Plus:
>
>   ... according to the the driver and device's available memory
>   resources. The amount of tx buffer space is an implementation detail
>   of both the device and the driver. It is not visible to the other side
>   and may be controlled by the application or administrative resource
>   limits.
>
> What I'm trying to describe here is that the additional tx buffer space
> isn't part of the device interface.
>
OK. Will do.

> > +The dgram sender sends packets when the virtqueue or the additional buffer is not full.
> > +When both are full, the sender
> > +MUST return an appropriate error to the upper layer application.
>
> MUST, SHOULD, etc clauses need to go into the
> devicenormative/drivernormative sections. They cannot be in regular
> text.
>
OK.

> > +For the rx side, dgram also uses the \field{buf_alloc}. If it is full, the packet
> > +is dropped by the receiver.
>
> UDP is connectionless so any number of other sources can send messages
> to the same destination, causing buf_alloc's value to be unpredictable.
> Can you explain how buf_alloc works with datagram sockets in more
> detail?

In the linux kernel in my prototype, datagram sockets also use
virtio_transport_inc_rx_pkt() and virtio_transport_dec_rx_pkt() to update
vvs->rx_bytes and compare it with vvs->buf_alloc. virtio_transport_inc_rx_pkt
is called when enqueuing the datagram packets.
virtio_transport_dec_rx_pkt is called when dequeuing those packets.

If multiple sources send messages to the same destination, they will share
the same buf_alloc. Do you want something with more control?
Maybe somehow allocate a buffer for each remote CID and port? But I
feel that is a little bit overkill. Any other suggestions?

> >  \drivernormative{\paragraph}{Device Operation: Buffer Space Management}{Device Types / Socket Device / Device Operation / Buffer Space Management}
> > -VIRTIO_VSOCK_OP_RW data packets MUST only be transmitted when the peer has
> > -sufficient free buffer space for the payload.
> > +For stream sockets, VIRTIO_VSOCK_OP_RW data packets MUST only be transmitted when the peer has
> > +sufficient free buffer space for the payload. For dgram sockets, VIRTIO_VSOCK_OP_RW data packets
> > +MAY be transmitted when the peer buffer is full. Then the packet will be dropped by the receiver.
> >
> >  All packets associated with a stream flow MUST contain valid information in
> >  \field{buf_alloc} and \field{fwd_cnt} fields.
> >
> >  \devicenormative{\paragraph}{Device Operation: Buffer Space Management}{Device Types / Socket Device / Device Operation / Buffer Space Management}
> > -VIRTIO_VSOCK_OP_RW data packets MUST only be transmitted when the peer has
> > -sufficient free buffer space for the payload.
> > +For stream sockets, VIRTIO_VSOCK_OP_RW data packets MUST only be transmitted when the peer has
> > +sufficient free buffer space for the payload. For dgram sockets, VIRTIO_VSOCK_OP_RW data packets
> > +MAY be transmitted when the peer buffer is full. Then the packet will be dropped by the receiver.
> >
> >  All packets associated with a stream flow MUST contain valid information in
> >  \field{buf_alloc} and \field{fwd_cnt} fields.
> > @@ -203,14 +234,14 @@ \subsubsection{Receive and Transmit}\label{sec:Device Types / Socket Device / De
> >  The \field{guest_cid} configuration field MUST be used as the source CID when
> >  sending outgoing packets.
> >
> > -A VIRTIO_VSOCK_OP_RST reply MUST be sent if a packet is received with an
> > +For stream sockets, A VIRTIO_VSOCK_OP_RST reply MUST be sent if a packet is received with an
> >  unknown \field{type} value.
>
> What about datagram sockets? Please state what must happen and why.

I think datagram sockets should do the same thing as the stream to
return a VIRTIO_VSOCK_OP_RST?
Any other ideas?

> >
> >  \devicenormative{\paragraph}{Device Operation: Receive and Transmit}{Device Types / Socket Device / Device Operation / Receive and Transmit}
> >
> >  The \field{guest_cid} configuration field MUST NOT contain a reserved CID as listed in \ref{sec:Device Types / Socket Device / Device configuration layout}.
> >
> > -A VIRTIO_VSOCK_OP_RST reply MUST be sent if a packet is received with an
> > +For stream sockets, A VIRTIO_VSOCK_OP_RST reply MUST be sent if a packet is received with an
> >  unknown \field{type} value.
> >
> >  \subsubsection{Stream Sockets}\label{sec:Device Types / Socket Device / Device Operation / Stream Sockets}
> > @@ -240,6 +271,17 @@ \subsubsection{Stream Sockets}\label{sec:Device Types / Socket Device / Device O
> >  destination) address tuple for a new connection while the other peer is still
> >  processing the old connection.
> >
> > +\subsubsection{Datagram Sockets}\label{sec:Device Types / Socket Device / Device Operation / Stream Sockets}
>
> s/Stream Sockets/Datagram Sockets/

Will do

> > +
> > +Datagram (dgram) sockets are connectionless and unreliable. The sender just sends
> > +a message to the peer and hope it will be delivered. A VIRTIO_VSOCK_OP_RST reply is sent if
>
> s/hope/hopes/

got it.

> > +a receiving socket does not exist on the destination.
> > +If the transmission or receiving buffers are full, the packets
> > +are dropped. If the transmission buffer is full, an appropriate error message
> > +is returned to the caller.
>
> It's unclear whether the caller is the driver/device or something else.
> I think you're referring to the application interace, which is outside
> the scope of the VIRTIO spec. I suggest dropping the last sentence.

Yeah, I was thinking about the application interface. I will drop this
sentence.

Thanks for all the feedback.
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
