Return-Path: <SRS0=MQJa=KV=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_RED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E3F0C47088
	for <virtualization@archiver.kernel.org>; Wed, 26 May 2021 17:51:34 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9240A60FF0
	for <virtualization@archiver.kernel.org>; Wed, 26 May 2021 17:51:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9240A60FF0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=bytedance.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 4B3ED40175;
	Wed, 26 May 2021 17:51:33 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id WCSHQTDShAAe; Wed, 26 May 2021 17:51:32 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTP id 47FD040113;
	Wed, 26 May 2021 17:51:31 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 20B61C000D;
	Wed, 26 May 2021 17:51:31 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 056ACC0001
 for <virtualization@lists.linux-foundation.org>;
 Wed, 26 May 2021 17:51:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 005B66077C
 for <virtualization@lists.linux-foundation.org>;
 Wed, 26 May 2021 17:51:30 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=bytedance-com.20150623.gappssmtp.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id TIrxCQhN3RoV
 for <virtualization@lists.linux-foundation.org>;
 Wed, 26 May 2021 17:51:28 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com
 [IPv6:2607:f8b0:4864:20::434])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 8E067606F0
 for <virtualization@lists.linux-foundation.org>;
 Wed, 26 May 2021 17:51:28 +0000 (UTC)
Received: by mail-pf1-x434.google.com with SMTP id q67so1520148pfb.4
 for <virtualization@lists.linux-foundation.org>;
 Wed, 26 May 2021 10:51:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance-com.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id;
 bh=HZvy0KCdCA0zoii5u97BeYQqfOi/+EHLzSddqNtR9fQ=;
 b=BQTYQveoA4cqElJvdshLkH6Z6O0vJow9gw4N3kkU5Q05ZqyMCia0IJTXs0LrhCmzuR
 H7/9/AiSsMAP7l6CAsh2CcwZzaEpCyzZ5yW1zmDwWyr10sx1ucrmUgvnIno/UkTVndpE
 UMzBWLn7e6VbfUlMqR4UrDK7KqMVKdLMguU5jS2FM3TXushFPY5Vggl/JYfs3TxS68ya
 wwYvAcWLkZ/aXJ9qo8lPP13HjtnA9udBK1A8o9oLWdEuIXbU7quaD0XU4WMDtbKPegro
 nMjKOatCfwVUb15HsBhIcMwvhdR5ZDomtN12hwTatH07DxguNwzitdFLFnlyHIhuben2
 lJjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=HZvy0KCdCA0zoii5u97BeYQqfOi/+EHLzSddqNtR9fQ=;
 b=g6VuVB3Fw2k9/UEpzP/94t2ynhqI+2/gRw4WfDzAnQnwOvB5LCWmL2DlB/+K+Lrsi8
 oMXeqLvVZerwUc6npfQuUI3nwLDpXbyDiAlDtGdlKwSmXVphQXGCs+Z59vlXNNj5XMBf
 7Z2trTLVg8NfR4f7abOzTC3004m4pVhR9OicjBcVgv+GA3lxiL4P2ACy8OD65ewP1x/I
 kyE/XKtoK57qUH952Ty2JCIjo+CBZ8s3kitQ6ZC5crTqpznK4RLBBYbB3Li+qPFXTEHx
 pG754nD2FrdlubfjeGBaLSszjk9A2siUvYEq024HiWTRt+BwDyRYOh3YtYq21kva2Tkd
 mmJw==
X-Gm-Message-State: AOAM532NoZxTd1l2HSrzi+3HzdeiEE3Y+wQcGHQpqTJGn+v/B6BFuRxu
 /2lj+JmtwcMgPQqdMnA8VjSH+g==
X-Google-Smtp-Source: ABdhPJypnYW+sqeEmFq7b+q7gxcDBaNkXP4GO9r/w5enM3KqVqTwgNkebPCePGL/16WR7zHi0kawpA==
X-Received: by 2002:a63:4648:: with SMTP id v8mr25980855pgk.34.1622051487624; 
 Wed, 26 May 2021 10:51:27 -0700 (PDT)
Received: from n124-121-013.byted.org
 (ec2-54-241-92-238.us-west-1.compute.amazonaws.com. [54.241.92.238])
 by smtp.gmail.com with ESMTPSA id r10sm14358pga.48.2021.05.26.10.51.26
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 26 May 2021 10:51:27 -0700 (PDT)
From: Jiang Wang <jiang.wang@bytedance.com>
To: mst@redhat.com,
	cohuck@redhat.com,
	virtio-comment@lists.oasis-open.org
Subject: [RFC v3] virtio-vsock: add description for datagram type
Date: Wed, 26 May 2021 17:50:35 +0000
Message-Id: <20210526175035.1873294-1-jiang.wang@bytedance.com>
X-Mailer: git-send-email 2.11.0
Cc: cong.wang@bytedance.com, duanxiongchun@bytedance.com,
 "jiang.wang" <jiang.wang@bytedance.com>,
 virtualization@lists.linux-foundation.org, xieyongji@bytedance.com,
 chaiwen.cc@bytedance.com, stefanha@redhat.com, asias@redhat.com,
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
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

From: "jiang.wang" <jiang.wang@bytedance.com>

Add supports for datagram type for virtio-vsock. Datagram
sockets are connectionless and unreliable. To avoid contention
with stream and other sockets, add two more virtqueues and
a new feature bit to identify if those two new queues exist or not.

Also add descriptions for resource management of datagram, which
does not use the existing credit update mechanism associated with
stream sockets.

Signed-off-by: Jiang Wang <jiang.wang@bytedance.com>
---
V2: addressed the comments for the previous version.
V3: add description for the mergeable receive buffer.

btw: send the same patch again to include virtio-comment@

 virtio-vsock.tex | 137 +++++++++++++++++++++++++++++++++++++++++++++++++------
 1 file changed, 124 insertions(+), 13 deletions(-)

diff --git a/virtio-vsock.tex b/virtio-vsock.tex
index da7e641..7eb3596 100644
--- a/virtio-vsock.tex
+++ b/virtio-vsock.tex
@@ -9,14 +9,36 @@ \subsection{Device ID}\label{sec:Device Types / Socket Device / Device ID}
 
 \subsection{Virtqueues}\label{sec:Device Types / Socket Device / Virtqueues}
 \begin{description}
-\item[0] rx
-\item[1] tx
+\item[0] stream rx
+\item[1] stream tx
+\item[2] datagram rx
+\item[3] datagram tx
+\item[4] event
+\end{description}
+The virtio socket device uses 5 queues if feature bit VIRTIO_VSOCK_F_DRGAM is set. Otherwise, it
+only uses 3 queues, as the following.
+
+\begin{description}
+\item[0] stream rx
+\item[1] stream tx
 \item[2] event
 \end{description}
 
+When behavior differs between stream and datagram rx/tx virtqueues
+their full names are used. Common behavior is simply described in
+terms of rx/tx virtqueues and applies to both stream and datagram
+virtqueues.
+
 \subsection{Feature bits}\label{sec:Device Types / Socket Device / Feature bits}
 
-There are currently no feature bits defined for this device.
+\begin{description}
+\item[VIRTIO_VSOCK_F_DGRAM (0)] Device has support for datagram socket type.
+\end{description}
+
+\begin{description}
+\item[VIRTIO_VSOCK_F_MRG_RXBUF (1)] Driver can merge receive buffers.
+\end{description}
+
 
 \subsection{Device configuration layout}\label{sec:Device Types / Socket Device / Device configuration layout}
 
@@ -64,6 +86,8 @@ \subsection{Device Operation}\label{sec:Device Types / Socket Device / Device Op
 
 Packets transmitted or received contain a header before the payload:
 
+If feature VIRTIO_VSOCK_F_MRG_RXBUF is not negotiated, use the following header.
+
 \begin{lstlisting}
 struct virtio_vsock_hdr {
 	le64 src_cid;
@@ -79,6 +103,15 @@ \subsection{Device Operation}\label{sec:Device Types / Socket Device / Device Op
 };
 \end{lstlisting}
 
+If feature VIRTIO_VSOCK_F_MRG_RXBUF is negotianted, use the following header.
+\begin{lstlisting}
+struct virtio_vsock_hdr_mrg_rxbuf {
+	struct virtio_vsock_hdr hdr;
+	le16 num_buffers;
+};
+\end{lstlisting}
+
+
 The upper 32 bits of src_cid and dst_cid are reserved and zeroed.
 
 Most packets simply transfer data but control packets are also used for
@@ -107,6 +140,9 @@ \subsection{Device Operation}\label{sec:Device Types / Socket Device / Device Op
 
 \subsubsection{Virtqueue Flow Control}\label{sec:Device Types / Socket Device / Device Operation / Virtqueue Flow Control}
 
+Flow control applies to stream sockets; datagram sockets do not have
+flow control.
+
 The tx virtqueue carries packets initiated by applications and replies to
 received packets.  The rx virtqueue carries packets initiated by the device and
 replies to previously transmitted packets.
@@ -140,12 +176,15 @@ \subsubsection{Addressing}\label{sec:Device Types / Socket Device / Device Opera
 consists of a (cid, port number) tuple. The header fields used for this are
 \field{src_cid}, \field{src_port}, \field{dst_cid}, and \field{dst_port}.
 
-Currently only stream sockets are supported. \field{type} is 1 for stream
-socket types.
+Currently stream and datagram (dgram) sockets are supported. \field{type} is 1 for stream
+socket types. \field{type} is 3 for dgram socket types.
 
 Stream sockets provide in-order, guaranteed, connection-oriented delivery
 without message boundaries.
 
+Datagram sockets provide unordered, unreliable, connectionless messages 
+with message boundaries and a maximum length.
+
 \subsubsection{Buffer Space Management}\label{sec:Device Types / Socket Device / Device Operation / Buffer Space Management}
 \field{buf_alloc} and \field{fwd_cnt} are used for buffer space management of
 stream sockets. The guest and the device publish how much buffer space is
@@ -162,7 +201,7 @@ \subsubsection{Buffer Space Management}\label{sec:Device Types / Socket Device /
 u32 peer_free = peer_buf_alloc - (tx_cnt - peer_fwd_cnt);
 \end{lstlisting}
 
-If there is insufficient buffer space, the sender waits until virtqueue buffers
+For stream sockets, if there is insufficient buffer space, the sender waits until virtqueue buffers
 are returned and checks \field{buf_alloc} and \field{fwd_cnt} again. Sending
 the VIRTIO_VSOCK_OP_CREDIT_REQUEST packet queries how much buffer space is
 available. The reply to this query is a VIRTIO_VSOCK_OP_CREDIT_UPDATE packet.
@@ -170,22 +209,52 @@ \subsubsection{Buffer Space Management}\label{sec:Device Types / Socket Device /
 previously receiving a VIRTIO_VSOCK_OP_CREDIT_REQUEST packet. This allows
 communicating updates any time a change in buffer space occurs.
 
+Unlike stream sockets, dgram sockets do not use VIRTIO_VSOCK_OP_CREDIT_UPDATE or
+VIRTIO_VSOCK_OP_CREDIT_REQUEST packets. The dgram buffer management
+is split to two parts: tx side and rx side. For the tx side, if the 
+virtqueue is full, the packet will be dropped.
+For the rx side, dgram also uses the \field{buf_alloc}. If it is full, the packet
+is dropped by the receiver.
+
+\drivernormative{\paragraph}{Device Operation: Buffer Space Management}{Device Types / Socket Device / Device Operation / Setting Up Receive Buffers}
+\begin{itemize}
+\item If VIRTIO_VSOCK_F_MRG_RXBUF is not negotiated, the driver SHOULD populate the receive queue(s)
+      with buffers of at least 1526 bytes for stream sockets and 4096 bytes for datagram sockets.
+\item If VIRTIO_VSOCK_F_MRG_RXBUF is negotiated, each buffer MUST be at
+least the size of the struct virtio_vsock_hdr.
+\end{itemize}
+
+\begin{note}
+Obviously each buffer can be split across multiple descriptor elements.
+\end{note}
+
+\devicenormative{\paragraph}{Device Operation: Buffer Space Management}{Device Types / Socket Device / Device Operation / Setting Up Receive Buffers}
+The device MUST set \field{num_buffers} to the number of descriptors used when
+transmitting the  packet.
+
+The device MUST use only a single descriptor if VIRTIO_VSOCK_F_MRG_RXBUF
+is not negotiated.
+
 \drivernormative{\paragraph}{Device Operation: Buffer Space Management}{Device Types / Socket Device / Device Operation / Buffer Space Management}
-VIRTIO_VSOCK_OP_RW data packets MUST only be transmitted when the peer has
-sufficient free buffer space for the payload.
+For stream sockets, VIRTIO_VSOCK_OP_RW data packets MUST only be transmitted when the peer has
+sufficient free buffer space for the payload. For dgram sockets, VIRTIO_VSOCK_OP_RW data packets
+MAY be transmitted when the peer rx buffer is full. Then the packet will be dropped by the peer,
+and driver will not get any notification.
 
 All packets associated with a stream flow MUST contain valid information in
 \field{buf_alloc} and \field{fwd_cnt} fields.
 
 \devicenormative{\paragraph}{Device Operation: Buffer Space Management}{Device Types / Socket Device / Device Operation / Buffer Space Management}
-VIRTIO_VSOCK_OP_RW data packets MUST only be transmitted when the peer has
-sufficient free buffer space for the payload.
+For stream sockets, VIRTIO_VSOCK_OP_RW data packets MUST only be transmitted when the peer has
+sufficient free buffer space for the payload. For dgram sockets, VIRTIO_VSOCK_OP_RW data packets
+MAY be transmitted when the peer rx buffer is full. Then the packet will be dropped by the peer,
+and the device will not get any notification.
 
 All packets associated with a stream flow MUST contain valid information in
 \field{buf_alloc} and \field{fwd_cnt} fields.
 
 \subsubsection{Receive and Transmit}\label{sec:Device Types / Socket Device / Device Operation / Receive and Transmit}
-The driver queues outgoing packets on the tx virtqueue and incoming packet
+The driver queues outgoing packets on the tx virtqueue and allocates incoming packet
 receive buffers on the rx virtqueue. Packets are of the following form:
 
 \begin{lstlisting}
@@ -198,21 +267,55 @@ \subsubsection{Receive and Transmit}\label{sec:Device Types / Socket Device / De
 Virtqueue buffers for outgoing packets are read-only. Virtqueue buffers for
 incoming packets are write-only.
 
+When transmitting packets to the device, \field{num_buffers} is not used.
+
+\begin{enumerate}
+\item \field{num_buffers} indicates how many descriptors
+  this packet is spread over (including this one): this will
+  always be 1 if VIRTIO_VSOCK_F_MRG_RXBUF was not negotiated.
+  This allows receipt of large packets without having to allocate large
+  buffers: a packet that does not fit in a single buffer can flow
+  over to the next buffer, and so on. In this case, there will be
+  at least \field{num_buffers} used buffers in the virtqueue, and the device
+  chains them together to form a single packet in a way similar to
+  how it would store it in a single buffer spread over multiple
+  descriptors.
+  The other buffers will not begin with a struct virtio_vsock_hdr.
+
+\item If
+  \field{num_buffers} is one, then the entire packet will be
+  contained within this buffer, immediately following the struct
+  virtio_vsock_hdr.
+\end{enumerate}
+
 \drivernormative{\paragraph}{Device Operation: Receive and Transmit}{Device Types / Socket Device / Device Operation / Receive and Transmit}
 
 The \field{guest_cid} configuration field MUST be used as the source CID when
 sending outgoing packets.
 
-A VIRTIO_VSOCK_OP_RST reply MUST be sent if a packet is received with an
+For stream and datagram sockets, A VIRTIO_VSOCK_OP_RST reply MUST be sent if a packet is received with an
 unknown \field{type} value.
 
 \devicenormative{\paragraph}{Device Operation: Receive and Transmit}{Device Types / Socket Device / Device Operation / Receive and Transmit}
 
 The \field{guest_cid} configuration field MUST NOT contain a reserved CID as listed in \ref{sec:Device Types / Socket Device / Device configuration layout}.
 
-A VIRTIO_VSOCK_OP_RST reply MUST be sent if a packet is received with an
+For stream and datagram sockets, A VIRTIO_VSOCK_OP_RST reply MUST be sent if a packet is received with an
 unknown \field{type} value.
 
+If VIRTIO_VSOCK_F_MRG_RXBUF has been negotiated, the device MUST set
+\field{num_buffers} to indicate the number of buffers
+the packet (including the header) is spread over.
+
+If a receive packet is spread over multiple buffers, the device
+MUST use all buffers but the last (i.e. the first $\field{num_buffers} -
+1$ buffers) completely up to the full length of each buffer
+supplied by the driver.
+
+The device MUST use all buffers used by a single receive
+packet together, such that at least \field{num_buffers} are
+observed by driver as used.
+
 \subsubsection{Stream Sockets}\label{sec:Device Types / Socket Device / Device Operation / Stream Sockets}
 
 Connections are established by sending a VIRTIO_VSOCK_OP_REQUEST packet. If a
@@ -240,6 +343,14 @@ \subsubsection{Stream Sockets}\label{sec:Device Types / Socket Device / Device O
 destination) address tuple for a new connection while the other peer is still
 processing the old connection.
 
+\subsubsection{Datagram Sockets}\label{sec:Device Types / Socket Device / Device Operation / Datagram Sockets}
+
+Datagram (dgram) sockets are connectionless and unreliable. The sender just sends
+a message to the peer and hopes it will be delivered. A VIRTIO_VSOCK_OP_RST reply is sent if
+a receiving socket does not exist on the destination.
+If the transmission or receiving buffers are full, the packets
+are dropped.
+
 \subsubsection{Device Events}\label{sec:Device Types / Socket Device / Device Operation / Device Events}
 
 Certain events are communicated by the device to the driver using the event
-- 
2.11.0

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
