Return-Path: <SRS0=bIcn=PX=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DAE6C43217
	for <virtualization@archiver.kernel.org>; Thu,  4 Nov 2021 17:36:12 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BEC28611C0
	for <virtualization@archiver.kernel.org>; Thu,  4 Nov 2021 17:36:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org BEC28611C0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 736CC403EE;
	Thu,  4 Nov 2021 17:36:11 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id I9SP-VU-tsUr; Thu,  4 Nov 2021 17:36:10 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id DFCA9400DD;
	Thu,  4 Nov 2021 17:36:09 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B3696C0012;
	Thu,  4 Nov 2021 17:36:09 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1D607C000E
 for <virtualization@lists.linux-foundation.org>;
 Thu,  4 Nov 2021 17:36:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 06B5F81A24
 for <virtualization@lists.linux-foundation.org>;
 Thu,  4 Nov 2021 17:36:08 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id WudlVcR9JMtY
 for <virtualization@lists.linux-foundation.org>;
 Thu,  4 Nov 2021 17:36:03 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 4522981948
 for <virtualization@lists.linux-foundation.org>;
 Thu,  4 Nov 2021 17:36:03 +0000 (UTC)
Received: by verein.lst.de (Postfix, from userid 2407)
 id ACAA76732D; Thu,  4 Nov 2021 18:35:59 +0100 (CET)
Date: Thu, 4 Nov 2021 18:35:59 +0100
From: Christoph Hellwig <hch@lst.de>
To: "Darrick J. Wong" <djwong@kernel.org>
Subject: Re: futher decouple DAX from block devices
Message-ID: <20211104173559.GB31740@lst.de>
References: <20211018044054.1779424-1-hch@lst.de>
 <21ff4333-e567-2819-3ae0-6a2e83ec7ce6@sandeen.net>
 <20211104081740.GA23111@lst.de> <20211104173417.GJ2237511@magnolia>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20211104173417.GJ2237511@magnolia>
User-Agent: Mutt/1.5.17 (2007-11-01)
Cc: nvdimm@lists.linux.dev, Mike Snitzer <snitzer@redhat.com>,
 linux-s390@vger.kernel.org, linux-erofs@lists.ozlabs.org,
 Eric Sandeen <sandeen@sandeen.net>, virtualization@lists.linux-foundation.org,
 linux-xfs@vger.kernel.org, dm-devel@redhat.com, linux-fsdevel@vger.kernel.org,
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

On Thu, Nov 04, 2021 at 10:34:17AM -0700, Darrick J. Wong wrote:
> /me wonders, are block devices going away?  Will mkfs.xfs have to learn
> how to talk to certain chardevs?  I guess jffs2 and others already do
> that kind of thing... but I suppose I can wait for the real draft to
> show up to ramble further. ;)

Right now I've mostly been looking into the kernel side.  An no, I
do not expect /dev/pmem* to go away as you'll still need it for a
not DAX aware file system and/or application (such as mkfs initially).

But yes, just pointing mkfs to the chardev should be doable with very
little work.  We can point it to a regular file after all.
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
