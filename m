Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AEDE3C43217
	for <virtualization@archiver.kernel.org>; Wed, 24 Nov 2021 06:36:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 13A3D401A1;
	Wed, 24 Nov 2021 06:36:15 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id w1yQEbWEEHzk; Wed, 24 Nov 2021 06:36:14 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 87F7840003;
	Wed, 24 Nov 2021 06:36:13 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 5F92AC001E;
	Wed, 24 Nov 2021 06:36:13 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 60208C0012
 for <virtualization@lists.linux-foundation.org>;
 Wed, 24 Nov 2021 06:36:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 3292A60B30
 for <virtualization@lists.linux-foundation.org>;
 Wed, 24 Nov 2021 06:36:12 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id cucyOWfu5F-6
 for <virtualization@lists.linux-foundation.org>;
 Wed, 24 Nov 2021 06:36:11 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 3564F60B00
 for <virtualization@lists.linux-foundation.org>;
 Wed, 24 Nov 2021 06:36:10 +0000 (UTC)
Received: by verein.lst.de (Postfix, from userid 2407)
 id C659668AFE; Wed, 24 Nov 2021 07:36:05 +0100 (CET)
Date: Wed, 24 Nov 2021 07:36:05 +0100
From: Christoph Hellwig <hch@lst.de>
To: "Darrick J. Wong" <djwong@kernel.org>
Subject: Re: [PATCH 06/29] dax: move the partition alignment check into
 fs_dax_get_by_bdev
Message-ID: <20211124063605.GA6889@lst.de>
References: <20211109083309.584081-1-hch@lst.de>
 <20211109083309.584081-7-hch@lst.de> <20211123222555.GE266024@magnolia>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20211123222555.GE266024@magnolia>
User-Agent: Mutt/1.5.17 (2007-11-01)
Cc: nvdimm@lists.linux.dev, Mike Snitzer <snitzer@redhat.com>,
 linux-s390@vger.kernel.org, linux-erofs@lists.ozlabs.org,
 virtualization@lists.linux-foundation.org, linux-xfs@vger.kernel.org,
 dm-devel@redhat.com, linux-fsdevel@vger.kernel.org,
 Dan Williams <dan.j.williams@intel.com>, linux-ext4@vger.kernel.org,
 Ira Weiny <ira.weiny@intel.com>, Christoph Hellwig <hch@lst.de>
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

On Tue, Nov 23, 2021 at 02:25:55PM -0800, Darrick J. Wong wrote:
> > +	if ((get_start_sect(bdev) * SECTOR_SIZE) % PAGE_SIZE ||
> > +	    (bdev_nr_sectors(bdev) * SECTOR_SIZE) % PAGE_SIZE) {
> 
> Do we have to be careful about 64-bit division here, or do we not
> support DAX on 32-bit?

I can't find anything in the Kconfig limiting DAX to 32-bit.  But
then again the existing code has divisions like this, so the compiler
is probably smart enough to turn them into shifts.

> > +		pr_info("%pg: error: unaligned partition for dax\n", bdev);
> 
> I also wonder if this should be ratelimited...?

This happens once (or maybe three times for XFS with rt and log devices)
at mount time, so I see no need for a ratelimit.
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
