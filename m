Return-Path: <SRS0=nkKT=LC=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DDD1C4743D
	for <virtualization@archiver.kernel.org>; Tue,  8 Jun 2021 13:46:16 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4C5B361040
	for <virtualization@archiver.kernel.org>; Tue,  8 Jun 2021 13:46:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4C5B361040
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 1B1B2400EB;
	Tue,  8 Jun 2021 13:46:16 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id tcaFKoTwFL2q; Tue,  8 Jun 2021 13:46:14 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTP id 3767F400E7;
	Tue,  8 Jun 2021 13:46:14 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 08D24C000B;
	Tue,  8 Jun 2021 13:46:14 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 935EBC0001
 for <virtualization@lists.linux-foundation.org>;
 Tue,  8 Jun 2021 13:46:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 7FFA74045A
 for <virtualization@lists.linux-foundation.org>;
 Tue,  8 Jun 2021 13:46:12 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id a0YOqb2oV5aH
 for <virtualization@lists.linux-foundation.org>;
 Tue,  8 Jun 2021 13:46:10 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 911A340459
 for <virtualization@lists.linux-foundation.org>;
 Tue,  8 Jun 2021 13:46:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1623159969;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=xqwS8sHn3czaB3s37FeIBItY7UZtGm9LrVFJWRBRhVc=;
 b=LG4uQZ1PFS+y+FuTIbUdGhej2RgSFFb3gbTVqn3FadpyS754URGrazmO+Pkv5faVIlImFo
 Kg6IcIfLwtS2MNEl+zhRsLnVYXEVufXxe7sVXtcOjZFhzR8Oz/z7dqfLygcCB2+mj5vXf5
 sHpFxn0fCIgIUJlOmiBKXHaO/upatu8=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-33-wYPxOHqSMV-p-bVF1cLFsg-1; Tue, 08 Jun 2021 09:46:05 -0400
X-MC-Unique: wYPxOHqSMV-p-bVF1cLFsg-1
Received: by mail-ed1-f69.google.com with SMTP id
 z5-20020a05640235c5b0290393974bcf7eso2329104edc.2
 for <virtualization@lists.linux-foundation.org>;
 Tue, 08 Jun 2021 06:46:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=xqwS8sHn3czaB3s37FeIBItY7UZtGm9LrVFJWRBRhVc=;
 b=dlnHObL2WPLDBuZe/BKvZ27efYAkuTc1P+cU16YQJToffT3f4nOnyIo+ddX9y8Dd6x
 teuQwQykwyer6oMPkwJKTzl6SmAJPWhoS1bEk2dHHVIDQKTenN5qXKGrDb647ziT7r/8
 c7ZXoAjAWxj/+KdREIxAUIXDkLhq5IcA+9tAxkF5DKfaNC69PuPwYIH7a8hBfTF1i618
 qrDJNs2AuYPpeU+B2nVtTiG3UVC3ziFQBCJP49iHhOgO94SAKGaRomuwWUrEqprLT+34
 5Vb8p6niYhJhOKOqwVpq1FIXCAskcjahhw5M20SAQVBKDHlYjdVj3aAGL/i/Q4SQwNV6
 urBw==
X-Gm-Message-State: AOAM5324fjgEfO5Bz/Y6VguPM3Jj7BILHSNzYQiMPeE8NJ2Cz80/dnt1
 5ikKwd4zAl6SQMxX3AVcLpxeQkxQriyGXBHO77VsapfJyazIDnqLSmLOv8U2nGNQQzTK9xTgsEq
 CGM+QRUwXM/rEPxMFZ8XzYTyH3I5LGucp7LhkVHFtVA==
X-Received: by 2002:a05:6402:22f3:: with SMTP id
 dn19mr25492401edb.240.1623159964531; 
 Tue, 08 Jun 2021 06:46:04 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzJ4lAMQ2EHnKH7mpRdK0Og2EG1/Ap2u2fUqYzFVcwZrQcA/Saiay8/WHIQ9xWF33a3ADt32Q==
X-Received: by 2002:a05:6402:22f3:: with SMTP id
 dn19mr25492369edb.240.1623159964267; 
 Tue, 08 Jun 2021 06:46:04 -0700 (PDT)
Received: from steredhat (host-79-18-148-79.retail.telecomitalia.it.
 [79.18.148.79])
 by smtp.gmail.com with ESMTPSA id n26sm7825325ejc.27.2021.06.08.06.46.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Jun 2021 06:46:03 -0700 (PDT)
Date: Tue, 8 Jun 2021 15:46:01 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Jiang Wang <jiang.wang@bytedance.com>
Subject: Re: [RFC v4] virtio-vsock: add description for datagram type
Message-ID: <20210608134601.5qs46xdn7bzaob77@steredhat>
References: <20210528040118.3253836-1-jiang.wang@bytedance.com>
MIME-Version: 1.0
In-Reply-To: <20210528040118.3253836-1-jiang.wang@bytedance.com>
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

On Fri, May 28, 2021 at 04:01:18AM +0000, Jiang Wang wrote:
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
>
>V2: addressed the comments for the previous version.
>V3: add description for the mergeable receive buffer.
>V4: add a feature bit for stream and reserver a bit for seqpacket.
>Fix mrg_rxbuf related sentences.
>
> virtio-vsock.tex | 155 ++++++++++++++++++++++++++++++++++++++++++++++++++-----
> 1 file changed, 142 insertions(+), 13 deletions(-)
>
>diff --git a/virtio-vsock.tex b/virtio-vsock.tex
>index da7e641..bacac3c 100644
>--- a/virtio-vsock.tex
>+++ b/virtio-vsock.tex
>@@ -9,14 +9,41 @@ \subsection{Device ID}\label{sec:Device Types / Socket Device / Device ID}
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

Is there a particular reason to always have the event queue as the last 
one?

Maybe it's better to add the datagram queues at the bottom, so the first 
3 queues are always the same.

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
>+\item[VIRTIO_VSOCK_F_STREAM (0)] Device has support for stream socket type.
>+\end{description}
>+
>+\begin{description}
>+\item[VIRTIO_VSOCK_F_DGRAM (2)] Device has support for datagram socket 
>type.
>+\end{description}
>+
>+\begin{description}
>+\item[VIRTIO_VSOCK_F_MRG_RXBUF (3)] Driver can merge receive buffers.
>+\end{description}
>+
>+If no feature bits are defined, then assume only VIRTIO_VSOCK_F_STREAM 
>is set.

I'd say more like socket streams are supported, without reference to the 
feature bit, something like: "If no feature bits are defined, then 
assume device only supports stream socket type."

>
> \subsection{Device configuration layout}\label{sec:Device Types / Socket Device / Device configuration layout}
>
>@@ -64,6 +91,8 @@ \subsection{Device Operation}\label{sec:Device Types / Socket Device / Device Op
>
> Packets transmitted or received contain a header before the payload:
>
>+If feature VIRTIO_VSOCK_F_MRG_RXBUF is not negotiated, use the following header.
>+
> \begin{lstlisting}
> struct virtio_vsock_hdr {
> 	le64 src_cid;
>@@ -79,6 +108,15 @@ \subsection{Device Operation}\label{sec:Device Types / Socket Device / Device Op
> };
> \end{lstlisting}
>
>+If feature VIRTIO_VSOCK_F_MRG_RXBUF is negotiated, use the following header.
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
>@@ -107,6 +145,9 @@ \subsection{Device Operation}\label{sec:Device Types / Socket Device / Device Op
>
> \subsubsection{Virtqueue Flow Control}\label{sec:Device Types / Socket Device / Device Operation / Virtqueue Flow Control}
>
>+Flow control applies to stream sockets; datagram sockets do not have
>+flow control.
>+
> The tx virtqueue carries packets initiated by applications and replies to
> received packets.  The rx virtqueue carries packets initiated by the device and
> replies to previously transmitted packets.
>@@ -140,12 +181,15 @@ \subsubsection{Addressing}\label{sec:Device Types / Socket Device / Device Opera
> consists of a (cid, port number) tuple. The header fields used for this are
> \field{src_cid}, \field{src_port}, \field{dst_cid}, and \field{dst_port}.
>
>-Currently only stream sockets are supported. \field{type} is 1 for 
>stream
>-socket types.
>+Currently stream and datagram (dgram) sockets are supported. \field{type} is 1 for stream
>+socket types. \field{type} is 3 for dgram socket types.

When Arseny's change will merged, we can define and use 
VIRTIO_VSOCK_TYPE_DGRAM,.

>
> Stream sockets provide in-order, guaranteed, connection-oriented 
> delivery
> without message boundaries.
>
>+Datagram sockets provide unordered, unreliable, connectionless 
>messages
>+with message boundaries and a maximum length.
>+
> \subsubsection{Buffer Space Management}\label{sec:Device Types / Socket Device / Device Operation / Buffer Space Management}
> \field{buf_alloc} and \field{fwd_cnt} are used for buffer space 
> management of
> stream sockets. The guest and the device publish how much buffer space is
>@@ -162,7 +206,7 @@ \subsubsection{Buffer Space Management}\label{sec:Device Types / Socket Device /
> u32 peer_free = peer_buf_alloc - (tx_cnt - peer_fwd_cnt);
> \end{lstlisting}
>
>-If there is insufficient buffer space, the sender waits until virtqueue buffers
>+For stream sockets, if there is insufficient buffer space, the sender waits until virtqueue buffers
> are returned and checks \field{buf_alloc} and \field{fwd_cnt} again. Sending
> the VIRTIO_VSOCK_OP_CREDIT_REQUEST packet queries how much buffer space is
> available. The reply to this query is a VIRTIO_VSOCK_OP_CREDIT_UPDATE packet.
>@@ -170,24 +214,55 @@ \subsubsection{Buffer Space Management}\label{sec:Device Types / Socket Device /
> previously receiving a VIRTIO_VSOCK_OP_CREDIT_REQUEST packet. This allows
> communicating updates any time a change in buffer space occurs.
>
>+Unlike stream sockets, dgram sockets do not use VIRTIO_VSOCK_OP_CREDIT_UPDATE or
>+VIRTIO_VSOCK_OP_CREDIT_REQUEST packets. The dgram buffer management
>+is split to two parts: tx side and rx side. For the tx side, if the

Maybe better to use sender and receiver, since we use tx and rx to 
identify the queues.

>+virtqueue is full, the packet will be dropped.
>+For the rx side, dgram also uses the \field{buf_alloc}. If it is full, the packet
>+is dropped by the receiver.

This sentence is a bit unclear.
`buf_alloc` for stream socket is used to inform the other peer about the 
receive buffer space. In this case we are using the local information, 
so there is no need to refer to `buf_alloc`. We can write something 
like: "The packet is dropped by the receiver if there is no space in the 
receive buffer".

>+
>+\drivernormative{\paragraph}{Device Operation: Buffer Space Management}{Device Types / Socket Device / Device Operation / Setting Up Receive Buffers}
>+\begin{itemize}
>+\item If VIRTIO_VSOCK_F_MRG_RXBUF is not negotiated, the driver SHOULD populate the receive queue(s)
>+      with buffers of at least 1526 bytes for stream sockets and 4096 
>bytes for datagram sockets.

Where does 1526 come from?

We're adding a requirement for socket streams that wasn't there until 
now.

>+\item If VIRTIO_VSOCK_F_MRG_RXBUF is negotiated, each buffer MUST be at
>+least the size of the struct virtio_vsock_hdr_mgr_rxbuf.
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
> All packets associated with a stream flow MUST contain valid 
> information in
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
>+If VIRTIO_VSOCK_F_MRG_RXBUF was not negotiated, use the following.

Please use present as in the rest of the document,

> \begin{lstlisting}
> struct virtio_vsock_packet {
>     struct virtio_vsock_hdr hdr;
>@@ -195,24 +270,70 @@ \subsubsection{Receive and Transmit}\label{sec:Device Types / Socket Device / De
> };
> \end{lstlisting}
>
>+Otherwise, use the following form:

Maybe better to repeat:

If VIRTIO_VSOCK_F_MRG_RXBUF is negotiated...

>+\begin{lstlisting}
>+struct virtio_vsock_packet_mrg_rxbuf {
>+    struct virtio_vsock_hdr_mrg_rxbuf hdr;
>+    u8 data[];
>+};
>+\end{lstlisting}
>+
>+
> Virtqueue buffers for outgoing packets are read-only. Virtqueue buffers for
> incoming packets are write-only.
>
>+When transmitting packets to the device, \field{num_buffers} is not 
>used.
>+
>+\begin{enumerate}
>+\item \field{num_buffers} indicates how many descriptors
>+  this packet is spread over (including this one).
>+  This is valid only if VIRTIO_VSOCK_F_MRG_RXBUF was negotiated.
>+  This allows receipt of large packets without having to allocate large
>+  buffers: a packet that does not fit in a single buffer can flow
>+  over to the next buffer, and so on. In this case, there will be
>+  at least \field{num_buffers} used buffers in the virtqueue, and the device
>+  chains them together to form a single packet in a way similar to
>+  how it would store it in a single buffer spread over multiple
>+  descriptors.
>+  The other buffers will not begin with a struct virtio_vsock_hdr.
>+
>+  If VIRTIO_VSOCK_F_MRG_RXBUF was not negotiated, then only one
>+  descriptor is used.
>+
>+\item If
>+  \field{num_buffers} is one, then the entire packet will be
>+  contained within this buffer, immediately following the struct
>+  virtio_vsock_hdr.
>+\end{enumerate}
>+
> \drivernormative{\paragraph}{Device Operation: Receive and 
> Transmit}{Device Types / Socket Device / Device Operation / Receive 
> and Transmit}
>
> The \field{guest_cid} configuration field MUST be used as the source CID when
> sending outgoing packets.
>
>-A VIRTIO_VSOCK_OP_RST reply MUST be sent if a packet is received with an
>+For stream and datagram sockets, A VIRTIO_VSOCK_OP_RST reply MUST be 

Perhaps we can leave it as it was before, since the `type` field 
identifies the socket type itself.

>sent if a packet is received with an
> unknown \field{type} value.
>
> \devicenormative{\paragraph}{Device Operation: Receive and Transmit}{Device Types / Socket Device / Device Operation / Receive and Transmit}
>
> The \field{guest_cid} configuration field MUST NOT contain a reserved CID as listed in \ref{sec:Device Types / Socket Device / Device configuration layout}.
>
>-A VIRTIO_VSOCK_OP_RST reply MUST be sent if a packet is received with an
>+For stream and datagram sockets, A VIRTIO_VSOCK_OP_RST reply MUST be sent if a packet is received with an
> unknown \field{type} value.

Ditto.

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
>@@ -240,6 +361,14 @@ \subsubsection{Stream Sockets}\label{sec:Device Types / Socket Device / Device O
> destination) address tuple for a new connection while the other peer is still
> processing the old connection.
>
>+\subsubsection{Datagram Sockets}\label{sec:Device Types / Socket Device / Device Operation / Datagram Sockets}
>+
>+Datagram (dgram) sockets are connectionless and unreliable. The sender just sends
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

I don't know if maybe it's better to break this patch in two, one where 
we add datagram and one for mergeable buffer.

But let's see what others think.

Thanks,
Stefano

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
