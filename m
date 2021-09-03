Return-Path: <SRS0=H6i0=NZ=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24D29C433FE
	for <virtualization@archiver.kernel.org>; Fri,  3 Sep 2021 10:51:51 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C3AAD60698
	for <virtualization@archiver.kernel.org>; Fri,  3 Sep 2021 10:51:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org C3AAD60698
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 85989400F0;
	Fri,  3 Sep 2021 10:51:50 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id IyMcfj_BMz2R; Fri,  3 Sep 2021 10:51:48 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 7AABB400E7;
	Fri,  3 Sep 2021 10:51:47 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 5E43FC0010;
	Fri,  3 Sep 2021 10:51:47 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id AEFA2C000E
 for <virtualization@lists.linux-foundation.org>;
 Fri,  3 Sep 2021 10:51:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 9B5E4400F0
 for <virtualization@lists.linux-foundation.org>;
 Fri,  3 Sep 2021 10:51:46 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id udypEhTBBQb0
 for <virtualization@lists.linux-foundation.org>;
 Fri,  3 Sep 2021 10:51:44 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 83A6B400E7
 for <virtualization@lists.linux-foundation.org>;
 Fri,  3 Sep 2021 10:51:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1630666303;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=h+1UOnvw3NSqng6A5H/Jgh4cLQIcATTLJmUT7GXhTyU=;
 b=LQijQu/aDDdxcfAa66jmyxbpAFmimlmu/1SmkzYyL//PBioOBITAX1eg65GBkAjYi6pPUi
 HY54iCDKIdGBDb6NrQQGwqaI42KlyduZAciGHtFzYUtlWEqFbsW/83Nx7Cf0XYRHtjiATJ
 +b8C0uZowuWQmQjzmi6q3STClIEbWBk=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-446-TH7JiqyrOA2JqQ8eQUW73A-1; Fri, 03 Sep 2021 06:51:40 -0400
X-MC-Unique: TH7JiqyrOA2JqQ8eQUW73A-1
Received: by mail-ej1-f72.google.com with SMTP id
 o14-20020a1709062e8e00b005d37183e041so2498408eji.21
 for <virtualization@lists.linux-foundation.org>;
 Fri, 03 Sep 2021 03:51:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=h+1UOnvw3NSqng6A5H/Jgh4cLQIcATTLJmUT7GXhTyU=;
 b=GS8RksN76Ak0v9dEvKid8fzxqttu9QeiDYrh9PUF0mZ7HqnJUvF8cKy2WQ1DF4xI3a
 Srhevqn0c85NAOpfxCXaK+XNwRC5EGi2jaXcPl0rmvzny2rmi8EfTUfP8jGaDOXmpcId
 9fWDWcc0k6LA36tIoEQOVODu/D+1oQGLBZJ7N08ZRjRnM8weVZZD6ymRSHL57v5jEOO8
 GpBgfEo8X0h+0nvjMB1OUqIO6xRl3jH13sKS2sqVeUXQEGzVFzMpvacS2kIyoadcRsBT
 gWCfEWxhVOl9dE/OgPhU0ZfozgmlTOBwglD1+xnJRk950zI5lYtRuQvfQyTjz0IVIUp2
 u9tw==
X-Gm-Message-State: AOAM530XBUVyNNpGZEUOcm1KR6UoQg9kgJCZueyJJW9fwFQ8wnGA0UNh
 bALpUT5PuWG5L95bjbfrYsYXagYm+J6c/eva6oepbJyj652fMj8bGkJwPyAWl5YnU1iHZitzFnN
 ixTPDEiC0/gLuJatyM6voFwv0NGqRtD5V4sJuaDvS8A==
X-Received: by 2002:a17:907:1de1:: with SMTP id
 og33mr3544451ejc.278.1630666298902; 
 Fri, 03 Sep 2021 03:51:38 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyqdBg5JaheEJbc30tZlrsJoleYu2HaKiPdoof0zydHUsK+bclrEbRsBrPGwE8OSPwh86h8CQ==
X-Received: by 2002:a17:907:1de1:: with SMTP id
 og33mr3544432ejc.278.1630666298665; 
 Fri, 03 Sep 2021 03:51:38 -0700 (PDT)
Received: from steredhat (host-79-51-2-59.retail.telecomitalia.it.
 [79.51.2.59])
 by smtp.gmail.com with ESMTPSA id e21sm2591694ejj.4.2021.09.03.03.51.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 03 Sep 2021 03:51:38 -0700 (PDT)
Date: Fri, 3 Sep 2021 12:51:35 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [virtio-comment] Re: [PATCH v5] virtio-vsock: add description
 for datagram type
Message-ID: <20210903105135.hyjlzqecve4ll4zx@steredhat>
References: <20210610181203.979686-1-jiang.wang@bytedance.com>
 <YTDam7jdjRz686bp@stefanha-x1.localdomain>
 <CAP_N_Z_hHFbmd4tVMNYMrGiUt43Rs0N9rwM6F3Q_Wu1MTyfeKA@mail.gmail.com>
 <20210903072224.vf2tkvvxfyh7dzuy@steredhat>
 <20210903035033-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
In-Reply-To: <20210903035033-mutt-send-email-mst@kernel.org>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=sgarzare@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Cong Wang <cong.wang@bytedance.com>,
 Xiongchun Duan <duanxiongchun@bytedance.com>,
 "Jiang Wang ." <jiang.wang@bytedance.com>, cohuck@redhat.com,
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

On Fri, Sep 03, 2021 at 03:57:24AM -0400, Michael S. Tsirkin wrote:
>On Fri, Sep 03, 2021 at 09:22:24AM +0200, Stefano Garzarella wrote:
>> On Thu, Sep 02, 2021 at 05:08:01PM -0700, Jiang Wang . wrote:
>> > On Thu, Sep 2, 2021 at 7:07 AM Stefan Hajnoczi <stefanha@redhat.com> wrote:
>> > > On Thu, Jun 10, 2021 at 06:12:03PM +0000, Jiang Wang wrote:

[...]

>> > > >
>> > > > -There are currently no feature bits defined for this device.
>> > > > +\begin{description}
>> > > > +\item[VIRTIO_VSOCK_F_STREAM (0)] Device has support for stream socket type.
>> > > > +\end{description}
>> > > > +
>> > > > +\begin{description}
>> > > > +\item[VIRTIO_VSOCK_F_DGRAM (2)] Device has support for datagram socket type.
>> > >
>> > > Is this really bit 2 or did you mean bit 1 (value 0x2)?
>> > >
>> > I left bit 1 for SEQPACKET feature bit.  That will probably merge
>> > before this patch.
>>
>> Yep, SEQPACKET implementation is also merged in the linux kernel using the
>> feature bit 1 (0x2), bit 0 (0x1) was left free for stream.
>>
>> >
>> > > What happens to the virtqueue layout when VIRTIO_VSOCK_F_DGRAM is
>> > > present and VIRTIO_VSOCK_F_STREAM is absent? The virtqueue section above
>> > > implies that VIRTIO_VSOCK_F_STREAM is always present.
>> > >
>> > yeah, good question. I  think then it means the first two queues will be used
>> > for dgram?
>> >
>> > > > +\end{description}
>> > > > +
>> > > > +If no feature bits are defined, assume device only supports stream socket type.
>> > >
>> > > It's cleaner to define VIRTIO_VSOCK_F_NO_STREAM (0) instead. When the
>> > > bit is set the stream socket type is not available and the stream_rx/tx
>> > > virtqueues are absent.
>> > >
>> > > This way it's not necessary to define special behavior depending on
>> > > certain combinations of feature bits.
>> > >
>> > Agree. I went back and read old emails again and found I missed the
>> > negative bit part. So repeating the previous question, if
>> > VIRTIO_VSOCK_F_NO_STREAM  and VIRTIO_VSOCK_F_DGRAM
>> > present, then we will only have 3 queues and the first two are for dgram, right?
>> >
>> > Also, I am wondering what if an implementation only sets
>> > VIRTIO_VSOCK_F_NO_STREAM bit, but somehow forgot (or for whatever
>> > reason) to set VIRTIO_VSOCK_F_DGRAM bit? Does that mean there will
>> > be no virtqueues? The implementation is a mistake? Because it will not
>> > do anything.
>> > Do we need to explicitly add a sentence in the spec to say something like
>> > "Don't set VIRTIO_VSOCK_F_NO_STREAM alone" etc?
>>
>> Good point.
>>
>> IIRC we thought to add F_STREAM to allow devices for example that support
>> only DGRAM, but we said to consider stream supported if no feature was set
>> for backward compatibility.
>> With F_NO_STREAM we can do the same, but actually we could have this strange
>> case. I don't think it's a big problem, in the end it's a configuration
>> error. Maybe F_NO_STREMA is clearer since the original device spec supports
>> streams without any feature bit defined.
>>
>> Stefano
>
>How about that instead of VIRTIO_VSOCK_F_NO_STREAM we do
>
>VIRTIO_VSOCK_F_TYPE /* device supports multiple socket types */
>
>then with VIRTIO_VSOCK_F_TYPE clear we only have stream.
>

For SEQPACKET it should be okay, since it depends on stream queues, but 
DGRAM will have its own queues, so with F_TYPE it seems to me more 
difficult to handle the case in which a device supports DGRAM but not 
STREAM.

>We should also make SEQPACKET depend on this VIRTIO_VSOCK_F_TYPE -
>linux guests do not validate that right now but
>it's probably not too late to add such a patch to linux
>as a bugfix.

Yep, also with F_NO_STREAM we should do a validation, since F_SEQPACKET 
depends on !F_NO_STREAM.

I'll take care of this when we decide what flag to use.

Stefano

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
