Return-Path: <SRS0=uiEo=LE=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 203F8C47094
	for <virtualization@archiver.kernel.org>; Thu, 10 Jun 2021 06:56:24 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BAA37613E4
	for <virtualization@archiver.kernel.org>; Thu, 10 Jun 2021 06:56:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BAA37613E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 85FEE40142;
	Thu, 10 Jun 2021 06:56:23 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id IsIjCnW18FiB; Thu, 10 Jun 2021 06:56:22 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id A2A69403EC;
	Thu, 10 Jun 2021 06:56:21 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 72E76C000D;
	Thu, 10 Jun 2021 06:56:21 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 26DFEC000B
 for <virtualization@lists.linux-foundation.org>;
 Thu, 10 Jun 2021 06:56:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 0799083C73
 for <virtualization@lists.linux-foundation.org>;
 Thu, 10 Jun 2021 06:56:20 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 9kvxR1P_CVMB
 for <virtualization@lists.linux-foundation.org>;
 Thu, 10 Jun 2021 06:56:18 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id A277583C6F
 for <virtualization@lists.linux-foundation.org>;
 Thu, 10 Jun 2021 06:56:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1623308177;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=1KbSUofFD7f0SqleAYF11F9S46D73e/ANh9iPSLHD9A=;
 b=F16Jz86nAAvIqwTqhT3CFzmcY/L8HOYby9eF8RPVt2/L69BQyIHGxaaguILdlEwgKGJvYW
 idL42iN9af3/l2vRNHNydF9KEhAuWTLZySuWhuAtGJCiIJaQ1MiLGvuoN3gKkbw4fugD9R
 CrVDpYvXMthD4qeqaH03nMsnfqdk6SE=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-453-2vExCmMmN2Sce83Xk28aig-1; Thu, 10 Jun 2021 02:56:15 -0400
X-MC-Unique: 2vExCmMmN2Sce83Xk28aig-1
Received: by mail-ej1-f69.google.com with SMTP id
 gv42-20020a1709072beab02903eab8e33118so8615677ejc.19
 for <virtualization@lists.linux-foundation.org>;
 Wed, 09 Jun 2021 23:56:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=1KbSUofFD7f0SqleAYF11F9S46D73e/ANh9iPSLHD9A=;
 b=Ix3pgRb8mNYhG1sQYaeFFNEvRrTCL3bnXBRdfBC7J57Lht2cRYQ0RzUg4uXp/7ZiYS
 bk9Y1sXW2fkcoVtQeI3vU9klsWSMUaF045CA59J+dkdDPrzy2IZtJkEREzmLfS4IfqNo
 DlZHFaxs/qbj279udMGSReWC9smGHgoLfR3qFhiLJjzLjKGWs2ejPWKCpqRVBNTnHir4
 9+ugXynZlQC8w/tRRcMGVcYr9T1rVOeqjDJJBCIPi3ZGVZzVYLUpg3JKnC3jMmAxTPm9
 NqkW5zr0al/IxN9m4c54KdqCRI6Jo7KNAgrf4JfPjAHL9j1LJEOmAu/ZndedGy+6djmG
 0UQQ==
X-Gm-Message-State: AOAM531nftLV1jhBhSAMKX6/LB1oEbBXB9q5sFYLmCaZhnIB+NxUJ7Yd
 dc7XuNZEjA7di2BmQOnlVQtuyDF36BnUYi/zVsoL7aeo/VxiyO818bbUddY6Fm2A+trifvli+jV
 8U/dit2KhEhDeuiZ/gJj3hQ4l2TFU8IuMPYBzfWJ5vQ==
X-Received: by 2002:a17:907:970f:: with SMTP id
 jg15mr3148188ejc.59.1623308173279; 
 Wed, 09 Jun 2021 23:56:13 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxfIv81spWJXNarfOJdda2HFMOX2b2HK5tvpYTIO17jIeP6QYSnkJhjQ1uYcXSP8Pz04bwJRg==
X-Received: by 2002:a17:907:970f:: with SMTP id
 jg15mr3148177ejc.59.1623308173081; 
 Wed, 09 Jun 2021 23:56:13 -0700 (PDT)
Received: from steredhat (host-79-18-148-79.retail.telecomitalia.it.
 [79.18.148.79])
 by smtp.gmail.com with ESMTPSA id y25sm850575edt.17.2021.06.09.23.56.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 09 Jun 2021 23:56:12 -0700 (PDT)
Date: Thu, 10 Jun 2021 08:56:10 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: "Jiang Wang ." <jiang.wang@bytedance.com>
Subject: Re: [External] Re: [RFC v4] virtio-vsock: add description for
 datagram type
Message-ID: <20210610065610.tvf2hkzgc4mjgdk6@steredhat>
References: <20210528040118.3253836-1-jiang.wang@bytedance.com>
 <20210608134601.5qs46xdn7bzaob77@steredhat>
 <CAP_N_Z9-C0zgXzRXX_vm37cK6-q1Qv+0CErMkMTHGjMgcTs-6Q@mail.gmail.com>
 <20210609071725.627yqnmkzadwpubp@steredhat>
 <CAP_N_Z-FCkTDupYSFY1q=FsmAzjAtZ1wGj9h+fngPnSSSecwdw@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAP_N_Z-FCkTDupYSFY1q=FsmAzjAtZ1wGj9h+fngPnSSSecwdw@mail.gmail.com>
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

On Wed, Jun 09, 2021 at 08:31:27PM -0700, Jiang Wang . wrote:
>On Wed, Jun 9, 2021 at 12:17 AM Stefano Garzarella <sgarzare@redhat.com> wrote:
>>
>> On Tue, Jun 08, 2021 at 09:22:26PM -0700, Jiang Wang . wrote:
>> >On Tue, Jun 8, 2021 at 6:46 AM Stefano Garzarella <sgarzare@redhat.com> wrote:
>> >>
>> >> On Fri, May 28, 2021 at 04:01:18AM +0000, Jiang Wang wrote:
>> >> >From: "jiang.wang" <jiang.wang@bytedance.com>
>> >> >
>> >> >Add supports for datagram type for virtio-vsock. Datagram
>> >> >sockets are connectionless and unreliable. To avoid contention
>> >> >with stream and other sockets, add two more virtqueues and
>> >> >a new feature bit to identify if those two new queues exist or not.
>> >> >
>> >> >Also add descriptions for resource management of datagram, which
>> >> >does not use the existing credit update mechanism associated with
>> >> >stream sockets.
>> >> >
>> >> >Signed-off-by: Jiang Wang <jiang.wang@bytedance.com>
>> >> >---
>> >> >
>> >> >V2: addressed the comments for the previous version.
>> >> >V3: add description for the mergeable receive buffer.
>> >> >V4: add a feature bit for stream and reserver a bit for seqpacket.
>> >> >Fix mrg_rxbuf related sentences.
>> >> >
>> >> > virtio-vsock.tex | 155 ++++++++++++++++++++++++++++++++++++++++++++++++++-----
>> >> > 1 file changed, 142 insertions(+), 13 deletions(-)
>> >> >
>> >> >diff --git a/virtio-vsock.tex b/virtio-vsock.tex
>> >> >index da7e641..bacac3c 100644
>> >> >--- a/virtio-vsock.tex
>> >> >+++ b/virtio-vsock.tex
>> >> >@@ -9,14 +9,41 @@ \subsection{Device ID}\label{sec:Device Types / Socket Device / Device ID}
>> >> >
>> >> > \subsection{Virtqueues}\label{sec:Device Types / Socket Device / Virtqueues}
>> >> > \begin{description}
>> >> >-\item[0] rx
>> >> >-\item[1] tx
>> >> >+\item[0] stream rx
>> >> >+\item[1] stream tx
>> >> >+\item[2] datagram rx
>> >> >+\item[3] datagram tx
>> >> >+\item[4] event
>> >>
>> >> Is there a particular reason to always have the event queue as the last
>> >> one?
>> >>
>> >> Maybe it's better to add the datagram queues at the bottom, so the first
>> >> 3 queues are always the same.
>> >>
>> >I am not sure. I think Linux kernel should be fine with what you described.
>> >But I am not sure about QEMU. From the code, I see virtqueue is allocated
>> >as an array, like following,
>> >
>> >+ #ifdef CONFIG_VHOST_VSOCK_DGRAM
>> >+    struct vhost_virtqueue vhost_vqs[4];
>> >+ #else
>> >    struct vhost_virtqueue vhost_vqs[2];
>> >+ #endi
>>
>> I see, also vhost_dev_init() requires an array, so I agree that this is
>> the best approach, sorry for the noise.
>>
>> Just to be sure to check that anything is working if
>> CONFIG_VHOST_VSOCK_DGRAM is defined, but the guest has an old driver
>> that doesn't support DGRAM, and viceversa.
>
>Sure.  I just want to mention that the QEMU should be consistent
>with the device (host). If QEMU enabled CONFIG_VHOST_VSOCK_DGRAM,
>the device also needs to enable a similar option. Than the driver can
>be old or new versions.

Okay, but we should allow to run an old QEMU (without DGRAM) with a new 
kernel (with DGRAM support built it) and viceversa.
The features bit are used to guarantee compatibility and to enable and 
disable features at runtime depending on what the device or driver 
supports.

>
>> >
>> >so I assume the virtqueues for tx/rx should be
>> >continuous? I can try to put the new queues at the end and see if it
>> >works or not.
>> >
>> >btw, my qemu change is here:
>> >https://github.com/Jiang1155/qemu/commit/6307aa7a0c347905a31f3ca6577923e2f6dd9d84
>> >
>> >> >+\end{description}
>> >> >+The virtio socket device uses 5 queues if feature bit VIRTIO_VSOCK_F_DRGAM is set. Otherwise, it
>> >> >+only uses 3 queues, as the following.
>> >> >+
>> >> >+\begin{description}
>> >> >+\item[0] stream rx
>> >> >+\item[1] stream tx
>> >> > \item[2] event
>> >> > \end{description}
>> >> >
>> >> >+When behavior differs between stream and datagram rx/tx virtqueues
>> >> >+their full names are used. Common behavior is simply described in
>> >> >+terms of rx/tx virtqueues and applies to both stream and datagram
>> >> >+virtqueues.
>> >> >+
>> >> > \subsection{Feature bits}\label{sec:Device Types / Socket Device / Feature bits}
>> >> >
>> >> >-There are currently no feature bits defined for this device.
>> >> >+\begin{description}
>> >> >+\item[VIRTIO_VSOCK_F_STREAM (0)] Device has support for stream socket type.
>> >> >+\end{description}
>> >> >+
>> >> >+\begin{description}
>> >> >+\item[VIRTIO_VSOCK_F_DGRAM (2)] Device has support for datagram socket
>> >> >type.
>> >> >+\end{description}
>> >> >+
>> >> >+\begin{description}
>> >> >+\item[VIRTIO_VSOCK_F_MRG_RXBUF (3)] Driver can merge receive buffers.
>> >> >+\end{description}
>> >> >+
>> >> >+If no feature bits are defined, then assume only VIRTIO_VSOCK_F_STREAM
>> >> >is set.
>> >>
>> >> I'd say more like socket streams are supported, without reference to the
>> >> feature bit, something like: "If no feature bits are defined, then
>> >> assume device only supports stream socket type."
>> >>
>> >OK.
>> >
>> >> >
>> >> > \subsection{Device configuration layout}\label{sec:Device Types / Socket Device / Device configuration layout}
>> >> >
>> >> >@@ -64,6 +91,8 @@ \subsection{Device Operation}\label{sec:Device Types / Socket Device / Device Op
>> >> >
>> >> > Packets transmitted or received contain a header before the payload:
>> >> >
>> >> >+If feature VIRTIO_VSOCK_F_MRG_RXBUF is not negotiated, use the following header.
>> >> >+
>> >> > \begin{lstlisting}
>> >> > struct virtio_vsock_hdr {
>> >> >       le64 src_cid;
>> >> >@@ -79,6 +108,15 @@ \subsection{Device Operation}\label{sec:Device Types / Socket Device / Device Op
>> >> > };
>> >> > \end{lstlisting}
>> >> >
>> >> >+If feature VIRTIO_VSOCK_F_MRG_RXBUF is negotiated, use the following header.
>> >> >+\begin{lstlisting}
>> >> >+struct virtio_vsock_hdr_mrg_rxbuf {
>> >> >+      struct virtio_vsock_hdr hdr;
>> >> >+      le16 num_buffers;
>> >> >+};
>> >> >+\end{lstlisting}
>> >> >+
>> >> >+
>> >> > The upper 32 bits of src_cid and dst_cid are reserved and zeroed.
>> >> >
>> >> > Most packets simply transfer data but control packets are also used for
>> >> >@@ -107,6 +145,9 @@ \subsection{Device Operation}\label{sec:Device Types / Socket Device / Device Op
>> >> >
>> >> > \subsubsection{Virtqueue Flow Control}\label{sec:Device Types / Socket Device / Device Operation / Virtqueue Flow Control}
>> >> >
>> >> >+Flow control applies to stream sockets; datagram sockets do not have
>> >> >+flow control.
>> >> >+
>> >> > The tx virtqueue carries packets initiated by applications and replies to
>> >> > received packets.  The rx virtqueue carries packets initiated by the device and
>> >> > replies to previously transmitted packets.
>> >> >@@ -140,12 +181,15 @@ \subsubsection{Addressing}\label{sec:Device Types / Socket Device / Device Opera
>> >> > consists of a (cid, port number) tuple. The header fields used for this are
>> >> > \field{src_cid}, \field{src_port}, \field{dst_cid}, and \field{dst_port}.
>> >> >
>> >> >-Currently only stream sockets are supported. \field{type} is 1 for
>> >> >stream
>> >> >-socket types.
>> >> >+Currently stream and datagram (dgram) sockets are supported. \field{type} is 1 for stream
>> >> >+socket types. \field{type} is 3 for dgram socket types.
>> >>
>> >> When Arseny's change will merged, we can define and use
>> >> VIRTIO_VSOCK_TYPE_DGRAM,.
>> >
>> >Sure.
>> >> >
>> >> > Stream sockets provide in-order, guaranteed, connection-oriented
>> >> > delivery
>> >> > without message boundaries.
>> >> >
>> >> >+Datagram sockets provide unordered, unreliable, connectionless
>> >> >messages
>> >> >+with message boundaries and a maximum length.
>> >> >+
>> >> > \subsubsection{Buffer Space Management}\label{sec:Device Types / Socket Device / Device Operation / Buffer Space Management}
>> >> > \field{buf_alloc} and \field{fwd_cnt} are used for buffer space
>> >> > management of
>> >> > stream sockets. The guest and the device publish how much buffer space is
>> >> >@@ -162,7 +206,7 @@ \subsubsection{Buffer Space Management}\label{sec:Device Types / Socket Device /
>> >> > u32 peer_free = peer_buf_alloc - (tx_cnt - peer_fwd_cnt);
>> >> > \end{lstlisting}
>> >> >
>> >> >-If there is insufficient buffer space, the sender waits until virtqueue buffers
>> >> >+For stream sockets, if there is insufficient buffer space, the sender waits until virtqueue buffers
>> >> > are returned and checks \field{buf_alloc} and \field{fwd_cnt} again. Sending
>> >> > the VIRTIO_VSOCK_OP_CREDIT_REQUEST packet queries how much buffer space is
>> >> > available. The reply to this query is a VIRTIO_VSOCK_OP_CREDIT_UPDATE packet.
>> >> >@@ -170,24 +214,55 @@ \subsubsection{Buffer Space Management}\label{sec:Device Types / Socket Device /
>> >> > previously receiving a VIRTIO_VSOCK_OP_CREDIT_REQUEST packet. This allows
>> >> > communicating updates any time a change in buffer space occurs.
>> >> >
>> >> >+Unlike stream sockets, dgram sockets do not use VIRTIO_VSOCK_OP_CREDIT_UPDATE or
>> >> >+VIRTIO_VSOCK_OP_CREDIT_REQUEST packets. The dgram buffer management
>> >> >+is split to two parts: tx side and rx side. For the tx side, if the
>> >>
>> >> Maybe better to use sender and receiver, since we use tx and rx to
>> >> identify the queues.
>> >
>> >OK.
>> >
>> >> >+virtqueue is full, the packet will be dropped.
>> >> >+For the rx side, dgram also uses the \field{buf_alloc}. If it is full, the packet
>> >> >+is dropped by the receiver.
>> >>
>> >> This sentence is a bit unclear.
>> >> `buf_alloc` for stream socket is used to inform the other peer about the
>> >> receive buffer space. In this case we are using the local information,
>> >> so there is no need to refer to `buf_alloc`. We can write something
>> >> like: "The packet is dropped by the receiver if there is no space in the
>> >> receive buffer".
>> >
>> >OK.
>> >
>> >> >+
>> >> >+\drivernormative{\paragraph}{Device Operation: Buffer Space Management}{Device Types / Socket Device / Device Operation / Setting Up Receive Buffers}
>> >> >+\begin{itemize}
>> >> >+\item If VIRTIO_VSOCK_F_MRG_RXBUF is not negotiated, the driver SHOULD populate the receive queue(s)
>> >> >+      with buffers of at least 1526 bytes for stream sockets and 4096
>> >> >bytes for datagram sockets.
>> >>
>> >> Where does 1526 come from?
>> >
>> >No specific reason. Any recommendations?
>> >
>> >> We're adding a requirement for socket streams that wasn't there until
>> >> now.
>> >
>> >This is only when mergeable rxbuf bit is used. I think before this, the stream
>> >rx buf should be at least bigger than the pkt header. We just did not put that
>> >into the spec.
>>
>> Mmm, I'm confused now. The statement says "If VIRTIO_VSOCK_F_MRG_RXBUF
>> is not negotiated"
>>     ^
>My bad. You are right, this is a new requirement for stream sockets.
>Not a typo.  Maybe remove the part for stream sockets? Something
>like following:
>
>If VIRTIO_VSOCK_F_MRG_RXBUF is not negotiated, the driver SHOULD
>populate the receive queue(s)
>with buffers of  at least 4096 bytes for datagram sockets.

Make sense to me. Maybe we can replase s/receive queue(s)/datagram rx 
queue/.

Thanks,
Stefano

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
