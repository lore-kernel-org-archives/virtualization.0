Return-Path: <SRS0=3//R=I6=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4653FC43460
	for <virtualization@archiver.kernel.org>; Thu,  1 Apr 2021 04:36:33 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ADEC26108F
	for <virtualization@archiver.kernel.org>; Thu,  1 Apr 2021 04:36:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ADEC26108F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=bytedance.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 5E59660A6B;
	Thu,  1 Apr 2021 04:36:32 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id nvyDQ7Htir5x; Thu,  1 Apr 2021 04:36:31 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTP id A370760A64;
	Thu,  1 Apr 2021 04:36:30 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 749FBC000D;
	Thu,  1 Apr 2021 04:36:30 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 2792EC000B
 for <virtualization@lists.linux-foundation.org>;
 Thu,  1 Apr 2021 04:36:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 0914040F1D
 for <virtualization@lists.linux-foundation.org>;
 Thu,  1 Apr 2021 04:36:29 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=bytedance-com.20150623.gappssmtp.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id EExvfLxYxw7B
 for <virtualization@lists.linux-foundation.org>;
 Thu,  1 Apr 2021 04:36:27 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com
 [IPv6:2607:f8b0:4864:20::435])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 51D1440F1B
 for <virtualization@lists.linux-foundation.org>;
 Thu,  1 Apr 2021 04:36:27 +0000 (UTC)
Received: by mail-pf1-x435.google.com with SMTP id 11so525720pfn.9
 for <virtualization@lists.linux-foundation.org>;
 Wed, 31 Mar 2021 21:36:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance-com.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id;
 bh=zXIKGt6DN6pL5ms54yrgChO9tbjRGYRA9SLaWJbv+HA=;
 b=X1QlwWsVYYhWlV06czekypeQyZ/bIfxPU3AAzcTOT9TUM59lNEzIGy1+O7zlfBayeC
 5RW7qHdaYzaqcY+sv2raNvuj2nODMBCbTeER0zSc4CRZ5AbKSK9YsUDg+AmeMR+HAmZD
 s14UTu+IL8NVkHTE8ywNcmG9xNgBfQmMyeUV4w/nrEw/XefJ89VDcS3RWxk/pa/Z4bdv
 Eb1VMtFVfqgbMZ9lQrDIJ3dPC6MOqcZXCd6vztjAhFggxJqy6bDc5FEknDKT+tk2nvmj
 QNFEwxPdYAxPifxXEj84XJQ/hVasLdx/gIiQw9Vf3d5MFc/S/uEVVtRumRp/eFcVP+sa
 BDCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=zXIKGt6DN6pL5ms54yrgChO9tbjRGYRA9SLaWJbv+HA=;
 b=DxkoBTGmP/T6Hy0MYgwI+MQv+uTmgHNdmEKoORXI6dQLfhud1fgCt4EplE+pbLJXiI
 ifSQoMam4yQEZw57TBXOjrdYh8iu2mBL8xVnNp6eg3AJT0LArIJ7RSnIdeE55M/uXYQu
 TfxaEpDxzAgFVG4Jsu5v5X7wtAEmRwHarLwU58isxGTjZKsGmGPIWXmWZqi074qvmwix
 EtuZVVt8oTdUZtt8fj9Foq8k2qfN3m0Ti3GJBLbjYAcOq+lUS8nZ+Dcwc3cfOSdQdrgl
 js3gWL6Lk6sWpc/3hVpbx4ssDa6RPv03aL5A6RPMKiEK2cwtwYJwZuhSBuGHLI/MYrjy
 rsoA==
X-Gm-Message-State: AOAM532sgKw5D6EnlgT704LBkaTDjZyXo30y3gsXxeX8RJ8aR4eMGNcN
 2vR/rnlBpwrHhx3FvelndIXnew==
X-Google-Smtp-Source: ABdhPJyg9uwqwnwf8lKytybcyYX2iDhqi3QdGhHO9b+cxYHY4MifhpmEbxDI+dzMzSzG3WE+yDZuCg==
X-Received: by 2002:a63:62c4:: with SMTP id w187mr5769815pgb.173.1617251786483; 
 Wed, 31 Mar 2021 21:36:26 -0700 (PDT)
Received: from n124-121-013.byted.org
 (ec2-54-241-92-238.us-west-1.compute.amazonaws.com. [54.241.92.238])
 by smtp.gmail.com with ESMTPSA id f65sm4072544pgc.19.2021.03.31.21.36.25
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 31 Mar 2021 21:36:26 -0700 (PDT)
From: "jiang.wang" <jiang.wang@bytedance.com>
To: mst@redhat.com,
	cohuck@redhat.com
Subject: [RFC v2] virtio-vsock: add description for datagram type
Date: Thu,  1 Apr 2021 04:36:02 +0000
Message-Id: <20210401043602.3510538-1-jiang.wang@bytedance.com>
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

Also add descriptions for resource management of datagram, which
does not use the existing credit update mechanism associated with
stream sockets.

Signed-off-by: Jiang Wang <jiang.wang@bytedance.com>
---
V2 addressed the comments for the previous version.

 virtio-vsock.tex | 62 +++++++++++++++++++++++++++++++++++++++++++++++---------
 1 file changed, 52 insertions(+), 10 deletions(-)

diff --git a/virtio-vsock.tex b/virtio-vsock.tex
index da7e641..62c12e0 100644
--- a/virtio-vsock.tex
+++ b/virtio-vsock.tex
@@ -11,12 +11,25 @@ \subsection{Virtqueues}\label{sec:Device Types / Socket Device / Virtqueues}
 \begin{description}
 \item[0] rx
 \item[1] tx
+\item[2] datagram rx
+\item[3] datagram tx
+\item[4] event
+\end{description}
+The virtio socket device uses 5 queues if feature bit VIRTIO_VSOCK_F_DRGAM is set. Otherwise, it
+only uses 3 queues, as the following. Rx and tx queues are always used for stream sockets.
+
+\begin{description}
+\item[0] rx
+\item[1] tx
 \item[2] event
 \end{description}
 
+
 \subsection{Feature bits}\label{sec:Device Types / Socket Device / Feature bits}
 
-There are currently no feature bits defined for this device.
+\begin{description}
+\item[VIRTIO_VSOCK_F_DGRAM (0)] Device has support for datagram socket type.
+\end{description}
 
 \subsection{Device configuration layout}\label{sec:Device Types / Socket Device / Device configuration layout}
 
@@ -107,6 +120,9 @@ \subsection{Device Operation}\label{sec:Device Types / Socket Device / Device Op
 
 \subsubsection{Virtqueue Flow Control}\label{sec:Device Types / Socket Device / Device Operation / Virtqueue Flow Control}
 
+Flow control applies to stream sockets; datagram sockets do not have
+flow control.
+
 The tx virtqueue carries packets initiated by applications and replies to
 received packets.  The rx virtqueue carries packets initiated by the device and
 replies to previously transmitted packets.
@@ -140,12 +156,15 @@ \subsubsection{Addressing}\label{sec:Device Types / Socket Device / Device Opera
 consists of a (cid, port number) tuple. The header fields used for this are
 \field{src_cid}, \field{src_port}, \field{dst_cid}, and \field{dst_port}.
 
-Currently only stream sockets are supported. \field{type} is 1 for stream
-socket types.
+Currently stream and datagram (dgram) sockets are supported. \field{type} is 1 for stream
+socket types. \field{type} is 3 for dgram socket types.
 
 Stream sockets provide in-order, guaranteed, connection-oriented delivery
 without message boundaries.
 
+Datagram sockets provide connectionless unreliable messages of
+a fixed maximum length.
+
 \subsubsection{Buffer Space Management}\label{sec:Device Types / Socket Device / Device Operation / Buffer Space Management}
 \field{buf_alloc} and \field{fwd_cnt} are used for buffer space management of
 stream sockets. The guest and the device publish how much buffer space is
@@ -162,7 +181,7 @@ \subsubsection{Buffer Space Management}\label{sec:Device Types / Socket Device /
 u32 peer_free = peer_buf_alloc - (tx_cnt - peer_fwd_cnt);
 \end{lstlisting}
 
-If there is insufficient buffer space, the sender waits until virtqueue buffers
+For stream sockets, if there is insufficient buffer space, the sender waits until virtqueue buffers
 are returned and checks \field{buf_alloc} and \field{fwd_cnt} again. Sending
 the VIRTIO_VSOCK_OP_CREDIT_REQUEST packet queries how much buffer space is
 available. The reply to this query is a VIRTIO_VSOCK_OP_CREDIT_UPDATE packet.
@@ -170,16 +189,28 @@ \subsubsection{Buffer Space Management}\label{sec:Device Types / Socket Device /
 previously receiving a VIRTIO_VSOCK_OP_CREDIT_REQUEST packet. This allows
 communicating updates any time a change in buffer space occurs.
 
+Unlike stream sockets, dgram sockets do not use VIRTIO_VSOCK_OP_CREDIT_UPDATE or
+VIRTIO_VSOCK_OP_CREDIT_REQUEST packets. The dgram buffer management
+is split to two parts: tx side and rx side. For the tx side, there is
+additional buffer space for each socket.
+The dgram sender sends packets when the virtqueue or the additional buffer is not full.
+When both are full, the sender
+MUST return an appropriate error to the upper layer application.
+For the rx side, dgram also uses the \field{buf_alloc}. If it is full, the packet
+is dropped by the receiver.
+
 \drivernormative{\paragraph}{Device Operation: Buffer Space Management}{Device Types / Socket Device / Device Operation / Buffer Space Management}
-VIRTIO_VSOCK_OP_RW data packets MUST only be transmitted when the peer has
-sufficient free buffer space for the payload.
+For stream sockets, VIRTIO_VSOCK_OP_RW data packets MUST only be transmitted when the peer has
+sufficient free buffer space for the payload. For dgram sockets, VIRTIO_VSOCK_OP_RW data packets
+MAY be transmitted when the peer buffer is full. Then the packet will be dropped by the receiver.
 
 All packets associated with a stream flow MUST contain valid information in
 \field{buf_alloc} and \field{fwd_cnt} fields.
 
 \devicenormative{\paragraph}{Device Operation: Buffer Space Management}{Device Types / Socket Device / Device Operation / Buffer Space Management}
-VIRTIO_VSOCK_OP_RW data packets MUST only be transmitted when the peer has
-sufficient free buffer space for the payload.
+For stream sockets, VIRTIO_VSOCK_OP_RW data packets MUST only be transmitted when the peer has
+sufficient free buffer space for the payload. For dgram sockets, VIRTIO_VSOCK_OP_RW data packets
+MAY be transmitted when the peer buffer is full. Then the packet will be dropped by the receiver.
 
 All packets associated with a stream flow MUST contain valid information in
 \field{buf_alloc} and \field{fwd_cnt} fields.
@@ -203,14 +234,14 @@ \subsubsection{Receive and Transmit}\label{sec:Device Types / Socket Device / De
 The \field{guest_cid} configuration field MUST be used as the source CID when
 sending outgoing packets.
 
-A VIRTIO_VSOCK_OP_RST reply MUST be sent if a packet is received with an
+For stream sockets, A VIRTIO_VSOCK_OP_RST reply MUST be sent if a packet is received with an
 unknown \field{type} value.
 
 \devicenormative{\paragraph}{Device Operation: Receive and Transmit}{Device Types / Socket Device / Device Operation / Receive and Transmit}
 
 The \field{guest_cid} configuration field MUST NOT contain a reserved CID as listed in \ref{sec:Device Types / Socket Device / Device configuration layout}.
 
-A VIRTIO_VSOCK_OP_RST reply MUST be sent if a packet is received with an
+For stream sockets, A VIRTIO_VSOCK_OP_RST reply MUST be sent if a packet is received with an
 unknown \field{type} value.
 
 \subsubsection{Stream Sockets}\label{sec:Device Types / Socket Device / Device Operation / Stream Sockets}
@@ -240,6 +271,17 @@ \subsubsection{Stream Sockets}\label{sec:Device Types / Socket Device / Device O
 destination) address tuple for a new connection while the other peer is still
 processing the old connection.
 
+\subsubsection{Datagram Sockets}\label{sec:Device Types / Socket Device / Device Operation / Stream Sockets}
+
+Datagram (dgram) sockets are connectionless and unreliable. The sender just sends
+a message to the peer and hope it will be delivered. A VIRTIO_VSOCK_OP_RST reply is sent if
+a receiving socket does not exist on the destination.
+If the transmission or receiving buffers are full, the packets
+are dropped. If the transmission buffer is full, an appropriate error message
+is returned to the caller.
+
+Dgram sockets preserve the message boundaries.
+
 \subsubsection{Device Events}\label{sec:Device Types / Socket Device / Device Operation / Device Events}
 
 Certain events are communicated by the device to the driver using the event
-- 
2.11.0

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
