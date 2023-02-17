Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 663C5C636D6
	for <virtualization@archiver.kernel.org>; Fri, 17 Feb 2023 05:23:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id DB46E404C9;
	Fri, 17 Feb 2023 05:23:34 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org DB46E404C9
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Y6yGSppn
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 0rxrcEG1KbU9; Fri, 17 Feb 2023 05:23:34 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 549A4400A4;
	Fri, 17 Feb 2023 05:23:33 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 549A4400A4
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 29E12C0033;
	Fri, 17 Feb 2023 05:23:33 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C193FC002B
 for <virtualization@lists.linux-foundation.org>;
 Fri, 17 Feb 2023 05:23:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 88AD5402BD
 for <virtualization@lists.linux-foundation.org>;
 Fri, 17 Feb 2023 05:23:31 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 88AD5402BD
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=Y6yGSppn
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id xIh1uiJfLNeI
 for <virtualization@lists.linux-foundation.org>;
 Fri, 17 Feb 2023 05:23:30 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 096E8401FF
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 096E8401FF
 for <virtualization@lists.linux-foundation.org>;
 Fri, 17 Feb 2023 05:23:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1676611408;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=SEhUHalQiI4aJxPso4UP1aHihgoarZd8OfJxRGmCl2g=;
 b=Y6yGSppng1ihn3yfe+gt7Wy0zD2fVEhMzp9oeaAsaqnBD5kccTbIBTnzE4tljwC5mnTuBb
 ALO+OQlIxXC5YaKMxIl5W8ERjGlWWdJOSMN0RPF6z59aswXmSGIWURE6MpYONoEDGmovbL
 mMpipn1U7qB3Z2ea58SPfpxq76MgrtM=
Received: from mail-oo1-f71.google.com (mail-oo1-f71.google.com
 [209.85.161.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-190-bDM0r8bDNmaZp5XdWrReWA-1; Fri, 17 Feb 2023 00:23:26 -0500
X-MC-Unique: bDM0r8bDNmaZp5XdWrReWA-1
Received: by mail-oo1-f71.google.com with SMTP id
 bc13-20020a056820168d00b0051f97e7b7f9so32689oob.13
 for <virtualization@lists.linux-foundation.org>;
 Thu, 16 Feb 2023 21:23:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=SEhUHalQiI4aJxPso4UP1aHihgoarZd8OfJxRGmCl2g=;
 b=kNhLMH3080Mi5oy7AE8XqHhsS/W1NaQZfuGALjFXwcsh21c97Cah48U+REj0X3xeZb
 wu+MxUAWO17Wf/wBP8rVcrtsagiG5KoFBt9YV/6pD0nBicP9vlV4qymujZyU1rpjbtMM
 eP5KZBeI/K2MUduEvkmXhnFwz4L+YXn8HKA1Gx3NpBg9jujnOoz/zFwxzz9JnH8fOnCd
 EQB7nCC1D40gzvtRqfLbpEI7LzG6JaMdAdOMb6aE0Tk6jMUmYF9PF2vwK3UW+lsSVNiI
 77kdepfLed4TeRrqTPe6yaRVoNN93Dny8wU0HxNIcIbQ4CjLB6DkjijtxXb18y1woeN/
 FWQw==
X-Gm-Message-State: AO0yUKXohtAFZBiL4REr9JH0zdYBscf8aglya40iit29rHNPOSnpBl6l
 m6pwwfvQ3khIG8jkfb8Xq9R/FT/U8VwWK5tNE/lh/3VDVolorvBi76ARBMnRlZw59GxScGtjCLh
 4NSgsYK7uG7ph18uA+k1wCOKuoCE6rhYLp3nfzs8onTYjSDb0JrgELadbQw==
X-Received: by 2002:a05:6808:3186:b0:37d:5d77:e444 with SMTP id
 cd6-20020a056808318600b0037d5d77e444mr294694oib.35.1676611406185; 
 Thu, 16 Feb 2023 21:23:26 -0800 (PST)
X-Google-Smtp-Source: AK7set8IPOjWEYRD3Pjb1Gw8WoQBhHw/tco7wdx+EJLW+upCYz3b+D8TKan4VZVttrqiUbnOmio+cTxWNyHOJccRYk0=
X-Received: by 2002:a05:6808:3186:b0:37d:5d77:e444 with SMTP id
 cd6-20020a056808318600b0037d5d77e444mr294690oib.35.1676611405874; Thu, 16 Feb
 2023 21:23:25 -0800 (PST)
MIME-Version: 1.0
References: <20230214072704.126660-1-xuanzhuo@linux.alibaba.com>
 <CACGkMEsMfBLByXpPrHXDcsDdQmJSQAp-HEanCAn1-d8kFtFYJQ@mail.gmail.com>
 <1676547964.6918266-1-xuanzhuo@linux.alibaba.com>
In-Reply-To: <1676547964.6918266-1-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Date: Fri, 17 Feb 2023 13:23:14 +0800
Message-ID: <CACGkMEtY+aJaPg=nJ5wf1tFkH97-AEmZcDsOnN976Cm5x=Q2rQ@mail.gmail.com>
Subject: Re: [PATCH vhost 00/10] virtio core prepares for AF_XDP
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 virtualization@lists.linux-foundation.org
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

On Thu, Feb 16, 2023 at 7:50 PM Xuan Zhuo <xuanzhuo@linux.alibaba.com> wrote:
>
> On Thu, 16 Feb 2023 13:27:00 +0800, Jason Wang <jasowang@redhat.com> wrote:
> > On Tue, Feb 14, 2023 at 3:27 PM Xuan Zhuo <xuanzhuo@linux.alibaba.com> wrote:
> > >
> > > XDP socket(AF_XDP) is an excellent bypass kernel network framework. The zero
> > > copy feature of xsk (XDP socket) needs to be supported by the driver. The
> > > performance of zero copy is very good.
> > >
> > > ENV: Qemu with vhost.
> > >
> > >                    vhost cpu | Guest APP CPU |Guest Softirq CPU | PPS
> > > -----------------------------|---------------|------------------|------------
> > > xmit by sockperf:     90%    |   100%        |                  |  318967
> > > xmit by xsk:          100%   |   30%         |   33%            | 1192064
> >
> > What's the setup of this test?
> >
> > CPU model/frequency, packet size, zerocopy enabled or not.
>
> Intel(R) Xeon(R) Platinum 8163 CPU @ 2.50GHz
>
> zerocopy: enabled
>
> size: 64
>
>
> >
> > (I remember I can get better performance with my old laptop through
> > pktgen (about 2Mpps))
>
> Let's compare sockperf just.
>
> The result of the test on Alibaba Cloud was 3.5M+PPS/60%cpu.

Just to make sure I understand here, the above said:

 xmit by sockperf:     90%    |   100%        |                  |  318967

It's 0.3 Mpps, what's the difference between those two?

Thanks

>
> Thanks.
>
>
> >
> > Thanks
> >
> > > recv by sockperf:     100%   |   68%         |   100%           |  692288
> > > recv by xsk:          100%   |   33%         |   43%            |  771670
> > >
> > > Before achieving the function of Virtio-Net, we also have to let virtio core
> > > support these features:
> > >
> > > 1. virtio core support premapped
> > > 2. virtio core support reset per-queue
> > > 3. introduce DMA APIs to virtio core
> > >
> > > Please review.
> > >
> > > Thanks.
> > >
> > > Xuan Zhuo (10):
> > >   virtio_ring: split: refactor virtqueue_add_split() for premapped
> > >   virtio_ring: packed: separate prepare code from
> > >     virtuque_add_indirect_packed()
> > >   virtio_ring: packed: refactor virtqueue_add_packed() for premapped
> > >   virtio_ring: split: introduce virtqueue_add_split_premapped()
> > >   virtio_ring: packed: introduce virtqueue_add_packed_premapped()
> > >   virtio_ring: introduce virtqueue_add_inbuf_premapped()
> > >   virtio_ring: add api virtio_dma_map() for advance dma
> > >   virtio_ring: introduce dma sync api for virtio
> > >   virtio_ring: correct the expression of the description of
> > >     virtqueue_resize()
> > >   virtio_ring: introduce virtqueue_reset()
> > >
> > >  drivers/virtio/virtio_ring.c | 792 ++++++++++++++++++++++++++++-------
> > >  include/linux/virtio.h       |  29 ++
> > >  2 files changed, 659 insertions(+), 162 deletions(-)
> > >
> > > --
> > > 2.32.0.3.g01195cf9f
> > >
> >
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
