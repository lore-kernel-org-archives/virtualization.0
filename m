Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E233CA0FEC
	for <virtualization@archiver.kernel.org>; Fri,  1 Sep 2023 12:45:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 256C360D78;
	Fri,  1 Sep 2023 12:45:25 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 256C360D78
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=XzZvw+1i
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id CfXqLpDcjUQl; Fri,  1 Sep 2023 12:45:24 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 68A3260B3B;
	Fri,  1 Sep 2023 12:45:23 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 68A3260B3B
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 416A1C0039;
	Fri,  1 Sep 2023 12:45:23 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 8749AC0032
 for <virtualization@lists.linux-foundation.org>;
 Fri,  1 Sep 2023 12:45:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 4D48860D78
 for <virtualization@lists.linux-foundation.org>;
 Fri,  1 Sep 2023 12:45:22 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 4D48860D78
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id QEzhzNoMBpyW
 for <virtualization@lists.linux-foundation.org>;
 Fri,  1 Sep 2023 12:45:21 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 3845360B3B
 for <virtualization@lists.linux-foundation.org>;
 Fri,  1 Sep 2023 12:45:21 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 3845360B3B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1693572320;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ouXJVZl4mDR5/cEQyxHcnEFyhfSlawc7J6ry03lS/Xk=;
 b=XzZvw+1ikUpzbZXs+JcNAXXpRkPQpMqnEHWZ9rl2tVdRrRaqDKk1/M67sOlQ0Gapv4pSMm
 Kp2XYObGV2c9z5Buqe8zRoiCUD4kAsnCtovcj6Gj3fXSb051vGZGE+aRcOAT50qyvNHBf6
 nVXNELxtrNQmmkmj65LqVDpj2FUtB+Y=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-16-k6Dqq4GWMgex9iX80JaARA-1; Fri, 01 Sep 2023 08:45:18 -0400
X-MC-Unique: k6Dqq4GWMgex9iX80JaARA-1
Received: by mail-ej1-f70.google.com with SMTP id
 a640c23a62f3a-94a355cf318so141518066b.2
 for <virtualization@lists.linux-foundation.org>;
 Fri, 01 Sep 2023 05:45:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693572317; x=1694177117;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ouXJVZl4mDR5/cEQyxHcnEFyhfSlawc7J6ry03lS/Xk=;
 b=NTZCJpanq9aVVrb0INzGlS/II8blN/XggqNOeVms+ktWqgYdvMcsVUi3fIgDEOK3cp
 FmlINnAFdiC7FdddKCccRhQVLxtaYM5JS73VbMw+RUTejY9jH0wjX0alFoeIcSe17oxh
 972eYll8+zyBnpFGzTLW4swOzq94CHSY2TR6mHKytgMGT3ujRxG6ewHwt2U1hNLAXH8U
 BfhP0Mc1MZWIwkvUhDHor5evN7qnCaUMNBLdAIOyGTrj+///33uhqA9jmtW94uxYAqAc
 psdXKfmXca4jItIhvVcFsS91diIhV6lnDRDsIwJpmIwlcajhXSi/JLCIUia7jLGkS/5n
 C2eg==
X-Gm-Message-State: AOJu0YzfR6Mr7DYWfwra25tHzZp5w0got9zkKcrVCOi2WFeLoH7NC3/U
 SExf7yuVnshl6lux4dDzE764HOs+xvMCZmXBsdLPSRgKuQ7980D5QOMfKMoCrM4N/ofqY3wDkLe
 8HyCDAvhAaSV+ZS8C509h8YP+2C5oyBa+Yv6aeKf+5g==
X-Received: by 2002:a17:907:2953:b0:99d:f056:5d6b with SMTP id
 et19-20020a170907295300b0099df0565d6bmr1523518ejc.20.1693572317719; 
 Fri, 01 Sep 2023 05:45:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF6/69QvGdy41KX06nMkkHYkHcfdpDOpRN/548wudGayx2mCpSoCRUaTC9GcwIY8kIBKX+y9A==
X-Received: by 2002:a17:907:2953:b0:99d:f056:5d6b with SMTP id
 et19-20020a170907295300b0099df0565d6bmr1523498ejc.20.1693572317380; 
 Fri, 01 Sep 2023 05:45:17 -0700 (PDT)
Received: from sgarzare-redhat (host-82-57-51-114.retail.telecomitalia.it.
 [82.57.51.114]) by smtp.gmail.com with ESMTPSA id
 lz20-20020a170906fb1400b009929d998abcsm1897247ejb.209.2023.09.01.05.45.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 01 Sep 2023 05:45:16 -0700 (PDT)
Date: Fri, 1 Sep 2023 14:45:14 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Bobby Eshleman <bobby.eshleman@bytedance.com>
Subject: Re: [PATCH] virtio-vsock: add VIRTIO_VSOCK_F_DGRAM feature bit
Message-ID: <h6wtvcglyw55enk6shdogbfnw3m6zbmb4lv65uhznpwzqjw5sc@vc7clkjbxfep>
References: <20230829212945.3420727-1-bobby.eshleman@bytedance.com>
MIME-Version: 1.0
In-Reply-To: <20230829212945.3420727-1-bobby.eshleman@bytedance.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: virtio-dev@lists.oasis-open.org, cong.wang@bytedance.com,
 jiang.wang@bytedance.com, bobbyeshleman@gmail.com, cohuck@redhat.com,
 virtualization@lists.linux-foundation.org, mst@redhat.com, stefanha@redhat.com,
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

On Tue, Aug 29, 2023 at 09:29:45PM +0000, Bobby Eshleman wrote:
>This adds support for datagrams to the virtio-vsock device.
>
>virtio-vsock already supports stream and seqpacket types. The existing
>message types and header fields are extended to support datagrams.
>Semantic differences between the flow types are stated, as well as any
>additional requirements for devices and drivers implementing this
>feature.
>
>Signed-off-by: Bobby Eshleman <bobby.eshleman@bytedance.com>
>---
> device-types/vsock/description.tex | 95 +++++++++++++++++++++++++++---
> 1 file changed, 88 insertions(+), 7 deletions(-)
>
>diff --git a/device-types/vsock/description.tex b/device-types/vsock/description.tex
>index 7d91d159872f..638dca8e5da1 100644
>--- a/device-types/vsock/description.tex
>+++ b/device-types/vsock/description.tex
>@@ -20,6 +20,7 @@ \subsection{Feature bits}\label{sec:Device Types / Socket Device / Feature bits}
> \item[VIRTIO_VSOCK_F_STREAM (0)] stream socket type is supported.
> \item[VIRTIO_VSOCK_F_SEQPACKET (1)] seqpacket socket type is supported.
> \item[VIRTIO_VSOCK_F_NO_IMPLIED_STREAM (2)] stream socket type is not implied.
>+\item[VIRTIO_VSOCK_F_DGRAM (3)] datagram socket type is supported.
> \end{description}
>
> \drivernormative{\subsubsection}{Feature bits}{Device Types / Socket Device / Feature bits}
>@@ -167,17 +168,22 @@ \subsubsection{Addressing}\label{sec:Device Types / Socket Device / Device Opera
> consists of a (cid, port number) tuple. The header fields used for this are
> \field{src_cid}, \field{src_port}, \field{dst_cid}, and \field{dst_port}.
>
>-Currently stream and seqpacket sockets are supported. \field{type} is 1 (VIRTIO_VSOCK_TYPE_STREAM)
>-for stream socket types, and 2 (VIRTIO_VSOCK_TYPE_SEQPACKET) for seqpacket socket types.
>+
>+Currently stream, seqpacket, and datagram sockets are supported. \field{type} is
>+1 (VIRTIO_VSOCK_TYPE_STREAM) for stream socket types, 2 (VIRTIO_VSOCK_TYPE_SEQPACKET) for
>+seqpacket socket types, and 3 (VIRTIO_VSOCK_TYPE_DGRAM) for datagram socket types.
>
> \begin{lstlisting}
> #define VIRTIO_VSOCK_TYPE_STREAM    1
> #define VIRTIO_VSOCK_TYPE_SEQPACKET 2
>+#define VIRTIO_VSOCK_TYPE_DGRAM     3
> \end{lstlisting}
>
> Stream sockets provide in-order, guaranteed, connection-oriented delivery
> without message boundaries. Seqpacket sockets provide in-order, guaranteed,
>-connection-oriented delivery with message and record boundaries.
>+connection-oriented delivery with message and record boundaries. Datagram
>+sockets provide connection-less, best-effort delivery of messages, with no
>+order or reliability guarantees.
>
> \subsubsection{Buffer Space Management}\label{sec:Device Types / Socket Device / Device Operation / Buffer Space Management}
> \field{buf_alloc} and \field{fwd_cnt} are used for buffer space management of
>@@ -203,16 +209,19 @@ \subsubsection{Buffer Space Management}\label{sec:Device Types / Socket Device /
> previously receiving a VIRTIO_VSOCK_OP_CREDIT_REQUEST packet. This allows
> communicating updates any time a change in buffer space occurs.
>
>+\field{buf_alloc} and \field{fwd_cnt} are reserved for future use by datagram
>+sockets. These fields are not used for datagram buffer space management.
>+
> \drivernormative{\paragraph}{Device Operation: Buffer Space Management}{Device Types / Socket Device / Device Operation / Buffer Space Management}
>-VIRTIO_VSOCK_OP_RW data packets MUST only be transmitted when the peer has
>-sufficient free buffer space for the payload.
>+For stream and seqpacket flows, VIRTIO_VSOCK_OP_RW data packets MUST only be
>+transmitted when the peer has sufficient free buffer space for the payload.
>
> All packets associated with a stream flow MUST contain valid information in
> \field{buf_alloc} and \field{fwd_cnt} fields.
>
> \devicenormative{\paragraph}{Device Operation: Buffer Space 
> Management}{Device Types / Socket Device / Device Operation / Buffer 
> Space Management}
>-VIRTIO_VSOCK_OP_RW data packets MUST only be transmitted when the peer has
>-sufficient free buffer space for the payload.
>+For stream and seqpacket flows, VIRTIO_VSOCK_OP_RW data packets MUST only be
>+transmitted when the peer has sufficient free buffer space for the payload.
>
> All packets associated with a stream flow MUST contain valid information in
> \field{buf_alloc} and \field{fwd_cnt} fields.
>@@ -299,6 +308,78 @@ \subsubsection{Seqpacket Sockets}\label{sec:Device Types / Socket Device / Devic
> #define VIRTIO_VSOCK_SEQ_EOR (1 << 1)
> \end{lstlisting}
>
>+\subsubsection{Datagram Sockets}\label{sec:Device Types / Socket Device / Device Operation / Datagram Sockets}
>+
>+\drivernormative{\paragraph}{Device Operation: Packet Fragmentation}{Device Types / Socket Device / Datagram Sockets / Fragmentation}
>+
>+Drivers MAY disassemble packets into smaller fragments. If drivers fragment a
>+packet, they MUST follow the fragmentation rules described in section
>+\ref{sec:Device Types / Socket Device / Device Operation / Datagram Sockets / Fragmentation}.
>+
>+Drivers MUST support assembly of received packet fragments according to the
>+fragmentation rules described in section
>+\ref{sec:Device Types / Socket Device / Device Operation / Datagram 
>Sockets / Fragmentation}.
>+
>+\devicenormative{\paragraph}{Device Operation: Packet Fragmentation}{Device Types / Socket Device / Datagram Sockets / Fragmentation}
>+
>+Devices MAY disassemble packets into smaller fragments. If devices fragment a
>+packet, they MUST follow the fragmentation rules described in section
>+\ref{sec:Device Types / Socket Device / Device Operation / Datagram Sockets / Fragmentation}.
>+
>+Devices MUST support assembly of received packet fragments according to the
>+fragmentation rules described in section
>+\ref{sec:Device Types / Socket Device / Device Operation / Datagram Sockets / Fragmentation}.
>+
>+\drivernormative{\paragraph}{Device Operation: Packet Dropping}{Device Types / Socket Device / Datagram Sockets / Dropping}
>+
>+The driver MAY drop received packets with no notification to the device. This
>+can happen if, for example, there are insufficient resources or no socket
>+exists for the destination address.
>+
>+\devicenormative{\paragraph}{Device Operation: Packet Dropping}{Device Types / Socket Device / Datagram Sockets / Dropping}
>+
>+The device MAY drop received packets with no notification to the driver. This
>+can happen if, for example, there are insufficient resources or no socket
>+exists for the destination address.

Should we provide some notification if the socket does not exist at the
destination?

>+
>+\paragraph{Datagram Fragmentation}\label{sec:Device Types / Socket Device / Device Operation / Datagram Sockets / Fragmentation}
>+
>+\field{flags} may have the following bit set:
>+
>+\begin{lstlisting}
>+#define VIRTIO_VSOCK_DGRAM_EOM (1 << 0)
>+\end{lstlisting}
>+
>+When the header \field{flags} field bit VIRTIO_VSOCK_DGRAM_EOM (bit 0) is set,
>+it indicates that the current payload is the end of a datagram 
>fragment OR that
>+the current payload is an entire datagram packet.

In the destination, if we discard some fragments, then could we
reconstruct a different datagram from the one sent?

Is that anything acceptable?

Thanks,
Stefano

>+
>+Datagram fragmentation is subject to the following rules:
>+
>+The fragments for a datagram packet MUST be added to the virtqueue in
>+sequential order.
>+
>+If a packet is not a fragment, then the VIRTIO_VSOCK_DGRAM_EOM bit (bit 0) of
>+\field{flags} MUST be set.
>+
>+If a packet is the last fragment of a fragment sequence, then the
>+VIRTIO_VSOCK_DGRAM_EOM bit (bit 0) of \field{flags} MUST be set.
>+
>+If a packet is any fragment except the last fragment of a fragment sequence,
>+then the VIRTIO_VSOCK_DGRAM_EOM bit (bit 0) of \field{flags} MUST NOT be set.
>+
>+If a driver or device has already placed a fragment of a packet on the
>+virtqueue, it MUST add the remaining fragments of the packet to the virtqueue
>+before adding any additional packets or fragments to the virtqueue.
>+
>+If fragments for a packet are only partially received after an
>+implementation-specific amount of time, then the destination device or driver
>+MAY drop the fragments.
>+
>+Each buffer containing a fragment MUST begin with a valid struct
>+virtio_vsock_hdr. \field{len} MUST equal the length of the fragment payload
>+only.
>+
> \subsubsection{Device Events}\label{sec:Device Types / Socket Device / Device Operation / Device Events}
>
> Certain events are communicated by the device to the driver using the event
>-- 
>2.20.1
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
