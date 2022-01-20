Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81484C433FE
	for <virtualization@archiver.kernel.org>; Thu, 20 Jan 2022 16:56:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 1E18760AD3;
	Thu, 20 Jan 2022 16:56:12 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 5jPyLJx_gV24; Thu, 20 Jan 2022 16:56:11 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 8E0EF60A8F;
	Thu, 20 Jan 2022 16:56:10 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 4C83BC0039;
	Thu, 20 Jan 2022 16:56:10 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 8142CC002F
 for <virtualization@lists.linux-foundation.org>;
 Thu, 20 Jan 2022 16:56:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 7C400415D3
 for <virtualization@lists.linux-foundation.org>;
 Thu, 20 Jan 2022 16:56:09 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 4Lu6WQrSspfM
 for <virtualization@lists.linux-foundation.org>;
 Thu, 20 Jan 2022 16:56:08 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 9EB7341528
 for <virtualization@lists.linux-foundation.org>;
 Thu, 20 Jan 2022 16:56:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1642697767;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=8mR9FRdz8I70HhOfwdXd7Kde0lgoBA3u1XOQMHhojHo=;
 b=UshQ8b68zAw9ofgGpCHj078SpJH/EQZ/JeQQ6R/58GSE0bT4wsHnZDHgfsYpuS5woOpvp8
 SG9rWJ4/XDeRLSy8x7Wtr0+LczLPotfBOsdUNe9n9XVHW3NaRtgqwfw1ZQkXLK6hXadxVt
 jSTE3k5MYciNct5vj0I1zIfNlY0RKng=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-665-uIMakynJOtyOIVdimNa3Lw-1; Thu, 20 Jan 2022 11:56:06 -0500
X-MC-Unique: uIMakynJOtyOIVdimNa3Lw-1
Received: by mail-wm1-f72.google.com with SMTP id
 v185-20020a1cacc2000000b0034906580813so7287109wme.1
 for <virtualization@lists.linux-foundation.org>;
 Thu, 20 Jan 2022 08:56:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=8mR9FRdz8I70HhOfwdXd7Kde0lgoBA3u1XOQMHhojHo=;
 b=dL61IEp4lF0tHVfCL4ybrTjQndp4vmScJ7J6DnxQuyl9xxJ7mYzUTLcn8A047oN18s
 S3fTsdkGsCFXpR25nc6SPkcF3CtmYxRugTEeFJ261wQk0FEZ3y0/QOfIDTXvWxpI1hFG
 jYo9zpVQpXQrVldfI5K5ad+z2+5KlrOc6Q9WXrQSQA88CTQAYsdPYQskNDLpC76qoaH0
 YRohWDwhKklE4q14Uuzrszo8VCp0jUsk8PSIgZPJWbM0Dcrk1CPQ7dgGV66e6ZGtmKOY
 CauLVUHnmmHbwOZiPpuZdIl3tNkS01opTmscIlWy7dg96t/IcZyxP18PJffkZAr7Zx7t
 26UQ==
X-Gm-Message-State: AOAM531TOGGgmqP1d0IYm/UoGhu61GR0P17WgNwBMj/tw0ELm1dOCelx
 V+KQst7+M5d/wdl5mMEQaLa/4/xtwyYYm3f9HnTJMW7L3pX1piu+HPIHRTZiBUAkZkPwY2hO9o7
 AeqRxO9OPbS/ya1FzPg11DcU1n9nB0REm5Ii9U0Ch2w==
X-Received: by 2002:a05:600c:4fd4:: with SMTP id
 o20mr9720476wmq.155.1642697764855; 
 Thu, 20 Jan 2022 08:56:04 -0800 (PST)
X-Google-Smtp-Source: ABdhPJz602JhtDTuZNmSMn/pluyt75fBTOcXq6oo9TvSS1+J7M5aQjpPqI7Y4TSrYEBGLNgdGX93aA==
X-Received: by 2002:a05:600c:4fd4:: with SMTP id
 o20mr9720458wmq.155.1642697764623; 
 Thu, 20 Jan 2022 08:56:04 -0800 (PST)
Received: from redhat.com ([2.55.158.216])
 by smtp.gmail.com with ESMTPSA id l13sm4525133wry.87.2022.01.20.08.56.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Jan 2022 08:56:03 -0800 (PST)
Date: Thu, 20 Jan 2022 11:55:53 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Stefano Garzarella <sgarzare@redhat.com>
Subject: Re: [PATCH v1] vhost: cache avail index in vhost_enable_notify()
Message-ID: <20220120115520-mutt-send-email-mst@kernel.org>
References: <20220114090508.36416-1-sgarzare@redhat.com>
 <20220114074454-mutt-send-email-mst@kernel.org>
 <20220114133816.7niyaqygvdveddmi@steredhat>
 <20220114084016-mutt-send-email-mst@kernel.org>
 <CAGxU2F7r6cH9Ywygv1QNxKyfyn=yGoDPNDQ-tHkeFMUcbpfXYA@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAGxU2F7r6cH9Ywygv1QNxKyfyn=yGoDPNDQ-tHkeFMUcbpfXYA@mail.gmail.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: kvm <kvm@vger.kernel.org>, netdev <netdev@vger.kernel.org>,
 kernel list <linux-kernel@vger.kernel.org>,
 Linux Virtualization <virtualization@lists.linux-foundation.org>,
 Stefan Hajnoczi <stefanha@redhat.com>
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

On Thu, Jan 20, 2022 at 04:08:39PM +0100, Stefano Garzarella wrote:
> On Fri, Jan 14, 2022 at 2:40 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> >
> > On Fri, Jan 14, 2022 at 02:38:16PM +0100, Stefano Garzarella wrote:
> > > On Fri, Jan 14, 2022 at 07:45:35AM -0500, Michael S. Tsirkin wrote:
> > > > On Fri, Jan 14, 2022 at 10:05:08AM +0100, Stefano Garzarella wrote:
> > > > > In vhost_enable_notify() we enable the notifications and we read
> > > > > the avail index to check if new buffers have become available in
> > > > > the meantime.
> > > > >
> > > > > We are not caching the avail index, so when the device will call
> > > > > vhost_get_vq_desc(), it will find the old value in the cache and
> > > > > it will read the avail index again.
> > > > >
> > > > > It would be better to refresh the cache every time we read avail
> > > > > index, so let's change vhost_enable_notify() caching the value in
> > > > > `avail_idx` and compare it with `last_avail_idx` to check if there
> > > > > are new buffers available.
> > > > >
> > > > > Anyway, we don't expect a significant performance boost because
> > > > > the above path is not very common, indeed vhost_enable_notify()
> > > > > is often called with unlikely(), expecting that avail index has
> > > > > not been updated.
> > > > >
> > > > > Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
> > > >
> > > > ... and can in theory even hurt due to an extra memory write.
> > > > So ... performance test restults pls?
> > >
> > > Right, could be.
> > >
> > > I'll run some perf test with vsock, about net, do you have a test suite or
> > > common step to follow to test it?
> > >
> > > Thanks,
> > > Stefano
> >
> > You can use the vhost test as a unit test as well.
> 
> Thanks for the advice, I did indeed use it!
> 
> I run virtio_test (with vhost_test.ko) using 64 as batch to increase the 
> chance of the path being taken. (I changed bufs=0x1000000 in 
> virtio_test.c to increase the duration).
> 
> I used `perf stat` to take some numbers, running this command:
> 
>    taskset -c 2 perf stat -r 10 --log-fd 1 -- ./virtio_test --batch=64
> 
> - Linux v5.16 without the patch applied
> 
>  Performance counter stats for './virtio_test --batch=64' (10 runs):
> 
>           2,791.70 msec task-clock                #    0.996 CPUs utilized            ( +-  0.36% )
>                 23      context-switches          #    8.209 /sec                     ( +-  2.75% )
>                  0      cpu-migrations            #    0.000 /sec
>                 79      page-faults               #   28.195 /sec                     ( +-  0.41% )
>      7,249,926,989      cycles                    #    2.587 GHz                      ( +-  0.36% )
>      7,711,999,656      instructions              #    1.06  insn per cycle           ( +-  1.08% )
>      1,838,436,806      branches                  #  656.134 M/sec                    ( +-  1.44% )
>          3,055,439      branch-misses             #    0.17% of all branches          ( +-  6.22% )
> 
>             2.8024 +- 0.0100 seconds time elapsed  ( +-  0.36% )
> 
> - Linux v5.16 with this patch applied
> 
>  Performance counter stats for './virtio_test --batch=64' (10 runs):
> 
>           2,753.36 msec task-clock                #    0.998 CPUs utilized            ( +-  0.20% )
>                 24      context-switches          #    8.699 /sec                     ( +-  2.86% )
>                  0      cpu-migrations            #    0.000 /sec
>                 76      page-faults               #   27.545 /sec                     ( +-  0.56% )
>      7,150,358,721      cycles                    #    2.592 GHz                      ( +-  0.20% )
>      7,420,639,950      instructions              #    1.04  insn per cycle           ( +-  0.76% )
>      1,745,759,193      branches                  #  632.730 M/sec                    ( +-  1.03% )
>          3,022,508      branch-misses             #    0.17% of all branches          ( +-  3.24% )
> 
>            2.75952 +- 0.00561 seconds time elapsed  ( +-  0.20% )
> 
> 
> The difference seems minimal with a slight improvement.
> 
> To try to stress the patch more, I modified vhost_test.ko to call 
> vhost_enable_notify()/vhost_disable_notify() on every cycle when calling 
> vhost_get_vq_desc():
> 
> - Linux v5.16 modified without the patch applied
> 
>  Performance counter stats for './virtio_test --batch=64' (10 runs):
> 
>           4,126.66 msec task-clock                #    1.006 CPUs utilized            ( +-  0.25% )
>                 28      context-switches          #    6.826 /sec                     ( +-  3.41% )
>                  0      cpu-migrations            #    0.000 /sec
>                 85      page-faults               #   20.721 /sec                     ( +-  0.44% )
>     10,716,808,883      cycles                    #    2.612 GHz                      ( +-  0.25% )
>     11,804,381,462      instructions              #    1.11  insn per cycle           ( +-  0.86% )
>      3,138,813,438      branches                  #  765.153 M/sec                    ( +-  1.03% )
>         11,286,860      branch-misses             #    0.35% of all branches          ( +-  1.23% )
> 
>             4.1027 +- 0.0103 seconds time elapsed  ( +-  0.25% )
> 
> - Linux v5.16 modified with this patch applied
> 
>  Performance counter stats for './virtio_test --batch=64' (10 runs):
> 
>           3,953.55 msec task-clock                #    1.001 CPUs utilized            ( +-  0.33% )
>                 29      context-switches          #    7.345 /sec                     ( +-  2.67% )
>                  0      cpu-migrations            #    0.000 /sec
>                 83      page-faults               #   21.021 /sec                     ( +-  0.65% )
>     10,267,242,653      cycles                    #    2.600 GHz                      ( +-  0.33% )
>      7,972,866,579      instructions              #    0.78  insn per cycle           ( +-  0.21% )
>      1,663,770,390      branches                  #  421.377 M/sec                    ( +-  0.45% )
>         16,986,093      branch-misses             #    1.02% of all branches          ( +-  0.47% )
> 
>             3.9489 +- 0.0130 seconds time elapsed  ( +-  0.33% )
> 
> In this case the difference is bigger, with a reduction in execution 
> time (3.7 %) and fewer branches and instructions. It should be the 
> branch `if (vq->avail_idx == vq->last_avail_idx)` in vhost_get_vq_desc() 
> that is not taken.
> 
> Should I resend the patch adding some more performance information?
> 
> Thanks,
> Stefano

Yea, pls do. You can just summarize it in a couple of lines.

-- 
MST

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
