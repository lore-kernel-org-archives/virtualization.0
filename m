Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1AE0C77B61
	for <virtualization@archiver.kernel.org>; Thu, 27 Apr 2023 08:24:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 0BD7341DED;
	Thu, 27 Apr 2023 08:24:04 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 0BD7341DED
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=N+faVCjZ
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id aGY7lyvYoHby; Thu, 27 Apr 2023 08:24:02 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 30D4D408B0;
	Thu, 27 Apr 2023 08:24:02 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 30D4D408B0
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 121D2C0037;
	Thu, 27 Apr 2023 08:24:02 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 5F389C002A
 for <virtualization@lists.linux-foundation.org>;
 Thu, 27 Apr 2023 08:24:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 3483083B93
 for <virtualization@lists.linux-foundation.org>;
 Thu, 27 Apr 2023 08:24:00 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 3483083B93
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=N+faVCjZ
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id kzRexwINoACb
 for <virtualization@lists.linux-foundation.org>;
 Thu, 27 Apr 2023 08:23:59 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 72FE1821A9
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 72FE1821A9
 for <virtualization@lists.linux-foundation.org>;
 Thu, 27 Apr 2023 08:23:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1682583838;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=W8usmC3JGK9PorB0wAqvMMI+OvA7gcjYhdZApmddriY=;
 b=N+faVCjZTFN00z42gAqKl3oYG9GRn6FRnRrF737cQBGA7P9wCKTnNjo55m4c7f0YyDrKlq
 +xcKGfU8CJ3qMYDjRDEKN2x+52t+SuEXbFdL4SAJ0q2tvisBcaHEaVYS6pc7ylMv5ZSDCN
 wprGYQhh+UoT7waG3J30G8nCkjjpxBo=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-632-iWUOI25YMvWTyqQmmnAppw-1; Thu, 27 Apr 2023 04:23:56 -0400
X-MC-Unique: iWUOI25YMvWTyqQmmnAppw-1
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-2ff4bc7a6a3so4884082f8f.3
 for <virtualization@lists.linux-foundation.org>;
 Thu, 27 Apr 2023 01:23:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1682583835; x=1685175835;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=W8usmC3JGK9PorB0wAqvMMI+OvA7gcjYhdZApmddriY=;
 b=LySsupq5mBJX0iaUKqU/5wT90xWDe6afrYp65mZQMBTEOojq3NRhVmGTwytHSuAqGd
 H+tnn+xZy0HRHUwWoZo2RXhNVoBlaoBVNjHS7ciRPy8bn5BXHNV4Km4CyamQsjR1H8dy
 MV2skPFZCOgnjOGUerBfLYQsSlikwMlM7y6JMWHoHBxWaDfwnIu6BQ287YpMrctbOobB
 Z6zI9Lci/7MuKDYTOfdTIB4DXBMsacrUP/0UuikHYFaXTJjcORm3m1bYZ8vjYOYh/q/4
 AogRRTlPpJxzSsK2Ky7ghHrqq7zgjmZ8ZFO6ztW70Gs+fymWBtHsaOjQNDynBe01HtB0
 0u0A==
X-Gm-Message-State: AC+VfDz34Mgk3Xqef3r7de4bheq8josGqMjnG0YrlFOb9sdz6hYtrDUn
 TEJ0kW1LevX1kVdtz1qEC3eX6db1c5YML+qG4RAtPJ0uxA1d6WQQGOjY3ZpgxWY+B06X3Phufz/
 EDKEmHZKXu5bDpNd/F+SsnHLNvcUwUbRF0evmAje3aA==
X-Received: by 2002:adf:db8e:0:b0:2fe:f2d1:dcab with SMTP id
 u14-20020adfdb8e000000b002fef2d1dcabmr580412wri.58.1682583835567; 
 Thu, 27 Apr 2023 01:23:55 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7rQyd/2UisYbyEnSs2VvV3WiCVMyj0AWWY8+sZq//VJGg92r0G4dwgdN0gnhvMCRphC2USAQ==
X-Received: by 2002:adf:db8e:0:b0:2fe:f2d1:dcab with SMTP id
 u14-20020adfdb8e000000b002fef2d1dcabmr580392wri.58.1682583835248; 
 Thu, 27 Apr 2023 01:23:55 -0700 (PDT)
Received: from redhat.com ([2.52.19.183]) by smtp.gmail.com with ESMTPSA id
 b4-20020a05600010c400b002e45f6ffe63sm17892253wrx.26.2023.04.27.01.23.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Apr 2023 01:23:54 -0700 (PDT)
Date: Thu, 27 Apr 2023 04:23:51 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH] virtio_net: suppress cpu stall when free_unused_bufs
Message-ID: <20230427042259-mutt-send-email-mst@kernel.org>
References: <20230427043433.2594960-1-wangwenliang.1995@bytedance.com>
 <1682576442.2203932-1-xuanzhuo@linux.alibaba.com>
 <252ee222-f918-426e-68ef-b3710a60662e@bytedance.com>
 <1682579624.5395834-1-xuanzhuo@linux.alibaba.com>
 <20230427041206-mutt-send-email-mst@kernel.org>
 <1682583225.3180113-2-xuanzhuo@linux.alibaba.com>
MIME-Version: 1.0
In-Reply-To: <1682583225.3180113-2-xuanzhuo@linux.alibaba.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: pabeni@redhat.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, edumazet@google.com,
 kuba@kernel.org, Wenliang Wang <wangwenliang.1995@bytedance.com>,
 davem@davemloft.net
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

On Thu, Apr 27, 2023 at 04:13:45PM +0800, Xuan Zhuo wrote:
> On Thu, 27 Apr 2023 04:12:44 -0400, "Michael S. Tsirkin" <mst@redhat.com> wrote:
> > On Thu, Apr 27, 2023 at 03:13:44PM +0800, Xuan Zhuo wrote:
> > > On Thu, 27 Apr 2023 15:02:26 +0800, Wenliang Wang <wangwenliang.1995@bytedance.com> wrote:
> > > >
> > > >
> > > > On 4/27/23 2:20 PM, Xuan Zhuo wrote:
> > > > > On Thu, 27 Apr 2023 12:34:33 +0800, Wenliang Wang <wangwenliang.1995@bytedance.com> wrote:
> > > > >> For multi-queue and large rx-ring-size use case, the following error
> > > > >
> > > > > Cound you give we one number for example?
> > > >
> > > > 128 queues and 16K queue_size is typical.
> > > >
> > > > >
> > > > >> occurred when free_unused_bufs:
> > > > >> rcu: INFO: rcu_sched self-detected stall on CPU.
> > > > >>
> > > > >> Signed-off-by: Wenliang Wang <wangwenliang.1995@bytedance.com>
> > > > >> ---
> > > > >>   drivers/net/virtio_net.c | 1 +
> > > > >>   1 file changed, 1 insertion(+)
> > > > >>
> > > > >> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> > > > >> index ea1bd4bb326d..21d8382fd2c7 100644
> > > > >> --- a/drivers/net/virtio_net.c
> > > > >> +++ b/drivers/net/virtio_net.c
> > > > >> @@ -3565,6 +3565,7 @@ static void free_unused_bufs(struct virtnet_info *vi)
> > > > >>   		struct virtqueue *vq = vi->rq[i].vq;
> > > > >>   		while ((buf = virtqueue_detach_unused_buf(vq)) != NULL)
> > > > >>   			virtnet_rq_free_unused_buf(vq, buf);
> > > > >> +		schedule();
> > > > >
> > > > > Just for rq?
> > > > >
> > > > > Do we need to do the same thing for sq?
> > > > Rq buffers are pre-allocated, take seconds to free rq unused buffers.
> > > >
> > > > Sq unused buffers are much less, so do the same for sq is optional.
> > >
> > > I got.
> > >
> > > I think we should look for a way, compatible with the less queues or the smaller
> > > rings. Calling schedule() directly may be not a good way.
> > >
> > > Thanks.
> >
> > Why isn't it a good way?
> 
> For the small ring, I don't think it is a good way, maybe we only deal with one
> buf, then call schedule().
> 
> We can call the schedule() after processing a certain number of buffers,
> or check need_resched () first.
> 
> Thanks.


Wenliang, does
            if (need_resched())
                    schedule();
fix the issue for you?


> 
> 
> >
> > >
> > > >
> > > > >
> > > > > Thanks.
> > > > >
> > > > >
> > > > >>   	}
> > > > >>   }
> > > > >>
> > > > >> --
> > > > >> 2.20.1
> > > > >>
> >

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
