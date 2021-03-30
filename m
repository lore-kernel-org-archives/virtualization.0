Return-Path: <SRS0=i4sF=I4=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2348DC433DB
	for <virtualization@archiver.kernel.org>; Tue, 30 Mar 2021 18:31:09 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6EE73619CC
	for <virtualization@archiver.kernel.org>; Tue, 30 Mar 2021 18:31:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6EE73619CC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=bytedance.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id E9F84404C8;
	Tue, 30 Mar 2021 18:31:07 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id qsRpRD9uzazG; Tue, 30 Mar 2021 18:31:06 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTP id 46FF7404B7;
	Tue, 30 Mar 2021 18:31:06 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 2251EC000B;
	Tue, 30 Mar 2021 18:31:06 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 8D317C000A
 for <virtualization@lists.linux-foundation.org>;
 Tue, 30 Mar 2021 18:31:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 7B5E56076C
 for <virtualization@lists.linux-foundation.org>;
 Tue, 30 Mar 2021 18:31:04 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=bytedance-com.20150623.gappssmtp.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id YIfW8eLT1wyu
 for <virtualization@lists.linux-foundation.org>;
 Tue, 30 Mar 2021 18:31:03 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com
 [IPv6:2607:f8b0:4864:20::232])
 by smtp3.osuosl.org (Postfix) with ESMTPS id D57EF606E5
 for <virtualization@lists.linux-foundation.org>;
 Tue, 30 Mar 2021 18:31:02 +0000 (UTC)
Received: by mail-oi1-x232.google.com with SMTP id k25so17437388oic.4
 for <virtualization@lists.linux-foundation.org>;
 Tue, 30 Mar 2021 11:31:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance-com.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=BiadkGNpvhnIMeQYg/IP/wXCd55Z8PSjgFBbL4qkBoo=;
 b=L3MlhZ1tGUHuJC1qBY8TYBUDDYdD1Sr5wnV9VN2VYeFQt8MpqWb01HDjZmFczUp4WK
 UUmPHBnJTkeZMzKLduLOFC4n51mx2h4uL0+gDNOwRGzJs/YcFD5e280SqplDycIRQEsd
 ZfW4rVLo3MuDbRX7tmH3YLf4NhYTPcwU4ZNsJldZUjeqiPiLeo+k5isKLJ7FFrhyzE+n
 JAYCQi0Q48nej/n9a44RHc7l5HSTFUP6dOwOl2CgWwmQ9aIEh3wt8WaXnNs8FC+xeaTw
 4zefmuKGIsljP2AaeZOUIC+Id0Q9CZUeoTWmrziaB5cZtpuLFEDPdsEsroqXV4YQQOTq
 OprA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=BiadkGNpvhnIMeQYg/IP/wXCd55Z8PSjgFBbL4qkBoo=;
 b=KAnL0eBit8FrX0PvS9yO17W3fBx/lv3F+6STGbmooQ5bjGAelXf+eHsM0eJfntIRbl
 yacUcYEb2mq0NG8Ony8e6kCR+VknwQUzcStyUnCkUpOXzoaadHqpHRBBqOx0TBOSy0Ei
 M/KmvT254ohZNkegSVT2mtOIsYM0ZmvYp7x/lnM/pSuFk2gArmFCF1dZYRW23SVN0W1F
 471yksoqulvOBhHYDi0jOZylTS2TUGVgFcGsa3KO6fSL9WJ2/9kG60J+v7ZZS9X5U81t
 cLA9D73YmGuxQyg4M+mKqS0eikFmrKW133JqS+Okp+RB8vKYWdfLc55hQ4C/rIHgmspv
 BFdg==
X-Gm-Message-State: AOAM533E+2JLD/lfuRePbJGSfd8bowbiFMEdzIIqKEGmqcEUjDqLbTOI
 mwlQNjbPz6TjtdzKb7NwgDPjqdVThONJVMeO2MsAYw==
X-Google-Smtp-Source: ABdhPJxYg7RRDHDvpGY5GG8Nvz+gsHvVQN57k1nQsJC/ABOVIZO1TF6EoM3ZZhOxmltvkyIWZKW57uk34qsztoqL0cQ=
X-Received: by 2002:aca:4b4d:: with SMTP id y74mr4243407oia.97.1617129061712; 
 Tue, 30 Mar 2021 11:31:01 -0700 (PDT)
MIME-Version: 1.0
References: <YFIj+FQQzZmVAqWw@stefanha-x1.localdomain>
 <CAP_N_Z857fnkc4GejHt_t_nxnhXC60=S51i_XQ-AdgXO2NipFA@mail.gmail.com>
 <YFjK7MkmJOFaUvgz@stefanha-x1.localdomain>
 <CAP_N_Z-aOds0-DgSYgGLb3AG7kvf=iqmLHojMjh878j8bTBkwg@mail.gmail.com>
 <20210322190517-mutt-send-email-mst@kernel.org>
 <CAP_N_Z_g1jgQE71WLPA45w72WJ8+1WFaP3zzXH8FRpFap=jqCA@mail.gmail.com>
 <YFmsb6o82KOSml9u@stefanha-x1.localdomain>
 <CAP_N_Z9g3VUeLGtC0D0EGmHk7D1RxFQvUBMzLDMkct5b=t6x3A@mail.gmail.com>
 <YGGdHfgJF45GRp5n@stefanha-x1.localdomain>
 <CAP_N_Z-v5ZFKO0SNeZre=F6q_+aQohHVQ1fg9oXbfboZgv_xeQ@mail.gmail.com>
 <YGMAfBLzcaCMwLJK@stefanha-x1.localdomain>
In-Reply-To: <YGMAfBLzcaCMwLJK@stefanha-x1.localdomain>
From: "Jiang Wang ." <jiang.wang@bytedance.com>
Date: Tue, 30 Mar 2021 11:30:50 -0700
Message-ID: <CAP_N_Z-=2RaH+w0YnZ=XMsjT=tWk4GQzww=NtKoVtTeayMpJSg@mail.gmail.com>
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

On Tue, Mar 30, 2021 at 3:42 AM Stefan Hajnoczi <stefanha@redhat.com> wrote:
>
> On Mon, Mar 29, 2021 at 04:22:28PM -0700, Jiang Wang . wrote:
> > On Mon, Mar 29, 2021 at 2:26 AM Stefan Hajnoczi <stefanha@redhat.com> wrote:
> > >
> > > On Fri, Mar 26, 2021 at 04:40:09PM -0700, Jiang Wang . wrote:
> > > > I thought about this and discussed it with my colleague Cong Wang.
> > > > One idea is to make current asynchronous send_pkt flow to be synchronous,
> > > > then if the virtqueue is full, the function can return  ENOMEM all the way back
> > > > to the caller and the caller can check the return value of sendmsg
> > > > and slow down when necessary.
> > > >
> > > > In the spec, we can put something like, if the virtqueue is full, the caller
> > > > should be notified with an error etc.
> > > >
> > > > In terms of implementation, that means we will remove the current
> > > > send_pkt_work for both stream and dgram sockets. Currently, the
> > > > code path uses RCU and a work queue, then grab a mutex in the
> > > > work queue function. Since we cannot grab mutex when in rcu
> > > > critical section, we have to change RCU to a normal reference
> > > > counting mechanism. I think this is doable. The drawback is
> > > > that the reference counting in general spends a little more
> > > > cycles than the RCU, so there is a small price to pay. Another
> > > > option is to use Sleepable RCU and remove the work queue.
> > > >
> > > > What do you guys think?
> > >
> > > I think the tx code path is like this because of reliable delivery.
> > > Maybe a separate datagram rx/tx code path would be simpler?
> >
> > I thought about this too.  dgram can have a separate rx/tx
> > path from stream types. In this case, the the_virtio_vsock
> > will still be shared because the virtqueues have to be in one
> > structure. Then the_virtio_vsock will be protected by a rcu
> > and a reference counting ( or a sleepable RCU ).
> >
> > In vhost_vsock_dev_release, it will wait for both rcu and another
> > one to be finished and then free the memory. I think this is
> > doable. Let me know if there is a better way to do it.
> > Btw, I think dgram tx code path will be quite different from
> > stream, but dgram rx path will be similar to stream type.
> >
> > > Take the datagram tx virtqueue lock, try to add the packet into the
> > > virtqueue, and return -ENOBUFS if the virtqueue is full. Then use the
> > > datagram socket's sndbuf accounting to prevent queuing up too many
> > > packets. When a datagram tx virtqueue buffer is used by the device,
> > > select queued packets for transmission.
> >
> > I am not sure about the last sentence. In the new design, there will
> > be no other queued packets for dgram (except those in the virtqueue).
> > When dgram tx virtqueue is freed by the device, the driver side
> > just needs to free some space. No need
> > to trigger more transmission.
>
> This approach drops packets when the virtqueue is full. In order to get
> close to UDP semantics I think the following is necessary:
>
> 1. Packets are placed directly into the tx virtqueue when possible.
> 2. Packets are queued up to sndbuf bytes if the tx virtqueue is full.
> 3. When a full tx virtqueue gets some free space again there is an
>    algorithm that selects from among the queued sockets.
>
> This is how unreliably delivery can be somewhat fair between competing
> threads. I thought you were trying to achieve this (it's similar to what
> UDP does)?

I see. I was thinking something different without an extra queue. I think
your approach is better. For step 3, I think I will just start with a simple
FIFO algorithm first.


> Stefan
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
