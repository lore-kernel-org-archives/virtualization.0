Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70025C38142
	for <virtualization@archiver.kernel.org>; Tue, 31 Jan 2023 05:29:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id E67A660608;
	Tue, 31 Jan 2023 05:29:31 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org E67A660608
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=casper.20170209 header.b=JvR8Ququ
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id OZ72aakZgz62; Tue, 31 Jan 2023 05:29:31 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 7188C60601;
	Tue, 31 Jan 2023 05:29:30 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 7188C60601
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 55552C0032;
	Tue, 31 Jan 2023 05:29:30 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 524ACC002B
 for <virtualization@lists.linux-foundation.org>;
 Tue, 31 Jan 2023 05:29:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id E65E260608
 for <virtualization@lists.linux-foundation.org>;
 Tue, 31 Jan 2023 05:29:28 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org E65E260608
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id pcK36Ig9lGtl
 for <virtualization@lists.linux-foundation.org>;
 Tue, 31 Jan 2023 05:29:28 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 3001560601
Received: from casper.infradead.org (casper.infradead.org
 [IPv6:2001:8b0:10b:1236::1])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 3001560601
 for <virtualization@lists.linux-foundation.org>;
 Tue, 31 Jan 2023 05:29:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=CQYz9YB3giOSRpIimXEFMxgqmfkfwruFek5pOzrb5IQ=; b=JvR8QuquuMwb2FdJFO6IqAmkUN
 tBrsFCSIXyqkvHRM7fZ5u2Yg3NPMsUB4PxUX/qu0v0Y/y56IW2JyHo3ZH+sQn74OeI+wQgRHwm469
 ekItn7tysg17ZoXo4wlDrE+odoN2wcg/QN0iGuhxZacjagKnw/aMq2JYFfGPuFT057WF6LsNJV+MO
 pG5SmCKtbNcmU931OJT8zqoMhqX/QZsBHuLW2VtKp9GTurrJUSgXCqAjzkF+H+0oZnKPQSIf5WWDS
 sHj5zkmFAK0ZxjLLSQoGz0ejpEslLySYtQeDdfyez4NU/l444zvg47QBe/HZXhOo5g6wjc5+Ht4Gj
 7x1ystVw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red
 Hat Linux)) id 1pMjBr-00B2qK-A1; Tue, 31 Jan 2023 05:28:19 +0000
Date: Tue, 31 Jan 2023 05:28:19 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Jakub Kicinski <kuba@kernel.org>
Subject: Re: [PATCH 01/23] block: factor out a bvec_set_page helper
Message-ID: <Y9im8+cEyRhQLLfV@casper.infradead.org>
References: <20230130092157.1759539-1-hch@lst.de>
 <20230130092157.1759539-2-hch@lst.de>
 <20230130204758.38f4c6b9@kernel.org>
 <Y9igcK1d/iGn33pK@casper.infradead.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <Y9igcK1d/iGn33pK@casper.infradead.org>
Cc: kvm@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>,
 linux-nvme@lists.infradead.org, virtualization@lists.linux-foundation.org,
 David Howells <dhowells@redhat.com>, linux-mm@kvack.org,
 Eric Dumazet <edumazet@google.com>, target-devel@vger.kernel.org,
 Marc Dionne <marc.dionne@auristor.com>, Christoph Hellwig <hch@lst.de>,
 io-uring@vger.kernel.org, Mike Marshall <hubcap@omnibond.com>,
 linux-cifs@vger.kernel.org, Sagi Grimberg <sagi@grimberg.me>,
 linux-scsi@vger.kernel.org, Sergey Senozhatsky <senozhatsky@chromium.org>,
 linux-afs@lists.infradead.org, Ilya Dryomov <idryomov@gmail.com>,
 Paolo Abeni <pabeni@redhat.com>, devel@lists.orangefs.org,
 linux-block@vger.kernel.org, Keith Busch <kbusch@kernel.org>,
 ceph-devel@vger.kernel.org, Xiubo Li <xiubli@redhat.com>,
 Trond Myklebust <trond.myklebust@hammerspace.com>,
 Jens Axboe <axboe@kernel.dk>, linux-nfs@vger.kernel.org,
 "Martin K. Petersen" <martin.petersen@oracle.com>, netdev@vger.kernel.org,
 samba-technical@lists.samba.org, Steve French <sfrench@samba.org>,
 Minchan Kim <minchan@kernel.org>, Chuck Lever <chuck.lever@oracle.com>,
 Anna Schumaker <anna@kernel.org>, linux-fsdevel@vger.kernel.org,
 Andrew Morton <akpm@linux-foundation.org>,
 "David S. Miller" <davem@davemloft.net>
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

On Tue, Jan 31, 2023 at 05:00:32AM +0000, Matthew Wilcox wrote:
> On Mon, Jan 30, 2023 at 08:47:58PM -0800, Jakub Kicinski wrote:
> > kinda random thought but since we're touching this area - could we
> > perhaps move the definition of struct bio_vec and trivial helpers 
> > like this into a new header? bvec.h pulls in mm.h which is a right
> > behemoth :S
> 
> I bet we can drop mm.h now.  It was originally added for nth_page()
> in 3d75ca0adef4 but those were all removed by b8753433fc61.
> 
> A quick smoke test on my default testing config doesn't find any
> problems.  Let me send a patch and see if the build bots complain.

Disappointingly, it doesn't really change anything.  1134 files
depend on mm.h both before and after [1].  Looks like it's due to
arch/x86/include/asm/cacheflush.h pulling in linux/mm.h, judging by the
contents of .build_test_kernel-x86_64/net/ipv6/.inet6_hashtables.o.cmd.
But *lots* of header files pull in mm.h, including scatterlist.h,
vt_kern.h, net.h, nfs_fs.h, sunrpc/svc.h and security.h.

I suppose it may cut down on include loops to drop it here, so I'm
still in favour of the patch I posted, but this illustrates how
deeply entangled our headers still are.

[1] find .build_test_kernel-x86_64/ -name '.*.cmd' |xargs grep 'include/linux/mm.h' |wc -l
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
