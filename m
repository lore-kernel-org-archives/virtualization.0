Return-Path: <SRS0=byTZ=IU=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC17EC433DB
	for <virtualization@archiver.kernel.org>; Mon, 22 Mar 2021 23:02:35 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1F911619A3
	for <virtualization@archiver.kernel.org>; Mon, 22 Mar 2021 23:02:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1F911619A3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=bytedance.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id C9A34607F8;
	Mon, 22 Mar 2021 23:02:34 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id mlpT_Nnh1lOw; Mon, 22 Mar 2021 23:02:33 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTP id BC04A607E2;
	Mon, 22 Mar 2021 23:02:32 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 93A8EC000A;
	Mon, 22 Mar 2021 23:02:32 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 24E6AC0001
 for <virtualization@lists.linux-foundation.org>;
 Mon, 22 Mar 2021 23:02:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id EDF1F40435
 for <virtualization@lists.linux-foundation.org>;
 Mon, 22 Mar 2021 23:02:29 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=bytedance-com.20150623.gappssmtp.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id gPk8kQ9b5yPh
 for <virtualization@lists.linux-foundation.org>;
 Mon, 22 Mar 2021 23:02:27 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com
 [IPv6:2607:f8b0:4864:20::329])
 by smtp4.osuosl.org (Postfix) with ESMTPS id E64AC40433
 for <virtualization@lists.linux-foundation.org>;
 Mon, 22 Mar 2021 23:02:26 +0000 (UTC)
Received: by mail-ot1-x329.google.com with SMTP id
 68-20020a9d0f4a0000b02901b663e6258dso17648138ott.13
 for <virtualization@lists.linux-foundation.org>;
 Mon, 22 Mar 2021 16:02:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance-com.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=XtiihYYkFX7J6Nvn9HHSkcmm/D1/7FdRl/8vTvzz9ss=;
 b=bX7i6NWsi6U+XvQPHXHla7tB2HOoHlbiegkbUk5cYvV/AQAUpZCD9LfAdg85jH/f01
 GCJQbDGJ3v8eGCN2zzTNLGg2er9+mO81dgYQZBqSiiM4+NhEjeBa9Qu5OzgmKGghcYE9
 pw1jI9EEO16JnuiuQJp1oz3Ob432H9XC5yBPkO3hnu31WdWvMBmyXXAHlf+5QSlUjx47
 BZRQ5qvNGKuWMg7+0BPOf4wC39wKCYfn5pnYY6tlzmpQkZPoVU3zj0h1+zugshPGAAJ/
 i96n6sLXXwGBBiVNFfWrE6qIAFCdAWNcCmHBFiIG31cHwNrQfKOTamFhmgsCQVlBYoH7
 MDJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=XtiihYYkFX7J6Nvn9HHSkcmm/D1/7FdRl/8vTvzz9ss=;
 b=ekcrawCRFux7XHIFq4Be+MjvrSEPDPwVELoou9rmrKOymqkbJjd0eBtMZDEcGXOMGo
 gaGoSmee45TwndYTfxTozOhabM/YQZyt0IehXBcERenNXfUk7ZE0n9hcxvCPodPrjtmt
 tLbMMSJ4RrIE96TO2Y6jIOG5deaYeX6y01pge9Q1MhOyJDUf1t71uakv8ubz4IKprZ5D
 7XPBbeb/KsxOm0LAg5HirMtKnX3TCharb8HyXMyz3M8xSaEzjatGHWGWk+32Bc8Hh4/I
 2VNuP48gX5qtLx0SYvY3G7BQop0uU+zQLNrHxAgssYcPcnhWxnIaF5h/PP7HlYe8ijcV
 Iw0g==
X-Gm-Message-State: AOAM533SG4IXAyuRx2+gFybqOTzoIYGcFZaE2FhBLBUmFA3hFLvx6Inx
 K4z7zm/kQ8AJLNyXRvO7FZFWxSHRU6FM3B1VXOIYxQ==
X-Google-Smtp-Source: ABdhPJzFxSXn5Cxq/OZQTjYbiS5gN995oXnGWyM0jFXvO+R8CMJYCzoZm5B3ZE8mEAi+wYlLKNFXFBNE+ZVKtTOO97g=
X-Received: by 2002:a9d:ef1:: with SMTP id 104mr1755213otj.180.1616454145154; 
 Mon, 22 Mar 2021 16:02:25 -0700 (PDT)
MIME-Version: 1.0
References: <20210316215644.2254177-1-jiang.wang@bytedance.com>
 <YFIj+FQQzZmVAqWw@stefanha-x1.localdomain>
 <CAP_N_Z857fnkc4GejHt_t_nxnhXC60=S51i_XQ-AdgXO2NipFA@mail.gmail.com>
 <YFjK7MkmJOFaUvgz@stefanha-x1.localdomain>
In-Reply-To: <YFjK7MkmJOFaUvgz@stefanha-x1.localdomain>
From: "Jiang Wang ." <jiang.wang@bytedance.com>
Date: Mon, 22 Mar 2021 16:02:14 -0700
Message-ID: <CAP_N_Z-aOds0-DgSYgGLb3AG7kvf=iqmLHojMjh878j8bTBkwg@mail.gmail.com>
Subject: Re: [External] Re: [RFC PATCH] virtio-vsock: add description for
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

On Mon, Mar 22, 2021 at 9:51 AM Stefan Hajnoczi <stefanha@redhat.com> wrote:
>
> On Thu, Mar 18, 2021 at 10:59:20AM -0700, Jiang Wang . wrote:
> > On Wed, Mar 17, 2021 at 8:45 AM Stefan Hajnoczi <stefanha@redhat.com> wrote:
> > >
> > > On Tue, Mar 16, 2021 at 09:56:44PM +0000, jiang.wang wrote:
> > > > Add supports for datagram type for virtio-vsock. Datagram
> > > > sockets are connectionless and unreliable. To avoid contention
> > > > with stream and other sockets, add two more virtqueues and
> > > > a new feature bit to identify if those two new queues exist or not.
> > > >
> > > > Also add descriptions for resouce management of datagram, which
> > > > does not use the existing credit update mechanism associated with
> > > > stream sockets.
> > > >
> > > > Signed-off-by: Jiang Wang <jiang.wang@bytedance.com>
> > > > ---
> > > >  virtio-vsock.tex | 72 ++++++++++++++++++++++++++++++++++++++++++++++++--------
> > > >  1 file changed, 62 insertions(+), 10 deletions(-)
> > > >
> > > > diff --git a/virtio-vsock.tex b/virtio-vsock.tex
> > > > index da7e641..a2ff0a4 100644
> > > > --- a/virtio-vsock.tex
> > > > +++ b/virtio-vsock.tex
> > > > @@ -9,14 +9,27 @@ \subsection{Device ID}\label{sec:Device Types / Socket Device / Device ID}
> > > >
> > > >  \subsection{Virtqueues}\label{sec:Device Types / Socket Device / Virtqueues}
> > > >  \begin{description}
> > > > +\item[0] stream rx
> > > > +\item[1] stream tx
> > > > +\item[2] dgram rx
> > > > +\item[3] dgram tx
> > > > +\item[4] event
> > > > +\end{description}
> > > > +The virtio socket device uses 5 queues if feature bit VIRTIO_VSOCK_DRGAM is set. Otherwise, it
> > > > +only uses 3 queues, as the following.
> > > > +
> > > > +\begin{description}
> > > >  \item[0] rx
> > > >  \item[1] tx
> > > >  \item[2] event
> > > >  \end{description}
> > > >
> > > > +
> > > >  \subsection{Feature bits}\label{sec:Device Types / Socket Device / Feature bits}
> > > >
> > > > -There are currently no feature bits defined for this device.
> > > > +\begin{description}
> > > > +\item[VIRTIO_VSOCK_DGRAM (0)] Device has support for datagram sockets type.
> > > > +\end{description}
> > >
> > > By convention feature bits are named VIRTIO_<device>_F_<feature>. Please
> > > add the "_F_".
> > >
> > Sure.
> >
> > > >
> > > >  \subsection{Device configuration layout}\label{sec:Device Types / Socket Device / Device configuration layout}
> > > >
> > > > @@ -76,6 +89,7 @@ \subsection{Device Operation}\label{sec:Device Types / Socket Device / Device Op
> > > >       le32 flags;
> > > >       le32 buf_alloc;
> > > >       le32 fwd_cnt;
> > > > +     le64 timestamp;
> > >
> > > Adding this field breaks old devices and drivers. Please make this field
> > > conditional on the dgram socket type or the VIRTIO_VSOCK_F_DGRAM feature
> > > bit.
> > >
> > > Also, are all the other fields still used with dgram sockets? Maybe you
> > > can use a union instead to reuse some space?
> >
> > I will make this new field depending on the dgram socket type.
> >
> > For the union idea, could I change the order of those fields? Dgram does not use
> > flags and fwd_cnt fields, and I want to put them together with a union
> > of a le64 timestamp.
> > Something like:
> >
> > struct virtio_vsock_hdr {
> >   le64 src_cid;
> >   le64 dst_cid;
> >   le32 src_port;
> >   le32 dst_port;
> >   le32 len;
> >   le16 type;
> >   le16 op;
> >   le32 buf_alloc;
> >  union {
> >         struct {
> >               le32 flags;
> >               le32 fwd_cnt;
> >         } stream;
> >         le64 dgram_timestamp;
> >      } internal; // or a better name
> > };
>
> Unfortunately reordering the fields would break existing devices and
> drivers since they access flags and fwd_cnt at a specific offset in
> struct virtio_vsock_hdr.
>
> Thinking more about the union idea, I think it's more trouble than it is
> worth. You could just write dgram_timestamp accessor functions that
> split/join the le64 value into the existing le32 flags and fwd_cnt
> fields.

Sure. Maybe we don't need this field at all. Will discuss it at the
end of email.

> >
> > > >  };
> > > >  \end{lstlisting}
> > > >
> > > > @@ -121,11 +135,14 @@ \subsubsection{Virtqueue Flow Control}\label{sec:Device Types / Socket Device /
> > > >  packets.  With additional resources, it becomes possible to process incoming
> > > >  packets even when outgoing packets cannot be sent.
> > > >
> > > > -Eventually even the additional resources will be exhausted and further
> > > > +For stream type, eventually even the additional resources will be exhausted and further
> > > >  processing is not possible until the other side processes the virtqueue that
> > > >  it has neglected.  This stop to processing prevents one side from causing
> > > >  unbounded resource consumption in the other side.
> > > >
> > > > +For datagram type, the additional resources have a fixed size limit to prevent
> > > > +unbounded resource consumption.
> > > > +
> > > >  \drivernormative{\paragraph}{Device Operation: Virtqueue Flow Control}{Device Types / Socket Device / Device Operation / Virtqueue Flow Control}
> > > >
> > > >  The rx virtqueue MUST be processed even when the tx virtqueue is full so long as there are additional resources available to hold packets outside the tx virtqueue.
> > > > @@ -140,12 +157,15 @@ \subsubsection{Addressing}\label{sec:Device Types / Socket Device / Device Opera
> > > >  consists of a (cid, port number) tuple. The header fields used for this are
> > > >  \field{src_cid}, \field{src_port}, \field{dst_cid}, and \field{dst_port}.
> > > >
> > > > -Currently only stream sockets are supported. \field{type} is 1 for stream
> > > > -socket types.
> > > > +Currently stream and datagram (dgram) sockets are supported. \field{type} is 1 for stream
> > > > +socket types. \field{type} is 3 for dgram socket types.
> > > >
> > > >  Stream sockets provide in-order, guaranteed, connection-oriented delivery
> > > >  without message boundaries.
> > > >
> > > > +Datagram socekts provide connectionless unreliable messages of
> > >
> > > s/socekts/sockets/
> > >
> > > > +a fixed maximum length.
> > > > +
> > > >  \subsubsection{Buffer Space Management}\label{sec:Device Types / Socket Device / Device Operation / Buffer Space Management}
> > > >  \field{buf_alloc} and \field{fwd_cnt} are used for buffer space management of
> > > >  stream sockets. The guest and the device publish how much buffer space is
> > > > @@ -170,20 +190,41 @@ \subsubsection{Buffer Space Management}\label{sec:Device Types / Socket Device /
> > > >  previously receiving a VIRTIO_VSOCK_OP_CREDIT_REQUEST packet. This allows
> > > >  communicating updates any time a change in buffer space occurs.
> > > >
> > > > +For datagram sockets, \field{buf_alloc} is also used on the rx side. Unlike stream
> > > > +sockets, dgram sockets do not use VIRTIO_VSOCK_OP_CREDIT_UPDATE or
> > > > +VIRTIO_VSOCK_OP_CREDIT_REQUEST packets. The dgram sender does not check if
> > > > +the \field{buf_alloc} of the peer is full or not. If it is full, the packet
> > > > +will be dropped. To limit resouce usage of the sender, \field{dgram_tx_bytes}
> > >
> > > s/resouce/resource/
> > >
> > > \field{dgram_tx_bytes} is not included in any struct definition?
> >
> > dgram_tx_bytes is a field in struct vhost_vsock and virtio_vsock. But
> > I don't see them
> > mentioned in the spec.
>
> The VIRTIO specification does not depend on the internals of device
> implementations. Someone reading the spec must be able to implement a
> driver or a device without knowledge of the Linux virtio_vsock or
> vhost_vsock implementations.
>
> If dgram_tx_bytes is a new concept that device implementations must
> incorporate, then please describe it fully in the spec.
>

Sure. Will likely drop this field. Will discuss more at the end of the email.

> >
> > > > +is used for each VM and host. Only payload bytes are counted and header bytes are not
> > >
> > > Please use the VIRTIO specification terms "driver" and "device" instead
> > > of VM and host.
> > Sure.
> >
> > > It's not clear to me what "used" means. What exactly do the driver and
> > > device need to do?
> >
> > In the  Linux and KVM case, I added the dgram_tx_bytes to vhost_vsock
> > and virtio_vsock.
> > Then in virtio_transport_send_pkt() and vhost_transport_send_pkt(),
> > the code will increase and check
> > dgram_tx_bytes first. If dgram_tx_bytes is no less than
> > VIRTIO_VSOCK_MAX_DGRAM_BUF_SIZE,
> > the function will free the pkt with virtio_transport_free_pkt() and
> > then return. The dgram_tx_bytes
> > is decreased in vhost_transport_do_send_pkt, just before each
> > virtio_transport_free_pkt() is called.
> > It is similar for the device case.
> >
> > The goal is to limit the memory usage for the vsock. Since dgram does
> > not use credit, the sender
> > can send far more packets than the receiver can handle. If we don't
> > add the above check, the
> > sender can use lots of memory and cause OOM in the Linux kernel.
> >
> > I am not sure if these details are too much for a spec or not. But I
> > think it will be good to
> > add some description. Or we can just say that the sender ( device or
> > the driver ) must not use
> > unlimited resources.
>
> I'm not sure why this mechanism is needed since the virtqueue has a
> fixed size and the receiver has socket buffers (rcvbuf) of fixed sizes.
> Memory usage is bounded so I don't understand how OOM can occur.
>
> I would have expected the following:
> 1. When sending, drop VIRTIO_VSOCK_OP_RW packets instead of sending if
>    the virtqueue is full.
> 2. When receiving, drop VIRTIO_VSOCK_OP_RW packets if the socket rcvbuf
>    is full.
>
> That's all. No additional accounting mechanism is necessary for
> unreliable delivery.
>

You are right. I checked again and the OOM problem is likely a problem in my
implementation. I will drop this additional accounting.

Following are more
details about my implementation problem. I reused the send_pkt functions
of the stream for datagram too. When a virtqueue is full, the code does not
drop dgram packets, but add it back to the send_pkt_list ( because stream
type does that). I think I should fix that part to drop
the dgram packets instead of adding a new accounting mechanism.
Will give it a try.

> > > > +included. If \field{dgram_tx_bytes} is equal to VIRTIO_VSOCK_MAX_DGRAM_BUF_SIZE,
> > > > +the send will fail.
> > >
> > > Does the device reject dgram packets or does the driver refuse to send
> > > more dgram packets?
> >
> > The sender will drop the packets. This one is independent of the rx
> > side. If the device is the
> > sender, device will drop the packets. If the driver is the sender, the
> > driver will drop the packets.
> >
> > > > +
> > > > +For dgram, since \field{dgram_tx_byte} is shared within a VM or host, a tx_timeout and
> > > > +a timer are used for each outgoing packet. If a packet is not delivered within
> > > > +tx_timeout, it will be dropped to make free space for other dgram sockets.
> > >
> > > What does this mean? Does the timeout cause the device to drop packets
> > > that haven't been handled yet (e.g. read by a host userspace process)?
> >
> > This is on the sender side (regardless of the driver or the device ).
> > This  is similar to
> > above mentioned dgram_tx_bytes. Dgram_tx_bytes only makes sure if the memory
> > usage reaches a limit, the sender will not consume more memory. But
> > dgram_tx_bytes
> > is shared among different dgram sockets for a device or the driver, a
> > misbehave or
> > malicious dgram socket can potentially use all memory and block other
> > dgram sockets.
> > from sending any new packets. To handle this case,
> > the tx_timeout is used to free some space from the sender's memory pool, so that
> > other dgram sockets can continue to send some packets.
>
> Why is the timestamp included in the header? It seems to only be used by
> the side that is sending so it's not obvious to me that it needs to be
> sent to the other side.
>
> How does timestamp ensure fairness? It seems like the malicious sending
> could simple send more packets in order to exhaust all available memory
> again when its old packets expire.
>
Since I will drop the additional accounting, I will probably drop this timestamp
too. Will describe more in the end of the email.

> >
> > > POSIX Sockets have a receive socket buffer (rcvbuf) that is used for
> > > memory accounting and dropping packets. Operating systems implementing
> > > POSIX Sockets would use that to decide when incoming packets are
> > > dropped. It seems like dgram_tx_byte does something similar at the
> > > device level and I'm not sure why it's necessary?
> >
> > dgram_tx_byte is for the tx (sender) side. The receive buffer you mentioned
> > is on the receiving side.
>
> POSIX Sockets have a send socket buffer (sndbuf) for that. The sender
> should use a similar approach to how UDP sockets work.
>
> > Thanks for all the comments. I will fix those spelling errors and use
> > a spell check
> > next time. I hope I answered all your questions. Please let me know if I missed
> > any questions or anything still not clear.
>
> To summarize:
>
> 1. Why is dgram_tx_bytes needed since the virtqueue already has a finite
>    size?

The problem is in my implementation as mentioned above. Will drop this.

>
> 2. Does the timestamp field provide fairness between senders? I don't
>    understand its purpose.
>

The timestamp is associated with my additional accounting. I will drop
this field.

> 3. vsock dgram should probably follow the UDP approach to memory
>    accounting instead of inventing new mechanisms. Applications and
>    developers will probably be happiest with UDP-like behavior.
>

Sure. I checked with UDP briefly. I see SO_SNDBUF, which is per socket.
Also, I found net.ipv4.udp_mem, which is a global value.

After dropping my additional accounting. I think there is still a question
about if we want to protect the shared dgram virtqueue
against bad dgram sockets or not. And if so, how to do it, or what to write
in the spec. For example, if a bad dgram socket keeps sending lots of
data to a port that no socket is receiving,
then those packets will only be dropped by the receiver (device or the
driver), or
when the virtqueue is full. Other good dgram sockets will compete
with this bad one on the tx side. In my current implementation, it
depends on how the Linux scheduler schedules those processes.
The bad one is unlikely to make the virtqueue full all the time and
completely block
other good dgram sockets because the other end is still receiving and
cleaning the virtqueue. But it will waste a lot of resources. I think
that is fine and we don't need to add strict requirements about it
in the spec.

I don't know if UDP has a similar situation as shared virtqueue or not. The
net.ipv4.udp_mem looks like just a global accounting. If you have any
suggestions about this, please let me know.

Thank you!

> Stefan
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
