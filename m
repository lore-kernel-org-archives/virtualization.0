Return-Path: <SRS0=Cini=I5=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4F54C433DB
	for <virtualization@archiver.kernel.org>; Wed, 31 Mar 2021 01:02:51 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1CDF9617C9
	for <virtualization@archiver.kernel.org>; Wed, 31 Mar 2021 01:02:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1CDF9617C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=bytedance.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id C5D23405DB;
	Wed, 31 Mar 2021 01:02:50 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id kB_i31u3_RyA; Wed, 31 Mar 2021 01:02:49 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTP id 065984059F;
	Wed, 31 Mar 2021 01:02:48 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D78B5C000B;
	Wed, 31 Mar 2021 01:02:48 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 2F19BC000A
 for <virtualization@lists.linux-foundation.org>;
 Wed, 31 Mar 2021 01:02:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 201A760902
 for <virtualization@lists.linux-foundation.org>;
 Wed, 31 Mar 2021 01:02:47 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=bytedance-com.20150623.gappssmtp.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id TbrQSiPMVCdp
 for <virtualization@lists.linux-foundation.org>;
 Wed, 31 Mar 2021 01:02:45 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com
 [IPv6:2607:f8b0:4864:20::32e])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 880E8608FE
 for <virtualization@lists.linux-foundation.org>;
 Wed, 31 Mar 2021 01:02:45 +0000 (UTC)
Received: by mail-ot1-x32e.google.com with SMTP id
 68-20020a9d0f4a0000b02901b663e6258dso17362134ott.13
 for <virtualization@lists.linux-foundation.org>;
 Tue, 30 Mar 2021 18:02:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance-com.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=wzEFJavdccmnVQqc3mRKAXF/O/vmgnf5AeRBC/jtQAQ=;
 b=pQjzeLggCgHPI1Kn5NU7INxfz5B+il0gqjTE+1CLXSk79lMnQpOiua8Epy3uMQcpi0
 FPoxOAXxNjrmL2LxzFXFWnGCylBt0Zdya8DLillX7C9DuaWzkdBAWxuVveHix7N5AkTi
 MqfoXJ6saO4MJJXdk8CRbnHJqAgDLn0QBJXp3BMetHNZDYSVAmo4Z/PaK7Y20LZISb32
 ulkGZFzMgh824RJp1NMJZUmUYOKMNR2UDL+Y1LhtC04HF1Mv3trYmAE8ZzP0Dx1XFpqT
 yHpfrQLnWI6EvT71xWsX/Z+p/xmbm7T17WEkDWoNqZHQKjikcmuPTw1zw1cbZ9gUx+f9
 A0ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=wzEFJavdccmnVQqc3mRKAXF/O/vmgnf5AeRBC/jtQAQ=;
 b=THAAR0t4t4G4VsNpYGv5ZtE0vCD9yOp9zKiPqrQ6aTMqHVLGjlbPytp9BEWVdQILie
 LjwDhdGp+fffzsZt780MTwQviUfwM+yWnUoqjlhSJ8L5dip8Jzik607MUChANBsCnCym
 WMs03jQje21WkQtbiEpo6I4LtyHDLr/vSxhjeecLNgMp9HaVRRYAddjB4ZK/Bt8gqZ5n
 onMrsQ5bZOMsWN6lRgHSizKo8hXFFAQq5fWnOm0xqHnT6ZF2ZnZ1YSmz4iGnw84SVMCA
 wqJTmBNUa/8WJQskCXerNm4YybzptvCAt66dLTi/ZqpQyeomL4Pi08HijlUl3BgtVkQT
 cTdw==
X-Gm-Message-State: AOAM533UDmtuGiiE7gySDcU2Pj61ooLEWZXOAcpQzUhIizbUByzYacVx
 5A5TGNf278A2LGGxGEaRn6lXrgky31y1dWa/2DfRxQ==
X-Google-Smtp-Source: ABdhPJzTnu1fSF4coB1PZmxCogVyuixNOiCyrmWJ/0He7B8/vcyug5rYgWjTTr7qv6jS4vbmZJGgxBr5WjrLjPav9gE=
X-Received: by 2002:a05:6830:22c3:: with SMTP id
 q3mr519753otc.56.1617152564358; 
 Tue, 30 Mar 2021 18:02:44 -0700 (PDT)
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
 <CAP_N_Z8Z1hzWSoU3ezUDz0+_EkGjgRJVgsuDGvOcEe7MkTsHTQ@mail.gmail.com>
In-Reply-To: <CAP_N_Z8Z1hzWSoU3ezUDz0+_EkGjgRJVgsuDGvOcEe7MkTsHTQ@mail.gmail.com>
From: "Jiang Wang ." <jiang.wang@bytedance.com>
Date: Tue, 30 Mar 2021 18:02:33 -0700
Message-ID: <CAP_N_Z956yVDq1P38skH7EXNB-uD_P2tCV=sMYFkUqm2ru4ojw@mail.gmail.com>
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

Hi Stefano,

I checked dgram code again. I think assigning transport for each packet
is doable. The dgram will be similar to stream to have two transports.

If there is no other problem, I can submit a Linux kernel patch to support
nested dgram on VMCI first. Then it will be easier for virtio vsock.

Also, I don't think we need to put anything related to this multiple-
transport support in the spec.  Let me know if otherwise.

Regards,

Jiang

On Tue, Mar 30, 2021 at 11:34 AM Jiang Wang . <jiang.wang@bytedance.com> wrote:
>
> On Tue, Mar 30, 2021 at 8:32 AM Stefano Garzarella <sgarzare@redhat.com> wrote:
> >
> > Hi Jiang,
> >
> > On Fri, Mar 26, 2021 at 04:40:09PM -0700, Jiang Wang . wrote:
> > >Hi Michael and Stefan,
> > >
> > >I thought about this and discussed it with my colleague Cong Wang.
> > >One idea is to make current asynchronous send_pkt flow to be synchronous,
> > >then if the virtqueue is full, the function can return  ENOMEM all the way back
> > >to the caller and the caller can check the return value of sendmsg
> > >and slow down when necessary.
> > >
> > >In the spec, we can put something like, if the virtqueue is full, the caller
> > >should be notified with an error etc.
> > >
> > >In terms of implementation, that means we will remove the current
> > >send_pkt_work for both stream and dgram sockets. Currently, the
> > >code path uses RCU and a work queue, then grab a mutex in the
> > >work queue function. Since we cannot grab mutex when in rcu
> > >critical section, we have to change RCU to a normal reference
> > >counting mechanism. I think this is doable. The drawback is
> > >that the reference counting in general spends a little more
> > >cycles than the RCU, so there is a small price to pay. Another
> > >option is to use Sleepable RCU and remove the work queue.
> > >
> > >What do you guys think?
> >
> > another thing that came to mind not related to the spec but to the Linux
> > implementation, is the multi-transport support.
> > When we discussed the initial proposals [1][2], we decided to take a
> > shortcut for DGRAM, since the only transport with DGRAM support was
> > vmci. So for now only a single transport with VSOCK_TRANSPORT_F_DGRAM
> > set can be registered.
> >
> > Since also virtio-transport and vhost-transport will support DGRAM, we
> > need to find a way to allow multiple transports that support DGRAM to be
> > registered together to support nested VMs.
> >
> > Do you have already thought about how to solve this problem?
> >
> > We should definitely allow the registration of more transports with
> > VSOCK_TRANSPORT_F_DGRAM, and dynamically choose which one to use when
> > sending a packet.
>
> Got it. We briefly discussed multiple dgram transport
> support in my old email thread. At that time, I was thinking
> maybe check for transport for each packet. I did not spend more
> time on that part after that. I will think about it more and get
> back to you. Thanks
>
> > Thanks,
> > Stefano
> >
> > [1] https://www.spinics.net/lists/netdev/msg570274.html
> > [2] https://www.spinics.net/lists/netdev/msg575792.html
> >
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
