Return-Path: <SRS0=TY3O=PA=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1488C433F5
	for <virtualization@archiver.kernel.org>; Tue, 12 Oct 2021 14:14:29 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6F2F060EFE
	for <virtualization@archiver.kernel.org>; Tue, 12 Oct 2021 14:14:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 6F2F060EFE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 3DAB360664;
	Tue, 12 Oct 2021 14:14:29 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id WQDwubVyMKyQ; Tue, 12 Oct 2021 14:14:28 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id B34E160658;
	Tue, 12 Oct 2021 14:14:27 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 659D1C000F;
	Tue, 12 Oct 2021 14:14:27 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 914B2C000D
 for <virtualization@lists.linux-foundation.org>;
 Tue, 12 Oct 2021 14:14:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 8011480CB9
 for <virtualization@lists.linux-foundation.org>;
 Tue, 12 Oct 2021 14:14:26 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=kernel.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id PTllK5Yw5LXh
 for <virtualization@lists.linux-foundation.org>;
 Tue, 12 Oct 2021 14:14:25 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 5883780CB5
 for <virtualization@lists.linux-foundation.org>;
 Tue, 12 Oct 2021 14:14:25 +0000 (UTC)
Received: by mail.kernel.org (Postfix) with ESMTPSA id 419A260EFE;
 Tue, 12 Oct 2021 14:14:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1634048065;
 bh=Lne+e+L1HpFcvPT6IkNOvPQQwI5RziJjezB3HEARZts=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=uBZ4T55jP7PDLI9I3qVzMGnQg5UxpxwTPO/3oJNo0dBrb64ji4neVN+gTIdQWguWs
 KbluoLSzWua+3yLYio+vTJdpquLO2hLxXBq8+zl3av2f8qO29pzlahkBYHWDiNUaHy
 86+ZF8I01nLmgBHvl0iLFJF7Vfhke9N+FGJM5UVjPpySeF4Zx+ODPPRfjzduGYqp37
 NpIEoQwwVDNwqM6myfxjRLBjdklXj6fKUujRaa1dcqzQjxWyOG/IUQjRI7c80Md3YF
 mBcfoJ2bJGNdA8AX8ZrLlihU2r4rR3MXqudsOPLvV4L7Fo9W3EVVFGtZk07TABrBdM
 xTm8HSaxtgvkw==
Date: Tue, 12 Oct 2021 17:14:20 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Jason Gunthorpe <jgg@nvidia.com>
Subject: Re: [PATCH mlx5-next 1/7] RDMA/mlx5: Don't set esc_size in user mr
Message-ID: <YWWYPCHv6moPv5pW@unreal>
References: <cover.1634033956.git.leonro@nvidia.com>
 <f60a002566ae19014659afe94d7fcb7a10cfb353.1634033956.git.leonro@nvidia.com>
 <20211012125234.GU2744544@nvidia.com>
 <fdae8091-337d-a21d-d31d-5270e5029bb8@nvidia.com>
 <20211012140433.GV2744544@nvidia.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20211012140433.GV2744544@nvidia.com>
Cc: Aharon Landau <aharonl@nvidia.com>, linux-rdma@vger.kernel.org,
 netdev@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 Saeed Mahameed <saeedm@nvidia.com>, Doug Ledford <dledford@redhat.com>,
 Jakub Kicinski <kuba@kernel.org>, Maor Gottlieb <maorg@nvidia.com>,
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

On Tue, Oct 12, 2021 at 11:04:33AM -0300, Jason Gunthorpe wrote:
> On Tue, Oct 12, 2021 at 04:57:16PM +0300, Aharon Landau wrote:
> > 
> > On 10/12/2021 3:52 PM, Jason Gunthorpe wrote:
> > > On Tue, Oct 12, 2021 at 01:26:29PM +0300, Leon Romanovsky wrote:
> > > > From: Aharon Landau <aharonl@nvidia.com>
> > > > 
> > > > reg_create() is used for user MRs only and should not set desc_size at
> > > > all. Attempt to set it causes to the following trace:
> > > > 
> > > > BUG: unable to handle page fault for address: 0000000800000000
> > > > PGD 0 P4D 0
> > > > Oops: 0000 [#1] SMP PTI
> > > > CPU: 5 PID: 890 Comm: ib_write_bw Not tainted 5.15.0-rc4+ #47
> > > > Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.13.0-0-gf21b5a4aeb02-prebuilt.qemu.org 04/01/2014
> > > > RIP: 0010:mlx5_ib_dereg_mr+0x14/0x3b0 [mlx5_ib]
> > > > Code: 48 63 cd 4c 89 f7 48 89 0c 24 e8 37 30 03 e1 48 8b 0c 24 eb a0 90 0f 1f 44 00 00 41 56 41 55 41 54 55 53 48 89 fb 48 83 ec 30 <48> 8b 2f 65 48 8b 04 25 28 00 00 00 48 89 44 24 28 31 c0 8b 87 c8
> > > > RSP: 0018:ffff88811afa3a60 EFLAGS: 00010286
> > > > RAX: 000000000000001c RBX: 0000000800000000 RCX: 0000000000000000
> > > > RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000800000000
> > > > RBP: 0000000800000000 R08: 0000000000000000 R09: c0000000fffff7ff
> > > > R10: ffff88811afa38f8 R11: ffff88811afa38f0 R12: ffffffffa02c7ac0
> > > > R13: 0000000000000000 R14: ffff88811afa3cd8 R15: ffff88810772fa00
> > > > FS:  00007f47b9080740(0000) GS:ffff88852cd40000(0000) knlGS:0000000000000000
> > > > CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > > > CR2: 0000000800000000 CR3: 000000010761e003 CR4: 0000000000370ea0
> > > > DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> > > > DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> > > > Call Trace:
> > > >   mlx5_ib_free_odp_mr+0x95/0xc0 [mlx5_ib]
> > > >   mlx5_ib_dereg_mr+0x128/0x3b0 [mlx5_ib]
> > > >   ib_dereg_mr_user+0x45/0xb0 [ib_core]
> > > >   ? xas_load+0x8/0x80
> > > >   destroy_hw_idr_uobject+0x1a/0x50 [ib_uverbs]
> > > >   uverbs_destroy_uobject+0x2f/0x150 [ib_uverbs]
> > > >   uobj_destroy+0x3c/0x70 [ib_uverbs]
> > > >   ib_uverbs_cmd_verbs+0x467/0xb00 [ib_uverbs]
> > > >   ? uverbs_finalize_object+0x60/0x60 [ib_uverbs]
> > > >   ? ttwu_queue_wakelist+0xa9/0xe0
> > > >   ? pty_write+0x85/0x90
> > > >   ? file_tty_write.isra.33+0x214/0x330
> > > >   ? process_echoes+0x60/0x60
> > > >   ib_uverbs_ioctl+0xa7/0x110 [ib_uverbs]
> > > >   __x64_sys_ioctl+0x10d/0x8e0
> > > >   ? vfs_write+0x17f/0x260
> > > >   do_syscall_64+0x3c/0x80
> > > >   entry_SYSCALL_64_after_hwframe+0x44/0xae
> > > > 
> > > > Fixes: a639e66703ee ("RDMA/mlx5: Zero out ODP related items in the mlx5_ib_mr")
> > > Can you explain why this is crashing?
> > > 
> > > reg_create isn't used on the ODP implicit children path.
> > > 
> > > Jason
> > It is not implicit ODP flow, therefore, mr->implicit_children shouldn't be
> > set.
> 
> It should always be initialized. That seems to be the bug here, add the
> missing xa_init as well as delete the extra desc_size set:

I would expect such change in mlx5_ib_init_odp_mr().

> 
> diff --git a/drivers/infiniband/hw/mlx5/mr.c b/drivers/infiniband/hw/mlx5/mr.c
> index b4d2322e9ca564..46626e0fe08905 100644
> --- a/drivers/infiniband/hw/mlx5/mr.c
> +++ b/drivers/infiniband/hw/mlx5/mr.c
> @@ -1525,6 +1525,7 @@ static struct ib_mr *create_user_odp_mr(struct ib_pd *pd, u64 start, u64 length,
>                 ib_umem_release(&odp->umem);
>                 return ERR_CAST(mr);
>         }
> +       xa_init(&mr->implicit_children);
>  
>         odp->private = mr;
>         err = mlx5r_store_odp_mkey(dev, &mr->mmkey);
> 
> Jason
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
