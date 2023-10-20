Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D85C5C004C0
	for <virtualization@archiver.kernel.org>; Fri, 20 Oct 2023 09:52:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 77B3383BEF;
	Fri, 20 Oct 2023 09:52:37 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 77B3383BEF
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id EmHQx3Z2Sqfj; Fri, 20 Oct 2023 09:52:36 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id DF6A283BBC;
	Fri, 20 Oct 2023 09:52:35 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org DF6A283BBC
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B5985C0071;
	Fri, 20 Oct 2023 09:52:35 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 57368C0032
 for <virtualization@lists.linux-foundation.org>;
 Fri, 20 Oct 2023 09:52:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 29C2683BBC
 for <virtualization@lists.linux-foundation.org>;
 Fri, 20 Oct 2023 09:52:34 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 29C2683BBC
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id wIwnhfUlX4lR
 for <virtualization@lists.linux-foundation.org>;
 Fri, 20 Oct 2023 09:52:33 +0000 (UTC)
Received: from out30-98.freemail.mail.aliyun.com
 (out30-98.freemail.mail.aliyun.com [115.124.30.98])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 7484983BA7
 for <virtualization@lists.linux-foundation.org>;
 Fri, 20 Oct 2023 09:52:31 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 7484983BA7
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R861e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=ay29a033018046051;
 MF=xuanzhuo@linux.alibaba.com; NM=1; PH=DS; RN=6; SR=0;
 TI=SMTPD_---0VuWrMoa_1697795545; 
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com
 fp:SMTPD_---0VuWrMoa_1697795545) by smtp.aliyun-inc.com;
 Fri, 20 Oct 2023 17:52:26 +0800
Message-ID: <1697795422.0986886-1-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH] virtio_ring: add an error code check in virtqueue_resize
Date: Fri, 20 Oct 2023 17:50:22 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
References: <20231020092320.209234-1-suhui@nfschina.com>
 <20231020053047-mutt-send-email-mst@kernel.org>
 <1697794601.5857713-2-xuanzhuo@linux.alibaba.com>
 <20231020054140-mutt-send-email-mst@kernel.org>
In-Reply-To: <20231020054140-mutt-send-email-mst@kernel.org>
Cc: Su Hui <suhui@nfschina.com>, kernel-janitors@vger.kernel.org,
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

On Fri, 20 Oct 2023 05:42:14 -0400, "Michael S. Tsirkin" <mst@redhat.com> wrote:
> On Fri, Oct 20, 2023 at 05:36:41PM +0800, Xuan Zhuo wrote:
> > On Fri, 20 Oct 2023 05:34:32 -0400, "Michael S. Tsirkin" <mst@redhat.com> wrote:
> > > On Fri, Oct 20, 2023 at 05:23:21PM +0800, Su Hui wrote:
> > > > virtqueue_resize_packed() or virtqueue_resize_split() can return
> > > > error code if failed, so add a check for this.
> > > >
> > > > Signed-off-by: Su Hui <suhui@nfschina.com>
> > > > ---
> > > >
> > > > I'm not sure that return directly is right or not,
> > > > maybe there are some process should do before return.
> > >
> > > yes - presizely what virtqueue_enable_after_reset does.
> > >
> > > Error handling in virtqueue_enable_after_reset is really weird BTW.
> > > For some reason it overrides the error code returned.
> > >
> > >
> > >
> > >
> > >
> > > >  drivers/virtio/virtio_ring.c | 3 +++
> > > >  1 file changed, 3 insertions(+)
> > > >
> > > > diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> > > > index 51d8f3299c10..cf662c3a755b 100644
> > > > --- a/drivers/virtio/virtio_ring.c
> > > > +++ b/drivers/virtio/virtio_ring.c
> > > > @@ -2759,6 +2759,9 @@ int virtqueue_resize(struct virtqueue *_vq, u32 num,
> > > >  	else
> > > >  		err = virtqueue_resize_split(_vq, num);
> > > >
> > > > +	if (err)
> > > > +		return err;
> > > > +
> > > >  	return virtqueue_enable_after_reset(_vq);
> > >
> > > So I think it should be something like:
> > >
> > > 	int err_reset = virtqueue_enable_after_reset(_vq);
> > > 	BUG_ON(err_reset);
> > >
> > > 	return err;
> > >
> >
> > How about WARN and vq->broken?
> >
> > Thanks.
>
> Well, what are the cases where it can happen practically?

Device error. Such as vp_active_vq()

Thanks.


>
> >
> > >
> > >
> > > >  }
> > > >  EXPORT_SYMBOL_GPL(virtqueue_resize);
> > > > --
> > > > 2.30.2
> > >
>
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
