Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8754DEB8FA5
	for <virtualization@archiver.kernel.org>; Wed,  6 Sep 2023 08:18:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 08B7F82045;
	Wed,  6 Sep 2023 08:18:16 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 08B7F82045
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=JCPrMkqt
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id JfU9k6mVDZmu; Wed,  6 Sep 2023 08:18:14 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id ECB1C82036;
	Wed,  6 Sep 2023 08:18:13 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org ECB1C82036
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C9F5DC0071;
	Wed,  6 Sep 2023 08:18:13 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D9421C0032
 for <virtualization@lists.linux-foundation.org>;
 Wed,  6 Sep 2023 08:18:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id A71AC82061
 for <virtualization@lists.linux-foundation.org>;
 Wed,  6 Sep 2023 08:18:12 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org A71AC82061
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id aJkTlejCTxQq
 for <virtualization@lists.linux-foundation.org>;
 Wed,  6 Sep 2023 08:18:10 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 5D5FD82051
 for <virtualization@lists.linux-foundation.org>;
 Wed,  6 Sep 2023 08:18:10 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 5D5FD82051
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1693988289;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=EEWHH7s1tqM5Re2X1thPTcUM+yV+Rev1ROiI6AZZKi0=;
 b=JCPrMkqt0eYJO3gAi1gqCsRgre6I2cr4tmn/eaSA7T0MNoAtKIS1jozyzn4+MHELyY7DFu
 EP+4uZwrbO8MfkjWo7ie+ck+yQkyUSzrigCpeo6MXDEXg6li7ah4KMv67FqjPPGq6NOozO
 CNRfD879q3sL/If375GqXYttas9BtFY=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-360-QIK7XmgwOHOBURrOyWg4vA-1; Wed, 06 Sep 2023 04:18:05 -0400
X-MC-Unique: QIK7XmgwOHOBURrOyWg4vA-1
Received: by mail-ej1-f71.google.com with SMTP id
 a640c23a62f3a-9a5952a0b20so278149766b.3
 for <virtualization@lists.linux-foundation.org>;
 Wed, 06 Sep 2023 01:18:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693988284; x=1694593084;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EEWHH7s1tqM5Re2X1thPTcUM+yV+Rev1ROiI6AZZKi0=;
 b=lm41nWt+Acu+jKjMFWlLx3tTVXEUgQymIb/n2V2aZ5xY0y51D2zIL3VV+v4LMgjIKd
 qPYQowo57PgPqgZwwXtqrW+dvP2g7Mf0BxapqOvUbx6Kp1QUZ0nbb+N5STSBPnI+ogUX
 tB3nB2y13kZsnCNG5v/WbG9zmaqPENM1Xkzt7Cd6HpyguGhSxO+hIi9oTrRZ02plx1CD
 yytYxBWTXlKJlIDHAZ1ax1Gob+BwRhFCCXsTYNm3XQ+tIcCId0+eKdKJ2jFoex4uaimQ
 tAbNhm5VmKosDFfN85ALRYvLX83t6TAbOrwswha+XFGWWZCIhAaaCUZgzPf67GjQ+nKA
 Qitw==
X-Gm-Message-State: AOJu0YxTFRxOc7swdh+bxVTb23q+KsINmvGOLZBBASlxYAu6Jp+dxdeR
 dekkhlLTzREdDBIlMJwppaxuJTNLToB9SQcAZPK4WtXsy9yiEktLRbcvuTV1ddO7HWBPIxKfjTo
 1tXfsk2T7zhC87kHAjEvVPQD5IKnVBmWEWAUf1O+opA==
X-Received: by 2002:a17:907:b11:b0:9a5:ed5b:2418 with SMTP id
 h17-20020a1709070b1100b009a5ed5b2418mr1507612ejl.55.1693988284029; 
 Wed, 06 Sep 2023 01:18:04 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG0TCylGxUC7GNlvV2jjSG6jUCdlP8HrEHiV+5Wk9y+cG3aE3mI8cUjxW5EKW051M1JZnAfTQ==
X-Received: by 2002:a17:907:b11:b0:9a5:ed5b:2418 with SMTP id
 h17-20020a1709070b1100b009a5ed5b2418mr1507601ejl.55.1693988283606; 
 Wed, 06 Sep 2023 01:18:03 -0700 (PDT)
Received: from redhat.com ([2.52.23.134]) by smtp.gmail.com with ESMTPSA id
 p20-20020a170906229400b0099bd1a78ef5sm8645192eja.74.2023.09.06.01.18.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 06 Sep 2023 01:18:03 -0700 (PDT)
Date: Wed, 6 Sep 2023 04:17:59 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Bobby Eshleman <bobbyeshleman@gmail.com>
Subject: Re: [PATCH] virtio-vsock: add VIRTIO_VSOCK_F_DGRAM feature bit
Message-ID: <20230906041708-mutt-send-email-mst@kernel.org>
References: <20230829212945.3420727-1-bobby.eshleman@bytedance.com>
 <20230829181549-mutt-send-email-mst@kernel.org>
 <ZO6Ql9iWi6a8vDyU@bullseye>
 <20230901091938-mutt-send-email-mst@kernel.org>
 <ZPK7/84QeSHtYGBQ@bullseye>
 <20230902043532-mutt-send-email-mst@kernel.org>
 <ZPL/Ss6sXmfU/0Mg@bullseye>
MIME-Version: 1.0
In-Reply-To: <ZPL/Ss6sXmfU/0Mg@bullseye>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: virtio-dev@lists.oasis-open.org, cong.wang@bytedance.com,
 Bobby Eshleman <bobby.eshleman@bytedance.com>, jiang.wang@bytedance.com,
 cohuck@redhat.com, virtualization@lists.linux-foundation.org,
 stefanha@redhat.com, virtio-comment@lists.oasis-open.org,
 arseny.krasnov@kaspersky.com
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

On Sat, Sep 02, 2023 at 09:24:26AM +0000, Bobby Eshleman wrote:
> On Sat, Sep 02, 2023 at 04:41:28AM -0400, Michael S. Tsirkin wrote:
> > On Sat, Sep 02, 2023 at 04:37:19AM +0000, Bobby Eshleman wrote:
> > > On Fri, Sep 01, 2023 at 09:31:03AM -0400, Michael S. Tsirkin wrote:
> > > > On Wed, Aug 30, 2023 at 12:43:03AM +0000, Bobby Eshleman wrote:
> > > > > On Tue, Aug 29, 2023 at 06:21:35PM -0400, Michael S. Tsirkin wrote:
> > > > > > On Tue, Aug 29, 2023 at 09:29:45PM +0000, Bobby Eshleman wrote:
> > > > > > > This adds support for datagrams to the virtio-vsock device.
> > > > > > > 
> > > > > > > virtio-vsock already supports stream and seqpacket types. The existing
> > > > > > > message types and header fields are extended to support datagrams.
> > > > > > > Semantic differences between the flow types are stated, as well as any
> > > > > > > additional requirements for devices and drivers implementing this
> > > > > > > feature.
> > > > > > > 
> > > > > > > Signed-off-by: Bobby Eshleman <bobby.eshleman@bytedance.com>
> > > > > > > ---
> > > > > > >  device-types/vsock/description.tex | 95 +++++++++++++++++++++++++++---
> > > > > > >  1 file changed, 88 insertions(+), 7 deletions(-)
> > > > > > > 
> > > > > > > diff --git a/device-types/vsock/description.tex b/device-types/vsock/description.tex
> > > > > > > index 7d91d159872f..638dca8e5da1 100644
> > > > > > > --- a/device-types/vsock/description.tex
> > > > > > > +++ b/device-types/vsock/description.tex
> > > > > > > @@ -20,6 +20,7 @@ \subsection{Feature bits}\label{sec:Device Types / Socket Device / Feature bits}
> > > > > > >  \item[VIRTIO_VSOCK_F_STREAM (0)] stream socket type is supported.
> > > > > > >  \item[VIRTIO_VSOCK_F_SEQPACKET (1)] seqpacket socket type is supported.
> > > > > > >  \item[VIRTIO_VSOCK_F_NO_IMPLIED_STREAM (2)] stream socket type is not implied.
> > > > > > > +\item[VIRTIO_VSOCK_F_DGRAM (3)] datagram socket type is supported.
> > > > > > >  \end{description}
> > > > > > >  
> > > > > > >  \drivernormative{\subsubsection}{Feature bits}{Device Types / Socket Device / Feature bits}
> > > > > > > @@ -167,17 +168,22 @@ \subsubsection{Addressing}\label{sec:Device Types / Socket Device / Device Opera
> > > > > > >  consists of a (cid, port number) tuple. The header fields used for this are
> > > > > > >  \field{src_cid}, \field{src_port}, \field{dst_cid}, and \field{dst_port}.
> > > > > > >  
> > > > > > > -Currently stream and seqpacket sockets are supported. \field{type} is 1 (VIRTIO_VSOCK_TYPE_STREAM)
> > > > > > > -for stream socket types, and 2 (VIRTIO_VSOCK_TYPE_SEQPACKET) for seqpacket socket types.
> > > > > > > +
> > > > > > > +Currently stream, seqpacket, and datagram sockets are supported. \field{type} is
> > > > > > > +1 (VIRTIO_VSOCK_TYPE_STREAM) for stream socket types, 2 (VIRTIO_VSOCK_TYPE_SEQPACKET) for
> > > > > > > +seqpacket socket types, and 3 (VIRTIO_VSOCK_TYPE_DGRAM) for datagram socket types.
> > > > > > >  
> > > > > > >  \begin{lstlisting}
> > > > > > >  #define VIRTIO_VSOCK_TYPE_STREAM    1
> > > > > > >  #define VIRTIO_VSOCK_TYPE_SEQPACKET 2
> > > > > > > +#define VIRTIO_VSOCK_TYPE_DGRAM     3
> > > > > > >  \end{lstlisting}
> > > > > > >  
> > > > > > >  Stream sockets provide in-order, guaranteed, connection-oriented delivery
> > > > > > >  without message boundaries. Seqpacket sockets provide in-order, guaranteed,
> > > > > > > -connection-oriented delivery with message and record boundaries.
> > > > > > > +connection-oriented delivery with message and record boundaries. Datagram
> > > > > > > +sockets provide connection-less, best-effort delivery of messages, with no
> > > > > > > +order or reliability guarantees.
> > > > > > >  
> > > > > > >  \subsubsection{Buffer Space Management}\label{sec:Device Types / Socket Device / Device Operation / Buffer Space Management}
> > > > > > >  \field{buf_alloc} and \field{fwd_cnt} are used for buffer space management of
> > > > > > > @@ -203,16 +209,19 @@ \subsubsection{Buffer Space Management}\label{sec:Device Types / Socket Device /
> > > > > > >  previously receiving a VIRTIO_VSOCK_OP_CREDIT_REQUEST packet. This allows
> > > > > > >  communicating updates any time a change in buffer space occurs.
> > > > > > >  
> > > > > > > +\field{buf_alloc} and \field{fwd_cnt} are reserved for future use by datagram
> > > > > > > +sockets. These fields are not used for datagram buffer space management.
> > > > > > 
> > > > > > no limits on datagram size?
> > > > > > 
> > > > > 
> > > > > In the Linux proof-of-concept, it is 64KB. I can add that here too.
> > > > 
> > > > or device driven maybe ...
> > > > 
> > > 
> > > Ah yes, I think Stefano was suggesting something like Laura's proposal:
> > > https://lists.oasis-open.org/archives/virtio-comment/202206/msg00093.html
> > > 
> > > > > > also with no flow control at all there's a performance problem:
> > > > > > imagine queue gets full. now buffers begin to be dropped.
> > > > > > problem is, dropping is faster than delivering to application.
> > > > > > so now application sees its packets consumed super quickly
> > > > > > and starts sending even faster.
> > > > > > not good for performance.
> > > > > > 
> > > > > > yes datagram expects some way to drop packets but just disabling flow
> > > > > > control completely is not the right thing to do I think.
> > > > > > 
> > > > > 
> > > > > On the LKML I discussed using congestion notification as a way to handle
> > > > > this situation, but deferred it to a future feature bit. I can build
> > > > > it in from the beginning though.
> > > > 
> > > > as in messages to stop/start transmission? might work.
> > > > 
> > > 
> > > Yes, say for example that a flow is sending a large number of packets
> > > and the destination socket's receive queue becomes full. The destination
> > > sends a "stop" message with the destination address. More packets are
> > > likely to continue trailing in, and they may be dropped. The source
> > > device or driver will use the destination address to throttle further
> > > attempts of sockets to transmit to that destination, and the flow will
> > > stop.
> > > 
> > > After the socket's receive queue is no longer full, it may notify the
> > > device/driver which can then send a "start" message with the destination
> > > address to any previously "stopped" sources. The sources can then
> > > reenable flows to that destination.
> > 
> > Ah so control is actually per socket. Another idea is that does not have
> > to be completely full - we can start suppressing a bit before it's full
> > to reduce packet drops.
> > 
> 
> Totally, yes that makes sense.


I don't know how we prevent blocking traffic to unrelated
destinations in this case though.  Do we have to?

> > > 
> > > The other alternative I evaluated was using a single "stop for some
> > > time" message with an exponential or fibonacci backoff with a ceiling,
> > > but the downside is that a congested queue could block the "stop"
> > > message from reaching the source and eventually the source would become
> > > unthrottled even though the destination is *trying* to throttle it. I
> > > think this is bad for some pretty abusable cases, such as creating a
> > > socket that has no receiver. A stop/start message pair doesn't have this
> > > issue.
> > > > > > 
> > > > > > > +
> > > > > > >  \drivernormative{\paragraph}{Device Operation: Buffer Space Management}{Device Types / Socket Device / Device Operation / Buffer Space Management}
> > > > > > > -VIRTIO_VSOCK_OP_RW data packets MUST only be transmitted when the peer has
> > > > > > > -sufficient free buffer space for the payload.
> > > > > > > +For stream and seqpacket flows, VIRTIO_VSOCK_OP_RW data packets MUST only be
> > > > > > > +transmitted when the peer has sufficient free buffer space for the payload.
> > > > > > >  
> > > > > > >  All packets associated with a stream flow MUST contain valid information in
> > > > > > >  \field{buf_alloc} and \field{fwd_cnt} fields.
> > > > > > >  
> > > > > > >  \devicenormative{\paragraph}{Device Operation: Buffer Space Management}{Device Types / Socket Device / Device Operation / Buffer Space Management}
> > > > > > > -VIRTIO_VSOCK_OP_RW data packets MUST only be transmitted when the peer has
> > > > > > > -sufficient free buffer space for the payload.
> > > > > > > +For stream and seqpacket flows, VIRTIO_VSOCK_OP_RW data packets MUST only be
> > > > > > > +transmitted when the peer has sufficient free buffer space for the payload.
> > > > > > >  
> > > > > > >  All packets associated with a stream flow MUST contain valid information in
> > > > > > >  \field{buf_alloc} and \field{fwd_cnt} fields.
> > > > > > > @@ -299,6 +308,78 @@ \subsubsection{Seqpacket Sockets}\label{sec:Device Types / Socket Device / Devic
> > > > > > >  #define VIRTIO_VSOCK_SEQ_EOR (1 << 1)
> > > > > > >  \end{lstlisting}
> > > > > > >  
> > > > > > > +\subsubsection{Datagram Sockets}\label{sec:Device Types / Socket Device / Device Operation / Datagram Sockets}
> > > > > > > +
> > > > > > > +\drivernormative{\paragraph}{Device Operation: Packet Fragmentation}{Device Types / Socket Device / Datagram Sockets / Fragmentation}
> > > > > > > +
> > > > > > > +Drivers MAY disassemble packets into smaller fragments. If drivers fragment a
> > > > > > > +packet, they MUST follow the fragmentation rules described in section
> > > > > > > +\ref{sec:Device Types / Socket Device / Device Operation / Datagram Sockets / Fragmentation}.
> > > > > > > +
> > > > > > > +Drivers MUST support assembly of received packet fragments according to the
> > > > > > > +fragmentation rules described in section
> > > > > > > +\ref{sec:Device Types / Socket Device / Device Operation / Datagram Sockets / Fragmentation}.
> > > > > > > +
> > > > > > > +\devicenormative{\paragraph}{Device Operation: Packet Fragmentation}{Device Types / Socket Device / Datagram Sockets / Fragmentation}
> > > > > > > +
> > > > > > > +Devices MAY disassemble packets into smaller fragments. If devices fragment a
> > > > > > > +packet, they MUST follow the fragmentation rules described in section
> > > > > > > +\ref{sec:Device Types / Socket Device / Device Operation / Datagram Sockets / Fragmentation}.
> > > > > > > +
> > > > > > > +Devices MUST support assembly of received packet fragments according to the
> > > > > > > +fragmentation rules described in section
> > > > > > > +\ref{sec:Device Types / Socket Device / Device Operation / Datagram Sockets / Fragmentation}.
> > > > > > > +
> > > > > > > +\drivernormative{\paragraph}{Device Operation: Packet Dropping}{Device Types / Socket Device / Datagram Sockets / Dropping}
> > > > > > > +
> > > > > > > +The driver MAY drop received packets with no notification to the device. This
> > > > > > > +can happen if, for example, there are insufficient resources or no socket
> > > > > > > +exists for the destination address.
> > > > > > > +
> > > > > > > +\devicenormative{\paragraph}{Device Operation: Packet Dropping}{Device Types / Socket Device / Datagram Sockets / Dropping}
> > > > > > > +
> > > > > > > +The device MAY drop received packets with no notification to the driver. This
> > > > > > > +can happen if, for example, there are insufficient resources or no socket
> > > > > > > +exists for the destination address.
> > > > > > > +
> > > > > > > +\paragraph{Datagram Fragmentation}\label{sec:Device Types / Socket Device / Device Operation / Datagram Sockets / Fragmentation}
> > > > > > > +
> > > > > > > +\field{flags} may have the following bit set:
> > > > > > > +
> > > > > > > +\begin{lstlisting}
> > > > > > > +#define VIRTIO_VSOCK_DGRAM_EOM (1 << 0)
> > > > > > > +\end{lstlisting}
> > > > > > > +
> > > > > > > +When the header \field{flags} field bit VIRTIO_VSOCK_DGRAM_EOM (bit 0) is set,
> > > > > > > +it indicates that the current payload is the end of a datagram fragment OR that
> > > > > > > +the current payload is an entire datagram packet.
> > > > > > > +
> > > > > > > +Datagram fragmentation is subject to the following rules:
> > > > > > > +
> > > > > > > +The fragments for a datagram packet MUST be added to the virtqueue in
> > > > > > > +sequential order.
> > > > > > > +
> > > > > > > +If a packet is not a fragment, then the VIRTIO_VSOCK_DGRAM_EOM bit (bit 0) of
> > > > > > > +\field{flags} MUST be set.
> > > > > > > +
> > > > > > > +If a packet is the last fragment of a fragment sequence, then the
> > > > > > > +VIRTIO_VSOCK_DGRAM_EOM bit (bit 0) of \field{flags} MUST be set.
> > > > > > > +
> > > > > > > +If a packet is any fragment except the last fragment of a fragment sequence,
> > > > > > > +then the VIRTIO_VSOCK_DGRAM_EOM bit (bit 0) of \field{flags} MUST NOT be set.
> > > > > > > +
> > > > > > > +If a driver or device has already placed a fragment of a packet on the
> > > > > > > +virtqueue, it MUST add the remaining fragments of the packet to the virtqueue
> > > > > > > +before adding any additional packets or fragments to the virtqueue.
> > > > > > > +
> > > > > > > +If fragments for a packet are only partially received after an
> > > > > > > +implementation-specific amount of time, then the destination device or driver
> > > > > > > +MAY drop the fragments.
> > > > > > 
> > > > > > and how to detect this partial situation?
> > > > > > 
> > > > > > and if not then what happens?
> > > > > 
> > > > > All packets with EOM=0 should be added into a per-flow fragment list.
> > > > > 
> > > > > Once a packet with EOM=1 is received, they can all be concatenated and
> > > > > delivered to the destination socket.
> > > > > 
> > > > > If after X time no packet with EOM=1 is received, then we have detected
> > > > > this partial situation. The "then what happens part" is that the
> > > > > fragment list can be dropped and freed. Because the peer must send the
> > > > > remaining fragments, they will also be dropped and freed until EOM=1 is
> > > > > received.
> > > > 
> > > > aha. worth mentioning.
> > > > 
> > > > also all the must/may/should really belong in conformance
> > > > sections.
> > > > 
> > > 
> > > Got it, will do.
> > > 
> > > > 
> > > > > > 
> > > > > > > +Each buffer containing a fragment MUST begin with a valid struct
> > > > > > > +virtio_vsock_hdr. \field{len} MUST equal the length of the fragment payload
> > > > > > > +only.
> > > > > > 
> > > > > > what does this mean exactly?
> > > > > > 
> > > > > 
> > > > > It means that len only accounts for the fragment and not the whole
> > > > > (fragmented) packet. The second sentence means that the virtqueue buffer
> > > > > starts with the header.
> > > > > 
> > > > > For virtio-net mergable RX buffers the header is only in the first
> > > > > buffer and the length field accounts for the entire fragmented packet
> > > > > (that spans multiple bufers), so I suspected the specification was
> > > > > needed here too.
> > > > > 
> > > > > I'm happy to omit it.
> > > > > > >  \subsubsection{Device Events}\label{sec:Device Types / Socket Device / Device Operation / Device Events}
> > > > > > >  
> > > > > > >  Certain events are communicated by the device to the driver using the event
> > > > > > > -- 
> > > > > > > 2.20.1
> > > > > > 
> > > > > > _______________________________________________
> > > > > > Virtualization mailing list
> > > > > > Virtualization@lists.linux-foundation.org
> > > > > > https://lists.linuxfoundation.org/mailman/listinfo/virtualization
> > > > 
> > > > _______________________________________________
> > > > Virtualization mailing list
> > > > Virtualization@lists.linux-foundation.org
> > > > https://lists.linuxfoundation.org/mailman/listinfo/virtualization
> > 
> > _______________________________________________
> > Virtualization mailing list
> > Virtualization@lists.linux-foundation.org
> > https://lists.linuxfoundation.org/mailman/listinfo/virtualization

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
