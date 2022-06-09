Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 632AECCA47D
	for <virtualization@archiver.kernel.org>; Thu,  9 Jun 2022 16:38:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id EEE9761102;
	Thu,  9 Jun 2022 16:38:00 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 2Fm1p0edyYYo; Thu,  9 Jun 2022 16:37:59 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 02BA361080;
	Thu,  9 Jun 2022 16:37:58 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B79F2C0039;
	Thu,  9 Jun 2022 16:37:58 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id F00D6C002D
 for <virtualization@lists.linux-foundation.org>;
 Thu,  9 Jun 2022 16:37:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id D6F8241A16
 for <virtualization@lists.linux-foundation.org>;
 Thu,  9 Jun 2022 16:37:57 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=suse.cz header.b="b2KEX6ZC";
 dkim=neutral reason="invalid (unsupported algorithm ed25519-sha256)"
 header.d=suse.cz header.b="Irv56z+I"
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ciK8t3mnQe3d
 for <virtualization@lists.linux-foundation.org>;
 Thu,  9 Jun 2022 16:37:57 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 0798E4195B
 for <virtualization@lists.linux-foundation.org>;
 Thu,  9 Jun 2022 16:37:56 +0000 (UTC)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 65EBB1FECD;
 Thu,  9 Jun 2022 16:37:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1654792674;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=zfYT+PR9lXha9hYJlMd2oONaI1SUc3WGC1Bck/G8ec0=;
 b=b2KEX6ZCINZeKoHTynlrz3FMDUbnVbIkotULQQM8wta+qakmo0wc5ILD3yfYynBGt8D1yz
 HYV/+JhfacH7KcZ34tTxnGAMq0+073DU9INO4NM3aBmmmH1cmHo9hWrrTnPyGWxZmapSer
 hIaGVqCWyAZ99ysi+fFP8RhgxxrPFtk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1654792674;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=zfYT+PR9lXha9hYJlMd2oONaI1SUc3WGC1Bck/G8ec0=;
 b=Irv56z+I7t/5vmpdqARm0xsfrzoUND1o/lJUqjcW0uNId73f8zXP/st70yGmLiPVj3W5Qe
 j8Fgd9g+H7+p0iCw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id E9F2713A8C;
 Thu,  9 Jun 2022 16:37:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id sFfPN+EhomK4KAAAMHmgww
 (envelope-from <dsterba@suse.cz>); Thu, 09 Jun 2022 16:37:53 +0000
Date: Thu, 9 Jun 2022 18:33:23 +0200
From: David Sterba <dsterba@suse.cz>
To: "Matthew Wilcox (Oracle)" <willy@infradead.org>
Subject: Re: [PATCH v2 12/19] btrfs: Convert btrfs_migratepage to migrate_folio
Message-ID: <20220609163323.GV20633@twin.jikos.cz>
Mail-Followup-To: dsterba@suse.cz,
 "Matthew Wilcox (Oracle)" <willy@infradead.org>,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-block@vger.kernel.org, linux-aio@kvack.org,
 linux-btrfs@vger.kernel.org, linux-ext4@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, cluster-devel@redhat.com,
 linux-mm@kvack.org, linux-xfs@vger.kernel.org,
 linux-nfs@vger.kernel.org, linux-ntfs-dev@lists.sourceforge.net,
 ocfs2-devel@oss.oracle.com, linux-mtd@lists.infradead.org,
 virtualization@lists.linux-foundation.org,
 Christoph Hellwig <hch@lst.de>
References: <20220608150249.3033815-1-willy@infradead.org>
 <20220608150249.3033815-13-willy@infradead.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220608150249.3033815-13-willy@infradead.org>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Cc: linux-aio@kvack.org, linux-nfs@vger.kernel.org, cluster-devel@redhat.com,
 linux-ntfs-dev@lists.sourceforge.net, Christoph Hellwig <hch@lst.de>,
 linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 linux-block@vger.kernel.org, linux-mm@kvack.org, linux-mtd@lists.infradead.org,
 ocfs2-devel@oss.oracle.com, linux-fsdevel@vger.kernel.org,
 linux-ext4@vger.kernel.org, virtualization@lists.linux-foundation.org,
 linux-xfs@vger.kernel.org, linux-btrfs@vger.kernel.org
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
Reply-To: dsterba@suse.cz
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

On Wed, Jun 08, 2022 at 04:02:42PM +0100, Matthew Wilcox (Oracle) wrote:
> Use filemap_migrate_folio() to do the bulk of the work, and then copy
> the ordered flag across if needed.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> Reviewed-by: Christoph Hellwig <hch@lst.de>

Acked-by: David Sterba <dsterba@suse.com>

> +static int btrfs_migrate_folio(struct address_space *mapping,
> +			     struct folio *dst, struct folio *src,
>  			     enum migrate_mode mode)
>  {
> -	int ret;
> +	int ret = filemap_migrate_folio(mapping, dst, src, mode);
>  
> -	ret = migrate_page_move_mapping(mapping, newpage, page, 0);
>  	if (ret != MIGRATEPAGE_SUCCESS)
>  		return ret;
>  
> -	if (page_has_private(page))
> -		attach_page_private(newpage, detach_page_private(page));

If I'm reading it correctly, the private pointer does not need to be set
like that anymore because it's done somewhere during the
filemap_migrate_folio() call.

> -
> -	if (PageOrdered(page)) {
> -		ClearPageOrdered(page);
> -		SetPageOrdered(newpage);
> +	if (folio_test_ordered(src)) {
> +		folio_clear_ordered(src);
> +		folio_set_ordered(dst);
>  	}
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
