Return-Path: <SRS0=MQJa=KV=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_RED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B75ABC47088
	for <virtualization@archiver.kernel.org>; Wed, 26 May 2021 09:01:12 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 580B2613F6
	for <virtualization@archiver.kernel.org>; Wed, 26 May 2021 09:01:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 580B2613F6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 101E04038B;
	Wed, 26 May 2021 09:01:12 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id yyay6q83SQGL; Wed, 26 May 2021 09:01:10 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTP id 3C8BB40186;
	Wed, 26 May 2021 09:01:10 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 20671C000E;
	Wed, 26 May 2021 09:01:10 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id CB711C0001
 for <virtualization@lists.linux-foundation.org>;
 Wed, 26 May 2021 09:01:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id ABF2783BA5
 for <virtualization@lists.linux-foundation.org>;
 Wed, 26 May 2021 09:01:07 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id hOPSLtRkIlD0
 for <virtualization@lists.linux-foundation.org>;
 Wed, 26 May 2021 09:01:06 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id CB93683B9E
 for <virtualization@lists.linux-foundation.org>;
 Wed, 26 May 2021 09:01:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1622019664;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=FuCAo4muWjb4yYkGBh6i/0U8LNrw4CmtyCedoqYAR5Q=;
 b=MciFF5iXXlbSOtY/6S2zSfm/Qlu0p1pLkSCXEc3qSaHIueC74U8F93CTlxbmpC/SGUw5xf
 tA7G5flaE6ZnoB3aWiF7pxWWiQuWowYxPot9t9780s4rRQ6fVOL5owJiReMk45S37FAyBt
 WSM7xWS4U0mbll6k2+RV78/AinGs76k=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-488-LivDw_6iPeKYs1L1Kh5FvA-1; Wed, 26 May 2021 05:01:01 -0400
X-MC-Unique: LivDw_6iPeKYs1L1Kh5FvA-1
Received: by mail-ed1-f69.google.com with SMTP id
 da10-20020a056402176ab029038f0fea1f51so160418edb.13
 for <virtualization@lists.linux-foundation.org>;
 Wed, 26 May 2021 02:01:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=FuCAo4muWjb4yYkGBh6i/0U8LNrw4CmtyCedoqYAR5Q=;
 b=budShy6hwW8zRKyb0MNHxkelhyIKoH7nHksOjqOd3O5Q0d78srPqtfaDFbZMS6G9tV
 GaemC7LfJE6ri+ZDQ/oqpSL2vVO94KlKOSm8Ukxr+AH4BwARrDbVzJJSioU7EX6ATZjq
 Aqt8P1yqGJGTKaFgmG0CcpXDgW3tVVAosTPTG2+UxL4WRIdfAKOArEkxi1IO3ubJ03GN
 B2gytTpiICB+Lm6USpcquii+DA3ECM+SPMwAlowsliSZBxToKf2Tp1kbP1wicYpexixw
 wr5heHjsmylXlFX7rf+BdjwcX9JQ/P7w5RQwYr3k4Xx7g5srZT7zyudXGiAAww/zhFKn
 vzDQ==
X-Gm-Message-State: AOAM531GBG4LUe0OY0N5KKQ2yztg16oEC3FQksolFz5o+nrC2HAO+bBg
 VGs5xbmkLfw+t5Y7u6By8MollNH70CMmhYo/BQdrSXYFGkv45ARRx+GxpkYVzraAJFxPcxljILZ
 eWl+EiOo1Tqm0ueKNc+OJVICobvR0mO9pRbR/73BLYw==
X-Received: by 2002:a17:906:1496:: with SMTP id
 x22mr33374707ejc.419.1622019660213; 
 Wed, 26 May 2021 02:01:00 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxAIF/gzdTQgskkrR0c1NN5Tk8FWcqm0F7Jlh+MqAYWkgunKG+nDMBxlw5rm+5VZYfoblsEng==
X-Received: by 2002:a17:906:1496:: with SMTP id
 x22mr33374681ejc.419.1622019659891; 
 Wed, 26 May 2021 02:00:59 -0700 (PDT)
Received: from steredhat (host-79-18-148-79.retail.telecomitalia.it.
 [79.18.148.79])
 by smtp.gmail.com with ESMTPSA id y9sm2216341edc.46.2021.05.26.02.00.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 May 2021 02:00:59 -0700 (PDT)
Date: Wed, 26 May 2021 11:00:57 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Jiang Wang <jiang.wang@bytedance.com>
Subject: Re: [RFC v3] virtio-vsock: add description for datagram type
Message-ID: <20210526090057.n3r4tf7cvmlgtiak@steredhat>
References: <20210522234440.2594048-1-jiang.wang@bytedance.com>
MIME-Version: 1.0
In-Reply-To: <20210522234440.2594048-1-jiang.wang@bytedance.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=sgarzare@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: cong.wang@bytedance.com, duanxiongchun@bytedance.com, mst@redhat.com,
 cohuck@redhat.com, virtualization@lists.linux-foundation.org,
 xieyongji@bytedance.com, chaiwen.cc@bytedance.com, stefanha@redhat.com,
 virtio-comment@lists.oasis-open.org, asias@redhat.com,
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

Hi Jiang,
I think we should discuss this changes on 
virtio-comment@lists.oasis-open.org, so I CCed the list.


On Sat, May 22, 2021 at 11:44:40PM +0000, Jiang Wang wrote:
>From: "jiang.wang" <jiang.wang@bytedance.com>
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
>---
>V2: addressed the comments for the previous version.
>V3: add description for the mergeable receive buffer.
>
> virtio-vsock.tex | 137 +++++++++++++++++++++++++++++++++++++++++++++++++------
> 1 file changed, 124 insertions(+), 13 deletions(-)
>
>diff --git a/virtio-vsock.tex b/virtio-vsock.tex
>index da7e641..7eb3596 100644
>--- a/virtio-vsock.tex
>+++ b/virtio-vsock.tex
>@@ -9,14 +9,36 @@ \subsection{Device ID}\label{sec:Device Types / Socket Device / Device ID}
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
>-There are currently no feature bits defined for this device.
>+\begin{description}
>+\item[VIRTIO_VSOCK_F_DGRAM (0)] Device has support for datagram socket type.
>+\end{description}

As suggested by Michael here [1] we should add also a feature bit for 
stream, and maybe is better to reserve bit 0 for it.

Arseny already sent an implementation of SEQPACKET using bit 1 for 
VIRTIO_VSOCK_F_SEQPACKET, so I think we can use bit 2 for DGRAM and bit 
3 for MRG_RXBUF.

[1] 
https://lists.oasis-open.org/archives/virtio-comment/202104/msg00016.html

>+
>+\begin{description}
>+\item[VIRTIO_VSOCK_F_MRG_RXBUF (1)] Driver can merge receive buffers.
>+\end{description}
>+
>
> \subsection{Device configuration layout}\label{sec:Device Types / Socket Device / Device configuration layout}
>
>@@ -64,6 +86,8 @@ \subsection{Device Operation}\label{sec:Device Types / Socket Device / Device Op
>
> Packets transmitted or received contain a header before the payload:
>
>+If feature VIRTIO_VSOCK_F_MRG_RXBUF is not negotiated, use the following header.
>+
> \begin{lstlisting}
> struct virtio_vsock_hdr {
> 	le64 src_cid;
>@@ -79,6 +103,15 @@ \subsection{Device Operation}\label{sec:Device Types / Socket Device / Device Op
> };
> \end{lstlisting}
>
>+If feature VIRTIO_VSOCK_F_MRG_RXBUF is negotianted, use the following header.
>+\begin{lstlisting}
>+struct virtio_vsock_hdr_mrg_rxbuf {
>+	struct virtio_vsock_hdr hdr;
>+	le16 num_buffers;
>+};
>+\end{lstlisting}
>+
>+
> The upper 32 bits of src_cid and dst_cid are reserved and zeroed.
>
> Most packets simply transfer data but control packets are also used for
>@@ -107,6 +140,9 @@ \subsection{Device Operation}\label{sec:Device Types / Socket Device / Device Op
>
> \subsubsection{Virtqueue Flow Control}\label{sec:Device Types / Socket Device / Device Operation / Virtqueue Flow Control}
>
>+Flow control applies to stream sockets; datagram sockets do not have
>+flow control.
>+
> The tx virtqueue carries packets initiated by applications and replies to
> received packets.  The rx virtqueue carries packets initiated by the device and
> replies to previously transmitted packets.
>@@ -140,12 +176,15 @@ \subsubsection{Addressing}\label{sec:Device Types / Socket Device / Device Opera
> consists of a (cid, port number) tuple. The header fields used for this are
> \field{src_cid}, \field{src_port}, \field{dst_cid}, and 
> \field{dst_port}.
>
>-Currently only stream sockets are supported. \field{type} is 1 for stream
>-socket types.
>+Currently stream and datagram (dgram) sockets are supported. \field{type} is 1 for stream
>+socket types. \field{type} is 3 for dgram socket types.
>
> Stream sockets provide in-order, guaranteed, connection-oriented 
> delivery
> without message boundaries.
>
>+Datagram sockets provide unordered, unreliable, connectionless messages
>+with message boundaries and a maximum length.
>+
> \subsubsection{Buffer Space Management}\label{sec:Device Types / Socket Device / Device Operation / Buffer Space Management}
> \field{buf_alloc} and \field{fwd_cnt} are used for buffer space management of
> stream sockets. The guest and the device publish how much buffer space is
>@@ -162,7 +201,7 @@ \subsubsection{Buffer Space Management}\label{sec:Device Types / Socket Device /
> u32 peer_free = peer_buf_alloc - (tx_cnt - peer_fwd_cnt);
> \end{lstlisting}
>
>-If there is insufficient buffer space, the sender waits until 
>virtqueue buffers
>+For stream sockets, if there is insufficient buffer space, the sender waits until virtqueue buffers
> are returned and checks \field{buf_alloc} and \field{fwd_cnt} again. Sending
> the VIRTIO_VSOCK_OP_CREDIT_REQUEST packet queries how much buffer space is
> available. The reply to this query is a VIRTIO_VSOCK_OP_CREDIT_UPDATE 
> packet.
>@@ -170,22 +209,52 @@ \subsubsection{Buffer Space Management}\label{sec:Device Types / Socket Device /
> previously receiving a VIRTIO_VSOCK_OP_CREDIT_REQUEST packet. This allows
> communicating updates any time a change in buffer space occurs.
>
>+Unlike stream sockets, dgram sockets do not use VIRTIO_VSOCK_OP_CREDIT_UPDATE or
>+VIRTIO_VSOCK_OP_CREDIT_REQUEST packets. The dgram buffer management
>+is split to two parts: tx side and rx side. For the tx side, if the
>+virtqueue is full, the packet will be dropped.
>+For the rx side, dgram also uses the \field{buf_alloc}. If it is full, the packet
>+is dropped by the receiver.
>+
>+\drivernormative{\paragraph}{Device Operation: Buffer Space Management}{Device Types / Socket Device / Device Operation / Setting Up Receive Buffers}
>+\begin{itemize}
>+\item If VIRTIO_VSOCK_F_MRG_RXBUF is not negotiated, the driver SHOULD populate the receive queue(s)
>+      with buffers of at least 1526 bytes for stream sockets and 4096 bytes for datagram sockets.
>+\item If VIRTIO_VSOCK_F_MRG_RXBUF is negotiated, each buffer MUST be at
>+least the size of the struct virtio_vsock_hdr.
                                ^
                                Should it be virtio_vsock_hdr_mrg_rxbuf?

>+\end{itemize}
>+
>+\begin{note}
>+Obviously each buffer can be split across multiple descriptor elements.
>+\end{note}
>+
>+\devicenormative{\paragraph}{Device Operation: Buffer Space Management}{Device Types / Socket Device / Device Operation / Setting Up Receive Buffers}
>+The device MUST set \field{num_buffers} to the number of descriptors used when
>+transmitting the  packet.
>+
>+The device MUST use only a single descriptor if 
>VIRTIO_VSOCK_F_MRG_RXBUF
>+is not negotiated.
>+
> \drivernormative{\paragraph}{Device Operation: Buffer Space Management}{Device Types / Socket Device / Device Operation / Buffer Space Management}
>-VIRTIO_VSOCK_OP_RW data packets MUST only be transmitted when the peer has
>-sufficient free buffer space for the payload.
>+For stream sockets, VIRTIO_VSOCK_OP_RW data packets MUST only be transmitted when the peer has
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
>+sufficient free buffer space for the payload. For dgram sockets, VIRTIO_VSOCK_OP_RW data packets
>+MAY be transmitted when the peer rx buffer is full. Then the packet 
>will be dropped by the peer,
>+and the device will not get any notification.
>
> All packets associated with a stream flow MUST contain valid 
> information in
> \field{buf_alloc} and \field{fwd_cnt} fields.
>
> \subsubsection{Receive and Transmit}\label{sec:Device Types / Socket Device / Device Operation / Receive and Transmit}
>-The driver queues outgoing packets on the tx virtqueue and incoming packet
>+The driver queues outgoing packets on the tx virtqueue and allocates incoming packet
> receive buffers on the rx virtqueue. Packets are of the following form:
>
> \begin{lstlisting}
>@@ -198,21 +267,55 @@ \subsubsection{Receive and 
>Transmit}\label{sec:Device Types / Socket Device / De
> Virtqueue buffers for outgoing packets are read-only. Virtqueue 
> buffers for
> incoming packets are write-only.
>
>+When transmitting packets to the device, \field{num_buffers} is not used.

Should we add a new `struct virtio_vsock_packet` description used when 
VIRTIO_VSOCK_F_MRG_RXBUF is negotiated?

>+
>+\begin{enumerate}
>+\item \field{num_buffers} indicates how many descriptors
>+  this packet is spread over (including this one): this will
>+  always be 1 if VIRTIO_VSOCK_F_MRG_RXBUF was not negotiated.

If VIRTIO_VSOCK_F_MRG_RXBUF was not negotiated, we use only 
virtio_vsock_hdr where there isn't `num_buffers`, so it is not clear to 
me this statement.

>+  This allows receipt of large packets without having to allocate large
>+  buffers: a packet that does not fit in a single buffer can flow
>+  over to the next buffer, and so on. In this case, there will be
>+  at least \field{num_buffers} used buffers in the virtqueue, and the device
>+  chains them together to form a single packet in a way similar to
>+  how it would store it in a single buffer spread over multiple
>+  descriptors.
>+  The other buffers will not begin with a struct virtio_vsock_hdr.
>+
>+\item If
>+  \field{num_buffers} is one, then the entire packet will be
>+  contained within this buffer, immediately following the struct
>+  virtio_vsock_hdr.
>+\end{enumerate}
>+
> \drivernormative{\paragraph}{Device Operation: Receive and Transmit}{Device Types / Socket Device / Device Operation / Receive and Transmit}
>
> The \field{guest_cid} configuration field MUST be used as the source CID when
> sending outgoing packets.
>
>-A VIRTIO_VSOCK_OP_RST reply MUST be sent if a packet is received with an
>+For stream and datagram sockets, A VIRTIO_VSOCK_OP_RST reply MUST be sent if a packet is received with an
> unknown \field{type} value.
>
> \devicenormative{\paragraph}{Device Operation: Receive and Transmit}{Device Types / Socket Device / Device Operation / Receive and Transmit}
>
> The \field{guest_cid} configuration field MUST NOT contain a reserved CID as listed in \ref{sec:Device Types / Socket Device / Device configuration layout}.
>
>-A VIRTIO_VSOCK_OP_RST reply MUST be sent if a packet is received with an
>+For stream and datagram sockets, A VIRTIO_VSOCK_OP_RST reply MUST be sent if a packet is received with an
> unknown \field{type} value.
>
>+If VIRTIO_VSOCK_F_MRG_RXBUF has been negotiated, the device MUST set
>+\field{num_buffers} to indicate the number of buffers
>+the packet (including the header) is spread over.
>+
>+If a receive packet is spread over multiple buffers, the device
>+MUST use all buffers but the last (i.e. the first $\field{num_buffers} -
>+1$ buffers) completely up to the full length of each buffer
>+supplied by the driver.
>+
>+The device MUST use all buffers used by a single receive
>+packet together, such that at least \field{num_buffers} are
>+observed by driver as used.
>+
> \subsubsection{Stream Sockets}\label{sec:Device Types / Socket Device / Device Operation / Stream Sockets}
>
> Connections are established by sending a VIRTIO_VSOCK_OP_REQUEST packet. If a
>@@ -240,6 +343,14 @@ \subsubsection{Stream Sockets}\label{sec:Device Types / Socket Device / Device O
> destination) address tuple for a new connection while the other peer is still
> processing the old connection.
>
>+\subsubsection{Datagram Sockets}\label{sec:Device Types / Socket Device / Device Operation / Datagram Sockets}
>+
>+Datagram (dgram) sockets are connectionless and unreliable. The sender 
>just sends
>+a message to the peer and hopes it will be delivered. A VIRTIO_VSOCK_OP_RST reply is sent if
>+a receiving socket does not exist on the destination.
>+If the transmission or receiving buffers are full, the packets
>+are dropped.
>+
> \subsubsection{Device Events}\label{sec:Device Types / Socket Device / Device Operation / Device Events}
>
> Certain events are communicated by the device to the driver using the event
>-- 
>2.11.0
>

Thanks,
Stefano

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
