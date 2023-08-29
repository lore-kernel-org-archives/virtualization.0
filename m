Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1BE35C6FA8F
	for <virtualization@archiver.kernel.org>; Tue, 29 Aug 2023 22:21:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 8C1428204D;
	Tue, 29 Aug 2023 22:21:49 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 8C1428204D
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=DloVnVwG
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id iZO8gORLTa0Z; Tue, 29 Aug 2023 22:21:48 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id B242E8203E;
	Tue, 29 Aug 2023 22:21:47 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org B242E8203E
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 7AE3DC0071;
	Tue, 29 Aug 2023 22:21:47 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E9D90C0032
 for <virtualization@lists.linux-foundation.org>;
 Tue, 29 Aug 2023 22:21:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id C407982040
 for <virtualization@lists.linux-foundation.org>;
 Tue, 29 Aug 2023 22:21:45 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org C407982040
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id VSFANFF0bNio
 for <virtualization@lists.linux-foundation.org>;
 Tue, 29 Aug 2023 22:21:44 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 6988D8203E
 for <virtualization@lists.linux-foundation.org>;
 Tue, 29 Aug 2023 22:21:44 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 6988D8203E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1693347703;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Lu7V0ePLcaShI0tBfiRxcbnlQz+HWlAtwpMfUn9Uxqo=;
 b=DloVnVwGNZdoCjhXvA0LjWNwUs3FQEIKbD8MgN/JXaxgmFtNPxTt9FylNuj/SRWl46P6of
 qAHykbNgttwUwrvxqwhY8L1UxMpjAIirxwtz5sCuVQtkK+uKWLvpbR1/p6cNvfSqk0Bzq4
 cpaWn/Y28zkPlKp4C4Afsi36J6dat4Y=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-597-MtjoBFy-NXi0P1_gsb9wzQ-1; Tue, 29 Aug 2023 18:21:41 -0400
X-MC-Unique: MtjoBFy-NXi0P1_gsb9wzQ-1
Received: by mail-lf1-f69.google.com with SMTP id
 2adb3069b0e04-500c67585acso957186e87.2
 for <virtualization@lists.linux-foundation.org>;
 Tue, 29 Aug 2023 15:21:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693347700; x=1693952500;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Lu7V0ePLcaShI0tBfiRxcbnlQz+HWlAtwpMfUn9Uxqo=;
 b=Qf/PPdcjajzuGIkJbInCSJgR5MvYnFMnwz1wyJjD45hQ+VDL61IcxzPktLy4zK9aX9
 A7d11ZKW4rSjY2GxTLkgO3UInU2VIUPt0lj7eOYXJegq8qy+yQcWm2ulHvWKE7j6dZKT
 CLrpDtUZUS0DoCKcY9oyLcy5kkYKynksMOIUKVCafyGot/PzD9mMoAkbPvOu4iznTTuA
 iZ3lPRKFbqM7ttGQYn1eLOcKfITzWoFio0UaMRzS5vomIQQZupWQNEb9Gbtw2LUAaqhp
 GUifZ44+VERgWcjK3QZyByTCoJ1sqqp2tnhWD9sZ2iLnTOr6SQWqAKDnts5Ou4RpsS5H
 5X+Q==
X-Gm-Message-State: AOJu0YwcW2PDVByS4MpIy39gLQwhv6iC/heljSdf1Exo6yICNT2nxFPy
 Ztxg9y7HVNxw3aLqVv7/ExOD8xTuuA8erTJo03RtzHigsZNRPGRf6ZyBYCg0CuhwegMP2CbBZ2Y
 Ma05JEB/6v/9hq3EVWqPUhJUT7sZZxhCQ5xRV4FAAsQ==
X-Received: by 2002:a05:6512:3113:b0:4f6:3677:54e with SMTP id
 n19-20020a056512311300b004f63677054emr155122lfb.36.1693347700261; 
 Tue, 29 Aug 2023 15:21:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE/X8qmx8ebiElNKKVk8tCX2u7VhtGOVy45JqOvHAtGV9oCr27xjdgHLEYci2c30JOJOzIuJg==
X-Received: by 2002:a05:6512:3113:b0:4f6:3677:54e with SMTP id
 n19-20020a056512311300b004f63677054emr155097lfb.36.1693347699770; 
 Tue, 29 Aug 2023 15:21:39 -0700 (PDT)
Received: from redhat.com ([2.55.167.22]) by smtp.gmail.com with ESMTPSA id
 f2-20020a056402150200b005233609e39dsm6131494edw.30.2023.08.29.15.21.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Aug 2023 15:21:39 -0700 (PDT)
Date: Tue, 29 Aug 2023 18:21:35 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Bobby Eshleman <bobby.eshleman@bytedance.com>
Subject: Re: [PATCH] virtio-vsock: add VIRTIO_VSOCK_F_DGRAM feature bit
Message-ID: <20230829181549-mutt-send-email-mst@kernel.org>
References: <20230829212945.3420727-1-bobby.eshleman@bytedance.com>
MIME-Version: 1.0
In-Reply-To: <20230829212945.3420727-1-bobby.eshleman@bytedance.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: virtio-dev@lists.oasis-open.org, cong.wang@bytedance.com,
 jiang.wang@bytedance.com, bobbyeshleman@gmail.com, cohuck@redhat.com,
 virtualization@lists.linux-foundation.org, stefanha@redhat.com,
 virtio-comment@lists.oasis-open.org, arseny.krasnov@kaspersky.com
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

On Tue, Aug 29, 2023 at 09:29:45PM +0000, Bobby Eshleman wrote:
> This adds support for datagrams to the virtio-vsock device.
> 
> virtio-vsock already supports stream and seqpacket types. The existing
> message types and header fields are extended to support datagrams.
> Semantic differences between the flow types are stated, as well as any
> additional requirements for devices and drivers implementing this
> feature.
> 
> Signed-off-by: Bobby Eshleman <bobby.eshleman@bytedance.com>
> ---
>  device-types/vsock/description.tex | 95 +++++++++++++++++++++++++++---
>  1 file changed, 88 insertions(+), 7 deletions(-)
> 
> diff --git a/device-types/vsock/description.tex b/device-types/vsock/description.tex
> index 7d91d159872f..638dca8e5da1 100644
> --- a/device-types/vsock/description.tex
> +++ b/device-types/vsock/description.tex
> @@ -20,6 +20,7 @@ \subsection{Feature bits}\label{sec:Device Types / Socket Device / Feature bits}
>  \item[VIRTIO_VSOCK_F_STREAM (0)] stream socket type is supported.
>  \item[VIRTIO_VSOCK_F_SEQPACKET (1)] seqpacket socket type is supported.
>  \item[VIRTIO_VSOCK_F_NO_IMPLIED_STREAM (2)] stream socket type is not implied.
> +\item[VIRTIO_VSOCK_F_DGRAM (3)] datagram socket type is supported.
>  \end{description}
>  
>  \drivernormative{\subsubsection}{Feature bits}{Device Types / Socket Device / Feature bits}
> @@ -167,17 +168,22 @@ \subsubsection{Addressing}\label{sec:Device Types / Socket Device / Device Opera
>  consists of a (cid, port number) tuple. The header fields used for this are
>  \field{src_cid}, \field{src_port}, \field{dst_cid}, and \field{dst_port}.
>  
> -Currently stream and seqpacket sockets are supported. \field{type} is 1 (VIRTIO_VSOCK_TYPE_STREAM)
> -for stream socket types, and 2 (VIRTIO_VSOCK_TYPE_SEQPACKET) for seqpacket socket types.
> +
> +Currently stream, seqpacket, and datagram sockets are supported. \field{type} is
> +1 (VIRTIO_VSOCK_TYPE_STREAM) for stream socket types, 2 (VIRTIO_VSOCK_TYPE_SEQPACKET) for
> +seqpacket socket types, and 3 (VIRTIO_VSOCK_TYPE_DGRAM) for datagram socket types.
>  
>  \begin{lstlisting}
>  #define VIRTIO_VSOCK_TYPE_STREAM    1
>  #define VIRTIO_VSOCK_TYPE_SEQPACKET 2
> +#define VIRTIO_VSOCK_TYPE_DGRAM     3
>  \end{lstlisting}
>  
>  Stream sockets provide in-order, guaranteed, connection-oriented delivery
>  without message boundaries. Seqpacket sockets provide in-order, guaranteed,
> -connection-oriented delivery with message and record boundaries.
> +connection-oriented delivery with message and record boundaries. Datagram
> +sockets provide connection-less, best-effort delivery of messages, with no
> +order or reliability guarantees.
>  
>  \subsubsection{Buffer Space Management}\label{sec:Device Types / Socket Device / Device Operation / Buffer Space Management}
>  \field{buf_alloc} and \field{fwd_cnt} are used for buffer space management of
> @@ -203,16 +209,19 @@ \subsubsection{Buffer Space Management}\label{sec:Device Types / Socket Device /
>  previously receiving a VIRTIO_VSOCK_OP_CREDIT_REQUEST packet. This allows
>  communicating updates any time a change in buffer space occurs.
>  
> +\field{buf_alloc} and \field{fwd_cnt} are reserved for future use by datagram
> +sockets. These fields are not used for datagram buffer space management.

no limits on datagram size?

also with no flow control at all there's a performance problem:
imagine queue gets full. now buffers begin to be dropped.
problem is, dropping is faster than delivering to application.
so now application sees its packets consumed super quickly
and starts sending even faster.
not good for performance.

yes datagram expects some way to drop packets but just disabling flow
control completely is not the right thing to do I think.


> +
>  \drivernormative{\paragraph}{Device Operation: Buffer Space Management}{Device Types / Socket Device / Device Operation / Buffer Space Management}
> -VIRTIO_VSOCK_OP_RW data packets MUST only be transmitted when the peer has
> -sufficient free buffer space for the payload.
> +For stream and seqpacket flows, VIRTIO_VSOCK_OP_RW data packets MUST only be
> +transmitted when the peer has sufficient free buffer space for the payload.
>  
>  All packets associated with a stream flow MUST contain valid information in
>  \field{buf_alloc} and \field{fwd_cnt} fields.
>  
>  \devicenormative{\paragraph}{Device Operation: Buffer Space Management}{Device Types / Socket Device / Device Operation / Buffer Space Management}
> -VIRTIO_VSOCK_OP_RW data packets MUST only be transmitted when the peer has
> -sufficient free buffer space for the payload.
> +For stream and seqpacket flows, VIRTIO_VSOCK_OP_RW data packets MUST only be
> +transmitted when the peer has sufficient free buffer space for the payload.
>  
>  All packets associated with a stream flow MUST contain valid information in
>  \field{buf_alloc} and \field{fwd_cnt} fields.
> @@ -299,6 +308,78 @@ \subsubsection{Seqpacket Sockets}\label{sec:Device Types / Socket Device / Devic
>  #define VIRTIO_VSOCK_SEQ_EOR (1 << 1)
>  \end{lstlisting}
>  
> +\subsubsection{Datagram Sockets}\label{sec:Device Types / Socket Device / Device Operation / Datagram Sockets}
> +
> +\drivernormative{\paragraph}{Device Operation: Packet Fragmentation}{Device Types / Socket Device / Datagram Sockets / Fragmentation}
> +
> +Drivers MAY disassemble packets into smaller fragments. If drivers fragment a
> +packet, they MUST follow the fragmentation rules described in section
> +\ref{sec:Device Types / Socket Device / Device Operation / Datagram Sockets / Fragmentation}.
> +
> +Drivers MUST support assembly of received packet fragments according to the
> +fragmentation rules described in section
> +\ref{sec:Device Types / Socket Device / Device Operation / Datagram Sockets / Fragmentation}.
> +
> +\devicenormative{\paragraph}{Device Operation: Packet Fragmentation}{Device Types / Socket Device / Datagram Sockets / Fragmentation}
> +
> +Devices MAY disassemble packets into smaller fragments. If devices fragment a
> +packet, they MUST follow the fragmentation rules described in section
> +\ref{sec:Device Types / Socket Device / Device Operation / Datagram Sockets / Fragmentation}.
> +
> +Devices MUST support assembly of received packet fragments according to the
> +fragmentation rules described in section
> +\ref{sec:Device Types / Socket Device / Device Operation / Datagram Sockets / Fragmentation}.
> +
> +\drivernormative{\paragraph}{Device Operation: Packet Dropping}{Device Types / Socket Device / Datagram Sockets / Dropping}
> +
> +The driver MAY drop received packets with no notification to the device. This
> +can happen if, for example, there are insufficient resources or no socket
> +exists for the destination address.
> +
> +\devicenormative{\paragraph}{Device Operation: Packet Dropping}{Device Types / Socket Device / Datagram Sockets / Dropping}
> +
> +The device MAY drop received packets with no notification to the driver. This
> +can happen if, for example, there are insufficient resources or no socket
> +exists for the destination address.
> +
> +\paragraph{Datagram Fragmentation}\label{sec:Device Types / Socket Device / Device Operation / Datagram Sockets / Fragmentation}
> +
> +\field{flags} may have the following bit set:
> +
> +\begin{lstlisting}
> +#define VIRTIO_VSOCK_DGRAM_EOM (1 << 0)
> +\end{lstlisting}
> +
> +When the header \field{flags} field bit VIRTIO_VSOCK_DGRAM_EOM (bit 0) is set,
> +it indicates that the current payload is the end of a datagram fragment OR that
> +the current payload is an entire datagram packet.
> +
> +Datagram fragmentation is subject to the following rules:
> +
> +The fragments for a datagram packet MUST be added to the virtqueue in
> +sequential order.
> +
> +If a packet is not a fragment, then the VIRTIO_VSOCK_DGRAM_EOM bit (bit 0) of
> +\field{flags} MUST be set.
> +
> +If a packet is the last fragment of a fragment sequence, then the
> +VIRTIO_VSOCK_DGRAM_EOM bit (bit 0) of \field{flags} MUST be set.
> +
> +If a packet is any fragment except the last fragment of a fragment sequence,
> +then the VIRTIO_VSOCK_DGRAM_EOM bit (bit 0) of \field{flags} MUST NOT be set.
> +
> +If a driver or device has already placed a fragment of a packet on the
> +virtqueue, it MUST add the remaining fragments of the packet to the virtqueue
> +before adding any additional packets or fragments to the virtqueue.
> +
> +If fragments for a packet are only partially received after an
> +implementation-specific amount of time, then the destination device or driver
> +MAY drop the fragments.

and how to detect this partial situation?

and if not then what happens?

> +Each buffer containing a fragment MUST begin with a valid struct
> +virtio_vsock_hdr. \field{len} MUST equal the length of the fragment payload
> +only.

what does this mean exactly?

>  \subsubsection{Device Events}\label{sec:Device Types / Socket Device / Device Operation / Device Events}
>  
>  Certain events are communicated by the device to the driver using the event
> -- 
> 2.20.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
