Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 048FFC43334
	for <virtualization@archiver.kernel.org>; Thu,  9 Jun 2022 17:40:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id A456E40AA0;
	Thu,  9 Jun 2022 17:40:57 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id h_NJMSccVKSg; Thu,  9 Jun 2022 17:40:57 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 5334640A99;
	Thu,  9 Jun 2022 17:40:56 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 284CDC0032;
	Thu,  9 Jun 2022 17:40:56 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 73B39C002D
 for <virtualization@lists.linux-foundation.org>;
 Thu,  9 Jun 2022 17:40:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 61F5461105
 for <virtualization@lists.linux-foundation.org>;
 Thu,  9 Jun 2022 17:40:53 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=infradead.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ubAt8UBeSgmC
 for <virtualization@lists.linux-foundation.org>;
 Thu,  9 Jun 2022 17:40:51 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from casper.infradead.org (casper.infradead.org
 [IPv6:2001:8b0:10b:1236::1])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 5C46C60F5C
 for <virtualization@lists.linux-foundation.org>;
 Thu,  9 Jun 2022 17:40:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
 References:Message-ID:Subject:To:From:Date:Sender:Reply-To:Cc:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=50LH8Dogtui4JOE7bz/ojMzo0HRhZGWl5FgghUdbsso=; b=H80hSPNqGiAd5chM6yyxpXe7GI
 v16rR9GPk1lsBvZCxGkkfPwwIt580VMmgSt7/ZwfufekJhmrwARChvfRps5Isb2jo31hImz/J8zhg
 3Gqid/DHTzlBHrEnpsHq7tbmdB6lizbSwvMg1psBh47cB986OJv32t09q9JTTsGSl5f5sM+mUmbDC
 kBxIqffET9U+LDZy+bNXjBWIq4ozQI6dP3A/jTcDrHF2DBz9xSzltFjBNcK5NRZczIeDZyfqJ8lJf
 qfewZREEYM3aHIjRrfEfYKtBKEBJRQ6UywKBfP0QJhwiV/qPmGd6+tb1EV1S0HSjXDX6WidFPIyNN
 +S04cl5w==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red
 Hat Linux)) id 1nzM8y-00DjCy-V3; Thu, 09 Jun 2022 17:40:28 +0000
Date: Thu, 9 Jun 2022 18:40:28 +0100
From: Matthew Wilcox <willy@infradead.org>
To: dsterba@suse.cz, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
 linux-aio@kvack.org, linux-btrfs@vger.kernel.org,
 linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 cluster-devel@redhat.com, linux-mm@kvack.org,
 linux-xfs@vger.kernel.org, linux-nfs@vger.kernel.org,
 linux-ntfs-dev@lists.sourceforge.net, ocfs2-devel@oss.oracle.com,
 linux-mtd@lists.infradead.org, virtualization@lists.linux-foundation.org,
 Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v2 12/19] btrfs: Convert btrfs_migratepage to migrate_folio
Message-ID: <YqIwjEO1a0Sbxbym@casper.infradead.org>
References: <20220608150249.3033815-1-willy@infradead.org>
 <20220608150249.3033815-13-willy@infradead.org>
 <20220609163323.GV20633@twin.jikos.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220609163323.GV20633@twin.jikos.cz>
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

On Thu, Jun 09, 2022 at 06:33:23PM +0200, David Sterba wrote:
> On Wed, Jun 08, 2022 at 04:02:42PM +0100, Matthew Wilcox (Oracle) wrote:
> > Use filemap_migrate_folio() to do the bulk of the work, and then copy
> > the ordered flag across if needed.
> > 
> > Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> > Reviewed-by: Christoph Hellwig <hch@lst.de>
> 
> Acked-by: David Sterba <dsterba@suse.com>
> 
> > +static int btrfs_migrate_folio(struct address_space *mapping,
> > +			     struct folio *dst, struct folio *src,
> >  			     enum migrate_mode mode)
> >  {
> > -	int ret;
> > +	int ret = filemap_migrate_folio(mapping, dst, src, mode);
> >  
> > -	ret = migrate_page_move_mapping(mapping, newpage, page, 0);
> >  	if (ret != MIGRATEPAGE_SUCCESS)
> >  		return ret;
> >  
> > -	if (page_has_private(page))
> > -		attach_page_private(newpage, detach_page_private(page));
> 
> If I'm reading it correctly, the private pointer does not need to be set
> like that anymore because it's done somewhere during the
> filemap_migrate_folio() call.

That's correct.  Everything except moving the ordered flag across is
done for you, and I'm kind of tempted to modify folio_migrate_flags()
to copy the ordered flag across as well.  Then you could just use
filemap_migrate_folio() directly.

> > -
> > -	if (PageOrdered(page)) {
> > -		ClearPageOrdered(page);
> > -		SetPageOrdered(newpage);
> > +	if (folio_test_ordered(src)) {
> > +		folio_clear_ordered(src);
> > +		folio_set_ordered(dst);
> >  	}
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
