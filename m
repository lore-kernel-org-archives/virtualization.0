Return-Path: <SRS0=YXi0=PY=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6F30C433EF
	for <virtualization@archiver.kernel.org>; Fri,  5 Nov 2021 03:33:09 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7367B60EB4
	for <virtualization@archiver.kernel.org>; Fri,  5 Nov 2021 03:33:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 7367B60EB4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 24ECA40293;
	Fri,  5 Nov 2021 03:33:09 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id bMRszv0cklc2; Fri,  5 Nov 2021 03:33:08 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id B48414022C;
	Fri,  5 Nov 2021 03:33:07 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8663CC0012;
	Fri,  5 Nov 2021 03:33:07 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C5561C000E
 for <virtualization@lists.linux-foundation.org>;
 Fri,  5 Nov 2021 03:33:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id B677140272
 for <virtualization@lists.linux-foundation.org>;
 Fri,  5 Nov 2021 03:33:06 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id pLWfo1Clyx2g
 for <virtualization@lists.linux-foundation.org>;
 Fri,  5 Nov 2021 03:33:05 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from casper.infradead.org (casper.infradead.org
 [IPv6:2001:8b0:10b:1236::1])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 224DB4022C
 for <virtualization@lists.linux-foundation.org>;
 Fri,  5 Nov 2021 03:33:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=vYTj4+Qj7wwu4cVg0DWamUnt0bl+yIq5bTcfsNjRRqw=; b=GDZA848HxP31gXPJrbJb1hsEqw
 0f4xGgqaPeTYr/jnGmCuCwIDm9/vBUN70m1anN1+xf4jYdLKo8bnkpv98Tz/4LSFfutV+5RUbsHcn
 xvpui7RzzIwOqB9/ri4wv9GDDtkkShT1u8edH0UBE2oBmmJEo1CNw0G0wxCGXXKlubAjOM2Ro/Ehs
 bQ0RTb1mP+goFvBzd5NdSO+UkHqegStEbVRdq3ZH+RO1ssVK/8iJEk/+Yic/9NxIG4O8ZIrUL3aQU
 GV3eG6t1cGKVIkDmU4bZ62AO0lzIYsinGEt5zLBc3KGEkXCrJ55GrQMAElwFrvICgT/tM4n5HS7z3
 Ew1FygLQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red
 Hat Linux)) id 1mipvv-006JD0-HF; Fri, 05 Nov 2021 03:30:39 +0000
Date: Fri, 5 Nov 2021 03:30:27 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Theodore Ts'o <tytso@mit.edu>
Subject: Re: futher decouple DAX from block devices
Message-ID: <YYSlU48wcKt4qixx@casper.infradead.org>
References: <20211018044054.1779424-1-hch@lst.de>
 <21ff4333-e567-2819-3ae0-6a2e83ec7ce6@sandeen.net>
 <20211104081740.GA23111@lst.de> <20211104173417.GJ2237511@magnolia>
 <20211104173559.GB31740@lst.de>
 <CAPcyv4jbjc+XtX5RX5OL3vPadsYZwoK1NG1qC5AcpySBu5tL4g@mail.gmail.com>
 <20211104190443.GK24333@magnolia> <YYSgX9FI0kaGLeR0@mit.edu>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <YYSgX9FI0kaGLeR0@mit.edu>
Cc: Linux NVDIMM <nvdimm@lists.linux.dev>, linux-erofs@lists.ozlabs.org,
 Mike Snitzer <snitzer@redhat.com>, linux-s390 <linux-s390@vger.kernel.org>,
 "Darrick J. Wong" <djwong@kernel.org>, Eric Sandeen <sandeen@sandeen.net>,
 virtualization@lists.linux-foundation.org,
 linux-xfs <linux-xfs@vger.kernel.org>,
 device-mapper development <dm-devel@redhat.com>,
 linux-fsdevel <linux-fsdevel@vger.kernel.org>,
 Dan Williams <dan.j.williams@intel.com>,
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

On Thu, Nov 04, 2021 at 11:09:19PM -0400, Theodore Ts'o wrote:
> On Thu, Nov 04, 2021 at 12:04:43PM -0700, Darrick J. Wong wrote:
> > > Note that I've avoided implementing read/write fops for dax devices
> > > partly out of concern for not wanting to figure out shared-mmap vs
> > > write coherence issues, but also because of a bet with Dave Hansen
> > > that device-dax not grow features like what happened to hugetlbfs. So
> > > it would seem mkfs would need to switch to mmap I/O, or bite the
> > > bullet and implement read/write fops in the driver.
> > 
> > That ... would require a fair amount of userspace changes, though at
> > least e2fsprogs has pluggable io drivers, which would make mmapping a
> > character device not too awful.
> > 
> > xfsprogs would be another story -- porting the buffer cache mignt not be
> > too bad, but mkfs and repair seem to issue pread/pwrite calls directly.
> > Note that xfsprogs explicitly screens out chardevs.
> 
> It's not just e2fsprogs and xfsprogs.  There's also udev, blkid,
> potententially systemd unit generators to kick off fsck runs, etc.
> There are probably any number of user scripts which assume that file
> systems are mounted on block devices --- for example, by looking at
> the output of lsblk, etc.
> 
> Also note that block devices have O_EXCL support to provide locking
> against attempts to run mkfs on a mounted file system.  If you move
> dax file systems to be mounted on a character mode device, that would
> have to be replicated as well, etc.  So I suspect that a large number
> of subtle things would break, and I'd strongly recommend against going
> down that path.

Agreed.  There were reasons we decided to present pmem as "block
device with extra functionality" rather than try to cram all the block
layer functionality (eg submitting BIOs for filesystem metadata) into a
character device.  Some of those assumptions might be worth re-examining,
but I haven't seen anything that makes me say "this is obviously better
than what we did at the time".
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
