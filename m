Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6233CC636D7
	for <virtualization@archiver.kernel.org>; Mon, 30 Jan 2023 09:23:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id D0BA041715;
	Mon, 30 Jan 2023 09:23:40 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org D0BA041715
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=gUt9fXuq
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id gk8QaqsVw4ZQ; Mon, 30 Jan 2023 09:23:39 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 0018341724;
	Mon, 30 Jan 2023 09:23:38 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 0018341724
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 7D55FC007F;
	Mon, 30 Jan 2023 09:23:37 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3ABAAC0032
 for <virtualization@lists.linux-foundation.org>;
 Mon, 30 Jan 2023 09:23:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id F2EB641716
 for <virtualization@lists.linux-foundation.org>;
 Mon, 30 Jan 2023 09:23:34 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org F2EB641716
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id VMVFvKi3aerV
 for <virtualization@lists.linux-foundation.org>;
 Mon, 30 Jan 2023 09:23:33 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 9D1EB41715
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2607:7c80:54:3::133])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 9D1EB41715
 for <virtualization@lists.linux-foundation.org>;
 Mon, 30 Jan 2023 09:23:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
 MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:In-Reply-To:References;
 bh=lCuBrdiApHtnAzdlL9jd8/orKVtuLY/i0Sero01PH48=; b=gUt9fXuq6v7ElJkjGIu4Bt2k6I
 aie9JrU1FF7iS8hNoPZplHZMIg/mjCy9+CuXAh/U/DNgLjS6V1ufgxJp2NQMex5tHZQGfnrKiKRKo
 caqpxM1HRuxRxX61XnnyxOSlZ2/Jq47eap8gN/lH6+L4ZPbDi3w4YLBF5OHjyJWW13xcFRDWCqAUZ
 NKpMf5yhHzm/uS9x384Srna47NYmLZm+gDq7sZpO/NDG+BHvojVyEMNCK01EInd7TUHZ7+Fo+Bd26
 ywRu7rwlcWBFPjfGdWJeRjwhamdKyIPJEjKoaPO4rYQ0QXObm0HMjgFoMXTg096Bm2LCYjvYSlGAx
 FW6FwsxA==;
Received: from [2001:4bb8:19a:272a:732e:e417:47d7:2f4a] (helo=localhost)
 by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
 id 1pMQMS-002nyI-W6; Mon, 30 Jan 2023 09:22:01 +0000
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Subject: add bvec initialization helpers
Date: Mon, 30 Jan 2023 10:21:34 +0100
Message-Id: <20230130092157.1759539-1-hch@lst.de>
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
 fs/ceph/file.c                    |   10 ++++-----
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
 29 files changed, 143 insertions(+), 187 deletions(-)
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
