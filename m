Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8BBF4C433F5
	for <virtualization@archiver.kernel.org>; Tue, 11 Jan 2022 12:11:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 2C6B883004;
	Tue, 11 Jan 2022 12:11:02 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id nfctTFGi8Qed; Tue, 11 Jan 2022 12:11:01 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id C3DB682DE6;
	Tue, 11 Jan 2022 12:11:00 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 9B9A6C0030;
	Tue, 11 Jan 2022 12:11:00 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0E424C001E
 for <virtualization@lists.linux-foundation.org>;
 Tue, 11 Jan 2022 12:10:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 0907182FA9
 for <virtualization@lists.linux-foundation.org>;
 Tue, 11 Jan 2022 12:10:59 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id F8xiqjlo7BGS
 for <virtualization@lists.linux-foundation.org>;
 Tue, 11 Jan 2022 12:10:58 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 275DF82DE6
 for <virtualization@lists.linux-foundation.org>;
 Tue, 11 Jan 2022 12:10:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1641903057;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=DYKb1h3UwTvIBrak+dO+HI8WQ8cA3RqwZIRXKYvylUU=;
 b=KvfUYdIAGux/bmU1nfZCCeuPR8jI/jMT1X5ClxZ1S17XMCUpZkna6nn/DD14lWbYrjTZRs
 Vvdu6v062iV1cn3ciuIGvbqKdbMUDg+7Y6m9ESXYtYfC1wb6MAXj0lmEVnub6zJF2uZbFZ
 ExZ7hKQ1gQq4jE8P/Sag5/eQp5PsARU=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-614-Dumx4bWCOAqyHbwTq05otQ-1; Tue, 11 Jan 2022 07:10:56 -0500
X-MC-Unique: Dumx4bWCOAqyHbwTq05otQ-1
Received: by mail-wm1-f72.google.com with SMTP id
 c5-20020a1c3505000000b00345c92c27c6so1444278wma.2
 for <virtualization@lists.linux-foundation.org>;
 Tue, 11 Jan 2022 04:10:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=DYKb1h3UwTvIBrak+dO+HI8WQ8cA3RqwZIRXKYvylUU=;
 b=gUpAH1iMJoQBszzShLh994FmGDrZjW48SJkWYzjusNo9E67JGu63eg3sVvt0EaQyEJ
 RweduVB+sJhYXbbgeSaTs3L6byS++EECP4+NWJDhFJPk+MNtgdm64u6IGuf10l8jaewH
 BQs7rOJUp/Dljsmf6GMkTgibfCS2tqMA3D7f7XGXpgnDW5fgcmlpj6Qhwx/TyCcbMUj/
 ORRy2ertp29lQf3WS478s7Sdh6DR47SKdWkhaI0REbs1kMOnakshTWfRxpMywPGYGJlh
 ibeSeGzgCm6GfoATFC6etfr+QS2p2gfIpoBMMt6/GbEYY2d6rgh1n8ll565iu2P+ygB+
 f3Ag==
X-Gm-Message-State: AOAM533IsQkRnMNlzIx46dI1SACHMW2EhZSIdFKNaYsmRystsPF/aotu
 lzYiDCfWx1Edsoxdw4IYJbcKKGD+zngiGmdNQrjqkQ6TtMUAU++EFSJNsSALen06tJjXgB3xF35
 2JfHFtW6owbiMUkfNiXnO23+L+6LiCj0lSCaVJtCfEA==
X-Received: by 2002:a05:6000:144c:: with SMTP id
 v12mr3569858wrx.266.1641903054782; 
 Tue, 11 Jan 2022 04:10:54 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzu3Y99qyugGADX79dDriIviOcrMFSs0fcAU42htyD5Wop+3caeJ98xXCJoTzv84Ag6iWuVtA==
X-Received: by 2002:a05:6000:144c:: with SMTP id
 v12mr3569849wrx.266.1641903054603; 
 Tue, 11 Jan 2022 04:10:54 -0800 (PST)
Received: from redhat.com ([2.55.5.100])
 by smtp.gmail.com with ESMTPSA id w10sm7827165wrn.81.2022.01.11.04.10.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Jan 2022 04:10:54 -0800 (PST)
Date: Tue, 11 Jan 2022 07:10:50 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Si-Wei Liu <si-wei.liu@oracle.com>
Subject: Re: [PATCH 2/4] vdpa/mlx5: Fix is_index_valid() to refer to features
Message-ID: <20220111070943-mutt-send-email-mst@kernel.org>
References: <20220111072253.101884-1-elic@nvidia.com>
 <00619365-173b-bd2c-3a9f-c6d7084631fb@oracle.com>
MIME-Version: 1.0
In-Reply-To: <00619365-173b-bd2c-3a9f-c6d7084631fb@oracle.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: lvivier@redhat.com, virtualization@lists.linux-foundation.org,
 eperezma@redhat.com, Eli Cohen <elic@nvidia.com>
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

On Tue, Jan 11, 2022 at 01:31:28AM -0800, Si-Wei Liu wrote:
> 
> 
> On 1/10/2022 11:22 PM, Eli Cohen wrote:
> > Make sure the decision whether an index received trough a callback is
> > valid or not consults the negotiated features.
> > 
> > Signed-off-by: Eli Cohen <elic@nvidia.com>
> Reviewed-by: Si-Wei Liu<si-wei.liu@oracle.com>
> 
> Is there more for this series? Subject says there're 4 patches in total?

OK so with this + 1/4 are we OK with v7 of the big patchset now?
I'm kind of beginning to worry it's rushed ...
Jason?


> > ---
> >   drivers/vdpa/mlx5/net/mlx5_vnet.c | 10 +++++++---
> >   1 file changed, 7 insertions(+), 3 deletions(-)
> > 
> > diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> > index d1ff65065fb1..9eacfdb48434 100644
> > --- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
> > +++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> > @@ -133,10 +133,14 @@ struct mlx5_vdpa_virtqueue {
> >   static bool is_index_valid(struct mlx5_vdpa_dev *mvdev, u16 idx)
> >   {
> > -	if (unlikely(idx > mvdev->max_idx))
> > -		return false;
> > +	if (!(mvdev->actual_features & BIT_ULL(VIRTIO_NET_F_MQ))) {
> > +		if (!(mvdev->actual_features & BIT_ULL(VIRTIO_NET_F_CTRL_VQ)))
> > +			return idx < 2;
> > +		else
> > +			return idx < 3;
> > +	}
> > -	return true;
> > +	return idx <= mvdev->max_idx;
> >   }
> >   struct mlx5_vdpa_net {

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
