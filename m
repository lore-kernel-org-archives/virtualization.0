Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2AE9CC433EF
	for <virtualization@archiver.kernel.org>; Wed, 24 Nov 2021 07:14:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id BCB9740120;
	Wed, 24 Nov 2021 07:14:37 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id lGIZT70Cpbde; Wed, 24 Nov 2021 07:14:36 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 47EEB40003;
	Wed, 24 Nov 2021 07:14:36 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 0EDD3C002E;
	Wed, 24 Nov 2021 07:14:36 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E6E57C0012
 for <virtualization@lists.linux-foundation.org>;
 Wed, 24 Nov 2021 07:14:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id D4CB2400D6
 for <virtualization@lists.linux-foundation.org>;
 Wed, 24 Nov 2021 07:14:34 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id lEEUZwYQOfly
 for <virtualization@lists.linux-foundation.org>;
 Wed, 24 Nov 2021 07:14:34 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 27DD840003
 for <virtualization@lists.linux-foundation.org>;
 Wed, 24 Nov 2021 07:14:34 +0000 (UTC)
Received: by verein.lst.de (Postfix, from userid 2407)
 id 8727968AFE; Wed, 24 Nov 2021 08:14:30 +0100 (CET)
Date: Wed, 24 Nov 2021 08:14:30 +0100
From: Christoph Hellwig <hch@lst.de>
To: "Darrick J. Wong" <djwong@kernel.org>
Subject: Re: [PATCH 23/29] xfs: use IOMAP_DAX to check for DAX mappings
Message-ID: <20211124071430.GD7229@lst.de>
References: <20211109083309.584081-1-hch@lst.de>
 <20211109083309.584081-24-hch@lst.de> <20211123230124.GR266024@magnolia>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20211123230124.GR266024@magnolia>
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

On Tue, Nov 23, 2021 at 03:01:24PM -0800, Darrick J. Wong wrote:
> On Tue, Nov 09, 2021 at 09:33:03AM +0100, Christoph Hellwig wrote:
> > Use the explicit DAX flag instead of checking the inode flag in the
> > iomap code.
> > 
> > Signed-off-by: Christoph Hellwig <hch@lst.de>
> 
> Any particular reason to pass this in as a flag vs. querying the inode?

Same reason as the addition of IOMAP_DAX.  But I think I'll redo this
a bit to do the XFS paramater passing first and then actually check
IOMAP_DAX together with introducing it to make it all a little more clear.
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
