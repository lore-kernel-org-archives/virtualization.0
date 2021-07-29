Return-Path: <SRS0=atc4=MV=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30C24C4338F
	for <virtualization@archiver.kernel.org>; Thu, 29 Jul 2021 17:27:15 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E5CB46103B
	for <virtualization@archiver.kernel.org>; Thu, 29 Jul 2021 17:27:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org E5CB46103B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id A8E1983A8C;
	Thu, 29 Jul 2021 17:27:14 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 0CClE0zX6Uzk; Thu, 29 Jul 2021 17:27:13 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 3EDAA838F2;
	Thu, 29 Jul 2021 17:27:13 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 1899AC0010;
	Thu, 29 Jul 2021 17:27:13 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id CE266C000E
 for <virtualization@lists.linux-foundation.org>;
 Thu, 29 Jul 2021 17:27:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id BD35F608F1
 for <virtualization@lists.linux-foundation.org>;
 Thu, 29 Jul 2021 17:27:11 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=kernel.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id C0aNCW4Q839e
 for <virtualization@lists.linux-foundation.org>;
 Thu, 29 Jul 2021 17:27:11 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 2B66460726
 for <virtualization@lists.linux-foundation.org>;
 Thu, 29 Jul 2021 17:27:11 +0000 (UTC)
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1637B601FA;
 Thu, 29 Jul 2021 17:27:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1627579630;
 bh=kssTgqcbXEPlcdsvyvqpSjM1LIWESEJ+zCyffEvb604=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=YzdV9ItjgDa2iZKwe24iIX4qYDNymVr5eVUv7OJS1Ygxh2TLodDNSrffuR9zlPADi
 vjvOg9KwUNWxcUQVuCi1D1qllzOv/ryKTAGgtpvKEbPcRdu3VgmoXScsRweEPa/DjN
 78ak1uvc6m1PHtiuwtPFt7liiv8GcWfscpXa+XAOwWoTnV2NS8RMFM/1O6yjdFZkKU
 gHDpVXyKeXV2mMPBECU9HPcTVCNSWZJzcDzUpPFUjMecJ9xcPOBQIckHKnZr3abr2p
 7qKd8NAjlcispml/XK/ONvohYmYEDylbbBUATeg5B0RvKFD4pSJ19Yc/HPfVThpxz7
 aSwIlAPRjI+oQ==
Date: Thu, 29 Jul 2021 20:27:07 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Jason Gunthorpe <jgg@nvidia.com>
Subject: Re: [PATCH mlx5-next 1/5] RDMA/mlx5: Replace struct mlx5_core_mkey
 by u32 key
Message-ID: <YQLk65qM6oJ1J9fg@unreal>
References: <cover.1624362290.git.leonro@nvidia.com>
 <2e0feba18d8fe310b2ed38fbfbdd4af7a9b84bf1.1624362290.git.leonro@nvidia.com>
 <20210729152803.GA2394514@nvidia.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210729152803.GA2394514@nvidia.com>
Cc: Aharon Landau <aharonl@nvidia.com>, linux-rdma@vger.kernel.org,
 netdev@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 Doug Ledford <dledford@redhat.com>, Shay Drory <shayd@nvidia.com>,
 Jakub Kicinski <kuba@kernel.org>, Saeed Mahameed <saeedm@nvidia.com>
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

On Thu, Jul 29, 2021 at 12:28:03PM -0300, Jason Gunthorpe wrote:
> On Tue, Jun 22, 2021 at 03:08:19PM +0300, Leon Romanovsky wrote:
> 
> > diff --git a/drivers/net/ethernet/mellanox/mlx5/core/mr.c b/drivers/net/ethernet/mellanox/mlx5/core/mr.c
> > index 50af84e76fb6..7a76b5eb1c1a 100644
> > +++ b/drivers/net/ethernet/mellanox/mlx5/core/mr.c
> > @@ -35,13 +35,11 @@
> >  #include <linux/mlx5/driver.h>
> >  #include "mlx5_core.h"
> >  
> > -int mlx5_core_create_mkey(struct mlx5_core_dev *dev,
> > -			  struct mlx5_core_mkey *mkey,
> > -			  u32 *in, int inlen)
> > +int mlx5_core_create_mkey(struct mlx5_core_dev *dev, u32 *mkey, u32 *in,
> > +			  int inlen)
> >  {
> >  	u32 lout[MLX5_ST_SZ_DW(create_mkey_out)] = {};
> >  	u32 mkey_index;
> > -	void *mkc;
> >  	int err;
> >  
> >  	MLX5_SET(create_mkey_in, in, opcode, MLX5_CMD_OP_CREATE_MKEY);
> > @@ -50,38 +48,32 @@ int mlx5_core_create_mkey(struct mlx5_core_dev *dev,
> >  	if (err)
> >  		return err;
> >  
> > -	mkc = MLX5_ADDR_OF(create_mkey_in, in, memory_key_mkey_entry);
> >  	mkey_index = MLX5_GET(create_mkey_out, lout, mkey_index);
> > -	mkey->iova = MLX5_GET64(mkc, mkc, start_addr);
> > -	mkey->size = MLX5_GET64(mkc, mkc, len);
> > -	mkey->key |= mlx5_idx_to_mkey(mkey_index);
> > -	mkey->pd = MLX5_GET(mkc, mkc, pd);
> > -	init_waitqueue_head(&mkey->wait);
> > +	*mkey |= mlx5_idx_to_mkey(mkey_index);
> 
> 
> This conflicts with 0232fc2ddcf4 ("net/mlx5: Reset mkey index on creation")
> 
> Please resend/rebase. I think it should be fixed like
> 
> 	mkey_index = MLX5_GET(create_mkey_out, lout, mkey_index);
> 	*mkey = (u32)mlx5_mkey_variant(mkey->key) | mlx5_idx_to_mkey(mkey_index);
> 
> 	mlx5_core_dbg(dev, "out 0x%x, mkey 0x%x\n", mkey_index,	*mkey);
> ?

Yes, this is how it is fixed in my tree. I just waited till you finish the review.

> 
> (though I will look at the rest of the series today, so don't rush on
> this)
> 
> Jason
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
