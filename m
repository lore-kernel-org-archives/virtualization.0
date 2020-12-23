Return-Path: <SRS0=+X4x=F3=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FA3EC433E0
	for <virtualization@archiver.kernel.org>; Wed, 23 Dec 2020 08:13:44 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A384322482
	for <virtualization@archiver.kernel.org>; Wed, 23 Dec 2020 08:13:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A384322482
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 476D785D54;
	Wed, 23 Dec 2020 08:13:43 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id GEh5oHQ70CfT; Wed, 23 Dec 2020 08:13:42 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id A7BCA85D7D;
	Wed, 23 Dec 2020 08:13:42 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 89729C1787;
	Wed, 23 Dec 2020 08:13:42 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 8FA39C0893
 for <virtualization@lists.linux-foundation.org>;
 Wed, 23 Dec 2020 08:13:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 7E50C86773
 for <virtualization@lists.linux-foundation.org>;
 Wed, 23 Dec 2020 08:13:41 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id IhWAnsEJ7mnL
 for <virtualization@lists.linux-foundation.org>;
 Wed, 23 Dec 2020 08:13:40 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 73BE78676E
 for <virtualization@lists.linux-foundation.org>;
 Wed, 23 Dec 2020 08:13:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=9mT6ehxNEt1jUz3TfJecdTTXQ2Ih2qfV3QTcUD44O04=; b=JPB0a4t7K8WEKPQv3hVXh7yGzq
 9wAt2jVARSqPuaCHW+1jygDtQ11enIvosGCFjiLDVmuSCI8gUnDAxJtkTlAzV5L94gaz7Nlurb6om
 yHj7+cinD8X0Hx0hjLaW/sFbtlTe5TqGuH4hTiPGacWQ8228r7/V1ZR7RvvW/gervcVRB6cU7hP9j
 8Ye+VK76pyC3CaL4DQ/AVEiAzsuPUIrmQTmCmkIqWzDKIiHn5tTplGa0VeBlmQNf2yjzl2DdKFAXy
 p/0B807UKBAiXZohjVUCLoOmCQL5L6j1HusyL4nlAeQapxfq2STMvgRXEPAa76V5nNERvvE7Y7T2U
 AR6qBiNQ==;
Received: from hch by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat
 Linux)) id 1krzGu-0005kz-5Q; Wed, 23 Dec 2020 08:13:24 +0000
Date: Wed, 23 Dec 2020 08:13:24 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Yongji Xie <xieyongji@bytedance.com>
Subject: Re: [RFC v2 01/13] mm: export zap_page_range() for driver use
Message-ID: <20201223081324.GA21558@infradead.org>
References: <CACycT3vevQQ8cGK_ac-1oyCb9+YPSAhLMue=4J3=2HzXVK7XHw@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CACycT3vevQQ8cGK_ac-1oyCb9+YPSAhLMue=4J3=2HzXVK7XHw@mail.gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 casper.infradead.org. See http://www.infradead.org/rpr.html
Cc: axboe@kernel.dk, corbet@lwn.net, kvm@vger.kernel.org,
 "Michael S. Tsirkin" <mst@redhat.com>, linux-aio@kvack.org,
 netdev@vger.kernel.org, Randy Dunlap <rdunlap@infradead.org>,
 Matthew Wilcox <willy@infradead.org>,
 virtualization@lists.linux-foundation.org,
 Christoph Hellwig <hch@infradead.org>, linux-mm@kvack.org, bcrl@kvack.org,
 viro@zeniv.linux.org.uk, Stefan Hajnoczi <stefanha@redhat.com>,
 linux-fsdevel@vger.kernel.org, akpm@linux-foundation.org
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

On Wed, Dec 23, 2020 at 02:32:07PM +0800, Yongji Xie wrote:
> Now I want to map/unmap some pages in an userland vma dynamically. The
> vm_insert_page() is being used for mapping. In the unmapping case, it
> looks like the zap_page_range() does what I want. So I export it.
> Otherwise, we need some ways to notify userspace to trigger it with
> madvise(MADV_DONTNEED), which might not be able to meet all our needs.
> For example, unmapping some pages in a memory shrinker function.
> 
> So I'd like to know what's the limitation to use zap_page_range() in a
> module. And if we can't use it in a module, is there any acceptable
> way to achieve that?

I think the anser is: don't play funny games with unmapped outside of
munmap.  Especially as synchronization is very hard to get right.
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
