Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D016C433EF
	for <virtualization@archiver.kernel.org>; Tue,  3 May 2022 16:39:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id D5D9583313;
	Tue,  3 May 2022 16:39:14 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 0asPNTn-RRS4; Tue,  3 May 2022 16:39:14 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 80AD18329E;
	Tue,  3 May 2022 16:39:13 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 4DD93C0032;
	Tue,  3 May 2022 16:39:13 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 506B8C002D
 for <virtualization@lists.linux-foundation.org>;
 Tue,  3 May 2022 16:39:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 381E261030
 for <virtualization@lists.linux-foundation.org>;
 Tue,  3 May 2022 16:39:12 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=kernel-dk.20210112.gappssmtp.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id d5pIYyaW2auI
 for <virtualization@lists.linux-foundation.org>;
 Tue,  3 May 2022 16:39:11 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com
 [IPv6:2607:f8b0:4864:20::102b])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 504E26102D
 for <virtualization@lists.linux-foundation.org>;
 Tue,  3 May 2022 16:39:10 +0000 (UTC)
Received: by mail-pj1-x102b.google.com with SMTP id
 gj17-20020a17090b109100b001d8b390f77bso2769544pjb.1
 for <virtualization@lists.linux-foundation.org>;
 Tue, 03 May 2022 09:39:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kernel-dk.20210112.gappssmtp.com; s=20210112;
 h=from:to:cc:in-reply-to:references:subject:message-id:date
 :mime-version:content-transfer-encoding;
 bh=s39mE0kiqCYA7ZYSMO88r6nrLoSeKkE/K4dp3BvGwGs=;
 b=pGDpCf7sl1d7573gjTTpqwkm3SiLycRrYLR/Cpm0xghxjpDf3AYMtstNaQt6JhXwCj
 hQ35tsdAS9xUuNcQ6bjTAIO4jrWGURYFn6WniUxLx9leI8Us/ZQXxmUsx5sXqR+3SMFs
 NPtnD8cP+Vrfqw+JIy3zA370Pyvn+VSXvM3gc7wLfoXTetostms9mgjy7Euc3hVJAm4j
 a9n45bGAUG8eOYOtc2pRDLYRKouGSmmTKZVBKYAG6yGnvzNVe7ulVhqBTMV0jNCtQJ1b
 eh8fwFdSJCS0763Fc+Es4Igf8he/A1M8/7QNTfbxn1mM2JdiBuUfp0c3rzGlnMqDUeCY
 VcJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:in-reply-to:references:subject
 :message-id:date:mime-version:content-transfer-encoding;
 bh=s39mE0kiqCYA7ZYSMO88r6nrLoSeKkE/K4dp3BvGwGs=;
 b=VPl/YpaWd3xsWyglIRkgcy07XShzNId+puFxcpaS8uvA0mTNxSHqc70v/phMGhEWiS
 rp2tMQPAzblKxs9Z1/Q6muiq4BePQvCVWhxePsRXrjMEuXmX/UK8AMIU3RHVE/qslFmT
 X09Tdtb0w9VNG41gogRNdTFMf5SllBTA83bUobDlPp43JrOHNpBo7uPLY/Pq2eHMUwDk
 Ak1gG1k5+J0MLtMx5N7SarhKgWZwSFFeZOUsdnTDtAp5HySqY+D4+BKacvL3TOn0TL2e
 BA79ut6P70jfOvNXBHKGO36fDXbDTPpwn9C6cSCM7OElSaUgTk/WvSGEPRwGQk1Z24Bw
 KlrA==
X-Gm-Message-State: AOAM531Q61eQ16ArR+mvIgVT+409DIzWwVUZrQYgpWCLOWJXoQU5GGyA
 jNRyPO0zmaD+sFKurnjyH5nEJA==
X-Google-Smtp-Source: ABdhPJynf+YKk08yAhS/p4BXstboFDeyZsD4FTBMM24xr+KLv+BRsvUdLzF1UAPk9hKAVzsu2Q8whQ==
X-Received: by 2002:a17:90a:9901:b0:1cb:aa19:5eee with SMTP id
 b1-20020a17090a990100b001cbaa195eeemr5645991pjp.158.1651595950265; 
 Tue, 03 May 2022 09:39:10 -0700 (PDT)
Received: from [127.0.1.1] ([8.34.116.185]) by smtp.gmail.com with ESMTPSA id
 m9-20020a17090a858900b001d9b7fa9562sm1559200pjn.28.2022.05.03.09.39.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 May 2022 09:39:09 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: Christoph Hellwig <hch@lst.de>
In-Reply-To: <20220418045314.360785-1-hch@lst.de>
References: <20220418045314.360785-1-hch@lst.de>
Subject: Re: fix and cleanup discard_alignment handling
Message-Id: <165159594780.2557.1712299203175316151.b4-ty@kernel.dk>
Date: Tue, 03 May 2022 10:39:07 -0600
MIME-Version: 1.0
Cc: hoeppner@linux.ibm.com, mst@redhat.com, linux-nvme@lists.infradead.org,
 virtualization@lists.linux-foundation.org, song@kernel.org,
 dm-devel@redhat.com, haris.iqbal@ionos.com, jinpu.wang@ionos.com,
 linux-s390@vger.kernel.org, richard@nod.at, xen-devel@lists.xenproject.org,
 linux-um@lists.infradead.org, snitzer@kernel.org, josef@toxicpanda.com,
 nbd@other.debian.org, linux-raid@vger.kernel.org, sth@linux.ibm.com,
 linux-block@vger.kernel.org, martin.petersen@oracle.com,
 johannes@sipsolutions.net, roger.pau@citrix.com
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

On Mon, 18 Apr 2022 06:53:03 +0200, Christoph Hellwig wrote:
> the somewhat confusing name of the discard_alignment queue limit, that
> really is an offset for the discard granularity mislead a lot of driver
> authors to set it to an incorrect value.  This series tries to fix up
> all these cases.
> 
> Diffstat:
>  arch/um/drivers/ubd_kern.c         |    1 -
>  drivers/block/loop.c               |    1 -
>  drivers/block/nbd.c                |    3 ---
>  drivers/block/null_blk/main.c      |    1 -
>  drivers/block/rnbd/rnbd-srv-dev.h  |    2 +-
>  drivers/block/virtio_blk.c         |    7 ++++---
>  drivers/block/xen-blkback/xenbus.c |    4 ++--
>  drivers/md/dm-zoned-target.c       |    2 +-
>  drivers/md/raid5.c                 |    1 -
>  drivers/nvme/host/core.c           |    1 -
>  drivers/s390/block/dasd_fba.c      |    1 -
>  11 files changed, 8 insertions(+), 16 deletions(-)
> 
> [...]

Applied, thanks!

[01/11] ubd: don't set the discard_alignment queue limit
        commit: 07c6e92a8478770a7302f7dde72f03a5465901bd
[02/11] nbd: don't set the discard_alignment queue limit
        commit: 4a04d517c56e0616c6f69afc226ee2691e543712
[03/11] null_blk: don't set the discard_alignment queue limit
        commit: fb749a87f4536d2fa86ea135ae4eff1072903438
[04/11] virtio_blk: fix the discard_granularity and discard_alignment queue limits
        commit: 62952cc5bccd89b76d710de1d0b43244af0f2903
[05/11] dm-zoned: don't set the discard_alignment queue limit
        commit: 44d583702f4429763c558624fac763650a1f05bf
[06/11] raid5: don't set the discard_alignment queue limit
        commit: 3d50d368c92ade2f98a3d0d28b842a57c35284e9
[07/11] dasd: don't set the discard_alignment queue limit
        commit: c3f765299632727fa5ea5a0acf118665227a4f1a
[08/11] loop: remove a spurious clear of discard_alignment
        commit: 4418bfd8fb9602d9cd8747c3ad52fdbaa02e2ffd
[09/11] nvme: remove a spurious clear of discard_alignment
        commit: 4e7f0ece41e1be8f876f320a0972a715daec0a50
[10/11] rnbd-srv: use bdev_discard_alignment
        commit: 18292faa89d2bff3bdd33ab9c065f45fb6710e47
[11/11] xen-blkback: use bdev_discard_alignment
        commit: c899b23533866910c90ef4386b501af50270d320

Best regards,
-- 
Jens Axboe


_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
