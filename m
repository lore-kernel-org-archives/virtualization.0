Return-Path: <SRS0=4L+9=IY=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93B65C433C1
	for <virtualization@archiver.kernel.org>; Fri, 26 Mar 2021 23:40:26 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1D828619FF
	for <virtualization@archiver.kernel.org>; Fri, 26 Mar 2021 23:40:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1D828619FF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=bytedance.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id A995384D5D;
	Fri, 26 Mar 2021 23:40:25 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ObIkR-5rBPM1; Fri, 26 Mar 2021 23:40:24 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTP id 5174484D56;
	Fri, 26 Mar 2021 23:40:24 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 1E70AC000C;
	Fri, 26 Mar 2021 23:40:24 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 7A1FCC000A
 for <virtualization@lists.linux-foundation.org>;
 Fri, 26 Mar 2021 23:40:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 6229440629
 for <virtualization@lists.linux-foundation.org>;
 Fri, 26 Mar 2021 23:40:22 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=bytedance-com.20150623.gappssmtp.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id eZu4PGCmRaiY
 for <virtualization@lists.linux-foundation.org>;
 Fri, 26 Mar 2021 23:40:21 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com
 [IPv6:2607:f8b0:4864:20::336])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 5EFED40287
 for <virtualization@lists.linux-foundation.org>;
 Fri, 26 Mar 2021 23:40:21 +0000 (UTC)
Received: by mail-ot1-x336.google.com with SMTP id
 w21-20020a9d63950000b02901ce7b8c45b4so6779805otk.5
 for <virtualization@lists.linux-foundation.org>;
 Fri, 26 Mar 2021 16:40:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance-com.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=bTqZTcR0Pgr45CeTn0t96sPY3NsCLfxBX+ACA2V1zRE=;
 b=0vO/i/oZ0xiOCRxJnwkGwiuhaaihVhYJBkPBQFxa+vjgTAi2V7eMliLeo/subSkcH5
 5TXxMhShO78vdf6Fl0hYAZaVe7g1xb4T3Eov3a+lVuEP8mWDkhE9BhrUOXYUklQOo/rM
 QOFdarcz3vGqIKw0n1lfEv3JxJhwIgdPFa9vMhIrARKkKjRhPtJ18lnRB/N2nWwJPClI
 EWbykedG8BtqbyEpLCWs7W2kHnSqwEIwFjk2nZJ4Zre7aGFsDZcnTM87c0yqF9+mgyET
 d6btL6c1LFUqQsTtCU1LlSluQl7U8eWmqWV3TKHkGXFS3FNW9SohM0sFKTfp6lqSUJEm
 oFYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=bTqZTcR0Pgr45CeTn0t96sPY3NsCLfxBX+ACA2V1zRE=;
 b=Ymzh1x/zxVlYWZwv21XojyMAxPiWpQwtDsu78b3rYtRIpXE415H66HtD5+9tDFWbeM
 Qm7nKO9AnUL+8KFHscBwgXT8B2d0tsXoX3lBA8XLLXtm+M2JWov8M9cs3JTjCju7X/dX
 RIsZhP60e1CQtsXapBUc34o8C3lig/Xu3nGZHJvtpoyEXXfmOixY/KoeJahI5lMtHnFm
 b1/CjVJDkoSHMXHGnXRSgDU+HJ/K1dFdTj+xOX0jYjn3CzVsY2bCTFnRKFK0lc3iRorY
 MNdBrZCSg2QQ9+8wFYsy5ZHxFNZZjodNzNorFUmxCyYJUUok7j9uUme1SKvv2frNY4Cc
 Jm9Q==
X-Gm-Message-State: AOAM5307k6jdyXYZoOPkq8X0JWlXRa0MpbWdmykuJb13MozSReYelx5H
 No7XItDgltkX7BB6aDFWR5vPOaRJjDyw9c84qN4CFQ==
X-Google-Smtp-Source: ABdhPJw7RAVS4Iqai0XEvZv5Ptz5kG/An7TVGObMngV2R1I6/0Riw1omrS0r2kB/OBfIxFp/xbnFrBMrWffEjtvL64k=
X-Received: by 2002:a9d:5d0a:: with SMTP id b10mr96830oti.180.1616802020270;
 Fri, 26 Mar 2021 16:40:20 -0700 (PDT)
MIME-Version: 1.0
References: <20210316215644.2254177-1-jiang.wang@bytedance.com>
 <YFIj+FQQzZmVAqWw@stefanha-x1.localdomain>
 <CAP_N_Z857fnkc4GejHt_t_nxnhXC60=S51i_XQ-AdgXO2NipFA@mail.gmail.com>
 <YFjK7MkmJOFaUvgz@stefanha-x1.localdomain>
 <CAP_N_Z-aOds0-DgSYgGLb3AG7kvf=iqmLHojMjh878j8bTBkwg@mail.gmail.com>
 <20210322190517-mutt-send-email-mst@kernel.org>
 <CAP_N_Z_g1jgQE71WLPA45w72WJ8+1WFaP3zzXH8FRpFap=jqCA@mail.gmail.com>
 <YFmsb6o82KOSml9u@stefanha-x1.localdomain>
In-Reply-To: <YFmsb6o82KOSml9u@stefanha-x1.localdomain>
From: "Jiang Wang ." <jiang.wang@bytedance.com>
Date: Fri, 26 Mar 2021 16:40:09 -0700
Message-ID: <CAP_N_Z9g3VUeLGtC0D0EGmHk7D1RxFQvUBMzLDMkct5b=t6x3A@mail.gmail.com>
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

Hi Michael and Stefan,

I thought about this and discussed it with my colleague Cong Wang.
One idea is to make current asynchronous send_pkt flow to be synchronous,
then if the virtqueue is full, the function can return  ENOMEM all the way back
to the caller and the caller can check the return value of sendmsg
and slow down when necessary.

In the spec, we can put something like, if the virtqueue is full, the caller
should be notified with an error etc.

In terms of implementation, that means we will remove the current
send_pkt_work for both stream and dgram sockets. Currently, the
code path uses RCU and a work queue, then grab a mutex in the
work queue function. Since we cannot grab mutex when in rcu
critical section, we have to change RCU to a normal reference
counting mechanism. I think this is doable. The drawback is
that the reference counting in general spends a little more
cycles than the RCU, so there is a small price to pay. Another
option is to use Sleepable RCU and remove the work queue.

What do you guys think?

btw, I will also add some SENDBUF restrictions for the dgram
sockets, but I don't think it needs to be in the spec.

Regards,

Jiang

On Tue, Mar 23, 2021 at 1:53 AM Stefan Hajnoczi <stefanha@redhat.com> wrote:
>
> On Mon, Mar 22, 2021 at 07:23:14PM -0700, Jiang Wang . wrote:
> > Got it. Will do.
>
> You could look at udp_sendmsg() to see how sockets compete when
> transmitting to the same net device.
>
> I'm not very familiar with this but I guess that the qdisc (like
> fq_codel) decides which packets to place into the device's tx queue. I
> guess sk_buffs waiting to be put onto the device's tx queue are
> accounted for against the socket's sndbuf. Further sendmsg calls will
> fail with -ENOBUFS when the sndbuf limit is reached.
>
> It's not clear to me how much of the existing code can be reused since
> vsock does not use sk_buff or netdev :(.
>
> Stefan
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
