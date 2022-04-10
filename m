Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20D5AC43219
	for <virtualization@archiver.kernel.org>; Sun, 10 Apr 2022 06:26:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 88D3741744;
	Sun, 10 Apr 2022 06:26:32 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id YDuoSU-MpSm5; Sun, 10 Apr 2022 06:26:31 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id A7EF541739;
	Sun, 10 Apr 2022 06:26:30 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 6B061C0033;
	Sun, 10 Apr 2022 06:26:30 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A6F20C002C
 for <virtualization@lists.linux-foundation.org>;
 Sun, 10 Apr 2022 06:26:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 7BDDF41744
 for <virtualization@lists.linux-foundation.org>;
 Sun, 10 Apr 2022 06:26:28 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id dmk7GNXex2ZD
 for <virtualization@lists.linux-foundation.org>;
 Sun, 10 Apr 2022 06:26:27 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 60BA641739
 for <virtualization@lists.linux-foundation.org>;
 Sun, 10 Apr 2022 06:26:26 +0000 (UTC)
Received: by verein.lst.de (Postfix, from userid 2407)
 id E057168AFE; Sun, 10 Apr 2022 08:26:20 +0200 (CEST)
Date: Sun, 10 Apr 2022 08:26:20 +0200
From: Christoph Hellwig <hch@lst.de>
To: Christoph =?iso-8859-1?Q?B=F6hmwalder?= <christoph.boehmwalder@linbit.com>
Subject: Re: [PATCH 24/27] block: remove QUEUE_FLAG_DISCARD
Message-ID: <20220410062620.GA16234@lst.de>
References: <20220409045043.23593-1-hch@lst.de>
 <20220409045043.23593-25-hch@lst.de>
 <72e9bd34-3380-e305-65f0-a17306f5bd08@linbit.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <72e9bd34-3380-e305-65f0-a17306f5bd08@linbit.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Cc: jfs-discussion@lists.sourceforge.net, linux-nvme@lists.infradead.org,
 virtualization@lists.linux-foundation.org, linux-mm@kvack.org,
 dm-devel@redhat.com, target-devel@vger.kernel.org,
 linux-mtd@lists.infradead.org, Christoph Hellwig <hch@lst.de>,
 drbd-dev@lists.linbit.com, linux-s390@vger.kernel.org,
 linux-nilfs@vger.kernel.org, linux-scsi@vger.kernel.org,
 cluster-devel@redhat.com, xen-devel@lists.xenproject.org,
 linux-ext4@vger.kernel.org, linux-um@lists.infradead.org, nbd@other.debian.org,
 linux-block@vger.kernel.org, linux-bcache@vger.kernel.org,
 ceph-devel@vger.kernel.org, Coly Li <colyli@suse.de>,
 Jens Axboe <axboe@kernel.dk>, linux-raid@vger.kernel.org,
 "Martin K . Petersen" <martin.petersen@oracle.com>, linux-mmc@vger.kernel.org,
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
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

On Sat, Apr 09, 2022 at 10:15:33AM +0200, Christoph B=F6hmwalder wrote:
> On 09.04.22 06:50, Christoph Hellwig wrote:
>> Just use a non-zero max_discard_sectors as an indicator for discard
>> support, similar to what is done for write zeroes.
>>
>> The only places where needs special attention is the RAID5 driver,
>> which must clear discard support for security reasons by default,
>> even if the default stacking rules would allow for it.
>>
>> Signed-off-by: Christoph Hellwig <hch@lst.de>
>> Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>
>> Acked-by: Christoph B=F6hmwalder <christoph.boehmwalder@linbit.com> [btr=
fs]
>
> I think you may have a typo there: my ACK was for drbd, not btrfs.

Indeed, sorry.
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
