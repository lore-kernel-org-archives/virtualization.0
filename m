Return-Path: <SRS0=i4sF=I4=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 940EDC433C1
	for <virtualization@archiver.kernel.org>; Tue, 30 Mar 2021 18:35:06 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 077DF61924
	for <virtualization@archiver.kernel.org>; Tue, 30 Mar 2021 18:35:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 077DF61924
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=bytedance.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id A7BED6084D;
	Tue, 30 Mar 2021 18:35:05 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id PCP0L8SmHArZ; Tue, 30 Mar 2021 18:35:04 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTP id 3EE216084C;
	Tue, 30 Mar 2021 18:35:04 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id DA5F5C000B;
	Tue, 30 Mar 2021 18:35:03 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3E1C3C000A
 for <virtualization@lists.linux-foundation.org>;
 Tue, 30 Mar 2021 18:35:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 1DF81401D3
 for <virtualization@lists.linux-foundation.org>;
 Tue, 30 Mar 2021 18:35:02 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=bytedance-com.20150623.gappssmtp.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id MtVjnw4nhsvk
 for <virtualization@lists.linux-foundation.org>;
 Tue, 30 Mar 2021 18:35:01 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com
 [IPv6:2607:f8b0:4864:20::329])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 0C6EB40183
 for <virtualization@lists.linux-foundation.org>;
 Tue, 30 Mar 2021 18:35:00 +0000 (UTC)
Received: by mail-ot1-x329.google.com with SMTP id
 w21-20020a9d63950000b02901ce7b8c45b4so16503932otk.5
 for <virtualization@lists.linux-foundation.org>;
 Tue, 30 Mar 2021 11:35:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance-com.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=lavd40+aKMRCb59ZCzrxYr1pYRcO0CGc7lld+0DWfvU=;
 b=nzxYHtSe8UnRSpjGb7OH61dl7x0+/ToUrXrPCbTjy9d2Ewx74fRlf0a/JmWeEHUNzl
 +yPdreek2KhBqG1zrno/7xzOz43alEYGolw99XUDndolxXMrw9Zb0WAIYfvbXWXmJKrC
 s84Nf4qCuASS0gkRJTUlCRBycTJQlnpyO/+VXY6t+Wa9iPTidIUmdF/m5jouRcjwl/OY
 W43PBu8r/QH7nj0yjBPr5mIavqqD0emopztS69fK+dpEQai6Wn1UvqJl8l6q7wozX2FM
 6ftuCMJDGiayrDMgBi7dbxeEotBK+SixnAady46CshAaIPnxWJ5p09OZ2uOCFW1EhYBY
 1gug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=lavd40+aKMRCb59ZCzrxYr1pYRcO0CGc7lld+0DWfvU=;
 b=r9A6VacpD2vco+2cMc7Oon0XAbrwRiF+U0k8+idS9kYe88WdB1eB3ns6BHE9pGJUXi
 guBucRhz8mIGsIZmQYkEvEAttORa0q6setqFEEjQZrpBMh1gfH45NXi803vwfnyglSi7
 V7RRCaByvhwyWVoFZb8pix1f/1HOcZ3ROgn6hLT1B+ca6rnklY22KrBUwlBAuDp/sbfe
 DR1h8yDaJZqN8vAjIWfXH0QbyE5D/XfiDrlVe0DatHIE/++maA/O5oyy7CZiPUVUdSmj
 xb2+FRzDVki6NrCth1iJj3bvdY9zXtGLwQkRHb3p64w7vWWQe3/zX3ex/CMOIeOA1A/E
 +CAg==
X-Gm-Message-State: AOAM533Xs2PhSP0Vvzsh91ptxJpZQoHWlKW2W1S5g8F7L4H6QHaApbaF
 8+bdXQjzVjpwWw0YuErMCodeMeuQacsgjgRAgejVUw==
X-Google-Smtp-Source: ABdhPJzdsYPFC0a73PdcgMPMDGLe4BhzI8RoFXP+F9iDMd72CeAvc8I9CF2qqo3Y6P+PzB0GbufuzIoq2gzyh7ln90g=
X-Received: by 2002:a05:6830:22c3:: with SMTP id
 q3mr28001914otc.56.1617129299836; 
 Tue, 30 Mar 2021 11:34:59 -0700 (PDT)
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
 <20210330153231.duj6wqnekztdherp@steredhat>
In-Reply-To: <20210330153231.duj6wqnekztdherp@steredhat>
From: "Jiang Wang ." <jiang.wang@bytedance.com>
Date: Tue, 30 Mar 2021 11:34:49 -0700
Message-ID: <CAP_N_Z8Z1hzWSoU3ezUDz0+_EkGjgRJVgsuDGvOcEe7MkTsHTQ@mail.gmail.com>
Subject: Re: [External] Re: [RFC PATCH] virtio-vsock: add description for
 datagram type
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

On Tue, Mar 30, 2021 at 8:32 AM Stefano Garzarella <sgarzare@redhat.com> wrote:
>
> Hi Jiang,
>
> On Fri, Mar 26, 2021 at 04:40:09PM -0700, Jiang Wang . wrote:
> >Hi Michael and Stefan,
> >
> >I thought about this and discussed it with my colleague Cong Wang.
> >One idea is to make current asynchronous send_pkt flow to be synchronous,
> >then if the virtqueue is full, the function can return  ENOMEM all the way back
> >to the caller and the caller can check the return value of sendmsg
> >and slow down when necessary.
> >
> >In the spec, we can put something like, if the virtqueue is full, the caller
> >should be notified with an error etc.
> >
> >In terms of implementation, that means we will remove the current
> >send_pkt_work for both stream and dgram sockets. Currently, the
> >code path uses RCU and a work queue, then grab a mutex in the
> >work queue function. Since we cannot grab mutex when in rcu
> >critical section, we have to change RCU to a normal reference
> >counting mechanism. I think this is doable. The drawback is
> >that the reference counting in general spends a little more
> >cycles than the RCU, so there is a small price to pay. Another
> >option is to use Sleepable RCU and remove the work queue.
> >
> >What do you guys think?
>
> another thing that came to mind not related to the spec but to the Linux
> implementation, is the multi-transport support.
> When we discussed the initial proposals [1][2], we decided to take a
> shortcut for DGRAM, since the only transport with DGRAM support was
> vmci. So for now only a single transport with VSOCK_TRANSPORT_F_DGRAM
> set can be registered.
>
> Since also virtio-transport and vhost-transport will support DGRAM, we
> need to find a way to allow multiple transports that support DGRAM to be
> registered together to support nested VMs.
>
> Do you have already thought about how to solve this problem?
>
> We should definitely allow the registration of more transports with
> VSOCK_TRANSPORT_F_DGRAM, and dynamically choose which one to use when
> sending a packet.

Got it. We briefly discussed multiple dgram transport
support in my old email thread. At that time, I was thinking
maybe check for transport for each packet. I did not spend more
time on that part after that. I will think about it more and get
back to you. Thanks

> Thanks,
> Stefano
>
> [1] https://www.spinics.net/lists/netdev/msg570274.html
> [2] https://www.spinics.net/lists/netdev/msg575792.html
>
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
