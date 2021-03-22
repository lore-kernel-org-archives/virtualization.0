Return-Path: <SRS0=byTZ=IU=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5813C433DB
	for <virtualization@archiver.kernel.org>; Mon, 22 Mar 2021 23:10:51 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6AAC4619A3
	for <virtualization@archiver.kernel.org>; Mon, 22 Mar 2021 23:10:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6AAC4619A3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 609524033B;
	Mon, 22 Mar 2021 23:10:50 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id F8QuUkUuJ3up; Mon, 22 Mar 2021 23:10:49 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTP id E61F340319;
	Mon, 22 Mar 2021 23:10:48 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B9EBCC000A;
	Mon, 22 Mar 2021 23:10:48 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 41074C0001
 for <virtualization@lists.linux-foundation.org>;
 Mon, 22 Mar 2021 23:10:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 274EF40426
 for <virtualization@lists.linux-foundation.org>;
 Mon, 22 Mar 2021 23:10:47 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id JyyoCwk2aZ2z
 for <virtualization@lists.linux-foundation.org>;
 Mon, 22 Mar 2021 23:10:45 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 8E786402CF
 for <virtualization@lists.linux-foundation.org>;
 Mon, 22 Mar 2021 23:10:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1616454644;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=0GSkArCoHjBftwE81RTwvCUXwgriULlhE+khZ58rqTs=;
 b=X+MkecUS0yVufrZ99cI8+8HzGqvjVcSkmTNQ6BFxEkTtjg2Xtq1oIhecOh2wKfoCdCV5E6
 OFkq+6sySBQgJiMsoCaE/sMaXNUD74CZHIeD7qKYj8VVdy3VwHB7kdL5UEtG2VWLLtUYuS
 KXleAMeLGM2ijhaj5n9uYDth7bAanEk=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-240-iEJ1YcwXOLKW6mB1vWYrMw-1; Mon, 22 Mar 2021 19:10:40 -0400
X-MC-Unique: iEJ1YcwXOLKW6mB1vWYrMw-1
Received: by mail-wm1-f71.google.com with SMTP id n22so43607wmo.7
 for <virtualization@lists.linux-foundation.org>;
 Mon, 22 Mar 2021 16:10:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=0GSkArCoHjBftwE81RTwvCUXwgriULlhE+khZ58rqTs=;
 b=XRNpityzB1er0Rkvq13S4tZHxhGEEKrfDOX9WTdgCDM+Ecgk60JXPDEpJJZ5KdxdPT
 Q3vlWYERz1pHBEHloUmzuGRiEJ/XFYyu8yNj0uRhE5d7BjxflHL9jNpR1KBgmf655PAc
 XO7ukeIFRix1sa4SUhhgsseKzfGYZVh9Ndu3Z+kezpeiTPo7JDR9yn9/0HF/DbXLrNrp
 oHm88tMqPgqdEb26ZKZ2YWM3shOY6R4wYBOlIQK+wz1ebmr69Ip+QgO9rM+y3IFJZiP8
 FD/8/9NPJncwCivFlSZpBqAQeAA/R03Brmf1MfidkA49ueVaaTDYEQ8Ive9n180KLILr
 5GHQ==
X-Gm-Message-State: AOAM531buHxy9ZO1HVHv8i0KSBfvmhdZZf5Qls5o5G5VWzbjAaChKcta
 NNkO9TD3IV+3xSRnjcIBhvSqcbxGkZWc6FRRu0+/MYsBKAXTqU5418T6fxNa/IUsqVlxB6kLK5P
 xXXmf5d1gZmi67ZT35l6gkMlOmJtg6THBt+/rceoirg==
X-Received: by 2002:a7b:ce06:: with SMTP id m6mr627323wmc.38.1616454639285;
 Mon, 22 Mar 2021 16:10:39 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx1mG/vc2tmrW+ACX0Op/1fIPobrvF9fMdxrYX9ayfccdaXzIP5ei+y/c6Sc2s29CSZyh5+3w==
X-Received: by 2002:a7b:ce06:: with SMTP id m6mr627310wmc.38.1616454639125;
 Mon, 22 Mar 2021 16:10:39 -0700 (PDT)
Received: from redhat.com ([2a10:800e:f0d3:0:b69b:9fb8:3947:5636])
 by smtp.gmail.com with ESMTPSA id n23sm22825856wra.71.2021.03.22.16.10.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Mar 2021 16:10:38 -0700 (PDT)
Date: Mon, 22 Mar 2021 19:10:34 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: "Jiang Wang ." <jiang.wang@bytedance.com>
Subject: Re: [External] Re: [RFC PATCH] virtio-vsock: add description for
 datagram type
Message-ID: <20210322190517-mutt-send-email-mst@kernel.org>
References: <20210316215644.2254177-1-jiang.wang@bytedance.com>
 <YFIj+FQQzZmVAqWw@stefanha-x1.localdomain>
 <CAP_N_Z857fnkc4GejHt_t_nxnhXC60=S51i_XQ-AdgXO2NipFA@mail.gmail.com>
 <YFjK7MkmJOFaUvgz@stefanha-x1.localdomain>
 <CAP_N_Z-aOds0-DgSYgGLb3AG7kvf=iqmLHojMjh878j8bTBkwg@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAP_N_Z-aOds0-DgSYgGLb3AG7kvf=iqmLHojMjh878j8bTBkwg@mail.gmail.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
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

On Mon, Mar 22, 2021 at 04:02:14PM -0700, Jiang Wang . wrote:
> After dropping my additional accounting. I think there is still a question
> about if we want to protect the shared dgram virtqueue
> against bad dgram sockets or not. And if so, how to do it, or what to write
> in the spec. For example, if a bad dgram socket keeps sending lots of
> data to a port that no socket is receiving,
> then those packets will only be dropped by the receiver (device or the
> driver), or
> when the virtqueue is full. Other good dgram sockets will compete
> with this bad one on the tx side. In my current implementation, it
> depends on how the Linux scheduler schedules those processes.
> The bad one is unlikely to make the virtqueue full all the time and
> completely block
> other good dgram sockets because the other end is still receiving and
> cleaning the virtqueue. But it will waste a lot of resources. I think
> that is fine and we don't need to add strict requirements about it
> in the spec.
> 
> I don't know if UDP has a similar situation as shared virtqueue or not. The
> net.ipv4.udp_mem looks like just a global accounting. If you have any
> suggestions about this, please let me know.
> 
> Thank you!

Yes I suspect just not doing any accounting isn't going to work well.
Consider that with a NIC, if a socket is sending too much data faster
than destination can consume it, its packets get dropped. So far so
good.

With vsock, if your guest gets too fast, packets are being dropped
which is faster than processing them on the host.
The result is guest goes even faster!

Used to be a problem on linux too before packets inside transmit
queues started being accounted for: a socket would fill
the tx queue then others would just drop their packets.

So we need some kind of accounting to slow down transmitters when
they go too fast, to avoid this kind of positive feedback.


-- 
MST

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
