Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D1F5C433EF
	for <virtualization@archiver.kernel.org>; Thu, 26 May 2022 01:16:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id DBFAB41D6B;
	Thu, 26 May 2022 01:16:55 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id xs2l7B8ZGwTS; Thu, 26 May 2022 01:16:54 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 9AF6B41D60;
	Thu, 26 May 2022 01:16:53 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 7C212C0032;
	Thu, 26 May 2022 01:16:53 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 42E85C002D
 for <virtualization@lists.linux-foundation.org>;
 Thu, 26 May 2022 01:16:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 2B76B41D60
 for <virtualization@lists.linux-foundation.org>;
 Thu, 26 May 2022 01:16:52 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id HYpu-P-BCzNV
 for <virtualization@lists.linux-foundation.org>;
 Thu, 26 May 2022 01:16:50 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from casper.infradead.org (casper.infradead.org
 [IPv6:2001:8b0:10b:1236::1])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 3FF3A41D4A
 for <virtualization@lists.linux-foundation.org>;
 Thu, 26 May 2022 01:16:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=qYg8IKyL/r8f2Vg1ESuYjuOnE5g2jafpU06hhSyNUpw=; b=FU/B4l/86GX2mfAVzdnOZlet7o
 4YIMhkZpbCoSmgTvSZ+0srZ6BwOG40pWCCMj19qhaZ7LyhuSaw2+YdDV5a6+88avQFq2cWdQHfPWr
 byuXc0vT/MGU7fDuPvzVefIP3U6jrYIpaAmCNdJioEzp88SsKae4gtRxxjsbwJwKjR30fWyrk6jS+
 6N+w+qBIVJaEKMA2SIN/QJXQZdAFNIwoALKz9JWYzo9WKGMkqQ+rWdT359dIGkZ8Sy1ZcS2tNgQxZ
 uFqnsZqHJyvAVlUVWnv0GfWFHqg8A7Yfpa485ULCi1tDMGcQd2T2bgnhjP4//0FFa8Q9P8q43x6cS
 bXqNJBtA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red
 Hat Linux)) id 1nu278-000pxs-VA; Thu, 26 May 2022 01:16:35 +0000
Date: Thu, 26 May 2022 02:16:34 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [linux-next:master] BUILD REGRESSION
 8cb8311e95e3bb58bd84d6350365f14a718faa6d
Message-ID: <Yo7U8kglHlcvQ0Ri@casper.infradead.org>
References: <628ea118.wJYf60YnZco0hs9o%lkp@intel.com>
 <20220525145056.953631743a4c494aabf000dc@linux-foundation.org>
 <F0E25DFF-8256-48FF-8B88-C0E3730A3E5E@jrtc27.com>
 <20220525152006.e87d3fa50aca58fdc1b43b6a@linux-foundation.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220525152006.e87d3fa50aca58fdc1b43b6a@linux-foundation.org>
Cc: linux-fbdev@vger.kernel.org, kernel test robot <lkp@intel.com>,
 kvm@vger.kernel.org, linux-rdma@vger.kernel.org, netdev@vger.kernel.org,
 linux-staging@lists.linux.dev, alsa-devel@alsa-project.org,
 dri-devel@lists.freedesktop.org, virtualization@lists.linux-foundation.org,
 linux-mm@kvack.org, amd-gfx@lists.freedesktop.org, linux-pci@vger.kernel.org,
 linux-riscv@lists.infradead.org, linux-omap@vger.kernel.org,
 Jessica Clarke <jrtc27@jrtc27.com>, bpf@vger.kernel.org,
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

On Wed, May 25, 2022 at 03:20:06PM -0700, Andrew Morton wrote:
> On Wed, 25 May 2022 23:07:35 +0100 Jessica Clarke <jrtc27@jrtc27.com> wrote:
> 
> > This is i386, so an unsigned long is 32-bit, but i_blocks is a blkcnt_t
> > i.e. a u64, which makes the shift without a cast of the LHS fishy.
> 
> Ah, of course, thanks.  I remember 32 bits ;)
> 
> --- a/mm/shmem.c~mm-shmemc-suppress-shift-warning
> +++ a/mm/shmem.c
> @@ -1945,7 +1945,7 @@ alloc_nohuge:
>  
>  	spin_lock_irq(&info->lock);
>  	info->alloced += folio_nr_pages(folio);
> -	inode->i_blocks += BLOCKS_PER_PAGE << folio_order(folio);
> +	inode->i_blocks += (blkcnt_t)BLOCKS_PER_PAGE << folio_order(folio);

Bizarre this started showing up now.  The recent patch was:

-       info->alloced += compound_nr(page);
-       inode->i_blocks += BLOCKS_PER_PAGE << compound_order(page);
+       info->alloced += folio_nr_pages(folio);
+       inode->i_blocks += BLOCKS_PER_PAGE << folio_order(folio);

so it could tell that compound_order() was small, but folio_order()
might be large?

Silencing the warning is a good thing, but folio_order() can (at the
moment) be at most 9 on i386, so it isn't actually going to be
larger than 4096.
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
