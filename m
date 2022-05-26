Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53F8AC433EF
	for <virtualization@archiver.kernel.org>; Thu, 26 May 2022 14:28:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id DF2A0843D1;
	Thu, 26 May 2022 14:28:50 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 0cw16WVuCM_z; Thu, 26 May 2022 14:28:50 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 8E35B842E7;
	Thu, 26 May 2022 14:28:49 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 4EC24C0039;
	Thu, 26 May 2022 14:28:49 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 170A3C002D
 for <virtualization@lists.linux-foundation.org>;
 Thu, 26 May 2022 14:28:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 06482842E7
 for <virtualization@lists.linux-foundation.org>;
 Thu, 26 May 2022 14:28:48 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id m5Gkkorjue8B
 for <virtualization@lists.linux-foundation.org>;
 Thu, 26 May 2022 14:28:46 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from casper.infradead.org (casper.infradead.org
 [IPv6:2001:8b0:10b:1236::1])
 by smtp1.osuosl.org (Postfix) with ESMTPS id B86D4842C9
 for <virtualization@lists.linux-foundation.org>;
 Thu, 26 May 2022 14:28:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=k7apNoi1g1YhGHKMlKvo5ejDwWGQrfqPL3Ty5xTWm5Q=; b=jt2D3c7xgVZUKhGsBafhmm2sFE
 7iHXpIRdAmkRqKCTrByt8vvIu4Y3EGktUCpnmPTFxq5LEtvIgLU7neTQ7C/IsI99LeEY7HaXKuYy7
 5ZrEicxpMCl0i/enkPZwHxhNQ3wSCLz0PWMpopuxkJst9ua3Mey2ATEpeisJ/smtNzknhVcxsQdkT
 dSKtJhfNJpH19fcWEk13NeBfTP6RD6LPE68nShdvuaPUklK12w19DAh/i1OVAzpUZ0A5rCLZKasUp
 WeWqziAdu0JgzoPn8WlmbMtIWF1JBvKksSw7KZdNfdrklRu0O6zxydJrgJF+gvKG7sfmTWPCyIS6G
 yc+jDrmg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red
 Hat Linux)) id 1nuETR-001JAt-Fo; Thu, 26 May 2022 14:28:25 +0000
Date: Thu, 26 May 2022 15:28:25 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Dan Carpenter <dan.carpenter@oracle.com>
Subject: Re: [linux-next:master] BUILD REGRESSION
 8cb8311e95e3bb58bd84d6350365f14a718faa6d
Message-ID: <Yo+OiR6abzVksVTM@casper.infradead.org>
References: <628ea118.wJYf60YnZco0hs9o%lkp@intel.com>
 <20220525145056.953631743a4c494aabf000dc@linux-foundation.org>
 <F0E25DFF-8256-48FF-8B88-C0E3730A3E5E@jrtc27.com>
 <20220525152006.e87d3fa50aca58fdc1b43b6a@linux-foundation.org>
 <Yo7U8kglHlcvQ0Ri@casper.infradead.org>
 <20220526084832.GC2146@kadam>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220526084832.GC2146@kadam>
Cc: alsa-devel@alsa-project.org, linux-fbdev@vger.kernel.org,
 kernel test robot <lkp@intel.com>, kvm@vger.kernel.org,
 linux-rdma@vger.kernel.org, netdev@vger.kernel.org,
 linux-staging@lists.linux.dev, bpf@vger.kernel.org,
 dri-devel@lists.freedesktop.org, virtualization@lists.linux-foundation.org,
 linux-mm@kvack.org, amd-gfx@lists.freedesktop.org, linux-pci@vger.kernel.org,
 Andrew Morton <akpm@linux-foundation.org>, linux-omap@vger.kernel.org,
 Jessica Clarke <jrtc27@jrtc27.com>, linux-riscv@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org, linux-parport@lists.infradead.org
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

On Thu, May 26, 2022 at 11:48:32AM +0300, Dan Carpenter wrote:
> On Thu, May 26, 2022 at 02:16:34AM +0100, Matthew Wilcox wrote:
> > Bizarre this started showing up now.  The recent patch was:
> > 
> > -       info->alloced += compound_nr(page);
> > -       inode->i_blocks += BLOCKS_PER_PAGE << compound_order(page);
> > +       info->alloced += folio_nr_pages(folio);
> > +       inode->i_blocks += BLOCKS_PER_PAGE << folio_order(folio);
> > 
> > so it could tell that compound_order() was small, but folio_order()
> > might be large?
> 
> The old code also generates a warning on my test system.  Smatch thinks
> both compound_order() and folio_order() are 0-255.  I guess because of
> the "unsigned char compound_order;" in the struct page.

It'd be nice if we could annotate that as "contains a value between
1 and BITS_PER_LONG - PAGE_SHIFT".  Then be able to optionally enable
a checker that ensures that's true on loads/stores.  Maybe we need a
language that isn't C :-P  Ada can do this ... I don't think Rust can.
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
