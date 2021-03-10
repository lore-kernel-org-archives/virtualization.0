Return-Path: <SRS0=SHSW=II=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 932DAC433DB
	for <virtualization@archiver.kernel.org>; Wed, 10 Mar 2021 08:37:30 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2EEAA64FC0
	for <virtualization@archiver.kernel.org>; Wed, 10 Mar 2021 08:37:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2EEAA64FC0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id E734543199;
	Wed, 10 Mar 2021 08:37:29 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id A08aiNa_o5PT; Wed, 10 Mar 2021 08:37:29 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTP id 86FA143194;
	Wed, 10 Mar 2021 08:37:28 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 52F54C000A;
	Wed, 10 Mar 2021 08:37:28 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A27E5C0001
 for <virtualization@lists.linux-foundation.org>;
 Wed, 10 Mar 2021 08:37:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 8401C43195
 for <virtualization@lists.linux-foundation.org>;
 Wed, 10 Mar 2021 08:37:27 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id KIImKPl4ZXua
 for <virtualization@lists.linux-foundation.org>;
 Wed, 10 Mar 2021 08:37:27 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
 by smtp2.osuosl.org (Postfix) with ESMTPS id DDC8343194
 for <virtualization@lists.linux-foundation.org>;
 Wed, 10 Mar 2021 08:37:26 +0000 (UTC)
Received: by verein.lst.de (Postfix, from userid 2407)
 id 5F87968B05; Wed, 10 Mar 2021 09:37:23 +0100 (CET)
Date: Wed, 10 Mar 2021 09:37:23 +0100
From: Christoph Hellwig <hch@lst.de>
To: Matthew Wilcox <willy@infradead.org>
Subject: Re: make alloc_anon_inode more useful
Message-ID: <20210310083723.GC5217@lst.de>
References: <20210309155348.974875-1-hch@lst.de>
 <20210310040545.GM3479805@casper.infradead.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210310040545.GM3479805@casper.infradead.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
Cc: Jason Gunthorpe <jgg@nvidia.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 "VMware, Inc." <pv-drivers@vmware.com>, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, virtualization@lists.linux-foundation.org,
 linux-mm@kvack.org, Minchan Kim <minchan@kernel.org>,
 Nadav Amit <namit@vmware.com>, Al Viro <viro@zeniv.linux.org.uk>,
 Daniel Vetter <daniel@ffwll.ch>, linux-fsdevel@vger.kernel.org,
 Andrew Morton <akpm@linux-foundation.org>, linuxppc-dev@lists.ozlabs.org,
 Christoph Hellwig <hch@lst.de>, Nitin Gupta <ngupta@vflare.org>
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

On Wed, Mar 10, 2021 at 04:05:45AM +0000, Matthew Wilcox wrote:
> On Tue, Mar 09, 2021 at 04:53:39PM +0100, Christoph Hellwig wrote:
> > this series first renames the existing alloc_anon_inode to
> > alloc_anon_inode_sb to clearly mark it as requiring a superblock.
> > 
> > It then adds a new alloc_anon_inode that works on the anon_inode
> > file system super block, thus removing tons of boilerplate code.
> > 
> > The few remainig callers of alloc_anon_inode_sb all use alloc_file_pseudo
> > later, but might also be ripe for some cleanup.
> 
> On a somewhat related note, could I get you to look at
> drivers/video/fbdev/core/fb_defio.c?
> 
> As far as I can tell, there's no need for fb_deferred_io_aops to exist.
> We could just set file->f_mapping->a_ops to NULL, and set_page_dirty()
> would do the exact same thing this code does (except it would get the
> return value correct).

> But maybe that would make something else go wrong that distinguishes
> between page->mapping being NULL and page->mapping->a_ops->foo being NULL?

I can't find any place in the kernel that treats a NULL aops different
from not having the method it is looking for. 

> Completely untested patch ...

the patch looks mostly good to me.

>  	}
> -#ifdef CONFIG_FB_DEFERRED_IO
> -	if (info->fbdefio)
> -		fb_deferred_io_open(info, inode, file);
> -#endif
> +	file->f_mapping->a_ops = NULL;

But I'd also skip this.  Drivers generally do not set aops, but if they
do a funtion like this really should not override it.  This will require
an audit of the callers, though.
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
