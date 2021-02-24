Return-Path: <SRS0=cI1G=H2=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0930BC433E0
	for <virtualization@archiver.kernel.org>; Wed, 24 Feb 2021 18:56:09 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 451EA64E90
	for <virtualization@archiver.kernel.org>; Wed, 24 Feb 2021 18:56:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 451EA64E90
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id C65AD83EC0;
	Wed, 24 Feb 2021 18:56:07 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id R2b-2Kz20gaL; Wed, 24 Feb 2021 18:56:06 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTP id 7F31483EBA;
	Wed, 24 Feb 2021 18:56:05 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 51B78C000A;
	Wed, 24 Feb 2021 18:56:05 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0E0D3C0001
 for <virtualization@lists.linux-foundation.org>;
 Wed, 24 Feb 2021 18:56:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id E7CD06F6A8
 for <virtualization@lists.linux-foundation.org>;
 Wed, 24 Feb 2021 18:56:02 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=infradead.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Y7xzXpVxNJst
 for <virtualization@lists.linux-foundation.org>;
 Wed, 24 Feb 2021 18:56:01 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
 by smtp3.osuosl.org (Postfix) with ESMTPS id D3C116F69F
 for <virtualization@lists.linux-foundation.org>;
 Wed, 24 Feb 2021 18:56:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=aSmBycH0uJ6bas2Xybb1KrzwdkDReh73b+85qbDRdQ4=; b=wDrxERWdH7aSgsyr5QwIDqAZ9y
 oImtMcG8bftvnoTIalKWfhjsmoeEQiczbkbMnhBawibN5m3IZe+Ezn0jI0b3N7tECV/3HeXJAnUYd
 W8o5Q+tHmoAEZcP7sSK80cahp6xqAHvfIjb4bN8Ah047kgyT5ZhaNeG0/jPTWlSqKyBU7etOCLtYN
 UuRrWoJkFf/F6dQlZwdj9eyXoEsDUO4A6dKqDRIppjs9lgVMTw9xvCOlkTv9PjwkBjqGkds7hfBnX
 k9uCfpbd5dSsERxkH6+KjD/pI/UT/wx5E8492nwTdjwfaMfUvAVVXreaqY7SB/05ZO8+FYmcicczo
 a0ns1/qg==;
Received: from hch by casper.infradead.org with local (Exim 4.94 #2 (Red Hat
 Linux)) id 1lEzJh-009lGy-25; Wed, 24 Feb 2021 18:55:26 +0000
Date: Wed, 24 Feb 2021 18:55:21 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Jens Axboe <axboe@kernel.dk>
Subject: Re: [RFC PATCH] blk-core: remove blk_put_request()
Message-ID: <20210224185521.GA2326119@infradead.org>
References: <20210222211115.30416-1-chaitanya.kulkarni@wdc.com>
 <YDY+ObNNiBMMuSEt@stefanha-x1.localdomain>
 <f3141eb3-9938-a216-a9f8-cb193589a657@kernel.dk>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <f3141eb3-9938-a216-a9f8-cb193589a657@kernel.dk>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 casper.infradead.org. See http://www.infradead.org/rpr.html
Cc: snitzer@redhat.com, mst@redhat.com,
 virtualization@lists.linux-foundation.org, bfields@fieldses.org,
 linux-ide@vger.kernel.org, dm-devel@redhat.com, target-devel@vger.kernel.org,
 alim.akhtar@samsung.com, agk@redhat.com, beanhuo@micron.com,
 stanley.chu@mediatek.com, linux-scsi@vger.kernel.org, cang@codeaurora.org,
 tim@cyberelk.net, dgilbert@interlog.com, vbadigan@codeaurora.org,
 richard.peng@oppo.com, Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>,
 jejb@linux.ibm.com, linux-block@vger.kernel.org, avri.altman@wdc.com,
 bp@alien8.de, Stefan Hajnoczi <stefanha@redhat.com>, jaegeuk@kernel.org,
 Kai.Makisara@kolumbus.fi, linux-nfs@vger.kernel.org,
 martin.petersen@oracle.com, baolin.wang@linaro.org, linux-mmc@vger.kernel.org,
 linux-kernel@vger.kernel.org, fujita.tomonori@lab.ntt.co.jp,
 chuck.lever@oracle.com, zliua@micron.com, pbonzini@redhat.com,
 davem@davemloft.net, asutoshd@codeaurora.org
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

On Wed, Feb 24, 2021 at 09:48:21AM -0700, Jens Axboe wrote:
> Would make sense to rename blk_get_request() to blk_mq_alloc_request()
> and then we have API symmetry. The get/put don't make sense when there
> are no references involved.
> 
> But it's a lot of churn for very little reward, which is always kind
> of annoying. Especially for the person that has to carry the patches.

Let's do the following:

 - move the initialize_rq_fn call from blk_get_request into
   blk_mq_alloc_request and make the former a trivial alias for the
   latter
 - migrate to the blk_mq_* versions on a per-driver/subsystem basis.
   The scsi migration depends on the first item above, so it will have
   to go with that or wait for the next merge window
 - don't migrate the legacy ide driver, as it is about to be removed and
   has a huge number of blk_get_request calls
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
