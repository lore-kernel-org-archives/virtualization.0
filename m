Return-Path: <SRS0=CXPs=PH=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9E4EC43219
	for <virtualization@archiver.kernel.org>; Tue, 19 Oct 2021 11:52:03 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5D7F56135E
	for <virtualization@archiver.kernel.org>; Tue, 19 Oct 2021 11:52:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 5D7F56135E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 2C94983C97;
	Tue, 19 Oct 2021 11:52:03 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id J9_1ciqkFe4W; Tue, 19 Oct 2021 11:52:02 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id DC6DD83C42;
	Tue, 19 Oct 2021 11:52:01 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id BB948C0011;
	Tue, 19 Oct 2021 11:52:01 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 37A74C000D
 for <virtualization@lists.linux-foundation.org>;
 Tue, 19 Oct 2021 11:52:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 26E0483C46
 for <virtualization@lists.linux-foundation.org>;
 Tue, 19 Oct 2021 11:52:01 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id wLwIIrl-x5Mv
 for <virtualization@lists.linux-foundation.org>;
 Tue, 19 Oct 2021 11:52:00 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 8274E83C42
 for <virtualization@lists.linux-foundation.org>;
 Tue, 19 Oct 2021 11:52:00 +0000 (UTC)
Received: by mail.kernel.org (Postfix) with ESMTPSA id B1D5B60FED;
 Tue, 19 Oct 2021 11:51:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1634644320;
 bh=//13uDQQNMbNmUnNCr9kAR4vydmZjWPTWfRAMUdlufc=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=AN+VU2Ma5/yW0PFSIk9Lc28PWbASdoBgmMVEAjz6OhblIjLudNvjQxqb3sBgQSMsC
 onAnybpCzbwZ4U3PM7B0ONJegnS3mlTpqrXb+Lv/KGPJGVD+m3XI18ldSaZ4+M0AwM
 c9057mRb1P/WsG3sH0aSwyIiDFCDaDcGh9uCvm5jL3lM08Lat5hG5MQrb3CUyha9fO
 KjV2VTgqDRf3S5A2IP8GU1Q7Z1mtkbMSzoCmmAixEmVDJAPiRKjJLwJOP2thvl22ku
 eoW+fCG0RhT2VRtlGD7DhItS4RDct82sgdgdGu8dSNDrfL8t61AorqC42btspP8fDG
 Zg7FSPVF2P4cg==
Date: Tue, 19 Oct 2021 14:51:56 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Jason Gunthorpe <jgg@nvidia.com>
Subject: Re: [PATCH mlx5-next 0/7] Clean MR key use across mlx5_* modules
Message-ID: <YW6xXL0WvI1HUczD@unreal>
References: <cover.1634033956.git.leonro@nvidia.com>
 <20211013144303.GF2744544@nvidia.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20211013144303.GF2744544@nvidia.com>
Cc: Aharon Landau <aharonl@nvidia.com>, linux-rdma@vger.kernel.org,
 netdev@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>,
 virtualization@lists.linux-foundation.org, Doug Ledford <dledford@redhat.com>,
 Shay Drory <shayd@nvidia.com>, Jakub Kicinski <kuba@kernel.org>,
 Maor Gottlieb <maorg@nvidia.com>, Saeed Mahameed <saeedm@nvidia.com>
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

On Wed, Oct 13, 2021 at 11:43:03AM -0300, Jason Gunthorpe wrote:
> On Tue, Oct 12, 2021 at 01:26:28PM +0300, Leon Romanovsky wrote:
> > From: Leon Romanovsky <leonro@nvidia.com>
> > 
> > Hi,
> > 
> > This is cleanup series of mlx5_* MR mkey management.
> > 
> > Thanks
> > 
> > Aharon Landau (7):
> >   RDMA/mlx5: Don't set esc_size in user mr
> 
> Please sent just this patch to -rc after modifying as I noted, don't
> put this in mlx5-next
> 
> >   RDMA/mlx5: Remove iova from struct mlx5_core_mkey
> >   RDMA/mlx5: Remove size from struct mlx5_core_mkey
> >   RDMA/mlx5: Remove pd from struct mlx5_core_mkey
> >   RDMA/mlx5: Replace struct mlx5_core_mkey by u32 key
> >   RDMA/mlx5: Move struct mlx5_core_mkey to mlx5_ib
> >   RDMA/mlx5: Attach ndescs to mlx5_ib_mkey
> 
> It seems fine to me, other than the little notes, a V2 can go to
> mlx5-next

Applied to vfio-next, to serve as a basis for live migration patches.
https://lore.kernel.org/kvm/20211019105838.227569-1-yishaih@nvidia.com/T/#m89f4f0ec4baddeb2828a2b38dcbbd6900009fb83

ae0579acde81 RDMA/mlx5: Attach ndescs to mlx5_ib_mkey
4123bfb0b28b RDMA/mlx5: Move struct mlx5_core_mkey to mlx5_ib
83fec3f12a59 RDMA/mlx5: Replace struct mlx5_core_mkey by u32 key
c64674168b6a RDMA/mlx5: Remove pd from struct mlx5_core_mkey
062fd731e51e RDMA/mlx5: Remove size from struct mlx5_core_mkey
cf6a8b1b24d6 RDMA/mlx5: Remove iova from struct mlx5_core_mkey

https://git.kernel.org/pub/scm/linux/kernel/git/mellanox/linux.git/log/?h=vfio-next

Thanks

> 
> Jason
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
