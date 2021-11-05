Return-Path: <SRS0=YXi0=PY=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90D75C433EF
	for <virtualization@archiver.kernel.org>; Fri,  5 Nov 2021 03:09:33 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0FEE16121E
	for <virtualization@archiver.kernel.org>; Fri,  5 Nov 2021 03:09:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 0FEE16121E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mit.edu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id BE8EC60BAA;
	Fri,  5 Nov 2021 03:09:32 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id odkYzcuBS_wn; Fri,  5 Nov 2021 03:09:31 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 5943760609;
	Fri,  5 Nov 2021 03:09:31 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 32698C0012;
	Fri,  5 Nov 2021 03:09:31 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id BB693C000E
 for <virtualization@lists.linux-foundation.org>;
 Fri,  5 Nov 2021 03:09:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 9D09D8184F
 for <virtualization@lists.linux-foundation.org>;
 Fri,  5 Nov 2021 03:09:29 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id CYkyR9kBEQZm
 for <virtualization@lists.linux-foundation.org>;
 Fri,  5 Nov 2021 03:09:29 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
 by smtp1.osuosl.org (Postfix) with ESMTPS id CE7BC8101F
 for <virtualization@lists.linux-foundation.org>;
 Fri,  5 Nov 2021 03:09:28 +0000 (UTC)
Received: from cwcc.thunk.org (pool-72-74-133-215.bstnma.fios.verizon.net
 [72.74.133.215]) (authenticated bits=0)
 (User authenticated as tytso@ATHENA.MIT.EDU)
 by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 1A539JCp001043
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 4 Nov 2021 23:09:19 -0400
Received: by cwcc.thunk.org (Postfix, from userid 15806)
 id 215AA15C00B9; Thu,  4 Nov 2021 23:09:19 -0400 (EDT)
Date: Thu, 4 Nov 2021 23:09:19 -0400
From: "Theodore Ts'o" <tytso@mit.edu>
To: "Darrick J. Wong" <djwong@kernel.org>
Subject: Re: futher decouple DAX from block devices
Message-ID: <YYSgX9FI0kaGLeR0@mit.edu>
References: <20211018044054.1779424-1-hch@lst.de>
 <21ff4333-e567-2819-3ae0-6a2e83ec7ce6@sandeen.net>
 <20211104081740.GA23111@lst.de> <20211104173417.GJ2237511@magnolia>
 <20211104173559.GB31740@lst.de>
 <CAPcyv4jbjc+XtX5RX5OL3vPadsYZwoK1NG1qC5AcpySBu5tL4g@mail.gmail.com>
 <20211104190443.GK24333@magnolia>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20211104190443.GK24333@magnolia>
Cc: Linux NVDIMM <nvdimm@lists.linux.dev>, Mike Snitzer <snitzer@redhat.com>,
 linux-s390 <linux-s390@vger.kernel.org>, linux-erofs@lists.ozlabs.org,
 Eric Sandeen <sandeen@sandeen.net>, virtualization@lists.linux-foundation.org,
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

On Thu, Nov 04, 2021 at 12:04:43PM -0700, Darrick J. Wong wrote:
> > Note that I've avoided implementing read/write fops for dax devices
> > partly out of concern for not wanting to figure out shared-mmap vs
> > write coherence issues, but also because of a bet with Dave Hansen
> > that device-dax not grow features like what happened to hugetlbfs. So
> > it would seem mkfs would need to switch to mmap I/O, or bite the
> > bullet and implement read/write fops in the driver.
> 
> That ... would require a fair amount of userspace changes, though at
> least e2fsprogs has pluggable io drivers, which would make mmapping a
> character device not too awful.
> 
> xfsprogs would be another story -- porting the buffer cache mignt not be
> too bad, but mkfs and repair seem to issue pread/pwrite calls directly.
> Note that xfsprogs explicitly screens out chardevs.

It's not just e2fsprogs and xfsprogs.  There's also udev, blkid,
potententially systemd unit generators to kick off fsck runs, etc.
There are probably any number of user scripts which assume that file
systems are mounted on block devices --- for example, by looking at
the output of lsblk, etc.

Also note that block devices have O_EXCL support to provide locking
against attempts to run mkfs on a mounted file system.  If you move
dax file systems to be mounted on a character mode device, that would
have to be replicated as well, etc.  So I suspect that a large number
of subtle things would break, and I'd strongly recommend against going
down that path.

						- Ted
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
