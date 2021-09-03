Return-Path: <SRS0=H6i0=NZ=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA88FC433EF
	for <virtualization@archiver.kernel.org>; Fri,  3 Sep 2021 07:22:37 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5EAEA61057
	for <virtualization@archiver.kernel.org>; Fri,  3 Sep 2021 07:22:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 5EAEA61057
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 1EAAF425E5;
	Fri,  3 Sep 2021 07:22:37 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Zwn4r_5MGW1c; Fri,  3 Sep 2021 07:22:36 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 91075425E1;
	Fri,  3 Sep 2021 07:22:35 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 68169C001A;
	Fri,  3 Sep 2021 07:22:35 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E3FCEC000E
 for <virtualization@lists.linux-foundation.org>;
 Fri,  3 Sep 2021 07:22:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id BBC37835D9
 for <virtualization@lists.linux-foundation.org>;
 Fri,  3 Sep 2021 07:22:33 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id mttgweqNTgcg
 for <virtualization@lists.linux-foundation.org>;
 Fri,  3 Sep 2021 07:22:33 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id E228C8354B
 for <virtualization@lists.linux-foundation.org>;
 Fri,  3 Sep 2021 07:22:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1630653751;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=X01Gg0eXt4oivg9yrhUAx6lVM0D/lP62SiSbqPDKEUM=;
 b=RLDfw6LqsRAGS9WDDDbs1XLFhRPWswMgmXFKuDeO0kWcBIlXwXWBGb33JFlkZKTAUN0vB8
 Ph5NLtseA9k91Xr9uRD/J3rGlTNpxP7AeUqlOAsaK7jhPRTjmXgwKieaUwcSm+zXO1pjHv
 d/tFEnAfueEiAYww8I4z21W73EQ5GZw=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-491-4XBY29qWPhqX_sgVLoQsZQ-1; Fri, 03 Sep 2021 03:22:28 -0400
X-MC-Unique: 4XBY29qWPhqX_sgVLoQsZQ-1
Received: by mail-ej1-f70.google.com with SMTP id
 q15-20020a17090622cf00b005c42d287e6aso2277214eja.18
 for <virtualization@lists.linux-foundation.org>;
 Fri, 03 Sep 2021 00:22:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=X01Gg0eXt4oivg9yrhUAx6lVM0D/lP62SiSbqPDKEUM=;
 b=YWgRvCKLXLtgz8HzVOSturGzlzOZ4gncDIOXh+OO/sJcXN0zHgwVgcn2ixzKgGTizE
 C3ZAZwNLEwBPOQrLPs5FEp/tT/jRuwWpLLkAcUZ1hSrneSoeay11CoH9SkoIBUaUdFh5
 SnPTmxsOroqzNSzj2XNoVgzVZi8tKjBXzxi0GedniQw7i2H89ARRcCtHWJCZkVPIso2o
 9ONjcAnPdh2cBaXI60YVUQRgP/cI/dk2oNxV2p9HaiyiNFoxWCr0gKRIe2mGx3edt+nZ
 N1Hr0DAJzOKxVCd5OZjXsu4j5XymCI3lI7+pX7SrGM2abF29nl/xzfIIauLqtDPUV+sJ
 fUyw==
X-Gm-Message-State: AOAM531K7FoIChzuOpoU3ugQ5qFlHGei2zbueua4aDN0XQcLAI7jjqvp
 dPyGAniASjVETQw8MoW3DSf2O6UXPVcop79QJ6Ot0IHaLJOiMo+Ma4J0/65uYsoE7X7iyfNHRMU
 oaDr+jG7OmF4pEKqSVrUUnk0eeEw2lx7KzKzA3SqC6Q==
X-Received: by 2002:a17:906:9b1:: with SMTP id
 q17mr2589470eje.546.1630653747348; 
 Fri, 03 Sep 2021 00:22:27 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxe7yLv7oURL248lSZ1gdZGAlaYThuX1RX1je6Tz0HHPsGt3t5rNow0rF2RChp+82Dk9vuZ/w==
X-Received: by 2002:a17:906:9b1:: with SMTP id
 q17mr2589448eje.546.1630653747108; 
 Fri, 03 Sep 2021 00:22:27 -0700 (PDT)
Received: from steredhat (host-79-51-2-59.retail.telecomitalia.it.
 [79.51.2.59])
 by smtp.gmail.com with ESMTPSA id p18sm2442442edu.86.2021.09.03.00.22.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 03 Sep 2021 00:22:26 -0700 (PDT)
Date: Fri, 3 Sep 2021 09:22:24 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: "Jiang Wang ." <jiang.wang@bytedance.com>
Subject: Re: [virtio-comment] Re: [PATCH v5] virtio-vsock: add description
 for datagram type
Message-ID: <20210903072224.vf2tkvvxfyh7dzuy@steredhat>
References: <20210610181203.979686-1-jiang.wang@bytedance.com>
 <YTDam7jdjRz686bp@stefanha-x1.localdomain>
 <CAP_N_Z_hHFbmd4tVMNYMrGiUt43Rs0N9rwM6F3Q_Wu1MTyfeKA@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAP_N_Z_hHFbmd4tVMNYMrGiUt43Rs0N9rwM6F3Q_Wu1MTyfeKA@mail.gmail.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=sgarzare@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Cong Wang <cong.wang@bytedance.com>,
 Xiongchun Duan <duanxiongchun@bytedance.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, cohuck@redhat.com,
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

On Thu, Sep 02, 2021 at 05:08:01PM -0700, Jiang Wang . wrote:
>On Thu, Sep 2, 2021 at 7:07 AM Stefan Hajnoczi <stefanha@redhat.com> wrote:
>>
>> On Thu, Jun 10, 2021 at 06:12:03PM +0000, Jiang Wang wrote:
>> > Add supports for datagram type for virtio-vsock. Datagram
>> > sockets are connectionless and unreliable. To avoid contention
>> > with stream and other sockets, add two more virtqueues and
>> > a new feature bit to identify if those two new queues exist or not.
>> >
>> > Also add descriptions for resource management of datagram, which
>> > does not use the existing credit update mechanism associated with
>> > stream sockets.
>> >
>> > Signed-off-by: Jiang Wang <jiang.wang@bytedance.com>
>> > ---
>>
>> Overall this looks good. The tricky thing will be implementing dgram
>> sockets in a way that minimizes dropped packets and provides some degree
>> of fairness between senders. Those are implementation issues though and
>> not visible at the device specification level.
>>
>> > diff --git a/virtio-vsock.tex b/virtio-vsock.tex
>> > index da7e641..26a62ac 100644
>> > --- a/virtio-vsock.tex
>> > +++ b/virtio-vsock.tex
>> > @@ -9,14 +9,37 @@ \subsection{Device ID}\label{sec:Device Types / Socket Device / Device ID}
>> >
>> >  \subsection{Virtqueues}\label{sec:Device Types / Socket Device / Virtqueues}
>> >  \begin{description}
>> > -\item[0] rx
>> > -\item[1] tx
>> > +\item[0] stream rx
>> > +\item[1] stream tx
>> > +\item[2] datagram rx
>> > +\item[3] datagram tx
>> > +\item[4] event
>> > +\end{description}
>> > +The virtio socket device uses 5 queues if feature bit VIRTIO_VSOCK_F_DRGAM is set. Otherwise, it
>> > +only uses 3 queues, as the following.
>>
>> s/as the following/as follows:/
>>
>Will do.
>
>> > +
>> > +\begin{description}
>> > +\item[0] stream rx
>> > +\item[1] stream tx
>> >  \item[2] event
>> >  \end{description}
>> >
>> > +When behavior differs between stream and datagram rx/tx virtqueues
>> > +their full names are used. Common behavior is simply described in
>> > +terms of rx/tx virtqueues and applies to both stream and datagram
>> > +virtqueues.
>> > +
>> >  \subsection{Feature bits}\label{sec:Device Types / Socket Device / Feature bits}
>> >
>> > -There are currently no feature bits defined for this device.
>> > +\begin{description}
>> > +\item[VIRTIO_VSOCK_F_STREAM (0)] Device has support for stream socket type.
>> > +\end{description}
>> > +
>> > +\begin{description}
>> > +\item[VIRTIO_VSOCK_F_DGRAM (2)] Device has support for datagram socket type.
>>
>> Is this really bit 2 or did you mean bit 1 (value 0x2)?
>>
>I left bit 1 for SEQPACKET feature bit.  That will probably merge
>before this patch.

Yep, SEQPACKET implementation is also merged in the linux kernel using 
the feature bit 1 (0x2), bit 0 (0x1) was left free for stream.

>
>> What happens to the virtqueue layout when VIRTIO_VSOCK_F_DGRAM is
>> present and VIRTIO_VSOCK_F_STREAM is absent? The virtqueue section above
>> implies that VIRTIO_VSOCK_F_STREAM is always present.
>>
>yeah, good question. I  think then it means the first two queues will be used
>for dgram?
>
>> > +\end{description}
>> > +
>> > +If no feature bits are defined, assume device only supports stream socket type.
>>
>> It's cleaner to define VIRTIO_VSOCK_F_NO_STREAM (0) instead. When the
>> bit is set the stream socket type is not available and the stream_rx/tx
>> virtqueues are absent.
>>
>> This way it's not necessary to define special behavior depending on
>> certain combinations of feature bits.
>>
>Agree. I went back and read old emails again and found I missed the
>negative bit part. So repeating the previous question, if
>VIRTIO_VSOCK_F_NO_STREAM  and VIRTIO_VSOCK_F_DGRAM
>present, then we will only have 3 queues and the first two are for dgram, right?
>
>Also, I am wondering what if an implementation only sets
>VIRTIO_VSOCK_F_NO_STREAM bit, but somehow forgot (or for whatever
>reason) to set VIRTIO_VSOCK_F_DGRAM bit? Does that mean there will
>be no virtqueues? The implementation is a mistake? Because it will not
>do anything.
>Do we need to explicitly add a sentence in the spec to say something like
>"Don't set VIRTIO_VSOCK_F_NO_STREAM alone" etc?

Good point.

IIRC we thought to add F_STREAM to allow devices for example that 
support only DGRAM, but we said to consider stream supported if no 
feature was set for backward compatibility.

With F_NO_STREAM we can do the same, but actually we could have this 
strange case. I don't think it's a big problem, in the end it's a 
configuration error. Maybe F_NO_STREMA is clearer since the original 
device spec supports streams without any feature bit defined.

Stefano

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
