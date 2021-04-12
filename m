Return-Path: <SRS0=TAdK=JJ=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A850C433B4
	for <virtualization@archiver.kernel.org>; Mon, 12 Apr 2021 22:42:42 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F386761246
	for <virtualization@archiver.kernel.org>; Mon, 12 Apr 2021 22:42:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F386761246
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=bytedance.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id A4E3483DCF;
	Mon, 12 Apr 2021 22:42:41 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id W6tlhTH2wP7x; Mon, 12 Apr 2021 22:42:40 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTP id 2725983D74;
	Mon, 12 Apr 2021 22:42:40 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id F18D1C000B;
	Mon, 12 Apr 2021 22:42:39 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 99F0EC000A
 for <virtualization@lists.linux-foundation.org>;
 Mon, 12 Apr 2021 22:42:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 6C062404F4
 for <virtualization@lists.linux-foundation.org>;
 Mon, 12 Apr 2021 22:42:37 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=bytedance-com.20150623.gappssmtp.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id PNvMVnssjcMN
 for <virtualization@lists.linux-foundation.org>;
 Mon, 12 Apr 2021 22:42:35 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com
 [IPv6:2607:f8b0:4864:20::229])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 69EE9404F2
 for <virtualization@lists.linux-foundation.org>;
 Mon, 12 Apr 2021 22:42:35 +0000 (UTC)
Received: by mail-oi1-x229.google.com with SMTP id n140so15082010oig.9
 for <virtualization@lists.linux-foundation.org>;
 Mon, 12 Apr 2021 15:42:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance-com.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=uYjBkeuJehCzgqflNtkkLYRF63Llrthc35cSMQusnfo=;
 b=axCga6FF94ESZusuE+X9dIHB9g1wNuFAVnZ4oKSzHcbf/wW4o2MDk/+o4QajIpJFOg
 F/0Fz+1jb6ALbkbQEYv6LSAVtGVLTC4+X3Dq6ZwKsOgTbdqHGOhaukZb6FsmyjO2TGYx
 ZuVBU7gewHoBOAVDxn8SQt5e0FuO/XFreZQnFZscuHeVqGIv0LL8d8bQKSWjAQY8ve9Q
 aNdPAxMqupKDt/RqrcyfugzcFW1h0AdH3G+3DLXx/435gCnEDjb98eqoLWXv3iQKgu8h
 87vbM8zYNRuvxOjTRP0vsvqqu4Y03iuvYF3s4gX2/l4rltnG6VarxUmQx4duf06t6gje
 J4xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=uYjBkeuJehCzgqflNtkkLYRF63Llrthc35cSMQusnfo=;
 b=IDSOkbwRZjP71zmwbp5XX7/PWftGb/l7yPGBsx20Qhtbfudo9zaexg4M+YIEQ7BmaM
 W+puZip2oXzsBYUnBHI8IK0rfeWCypKM2HGKR3S88qa0LFQ2hkZy7PrSj8L3NHCdTyBi
 k8Ec2vkpesDsND1B+RAbeK8hUG/lchvDZTZja6Q5ZfQgRR5pJtGmmBy9U4HOCvbmkUhc
 vJLrCz+aOaWKBr5oATi/iVXRHlzzQ9J5u8MzSwtzpGMsSbFQ7aHobfW+IBeVXqQLbqxb
 B3Gv63Sv4UwP+7LS2gGqKnLir+olVU4iMR74v0vckPyx6xnOMHVAGVk5oJPmorV5yHEa
 l2wQ==
X-Gm-Message-State: AOAM531cZCM4L8ivRkJ/L/A/WD38EVBRqdPu9NapIv8QbpSJMBohJsrY
 9N3s0UqCJOaV+OAZawtsEZ+o9b4IjAIR1yzxtxNgHA==
X-Google-Smtp-Source: ABdhPJwevcCEY2EfQr4f6j2Agyi76lp1P6PACIXfTrjBLa1xR2mwRc0SZI1cQrmj2CwniLrmWajMsIMNcV1/HdEcnLI=
X-Received: by 2002:aca:af4b:: with SMTP id y72mr1086273oie.97.1618267354309; 
 Mon, 12 Apr 2021 15:42:34 -0700 (PDT)
MIME-Version: 1.0
References: <20210401043602.3510538-1-jiang.wang@bytedance.com>
 <YHRQGSSnkN8Zipy0@stefanha-x1.localdomain>
 <20210412142133.t44pn5pjy6fdcvk4@steredhat>
In-Reply-To: <20210412142133.t44pn5pjy6fdcvk4@steredhat>
From: "Jiang Wang ." <jiang.wang@bytedance.com>
Date: Mon, 12 Apr 2021 15:42:23 -0700
Message-ID: <CAP_N_Z9VPkBKX9QD+cuzSSAn6dL0cpQ=EZs5vk+ByjjDpGgdBA@mail.gmail.com>
Subject: Re: Re: [RFC v2] virtio-vsock: add description for datagram type
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: cong.wang@bytedance.com, Xiongchun Duan <duanxiongchun@bytedance.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, cohuck@redhat.com,
 virtualization@lists.linux-foundation.org, xieyongji@bytedance.com,
 Stefan Hajnoczi <stefanha@redhat.com>, asias@redhat.com,
 Arseny Krasnov <arseny.krasnov@kaspersky.com>
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

On Mon, Apr 12, 2021 at 7:21 AM Stefano Garzarella <sgarzare@redhat.com> wrote:
>
> On Mon, Apr 12, 2021 at 02:50:17PM +0100, Stefan Hajnoczi wrote:
> >On Thu, Apr 01, 2021 at 04:36:02AM +0000, jiang.wang wrote:
> >> Add supports for datagram type for virtio-vsock. Datagram
> >> sockets are connectionless and unreliable. To avoid contention
> >> with stream and other sockets, add two more virtqueues and
> >> a new feature bit to identify if those two new queues exist or not.
> >>
> >> Also add descriptions for resource management of datagram, which
> >> does not use the existing credit update mechanism associated with
> >> stream sockets.
> >>
> >> Signed-off-by: Jiang Wang <jiang.wang@bytedance.com>
> >> ---
> >> V2 addressed the comments for the previous version.
> >>
> >>  virtio-vsock.tex | 62 +++++++++++++++++++++++++++++++++++++++++++++++---------
> >>  1 file changed, 52 insertions(+), 10 deletions(-)
> >>
> >> diff --git a/virtio-vsock.tex b/virtio-vsock.tex
> >> index da7e641..62c12e0 100644
> >> --- a/virtio-vsock.tex
> >> +++ b/virtio-vsock.tex
> >> @@ -11,12 +11,25 @@ \subsection{Virtqueues}\label{sec:Device Types / Socket Device / Virtqueues}
> >>  \begin{description}
> >>  \item[0] rx
> >>  \item[1] tx
> >> +\item[2] datagram rx
> >> +\item[3] datagram tx
> >> +\item[4] event
> >> +\end{description}
> >> +The virtio socket device uses 5 queues if feature bit VIRTIO_VSOCK_F_DRGAM is set. Otherwise, it
> >> +only uses 3 queues, as the following. Rx and tx queues are always used for stream sockets.
> >> +
> >> +\begin{description}
> >> +\item[0] rx
> >> +\item[1] tx
> >>  \item[2] event
> >>  \end{description}
> >>
> >
> >I suggest renaming "rx" and "tx" to "stream rx" and "stream tx"
> >virtqueues and also adding this:
> >
> >  When behavior differs between stream and datagram rx/tx virtqueues
> >  their full names are used. Common behavior is simply described in
> >  terms of rx/tx virtqueues and applies to both stream and datagram
> >  virtqueues.
> >
> >This way you won't need to duplicate portions of the spec that deal with
> >populating the virtqueues, for example.
> >
> >It's also clearer to use a full name for stream rx/tx virtqueues instead
> >of calling them rx/tx virtqueues now that we have datagram rx/tx
> >virtqueues.
> >
> >> +
> >>  \subsection{Feature bits}\label{sec:Device Types / Socket Device / Feature bits}
> >>
> >> -There are currently no feature bits defined for this device.
> >> +\begin{description}
> >> +\item[VIRTIO_VSOCK_F_DGRAM (0)] Device has support for datagram socket type.
> >> +\end{description}
> >>
> >>  \subsection{Device configuration layout}\label{sec:Device Types / Socket Device / Device configuration layout}
> >>
> >> @@ -107,6 +120,9 @@ \subsection{Device Operation}\label{sec:Device Types / Socket Device / Device Op
> >>
> >>  \subsubsection{Virtqueue Flow Control}\label{sec:Device Types / Socket Device / Device Operation / Virtqueue Flow Control}
> >>
> >> +Flow control applies to stream sockets; datagram sockets do not have
> >> +flow control.
> >> +
> >>  The tx virtqueue carries packets initiated by applications and replies to
> >>  received packets.  The rx virtqueue carries packets initiated by the device and
> >>  replies to previously transmitted packets.
> >> @@ -140,12 +156,15 @@ \subsubsection{Addressing}\label{sec:Device Types / Socket Device / Device Opera
> >>  consists of a (cid, port number) tuple. The header fields used for this are
> >>  \field{src_cid}, \field{src_port}, \field{dst_cid}, and \field{dst_port}.
> >>
> >> -Currently only stream sockets are supported. \field{type} is 1 for stream
> >> -socket types.
> >> +Currently stream and datagram (dgram) sockets are supported. \field{type} is 1 for stream
> >> +socket types. \field{type} is 3 for dgram socket types.
> >>
> >>  Stream sockets provide in-order, guaranteed, connection-oriented delivery
> >>  without message boundaries.
> >>
> >> +Datagram sockets provide connectionless unreliable messages of
> >> +a fixed maximum length.
> >
> >Plus unordered (?) and with message boundaries. In other words:
> >
> >  Datagram sockets provide unordered, unreliable, connectionless message
> >  with message boundaries and a fixed maximum length.
> >
> >I didn't think of the fixed maximum length aspect before. I guess the
> >intention is that the rx buffer size is the message size limit? That's
> >different from UDP messages, which can be fragmented into multiple IP
> >packets and can be larger than 64KiB:
> >https://en.wikipedia.org/wiki/User_Datagram_Protocol#UDP_datagram_structure
> >
> >Is it possible to support large datagram messages in vsock? I'm a little
> >concerned that applications that run successfully over UDP will not be
> >portable if vsock has this limitation because it would impose extra
> >message boundaries that the application protocol might not tolerate.
>
> Maybe we can reuse the same approach Arseny is using for SEQPACKET.
> Fragment the packets according to the buffers in the virtqueue and set
> the EOR flag to indicate the last packet in the message.
>
Agree. Another option is to use the ones for skb since we may need to
use skbs for multiple transport support anyway.

> Thanks,
> Stefano
>
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
