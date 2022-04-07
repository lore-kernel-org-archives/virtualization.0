Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 614E0C433F5
	for <virtualization@archiver.kernel.org>; Thu,  7 Apr 2022 15:25:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 0F47440CB0;
	Thu,  7 Apr 2022 15:25:41 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id kPrbx1o03yJP; Thu,  7 Apr 2022 15:25:40 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id A7C1040C82;
	Thu,  7 Apr 2022 15:25:39 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8D34FC002C;
	Thu,  7 Apr 2022 15:25:39 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 54B74C0012
 for <virtualization@lists.linux-foundation.org>;
 Thu,  7 Apr 2022 15:25:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 325876127C
 for <virtualization@lists.linux-foundation.org>;
 Thu,  7 Apr 2022 15:25:37 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=suse.cz header.b="gyRKbvUT";
 dkim=neutral reason="invalid (unsupported algorithm ed25519-sha256)"
 header.d=suse.cz header.b="h4c6BQrP"
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 15uLwNLemzHH
 for <virtualization@lists.linux-foundation.org>;
 Thu,  7 Apr 2022 15:25:36 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 81CF961201
 for <virtualization@lists.linux-foundation.org>;
 Thu,  7 Apr 2022 15:25:36 +0000 (UTC)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out1.suse.de (Postfix) with ESMTP id B53392129B;
 Thu,  7 Apr 2022 15:25:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1649345134;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=u5NLYRb0iRWqH+wp45tMsxWQ+2lcKX7UH+x3jrUc4CM=;
 b=gyRKbvUTSeCHD0kZFeha6b8GtwnfMcBVdpUrcZUXAMFpgjyGa2cKvGcE+1LQgsvJsr0yFR
 VJy4sQoNdJcuIc7oMupD7ITgqoAKAsjuZZusxwRbFTjJc52vRJgP/0hGLJXdzVq3P3r19L
 5WyRvzygj8B2JBXB13wX08lyO4vdhmc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1649345134;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=u5NLYRb0iRWqH+wp45tMsxWQ+2lcKX7UH+x3jrUc4CM=;
 b=h4c6BQrPPD9W33KeeEtgIxkffE6SxGamCvLBsxsw2FlmdG/K+M8MV8ruvANXF9Az9aOJRY
 CNJk3HEoegzTiHDg==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
 by relay2.suse.de (Postfix) with ESMTP id A2CECA3B94;
 Thu,  7 Apr 2022 15:25:34 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
 id 7459CDA80E; Thu,  7 Apr 2022 17:21:32 +0200 (CEST)
Date: Thu, 7 Apr 2022 17:21:32 +0200
From: David Sterba <dsterba@suse.cz>
To: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 10/27] block: add a bdev_nonrot helper
Message-ID: <20220407152132.GI15609@twin.jikos.cz>
Mail-Followup-To: dsterba@suse.cz, Christoph Hellwig <hch@lst.de>,
 Jens Axboe <axboe@kernel.dk>, dm-devel@redhat.com,
 linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-um@lists.infradead.org, linux-block@vger.kernel.org,
 drbd-dev@lists.linbit.com, nbd@other.debian.org,
 ceph-devel@vger.kernel.org,
 virtualization@lists.linux-foundation.org,
 xen-devel@lists.xenproject.org, linux-bcache@vger.kernel.org,
 linux-raid@vger.kernel.org, linux-mmc@vger.kernel.org,
 linux-mtd@lists.infradead.org, linux-nvme@lists.infradead.org,
 linux-s390@vger.kernel.org, linux-scsi@vger.kernel.org,
 target-devel@vger.kernel.org, linux-btrfs@vger.kernel.org,
 linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 cluster-devel@redhat.com, jfs-discussion@lists.sourceforge.net,
 linux-nilfs@vger.kernel.org, ntfs3@lists.linux.dev,
 ocfs2-devel@oss.oracle.com, linux-mm@kvack.org
References: <20220406060516.409838-1-hch@lst.de>
 <20220406060516.409838-11-hch@lst.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220406060516.409838-11-hch@lst.de>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Cc: jfs-discussion@lists.sourceforge.net, linux-nvme@lists.infradead.org,
 virtualization@lists.linux-foundation.org, linux-mm@kvack.org,
 dm-devel@redhat.com, target-devel@vger.kernel.org,
 linux-mtd@lists.infradead.org, drbd-dev@lists.linbit.com,
 linux-s390@vger.kernel.org, linux-nilfs@vger.kernel.org,
 linux-scsi@vger.kernel.org, cluster-devel@redhat.com,
 xen-devel@lists.xenproject.org, linux-ext4@vger.kernel.org,
 linux-um@lists.infradead.org, nbd@other.debian.org,
 linux-block@vger.kernel.org, linux-bcache@vger.kernel.org,
 ceph-devel@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
 linux-raid@vger.kernel.org, linux-mmc@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, linux-xfs@vger.kernel.org,
 ocfs2-devel@oss.oracle.com, linux-fsdevel@vger.kernel.org,
 ntfs3@lists.linux.dev, linux-btrfs@vger.kernel.org
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
Reply-To: dsterba@suse.cz
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

On Wed, Apr 06, 2022 at 08:04:59AM +0200, Christoph Hellwig wrote:
> Add a helper to check the nonrot flag based on the block_device instead
> of having to poke into the block layer internal request_queue.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  block/ioctl.c                       | 2 +-
>  drivers/block/loop.c                | 2 +-
>  drivers/md/dm-table.c               | 4 +---
>  drivers/md/md.c                     | 3 +--
>  drivers/md/raid1.c                  | 2 +-
>  drivers/md/raid10.c                 | 2 +-
>  drivers/md/raid5.c                  | 2 +-
>  drivers/target/target_core_file.c   | 3 +--
>  drivers/target/target_core_iblock.c | 2 +-

For

>  fs/btrfs/volumes.c                  | 4 ++--

Acked-by: David Sterba <dsterba@suse.com>
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
