Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3FED8C433EF
	for <virtualization@archiver.kernel.org>; Wed, 24 Nov 2021 07:10:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id BA06E40117;
	Wed, 24 Nov 2021 07:10:34 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id COwmIN-fv0pH; Wed, 24 Nov 2021 07:10:33 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 4960140003;
	Wed, 24 Nov 2021 07:10:33 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 209CEC002E;
	Wed, 24 Nov 2021 07:10:33 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 8AC3EC0012
 for <virtualization@lists.linux-foundation.org>;
 Wed, 24 Nov 2021 07:10:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 82CB940374
 for <virtualization@lists.linux-foundation.org>;
 Wed, 24 Nov 2021 07:10:32 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id d4XsXnoNqcM6
 for <virtualization@lists.linux-foundation.org>;
 Wed, 24 Nov 2021 07:10:32 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
 by smtp4.osuosl.org (Postfix) with ESMTPS id F21B1402D1
 for <virtualization@lists.linux-foundation.org>;
 Wed, 24 Nov 2021 07:10:31 +0000 (UTC)
Received: by verein.lst.de (Postfix, from userid 2407)
 id 9250868AFE; Wed, 24 Nov 2021 08:10:28 +0100 (CET)
Date: Wed, 24 Nov 2021 08:10:28 +0100
From: Christoph Hellwig <hch@lst.de>
To: Dan Williams <dan.j.williams@intel.com>
Subject: Re: [PATCH 22/29] iomap: add a IOMAP_DAX flag
Message-ID: <20211124071028.GC7229@lst.de>
References: <20211109083309.584081-1-hch@lst.de>
 <20211109083309.584081-23-hch@lst.de>
 <CAPcyv4gQO6F5-8Ux8ye5cU-W3ZQVDjj5614Xb8EsTvH9UhfAfg@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAPcyv4gQO6F5-8Ux8ye5cU-W3ZQVDjj5614Xb8EsTvH9UhfAfg@mail.gmail.com>
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

On Tue, Nov 23, 2021 at 06:47:10PM -0800, Dan Williams wrote:
> On Tue, Nov 9, 2021 at 12:34 AM Christoph Hellwig <hch@lst.de> wrote:
> >
> > Add a flag so that the file system can easily detect DAX operations.
> 
> Looks ok, but I would have preferred a quick note about the rationale
> here before needing to read other patches to figure that out.

The reason is to only apply the DAX partition offsets to actual DAX
operations, and not to e.g. fiemap.  I'll document that more clearly.
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
