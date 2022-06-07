Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CEF30C433EF
	for <virtualization@archiver.kernel.org>; Tue,  7 Jun 2022 14:24:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 8B05C424A0;
	Tue,  7 Jun 2022 14:24:33 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Z3bxQDOukZQ7; Tue,  7 Jun 2022 14:24:32 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id D462D4248F;
	Tue,  7 Jun 2022 14:24:31 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B30B5C0032;
	Tue,  7 Jun 2022 14:24:31 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 02358C002D
 for <virtualization@lists.linux-foundation.org>;
 Tue,  7 Jun 2022 14:24:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id D652240B9F
 for <virtualization@lists.linux-foundation.org>;
 Tue,  7 Jun 2022 14:24:28 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=infradead.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id vbquTIvj9186
 for <virtualization@lists.linux-foundation.org>;
 Tue,  7 Jun 2022 14:24:28 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from casper.infradead.org (casper.infradead.org
 [IPv6:2001:8b0:10b:1236::1])
 by smtp2.osuosl.org (Postfix) with ESMTPS id D801A40A9A
 for <virtualization@lists.linux-foundation.org>;
 Tue,  7 Jun 2022 14:24:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=TMQU2bbtV5kjI1Y7uBOgpmsi6MujvLdf4se1f0ultbQ=; b=T3tONSSZEZI3TnW91MAPGKwqdn
 ynmJAoI6mOfrbbq8Jqf2czJGvi9Q0ukvLmmikcGSI8ZqHSwvRkTwLUTylDBqG6RaX8/3fM9Nvve4c
 VqFvCNQX2J5+bZcWx69Xcxl0FnIF/+ozKW4FHlSZHfTn6FEQTfoWOYo1nVdtg5lJcedIUJr0ygYNv
 BxeGZpOaFU4iqywNAUPFsAq2KhxI0Hbg9OXTdHy26nItEezSSsuIGEVlhH9A3QRH3TI9Fv56fknf8
 0pc9AkwczXake1fj6Qt6cCxOadkgaG3Xkumb8mMGujy60/hhxbEX20y0v48fX/CV/o6oaLLnenmYd
 w0xneMdA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red
 Hat Linux)) id 1nya7z-00BhZy-2Z; Tue, 07 Jun 2022 14:24:15 +0000
Date: Tue, 7 Jun 2022 15:24:15 +0100
From: Matthew Wilcox <willy@infradead.org>
To: David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH 15/20] balloon: Convert to migrate_folio
Message-ID: <Yp9fj/Si2qyb61Y3@casper.infradead.org>
References: <20220606204050.2625949-1-willy@infradead.org>
 <20220606204050.2625949-16-willy@infradead.org>
 <e4d017a4-556d-bb5f-9830-a8843591bc8d@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <e4d017a4-556d-bb5f-9830-a8843591bc8d@redhat.com>
Cc: linux-aio@kvack.org, linux-nfs@vger.kernel.org, cluster-devel@redhat.com,
 linux-ntfs-dev@lists.sourceforge.net, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, linux-block@vger.kernel.org,
 linux-mm@kvack.org, linux-mtd@lists.infradead.org, ocfs2-devel@oss.oracle.com,
 linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
 virtualization@lists.linux-foundation.org, linux-xfs@vger.kernel.org,
 linux-btrfs@vger.kernel.org
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

On Tue, Jun 07, 2022 at 09:36:21AM +0200, David Hildenbrand wrote:
> On 06.06.22 22:40, Matthew Wilcox (Oracle) wrote:
> >  const struct address_space_operations balloon_aops = {
> > -	.migratepage = balloon_page_migrate,
> > +	.migrate_folio = balloon_migrate_folio,
> >  	.isolate_page = balloon_page_isolate,
> >  	.putback_page = balloon_page_putback,
> >  };
> 
> I assume you're working on conversion of the other callbacks as well,
> because otherwise, this ends up looking a bit inconsistent and confusing :)

My intention was to finish converting aops for the next merge window.

However, it seems to me that we goofed back in 2016 by merging
commit bda807d44454.  isolate_page() and putback_page() should
never have been part of address_space_operations.

I'm about to embark on creating a new migrate_operations struct
for drivers to use that contains only isolate/putback/migrate.
No filesystem uses isolate/putback, so those can just be deleted.
Both migrate_operations & address_space_operations will contain a
migrate callback.
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
