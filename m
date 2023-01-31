Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB660C38142
	for <virtualization@archiver.kernel.org>; Tue, 31 Jan 2023 13:46:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 3E26F8146A;
	Tue, 31 Jan 2023 13:46:10 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 3E26F8146A
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id kyXrIcogL9QU; Tue, 31 Jan 2023 13:46:09 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id CE4F28144D;
	Tue, 31 Jan 2023 13:46:08 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org CE4F28144D
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 3DD64C0033;
	Tue, 31 Jan 2023 13:46:08 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 49519C002B
 for <virtualization@lists.linux-foundation.org>;
 Tue, 31 Jan 2023 13:46:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 1BCAB81367
 for <virtualization@lists.linux-foundation.org>;
 Tue, 31 Jan 2023 13:46:06 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 1BCAB81367
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 0X8F5lCFjp8i
 for <virtualization@lists.linux-foundation.org>;
 Tue, 31 Jan 2023 13:46:05 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 4761981282
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 4761981282
 for <virtualization@lists.linux-foundation.org>;
 Tue, 31 Jan 2023 13:46:05 +0000 (UTC)
Received: by verein.lst.de (Postfix, from userid 2407)
 id A7B4968B05; Tue, 31 Jan 2023 14:45:22 +0100 (CET)
Date: Tue, 31 Jan 2023 14:45:21 +0100
From: Christoph Hellwig <hch@lst.de>
To: Bart Van Assche <bvanassche@acm.org>
Subject: Re: [PATCH 01/23] block: factor out a bvec_set_page helper
Message-ID: <20230131134521.GA24165@lst.de>
References: <20230130092157.1759539-1-hch@lst.de>
 <20230130092157.1759539-2-hch@lst.de>
 <2bab7050-dec7-3af8-b643-31b414b8c4b4@acm.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <2bab7050-dec7-3af8-b643-31b414b8c4b4@acm.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
Cc: kvm@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>,
 linux-nvme@lists.infradead.org, virtualization@lists.linux-foundation.org,
 David Howells <dhowells@redhat.com>, linux-mm@kvack.org,
 Eric Dumazet <edumazet@google.com>, target-devel@vger.kernel.org,
 Marc Dionne <marc.dionne@auristor.com>, Christoph Hellwig <hch@lst.de>,
 io-uring@vger.kernel.org, Mike Marshall <hubcap@omnibond.com>,
 linux-cifs@vger.kernel.org, Sagi Grimberg <sagi@grimberg.me>,
 linux-scsi@vger.kernel.org, Sergey Senozhatsky <senozhatsky@chromium.org>,
 linux-afs@lists.infradead.org, Jakub Kicinski <kuba@kernel.org>,
 Ilya Dryomov <idryomov@gmail.com>, Paolo Abeni <pabeni@redhat.com>,
 devel@lists.orangefs.org, linux-block@vger.kernel.org,
 Keith Busch <kbusch@kernel.org>, ceph-devel@vger.kernel.org,
 Xiubo Li <xiubli@redhat.com>,
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

On Mon, Jan 30, 2023 at 09:09:23AM -0800, Bart Van Assche wrote:
> Has it been considered to use structure assignment instead of introducing 
> bvec_set_page(), e.g. as follows?
>
> bip->bip_vec[bip->bip_vcnt] = (struct bio_vec) {
>       .bv_page = page, .bv_len = len, .bv_offset = offset };

Unless it's hidden behind a macro it doesn't solve the problem of
abstraction away the layout.  I'm also find it less readable.
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
