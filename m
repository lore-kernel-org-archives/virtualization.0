Return-Path: <SRS0=l8rc=LD=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5588C47095
	for <virtualization@archiver.kernel.org>; Wed,  9 Jun 2021 07:17:39 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 557E261002
	for <virtualization@archiver.kernel.org>; Wed,  9 Jun 2021 07:17:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 557E261002
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 25A65827AF;
	Wed,  9 Jun 2021 07:17:39 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id dXRCu9UQoyYk; Wed,  9 Jun 2021 07:17:37 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 3DB0083A9A;
	Wed,  9 Jun 2021 07:17:37 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id EEBD1C000E;
	Wed,  9 Jun 2021 07:17:36 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 98239C0011
 for <virtualization@lists.linux-foundation.org>;
 Wed,  9 Jun 2021 07:17:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 8706483AFD
 for <virtualization@lists.linux-foundation.org>;
 Wed,  9 Jun 2021 07:17:35 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id VgvRwkQN9WKd
 for <virtualization@lists.linux-foundation.org>;
 Wed,  9 Jun 2021 07:17:34 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id DE62583A9A
 for <virtualization@lists.linux-foundation.org>;
 Wed,  9 Jun 2021 07:17:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1623223052;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=D1twwbt4piJxwofY3G7NLbqixcY+nD6hCDzcQKBHGMY=;
 b=IQYo9MVgKlaimvGWevXe34LPR3oT0s5I402CLxa3Wj1EY3Mji2bkuEGzcdYlBwHRWdDMox
 7U8uZxGlxaFWn7A6eKiZqFPInmTTPTFsE3t9hqShZDJD1/ByQqbqEDk50OPlxccnXjPMOC
 TEBBkhKZ4RKcDT/keLuuxH3mCg326eE=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-401-H2d6sR_vMe2d_P3uNPNjaA-1; Wed, 09 Jun 2021 03:17:30 -0400
X-MC-Unique: H2d6sR_vMe2d_P3uNPNjaA-1
Received: by mail-ej1-f69.google.com with SMTP id
 p5-20020a17090653c5b02903db1cfa514dso7629980ejo.13
 for <virtualization@lists.linux-foundation.org>;
 Wed, 09 Jun 2021 00:17:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=D1twwbt4piJxwofY3G7NLbqixcY+nD6hCDzcQKBHGMY=;
 b=f8TubiBZbzEkr9vaAVXAtdYHQI8L6ru9wsVW3F8DYC5JH3j8GbuHWbpY4WB8d+SQ+c
 Ffjk8/oUFtJ+qkKVSX4BVGH/MRu4TiO5cToAGscPJ+weSsvTzt1nOtNmjS0IN3qm/VDP
 9ASIjM2VF/kdJadW38jw1pEf2qavJLj7i5a4zqUmAje9z5V2p4EP1WQG719kDsD6Adwv
 TVzbE838T9JlZNQustfFDW/QWHWdo8YOw/veYTRKmVwBiKiBODFhpy3DpzRQD0fBDbzR
 ZhyEEJHMUaK9Pzmfp/PbZ6Fz8DWnTkcQDFizdOx0w6zfbAS+ewXCkUzdhDPdxOqMJ5iK
 ARFg==
X-Gm-Message-State: AOAM533UR6QXk8ReCbasLzHn9T6qGz8P2nXx6bYL1u0xpfOIzA2PGbEe
 q2gq0j8akRdNqJG1IOsWXecF7pWgTwQvnuPuxGe2sx0tesVQlKQckUqiL3IuyExMPipvb/HQg2B
 OxWsgzDvhnlfWd7wFYX1IXEIpCfdTB2D10pbMTe7fHg==
X-Received: by 2002:a05:6402:4301:: with SMTP id
 m1mr9913758edc.303.1623223048784; 
 Wed, 09 Jun 2021 00:17:28 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy4G0esvSMxR28K+oayQBDtPtHebJc/ZcPsT31+RxU2keyH/y7oHMDW2aI6xSO6GgcC+UyvzQ==
X-Received: by 2002:a05:6402:4301:: with SMTP id
 m1mr9913734edc.303.1623223048495; 
 Wed, 09 Jun 2021 00:17:28 -0700 (PDT)
Received: from steredhat (host-79-18-148-79.retail.telecomitalia.it.
 [79.18.148.79])
 by smtp.gmail.com with ESMTPSA id d5sm756951edt.49.2021.06.09.00.17.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 09 Jun 2021 00:17:27 -0700 (PDT)
Date: Wed, 9 Jun 2021 09:17:25 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: "Jiang Wang ." <jiang.wang@bytedance.com>
Subject: Re: [External] Re: [RFC v4] virtio-vsock: add description for
 datagram type
Message-ID: <20210609071725.627yqnmkzadwpubp@steredhat>
References: <20210528040118.3253836-1-jiang.wang@bytedance.com>
 <20210608134601.5qs46xdn7bzaob77@steredhat>
 <CAP_N_Z9-C0zgXzRXX_vm37cK6-q1Qv+0CErMkMTHGjMgcTs-6Q@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAP_N_Z9-C0zgXzRXX_vm37cK6-q1Qv+0CErMkMTHGjMgcTs-6Q@mail.gmail.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=sgarzare@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: cong.wang@bytedance.com, Xiongchun Duan <duanxiongchun@bytedance.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, cohuck@redhat.com,
 virtualization@lists.linux-foundation.org,
 Yongji Xie <xieyongji@bytedance.com>,
 =?utf-8?B?5p+056iz?= <chaiwen.cc@bytedance.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, virtio-comment@lists.oasis-open.org,
 asias@redhat.com, Arseny Krasnov <arseny.krasnov@kaspersky.com>,
 Jorgen Hansen <jhansen@vmware.com>
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

On Tue, Jun 08, 2021 at 09:22:26PM -0700, Jiang Wang . wrote:
>On Tue, Jun 8, 2021 at 6:46 AM Stefano Garzarella <sgarzare@redhat.com> wrote:
>>
>> On Fri, May 28, 2021 at 04:01:18AM +0000, Jiang Wang wrote:
>> >From: "jiang.wang" <jiang.wang@bytedance.com>
>> >
>> >Add supports for datagram type for virtio-vsock. Datagram
>> >sockets are connectionless and unreliable. To avoid contention
>> >with stream and other sockets, add two more virtqueues and
>> >a new feature bit to identify if those two new queues exist or not.
>> >
>> >Also add descriptions for resource management of datagram, which
>> >does not use the existing credit update mechanism associated with
>> >stream sockets.
>> >
>> >Signed-off-by: Jiang Wang <jiang.wang@bytedance.com>
>> >---
>> >
>> >V2: addressed the comments for the previous version.
>> >V3: add description for the mergeable receive buffer.
>> >V4: add a feature bit for stream and reserver a bit for seqpacket.
>> >Fix mrg_rxbuf related sentences.
>> >
>> > virtio-vsock.tex | 155 ++++++++++++++++++++++++++++++++++++++++++++++++++-----
>> > 1 file changed, 142 insertions(+), 13 deletions(-)
>> >
>> >diff --git a/virtio-vsock.tex b/virtio-vsock.tex
>> >index da7e641..bacac3c 100644
>> >--- a/virtio-vsock.tex
>> >+++ b/virtio-vsock.tex
>> >@@ -9,14 +9,41 @@ \subsection{Device ID}\label{sec:Device Types / Socket Device / Device ID}
>> >
>> > \subsection{Virtqueues}\label{sec:Device Types / Socket Device / Virtqueues}
>> > \begin{description}
>> >-\item[0] rx
>> >-\item[1] tx
>> >+\item[0] stream rx
>> >+\item[1] stream tx
>> >+\item[2] datagram rx
>> >+\item[3] datagram tx
>> >+\item[4] event
>>
>> Is there a particular reason to always have the event queue as the last
>> one?
>>
>> Maybe it's better to add the datagram queues at the bottom, so the first
>> 3 queues are always the same.
>>
>I am not sure. I think Linux kernel should be fine with what you described.
>But I am not sure about QEMU. From the code, I see virtqueue is allocated
>as an array, like following,
>
>+ #ifdef CONFIG_VHOST_VSOCK_DGRAM
>+    struct vhost_virtqueue vhost_vqs[4];
>+ #else
>    struct vhost_virtqueue vhost_vqs[2];
>+ #endi

I see, also vhost_dev_init() requires an array, so I agree that this is 
the best approach, sorry for the noise.

Just to be sure to check that anything is working if 
CONFIG_VHOST_VSOCK_DGRAM is defined, but the guest has an old driver 
that doesn't support DGRAM, and viceversa.

>
>so I assume the virtqueues for tx/rx should be
>continuous? I can try to put the new queues at the end and see if it
>works or not.
>
>btw, my qemu change is here:
>https://github.com/Jiang1155/qemu/commit/6307aa7a0c347905a31f3ca6577923e2f6dd9d84
>
>> >+\end{description}
>> >+The virtio socket device uses 5 queues if feature bit VIRTIO_VSOCK_F_DRGAM is set. Otherwise, it
>> >+only uses 3 queues, as the following.
>> >+
>> >+\begin{description}
>> >+\item[0] stream rx
>> >+\item[1] stream tx
>> > \item[2] event
>> > \end{description}
>> >
>> >+When behavior differs between stream and datagram rx/tx virtqueues
>> >+their full names are used. Common behavior is simply described in
>> >+terms of rx/tx virtqueues and applies to both stream and datagram
>> >+virtqueues.
>> >+
>> > \subsection{Feature bits}\label{sec:Device Types / Socket Device / Feature bits}
>> >
>> >-There are currently no feature bits defined for this device.
>> >+\begin{description}
>> >+\item[VIRTIO_VSOCK_F_STREAM (0)] Device has support for stream socket type.
>> >+\end{description}
>> >+
>> >+\begin{description}
>> >+\item[VIRTIO_VSOCK_F_DGRAM (2)] Device has support for datagram socket
>> >type.
>> >+\end{description}
>> >+
>> >+\begin{description}
>> >+\item[VIRTIO_VSOCK_F_MRG_RXBUF (3)] Driver can merge receive buffers.
>> >+\end{description}
>> >+
>> >+If no feature bits are defined, then assume only VIRTIO_VSOCK_F_STREAM
>> >is set.
>>
>> I'd say more like socket streams are supported, without reference to the
>> feature bit, something like: "If no feature bits are defined, then
>> assume device only supports stream socket type."
>>
>OK.
>
>> >
>> > \subsection{Device configuration layout}\label{sec:Device Types / Socket Device / Device configuration layout}
>> >
>> >@@ -64,6 +91,8 @@ \subsection{Device Operation}\label{sec:Device Types / Socket Device / Device Op
>> >
>> > Packets transmitted or received contain a header before the payload:
>> >
>> >+If feature VIRTIO_VSOCK_F_MRG_RXBUF is not negotiated, use the following header.
>> >+
>> > \begin{lstlisting}
>> > struct virtio_vsock_hdr {
>> >       le64 src_cid;
>> >@@ -79,6 +108,15 @@ \subsection{Device Operation}\label{sec:Device Types / Socket Device / Device Op
>> > };
>> > \end{lstlisting}
>> >
>> >+If feature VIRTIO_VSOCK_F_MRG_RXBUF is negotiated, use the following header.
>> >+\begin{lstlisting}
>> >+struct virtio_vsock_hdr_mrg_rxbuf {
>> >+      struct virtio_vsock_hdr hdr;
>> >+      le16 num_buffers;
>> >+};
>> >+\end{lstlisting}
>> >+
>> >+
>> > The upper 32 bits of src_cid and dst_cid are reserved and zeroed.
>> >
>> > Most packets simply transfer data but control packets are also used for
>> >@@ -107,6 +145,9 @@ \subsection{Device Operation}\label{sec:Device Types / Socket Device / Device Op
>> >
>> > \subsubsection{Virtqueue Flow Control}\label{sec:Device Types / Socket Device / Device Operation / Virtqueue Flow Control}
>> >
>> >+Flow control applies to stream sockets; datagram sockets do not have
>> >+flow control.
>> >+
>> > The tx virtqueue carries packets initiated by applications and replies to
>> > received packets.  The rx virtqueue carries packets initiated by the device and
>> > replies to previously transmitted packets.
>> >@@ -140,12 +181,15 @@ \subsubsection{Addressing}\label{sec:Device Types / Socket Device / Device Opera
>> > consists of a (cid, port number) tuple. The header fields used for this are
>> > \field{src_cid}, \field{src_port}, \field{dst_cid}, and \field{dst_port}.
>> >
>> >-Currently only stream sockets are supported. \field{type} is 1 for
>> >stream
>> >-socket types.
>> >+Currently stream and datagram (dgram) sockets are supported. \field{type} is 1 for stream
>> >+socket types. \field{type} is 3 for dgram socket types.
>>
>> When Arseny's change will merged, we can define and use
>> VIRTIO_VSOCK_TYPE_DGRAM,.
>
>Sure.
>> >
>> > Stream sockets provide in-order, guaranteed, connection-oriented
>> > delivery
>> > without message boundaries.
>> >
>> >+Datagram sockets provide unordered, unreliable, connectionless
>> >messages
>> >+with message boundaries and a maximum length.
>> >+
>> > \subsubsection{Buffer Space Management}\label{sec:Device Types / Socket Device / Device Operation / Buffer Space Management}
>> > \field{buf_alloc} and \field{fwd_cnt} are used for buffer space
>> > management of
>> > stream sockets. The guest and the device publish how much buffer space is
>> >@@ -162,7 +206,7 @@ \subsubsection{Buffer Space Management}\label{sec:Device Types / Socket Device /
>> > u32 peer_free = peer_buf_alloc - (tx_cnt - peer_fwd_cnt);
>> > \end{lstlisting}
>> >
>> >-If there is insufficient buffer space, the sender waits until virtqueue buffers
>> >+For stream sockets, if there is insufficient buffer space, the sender waits until virtqueue buffers
>> > are returned and checks \field{buf_alloc} and \field{fwd_cnt} again. Sending
>> > the VIRTIO_VSOCK_OP_CREDIT_REQUEST packet queries how much buffer space is
>> > available. The reply to this query is a VIRTIO_VSOCK_OP_CREDIT_UPDATE packet.
>> >@@ -170,24 +214,55 @@ \subsubsection{Buffer Space Management}\label{sec:Device Types / Socket Device /
>> > previously receiving a VIRTIO_VSOCK_OP_CREDIT_REQUEST packet. This allows
>> > communicating updates any time a change in buffer space occurs.
>> >
>> >+Unlike stream sockets, dgram sockets do not use VIRTIO_VSOCK_OP_CREDIT_UPDATE or
>> >+VIRTIO_VSOCK_OP_CREDIT_REQUEST packets. The dgram buffer management
>> >+is split to two parts: tx side and rx side. For the tx side, if the
>>
>> Maybe better to use sender and receiver, since we use tx and rx to
>> identify the queues.
>
>OK.
>
>> >+virtqueue is full, the packet will be dropped.
>> >+For the rx side, dgram also uses the \field{buf_alloc}. If it is full, the packet
>> >+is dropped by the receiver.
>>
>> This sentence is a bit unclear.
>> `buf_alloc` for stream socket is used to inform the other peer about the
>> receive buffer space. In this case we are using the local information,
>> so there is no need to refer to `buf_alloc`. We can write something
>> like: "The packet is dropped by the receiver if there is no space in the
>> receive buffer".
>
>OK.
>
>> >+
>> >+\drivernormative{\paragraph}{Device Operation: Buffer Space Management}{Device Types / Socket Device / Device Operation / Setting Up Receive Buffers}
>> >+\begin{itemize}
>> >+\item If VIRTIO_VSOCK_F_MRG_RXBUF is not negotiated, the driver SHOULD populate the receive queue(s)
>> >+      with buffers of at least 1526 bytes for stream sockets and 4096
>> >bytes for datagram sockets.
>>
>> Where does 1526 come from?
>
>No specific reason. Any recommendations?
>
>> We're adding a requirement for socket streams that wasn't there until
>> now.
>
>This is only when mergeable rxbuf bit is used. I think before this, the stream
>rx buf should be at least bigger than the pkt header. We just did not put that
>into the spec.

Mmm, I'm confused now. The statement says "If VIRTIO_VSOCK_F_MRG_RXBUF
is not negotiated"
    ^

Is it a typo?


IIUC when VIRTIO_VSOCK_F_MRG_RXBUF is negotiated the minimum buffer size 
is virtio_vsock_hdr_mgr_rxbuf...

>
>> >+\item If VIRTIO_VSOCK_F_MRG_RXBUF is negotiated, each buffer MUST be at
>> >+least the size of the struct virtio_vsock_hdr_mgr_rxbuf.

... from this ^ statement.

And I agree that rx buf should be at least the virtio_vsock_hdr size.

>> >+\end{itemize}
>> >+
>> >+\begin{note}
>> >+Obviously each buffer can be split across multiple descriptor 
>> >elements.
>> >+\end{note}
>> >+
>> >+\devicenormative{\paragraph}{Device Operation: Buffer Space Management}{Device Types / Socket Device / Device Operation / Setting Up Receive Buffers}
>> >+The device MUST set \field{num_buffers} to the number of descriptors used when
>> >+transmitting the  packet.
>> >+
>> >+The device MUST use only a single descriptor if VIRTIO_VSOCK_F_MRG_RXBUF
>> >+is not negotiated.
>> >+
>> > \drivernormative{\paragraph}{Device Operation: Buffer Space Management}{Device Types / Socket Device / Device Operation / Buffer Space Management}
>> >-VIRTIO_VSOCK_OP_RW data packets MUST only be transmitted when the peer has
>> >-sufficient free buffer space for the payload.
>> >+For stream sockets, VIRTIO_VSOCK_OP_RW data packets MUST only be transmitted when the peer has
>> >+sufficient free buffer space for the payload. For dgram sockets, VIRTIO_VSOCK_OP_RW data packets
>> >+MAY be transmitted when the peer rx buffer is full. Then the packet will be dropped by the peer,
>> >+and driver will not get any notification.
>> >
>> > All packets associated with a stream flow MUST contain valid
>> > information in
>> > \field{buf_alloc} and \field{fwd_cnt} fields.
>> >
>> > \devicenormative{\paragraph}{Device Operation: Buffer Space Management}{Device Types / Socket Device / Device Operation / Buffer Space Management}
>> >-VIRTIO_VSOCK_OP_RW data packets MUST only be transmitted when the peer has
>> >-sufficient free buffer space for the payload.
>> >+For stream sockets, VIRTIO_VSOCK_OP_RW data packets MUST only be transmitted when the peer has
>> >+sufficient free buffer space for the payload. For dgram sockets, 
>> >VIRTIO_VSOCK_OP_RW data packets
>> >+MAY be transmitted when the peer rx buffer is full. Then the packet will be dropped by the peer,
>> >+and the device will not get any notification.
>> >
>> > All packets associated with a stream flow MUST contain valid information in
>> > \field{buf_alloc} and \field{fwd_cnt} fields.
>> >
>> > \subsubsection{Receive and Transmit}\label{sec:Device Types / Socket Device / Device Operation / Receive and Transmit}
>> >-The driver queues outgoing packets on the tx virtqueue and incoming 
>> >packet
>> >+The driver queues outgoing packets on the tx virtqueue and allocates incoming packet
>> > receive buffers on the rx virtqueue. Packets are of the following form:
>> >
>> >+If VIRTIO_VSOCK_F_MRG_RXBUF was not negotiated, use the following.
>>
>> Please use present as in the rest of the document,
>
>Sure. I see both past tense and present tense in the spec, so I was a 
>little bit confused.

Sorry about that. I generally always saw the present tense and seemed to 
use it everywhere.

>
>> > \begin{lstlisting}
>> > struct virtio_vsock_packet {
>> >     struct virtio_vsock_hdr hdr;
>> >@@ -195,24 +270,70 @@ \subsubsection{Receive and Transmit}\label{sec:Device Types / Socket Device / De
>> > };
>> > \end{lstlisting}
>> >
>> >+Otherwise, use the following form:
>>
>> Maybe better to repeat:
>>
>> If VIRTIO_VSOCK_F_MRG_RXBUF is negotiated...
>>
>OK.
>
>> >+\begin{lstlisting}
>> >+struct virtio_vsock_packet_mrg_rxbuf {
>> >+    struct virtio_vsock_hdr_mrg_rxbuf hdr;
>> >+    u8 data[];
>> >+};
>> >+\end{lstlisting}
>> >+
>> >+
>> > Virtqueue buffers for outgoing packets are read-only. Virtqueue buffers for
>> > incoming packets are write-only.
>> >
>> >+When transmitting packets to the device, \field{num_buffers} is not
>> >used.
>> >+
>> >+\begin{enumerate}
>> >+\item \field{num_buffers} indicates how many descriptors
>> >+  this packet is spread over (including this one).
>> >+  This is valid only if VIRTIO_VSOCK_F_MRG_RXBUF was negotiated.
>> >+  This allows receipt of large packets without having to allocate large
>> >+  buffers: a packet that does not fit in a single buffer can flow
>> >+  over to the next buffer, and so on. In this case, there will be
>> >+  at least \field{num_buffers} used buffers in the virtqueue, and the device
>> >+  chains them together to form a single packet in a way similar to
>> >+  how it would store it in a single buffer spread over multiple
>> >+  descriptors.
>> >+  The other buffers will not begin with a struct virtio_vsock_hdr.
>> >+
>> >+  If VIRTIO_VSOCK_F_MRG_RXBUF was not negotiated, then only one
>> >+  descriptor is used.
>> >+
>> >+\item If
>> >+  \field{num_buffers} is one, then the entire packet will be
>> >+  contained within this buffer, immediately following the struct
>> >+  virtio_vsock_hdr.
>> >+\end{enumerate}
>> >+
>> > \drivernormative{\paragraph}{Device Operation: Receive and
>> > Transmit}{Device Types / Socket Device / Device Operation / Receive
>> > and Transmit}
>> >
>> > The \field{guest_cid} configuration field MUST be used as the source CID when
>> > sending outgoing packets.
>> >
>> >-A VIRTIO_VSOCK_OP_RST reply MUST be sent if a packet is received with an
>> >+For stream and datagram sockets, A VIRTIO_VSOCK_OP_RST reply MUST be
>>
>> Perhaps we can leave it as it was before, since the `type` field
>> identifies the socket type itself.
>
>OK.
>
>> >sent if a packet is received with an
>> > unknown \field{type} value.
>> >
>> > \devicenormative{\paragraph}{Device Operation: Receive and Transmit}{Device Types / Socket Device / Device Operation / Receive and Transmit}
>> >
>> > The \field{guest_cid} configuration field MUST NOT contain a reserved CID as listed in \ref{sec:Device Types / Socket Device / Device configuration layout}.
>> >
>> >-A VIRTIO_VSOCK_OP_RST reply MUST be sent if a packet is received with an
>> >+For stream and datagram sockets, A VIRTIO_VSOCK_OP_RST reply MUST 
>> >be sent if a packet is received with an
>> > unknown \field{type} value.
>>
>> Ditto.
>
>OK.
>
>> >
>> >+If VIRTIO_VSOCK_F_MRG_RXBUF has been negotiated, the device MUST set
>> >+\field{num_buffers} to indicate the number of buffers
>> >+the packet (including the header) is spread over.
>> >+
>> >+If a receive packet is spread over multiple buffers, the device
>> >+MUST use all buffers but the last (i.e. the first $\field{num_buffers} -
>> >+1$ buffers) completely up to the full length of each buffer
>> >+supplied by the driver.
>> >+
>> >+The device MUST use all buffers used by a single receive
>> >+packet together, such that at least \field{num_buffers} are
>> >+observed by driver as used.
>> >+
>> > \subsubsection{Stream Sockets}\label{sec:Device Types / Socket 
>> > Device / Device Operation / Stream Sockets}
>> >
>> > Connections are established by sending a VIRTIO_VSOCK_OP_REQUEST packet. If a
>> >@@ -240,6 +361,14 @@ \subsubsection{Stream Sockets}\label{sec:Device Types / Socket Device / Device O
>> > destination) address tuple for a new connection while the other peer is still
>> > processing the old connection.
>> >
>> >+\subsubsection{Datagram Sockets}\label{sec:Device Types / Socket Device / Device Operation / Datagram Sockets}
>> >+
>> >+Datagram (dgram) sockets are connectionless and unreliable. The sender just sends
>> >+a message to the peer and hopes it will be delivered. A VIRTIO_VSOCK_OP_RST reply is sent if
>> >+a receiving socket does not exist on the destination.
>> >+If the transmission or receiving buffers are full, the packets
>> >+are dropped.
>> >+
>> > \subsubsection{Device Events}\label{sec:Device Types / Socket Device / Device Operation / Device Events}
>> >
>> > Certain events are communicated by the device to the driver using the event
>> >--
>> >2.11.0
>> >
>>
>> I don't know if maybe it's better to break this patch in two, one 
>> where
>> we add datagram and one for mergeable buffer.
>>
>> But let's see what others think.
>
>OK. I can definitely break it to two patches if necessary. Thanks for
>all the comments.

Thanks,
Stefano

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
