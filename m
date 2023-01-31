Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0CDD0C38142
	for <virtualization@archiver.kernel.org>; Tue, 31 Jan 2023 05:01:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 475F44013A;
	Tue, 31 Jan 2023 05:01:48 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 475F44013A
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=casper.20170209 header.b=Q5zfNh/E
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id MlqOHV-bNCla; Tue, 31 Jan 2023 05:01:47 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 5C22B40133;
	Tue, 31 Jan 2023 05:01:46 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 5C22B40133
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 315A1C0081;
	Tue, 31 Jan 2023 05:01:46 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 85AA2C0080
 for <virtualization@lists.linux-foundation.org>;
 Tue, 31 Jan 2023 05:01:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 5963C81320
 for <virtualization@lists.linux-foundation.org>;
 Tue, 31 Jan 2023 05:01:44 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 5963C81320
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org
 header.a=rsa-sha256 header.s=casper.20170209 header.b=Q5zfNh/E
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id w-onbQiOD-bI
 for <virtualization@lists.linux-foundation.org>;
 Tue, 31 Jan 2023 05:01:42 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 72F1881317
Received: from casper.infradead.org (casper.infradead.org
 [IPv6:2001:8b0:10b:1236::1])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 72F1881317
 for <virtualization@lists.linux-foundation.org>;
 Tue, 31 Jan 2023 05:01:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=HeiethKseVGJ70/5PjRlX5YDB3+nnc26Ua2pXcSZvpo=; b=Q5zfNh/EB2Bmq7oWjxZpT6+msk
 Wru/DAC5G3Ah5BIaBZRlzZAeO/DNnzrkJTotw+xknA145DoaVDP0PapXQz9haLCp6JFInHd1m/Gq0
 Ugh3dsiSMTuuFZDfTCVfD5u3uqBFHZNFvaNOEf6GBWhQrOrUuRM/LfCeHe1ih3TKWB/32GnPqOt0M
 +KS/+gertHCfno38+Xr4AT42h2GV1/Lh8Psc34Ane6VpgoKN86DPzQO3EbFQEM4/mJ4G+4ucfZfY3
 NPYL3uNiTdgqjKCEqIT2kmWqSZZmNNoBtb5mihNp+8SSg7Q7Ae2AfDTQFg5YePXBH3WHd0Kojkyq6
 mP4yNoNg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red
 Hat Linux)) id 1pMiky-00B1Pp-3D; Tue, 31 Jan 2023 05:00:32 +0000
Date: Tue, 31 Jan 2023 05:00:32 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Jakub Kicinski <kuba@kernel.org>
Subject: Re: [PATCH 01/23] block: factor out a bvec_set_page helper
Message-ID: <Y9igcK1d/iGn33pK@casper.infradead.org>
References: <20230130092157.1759539-1-hch@lst.de>
 <20230130092157.1759539-2-hch@lst.de>
 <20230130204758.38f4c6b9@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20230130204758.38f4c6b9@kernel.org>
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

On Mon, Jan 30, 2023 at 08:47:58PM -0800, Jakub Kicinski wrote:
> kinda random thought but since we're touching this area - could we
> perhaps move the definition of struct bio_vec and trivial helpers 
> like this into a new header? bvec.h pulls in mm.h which is a right
> behemoth :S

I bet we can drop mm.h now.  It was originally added for nth_page()
in 3d75ca0adef4 but those were all removed by b8753433fc61.

A quick smoke test on my default testing config doesn't find any
problems.  Let me send a patch and see if the build bots complain.
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
