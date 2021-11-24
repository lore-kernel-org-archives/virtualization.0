Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E5BCC433EF
	for <virtualization@archiver.kernel.org>; Wed, 24 Nov 2021 06:59:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id CB2FA80CDA;
	Wed, 24 Nov 2021 06:59:45 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id JevnHgG533ij; Wed, 24 Nov 2021 06:59:45 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 8D76880C8F;
	Wed, 24 Nov 2021 06:59:44 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 60A20C001E;
	Wed, 24 Nov 2021 06:59:44 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 47C5CC0012
 for <virtualization@lists.linux-foundation.org>;
 Wed, 24 Nov 2021 06:59:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 2F4EC4023B
 for <virtualization@lists.linux-foundation.org>;
 Wed, 24 Nov 2021 06:59:42 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 1jlhg1ViPL18
 for <virtualization@lists.linux-foundation.org>;
 Wed, 24 Nov 2021 06:59:41 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 9C55D40233
 for <virtualization@lists.linux-foundation.org>;
 Wed, 24 Nov 2021 06:59:41 +0000 (UTC)
Received: by verein.lst.de (Postfix, from userid 2407)
 id 2A62068AFE; Wed, 24 Nov 2021 07:59:38 +0100 (CET)
Date: Wed, 24 Nov 2021 07:59:38 +0100
From: Christoph Hellwig <hch@lst.de>
To: Dan Williams <dan.j.williams@intel.com>
Subject: Re: [PATCH 25/29] dax: return the partition offset from
 fs_dax_get_by_bdev
Message-ID: <20211124065938.GB7229@lst.de>
References: <20211109083309.584081-1-hch@lst.de>
 <20211109083309.584081-26-hch@lst.de>
 <CAPcyv4jtWzd3c_S1_4fYA1SXTJZfBzP_1xk_OwYkeNp0UhxwSg@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAPcyv4jtWzd3c_S1_4fYA1SXTJZfBzP_1xk_OwYkeNp0UhxwSg@mail.gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Cc: Linux NVDIMM <nvdimm@lists.linux.dev>, Mike Snitzer <snitzer@redhat.com>,
 linux-s390 <linux-s390@vger.kernel.org>, linux-erofs@lists.ozlabs.org,
 virtualization@lists.linux-foundation.org,
 linux-xfs <linux-xfs@vger.kernel.org>,
 device-mapper development <dm-devel@redhat.com>,
 linux-fsdevel <linux-fsdevel@vger.kernel.org>,
 linux-ext4 <linux-ext4@vger.kernel.org>, Ira Weiny <ira.weiny@intel.com>,
 Christoph Hellwig <hch@lst.de>
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

On Tue, Nov 23, 2021 at 06:56:29PM -0800, Dan Williams wrote:
> On Tue, Nov 9, 2021 at 12:34 AM Christoph Hellwig <hch@lst.de> wrote:
> >
> > Prepare from removing the block_device from the DAX I/O path by returning
> 
> s/from removing/for the removal of/

Fixed.

> >         td->dm_dev.bdev = bdev;
> > -       td->dm_dev.dax_dev = fs_dax_get_by_bdev(bdev);
> > +       td->dm_dev.dax_dev = fs_dax_get_by_bdev(bdev, &part_off);
> 
> Perhaps allow NULL as an argument for callers that do not care about
> the start offset?

All callers currently care, dm just has another way to get at the
information.  So for now I'd like to not add the NULL special case,
but we can reconsider that as needed if/when more callers show up.
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
