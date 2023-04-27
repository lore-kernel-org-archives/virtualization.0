Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CFB78C77B61
	for <virtualization@archiver.kernel.org>; Thu, 27 Apr 2023 07:18:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 39BF941E0A;
	Thu, 27 Apr 2023 07:18:44 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 39BF941E0A
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 5hDjPIk-NOYe; Thu, 27 Apr 2023 07:18:43 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 90A81418D1;
	Thu, 27 Apr 2023 07:18:42 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 90A81418D1
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 70788C0037;
	Thu, 27 Apr 2023 07:18:42 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 957BEC002A
 for <virtualization@lists.linux-foundation.org>;
 Thu, 27 Apr 2023 07:18:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 6010540124
 for <virtualization@lists.linux-foundation.org>;
 Thu, 27 Apr 2023 07:18:41 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 6010540124
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id cyzvN-iiol_Y
 for <virtualization@lists.linux-foundation.org>;
 Thu, 27 Apr 2023 07:18:40 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org BCEB9400CC
Received: from out30-131.freemail.mail.aliyun.com
 (out30-131.freemail.mail.aliyun.com [115.124.30.131])
 by smtp2.osuosl.org (Postfix) with ESMTPS id BCEB9400CC
 for <virtualization@lists.linux-foundation.org>;
 Thu, 27 Apr 2023 07:18:39 +0000 (UTC)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R121e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=ay29a033018046049;
 MF=xuanzhuo@linux.alibaba.com; NM=1; PH=DS; RN=10; SR=0;
 TI=SMTPD_---0Vh6Ouev_1682579912; 
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com
 fp:SMTPD_---0Vh6Ouev_1682579912) by smtp.aliyun-inc.com;
 Thu, 27 Apr 2023 15:18:33 +0800
Message-ID: <1682579624.5395834-1-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH] virtio_net: suppress cpu stall when free_unused_bufs
Date: Thu, 27 Apr 2023 15:13:44 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: Wenliang Wang <wangwenliang.1995@bytedance.com>
References: <20230427043433.2594960-1-wangwenliang.1995@bytedance.com>
 <1682576442.2203932-1-xuanzhuo@linux.alibaba.com>
 <252ee222-f918-426e-68ef-b3710a60662e@bytedance.com>
In-Reply-To: <252ee222-f918-426e-68ef-b3710a60662e@bytedance.com>
Cc: mst@redhat.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, davem@davemloft.net
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
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

On Thu, 27 Apr 2023 15:02:26 +0800, Wenliang Wang <wangwenliang.1995@bytedance.com> wrote:
>
>
> On 4/27/23 2:20 PM, Xuan Zhuo wrote:
> > On Thu, 27 Apr 2023 12:34:33 +0800, Wenliang Wang <wangwenliang.1995@bytedance.com> wrote:
> >> For multi-queue and large rx-ring-size use case, the following error
> >
> > Cound you give we one number for example?
>
> 128 queues and 16K queue_size is typical.
>
> >
> >> occurred when free_unused_bufs:
> >> rcu: INFO: rcu_sched self-detected stall on CPU.
> >>
> >> Signed-off-by: Wenliang Wang <wangwenliang.1995@bytedance.com>
> >> ---
> >>   drivers/net/virtio_net.c | 1 +
> >>   1 file changed, 1 insertion(+)
> >>
> >> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> >> index ea1bd4bb326d..21d8382fd2c7 100644
> >> --- a/drivers/net/virtio_net.c
> >> +++ b/drivers/net/virtio_net.c
> >> @@ -3565,6 +3565,7 @@ static void free_unused_bufs(struct virtnet_info *vi)
> >>   		struct virtqueue *vq = vi->rq[i].vq;
> >>   		while ((buf = virtqueue_detach_unused_buf(vq)) != NULL)
> >>   			virtnet_rq_free_unused_buf(vq, buf);
> >> +		schedule();
> >
> > Just for rq?
> >
> > Do we need to do the same thing for sq?
> Rq buffers are pre-allocated, take seconds to free rq unused buffers.
>
> Sq unused buffers are much less, so do the same for sq is optional.

I got.

I think we should look for a way, compatible with the less queues or the smaller
rings. Calling schedule() directly may be not a good way.

Thanks.


>
> >
> > Thanks.
> >
> >
> >>   	}
> >>   }
> >>
> >> --
> >> 2.20.1
> >>
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
