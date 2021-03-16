Return-Path: <SRS0=cXtE=IO=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75F86C433E0
	for <virtualization@archiver.kernel.org>; Tue, 16 Mar 2021 21:57:33 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D54F564F7F
	for <virtualization@archiver.kernel.org>; Tue, 16 Mar 2021 21:57:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D54F564F7F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=bytedance.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 88AC6430B2;
	Tue, 16 Mar 2021 21:57:32 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id J8724kkURIW4; Tue, 16 Mar 2021 21:57:31 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTP id DA11B43198;
	Tue, 16 Mar 2021 21:57:30 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id AC6A4C000B;
	Tue, 16 Mar 2021 21:57:30 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 6B4FBC000A
 for <virtualization@lists.linux-foundation.org>;
 Tue, 16 Mar 2021 21:57:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 51DFB83E65
 for <virtualization@lists.linux-foundation.org>;
 Tue, 16 Mar 2021 21:57:29 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=bytedance-com.20150623.gappssmtp.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 7cuUCJuUv6ce
 for <virtualization@lists.linux-foundation.org>;
 Tue, 16 Mar 2021 21:57:27 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com
 [IPv6:2607:f8b0:4864:20::535])
 by smtp1.osuosl.org (Postfix) with ESMTPS id AEB6E83D41
 for <virtualization@lists.linux-foundation.org>;
 Tue, 16 Mar 2021 21:57:27 +0000 (UTC)
Received: by mail-pg1-x535.google.com with SMTP id o10so23534797pgg.4
 for <virtualization@lists.linux-foundation.org>;
 Tue, 16 Mar 2021 14:57:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance-com.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id;
 bh=UCfq6O2HGFUO1Fjnc00yoeKzTUEK+YWqnAT2aV6UqPo=;
 b=EKI9EnDBE0ymD3E1uSU2pzaC1pXHX3TLoF8eyfEzmV1f4bsMUqfS5u8Ge3tDbBBTaT
 4RTqEbYv37R8FdJboNDAGXhMjJRrSqMu1CVeQrjmqDFRC40QRIZqLQxJ4JxY07+SM/kA
 BI+WO4ngDW7oYrOGoy9wC6FcZC+blG9gS7SSamdEIQIz2ScDj+cYP5oru8QDhF86NhSg
 bRqHsGwvhHbxCNmF+u0bjKNS9kO0VwR/kNMq+WAUG/Y/VooHbMn2mYIq9KwcBfLfF3gM
 yHSHCMRciVg6KArh8yh/mTkWuiealP6gXV8E4FEQGSczYv0bHVkC064xQHsrcjk64Sy4
 zt6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=UCfq6O2HGFUO1Fjnc00yoeKzTUEK+YWqnAT2aV6UqPo=;
 b=Ui/6UtGGoMYVO8pBOe+z358UKIkjFOwfymjGBSHTUGhrys3ieDWhkfqvnUZMoaZSPV
 boRd/298PhkQCAmo/6O+GNhmluY+97o3jP5UdUVBIvfd11k3Ss6cZY9+lgA6iLMBmZoU
 ASTA/oo6oJFJIatBKqKe/GJRVAATqxPVoYGpd7YBuPuvqyxZpUm9yu5Wj/Hl6HQZa4Rx
 k0HMtBNvvQ5NU0tpGrpqWF3RtgTSBlE/9ovDkVp4SzIou7Gqw/0v5Mf6kYUM/O6O0Yiq
 8wgXbqFsVa5+98AhJcHk4xpZCmD+QMX/c1QO6OVnq+9Qj2qeYB6FFVuArkwCiGOCumv6
 LZNQ==
X-Gm-Message-State: AOAM533rMFESgYrSRBCZ2XcPpFL6RHAJYWLjBLw5rT2/HwtBpW12Ey5k
 ISIdBcbWGH+9rnoEZUa782u+RQ==
X-Google-Smtp-Source: ABdhPJy/iTnmkq24Z5YAWSqKThAoKpWTXp3NrVSjfFHOprSRLQk58RoqavzAaaX75zEe+fyEksm3Yg==
X-Received: by 2002:a63:2316:: with SMTP id j22mr1579307pgj.392.1615931846599; 
 Tue, 16 Mar 2021 14:57:26 -0700 (PDT)
Received: from n124-121-013.byted.org
 (ec2-54-241-92-238.us-west-1.compute.amazonaws.com. [54.241.92.238])
 by smtp.gmail.com with ESMTPSA id c6sm161167pfj.99.2021.03.16.14.57.25
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 16 Mar 2021 14:57:26 -0700 (PDT)
From: "jiang.wang" <jiang.wang@bytedance.com>
To: mst@redhat.com,
	cohuck@redhat.com
Subject: [RFC PATCH] virtio-vsock: add description for datagram type
Date: Tue, 16 Mar 2021 21:56:44 +0000
Message-Id: <20210316215644.2254177-1-jiang.wang@bytedance.com>
X-Mailer: git-send-email 2.11.0
Cc: cong.wang@bytedance.com, duanxiongchun@bytedance.com,
 "jiang.wang" <jiang.wang@bytedance.com>,
 virtualization@lists.linux-foundation.org, xieyongji@bytedance.com,
 stefanha@redhat.com, asias@redhat.com, arseny.krasnov@kaspersky.com
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

Add supports for datagram type for virtio-vsock. Datagram
sockets are connectionless and unreliable. To avoid contention
with stream and other sockets, add two more virtqueues and
a new feature bit to identify if those two new queues exist or not.

Also add descriptions for resouce management of datagram, which
does not use the existing credit update mechanism associated with
stream sockets.

Signed-off-by: Jiang Wang <jiang.wang@bytedance.com>
---
 virtio-vsock.tex | 72 ++++++++++++++++++++++++++++++++++++++++++++++++--------
 1 file changed, 62 insertions(+), 10 deletions(-)

diff --git a/virtio-vsock.tex b/virtio-vsock.tex
index da7e641..a2ff0a4 100644
--- a/virtio-vsock.tex
+++ b/virtio-vsock.tex
@@ -9,14 +9,27 @@ \subsection{Device ID}\label{sec:Device Types / Socket Device / Device ID}
 
 \subsection{Virtqueues}\label{sec:Device Types / Socket Device / Virtqueues}
 \begin{description}
+\item[0] stream rx
+\item[1] stream tx
+\item[2] dgram rx
+\item[3] dgram tx
+\item[4] event
+\end{description}
+The virtio socket device uses 5 queues if feature bit VIRTIO_VSOCK_DRGAM is set. Otherwise, it
+only uses 3 queues, as the following.
+
+\begin{description}
 \item[0] rx
 \item[1] tx
 \item[2] event
 \end{description}
 
+
 \subsection{Feature bits}\label{sec:Device Types / Socket Device / Feature bits}
 
-There are currently no feature bits defined for this device.
+\begin{description}
+\item[VIRTIO_VSOCK_DGRAM (0)] Device has support for datagram sockets type.
+\end{description}
 
 \subsection{Device configuration layout}\label{sec:Device Types / Socket Device / Device configuration layout}
 
@@ -76,6 +89,7 @@ \subsection{Device Operation}\label{sec:Device Types / Socket Device / Device Op
 	le32 flags;
 	le32 buf_alloc;
 	le32 fwd_cnt;
+	le64 timestamp;
 };
 \end{lstlisting}
 
@@ -121,11 +135,14 @@ \subsubsection{Virtqueue Flow Control}\label{sec:Device Types / Socket Device /
 packets.  With additional resources, it becomes possible to process incoming
 packets even when outgoing packets cannot be sent.
 
-Eventually even the additional resources will be exhausted and further
+For stream type, eventually even the additional resources will be exhausted and further
 processing is not possible until the other side processes the virtqueue that
 it has neglected.  This stop to processing prevents one side from causing
 unbounded resource consumption in the other side.
 
+For datagram type, the additional resources have a fixed size limit to prevent
+unbounded resource consumption.
+
 \drivernormative{\paragraph}{Device Operation: Virtqueue Flow Control}{Device Types / Socket Device / Device Operation / Virtqueue Flow Control}
 
 The rx virtqueue MUST be processed even when the tx virtqueue is full so long as there are additional resources available to hold packets outside the tx virtqueue.
@@ -140,12 +157,15 @@ \subsubsection{Addressing}\label{sec:Device Types / Socket Device / Device Opera
 consists of a (cid, port number) tuple. The header fields used for this are
 \field{src_cid}, \field{src_port}, \field{dst_cid}, and \field{dst_port}.
 
-Currently only stream sockets are supported. \field{type} is 1 for stream
-socket types.
+Currently stream and datagram (dgram) sockets are supported. \field{type} is 1 for stream
+socket types. \field{type} is 3 for dgram socket types.
 
 Stream sockets provide in-order, guaranteed, connection-oriented delivery
 without message boundaries.
 
+Datagram socekts provide connectionless unreliable messages of
+a fixed maximum length.
+
 \subsubsection{Buffer Space Management}\label{sec:Device Types / Socket Device / Device Operation / Buffer Space Management}
 \field{buf_alloc} and \field{fwd_cnt} are used for buffer space management of
 stream sockets. The guest and the device publish how much buffer space is
@@ -170,20 +190,41 @@ \subsubsection{Buffer Space Management}\label{sec:Device Types / Socket Device /
 previously receiving a VIRTIO_VSOCK_OP_CREDIT_REQUEST packet. This allows
 communicating updates any time a change in buffer space occurs.
 
+For datagram sockets, \field{buf_alloc} is also used on the rx side. Unlike stream 
+sockets, dgram sockets do not use VIRTIO_VSOCK_OP_CREDIT_UPDATE or 
+VIRTIO_VSOCK_OP_CREDIT_REQUEST packets. The dgram sender does not check if
+the \field{buf_alloc} of the peer is full or not. If it is full, the packet
+will be dropped. To limit resouce usage of the sender, \field{dgram_tx_bytes}
+is used for each VM and host. Only payload bytes are counted and header bytes are not
+included. If \field{dgram_tx_bytes} is equal to VIRTIO_VSOCK_MAX_DGRAM_BUF_SIZE,
+the send will fail.
+
+For dgram, since \field{dgram_tx_byte} is shared within a VM or host, a tx_timeout and
+a timer are used for each outgoing packet. If a packet is not delivered within
+tx_timeout, it will be dropped to make free space for other dgram sockets.
+
 \drivernormative{\paragraph}{Device Operation: Buffer Space Management}{Device Types / Socket Device / Device Operation / Buffer Space Management}
-VIRTIO_VSOCK_OP_RW data packets MUST only be transmitted when the peer has
-sufficient free buffer space for the payload.
+For stream sockets, VIRTIO_VSOCK_OP_RW data packets MUST only be transmitted when the peer has
+sufficient free buffer space for the payload. For dgram sockets, VIRTIO_VSOCK_OP_RW data packets
+can be transmitted when the peer buffer is full. Then the pacekt will be dropped.
 
 All packets associated with a stream flow MUST contain valid information in
 \field{buf_alloc} and \field{fwd_cnt} fields.
 
+All packets associated with a dgram flow MUST contain valid information in
+\field{timestamp} field, which will be used to check for tx timeout.
+
 \devicenormative{\paragraph}{Device Operation: Buffer Space Management}{Device Types / Socket Device / Device Operation / Buffer Space Management}
-VIRTIO_VSOCK_OP_RW data packets MUST only be transmitted when the peer has
-sufficient free buffer space for the payload.
+For stream sockets, VIRTIO_VSOCK_OP_RW data packets MUST only be transmitted when the peer has
+sufficient free buffer space for the payload. For dgram sockets, VIRTIO_VSOCK_OP_RW data packets
+can be transmitted when the peer buffer is full. Then the pacekt will be dropped.
 
 All packets associated with a stream flow MUST contain valid information in
 \field{buf_alloc} and \field{fwd_cnt} fields.
 
+All packets associated with a dgram flow MUST contain valid information in
+\field{timestamp} field.
+
 \subsubsection{Receive and Transmit}\label{sec:Device Types / Socket Device / Device Operation / Receive and Transmit}
 The driver queues outgoing packets on the tx virtqueue and incoming packet
 receive buffers on the rx virtqueue. Packets are of the following form:
@@ -203,14 +244,14 @@ \subsubsection{Receive and Transmit}\label{sec:Device Types / Socket Device / De
 The \field{guest_cid} configuration field MUST be used as the source CID when
 sending outgoing packets.
 
-A VIRTIO_VSOCK_OP_RST reply MUST be sent if a packet is received with an
+For stream socekts, A VIRTIO_VSOCK_OP_RST reply MUST be sent if a packet is received with an
 unknown \field{type} value.
 
 \devicenormative{\paragraph}{Device Operation: Receive and Transmit}{Device Types / Socket Device / Device Operation / Receive and Transmit}
 
 The \field{guest_cid} configuration field MUST NOT contain a reserved CID as listed in \ref{sec:Device Types / Socket Device / Device configuration layout}.
 
-A VIRTIO_VSOCK_OP_RST reply MUST be sent if a packet is received with an
+For stream sockets, A VIRTIO_VSOCK_OP_RST reply MUST be sent if a packet is received with an
 unknown \field{type} value.
 
 \subsubsection{Stream Sockets}\label{sec:Device Types / Socket Device / Device Operation / Stream Sockets}
@@ -240,6 +281,17 @@ \subsubsection{Stream Sockets}\label{sec:Device Types / Socket Device / Device O
 destination) address tuple for a new connection while the other peer is still
 processing the old connection.
 
+\subsubsection{Datagram Sockets}\label{sec:Device Types / Socket Device / Device Operation / Stream Sockets}
+
+Datagram (dgram) sockets are connectionless and unreliable. The sender just send 
+a message to the peer and hope it will be delivered. If there is no socket binds the 
+address on the other end, or the transmision or receving buffers are full, the packets 
+will be droped. Each packet may have a source cid and 
+source port, the receiver can use them to send back a reply message.
+
+Dgram sockets preserve the message boundaries. A message is either sent or dropped.
+Multiple messages will not be combined.
+
 \subsubsection{Device Events}\label{sec:Device Types / Socket Device / Device Operation / Device Events}
 
 Certain events are communicated by the device to the driver using the event
-- 
2.11.0

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
