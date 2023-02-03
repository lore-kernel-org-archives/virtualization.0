Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73BA5C64EC7
	for <virtualization@archiver.kernel.org>; Fri,  3 Feb 2023 15:07:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id E1D82612D9;
	Fri,  3 Feb 2023 15:07:40 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org E1D82612D9
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=LwFg4o7F
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id U0_kFEuSJ1DZ; Fri,  3 Feb 2023 15:07:40 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 67653612DF;
	Fri,  3 Feb 2023 15:07:39 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 67653612DF
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 4C3B2C0032;
	Fri,  3 Feb 2023 15:07:39 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 76BD6C0081
 for <virtualization@lists.linux-foundation.org>;
 Fri,  3 Feb 2023 15:07:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 5136E4159C
 for <virtualization@lists.linux-foundation.org>;
 Fri,  3 Feb 2023 15:07:35 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 5136E4159C
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org
 header.a=rsa-sha256 header.s=bombadil.20210309 header.b=LwFg4o7F
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Df8mnVhG2RhW
 for <virtualization@lists.linux-foundation.org>;
 Fri,  3 Feb 2023 15:07:33 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 2FE46403D6
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2607:7c80:54:3::133])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 2FE46403D6
 for <virtualization@lists.linux-foundation.org>;
 Fri,  3 Feb 2023 15:07:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
 MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:In-Reply-To:References;
 bh=xaXfHvtmirT//H/Mo9JZTCfopwE0ARO2STlU1q4PXIU=; b=LwFg4o7FNRjNvzeL1UIeY+PB30
 pigk8LO6ghAV/PW8A2diZklP7ONPkf/QuZ1j8F2QHoj76RmFvj/Q8pZxLQNZCU995h2ds4C/fgoU6
 vJrgHAy3JyTeMQU3sBiEJ2k75Q4WOqSb0agWbK9kpPxrkSUpCMcMfqkAl8xQSVnMiGJsWds5MEA0/
 ttVela2LE/82AgMzn2QpTZPgzNm+u+iJUJj6KJXJcu0gz4sOsbBmYQNi3tJoXH33FBOPEsxVAF/p5
 5brK/jfAn9M2GdavX3Sg69iNnol9jENDgRqr7idObKYZRPtBjJSz+TRjAv8KvwNM3XfV2T+AE+LX+
 QYoCj3mg==;
Received: from [2001:4bb8:19a:272a:910:bb67:7287:f956] (helo=localhost)
 by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
 id 1pNxe8-002abR-B0; Fri, 03 Feb 2023 15:06:36 +0000
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Subject: add bvec initialization helpers v2
Date: Fri,  3 Feb 2023 16:06:11 +0100
Message-Id: <20230203150634.3199647-1-hch@lst.de>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 bombadil.infradead.org. See http://www.infradead.org/rpr.html
Cc: kvm@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>,
 linux-nvme@lists.infradead.org, virtualization@lists.linux-foundation.org,
 David Howells <dhowells@redhat.com>, linux-mm@kvack.org,
 Eric Dumazet <edumazet@google.com>, target-devel@vger.kernel.org,
 Marc Dionne <marc.dionne@auristor.com>, linux-afs@lists.infradead.org,
 Mike Marshall <hubcap@omnibond.com>, linux-cifs@vger.kernel.org,
 Sagi Grimberg <sagi@grimberg.me>, linux-scsi@vger.kernel.org,
 Minchan Kim <minchan@kernel.org>, io-uring@vger.kernel.org,
 Jakub Kicinski <kuba@kernel.org>, Ilya Dryomov <idryomov@gmail.com>,
 Paolo Abeni <pabeni@redhat.com>, devel@lists.orangefs.org,
 linux-block@vger.kernel.org, Keith Busch <kbusch@kernel.org>,
 ceph-devel@vger.kernel.org, Xiubo Li <xiubli@redhat.com>,
 Trond Myklebust <trond.myklebust@hammerspace.com>, linux-nfs@vger.kernel.org,
 "Martin K. Petersen" <martin.petersen@oracle.com>, netdev@vger.kernel.org,
 samba-technical@lists.samba.org, Steve French <sfrench@samba.org>,
 Sergey Senozhatsky <senozhatsky@chromium.org>,
 Chuck Lever <chuck.lever@oracle.com>, Anna Schumaker <anna@kernel.org>,
 linux-fsdevel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>,
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

Hi all,

this series adds the helpers to initalize a bvec.  These remove open coding of
bvec internals and help with experimenting with other representations like
a phys_addr_t instead of page + offset.

Changes since v1:
 - fix a typo
 - simplify the code in ceph's __iter_get_bvecs a little bit further
 - fix two subject prefixes

Diffstat:
 block/bio-integrity.c             |    7 ------
 block/bio.c                       |   12 +----------
 drivers/block/rbd.c               |    7 ++----
 drivers/block/virtio_blk.c        |    4 ---
 drivers/block/zram/zram_drv.c     |   15 +++-----------
 drivers/nvme/host/core.c          |    4 ---
 drivers/nvme/target/io-cmd-file.c |   10 +--------
 drivers/nvme/target/tcp.c         |    5 +---
 drivers/scsi/sd.c                 |   36 ++++++++++++++++------------------
 drivers/target/target_core_file.c |   18 +++++------------
 drivers/vhost/vringh.c            |    5 +---
 fs/afs/write.c                    |    8 ++-----
 fs/ceph/file.c                    |   12 +++--------
 fs/cifs/connect.c                 |    5 ++--
 fs/cifs/fscache.c                 |   16 +++++----------
 fs/cifs/misc.c                    |    5 +---
 fs/cifs/smb2ops.c                 |    6 ++---
 fs/coredump.c                     |    7 +-----
 fs/nfs/fscache.c                  |   16 +++++----------
 fs/orangefs/inode.c               |   22 ++++++--------------
 fs/splice.c                       |    5 +---
 include/linux/bvec.h              |   40 ++++++++++++++++++++++++++++++++++++++
 io_uring/rsrc.c                   |    4 ---
 mm/page_io.c                      |    8 +------
 net/ceph/messenger_v1.c           |    7 +-----
 net/ceph/messenger_v2.c           |   28 ++++++++++----------------
 net/rxrpc/rxperf.c                |    8 ++-----
 net/sunrpc/svcsock.c              |    7 +-----
 net/sunrpc/xdr.c                  |    5 +---
 29 files changed, 142 insertions(+), 190 deletions(-)
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
