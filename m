Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B80FCA0FE6
	for <virtualization@archiver.kernel.org>; Fri,  1 Sep 2023 13:31:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id CE08160B01;
	Fri,  1 Sep 2023 13:31:18 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org CE08160B01
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=cwvBbnnP
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id oE1vCA4y4mWP; Fri,  1 Sep 2023 13:31:17 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id D952C60AE6;
	Fri,  1 Sep 2023 13:31:16 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org D952C60AE6
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A8EBEC0071;
	Fri,  1 Sep 2023 13:31:16 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 383DCC0032
 for <virtualization@lists.linux-foundation.org>;
 Fri,  1 Sep 2023 13:31:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 0C4B340A38
 for <virtualization@lists.linux-foundation.org>;
 Fri,  1 Sep 2023 13:31:15 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 0C4B340A38
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=cwvBbnnP
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Dhzl7CXfstgx
 for <virtualization@lists.linux-foundation.org>;
 Fri,  1 Sep 2023 13:31:12 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id AC4E941963
 for <virtualization@lists.linux-foundation.org>;
 Fri,  1 Sep 2023 13:31:12 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org AC4E941963
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1693575071;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=BXyHGh3Rjg686bZVAQcRsKrfRjARZ47LdD6WNAEPvaM=;
 b=cwvBbnnPP0odGNnz7G4bDk+AF7464II+ceD3Xf5Fcyhgse5UQoKDv/qoUBbjaOS1izRKLI
 Lr3ls9pGODxOtpWVzwHCRcNz0Qipzx3u/CAKyuvq1U2A84dYG6ESJEH/DDlsIvmtAU/Iey
 nrOdOnY7nkCQ4aMp/oPUQrMxRJaHIvI=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-192-k-MJ0TRyOJaa5rHO7e8Gag-1; Fri, 01 Sep 2023 09:31:09 -0400
X-MC-Unique: k-MJ0TRyOJaa5rHO7e8Gag-1
Received: by mail-ed1-f71.google.com with SMTP id
 4fb4d7f45d1cf-52a398d8a51so1555281a12.0
 for <virtualization@lists.linux-foundation.org>;
 Fri, 01 Sep 2023 06:31:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693575069; x=1694179869;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BXyHGh3Rjg686bZVAQcRsKrfRjARZ47LdD6WNAEPvaM=;
 b=gjHnG90gDIDqoUW2M9K4yS/XselXzKMyZQYClK98CNhNbnewji+KpKRP/OECUHVZkp
 J7Hh4gLVnG2VzBSdcVddX86sMLxd/1S62SEf/TTW7ILFrWBYiJC7GfQKck68AfGxuR46
 gBOInOVK1+5j6VjDQD7ERo6qKqtCTH0ztfVTjoaHYZAoCa9Qj8c/4u5dZL5HGCRW52no
 JKrHujhxDcxMFub7aNgwofRCdum+5oQg7HWHvM049V1fYBZAYJmFpJEb5Ml+W/25inbd
 J1mKnpcpqWPDEsqG7c2eZT5cME9SImbPWZfHpwbjLhiepvZMY8ZkHlKZOHXaPEPfBFTS
 KRxQ==
X-Gm-Message-State: AOJu0YzjF4eM+yT39RwVC9UK9QqYKM0//ZdQ1WfS7Q5Hlb60/duZL0Qs
 pAfrouTzx2SNVV7i53vUZNfBiPEYS2K0q2BYVFD+3vgK+tOoeAaYoPEQWg9JOf9lEZVGVVyHAvf
 ZfUtpQGuIWabtjwuzhi9pxm+12ZC/hikmBL3iAXEDdA==
X-Received: by 2002:aa7:c384:0:b0:523:ae0a:a446 with SMTP id
 k4-20020aa7c384000000b00523ae0aa446mr2334347edq.24.1693575068743; 
 Fri, 01 Sep 2023 06:31:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGLY0tuJD1WJszpQXunFN8M70befbfcgwb4jxN7POX5O8sDZD2N9Q1Iz55vPWyrafJeemXUbg==
X-Received: by 2002:aa7:c384:0:b0:523:ae0a:a446 with SMTP id
 k4-20020aa7c384000000b00523ae0aa446mr2334319edq.24.1693575068386; 
 Fri, 01 Sep 2023 06:31:08 -0700 (PDT)
Received: from redhat.com ([2.55.167.22]) by smtp.gmail.com with ESMTPSA id
 q6-20020aa7da86000000b0052a063e52b8sm2032710eds.83.2023.09.01.06.31.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 01 Sep 2023 06:31:07 -0700 (PDT)
Date: Fri, 1 Sep 2023 09:31:03 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Bobby Eshleman <bobbyeshleman@gmail.com>
Subject: Re: [PATCH] virtio-vsock: add VIRTIO_VSOCK_F_DGRAM feature bit
Message-ID: <20230901091938-mutt-send-email-mst@kernel.org>
References: <20230829212945.3420727-1-bobby.eshleman@bytedance.com>
 <20230829181549-mutt-send-email-mst@kernel.org>
 <ZO6Ql9iWi6a8vDyU@bullseye>
MIME-Version: 1.0
In-Reply-To: <ZO6Ql9iWi6a8vDyU@bullseye>
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

On Wed, Aug 30, 2023 at 12:43:03AM +0000, Bobby Eshleman wrote:
> On Tue, Aug 29, 2023 at 06:21:35PM -0400, Michael S. Tsirkin wrote:
> > On Tue, Aug 29, 2023 at 09:29:45PM +0000, Bobby Eshleman wrote:
> > > This adds support for datagrams to the virtio-vsock device.
> > > 
> > > virtio-vsock already supports stream and seqpacket types. The existing
> > > message types and header fields are extended to support datagrams.
> > > Semantic differences between the flow types are stated, as well as any
> > > additional requirements for devices and drivers implementing this
> > > feature.
> > > 
> > > Signed-off-by: Bobby Eshleman <bobby.eshleman@bytedance.com>
> > > ---
> > >  device-types/vsock/description.tex | 95 +++++++++++++++++++++++++++---
> > >  1 file changed, 88 insertions(+), 7 deletions(-)
> > > 
> > > diff --git a/device-types/vsock/description.tex b/device-types/vsock/description.tex
> > > index 7d91d159872f..638dca8e5da1 100644
> > > --- a/device-types/vsock/description.tex
> > > +++ b/device-types/vsock/description.tex
> > > @@ -20,6 +20,7 @@ \subsection{Feature bits}\label{sec:Device Types / Socket Device / Feature bits}
> > >  \item[VIRTIO_VSOCK_F_STREAM (0)] stream socket type is supported.
> > >  \item[VIRTIO_VSOCK_F_SEQPACKET (1)] seqpacket socket type is supported.
> > >  \item[VIRTIO_VSOCK_F_NO_IMPLIED_STREAM (2)] stream socket type is not implied.
> > > +\item[VIRTIO_VSOCK_F_DGRAM (3)] datagram socket type is supported.
> > >  \end{description}
> > >  
> > >  \drivernormative{\subsubsection}{Feature bits}{Device Types / Socket Device / Feature bits}
> > > @@ -167,17 +168,22 @@ \subsubsection{Addressing}\label{sec:Device Types / Socket Device / Device Opera
> > >  consists of a (cid, port number) tuple. The header fields used for this are
> > >  \field{src_cid}, \field{src_port}, \field{dst_cid}, and \field{dst_port}.
> > >  
> > > -Currently stream and seqpacket sockets are supported. \field{type} is 1 (VIRTIO_VSOCK_TYPE_STREAM)
> > > -for stream socket types, and 2 (VIRTIO_VSOCK_TYPE_SEQPACKET) for seqpacket socket types.
> > > +
> > > +Currently stream, seqpacket, and datagram sockets are supported. \field{type} is
> > > +1 (VIRTIO_VSOCK_TYPE_STREAM) for stream socket types, 2 (VIRTIO_VSOCK_TYPE_SEQPACKET) for
> > > +seqpacket socket types, and 3 (VIRTIO_VSOCK_TYPE_DGRAM) for datagram socket types.
> > >  
> > >  \begin{lstlisting}
> > >  #define VIRTIO_VSOCK_TYPE_STREAM    1
> > >  #define VIRTIO_VSOCK_TYPE_SEQPACKET 2
> > > +#define VIRTIO_VSOCK_TYPE_DGRAM     3
> > >  \end{lstlisting}
> > >  
> > >  Stream sockets provide in-order, guaranteed, connection-oriented delivery
> > >  without message boundaries. Seqpacket sockets provide in-order, guaranteed,
> > > -connection-oriented delivery with message and record boundaries.
> > > +connection-oriented delivery with message and record boundaries. Datagram
> > > +sockets provide connection-less, best-effort delivery of messages, with no
> > > +order or reliability guarantees.
> > >  
> > >  \subsubsection{Buffer Space Management}\label{sec:Device Types / Socket Device / Device Operation / Buffer Space Management}
> > >  \field{buf_alloc} and \field{fwd_cnt} are used for buffer space management of
> > > @@ -203,16 +209,19 @@ \subsubsection{Buffer Space Management}\label{sec:Device Types / Socket Device /
> > >  previously receiving a VIRTIO_VSOCK_OP_CREDIT_REQUEST packet. This allows
> > >  communicating updates any time a change in buffer space occurs.
> > >  
> > > +\field{buf_alloc} and \field{fwd_cnt} are reserved for future use by datagram
> > > +sockets. These fields are not used for datagram buffer space management.
> > 
> > no limits on datagram size?
> > 
> 
> In the Linux proof-of-concept, it is 64KB. I can add that here too.

or device driven maybe ...

> > also with no flow control at all there's a performance problem:
> > imagine queue gets full. now buffers begin to be dropped.
> > problem is, dropping is faster than delivering to application.
> > so now application sees its packets consumed super quickly
> > and starts sending even faster.
> > not good for performance.
> > 
> > yes datagram expects some way to drop packets but just disabling flow
> > control completely is not the right thing to do I think.
> > 
> 
> On the LKML I discussed using congestion notification as a way to handle
> this situation, but deferred it to a future feature bit. I can build
> it in from the beginning though.

as in messages to stop/start transmission? might work.

> > 
> > > +
> > >  \drivernormative{\paragraph}{Device Operation: Buffer Space Management}{Device Types / Socket Device / Device Operation / Buffer Space Management}
> > > -VIRTIO_VSOCK_OP_RW data packets MUST only be transmitted when the peer has
> > > -sufficient free buffer space for the payload.
> > > +For stream and seqpacket flows, VIRTIO_VSOCK_OP_RW data packets MUST only be
> > > +transmitted when the peer has sufficient free buffer space for the payload.
> > >  
> > >  All packets associated with a stream flow MUST contain valid information in
> > >  \field{buf_alloc} and \field{fwd_cnt} fields.
> > >  
> > >  \devicenormative{\paragraph}{Device Operation: Buffer Space Management}{Device Types / Socket Device / Device Operation / Buffer Space Management}
> > > -VIRTIO_VSOCK_OP_RW data packets MUST only be transmitted when the peer has
> > > -sufficient free buffer space for the payload.
> > > +For stream and seqpacket flows, VIRTIO_VSOCK_OP_RW data packets MUST only be
> > > +transmitted when the peer has sufficient free buffer space for the payload.
> > >  
> > >  All packets associated with a stream flow MUST contain valid information in
> > >  \field{buf_alloc} and \field{fwd_cnt} fields.
> > > @@ -299,6 +308,78 @@ \subsubsection{Seqpacket Sockets}\label{sec:Device Types / Socket Device / Devic
> > >  #define VIRTIO_VSOCK_SEQ_EOR (1 << 1)
> > >  \end{lstlisting}
> > >  
> > > +\subsubsection{Datagram Sockets}\label{sec:Device Types / Socket Device / Device Operation / Datagram Sockets}
> > > +
> > > +\drivernormative{\paragraph}{Device Operation: Packet Fragmentation}{Device Types / Socket Device / Datagram Sockets / Fragmentation}
> > > +
> > > +Drivers MAY disassemble packets into smaller fragments. If drivers fragment a
> > > +packet, they MUST follow the fragmentation rules described in section
> > > +\ref{sec:Device Types / Socket Device / Device Operation / Datagram Sockets / Fragmentation}.
> > > +
> > > +Drivers MUST support assembly of received packet fragments according to the
> > > +fragmentation rules described in section
> > > +\ref{sec:Device Types / Socket Device / Device Operation / Datagram Sockets / Fragmentation}.
> > > +
> > > +\devicenormative{\paragraph}{Device Operation: Packet Fragmentation}{Device Types / Socket Device / Datagram Sockets / Fragmentation}
> > > +
> > > +Devices MAY disassemble packets into smaller fragments. If devices fragment a
> > > +packet, they MUST follow the fragmentation rules described in section
> > > +\ref{sec:Device Types / Socket Device / Device Operation / Datagram Sockets / Fragmentation}.
> > > +
> > > +Devices MUST support assembly of received packet fragments according to the
> > > +fragmentation rules described in section
> > > +\ref{sec:Device Types / Socket Device / Device Operation / Datagram Sockets / Fragmentation}.
> > > +
> > > +\drivernormative{\paragraph}{Device Operation: Packet Dropping}{Device Types / Socket Device / Datagram Sockets / Dropping}
> > > +
> > > +The driver MAY drop received packets with no notification to the device. This
> > > +can happen if, for example, there are insufficient resources or no socket
> > > +exists for the destination address.
> > > +
> > > +\devicenormative{\paragraph}{Device Operation: Packet Dropping}{Device Types / Socket Device / Datagram Sockets / Dropping}
> > > +
> > > +The device MAY drop received packets with no notification to the driver. This
> > > +can happen if, for example, there are insufficient resources or no socket
> > > +exists for the destination address.
> > > +
> > > +\paragraph{Datagram Fragmentation}\label{sec:Device Types / Socket Device / Device Operation / Datagram Sockets / Fragmentation}
> > > +
> > > +\field{flags} may have the following bit set:
> > > +
> > > +\begin{lstlisting}
> > > +#define VIRTIO_VSOCK_DGRAM_EOM (1 << 0)
> > > +\end{lstlisting}
> > > +
> > > +When the header \field{flags} field bit VIRTIO_VSOCK_DGRAM_EOM (bit 0) is set,
> > > +it indicates that the current payload is the end of a datagram fragment OR that
> > > +the current payload is an entire datagram packet.
> > > +
> > > +Datagram fragmentation is subject to the following rules:
> > > +
> > > +The fragments for a datagram packet MUST be added to the virtqueue in
> > > +sequential order.
> > > +
> > > +If a packet is not a fragment, then the VIRTIO_VSOCK_DGRAM_EOM bit (bit 0) of
> > > +\field{flags} MUST be set.
> > > +
> > > +If a packet is the last fragment of a fragment sequence, then the
> > > +VIRTIO_VSOCK_DGRAM_EOM bit (bit 0) of \field{flags} MUST be set.
> > > +
> > > +If a packet is any fragment except the last fragment of a fragment sequence,
> > > +then the VIRTIO_VSOCK_DGRAM_EOM bit (bit 0) of \field{flags} MUST NOT be set.
> > > +
> > > +If a driver or device has already placed a fragment of a packet on the
> > > +virtqueue, it MUST add the remaining fragments of the packet to the virtqueue
> > > +before adding any additional packets or fragments to the virtqueue.
> > > +
> > > +If fragments for a packet are only partially received after an
> > > +implementation-specific amount of time, then the destination device or driver
> > > +MAY drop the fragments.
> > 
> > and how to detect this partial situation?
> > 
> > and if not then what happens?
> 
> All packets with EOM=0 should be added into a per-flow fragment list.
> 
> Once a packet with EOM=1 is received, they can all be concatenated and
> delivered to the destination socket.
> 
> If after X time no packet with EOM=1 is received, then we have detected
> this partial situation. The "then what happens part" is that the
> fragment list can be dropped and freed. Because the peer must send the
> remaining fragments, they will also be dropped and freed until EOM=1 is
> received.

aha. worth mentioning.

also all the must/may/should really belong in conformance
sections.


> > 
> > > +Each buffer containing a fragment MUST begin with a valid struct
> > > +virtio_vsock_hdr. \field{len} MUST equal the length of the fragment payload
> > > +only.
> > 
> > what does this mean exactly?
> > 
> 
> It means that len only accounts for the fragment and not the whole
> (fragmented) packet. The second sentence means that the virtqueue buffer
> starts with the header.
> 
> For virtio-net mergable RX buffers the header is only in the first
> buffer and the length field accounts for the entire fragmented packet
> (that spans multiple bufers), so I suspected the specification was
> needed here too.
> 
> I'm happy to omit it.
> > >  \subsubsection{Device Events}\label{sec:Device Types / Socket Device / Device Operation / Device Events}
> > >  
> > >  Certain events are communicated by the device to the driver using the event
> > > -- 
> > > 2.20.1
> > 
> > _______________________________________________
> > Virtualization mailing list
> > Virtualization@lists.linux-foundation.org
> > https://lists.linuxfoundation.org/mailman/listinfo/virtualization

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
