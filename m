Return-Path: <SRS0=fJjx=P6=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4048EC433F5
	for <virtualization@archiver.kernel.org>; Thu, 11 Nov 2021 15:02:17 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D248360E73
	for <virtualization@archiver.kernel.org>; Thu, 11 Nov 2021 15:02:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org D248360E73
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 7CA74403AF;
	Thu, 11 Nov 2021 15:02:16 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id dq1GS_KqAxVL; Thu, 11 Nov 2021 15:02:14 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 1D2DC40224;
	Thu, 11 Nov 2021 15:02:14 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E5FF3C001F;
	Thu, 11 Nov 2021 15:02:13 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id BA35BC001E
 for <virtualization@lists.linux-foundation.org>;
 Thu, 11 Nov 2021 15:02:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 9304740224
 for <virtualization@lists.linux-foundation.org>;
 Thu, 11 Nov 2021 15:02:12 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ZI9wvxWtuZRd
 for <virtualization@lists.linux-foundation.org>;
 Thu, 11 Nov 2021 15:02:11 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id E806E40172
 for <virtualization@lists.linux-foundation.org>;
 Thu, 11 Nov 2021 15:02:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1636642929;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=P8p6CBi9GhyAybomTT9aK06QsN9Co1Vcux5yo3BY17U=;
 b=gBHZvyledWPFubuyWPdHJ9NCx3/EQR78gUy0cWUJMn/p03jJfE7072uD13TF9cKyS6t9nH
 SfqLbOi8iqd0TRfx459nrW3cjOItqSpwuAQu2mucSNnzPeuRbKHfXYJDQyVQ4nVN04YUgB
 iJuh2mxz7D7dvy17BldVJjUEUERaAmY=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-551-_h-AzvFpOSiPDqYI7GPuTw-1; Thu, 11 Nov 2021 10:02:06 -0500
X-MC-Unique: _h-AzvFpOSiPDqYI7GPuTw-1
Received: by mail-wm1-f71.google.com with SMTP id
 l4-20020a05600c1d0400b00332f47a0fa3so2809444wms.8
 for <virtualization@lists.linux-foundation.org>;
 Thu, 11 Nov 2021 07:02:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=P8p6CBi9GhyAybomTT9aK06QsN9Co1Vcux5yo3BY17U=;
 b=ZB2onIeFeX7WjCQvNKAmGXIpqxXMlLdN8hvGo7T+oh8JN9Z6uXVXJlJ30if+2NVDr0
 DHrpTbB3wb4F5+7zlItW/fRfv5FyyhpQGgBTxLoEOm3Zx76iDUC9Q017fThGy2cv1eL6
 wihhlzhammcUIDwt+GanFoYcHDG5GV280fkk4OxxAdqsh5Xqmn228kBMaoI0qjBJ2tn5
 E43Bdu0bUxVT7Jz6KPGwApgeY9TwC/smRqS7U8o57Tqt1sbpWVEbdxqckg3MbCdpscsq
 1JptTHNvZvLgtSietjChQVVDRBEWEq1BsuSTp36VNFEnBENwuDEXPMd1jPl9xfbO7rU8
 ZsaA==
X-Gm-Message-State: AOAM533L+wtEejkMxQ/7iU+9fCubkwAXyyEBnVmsIpDiWapa3izSkNqs
 S3qnR1VWxvUBqq/EXD7cRtDNtM9WhidmateQSGlDBpHJf9te2EX88e1gdDsUxQvsIVuxEfBGvwL
 8vo3WRthlcrEncISEo81OLTNls/KSm7isCRZ9CYdOCQ==
X-Received: by 2002:a05:600c:1d28:: with SMTP id
 l40mr9002729wms.192.1636642925500; 
 Thu, 11 Nov 2021 07:02:05 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwkrb/NNFzG3uc3s+Qn7RLDKcEGHeP1u7uOqyhEqqTl55Guko20m8LN6N3y0i9Lb0+EXDrBAA==
X-Received: by 2002:a05:600c:1d28:: with SMTP id
 l40mr9002687wms.192.1636642925242; 
 Thu, 11 Nov 2021 07:02:05 -0800 (PST)
Received: from redhat.com ([2.55.135.246])
 by smtp.gmail.com with ESMTPSA id h1sm3116622wmb.7.2021.11.11.07.02.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 11 Nov 2021 07:02:04 -0800 (PST)
Date: Thu, 11 Nov 2021 10:02:01 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH v4 0/3] virtio support cache indirect desc
Message-ID: <20211111100044-mutt-send-email-mst@kernel.org>
References: <20211110074326-mutt-send-email-mst@kernel.org>
 <1636613527.8447719-1-xuanzhuo@linux.alibaba.com>
MIME-Version: 1.0
In-Reply-To: <1636613527.8447719-1-xuanzhuo@linux.alibaba.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
 Jakub Kicinski <kuba@kernel.org>, virtualization@lists.linux-foundation.org
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

On Thu, Nov 11, 2021 at 02:52:07PM +0800, Xuan Zhuo wrote:
> On Wed, 10 Nov 2021 07:53:44 -0500, Michael S. Tsirkin <mst@redhat.com> wrote:
> > On Mon, Nov 08, 2021 at 10:47:40PM +0800, Xuan Zhuo wrote:
> > > On Mon, 8 Nov 2021 08:49:27 -0500, Michael S. Tsirkin <mst@redhat.com> wrote:
> > > >
> > > > Hmm a bunch of comments got ignored. See e.g.
> > > > https://lore.kernel.org/r/20211027043851-mutt-send-email-mst%40kernel.org
> > > > if they aren't relevant add code comments or commit log text explaining the
> > > > design choice please.
> > >
> > > I should have responded to related questions, I am guessing whether some emails
> > > have been lost.
> > >
> > > I have sorted out the following 6 questions, if there are any missing questions,
> > > please let me know.
> > >
> > > 1. use list_head
> > >   In the earliest version, I used pointers directly. You suggest that I use
> > >   llist_head, but considering that llist_head has atomic operations. There is no
> > >   competition problem here, so I used list_head.
> > >
> > >   In fact, I did not increase the allocated space for list_head.
> > >
> > >   use as desc array: | vring_desc | vring_desc | vring_desc | vring_desc |
> > >   use as queue item: | list_head ........................................|
> >
> > the concern is that you touch many cache lines when removing an entry.
> >
> > I suggest something like:
> >
> > llist: add a non-atomic list_del_first
> >
> > One has to know what one's doing, but if one has locked the list
> > preventing all accesses, then it's ok to just pop off an entry without
> > atomics.
> >
> 
> Oh, great, but my way of solving the problem is too conservative.
> 
> > Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> >
> > ---
> >
> > diff --git a/include/linux/llist.h b/include/linux/llist.h
> > index 24f207b0190b..13a47dddb12b 100644
> > --- a/include/linux/llist.h
> > +++ b/include/linux/llist.h
> > @@ -247,6 +247,17 @@ static inline struct llist_node *__llist_del_all(struct llist_head *head)
> >
> >  extern struct llist_node *llist_del_first(struct llist_head *head);
> >
> > +static inline struct llist_node *__llist_del_first(struct llist_head *head)
> > +{
> > +	struct llist_node *first = head->first;
> > +
> > +	if (!first)
> > +		return NULL;
> > +
> > +	head->first = first->next;
> > +	return first;
> > +}
> > +
> >  struct llist_node *llist_reverse_order(struct llist_node *head);
> >
> >  #endif /* LLIST_H */
> >
> >
> > -----
> >
> >
> > > 2.
> > > > > +	if (vq->use_desc_cache && total_sg <= VIRT_QUEUE_CACHE_DESC_NUM) {
> > > > > +		if (vq->desc_cache_chain) {
> > > > > +			desc = vq->desc_cache_chain;
> > > > > +			vq->desc_cache_chain = (void *)desc->addr;
> > > > > +			goto got;
> > > > > +		}
> > > > > +		n = VIRT_QUEUE_CACHE_DESC_NUM;
> > > >
> > > > Hmm. This will allocate more entries than actually used. Why do it?
> > >
> > >
> > > This is because the size of each cache item is fixed, and the logic has been
> > > modified in the latest code. I think this problem no longer exists.
> > >
> > >
> > > 3.
> > > > What bothers me here is what happens if cache gets
> > > > filled on one numa node, then used on another?
> > >
> > > I'm thinking about another question, how did the cross-numa appear here, and
> > > virtio desc queue also has the problem of cross-numa. So is it necessary for us
> > > to deal with the cross-numa scene?
> >
> > It's true that desc queue might be cross numa, and people are looking
> > for ways to improve that. Not a reason to make things worse ...
> >
> 
> I will test for it.
> 
> >
> > > Indirect desc is used as virtio desc, so as long as it is in the same numa as
> > > virito desc. So we can allocate indirect desc cache at the same time when
> > > allocating virtio desc queue.
> >
> > Using it from current node like we do now seems better.
> >
> > > 4.
> > > > So e.g. for rx, we are wasting memory since indirect isn't used.
> > >
> > > In the current version, desc cache is set up based on pre-queue.
> > >
> > > So if the desc cache is not used, we don't need to set the desc cache.
> > >
> > > For example, virtio-net, as long as the tx queue and the rx queue in big packet
> > > mode enable desc cache.
> >
> >
> > I liked how in older versions adding indrect enabled it implicitly
> > though without need to hack drivers.
> 
> I see.
> 
> >
> > > 5.
> > > > Would a better API be a cache size in bytes? This controls how much
> > > > memory is spent after all.
> > >
> > > My design is to set a threshold. When total_sg is greater than this threshold,
> > > it will fall back to kmalloc/kfree. When total_sg is less than or equal to
> > > this threshold, use the allocated cache.
> > >
> >
> > I know. My question is this, do devices know what a good threshold is?
> > If yes how do they know?
> 
> I think the driver knows the threshold, for example, MAX_SKB_FRAG + 2 is a
> suitable threshold for virtio-net.
> 

I guess... in that case I assume it's a good idea to have
virtio core round the size up to whole cache lines, right?

> >
> > > 6. kmem_cache_*
> > >
> > > I have tested these, the performance is not as good as the method used in this
> > > patch.
> >
> > Do you mean kmem_cache_alloc_bulk/kmem_cache_free_bulk?
> > You mentioned just kmem_cache_alloc previously.
> 
> 
> I will test for kmem_cache_alloc_bulk.
> 
> Thanks.
> 
> >
> > >
> > > Thanks.
> >

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
