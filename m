Return-Path: <SRS0=uiEo=LE=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31FDFC48BDF
	for <virtualization@archiver.kernel.org>; Thu, 10 Jun 2021 18:12:27 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AE2D861376
	for <virtualization@archiver.kernel.org>; Thu, 10 Jun 2021 18:12:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AE2D861376
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=bytedance.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 7DDE382A28;
	Thu, 10 Jun 2021 18:12:26 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 8JTVherSN7gr; Thu, 10 Jun 2021 18:12:25 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id E5F5C82884;
	Thu, 10 Jun 2021 18:12:24 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A5F2FC000D;
	Thu, 10 Jun 2021 18:12:24 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 20914C000B
 for <virtualization@lists.linux-foundation.org>;
 Thu, 10 Jun 2021 18:12:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 0794640133
 for <virtualization@lists.linux-foundation.org>;
 Thu, 10 Jun 2021 18:12:23 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=bytedance-com.20150623.gappssmtp.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id UB9Vx4XGQZUh
 for <virtualization@lists.linux-foundation.org>;
 Thu, 10 Jun 2021 18:12:21 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com
 [IPv6:2607:f8b0:4864:20::533])
 by smtp2.osuosl.org (Postfix) with ESMTPS id CA25740118
 for <virtualization@lists.linux-foundation.org>;
 Thu, 10 Jun 2021 18:12:21 +0000 (UTC)
Received: by mail-pg1-x533.google.com with SMTP id l184so405329pgd.8
 for <virtualization@lists.linux-foundation.org>;
 Thu, 10 Jun 2021 11:12:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance-com.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id;
 bh=/fgst8x0pLWKH5Nbt0s9N2TUzSynvmHm5uNfYSXQnD0=;
 b=GKimmn/0Uoz8UCsb5mFho//4FeWrOA1Gl52Oi7D8PMoZ1FwRvK6kqegpVa86d6kERb
 epq301Pdh04YvViVqmwg2t9MqMGZVyTWpK7JQ7Alaz8kxi3QNMHGe7uUNl3fcy96/uA7
 38A3+32Ap4R+64M0rYbzBy1TarfdFLbO33Y5a1TFawVKdWoi1cgbD3dCa//aEm/i2mfo
 rHxvc0hLy1OLUSY6C+QK1lXiIOsvAfskDZyLi397va3VIgjkXUY5VH0zrln6dJB6Hc5G
 1hcSa/J2mJbnA2ZC15wSgE/ZgAqAJLYuWKe8BhW4GldjWb5H0/o+vf4RD2BZMzudTw7z
 53Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=/fgst8x0pLWKH5Nbt0s9N2TUzSynvmHm5uNfYSXQnD0=;
 b=d6RCzp4vwUg5IghN1b4tjYG2QPxMdqm5xjiHfH2fmJe1px6ksNtpkh1EOivdsBLbY1
 r6BHh4b/8UPwpoGwuLQ+7+iEZm61sYIuxNWHutNMcZY3GJfQ+qDDB085MEy3PmGfpCnV
 7k3++cO400LQkXEXTxZAwbvcuI6AkDN4NRzoCpK0Cq0tAP1LmNZfUnUy/HmD+t4U2gs9
 PmJBwPtD4cuEr8GrCAT8tbKRs3hO1Ng1iprij3bY7GwbdszzxBms0QQNN0fi0xxib3rH
 O6sEcJhD4OudTk392wsSkdRGVjrxnA2P0LkGmxFZIXnU1hmM+iTlvHvL6zlM090nXjZn
 a1kQ==
X-Gm-Message-State: AOAM533/lv0JPa6TbrLML0Z6b7O8vDNX0OUmTZuScg7LJQXg/OOhvlpn
 7s2KPhHVeWPHvnGn3XnoCkqaRA==
X-Google-Smtp-Source: ABdhPJyD5ZerRZcCVPjLKKRMLeZGmXq8XkjF1Qx8UPd8vmGpKxKqLEi1ahbaGyoKbdOQd4jWnnl77Q==
X-Received: by 2002:a63:d305:: with SMTP id b5mr6279956pgg.67.1623348740814;
 Thu, 10 Jun 2021 11:12:20 -0700 (PDT)
Received: from n124-121-013.byted.org
 (ec2-54-241-92-238.us-west-1.compute.amazonaws.com. [54.241.92.238])
 by smtp.gmail.com with ESMTPSA id l3sm3179136pgb.77.2021.06.10.11.12.19
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 10 Jun 2021 11:12:20 -0700 (PDT)
From: Jiang Wang <jiang.wang@bytedance.com>
To: mst@redhat.com,
	cohuck@redhat.com,
	virtio-comment@lists.oasis-open.org
Subject: [PATCH v5] virtio-vsock: add description for datagram type
Date: Thu, 10 Jun 2021 18:12:03 +0000
Message-Id: <20210610181203.979686-1-jiang.wang@bytedance.com>
X-Mailer: git-send-email 2.11.0
Cc: cong.wang@bytedance.com, duanxiongchun@bytedance.com,
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
V4: add a feature bit for stream and reserver a bit for seqpacket.
Fix mrg_rxbuf related sentences.
V5: removed mergeable rx buffer part. It will go to a 
separate patch. Fixed comments about tx, rx, feature bit etc.

 virtio-vsock.tex | 71 +++++++++++++++++++++++++++++++++++++++++++++++---------
 1 file changed, 60 insertions(+), 11 deletions(-)

diff --git a/virtio-vsock.tex b/virtio-vsock.tex
index da7e641..26a62ac 100644
--- a/virtio-vsock.tex
+++ b/virtio-vsock.tex
@@ -9,14 +9,37 @@ \subsection{Device ID}\label{sec:Device Types / Socket Device / Device ID}
 
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
+\item[VIRTIO_VSOCK_F_STREAM (0)] Device has support for stream socket type.
+\end{description}
+
+\begin{description}
+\item[VIRTIO_VSOCK_F_DGRAM (2)] Device has support for datagram socket type.
+\end{description}
+
+If no feature bits are defined, assume device only supports stream socket type.
 
 \subsection{Device configuration layout}\label{sec:Device Types / Socket Device / Device configuration layout}
 
@@ -107,6 +130,9 @@ \subsection{Device Operation}\label{sec:Device Types / Socket Device / Device Op
 
 \subsubsection{Virtqueue Flow Control}\label{sec:Device Types / Socket Device / Device Operation / Virtqueue Flow Control}
 
+Flow control applies to stream sockets; datagram sockets do not have
+flow control.
+
 The tx virtqueue carries packets initiated by applications and replies to
 received packets.  The rx virtqueue carries packets initiated by the device and
 replies to previously transmitted packets.
@@ -140,12 +166,15 @@ \subsubsection{Addressing}\label{sec:Device Types / Socket Device / Device Opera
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
@@ -162,7 +191,7 @@ \subsubsection{Buffer Space Management}\label{sec:Device Types / Socket Device /
 u32 peer_free = peer_buf_alloc - (tx_cnt - peer_fwd_cnt);
 \end{lstlisting}
 
-If there is insufficient buffer space, the sender waits until virtqueue buffers
+For stream sockets, if there is insufficient buffer space, the sender waits until virtqueue buffers
 are returned and checks \field{buf_alloc} and \field{fwd_cnt} again. Sending
 the VIRTIO_VSOCK_OP_CREDIT_REQUEST packet queries how much buffer space is
 available. The reply to this query is a VIRTIO_VSOCK_OP_CREDIT_UPDATE packet.
@@ -170,22 +199,33 @@ \subsubsection{Buffer Space Management}\label{sec:Device Types / Socket Device /
 previously receiving a VIRTIO_VSOCK_OP_CREDIT_REQUEST packet. This allows
 communicating updates any time a change in buffer space occurs.
 
+Unlike stream sockets, dgram sockets do not use VIRTIO_VSOCK_OP_CREDIT_UPDATE or
+VIRTIO_VSOCK_OP_CREDIT_REQUEST packets. The dgram buffer management
+is split to two parts: sender side and receiver side. For the sender side, if the 
+virtqueue is full, the packet will be dropped.
+For the receiver side, the packet is dropped by the receiver if there is no space in the
+receive buffer.
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
@@ -195,6 +235,7 @@ \subsubsection{Receive and Transmit}\label{sec:Device Types / Socket Device / De
 };
 \end{lstlisting}
 
+
 Virtqueue buffers for outgoing packets are read-only. Virtqueue buffers for
 incoming packets are write-only.
 
@@ -240,6 +281,14 @@ \subsubsection{Stream Sockets}\label{sec:Device Types / Socket Device / Device O
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
