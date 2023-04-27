Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 028C9C77B61
	for <virtualization@archiver.kernel.org>; Thu, 27 Apr 2023 08:12:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 8EC5A60B53;
	Thu, 27 Apr 2023 08:12:58 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 8EC5A60B53
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=GavAj0ga
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id rw5ihdtG662G; Thu, 27 Apr 2023 08:12:56 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id B047560B2E;
	Thu, 27 Apr 2023 08:12:55 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org B047560B2E
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 554E8C0037;
	Thu, 27 Apr 2023 08:12:55 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1981CC002A
 for <virtualization@lists.linux-foundation.org>;
 Thu, 27 Apr 2023 08:12:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id DACA060B53
 for <virtualization@lists.linux-foundation.org>;
 Thu, 27 Apr 2023 08:12:53 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org DACA060B53
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id vzXelQYS2stl
 for <virtualization@lists.linux-foundation.org>;
 Thu, 27 Apr 2023 08:12:53 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org D6C2F60B2E
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id D6C2F60B2E
 for <virtualization@lists.linux-foundation.org>;
 Thu, 27 Apr 2023 08:12:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1682583171;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=aB49IfnVQxAVPmxftGfpUlkFmuC67pXs44wakcN9xOc=;
 b=GavAj0gajNz/hvm0MB7+/MYdp2X8Mpofo4biwUOvImYEMj9FdjjhP6ETAq4oaZKyj+R12C
 tuVjNlw+OOr4eP7g5EyT/Xd0QZ/KKc23CoBjQ3olYE6xue7u3R/R58MaTRDE3OZqKeXAop
 0duKd+lcdEPFaqY363KC2Ls+bh0I3Tg=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-244-5IzcYMegMKeA_mURzm3GHg-1; Thu, 27 Apr 2023 04:12:49 -0400
X-MC-Unique: 5IzcYMegMKeA_mURzm3GHg-1
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-2f8c2258b48so2681712f8f.1
 for <virtualization@lists.linux-foundation.org>;
 Thu, 27 Apr 2023 01:12:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1682583168; x=1685175168;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=aB49IfnVQxAVPmxftGfpUlkFmuC67pXs44wakcN9xOc=;
 b=TRXP8U1VGJyk6PRUrkYDF21T3KUxMhOd8eDP/CJTT+SyKscOoGtgt6nIDDdsn0W+Lj
 Aw6KdAeGcWXrHKJ0tvSqL8nceuMWab8c9h7Bl+zxMo2+jIwSfjNgIOInQgHagI4nKfyX
 IA7LzvoCbw4WQv2cRMef6ykQD2X7Lz5c4dDX7xDMar8uinO+zSr/n7RKvzD1VjyD4NMk
 pVBRkzo1MXlfGGWaB/aFNk4HTGd4pYQuTfuVdmns9r8LvPZwloc23GkTSAhMNrncCSur
 gsnhQP+xrXNyUyq6JiTNa4E2Ru40CynwCqEVOr7+UpLwCSNcsbYOLTvYZq/i3ulOdxow
 0WdQ==
X-Gm-Message-State: AC+VfDyl3FTh4dSBZsHlpBJjWaxeErzP8+WIX5Oi1CYgpqu9z8yUKDbp
 6sVC2Qeyw9Yt/wY2EmIrQH/enOcZ2ZF/WJSB6/9Fk1MZryUdSymgxayHktUMessYP7YgPC/mDlm
 2c465HsJkU/eG2rDxncHufx5fmFRAIS/98uA3+T7jgg==
X-Received: by 2002:adf:f64c:0:b0:2f9:a75:b854 with SMTP id
 x12-20020adff64c000000b002f90a75b854mr536194wrp.59.1682583168409; 
 Thu, 27 Apr 2023 01:12:48 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5emRcma09Oxn5dJrEsZwosfPxvNpGMisqE8jgCL0zI/xRIB9M5uqzHDqbC55yckTxtp6HXjQ==
X-Received: by 2002:adf:f64c:0:b0:2f9:a75:b854 with SMTP id
 x12-20020adff64c000000b002f90a75b854mr536175wrp.59.1682583168106; 
 Thu, 27 Apr 2023 01:12:48 -0700 (PDT)
Received: from redhat.com ([2.52.19.183]) by smtp.gmail.com with ESMTPSA id
 m2-20020a056000008200b002f53fa16239sm17804457wrx.103.2023.04.27.01.12.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Apr 2023 01:12:47 -0700 (PDT)
Date: Thu, 27 Apr 2023 04:12:44 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH] virtio_net: suppress cpu stall when free_unused_bufs
Message-ID: <20230427041206-mutt-send-email-mst@kernel.org>
References: <20230427043433.2594960-1-wangwenliang.1995@bytedance.com>
 <1682576442.2203932-1-xuanzhuo@linux.alibaba.com>
 <252ee222-f918-426e-68ef-b3710a60662e@bytedance.com>
 <1682579624.5395834-1-xuanzhuo@linux.alibaba.com>
MIME-Version: 1.0
In-Reply-To: <1682579624.5395834-1-xuanzhuo@linux.alibaba.com>
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

On Thu, Apr 27, 2023 at 03:13:44PM +0800, Xuan Zhuo wrote:
> On Thu, 27 Apr 2023 15:02:26 +0800, Wenliang Wang <wangwenliang.1995@bytedance.com> wrote:
> >
> >
> > On 4/27/23 2:20 PM, Xuan Zhuo wrote:
> > > On Thu, 27 Apr 2023 12:34:33 +0800, Wenliang Wang <wangwenliang.1995@bytedance.com> wrote:
> > >> For multi-queue and large rx-ring-size use case, the following error
> > >
> > > Cound you give we one number for example?
> >
> > 128 queues and 16K queue_size is typical.
> >
> > >
> > >> occurred when free_unused_bufs:
> > >> rcu: INFO: rcu_sched self-detected stall on CPU.
> > >>
> > >> Signed-off-by: Wenliang Wang <wangwenliang.1995@bytedance.com>
> > >> ---
> > >>   drivers/net/virtio_net.c | 1 +
> > >>   1 file changed, 1 insertion(+)
> > >>
> > >> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> > >> index ea1bd4bb326d..21d8382fd2c7 100644
> > >> --- a/drivers/net/virtio_net.c
> > >> +++ b/drivers/net/virtio_net.c
> > >> @@ -3565,6 +3565,7 @@ static void free_unused_bufs(struct virtnet_info *vi)
> > >>   		struct virtqueue *vq = vi->rq[i].vq;
> > >>   		while ((buf = virtqueue_detach_unused_buf(vq)) != NULL)
> > >>   			virtnet_rq_free_unused_buf(vq, buf);
> > >> +		schedule();
> > >
> > > Just for rq?
> > >
> > > Do we need to do the same thing for sq?
> > Rq buffers are pre-allocated, take seconds to free rq unused buffers.
> >
> > Sq unused buffers are much less, so do the same for sq is optional.
> 
> I got.
> 
> I think we should look for a way, compatible with the less queues or the smaller
> rings. Calling schedule() directly may be not a good way.
> 
> Thanks.

Why isn't it a good way?

> 
> >
> > >
> > > Thanks.
> > >
> > >
> > >>   	}
> > >>   }
> > >>
> > >> --
> > >> 2.20.1
> > >>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
