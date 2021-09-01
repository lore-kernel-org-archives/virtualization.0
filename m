Return-Path: <SRS0=XZyc=NX=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F6A3C432BE
	for <virtualization@archiver.kernel.org>; Wed,  1 Sep 2021 01:24:59 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1C9AA61027
	for <virtualization@archiver.kernel.org>; Wed,  1 Sep 2021 01:24:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 1C9AA61027
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=bytedance.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id C876560628;
	Wed,  1 Sep 2021 01:24:58 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id guaXGxL6Hj8q; Wed,  1 Sep 2021 01:24:55 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 6C4DA6060C;
	Wed,  1 Sep 2021 01:24:54 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 3D344C0010;
	Wed,  1 Sep 2021 01:24:54 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 50DEBC000E
 for <virtualization@lists.linux-foundation.org>;
 Wed,  1 Sep 2021 01:24:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 3EF9F400C3
 for <virtualization@lists.linux-foundation.org>;
 Wed,  1 Sep 2021 01:24:52 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=bytedance-com.20150623.gappssmtp.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 5793HgLNWo1c
 for <virtualization@lists.linux-foundation.org>;
 Wed,  1 Sep 2021 01:24:48 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com
 [IPv6:2a00:1450:4864:20::232])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 8F4AD400E6
 for <virtualization@lists.linux-foundation.org>;
 Wed,  1 Sep 2021 01:24:47 +0000 (UTC)
Received: by mail-lj1-x232.google.com with SMTP id l18so1951505lji.12
 for <virtualization@lists.linux-foundation.org>;
 Tue, 31 Aug 2021 18:24:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance-com.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=QkuJxn0XZkFV1bxtsAsgIiDk0gjYltI+748QYHzdpS4=;
 b=zberLoCjtBRtqMZqoRsiw1nJr4HE9ojnnsj5Y/6CVdcVH4BnRtRKte0mkwgWNT779M
 FwWoEGRItJC46QLZLsv1fkCWtZhsQgu4jLLGss3lm2fbCdrEKzhZ0RrmvmEdY8EZmkE5
 ZbqP+/6YO9KBzxiBiMc+P+cvrbvjKd1tsb89x4OdJkO4H9R+HJQISyAY2OCL7H9NvQ9m
 KqvVwB93ngu8RN/tbwVJjtB/xsadbd2WHLmo2U4BaZEWdAjkwf+GQuNsfHvGEPHuu46x
 yr+KfGtYRkOGlxwRQnm1nH/0k0ECrexwgncgnVLEY6Z66z2mFCv7yqblGReySb53vqao
 V21w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=QkuJxn0XZkFV1bxtsAsgIiDk0gjYltI+748QYHzdpS4=;
 b=OkCXegNSrvHSTYZXRQBL2oA4cgYlM5HRpe4HfQo8lUNGO0hks15cWmOtruNpiLK9kx
 yNrtSz8RBHcfmeboFgkgvnmuHRas1aoNOG8tw8riuzlfCdqXmiD1JzOkBKJo9xoprnLg
 WH6CbcxJSuuXQuD58l4PSC6FdKQ2LpmQVfFhlmzDe2ZUMs0K7zlEsz+hZs5Yrfnq5PDZ
 yVExYYufod/maHGjBimDSFrp8k+lbFupVK0H/K8qTXShQ6Q2gDf42QpbfBr9wmSFA9iy
 T27RmpVAjKHb0DVy5H8XnrbXPjWFDh9q+L11tW7HyVB5lXmcgbZ/hKipjIwfSR3GchW1
 o27w==
X-Gm-Message-State: AOAM533j/v23wMJXED4mn8fWz3GFHkhLYEYxbYjFzedopI0RsILSgZlh
 F1v03+vJFaFl/FsdpPwHH2Xiwavleax4wWfniRYEHg==
X-Google-Smtp-Source: ABdhPJyQXi6tdKZOYU1N5mCNgFCwcLdZ015BFtxj/M7ig2MMsaPFOjxwcYyACATvUzkmzH4quVI3ZxjrQkGLoR5dhkU=
X-Received: by 2002:a2e:d09:: with SMTP id 9mr26741660ljn.241.1630459485001;
 Tue, 31 Aug 2021 18:24:45 -0700 (PDT)
MIME-Version: 1.0
References: <20210610181203.979686-1-jiang.wang@bytedance.com>
 <20210831211205-mutt-send-email-mst@kernel.org>
In-Reply-To: <20210831211205-mutt-send-email-mst@kernel.org>
From: "Jiang Wang ." <jiang.wang@bytedance.com>
Date: Tue, 31 Aug 2021 18:24:34 -0700
Message-ID: <CAP_N_Z_3mtE5AedbU=u6cKpu8rpVUD09shQPYB-5-=zV1uOdww@mail.gmail.com>
Subject: Re: [External] Re: [virtio-comment] [PATCH v5] virtio-vsock: add
 description for datagram type
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Cong Wang <cong.wang@bytedance.com>,
 Xiongchun Duan <duanxiongchun@bytedance.com>, cohuck@redhat.com,
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

On Tue, Aug 31, 2021 at 6:13 PM Michael S. Tsirkin <mst@redhat.com> wrote:
>
> On Thu, Jun 10, 2021 at 06:12:03PM +0000, Jiang Wang wrote:
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
>
> Is this going anywhere? Linux with this included was just released but
> if no one has the cycles to work on the spec then it's not too late to
> disable the guest code in a stable@ patch.
>

Hi Michael,

I am still working on this (fixing the migration issue), but would
like to know if there are any more
comments or not.  I did not notice any commits related to vsock
dgram merged to Linux kernel, could you show me the commit link?

Thanks and regards,

Jiang

> > ---
> >
> > V2: addressed the comments for the previous version.
> > V3: add description for the mergeable receive buffer.
> > V4: add a feature bit for stream and reserver a bit for seqpacket.
> > Fix mrg_rxbuf related sentences.
> > V5: removed mergeable rx buffer part. It will go to a
> > separate patch. Fixed comments about tx, rx, feature bit etc.
> >
> >  virtio-vsock.tex | 71 +++++++++++++++++++++++++++++++++++++++++++++++---------
> >  1 file changed, 60 insertions(+), 11 deletions(-)
> >
> > diff --git a/virtio-vsock.tex b/virtio-vsock.tex
> > index da7e641..26a62ac 100644
> > --- a/virtio-vsock.tex
> > +++ b/virtio-vsock.tex
> > @@ -9,14 +9,37 @@ \subsection{Device ID}\label{sec:Device Types / Socket Device / Device ID}
> >
> >  \subsection{Virtqueues}\label{sec:Device Types / Socket Device / Virtqueues}
> >  \begin{description}
> > -\item[0] rx
> > -\item[1] tx
> > +\item[0] stream rx
> > +\item[1] stream tx
> > +\item[2] datagram rx
> > +\item[3] datagram tx
> > +\item[4] event
> > +\end{description}
> > +The virtio socket device uses 5 queues if feature bit VIRTIO_VSOCK_F_DRGAM is set. Otherwise, it
> > +only uses 3 queues, as the following.
> > +
> > +\begin{description}
> > +\item[0] stream rx
> > +\item[1] stream tx
> >  \item[2] event
> >  \end{description}
> >
> > +When behavior differs between stream and datagram rx/tx virtqueues
> > +their full names are used. Common behavior is simply described in
> > +terms of rx/tx virtqueues and applies to both stream and datagram
> > +virtqueues.
> > +
> >  \subsection{Feature bits}\label{sec:Device Types / Socket Device / Feature bits}
> >
> > -There are currently no feature bits defined for this device.
> > +\begin{description}
> > +\item[VIRTIO_VSOCK_F_STREAM (0)] Device has support for stream socket type.
> > +\end{description}
> > +
> > +\begin{description}
> > +\item[VIRTIO_VSOCK_F_DGRAM (2)] Device has support for datagram socket type.
> > +\end{description}
> > +
> > +If no feature bits are defined, assume device only supports stream socket type.
> >
> >  \subsection{Device configuration layout}\label{sec:Device Types / Socket Device / Device configuration layout}
> >
> > @@ -107,6 +130,9 @@ \subsection{Device Operation}\label{sec:Device Types / Socket Device / Device Op
> >
> >  \subsubsection{Virtqueue Flow Control}\label{sec:Device Types / Socket Device / Device Operation / Virtqueue Flow Control}
> >
> > +Flow control applies to stream sockets; datagram sockets do not have
> > +flow control.
> > +
> >  The tx virtqueue carries packets initiated by applications and replies to
> >  received packets.  The rx virtqueue carries packets initiated by the device and
> >  replies to previously transmitted packets.
> > @@ -140,12 +166,15 @@ \subsubsection{Addressing}\label{sec:Device Types / Socket Device / Device Opera
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
> > +Datagram sockets provide unordered, unreliable, connectionless messages
> > +with message boundaries and a maximum length.
> > +
> >  \subsubsection{Buffer Space Management}\label{sec:Device Types / Socket Device / Device Operation / Buffer Space Management}
> >  \field{buf_alloc} and \field{fwd_cnt} are used for buffer space management of
> >  stream sockets. The guest and the device publish how much buffer space is
> > @@ -162,7 +191,7 @@ \subsubsection{Buffer Space Management}\label{sec:Device Types / Socket Device /
> >  u32 peer_free = peer_buf_alloc - (tx_cnt - peer_fwd_cnt);
> >  \end{lstlisting}
> >
> > -If there is insufficient buffer space, the sender waits until virtqueue buffers
> > +For stream sockets, if there is insufficient buffer space, the sender waits until virtqueue buffers
> >  are returned and checks \field{buf_alloc} and \field{fwd_cnt} again. Sending
> >  the VIRTIO_VSOCK_OP_CREDIT_REQUEST packet queries how much buffer space is
> >  available. The reply to this query is a VIRTIO_VSOCK_OP_CREDIT_UPDATE packet.
> > @@ -170,22 +199,33 @@ \subsubsection{Buffer Space Management}\label{sec:Device Types / Socket Device /
> >  previously receiving a VIRTIO_VSOCK_OP_CREDIT_REQUEST packet. This allows
> >  communicating updates any time a change in buffer space occurs.
> >
> > +Unlike stream sockets, dgram sockets do not use VIRTIO_VSOCK_OP_CREDIT_UPDATE or
> > +VIRTIO_VSOCK_OP_CREDIT_REQUEST packets. The dgram buffer management
> > +is split to two parts: sender side and receiver side. For the sender side, if the
> > +virtqueue is full, the packet will be dropped.
> > +For the receiver side, the packet is dropped by the receiver if there is no space in the
> > +receive buffer.
> > +
> >  \drivernormative{\paragraph}{Device Operation: Buffer Space Management}{Device Types / Socket Device / Device Operation / Buffer Space Management}
> > -VIRTIO_VSOCK_OP_RW data packets MUST only be transmitted when the peer has
> > -sufficient free buffer space for the payload.
> > +For stream sockets, VIRTIO_VSOCK_OP_RW data packets MUST only be transmitted when the peer has
> > +sufficient free buffer space for the payload. For dgram sockets, VIRTIO_VSOCK_OP_RW data packets
> > +MAY be transmitted when the peer rx buffer is full. Then the packet will be dropped by the peer,
> > +and driver will not get any notification.
> >
> >  All packets associated with a stream flow MUST contain valid information in
> >  \field{buf_alloc} and \field{fwd_cnt} fields.
> >
> >  \devicenormative{\paragraph}{Device Operation: Buffer Space Management}{Device Types / Socket Device / Device Operation / Buffer Space Management}
> > -VIRTIO_VSOCK_OP_RW data packets MUST only be transmitted when the peer has
> > -sufficient free buffer space for the payload.
> > +For stream sockets, VIRTIO_VSOCK_OP_RW data packets MUST only be transmitted when the peer has
> > +sufficient free buffer space for the payload. For dgram sockets, VIRTIO_VSOCK_OP_RW data packets
> > +MAY be transmitted when the peer rx buffer is full. Then the packet will be dropped by the peer,
> > +and the device will not get any notification.
> >
> >  All packets associated with a stream flow MUST contain valid information in
> >  \field{buf_alloc} and \field{fwd_cnt} fields.
> >
> >  \subsubsection{Receive and Transmit}\label{sec:Device Types / Socket Device / Device Operation / Receive and Transmit}
> > -The driver queues outgoing packets on the tx virtqueue and incoming packet
> > +The driver queues outgoing packets on the tx virtqueue and allocates incoming packet
> >  receive buffers on the rx virtqueue. Packets are of the following form:
> >
> >  \begin{lstlisting}
> > @@ -195,6 +235,7 @@ \subsubsection{Receive and Transmit}\label{sec:Device Types / Socket Device / De
> >  };
> >  \end{lstlisting}
> >
> > +
> >  Virtqueue buffers for outgoing packets are read-only. Virtqueue buffers for
> >  incoming packets are write-only.
> >
> > @@ -240,6 +281,14 @@ \subsubsection{Stream Sockets}\label{sec:Device Types / Socket Device / Device O
> >  destination) address tuple for a new connection while the other peer is still
> >  processing the old connection.
> >
> > +\subsubsection{Datagram Sockets}\label{sec:Device Types / Socket Device / Device Operation / Datagram Sockets}
> > +
> > +Datagram (dgram) sockets are connectionless and unreliable. The sender just sends
> > +a message to the peer and hopes it will be delivered. A VIRTIO_VSOCK_OP_RST reply is sent if
> > +a receiving socket does not exist on the destination.
> > +If the transmission or receiving buffers are full, the packets
> > +are dropped.
> > +
> >  \subsubsection{Device Events}\label{sec:Device Types / Socket Device / Device Operation / Device Events}
> >
> >  Certain events are communicated by the device to the driver using the event
> > --
> > 2.11.0
> >
> >
> > This publicly archived list offers a means to provide input to the
> > OASIS Virtual I/O Device (VIRTIO) TC.
> >
> > In order to verify user consent to the Feedback License terms and
> > to minimize spam in the list archive, subscription is required
> > before posting.
> >
> > Subscribe: virtio-comment-subscribe@lists.oasis-open.org
> > Unsubscribe: virtio-comment-unsubscribe@lists.oasis-open.org
> > List help: virtio-comment-help@lists.oasis-open.org
> > List archive: https://lists.oasis-open.org/archives/virtio-comment/
> > Feedback License: https://www.oasis-open.org/who/ipr/feedback_license.pdf
> > List Guidelines: https://www.oasis-open.org/policies-guidelines/mailing-lists
> > Committee: https://www.oasis-open.org/committees/virtio/
> > Join OASIS: https://www.oasis-open.org/join/
>
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
