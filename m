Return-Path: <SRS0=L1Zq=IV=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2188C433C1
	for <virtualization@archiver.kernel.org>; Tue, 23 Mar 2021 02:23:31 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 432986192D
	for <virtualization@archiver.kernel.org>; Tue, 23 Mar 2021 02:23:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 432986192D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=bytedance.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id ECECC40354;
	Tue, 23 Mar 2021 02:23:30 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id r3ypOLDqhsJf; Tue, 23 Mar 2021 02:23:30 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTP id 7E97F402FE;
	Tue, 23 Mar 2021 02:23:29 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 56B1DC000A;
	Tue, 23 Mar 2021 02:23:29 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id CB4D4C0001
 for <virtualization@lists.linux-foundation.org>;
 Tue, 23 Mar 2021 02:23:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id AB8D440352
 for <virtualization@lists.linux-foundation.org>;
 Tue, 23 Mar 2021 02:23:27 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id xIN42CoiqDie
 for <virtualization@lists.linux-foundation.org>;
 Tue, 23 Mar 2021 02:23:26 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com
 [IPv6:2607:f8b0:4864:20::230])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 64762402FE
 for <virtualization@lists.linux-foundation.org>;
 Tue, 23 Mar 2021 02:23:26 +0000 (UTC)
Received: by mail-oi1-x230.google.com with SMTP id d12so15399063oiw.12
 for <virtualization@lists.linux-foundation.org>;
 Mon, 22 Mar 2021 19:23:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance-com.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=/1Wt7ZTiVxEIDWELVBmNdMzbUt1BNMEwtU6U4anTncY=;
 b=NzRaXJxcR+ShRLGEbdzH6qhAEHAo3mYQYWRtzXRTAPPtDp4nSiDZ1kzDPCLaTfIz9K
 hgQUo9+PR7UNfrB3JTtTGUS5a7gfpI0SXLs/5/JzEF5nZ/HjYx079gqrA4N05XyYGGzN
 bcSVRva/FuRlliK7JIXKDFQkqLF+FiP14tI7rOu+48hVCjOQ2/MGDpH5Z0uxyQVJJlsv
 eitSV/ZX7IUISGwVVNOlE/wla2768FS4dY9FcxtYG6M49yDXFEPwJqOJ0fIDnv41N2Fi
 0dtJSlDZaO59UjX0cJI7MMCJwfpdoC2S3GB2vsUiaAv5qEdKjDTSWpup7/cl2lbb9IH1
 GGBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=/1Wt7ZTiVxEIDWELVBmNdMzbUt1BNMEwtU6U4anTncY=;
 b=Mha06r5914qBfVM5WFnUK7NLzNr759M9rnAjplpTIVKwQ/fAph+F+fF1UKb7jTHaFa
 CMBdBDeBdWtxIZ0sH+Esw1UDf8UG1kGOe+X6jiGbFqM5Guy68mpNHUqd/jvr/gRtJYQv
 LVwd6G2MciL1XEBOb25OiUYlegHH4lUOLi5kguwCteZ37bPFk/+wrguy/z84zaMTWirZ
 MPJjYlD85DWHTq6bYYaIgZ2g08thFrplrQdpVC8oD7yOi73F2UzVEGZ4EAP6fnzIMbQa
 UUr5tQOtDP2u6w4ACau2lqyw6KL9G1ZZRLm06JrZwlK5qLozfx/F7JeFPgiOxRSs5e4Y
 /8sg==
X-Gm-Message-State: AOAM5306SdCKSCTwGvP4bha3S5TzEhhWJFPczrx0UiU1QQee7oL0yVuz
 cSa/EbpTRzrUpkauqF9lHOrsX6RU4/R8wFGTF3wqsw==
X-Google-Smtp-Source: ABdhPJxBHSQNea+Lzdyv+5EibhLnAJ7iYc9UkGZ12Zg+ox9mRUh9LRkwbsUNo7aAO5KVo1dJLgVEikfEfS0SZJuZu/0=
X-Received: by 2002:a05:6808:1405:: with SMTP id
 w5mr1639585oiv.48.1616466205255; 
 Mon, 22 Mar 2021 19:23:25 -0700 (PDT)
MIME-Version: 1.0
References: <20210316215644.2254177-1-jiang.wang@bytedance.com>
 <YFIj+FQQzZmVAqWw@stefanha-x1.localdomain>
 <CAP_N_Z857fnkc4GejHt_t_nxnhXC60=S51i_XQ-AdgXO2NipFA@mail.gmail.com>
 <YFjK7MkmJOFaUvgz@stefanha-x1.localdomain>
 <CAP_N_Z-aOds0-DgSYgGLb3AG7kvf=iqmLHojMjh878j8bTBkwg@mail.gmail.com>
 <20210322190517-mutt-send-email-mst@kernel.org>
In-Reply-To: <20210322190517-mutt-send-email-mst@kernel.org>
From: "Jiang Wang ." <jiang.wang@bytedance.com>
Date: Mon, 22 Mar 2021 19:23:14 -0700
Message-ID: <CAP_N_Z_g1jgQE71WLPA45w72WJ8+1WFaP3zzXH8FRpFap=jqCA@mail.gmail.com>
Subject: Re: [External] Re: [RFC PATCH] virtio-vsock: add description for
 datagram type
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: cong.wang@bytedance.com, Xiongchun Duan <duanxiongchun@bytedance.com>,
 cohuck@redhat.com, virtualization@lists.linux-foundation.org,
 xieyongji@bytedance.com, Stefan Hajnoczi <stefanha@redhat.com>,
 Arseny Krasnov <arseny.krasnov@kaspersky.com>, asias@redhat.com
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

Got it. Will do.

On Mon, Mar 22, 2021 at 4:10 PM Michael S. Tsirkin <mst@redhat.com> wrote:
>
> On Mon, Mar 22, 2021 at 04:02:14PM -0700, Jiang Wang . wrote:
> > After dropping my additional accounting. I think there is still a question
> > about if we want to protect the shared dgram virtqueue
> > against bad dgram sockets or not. And if so, how to do it, or what to write
> > in the spec. For example, if a bad dgram socket keeps sending lots of
> > data to a port that no socket is receiving,
> > then those packets will only be dropped by the receiver (device or the
> > driver), or
> > when the virtqueue is full. Other good dgram sockets will compete
> > with this bad one on the tx side. In my current implementation, it
> > depends on how the Linux scheduler schedules those processes.
> > The bad one is unlikely to make the virtqueue full all the time and
> > completely block
> > other good dgram sockets because the other end is still receiving and
> > cleaning the virtqueue. But it will waste a lot of resources. I think
> > that is fine and we don't need to add strict requirements about it
> > in the spec.
> >
> > I don't know if UDP has a similar situation as shared virtqueue or not. The
> > net.ipv4.udp_mem looks like just a global accounting. If you have any
> > suggestions about this, please let me know.
> >
> > Thank you!
>
> Yes I suspect just not doing any accounting isn't going to work well.
> Consider that with a NIC, if a socket is sending too much data faster
> than destination can consume it, its packets get dropped. So far so
> good.
>
> With vsock, if your guest gets too fast, packets are being dropped
> which is faster than processing them on the host.
> The result is guest goes even faster!
>
> Used to be a problem on linux too before packets inside transmit
> queues started being accounted for: a socket would fill
> the tx queue then others would just drop their packets.
>
> So we need some kind of accounting to slow down transmitters when
> they go too fast, to avoid this kind of positive feedback.
>
>
> --
> MST
>
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
