Return-Path: <SRS0=H6i0=NZ=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FA1BC433F5
	for <virtualization@archiver.kernel.org>; Fri,  3 Sep 2021 00:08:20 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E67396108B
	for <virtualization@archiver.kernel.org>; Fri,  3 Sep 2021 00:08:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org E67396108B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=bytedance.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id A7833400E8;
	Fri,  3 Sep 2021 00:08:19 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id vZ0_0QjtwOd2; Fri,  3 Sep 2021 00:08:18 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id D668A400DE;
	Fri,  3 Sep 2021 00:08:17 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B616AC001A;
	Fri,  3 Sep 2021 00:08:17 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 25B4AC000E
 for <virtualization@lists.linux-foundation.org>;
 Fri,  3 Sep 2021 00:08:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 0C7D84017A
 for <virtualization@lists.linux-foundation.org>;
 Fri,  3 Sep 2021 00:08:16 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id R004VXJawiZs
 for <virtualization@lists.linux-foundation.org>;
 Fri,  3 Sep 2021 00:08:14 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com
 [IPv6:2a00:1450:4864:20::22f])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 648E0400DE
 for <virtualization@lists.linux-foundation.org>;
 Fri,  3 Sep 2021 00:08:14 +0000 (UTC)
Received: by mail-lj1-x22f.google.com with SMTP id i28so6737346ljm.7
 for <virtualization@lists.linux-foundation.org>;
 Thu, 02 Sep 2021 17:08:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance-com.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=shoT/h8kZ8kAkaA/UCG7GFMuSxrSKJjs1CdQsvCygG4=;
 b=bXpajAQ4YFoGiili5xZh4yiZPANCuRjVBDTFUtxOoRjwEXRRf3VR7omR3fmnzUp13s
 S7ZP2z4LKv0ZxZ/1CRtgI3OxrIW1G2dNoL1h0F06NbJoThJkO/yU6Ce0Gh+Bn4adXGlV
 tiSutVH0hsf78sIOeucQ81ZuZPEMYBo+1/ZovJPGccXoMt8uQJQV9Sf/WuDgcRwg0j62
 du2mkFsrLEfPOAQTnAn3ucXbccPzpulNu7tKOHV2dn8U+ZehFlFfuKW/Ihgjgw4W3jly
 /tw4qDb7ldtyVpij9vyJPT5SJXK+lC8wV4UCXx/mT6su90anp815C5pexZnrliwA3MnX
 7rBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=shoT/h8kZ8kAkaA/UCG7GFMuSxrSKJjs1CdQsvCygG4=;
 b=aJDX7laxM53nB2O5AHsjng8CVyJOJl2EIn2ueJ3LPgimRgsPE8qmrkm1TCZDmVmDp2
 RGhXHj/e/dkwHjgE3TjDzaZm1i2KUK6XTcH7tNuGr7poQqSaFtK0UOhLPZDbG+1js+lP
 gBebhH+pbI6hmJwycpWeBswZ0G8FP1lTGH2uBw9KArYy2uCy3krCAYplq7lD33Gpkl08
 HapmnM+0L1FWfeYCLJ+1EYaiNypBF1Dm0LI6v/KRK1Usbj8FAXUetvPUt3N7uGm308mB
 LzfJ3tvGTqwuSQBW43Z6DA5nOHgO+UCL6XQc7r+IN4h43dojMmb52B+GhB+ZIOEXowtn
 qFcA==
X-Gm-Message-State: AOAM531Vns+MEXwRKQukD2weih2W9ITtTKB+m4pSnJdNZHoIWKAD/oxb
 MdiN5nq2DlHTvjqlO3NPcdAuTx6PapYsz2NV1uPOVA==
X-Google-Smtp-Source: ABdhPJx5I1IdpxhkpsguRQ4JPAPtlipDcsgKg+UlXLioNZhYCF8dI5mAyqAScnV24edPO9Z8E/BPvGUEu6lw4Ff0vQA=
X-Received: by 2002:a2e:b001:: with SMTP id y1mr742680ljk.360.1630627692098;
 Thu, 02 Sep 2021 17:08:12 -0700 (PDT)
MIME-Version: 1.0
References: <20210610181203.979686-1-jiang.wang@bytedance.com>
 <YTDam7jdjRz686bp@stefanha-x1.localdomain>
In-Reply-To: <YTDam7jdjRz686bp@stefanha-x1.localdomain>
From: "Jiang Wang ." <jiang.wang@bytedance.com>
Date: Thu, 2 Sep 2021 17:08:01 -0700
Message-ID: <CAP_N_Z_hHFbmd4tVMNYMrGiUt43Rs0N9rwM6F3Q_Wu1MTyfeKA@mail.gmail.com>
Subject: Re: [virtio-comment] Re: [PATCH v5] virtio-vsock: add description for
 datagram type
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: Cong Wang <cong.wang@bytedance.com>,
 Xiongchun Duan <duanxiongchun@bytedance.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, cohuck@redhat.com,
 virtualization@lists.linux-foundation.org,
 Yongji Xie <xieyongji@bytedance.com>,
 =?UTF-8?B?5p+056iz?= <chaiwen.cc@bytedance.com>,
 virtio-comment@lists.oasis-open.org, asias@redhat.com,
 Arseny Krasnov <arseny.krasnov@kaspersky.com>,
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

On Thu, Sep 2, 2021 at 7:07 AM Stefan Hajnoczi <stefanha@redhat.com> wrote:
>
> On Thu, Jun 10, 2021 at 06:12:03PM +0000, Jiang Wang wrote:
> > Add supports for datagram type for virtio-vsock. Datagram
> > sockets are connectionless and unreliable. To avoid contention
> > with stream and other sockets, add two more virtqueues and
> > a new feature bit to identify if those two new queues exist or not.
> >
> > Also add descriptions for resource management of datagram, which
> > does not use the existing credit update mechanism associated with
> > stream sockets.
> >
> > Signed-off-by: Jiang Wang <jiang.wang@bytedance.com>
> > ---
>
> Overall this looks good. The tricky thing will be implementing dgram
> sockets in a way that minimizes dropped packets and provides some degree
> of fairness between senders. Those are implementation issues though and
> not visible at the device specification level.
>
> > diff --git a/virtio-vsock.tex b/virtio-vsock.tex
> > index da7e641..26a62ac 100644
> > --- a/virtio-vsock.tex
> > +++ b/virtio-vsock.tex
> > @@ -9,14 +9,37 @@ \subsection{Device ID}\label{sec:Device Types / Socket Device / Device ID}
> >
> >  \subsection{Virtqueues}\label{sec:Device Types / Socket Device / Virtqueues}
> >  \begin{description}
> > -\item[0] rx
> > -\item[1] tx
> > +\item[0] stream rx
> > +\item[1] stream tx
> > +\item[2] datagram rx
> > +\item[3] datagram tx
> > +\item[4] event
> > +\end{description}
> > +The virtio socket device uses 5 queues if feature bit VIRTIO_VSOCK_F_DRGAM is set. Otherwise, it
> > +only uses 3 queues, as the following.
>
> s/as the following/as follows:/
>
Will do.

> > +
> > +\begin{description}
> > +\item[0] stream rx
> > +\item[1] stream tx
> >  \item[2] event
> >  \end{description}
> >
> > +When behavior differs between stream and datagram rx/tx virtqueues
> > +their full names are used. Common behavior is simply described in
> > +terms of rx/tx virtqueues and applies to both stream and datagram
> > +virtqueues.
> > +
> >  \subsection{Feature bits}\label{sec:Device Types / Socket Device / Feature bits}
> >
> > -There are currently no feature bits defined for this device.
> > +\begin{description}
> > +\item[VIRTIO_VSOCK_F_STREAM (0)] Device has support for stream socket type.
> > +\end{description}
> > +
> > +\begin{description}
> > +\item[VIRTIO_VSOCK_F_DGRAM (2)] Device has support for datagram socket type.
>
> Is this really bit 2 or did you mean bit 1 (value 0x2)?
>
I left bit 1 for SEQPACKET feature bit.  That will probably merge
before this patch.

> What happens to the virtqueue layout when VIRTIO_VSOCK_F_DGRAM is
> present and VIRTIO_VSOCK_F_STREAM is absent? The virtqueue section above
> implies that VIRTIO_VSOCK_F_STREAM is always present.
>
yeah, good question. I  think then it means the first two queues will be used
for dgram?

> > +\end{description}
> > +
> > +If no feature bits are defined, assume device only supports stream socket type.
>
> It's cleaner to define VIRTIO_VSOCK_F_NO_STREAM (0) instead. When the
> bit is set the stream socket type is not available and the stream_rx/tx
> virtqueues are absent.
>
> This way it's not necessary to define special behavior depending on
> certain combinations of feature bits.
>
Agree. I went back and read old emails again and found I missed the
negative bit part. So repeating the previous question, if
VIRTIO_VSOCK_F_NO_STREAM  and VIRTIO_VSOCK_F_DGRAM
present, then we will only have 3 queues and the first two are for dgram, right?

Also, I am wondering what if an implementation only sets
VIRTIO_VSOCK_F_NO_STREAM bit, but somehow forgot (or for whatever
reason) to set VIRTIO_VSOCK_F_DGRAM bit? Does that mean there will
be no virtqueues? The implementation is a mistake? Because it will not
do anything.
Do we need to explicitly add a sentence in the spec to say something like
"Don't set VIRTIO_VSOCK_F_NO_STREAM alone" etc?


> >  \subsubsection{Receive and Transmit}\label{sec:Device Types / Socket Device / Device Operation / Receive and Transmit}
> > -The driver queues outgoing packets on the tx virtqueue and incoming packet
> > +The driver queues outgoing packets on the tx virtqueue and allocates incoming packet
> >  receive buffers on the rx virtqueue. Packets are of the following form:
>
> This change seems unrelated to dgram sockets. I don't think adding the
> word "allocates" makes things clearer or more precise. The driver may
> reuse receive buffers rather than allocating fresh buffers. I suggest
> dropping this change.
>
Got it. Will do.

> >
> >  \begin{lstlisting}
> > @@ -195,6 +235,7 @@ \subsubsection{Receive and Transmit}\label{sec:Device Types / Socket Device / De
> >  };
> >  \end{lstlisting}
> >
> > +
> >  Virtqueue buffers for outgoing packets are read-only. Virtqueue buffers for
> >  incoming packets are write-only.
> >
>
> Unnecessary whitespace change. Please drop.

Sure.
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
