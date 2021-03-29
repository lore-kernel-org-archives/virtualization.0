Return-Path: <SRS0=wWNv=I3=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACD88C433C1
	for <virtualization@archiver.kernel.org>; Mon, 29 Mar 2021 23:22:47 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 28E3D61990
	for <virtualization@archiver.kernel.org>; Mon, 29 Mar 2021 23:22:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 28E3D61990
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=bytedance.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id CCC2F403E9;
	Mon, 29 Mar 2021 23:22:46 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id nA7LBH9d2txz; Mon, 29 Mar 2021 23:22:44 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTP id 2E02E40357;
	Mon, 29 Mar 2021 23:22:44 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 032CFC000B;
	Mon, 29 Mar 2021 23:22:44 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3B7D8C000A
 for <virtualization@lists.linux-foundation.org>;
 Mon, 29 Mar 2021 23:22:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 29D5D607ED
 for <virtualization@lists.linux-foundation.org>;
 Mon, 29 Mar 2021 23:22:42 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=bytedance-com.20150623.gappssmtp.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id hlliSDajKwVv
 for <virtualization@lists.linux-foundation.org>;
 Mon, 29 Mar 2021 23:22:40 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com
 [IPv6:2607:f8b0:4864:20::331])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 7C103607CC
 for <virtualization@lists.linux-foundation.org>;
 Mon, 29 Mar 2021 23:22:39 +0000 (UTC)
Received: by mail-ot1-x331.google.com with SMTP id
 t23-20020a0568301e37b02901b65ab30024so13900119otr.4
 for <virtualization@lists.linux-foundation.org>;
 Mon, 29 Mar 2021 16:22:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance-com.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=yJLFRWZLpPpwRxH2i0kZ9GQbSF6EFssuN7JBVs6jYuk=;
 b=aM4jGcHoBvjGUVEDog/ZtJiFcaE8nDhwMXu/kBKEKZgigI3uypjviP6mOhO0lRWSyX
 m1W025yu/JEduHQ1kZZBvLVGFiE9nuwtFYp7+v0naep+5lFgQVuq2l/1QF1Plfi5G0Va
 t3qOnIGMOGVYZoeFMP3BnUBQpunIKQ/goCGXQZdrTGy6HMD4iys8/sNvYPWAxkkaf9ac
 wbydxQcrKS5Luc30Nqo0J88kjzx2cpCyEQaZa33p+RgoTSy3y3CAvQsPOCBfNSwgfsjQ
 dic6N1aG8HYx+abLgY9fVTF9AngHePYb0HW72K65S1CPUa+ye1ITbKTkH3M2gHifRHPz
 BEZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=yJLFRWZLpPpwRxH2i0kZ9GQbSF6EFssuN7JBVs6jYuk=;
 b=bF7YNaqwpUfWYeD6C3KtOIN8j+y5Pe0fKrRVScjiuoSDL+sWYy51Ugf81IrjX91VQ6
 YNGc6MX63lOR+5cQFomPXnkm2qLT0LSq60HiWXNJ9xSTG+W5L4Lvbd5yvYIVjYs79Kpr
 4maCWSF8IcUQUfwYDnvWbdDCIs1XxJyJuHeKCH9zmJdd4Olnla2x24ttDE1jEw9pciXS
 j5CQ4kBoAeW+mG3Q/9O7atxYqWKHcUERCleYIey1K6dkaBsFBrqE4/KkFmXAvetYBCOo
 bAHryO6QrbgGgJ59pRhHSE7tFWZtvBdugopWWdy5I0/fy7nsifXYzwYa/CRTcnC7rMKC
 sewA==
X-Gm-Message-State: AOAM530Eohl0AKye5nYkQIcNxqvuH+4n7y/QKvJL5LCMooSvApeMA5Fz
 Nqu42/At7QAgahBfBctNbEXhASupaH2Bey1zddsmdg==
X-Google-Smtp-Source: ABdhPJyQlfhnj31P/cIMZ2MgPKNgYM+d1Wxkfb/WIc5YDRxL9N3YoiLNAnHsQwlsAdr5z1/K9OtyPyS3lPe4NgJMul4=
X-Received: by 2002:a05:6830:22c3:: with SMTP id
 q3mr24380921otc.56.1617060159149; 
 Mon, 29 Mar 2021 16:22:39 -0700 (PDT)
MIME-Version: 1.0
References: <20210316215644.2254177-1-jiang.wang@bytedance.com>
 <YFIj+FQQzZmVAqWw@stefanha-x1.localdomain>
 <CAP_N_Z857fnkc4GejHt_t_nxnhXC60=S51i_XQ-AdgXO2NipFA@mail.gmail.com>
 <YFjK7MkmJOFaUvgz@stefanha-x1.localdomain>
 <CAP_N_Z-aOds0-DgSYgGLb3AG7kvf=iqmLHojMjh878j8bTBkwg@mail.gmail.com>
 <20210322190517-mutt-send-email-mst@kernel.org>
 <CAP_N_Z_g1jgQE71WLPA45w72WJ8+1WFaP3zzXH8FRpFap=jqCA@mail.gmail.com>
 <YFmsb6o82KOSml9u@stefanha-x1.localdomain>
 <CAP_N_Z9g3VUeLGtC0D0EGmHk7D1RxFQvUBMzLDMkct5b=t6x3A@mail.gmail.com>
 <YGGdHfgJF45GRp5n@stefanha-x1.localdomain>
In-Reply-To: <YGGdHfgJF45GRp5n@stefanha-x1.localdomain>
From: "Jiang Wang ." <jiang.wang@bytedance.com>
Date: Mon, 29 Mar 2021 16:22:28 -0700
Message-ID: <CAP_N_Z-v5ZFKO0SNeZre=F6q_+aQohHVQ1fg9oXbfboZgv_xeQ@mail.gmail.com>
Subject: Re: [External] Re: [RFC PATCH] virtio-vsock: add description for
 datagram type
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: cong.wang@bytedance.com, Xiongchun Duan <duanxiongchun@bytedance.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, cohuck@redhat.com,
 virtualization@lists.linux-foundation.org, xieyongji@bytedance.com,
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

On Mon, Mar 29, 2021 at 2:26 AM Stefan Hajnoczi <stefanha@redhat.com> wrote:
>
> On Fri, Mar 26, 2021 at 04:40:09PM -0700, Jiang Wang . wrote:
> > I thought about this and discussed it with my colleague Cong Wang.
> > One idea is to make current asynchronous send_pkt flow to be synchronous,
> > then if the virtqueue is full, the function can return  ENOMEM all the way back
> > to the caller and the caller can check the return value of sendmsg
> > and slow down when necessary.
> >
> > In the spec, we can put something like, if the virtqueue is full, the caller
> > should be notified with an error etc.
> >
> > In terms of implementation, that means we will remove the current
> > send_pkt_work for both stream and dgram sockets. Currently, the
> > code path uses RCU and a work queue, then grab a mutex in the
> > work queue function. Since we cannot grab mutex when in rcu
> > critical section, we have to change RCU to a normal reference
> > counting mechanism. I think this is doable. The drawback is
> > that the reference counting in general spends a little more
> > cycles than the RCU, so there is a small price to pay. Another
> > option is to use Sleepable RCU and remove the work queue.
> >
> > What do you guys think?
>
> I think the tx code path is like this because of reliable delivery.
> Maybe a separate datagram rx/tx code path would be simpler?

I thought about this too.  dgram can have a separate rx/tx
path from stream types. In this case, the the_virtio_vsock
will still be shared because the virtqueues have to be in one
structure. Then the_virtio_vsock will be protected by a rcu
and a reference counting ( or a sleepable RCU ).

In vhost_vsock_dev_release, it will wait for both rcu and another
one to be finished and then free the memory. I think this is
doable. Let me know if there is a better way to do it.
Btw, I think dgram tx code path will be quite different from
stream, but dgram rx path will be similar to stream type.

> Take the datagram tx virtqueue lock, try to add the packet into the
> virtqueue, and return -ENOBUFS if the virtqueue is full. Then use the
> datagram socket's sndbuf accounting to prevent queuing up too many
> packets. When a datagram tx virtqueue buffer is used by the device,
> select queued packets for transmission.

I am not sure about the last sentence. In the new design, there will
be no other queued packets for dgram (except those in the virtqueue).
When dgram tx virtqueue is freed by the device, the driver side
just needs to free some space. No need
to trigger more transmission.


Unlike the stream tx/rx code
> path there is no dependency between tx and rx because we don't have the
> credit mechanism.
> > btw, I will also add some SENDBUF restrictions for the dgram
> > sockets, but I don't think it needs to be in the spec.
>
> Yes, the spec doesn't need to explain implementation-specific issues.
>
> If there are common implementation issues then the spec can explain them
> in general terms (not referring to Linux internals) to help
> implementors.

Got it. Thanks. I will send a v2 spec soon.

> Stefan
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
