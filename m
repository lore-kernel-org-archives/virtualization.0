Return-Path: <SRS0=l/A6=KW=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CAB5C4707F
	for <virtualization@archiver.kernel.org>; Thu, 27 May 2021 13:21:22 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E3358613DE
	for <virtualization@archiver.kernel.org>; Thu, 27 May 2021 13:21:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E3358613DE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id A5CD1402B1;
	Thu, 27 May 2021 13:21:21 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id cfCc9hhWVhGk; Thu, 27 May 2021 13:21:20 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTP id 6FDA8402A0;
	Thu, 27 May 2021 13:21:19 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 4202EC000D;
	Thu, 27 May 2021 13:21:19 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 2A970C0001
 for <virtualization@lists.linux-foundation.org>;
 Thu, 27 May 2021 13:21:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 08E7F403B3
 for <virtualization@lists.linux-foundation.org>;
 Thu, 27 May 2021 13:21:18 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id d1t4Xmqm6on3
 for <virtualization@lists.linux-foundation.org>;
 Thu, 27 May 2021 13:21:16 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 58322402B1
 for <virtualization@lists.linux-foundation.org>;
 Thu, 27 May 2021 13:21:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1622121675;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=wNLHJZL2dIamuWLHtTmHZcBsatP+mFjiKo5H/D6CdTA=;
 b=CIazcqsMWfW+QmlsFh2AhAiI5zYZLXgbEUc8Rwqh0TtDwSfNoblWBXSIyMH2JkVrJu6oRT
 WeVHFSC0OkirvDfGHXYitfgyXT6dce+81pa0blLjDfbpMpxJuyJjTmo3g5mc/LVmwfSu2Z
 x92sNBtnhvn6RDGpzqSfhoVT6RdK5Iw=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-158-HTgvaVp9OQ-_-HtFzagosg-1; Thu, 27 May 2021 09:21:11 -0400
X-MC-Unique: HTgvaVp9OQ-_-HtFzagosg-1
Received: by mail-ed1-f71.google.com with SMTP id
 y17-20020a0564023591b02903886c26ada4so311515edc.5
 for <virtualization@lists.linux-foundation.org>;
 Thu, 27 May 2021 06:21:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=wNLHJZL2dIamuWLHtTmHZcBsatP+mFjiKo5H/D6CdTA=;
 b=Cw3jexI3FNUSvZbc0DqgsJhm87ErQyvWVl9r9lrPtH96/FoC4/TGFbFFQxbhNZgp0H
 ZzIuY0ztAHEECHXTIdqNZkHHJMXWOiPse65+l+DWsZWfR2zoVk65Js/aaYDkpOmpzSaz
 C7d3aTicpF7PWeFVUnYQw/hC1nwLaE4opqvnZAo028gMFkd+NgTBEeXoQoRtS2BGIv16
 uxxczgc2RtAX+AIaMtBUJ3x/rWb02l1CiT3mlEdm6FlvGaM88tXUhIMF9RgwQeLGYbTJ
 3SPV3b6oPJfdTXr4vhYKInV37f4WrriroJHm1YJrSUR+T+SF23nDpgNSWdAec+EQpX+8
 uWww==
X-Gm-Message-State: AOAM532uXQP2ZV7AeZChpBSlFBZDr5Xn29216v5E3APB42+SQ4VCUECu
 7Mriyr2RQUfwgiwtVeRHvb/wO64kB3+hojb9QMyI/eAn47FPYaDs+TeQsN1MmArOW2hYMYmRarn
 RPfa7j7qI/KfpywTA3dZigy2D3EY1GtH+HMNwe+nxkw==
X-Received: by 2002:a17:906:eb91:: with SMTP id
 mh17mr847490ejb.217.1622121670304; 
 Thu, 27 May 2021 06:21:10 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxEczDeXbuIqHaOW0EXCtVzbe2NliqslE6CwCFsyBf+7cb6NbgDMKbciKfetwBmRXqJfKvKGA==
X-Received: by 2002:a17:906:eb91:: with SMTP id
 mh17mr847468ejb.217.1622121670097; 
 Thu, 27 May 2021 06:21:10 -0700 (PDT)
Received: from steredhat (host-79-18-148-79.retail.telecomitalia.it.
 [79.18.148.79])
 by smtp.gmail.com with ESMTPSA id a7sm1073386edr.15.2021.05.27.06.21.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 May 2021 06:21:09 -0700 (PDT)
Date: Thu, 27 May 2021 15:21:06 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Jiang Wang <jiang.wang@bytedance.com>
Subject: Re: [virtio-comment] [RFC v3] virtio-vsock: add description for
 datagram type
Message-ID: <20210527132106.ovwbecznb6knrhig@steredhat>
References: <20210526175035.1873294-1-jiang.wang@bytedance.com>
MIME-Version: 1.0
In-Reply-To: <20210526175035.1873294-1-jiang.wang@bytedance.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=sgarzare@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: cong.wang@bytedance.com, duanxiongchun@bytedance.com, mst@redhat.com,
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

Re-send my thoughts on this new series...

On Wed, May 26, 2021 at 05:50:35PM +0000, Jiang Wang wrote:
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
>btw: send the same patch again to include virtio-comment@
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
> \field{src_cid}, \field{src_port}, \field{dst_cid}, and \field{dst_port}.
>
>-Currently only stream sockets are supported. \field{type} is 1 for stream
>-socket types.
>+Currently stream and datagram (dgram) sockets are supported. \field{type} is 1 for stream
>+socket types. \field{type} is 3 for dgram socket types.
>
> Stream sockets provide in-order, guaranteed, connection-oriented delivery
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
>-If there is insufficient buffer space, the sender waits until virtqueue buffers
>+For stream sockets, if there is insufficient buffer space, the sender waits until virtqueue buffers
> are returned and checks \field{buf_alloc} and \field{fwd_cnt} again. Sending
> the VIRTIO_VSOCK_OP_CREDIT_REQUEST packet queries how much buffer space is
> available. The reply to this query is a VIRTIO_VSOCK_OP_CREDIT_UPDATE packet.
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
>+The device MUST use only a single descriptor if VIRTIO_VSOCK_F_MRG_RXBUF
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
>+MAY be transmitted when the peer rx buffer is full. Then the packet will be dropped by the peer,
>+and the device will not get any notification.
>
> All packets associated with a stream flow MUST contain valid information in
> \field{buf_alloc} and \field{fwd_cnt} fields.
>
> \subsubsection{Receive and Transmit}\label{sec:Device Types / Socket Device / Device Operation / Receive and Transmit}
>-The driver queues outgoing packets on the tx virtqueue and incoming packet
>+The driver queues outgoing packets on the tx virtqueue and allocates incoming packet
> receive buffers on the rx virtqueue. Packets are of the following form:
>
> \begin{lstlisting}
>@@ -198,21 +267,55 @@ \subsubsection{Receive and Transmit}\label{sec:Device Types / Socket Device / De
> Virtqueue buffers for outgoing packets are read-only. Virtqueue buffers for
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

Thanks,
Stefano

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
