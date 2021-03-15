Return-Path: <SRS0=NA0D=IN=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_RED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65812C433DB
	for <virtualization@archiver.kernel.org>; Mon, 15 Mar 2021 09:09:53 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 183E661481
	for <virtualization@archiver.kernel.org>; Mon, 15 Mar 2021 09:09:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 183E661481
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id B169342FB2;
	Mon, 15 Mar 2021 09:09:51 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id behGav2HWuHg; Mon, 15 Mar 2021 09:09:51 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTP id 643554016F;
	Mon, 15 Mar 2021 09:09:50 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 2F7A4C000B;
	Mon, 15 Mar 2021 09:09:50 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id EB5CCC0001
 for <virtualization@lists.linux-foundation.org>;
 Mon, 15 Mar 2021 09:09:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id DE31D49DB8
 for <virtualization@lists.linux-foundation.org>;
 Mon, 15 Mar 2021 09:09:48 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=infradead.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id B6rLmxty7VVJ
 for <virtualization@lists.linux-foundation.org>;
 Mon, 15 Mar 2021 09:09:47 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
 by smtp4.osuosl.org (Postfix) with ESMTPS id F090D48CA9
 for <virtualization@lists.linux-foundation.org>;
 Mon, 15 Mar 2021 09:09:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=a9gg6oJQhPPM7u3VKZMtdQzIuN1q3Wx++payqsoQUyo=; b=mFecxq7ONcsePC6b0VSW3y9V6t
 PVSk5CTm0jpk4ChPtmaYl9/Pwho3AkaNrtLDTUjN8pJaDVS0q9LjQy4FQ4/zNolRtK5KmIkXpYmZG
 glLOI7o2kH5qU0A57FX81pbhx18d8uALXHe1TvXBG00Lj9H/jGkO1ZDUBGseO/2ihCMcY8EYKtHqO
 P5CumkZonUW2+fOXpswXn98pf42x2mXffxiIcICa7g5hKQ6XkWKFWHErwDk51QE7+JF705Wg1geCp
 4miqNpwdhMR1s4jjQJryKg/Br36ZPhbSFwCrN168mt6j75oZ1y22dtOwx4g7e0wW+SADD8jx2I3yn
 kI8DmPiw==;
Received: from hch by casper.infradead.org with local (Exim 4.94 #2 (Red Hat
 Linux)) id 1lLjD4-00HUP1-8A; Mon, 15 Mar 2021 09:08:25 +0000
Date: Mon, 15 Mar 2021 09:08:22 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Xie Yongji <xieyongji@bytedance.com>
Subject: Re: [PATCH v5 01/11] file: Export __receive_fd() to modules
Message-ID: <20210315090822.GA4166677@infradead.org>
References: <20210315053721.189-1-xieyongji@bytedance.com>
 <20210315053721.189-2-xieyongji@bytedance.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210315053721.189-2-xieyongji@bytedance.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 casper.infradead.org. See http://www.infradead.org/rpr.html
Cc: axboe@kernel.dk, corbet@lwn.net, kvm@vger.kernel.org, mst@redhat.com,
 netdev@vger.kernel.org, rdunlap@infradead.org, willy@infradead.org,
 virtualization@lists.linux-foundation.org, hch@infradead.org,
 bob.liu@oracle.com, bcrl@kvack.org, viro@zeniv.linux.org.uk,
 stefanha@redhat.com, linux-fsdevel@vger.kernel.org, dan.carpenter@oracle.com,
 mika.penttila@nextfour.com
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

On Mon, Mar 15, 2021 at 01:37:11PM +0800, Xie Yongji wrote:
> Export __receive_fd() so that some modules can use
> it to pass file descriptor between processes.

I really don't think any non-core code should do that, especilly not
modular mere driver code.
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
