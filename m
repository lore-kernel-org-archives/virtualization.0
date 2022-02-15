Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84FCAC433EF
	for <virtualization@archiver.kernel.org>; Tue, 15 Feb 2022 09:45:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 270C7415B9;
	Tue, 15 Feb 2022 09:45:37 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id IpK7wWzKiSVw; Tue, 15 Feb 2022 09:45:36 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id D25E7415AA;
	Tue, 15 Feb 2022 09:45:35 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A3114C000B;
	Tue, 15 Feb 2022 09:45:35 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 05D18C000B
 for <virtualization@lists.linux-foundation.org>;
 Tue, 15 Feb 2022 09:45:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id A6FFF415B2
 for <virtualization@lists.linux-foundation.org>;
 Tue, 15 Feb 2022 09:45:30 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id h771OEk0meR2
 for <virtualization@lists.linux-foundation.org>;
 Tue, 15 Feb 2022 09:45:29 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2607:7c80:54:e::133])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 52B88415B7
 for <virtualization@lists.linux-foundation.org>;
 Tue, 15 Feb 2022 09:45:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
 MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:In-Reply-To:References;
 bh=k2zUIoihKeX/PzTYAq+E6BX9omLlFxe2qXDX5akB7yw=; b=vDOP69iXQBS1etC9BNUgTKGNBG
 /khYC8I3DdAsyvTAJQDnYeX8sXRlOuPZJeOAg/ldjkhU4zwEDMdN62+p/QTA52FxDk2wuxx6tIgda
 CA2897HUhMe+Fy3qhaK9jPNazwCJfvlB4KDDsrn6/vmV3IkOSRW8BeEDzQxJnzBfvu9zPaEC+EIo9
 4K1EQz2VVPqr9rpyADPoup8dCtU3DiwZtLdfFU9fDcfvK2XJUDBpa3uwIT13Bv91g8aX+FEprUjgN
 EjidiXCviAuUxOEzRtRsF+02dAO8y/DKM2ys/hmDSXPyv89cjHn42WPRbN+QMMOUEKuwSSMjCsKHQ
 /4k/L6VA==;
Received: from [2001:4bb8:184:543c:6bdf:22f4:7f0a:fe97] (helo=localhost)
 by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nJuOb-0025zX-8L; Tue, 15 Feb 2022 09:45:17 +0000
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Subject: add a ->free_disk block_device_operation v3
Date: Tue, 15 Feb 2022 10:45:09 +0100
Message-Id: <20220215094514.3828912-1-hch@lst.de>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 bombadil.infradead.org. See http://www.infradead.org/rpr.html
Cc: Maxim Levitsky <maximlevitsky@gmail.com>, Alex Dubov <oakad@yahoo.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, linux-mmc@vger.kernel.org,
 virtualization@lists.linux-foundation.org, linux-block@vger.kernel.org,
 Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
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

Hi Jens,

this series adds a ->free_disk method to struct block_device_operation so that
drivers can defer freeing their disk private data until the gendisk goes away
and don't need to play games with the validity of ->private_data.

This also converts three simple drivers over as example, but eventually I
imagine that all drivers with private data will use it.

Changes since v2:
 - only call ->free_disk after add_disk has returned to simplify probe error
   handling
Changes since v1:
 - fix a tag_set use after free in virtio_blk

Diffstat:
 block/genhd.c                       |    5 ++
 drivers/block/virtio_blk.c          |   66 +++++++-----------------------------
 drivers/memstick/core/ms_block.c    |   64 ++++++++--------------------------
 drivers/memstick/core/ms_block.h    |    1 
 drivers/memstick/core/mspro_block.c |   57 +++++--------------------------
 include/linux/blkdev.h              |    2 +
 6 files changed, 46 insertions(+), 149 deletions(-)
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
