Return-Path: <SRS0=RKVt=P5=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 118CAC433F5
	for <virtualization@archiver.kernel.org>; Wed, 10 Nov 2021 12:54:59 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AAD266115B
	for <virtualization@archiver.kernel.org>; Wed, 10 Nov 2021 12:54:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org AAD266115B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 608C8403BB;
	Wed, 10 Nov 2021 12:54:58 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id IXNtwrsEeTUd; Wed, 10 Nov 2021 12:54:57 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 06CB9403BD;
	Wed, 10 Nov 2021 12:54:57 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D7653C0019;
	Wed, 10 Nov 2021 12:54:56 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 7586BC000E
 for <virtualization@lists.linux-foundation.org>;
 Wed, 10 Nov 2021 12:54:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 6405080F74
 for <virtualization@lists.linux-foundation.org>;
 Wed, 10 Nov 2021 12:54:55 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id h8lUr4VvjRm7
 for <virtualization@lists.linux-foundation.org>;
 Wed, 10 Nov 2021 12:54:54 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 6671B80E1E
 for <virtualization@lists.linux-foundation.org>;
 Wed, 10 Nov 2021 12:54:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1636548893;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=z4n9H695I56p3uFL/xN9H+OG/zilvbb6UbzgWj/opIc=;
 b=QH4jiq2SrVUlG8S4LwZ9y6IjFFzS7m9RproP5uavjpRqOy6AORCCD71A+ZPkFsLUicS9wd
 E/5/24iJHk5uPnCrEmlvtf6I+wKiUB+9FeXHDT3ngS82TR+N9ZCyD8h/3kjJCi9NtfpfhF
 6RT8KCirO9j6y7R/E0GCZRfQbACn1m0=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-269-8htX2zLAN_Knz9LwqICIVA-1; Wed, 10 Nov 2021 07:54:52 -0500
X-MC-Unique: 8htX2zLAN_Knz9LwqICIVA-1
Received: by mail-ed1-f69.google.com with SMTP id
 x13-20020a05640226cd00b003e2bf805a02so2191390edd.23
 for <virtualization@lists.linux-foundation.org>;
 Wed, 10 Nov 2021 04:54:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=z4n9H695I56p3uFL/xN9H+OG/zilvbb6UbzgWj/opIc=;
 b=l1ghbRvcqHTSn6E2USc1oq9wBvNzQ5EbXlp+rS6rgufJ7m4SjyOLEhZj8fmvhWTHSU
 QREM4zcyeDRfGAb4gsGRRMHVituG9svQEs/1Y9rrsSFSvlgyueLEAR9Ohn745GAWv7el
 FBFfP/N/zftatixZaPPSKecwBAn00RXIe9z1oOQ/b1dRfXXSVzYWZg5Z6GAVBUA44f21
 EAogmXGkd5ixxbqgbwxVgvQ4ItqGWacAEBe9UuV1tLUNv1bfY7heT/DqN3Vg3r6sC4Tw
 B2Hcq21D50cYqYkIk+DA6R5UtQMVlmTVBItixNk5TxAmN0UQq9mzsvjVWljnXTbME/+l
 vc6A==
X-Gm-Message-State: AOAM533aV4YHamt5qc9J6TQdns4LpkHK3Ftup/bSGLof621RX0u9jAOy
 kqmvVkl7dkRwhkA8bTBQBI2NY+c/9mWnS9wySa7qkaEE5mATOEpuUN8MTCjqR8IBURoHuoAYCws
 8gRw9Ve2eeJNj36yEBv9B6XVd6yxZZzqTfcfbszk+SQ==
X-Received: by 2002:aa7:cd99:: with SMTP id x25mr21043885edv.249.1636548891080; 
 Wed, 10 Nov 2021 04:54:51 -0800 (PST)
X-Google-Smtp-Source: ABdhPJw50M4PLj6z/Dq+XVHSq0+qJ6iYuzTlHJFOEl/jotgYfNBocUvMNCYW+Use7QYwyxpd7H5SiQ==
X-Received: by 2002:aa7:cd99:: with SMTP id x25mr21043861edv.249.1636548890882; 
 Wed, 10 Nov 2021 04:54:50 -0800 (PST)
Received: from redhat.com ([2.55.133.41])
 by smtp.gmail.com with ESMTPSA id r19sm12535963edt.54.2021.11.10.04.54.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 10 Nov 2021 04:54:50 -0800 (PST)
Date: Wed, 10 Nov 2021 07:54:46 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH v4 0/3] virtio support cache indirect desc
Message-ID: <20211110075412-mutt-send-email-mst@kernel.org>
References: <20211108084732-mutt-send-email-mst@kernel.org>
 <1636382860.765897-1-xuanzhuo@linux.alibaba.com>
 <20211110074326-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
In-Reply-To: <20211110074326-mutt-send-email-mst@kernel.org>
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

On Wed, Nov 10, 2021 at 07:53:49AM -0500, Michael S. Tsirkin wrote:
> On Mon, Nov 08, 2021 at 10:47:40PM +0800, Xuan Zhuo wrote:
> > On Mon, 8 Nov 2021 08:49:27 -0500, Michael S. Tsirkin <mst@redhat.com> wrote:
> > >
> > > Hmm a bunch of comments got ignored. See e.g.
> > > https://lore.kernel.org/r/20211027043851-mutt-send-email-mst%40kernel.org
> > > if they aren't relevant add code comments or commit log text explaining the
> > > design choice please.
> > 
> > I should have responded to related questions, I am guessing whether some emails
> > have been lost.
> > 
> > I have sorted out the following 6 questions, if there are any missing questions,
> > please let me know.
> > 
> > 1. use list_head
> >   In the earliest version, I used pointers directly. You suggest that I use
> >   llist_head, but considering that llist_head has atomic operations. There is no
> >   competition problem here, so I used list_head.
> > 
> >   In fact, I did not increase the allocated space for list_head.
> > 
> >   use as desc array: | vring_desc | vring_desc | vring_desc | vring_desc |
> >   use as queue item: | list_head ........................................|
> 
> the concern is that you touch many cache lines when removing an entry.
> 
> I suggest something like:
> 
> llist: add a non-atomic list_del_first
> 
> One has to know what one's doing, but if one has locked the list
> preventing all accesses, then it's ok to just pop off an entry without
> atomics.
> 
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> 
> ---
> 
> diff --git a/include/linux/llist.h b/include/linux/llist.h
> index 24f207b0190b..13a47dddb12b 100644
> --- a/include/linux/llist.h
> +++ b/include/linux/llist.h
> @@ -247,6 +247,17 @@ static inline struct llist_node *__llist_del_all(struct llist_head *head)
>  
>  extern struct llist_node *llist_del_first(struct llist_head *head);
>  
> +static inline struct llist_node *__llist_del_first(struct llist_head *head)
> +{
> +	struct llist_node *first = head->first;
> +
> +	if (!first)
> +		return NULL;
> +
> +	head->first = first->next;
> +	return first;
> +}
> +
>  struct llist_node *llist_reverse_order(struct llist_node *head);
>  
>  #endif /* LLIST_H */
> 
> 
> -----
> 
> 
> > 2.
> > > > +	if (vq->use_desc_cache && total_sg <= VIRT_QUEUE_CACHE_DESC_NUM) {
> > > > +		if (vq->desc_cache_chain) {
> > > > +			desc = vq->desc_cache_chain;
> > > > +			vq->desc_cache_chain = (void *)desc->addr;
> > > > +			goto got;
> > > > +		}
> > > > +		n = VIRT_QUEUE_CACHE_DESC_NUM;
> > >
> > > Hmm. This will allocate more entries than actually used. Why do it?
> > 
> > 
> > This is because the size of each cache item is fixed, and the logic has been
> > modified in the latest code. I think this problem no longer exists.
> > 
> > 
> > 3.
> > > What bothers me here is what happens if cache gets
> > > filled on one numa node, then used on another?
> > 
> > I'm thinking about another question, how did the cross-numa appear here, and
> > virtio desc queue also has the problem of cross-numa. So is it necessary for us
> > to deal with the cross-numa scene?
> 
> It's true that desc queue might be cross numa, and people are looking
> for ways to improve that. Not a reason to make things worse ...
> 

To add to that, given it's a concern, how about actually
testing performance for this config?

> > Indirect desc is used as virtio desc, so as long as it is in the same numa as
> > virito desc. So we can allocate indirect desc cache at the same time when
> > allocating virtio desc queue.
> 
> Using it from current node like we do now seems better.
> 
> > 4.
> > > So e.g. for rx, we are wasting memory since indirect isn't used.
> > 
> > In the current version, desc cache is set up based on pre-queue.
> > 
> > So if the desc cache is not used, we don't need to set the desc cache.
> > 
> > For example, virtio-net, as long as the tx queue and the rx queue in big packet
> > mode enable desc cache.
> 
> 
> I liked how in older versions adding indrect enabled it implicitly
> though without need to hack drivers.
> 
> > 5.
> > > Would a better API be a cache size in bytes? This controls how much
> > > memory is spent after all.
> > 
> > My design is to set a threshold. When total_sg is greater than this threshold,
> > it will fall back to kmalloc/kfree. When total_sg is less than or equal to
> > this threshold, use the allocated cache.
> > 
> 
> I know. My question is this, do devices know what a good threshold is?
> If yes how do they know?
> 
> > 6. kmem_cache_*
> > 
> > I have tested these, the performance is not as good as the method used in this
> > patch.
> 
> Do you mean kmem_cache_alloc_bulk/kmem_cache_free_bulk?
> You mentioned just kmem_cache_alloc previously.
> 
> > 
> > Thanks.

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
