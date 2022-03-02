Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30178C433F5
	for <virtualization@archiver.kernel.org>; Wed,  2 Mar 2022 16:10:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id BF77960F0A;
	Wed,  2 Mar 2022 16:10:17 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id XMnMogk4EEme; Wed,  2 Mar 2022 16:10:16 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 1A37460F00;
	Wed,  2 Mar 2022 16:10:16 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E82F9C0012;
	Wed,  2 Mar 2022 16:10:15 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 17E25C000B
 for <virtualization@lists.linux-foundation.org>;
 Wed,  2 Mar 2022 16:10:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id EA6A64012E
 for <virtualization@lists.linux-foundation.org>;
 Wed,  2 Mar 2022 16:10:13 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Z7wH7kdVP4Bv
 for <virtualization@lists.linux-foundation.org>;
 Wed,  2 Mar 2022 16:10:09 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 22DE340338
 for <virtualization@lists.linux-foundation.org>;
 Wed,  2 Mar 2022 16:10:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1646237407;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=iKE6AnoGP3Aot9xy/kmkgJWY4yjZ3CKjtSDN3mcaSzc=;
 b=hGwJhUp5dx6KVmlLUkFNIIRjD+9lBed5NWvbQhs39azbzIN6DxQzzteCvMng666sTxUn2e
 d1pNPev6Ukyb+bEnFmiVgzrRSaXvZhh3dZ2j/Nb1t650iE6rn38SUBURvXyYSFa35MkTab
 oI96h+jbg0wkgWr3AfabgFBhUtw2W4o=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-610-l8OiSnkvOdio0V-IbEwhxA-1; Wed, 02 Mar 2022 11:10:06 -0500
X-MC-Unique: l8OiSnkvOdio0V-IbEwhxA-1
Received: by mail-wm1-f70.google.com with SMTP id
 10-20020a1c020a000000b0037fae68fcc2so2078443wmc.8
 for <virtualization@lists.linux-foundation.org>;
 Wed, 02 Mar 2022 08:10:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=iKE6AnoGP3Aot9xy/kmkgJWY4yjZ3CKjtSDN3mcaSzc=;
 b=WMOv8t5JeNmqZMHk6BvbPmZ3RH67m9svCyatIdu/N/LXrete5bPFZY9g27ZP/xVL5l
 ulgmpjW6/1tAg8bbXiRO049uCC22oJjcm5bkSJoJAWKk4bizd7W4FYdmL5HNSo9LsdgR
 8uEez6wMjQVR6m6XCMQy2ZrUjY+38c9S3opFUoeyOvjkJMRY9fK0yWiH6qzDVNPgLmCT
 p+DKnRP+wW5Ee4xxeQ1MjWsm2fwtpsNi6knWZgM8V5X64XiynIuoddHj8GWNOjPCi9IS
 6p258hXugFmls1vKV92XORRdf7GIfOCI6S41M+qMF2QVAcgVRo7qQgvmVsf3nHjJKPD6
 vL4Q==
X-Gm-Message-State: AOAM530ocZJP1S/McOQtFWqsfz01uSA9gCWIuUetVjBA9Vswc4yp/c+B
 TAyhRW9lq3Rinyjf8lJsjMy53N2K/i2+5BuSWEXsH3JByDIlpiZbBt1bI4coThlDdbcT5+vWDRD
 BPnLchWlKOaq7pDuLXciLT0wVp8esvsfFNyfyFWsbvA==
X-Received: by 2002:a05:6000:178f:b0:1e6:f1ca:3f96 with SMTP id
 e15-20020a056000178f00b001e6f1ca3f96mr23948020wrg.145.1646237405403; 
 Wed, 02 Mar 2022 08:10:05 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyEPY0Y0RzMMlLZ32IiPpkom1ZZvBUFr7PWwhPkr+LUu5df1umc2sow4FyWFzlNtVK2QnvNbg==
X-Received: by 2002:a05:6000:178f:b0:1e6:f1ca:3f96 with SMTP id
 e15-20020a056000178f00b001e6f1ca3f96mr23948008wrg.145.1646237405131; 
 Wed, 02 Mar 2022 08:10:05 -0800 (PST)
Received: from sgarzare-redhat (host-95-248-229-156.retail.telecomitalia.it.
 [95.248.229.156]) by smtp.gmail.com with ESMTPSA id
 11-20020a05600c26cb00b0037ff53511f2sm5694170wmv.31.2022.03.02.08.10.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 02 Mar 2022 08:10:04 -0800 (PST)
Date: Wed, 2 Mar 2022 17:09:58 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: beshleman.devbox@gmail.com
Subject: Re: [virtio-comment] [PATCH v5 1/2] virtio-vsock: add description
 for datagram type
Message-ID: <20220302160958.62s34i2n2tccsscz@sgarzare-redhat>
References: <20210528040118.3253836-1-jiang.wang@bytedance.com>
 <20220224221547.2436395-1-beshleman.devbox@gmail.com>
 <20220224221547.2436395-2-beshleman.devbox@gmail.com>
MIME-Version: 1.0
In-Reply-To: <20220224221547.2436395-2-beshleman.devbox@gmail.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=sgarzare@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: cong.wang@bytedance.com, duanxiongchun@bytedance.com,
 bobby.eshleman@bytedance.com, jiang.wang@bytedance.com, mst@redhat.com,
 cohuck@redhat.com, virtualization@lists.linux-foundation.org,
 xieyongji@bytedance.com, chaiwen.cc@bytedance.com, stefanha@redhat.com,
 virtio-comment@lists.oasis-open.org, asias@redhat.com,
 arseny.krasnov@kaspersky.com, jhansen@vmware.com
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

Hi Bobby,
Sorry for the delay, but I saw these patches today.
Please, can you keep me in CC?

On Thu, Feb 24, 2022 at 10:15:46PM +0000, beshleman.devbox@gmail.com wrote:
>From: Jiang Wang <jiang.wang@bytedance.com>
>
>Add supports for datagram type for virtio-vsock. Datagram
>sockets are connectionless and unreliable. To avoid contention
>with stream and other sockets, add two more virtqueues and
>a new feature bit to identify if those two new queues exist or not.
>
>Also add descriptions for resource management of datagram, which
>does not use the existing credit update mechanism associated with
>stream sockets.
>
>Signed-off-by: Jiang Wang <jiang.wang@bytedance.com>
>Signed-off-by: Bobby Eshleman <bobby.eshleman@bytedance.com>
>---
>
>V2: Addressed the comments for the previous version.
>V3: Add description for the mergeable receive buffer.
>V4: Add a feature bit for stream and reserver a bit for seqpacket.
>    Fix mrg_rxbuf related sentences.
>V5: Rebase onto head (change to more nicely accompany seqpacket changes).
>    Remove statement about no feature bits being set (already made by seqpacket patches).
>    Clarify \field{type} declaration.
>    Use words "sender/receiver" instead of "tx/rx" for clarity, and other prose changes.
>    Directly state that full buffers result in dropped packets.
>    Change verbs to present tense.
>    Clarify if-else pairs (e.g., "If XYZ is negotiated" is followed by "If XYZ
>    is not negotiated" instead of "Otherwise").
>    Mergeable buffer changes are split off into a separate patch.
>
> virtio-vsock.tex | 63 +++++++++++++++++++++++++++++++++++++++++++++++---------
> 1 file changed, 53 insertions(+), 10 deletions(-)
>
>diff --git a/virtio-vsock.tex b/virtio-vsock.tex
>index d79984d..1a66a1b 100644
>--- a/virtio-vsock.tex
>+++ b/virtio-vsock.tex
>@@ -9,11 +9,26 @@ \subsection{Device ID}\label{sec:Device Types / Socket Device / Device ID}
>
> \subsection{Virtqueues}\label{sec:Device Types / Socket Device / Virtqueues}
> \begin{description}
>-\item[0] rx
>-\item[1] tx
>+\item[0] stream rx
>+\item[1] stream tx
>+\item[2] datagram rx
>+\item[3] datagram tx
>+\item[4] event
>+\end{description}
>+The virtio socket device uses 5 queues if feature bit VIRTIO_VSOCK_F_DRGAM is set. Otherwise, it
>+only uses 3 queues, as the following.

We are also adding a new flag (VIRTIO_VSOCK_F_NO_IMPLIED_STREAM) to
provide the possibility to support for example only dgrams.

So I think we should consider the case where we have only DGRAM queues
(and it will be similar to the stream only case so 3 queues).

Maybe we could describe this part better and say that if we have both
STREAM (or SEQPACKET) and DGRAM set we have 5 queues, otherwise
only 3 queues.

>+
>+\begin{description}
>+\item[0] stream rx
>+\item[1] stream tx
> \item[2] event
> \end{description}
>
>+When behavior differs between stream and datagram rx/tx virtqueues
>+their full names are used. Common behavior is simply described in
>+terms of rx/tx virtqueues and applies to both stream and datagram
>+virtqueues.
>+
> \subsection{Feature bits}\label{sec:Device Types / Socket Device / Feature bits}
>
> If no feature bit is set, only stream socket type is supported.
>@@ -23,6 +38,7 @@ \subsection{Feature bits}\label{sec:Device Types / Socket Device / Feature bits}
> \begin{description}
> \item[VIRTIO_VSOCK_F_STREAM (0)] stream socket type is supported.
> \item[VIRTIO_VSOCK_F_SEQPACKET (1)] seqpacket socket type is supported.
>+\item[VIRTIO_VSOCK_F_DGRAM (2)] datagram socket type is supported.
> \end{description}
>
> \subsection{Device configuration layout}\label{sec:Device Types / Socket Device / Device configuration layout}
>@@ -109,6 +125,9 @@ \subsection{Device Operation}\label{sec:Device Types / Socket Device / Device Op
>
> \subsubsection{Virtqueue Flow Control}\label{sec:Device Types / Socket Device / Device Operation / Virtqueue Flow Control}
>
>+Flow control applies to stream sockets; datagram sockets do not have
>+flow control.
>+
> The tx virtqueue carries packets initiated by applications and replies to
> received packets.  The rx virtqueue carries packets initiated by the device and
> replies to previously transmitted packets.
>@@ -142,18 +161,22 @@ \subsubsection{Addressing}\label{sec:Device Types / Socket Device / Device Opera
> consists of a (cid, port number) tuple. The header fields used for this are
> \field{src_cid}, \field{src_port}, \field{dst_cid}, and \field{dst_port}.
>
>-Currently stream and seqpacket sockets are supported. \field{type} is 1 (VIRTIO_VSOCK_TYPE_STREAM)
>-for stream socket types, and 2 (VIRTIO_VSOCK_TYPE_SEQPACKET) for seqpacket socket types.
>+Currently stream, seqpacket, and dgram sockets are supported. \field{type} is 1 (VIRTIO_VSOCK_TYPE_STREAM)
>+for stream socket types, 2 (VIRTIO_VSOCK_TYPE_SEQPACKET) for seqpacket socket types, and 3 (VIRTIO_VSOCK_TYPE_DGRAM) for dgram socket types.
>
> \begin{lstlisting}
> #define VIRTIO_VSOCK_TYPE_STREAM    1
> #define VIRTIO_VSOCK_TYPE_SEQPACKET 2
>+#define VIRTIO_VSOCK_TYPE_DGRAM     3
> \end{lstlisting}
>
> Stream sockets provide in-order, guaranteed, connection-oriented delivery
> without message boundaries. Seqpacket sockets provide in-order, guaranteed,
> connection-oriented delivery with message and record boundaries.
>
>+Datagram sockets provide unordered, unreliable, connectionless messages
>+with message boundaries and a maximum length.
>+
> \subsubsection{Buffer Space Management}\label{sec:Device Types / Socket Device / Device Operation / Buffer Space Management}
> \field{buf_alloc} and \field{fwd_cnt} are used for buffer space management of
> stream sockets. The guest and the device publish how much buffer space is
>@@ -170,7 +193,7 @@ \subsubsection{Buffer Space Management}\label{sec:Device Types / Socket Device /
> u32 peer_free = peer_buf_alloc - (tx_cnt - peer_fwd_cnt);
> \end{lstlisting}
>
>-If there is insufficient buffer space, the sender waits until virtqueue buffers
>+For stream sockets, if there is insufficient buffer space, the sender waits until virtqueue buffers

stream and seqpacket

> are returned and checks \field{buf_alloc} and \field{fwd_cnt} again. Sending
> the VIRTIO_VSOCK_OP_CREDIT_REQUEST packet queries how much buffer space is
> available. The reply to this query is a VIRTIO_VSOCK_OP_CREDIT_UPDATE packet.
>@@ -178,22 +201,32 @@ \subsubsection{Buffer Space Management}\label{sec:Device Types / Socket Device /
> previously receiving a VIRTIO_VSOCK_OP_CREDIT_REQUEST packet. This allows
> communicating updates any time a change in buffer space occurs.
>
>+Unlike stream sockets, dgram sockets do not use VIRTIO_VSOCK_OP_CREDIT_UPDATE
>+or VIRTIO_VSOCK_OP_CREDIT_REQUEST packets. The dgram buffer management is split
>+into two parts: senders and receivers. For senders, the packet is dropped if the
>+virtqueue is full. For receivers, the packet is dropped if there is no space
>+in the receive buffer.
>+
> \drivernormative{\paragraph}{Device Operation: Buffer Space Management}{Device Types / Socket Device / Device Operation / Buffer Space Management}
>-VIRTIO_VSOCK_OP_RW data packets MUST only be transmitted when the peer has
>-sufficient free buffer space for the payload.
>+For stream sockets, VIRTIO_VSOCK_OP_RW data packets MUST only be transmitted when the peer has

stream and seqpacket

>+sufficient free buffer space for the payload. For dgram sockets, VIRTIO_VSOCK_OP_RW data packets
>+MAY be transmitted when the peer rx buffer is full. Then the packet will be dropped by the peer,
>+and driver will not get any notification.
>
> All packets associated with a stream flow MUST contain valid information in
> \field{buf_alloc} and \field{fwd_cnt} fields.
>
> \devicenormative{\paragraph}{Device Operation: Buffer Space Management}{Device Types / Socket Device / Device Operation / Buffer Space Management}
>-VIRTIO_VSOCK_OP_RW data packets MUST only be transmitted when the peer has
>-sufficient free buffer space for the payload.
>+For stream sockets, VIRTIO_VSOCK_OP_RW data packets MUST only be transmitted when the peer has

stream and seqpacket

>+sufficient free buffer space for the payload. For dgram sockets, VIRTIO_VSOCK_OP_RW data packets
>+MAY be transmitted when the peer rx buffer is full. Then the packet will be dropped by the peer,
>+and the device will not get any notification.
>
> All packets associated with a stream flow MUST contain valid information in
> \field{buf_alloc} and \field{fwd_cnt} fields.
>
> \subsubsection{Receive and Transmit}\label{sec:Device Types / Socket Device / Device Operation / Receive and Transmit}
>-The driver queues outgoing packets on the tx virtqueue and incoming packet
>+The driver queues outgoing packets on the tx virtqueue and allocates incoming packet

Is this change related?

> receive buffers on the rx virtqueue. Packets are of the following form:
>
> \begin{lstlisting}
>@@ -206,6 +239,8 @@ \subsubsection{Receive and Transmit}\label{sec:Device Types / Socket Device / De
> Virtqueue buffers for outgoing packets are read-only. Virtqueue buffers for
> incoming packets are write-only.
>
>+When transmitting packets to the device, \field{num_buffers} is not used.
>+

Leftover? Perhaps it should go in patch 2.

> \drivernormative{\paragraph}{Device Operation: Receive and Transmit}{Device Types / Socket Device / Device Operation / Receive and Transmit}
>
> The \field{guest_cid} configuration field MUST be used as the source CID when
>@@ -274,6 +309,14 @@ \subsubsection{Seqpacket Sockets}\label{sec:Device Types / Socket Device / Devic
> #define VIRTIO_VSOCK_SEQ_EOR (1 << 1)
> \end{lstlisting}
>
>+\subsubsection{Datagram Sockets}\label{sec:Device Types / Socket Device / Device Operation / Datagram Sockets}
>+
>+Datagram (dgram) sockets are connectionless and unreliable. The sender just sends
>+a message to the peer and hopes it will be delivered. A VIRTIO_VSOCK_OP_RST reply is sent if
>+a receiving socket does not exist on the destination.
>+If the transmission or receiving buffers are full, the packets
>+are dropped.
>+

I'm not sure we should respond with RST if there's no socket bind on
the port.

What happens with UDP if we do a sendto to a closed port?

Thanks,
Stefano

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
