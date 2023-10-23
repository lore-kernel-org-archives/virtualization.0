Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0511CC001E0
	for <virtualization@archiver.kernel.org>; Mon, 23 Oct 2023 09:52:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 85E7A41552;
	Mon, 23 Oct 2023 09:52:21 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 85E7A41552
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id pZp_M6RHdfkx; Mon, 23 Oct 2023 09:52:20 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 89DDC4152C;
	Mon, 23 Oct 2023 09:52:19 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 89DDC4152C
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 3D7C3C0039;
	Mon, 23 Oct 2023 09:52:19 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 29BC9C0032
 for <virtualization@lists.linux-foundation.org>;
 Mon, 23 Oct 2023 09:52:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id ED29082AEF
 for <virtualization@lists.linux-foundation.org>;
 Mon, 23 Oct 2023 09:52:17 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org ED29082AEF
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id cy75oxV62Pd1
 for <virtualization@lists.linux-foundation.org>;
 Mon, 23 Oct 2023 09:52:17 +0000 (UTC)
Received: from out30-118.freemail.mail.aliyun.com
 (out30-118.freemail.mail.aliyun.com [115.124.30.118])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 5E71A82AC3
 for <virtualization@lists.linux-foundation.org>;
 Mon, 23 Oct 2023 09:52:15 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 5E71A82AC3
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R211e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=ay29a033018046049;
 MF=xuanzhuo@linux.alibaba.com; NM=1; PH=DS; RN=5; SR=0;
 TI=SMTPD_---0Vujf6Ku_1698054729; 
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com
 fp:SMTPD_---0Vujf6Ku_1698054729) by smtp.aliyun-inc.com;
 Mon, 23 Oct 2023 17:52:10 +0800
Message-ID: <1698054722.2894735-1-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH] virtio_ring: add an error code check in virtqueue_resize
Date: Mon, 23 Oct 2023 17:52:02 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: Su Hui <suhui@nfschina.com>
References: <20231020092320.209234-1-suhui@nfschina.com>
 <20231020053047-mutt-send-email-mst@kernel.org>
 <1697794601.5857713-2-xuanzhuo@linux.alibaba.com>
 <20231020054140-mutt-send-email-mst@kernel.org>
 <1697795422.0986886-1-xuanzhuo@linux.alibaba.com>
 <20231020055943-mutt-send-email-mst@kernel.org>
 <1698028017.8052797-1-xuanzhuo@linux.alibaba.com>
 <d4aa3f76-3e08-a852-a948-b88226a37fdd@nfschina.com>
 <1698029596.5404413-3-xuanzhuo@linux.alibaba.com>
 <46aee820-6c01-ed8a-613b-5c57258d749e@nfschina.com>
 <1698040004.5365264-4-xuanzhuo@linux.alibaba.com>
 <6a7d1006-0988-77ea-0991-9c7b422d78e1@nfschina.com>
In-Reply-To: <6a7d1006-0988-77ea-0991-9c7b422d78e1@nfschina.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, kernel-janitors@vger.kernel.org,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org
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

On Mon, 23 Oct 2023 17:50:46 +0800, Su Hui <suhui@nfschina.com> wrote:
> On 2023/10/23 13:46, Xuan Zhuo wrote:
> >>>>>>>> Well, what are the cases where it can happen practically?
> >>>>>>> Device error. Such as vp_active_vq()
> >>>>>>>
> >>>>>>> Thanks.
> >>>>>> Hmm interesting. OK. But do callers know to recover?
> >>>>> No.
> >>>>>
> >>>>> So I think WARN + broken is suitable.
> >>>>>
> >>>>> Thanks.
> >>>> Sorry for the late, is the following code okay?
> >>>>
> >>>> @@ -2739,7 +2739,7 @@ int virtqueue_resize(struct virtqueue *_vq, u32 num,
> >>>>                         void (*recycle)(struct virtqueue *vq, void *buf))
> >>>>     {
> >>>>            struct vring_virtqueue *vq = to_vvq(_vq);
> >>>> -       int err;
> >>>> +       int err, err_reset;
> >>>>
> >>>>            if (num > vq->vq.num_max)
> >>>>                    return -E2BIG;
> >>>> @@ -2759,7 +2759,15 @@ int virtqueue_resize(struct virtqueue *_vq, u32 num,
> >>>>            else
> >>>>                    err = virtqueue_resize_split(_vq, num);
> >>>>
> >>>> -       return virtqueue_enable_after_reset(_vq);
> >>>> +       err_reset = virtqueue_enable_after_reset(_vq);
> >>>> +
> >>>> +       if (err) {
> >>> No err.
> >>>
> >>> err is not important.
> >>> You can remove that.
> >> Emm, I'm a little confused that which code should I remove ?
> >>
> >>
> >> like this:
> >> 	if (vq->packed_ring)
> >> 		virtqueue_resize_packed(_vq, num);
> >> 	else
> >> 		virtqueue_resize_split(_vq, num);
> >>
> >> And we should set broken and warn inside virtqueue_enable_after_reset()?
>
> In my opinion, we should return the error code of virtqueue_resize_packed() / virtqueue_resize_split().
> But if this err is not important, this patch makes no sense.
> Maybe I misunderstand somewhere...
> If you think it's worth sending a patch, you can send it :).(I'm not familiar with this code).

OK.

Thanks.


>
> Thanks,
> Su Hui
>
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
