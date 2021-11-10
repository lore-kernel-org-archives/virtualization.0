Return-Path: <SRS0=RKVt=P5=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25F1BC433F5
	for <virtualization@archiver.kernel.org>; Wed, 10 Nov 2021 12:53:59 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CB0CD6115B
	for <virtualization@archiver.kernel.org>; Wed, 10 Nov 2021 12:53:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org CB0CD6115B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 82675400C6;
	Wed, 10 Nov 2021 12:53:58 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id y3V7x9gj2Ht8; Wed, 10 Nov 2021 12:53:57 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id AF724400AF;
	Wed, 10 Nov 2021 12:53:56 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 7BEEBC0019;
	Wed, 10 Nov 2021 12:53:56 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E432AC000E
 for <virtualization@lists.linux-foundation.org>;
 Wed, 10 Nov 2021 12:53:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id D397380C12
 for <virtualization@lists.linux-foundation.org>;
 Wed, 10 Nov 2021 12:53:54 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id g0NZ4lmF4zzz
 for <virtualization@lists.linux-foundation.org>;
 Wed, 10 Nov 2021 12:53:53 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 3E54680BE9
 for <virtualization@lists.linux-foundation.org>;
 Wed, 10 Nov 2021 12:53:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1636548832;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Sn1WXrnXTZ1dYyFwngm5xjUkxmZOxlAGXW9Egen7F3c=;
 b=BZsrbmGWiYkXXY2b1j/H0StJ3Da7ROuVZ9ZWBP4wLvWdPeSymMEk6U6AIFksjwQ+1Q0io0
 m1YykZ6MePPGo5itRDV2c3AW5ullu5jnvPU/mnOA0YItE4TOupW6712K4T8I7aA06U2xlI
 39KjyKNfFNFsEwTqp+ScxtJxDnN0xro=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-458-nmjCpYB3PTibYQvXn2JVVA-1; Wed, 10 Nov 2021 07:53:50 -0500
X-MC-Unique: nmjCpYB3PTibYQvXn2JVVA-1
Received: by mail-ed1-f72.google.com with SMTP id
 f4-20020a50e084000000b003db585bc274so2205387edl.17
 for <virtualization@lists.linux-foundation.org>;
 Wed, 10 Nov 2021 04:53:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=Sn1WXrnXTZ1dYyFwngm5xjUkxmZOxlAGXW9Egen7F3c=;
 b=YZkhyTMUHMioTcU5OOHbtY820F5NYcdAnXki1autYhSecTaZsxacHkwfRwmCXEMpaq
 ilnkoFIzzsUs/DEcd2nRtWB+adm/qeb9tLnelMmzUHxnqxlvHAZ1yKz0kFdijyEW/rNg
 wdpVzgkCSzAJC27widzJ7/T76zE3kS12elv47pCdESYqWt+laB+vlmIkf1zgRJOIYaTq
 wSnFsmx3/MY/VSvxaUA6HiCgylq8GJT4Opp9+71fHTX9/+ynWQ63Av4H9ymVZsiRdEOR
 Sxh6QwaMo+o7jmUUk9q5EVdeg08C61W2HW+tSHognbc7S8/WxuEFl3fQdJGmYEMfKwUf
 3vxw==
X-Gm-Message-State: AOAM530jMFCqTERD/u5gxyD6xFmgMiXBiZNgEtRFsUqR/o/ZnuYfz3WK
 DT3DkOMv6/13GRwPoHsP3nrS9PAbpZ80wtY6fS5SxTbn8Nbfsdnly1eHHhlLxYOXEh0alMwrs05
 /44QkUR/7mWxxaXGxc80co+gqP0pgmSpUEoWiOgnByA==
X-Received: by 2002:a17:907:1b25:: with SMTP id
 mp37mr20401383ejc.140.1636548829189; 
 Wed, 10 Nov 2021 04:53:49 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzn5NPOygFjffm/bfuj3ZHK0KZf4lB7kWR2MkWgkMO02HRnjld94PSJZzwVE7i8KU7r+5B7IA==
X-Received: by 2002:a17:907:1b25:: with SMTP id
 mp37mr20401345ejc.140.1636548828941; 
 Wed, 10 Nov 2021 04:53:48 -0800 (PST)
Received: from redhat.com ([2.55.133.41])
 by smtp.gmail.com with ESMTPSA id ar2sm2125481ejc.20.2021.11.10.04.53.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 10 Nov 2021 04:53:47 -0800 (PST)
Date: Wed, 10 Nov 2021 07:53:44 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH v4 0/3] virtio support cache indirect desc
Message-ID: <20211110074326-mutt-send-email-mst@kernel.org>
References: <20211108084732-mutt-send-email-mst@kernel.org>
 <1636382860.765897-1-xuanzhuo@linux.alibaba.com>
MIME-Version: 1.0
In-Reply-To: <1636382860.765897-1-xuanzhuo@linux.alibaba.com>
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

On Mon, Nov 08, 2021 at 10:47:40PM +0800, Xuan Zhuo wrote:
> On Mon, 8 Nov 2021 08:49:27 -0500, Michael S. Tsirkin <mst@redhat.com> wrote:
> >
> > Hmm a bunch of comments got ignored. See e.g.
> > https://lore.kernel.org/r/20211027043851-mutt-send-email-mst%40kernel.org
> > if they aren't relevant add code comments or commit log text explaining the
> > design choice please.
> 
> I should have responded to related questions, I am guessing whether some emails
> have been lost.
> 
> I have sorted out the following 6 questions, if there are any missing questions,
> please let me know.
> 
> 1. use list_head
>   In the earliest version, I used pointers directly. You suggest that I use
>   llist_head, but considering that llist_head has atomic operations. There is no
>   competition problem here, so I used list_head.
> 
>   In fact, I did not increase the allocated space for list_head.
> 
>   use as desc array: | vring_desc | vring_desc | vring_desc | vring_desc |
>   use as queue item: | list_head ........................................|

the concern is that you touch many cache lines when removing an entry.

I suggest something like:

llist: add a non-atomic list_del_first

One has to know what one's doing, but if one has locked the list
preventing all accesses, then it's ok to just pop off an entry without
atomics.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

---

diff --git a/include/linux/llist.h b/include/linux/llist.h
index 24f207b0190b..13a47dddb12b 100644
--- a/include/linux/llist.h
+++ b/include/linux/llist.h
@@ -247,6 +247,17 @@ static inline struct llist_node *__llist_del_all(struct llist_head *head)
 
 extern struct llist_node *llist_del_first(struct llist_head *head);
 
+static inline struct llist_node *__llist_del_first(struct llist_head *head)
+{
+	struct llist_node *first = head->first;
+
+	if (!first)
+		return NULL;
+
+	head->first = first->next;
+	return first;
+}
+
 struct llist_node *llist_reverse_order(struct llist_node *head);
 
 #endif /* LLIST_H */


-----


> 2.
> > > +	if (vq->use_desc_cache && total_sg <= VIRT_QUEUE_CACHE_DESC_NUM) {
> > > +		if (vq->desc_cache_chain) {
> > > +			desc = vq->desc_cache_chain;
> > > +			vq->desc_cache_chain = (void *)desc->addr;
> > > +			goto got;
> > > +		}
> > > +		n = VIRT_QUEUE_CACHE_DESC_NUM;
> >
> > Hmm. This will allocate more entries than actually used. Why do it?
> 
> 
> This is because the size of each cache item is fixed, and the logic has been
> modified in the latest code. I think this problem no longer exists.
> 
> 
> 3.
> > What bothers me here is what happens if cache gets
> > filled on one numa node, then used on another?
> 
> I'm thinking about another question, how did the cross-numa appear here, and
> virtio desc queue also has the problem of cross-numa. So is it necessary for us
> to deal with the cross-numa scene?

It's true that desc queue might be cross numa, and people are looking
for ways to improve that. Not a reason to make things worse ...


> Indirect desc is used as virtio desc, so as long as it is in the same numa as
> virito desc. So we can allocate indirect desc cache at the same time when
> allocating virtio desc queue.

Using it from current node like we do now seems better.

> 4.
> > So e.g. for rx, we are wasting memory since indirect isn't used.
> 
> In the current version, desc cache is set up based on pre-queue.
> 
> So if the desc cache is not used, we don't need to set the desc cache.
> 
> For example, virtio-net, as long as the tx queue and the rx queue in big packet
> mode enable desc cache.


I liked how in older versions adding indrect enabled it implicitly
though without need to hack drivers.

> 5.
> > Would a better API be a cache size in bytes? This controls how much
> > memory is spent after all.
> 
> My design is to set a threshold. When total_sg is greater than this threshold,
> it will fall back to kmalloc/kfree. When total_sg is less than or equal to
> this threshold, use the allocated cache.
> 

I know. My question is this, do devices know what a good threshold is?
If yes how do they know?

> 6. kmem_cache_*
> 
> I have tested these, the performance is not as good as the method used in this
> patch.

Do you mean kmem_cache_alloc_bulk/kmem_cache_free_bulk?
You mentioned just kmem_cache_alloc previously.

> 
> Thanks.

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
