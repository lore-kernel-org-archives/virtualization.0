Return-Path: <SRS0=CXPs=PH=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C567C433EF
	for <virtualization@archiver.kernel.org>; Tue, 19 Oct 2021 07:23:38 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A5525611EF
	for <virtualization@archiver.kernel.org>; Tue, 19 Oct 2021 07:23:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org A5525611EF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 6237860A69;
	Tue, 19 Oct 2021 07:23:37 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id CoMwxm7rA0Qo; Tue, 19 Oct 2021 07:23:36 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 1EF90606EA;
	Tue, 19 Oct 2021 07:23:36 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E7164C000F;
	Tue, 19 Oct 2021 07:23:35 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 8D3F7C000D
 for <virtualization@lists.linux-foundation.org>;
 Tue, 19 Oct 2021 07:23:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 6D617402DD
 for <virtualization@lists.linux-foundation.org>;
 Tue, 19 Oct 2021 07:23:34 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id BZ8gvcsGJxK0
 for <virtualization@lists.linux-foundation.org>;
 Tue, 19 Oct 2021 07:23:32 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 4AB0F40233
 for <virtualization@lists.linux-foundation.org>;
 Tue, 19 Oct 2021 07:23:32 +0000 (UTC)
Received: by verein.lst.de (Postfix, from userid 2407)
 id C6E1568BFE; Tue, 19 Oct 2021 09:23:26 +0200 (CEST)
Date: Tue, 19 Oct 2021 09:23:26 +0200
From: Christoph Hellwig <hch@lst.de>
To: "Darrick J. Wong" <djwong@kernel.org>
Subject: Re: [PATCH 06/11] xfs: factor out a xfs_setup_dax helper
Message-ID: <20211019072326.GA23171@lst.de>
References: <20211018044054.1779424-1-hch@lst.de>
 <20211018044054.1779424-7-hch@lst.de> <20211018164351.GT24307@magnolia>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20211018164351.GT24307@magnolia>
User-Agent: Mutt/1.5.17 (2007-11-01)
Cc: , linux-xfs@vger.kernel.org, linux-erofs@lists.ozlabs.org, To-header@lst.de,
 Mike Snitzer <snitzer@redhat.com>, nvdimm@lists.linux.dev,
 linux-s390@vger.kernel.org, no@lst.de, on@lst.de,
 virtualization@lists.linux-foundation.org, "input <"@lst.de,
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

On Mon, Oct 18, 2021 at 09:43:51AM -0700, Darrick J. Wong wrote:
> > --- a/fs/xfs/xfs_super.c
> > +++ b/fs/xfs/xfs_super.c
> > @@ -339,6 +339,32 @@ xfs_buftarg_is_dax(
> >  			bdev_nr_sectors(bt->bt_bdev));
> >  }
> >  
> > +static int
> > +xfs_setup_dax(
> 
> /me wonders if this should be named xfs_setup_dax_always, since this
> doesn't handle the dax=inode mode?

Sure, why not.

> The only reason I bring that up is that Eric reminded me a while ago
> that we don't actually print any kind of EXPERIMENTAL warning for the
> auto-detection behavior.

Yes, I actually noticed that as well when preparing this series.
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
