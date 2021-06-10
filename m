Return-Path: <SRS0=uiEo=LE=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9A00C48BDF
	for <virtualization@archiver.kernel.org>; Thu, 10 Jun 2021 18:39:52 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 50EBB613DD
	for <virtualization@archiver.kernel.org>; Thu, 10 Jun 2021 18:39:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 50EBB613DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=bytedance.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 1658960A92;
	Thu, 10 Jun 2021 18:39:52 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ihcomxLRQy4y; Thu, 10 Jun 2021 18:39:51 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 886C06067A;
	Thu, 10 Jun 2021 18:39:50 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 40215C000E;
	Thu, 10 Jun 2021 18:39:50 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 8113BC000B
 for <virtualization@lists.linux-foundation.org>;
 Thu, 10 Jun 2021 18:39:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 60CB5405A0
 for <virtualization@lists.linux-foundation.org>;
 Thu, 10 Jun 2021 18:39:48 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=bytedance-com.20150623.gappssmtp.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id H7Yw2vYOX_3U
 for <virtualization@lists.linux-foundation.org>;
 Thu, 10 Jun 2021 18:39:46 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com
 [IPv6:2607:f8b0:4864:20::52e])
 by smtp4.osuosl.org (Postfix) with ESMTPS id D8FFB40585
 for <virtualization@lists.linux-foundation.org>;
 Thu, 10 Jun 2021 18:39:46 +0000 (UTC)
Received: by mail-pg1-x52e.google.com with SMTP id t17so467749pga.5
 for <virtualization@lists.linux-foundation.org>;
 Thu, 10 Jun 2021 11:39:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance-com.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id;
 bh=a/2keV94P+ud71lUAkepex4el51Gz6xOrkcmuSyZrA4=;
 b=MYGoncXWASedCdczq3uSx8ASZ7sLni5dc89ogSoUdtxtX96JK2Mfnj9+vUFZxvRteR
 Q7RP82jWr/fDq6R0mf0fRjNP6uGKSuREiUdPvIa+7L2zWZs0goFn8+v+EGIKojiOaOF+
 y+9Wj63O/t1iCZPVBqcb3vxvFpSj5XC9+Qyhz0lda7SF2E9akIs3g4z86MsEL7LzuzgR
 KN3ChiYxmxAwmjdo/jeYqgX8/BR192g5qGta1e7lQbZiDoIeM9idvk9QqTHxjxpklbWF
 UYDITumKVVWoilIwEVmVniIHl8wrI00hW9kRi5RejLb9rBS35SD1+jLB1ekLWXRTLBzA
 pshQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=a/2keV94P+ud71lUAkepex4el51Gz6xOrkcmuSyZrA4=;
 b=QnIHDD8Tj8c8fDUkyaCTR0UPyN5zRL+BaAccsJFJv7TgCIBJ06Wk5lPMCruCOyiGQC
 aPa9R5xcbuvYkAvI0ywu/eKmUAXuVD4r6ovep+7XhbCTKO2E3BJHASL3cTBeBeeA5qGH
 xMwCKHWvpZDYGVplstEiknRyk+TqgeLzqk9zgySBLKxjg2YL9RZZLuj6sNkkl5JCxTes
 XgXc4mAC2CWRyZK6v3jdvvJuYEZ/Rw9N6chjDKnBfZ9zUfIox/U5/u5tN2pgbdRoZOZd
 dj9pLggnvJ6weJZ7UGZWwVUvIhWHuCZLjiKRJ6gGdL+YT8h8eXC4mFVZ1EYvqTJfNQdF
 NT0Q==
X-Gm-Message-State: AOAM533iySrCErfpdrLimenqO+iqinZhOhzxq3AY1Ll3cPhjbBqEt1nt
 OqZ4T8+zwK7hMXJ9AVG7T5rphQ==
X-Google-Smtp-Source: ABdhPJyDlL7ZoI8OA97y51SG5/S9LjsgEBBUYrEZQ1qytEbIohOqE22BWwVq8lj0zkb1Hnhmh0TPVA==
X-Received: by 2002:a63:e709:: with SMTP id b9mr6228052pgi.18.1623350385513;
 Thu, 10 Jun 2021 11:39:45 -0700 (PDT)
Received: from n124-121-013.byted.org
 (ec2-54-241-92-238.us-west-1.compute.amazonaws.com. [54.241.92.238])
 by smtp.gmail.com with ESMTPSA id q24sm3248950pgk.32.2021.06.10.11.39.44
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 10 Jun 2021 11:39:45 -0700 (PDT)
From: Jiang Wang <jiang.wang@bytedance.com>
To: mst@redhat.com,
	cohuck@redhat.com,
	virtio-comment@lists.oasis-open.org
Subject: [RFC PATCH v1] vsock: add mergeable rx buffer description
Date: Thu, 10 Jun 2021 18:39:35 +0000
Message-Id: <20210610183935.1000999-1-jiang.wang@bytedance.com>
X-Mailer: git-send-email 2.11.0
Cc: cong.wang@bytedance.com, duanxiongchun@bytedance.com,
 virtualization@lists.linux-foundation.org, xieyongji@bytedance.com,
 chaiwen.cc@bytedance.com, stefanha@redhat.com, asias@redhat.com,
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
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

Mergeable rx buffer is already supported by virtio-net, and
it can save memory for big packets. It will also be beneficial
for the vsock devices, so add it to the spec.

---
V0 -> V1: I send similar patch with vsock dgram before and 
already got some comments. This version fixed those,such as
use present tense for feature bit etc. Also the feature bit
value is 3, because we expect to have some other featue bits
defined soon.

 virtio-vsock.tex | 78 +++++++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 77 insertions(+), 1 deletion(-)

diff --git a/virtio-vsock.tex b/virtio-vsock.tex
index da7e641..d529291 100644
--- a/virtio-vsock.tex
+++ b/virtio-vsock.tex
@@ -16,7 +16,9 @@ \subsection{Virtqueues}\label{sec:Device Types / Socket Device / Virtqueues}
 
 \subsection{Feature bits}\label{sec:Device Types / Socket Device / Feature bits}
 
-There are currently no feature bits defined for this device.
+\begin{description}
+\item[VIRTIO_VSOCK_F_MRG_RXBUF (3)] Driver can merge receive buffers.
+\end{description}
 
 \subsection{Device configuration layout}\label{sec:Device Types / Socket Device / Device configuration layout}
 
@@ -64,6 +66,8 @@ \subsection{Device Operation}\label{sec:Device Types / Socket Device / Device Op
 
 Packets transmitted or received contain a header before the payload:
 
+If feature VIRTIO_VSOCK_F_MRG_RXBUF is not negotiated, use the following header.
+
 \begin{lstlisting}
 struct virtio_vsock_hdr {
 	le64 src_cid;
@@ -79,6 +83,15 @@ \subsection{Device Operation}\label{sec:Device Types / Socket Device / Device Op
 };
 \end{lstlisting}
 
+If feature VIRTIO_VSOCK_F_MRG_RXBUF is negotiated, use the following header.
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
@@ -170,6 +183,23 @@ \subsubsection{Buffer Space Management}\label{sec:Device Types / Socket Device /
 previously receiving a VIRTIO_VSOCK_OP_CREDIT_REQUEST packet. This allows
 communicating updates any time a change in buffer space occurs.
 
+\drivernormative{\paragraph}{Device Operation: Buffer Space Management}{Device Types / Socket Device / Device Operation / Setting Up Receive Buffers}
+\begin{itemize}
+\item If VIRTIO_VSOCK_F_MRG_RXBUF is negotiated, each buffer MUST be at
+least the size of the struct virtio_vsock_hdr_mgr_rxbuf.
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
 VIRTIO_VSOCK_OP_RW data packets MUST only be transmitted when the peer has
 sufficient free buffer space for the payload.
@@ -188,6 +218,7 @@ \subsubsection{Receive and Transmit}\label{sec:Device Types / Socket Device / De
 The driver queues outgoing packets on the tx virtqueue and incoming packet
 receive buffers on the rx virtqueue. Packets are of the following form:
 
+If VIRTIO_VSOCK_F_MRG_RXBUF is not negotiated, use the following.
 \begin{lstlisting}
 struct virtio_vsock_packet {
     struct virtio_vsock_hdr hdr;
@@ -195,9 +226,41 @@ \subsubsection{Receive and Transmit}\label{sec:Device Types / Socket Device / De
 };
 \end{lstlisting}
 
+Otherwise, use the following form:
+\begin{lstlisting}
+struct virtio_vsock_packet_mrg_rxbuf {
+    struct virtio_vsock_hdr_mrg_rxbuf hdr;
+    u8 data[];
+};
+\end{lstlisting}
+
 Virtqueue buffers for outgoing packets are read-only. Virtqueue buffers for
 incoming packets are write-only.
 
+When transmitting packets to the device, \field{num_buffers} is not used.
+
+\begin{enumerate}
+\item \field{num_buffers} indicates how many descriptors
+  this packet is spread over (including this one). 
+  This is valid only if VIRTIO_VSOCK_F_MRG_RXBUF is negotiated.
+  This allows receipt of large packets without having to allocate large
+  buffers: a packet that does not fit in a single buffer can flow
+  over to the next buffer, and so on. In this case, there will be
+  at least \field{num_buffers} used buffers in the virtqueue, and the device
+  chains them together to form a single packet in a way similar to
+  how it would store it in a single buffer spread over multiple
+  descriptors.
+  The other buffers will not begin with a struct virtio_vsock_hdr.
+
+  If VIRTIO_VSOCK_F_MRG_RXBUF is not negotiated, then only one
+  descriptor is used.
+
+\item If
+  \field{num_buffers} is one, then the entire packet will be
+  contained within this buffer, immediately following the struct
+  virtio_vsock_hdr.
+\end{enumerate}
+
 \drivernormative{\paragraph}{Device Operation: Receive and Transmit}{Device Types / Socket Device / Device Operation / Receive and Transmit}
 
 The \field{guest_cid} configuration field MUST be used as the source CID when
@@ -213,6 +276,19 @@ \subsubsection{Receive and Transmit}\label{sec:Device Types / Socket Device / De
 A VIRTIO_VSOCK_OP_RST reply MUST be sent if a packet is received with an
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
-- 
2.11.0

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
