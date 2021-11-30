Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D90ADC433FE
	for <virtualization@archiver.kernel.org>; Tue, 30 Nov 2021 23:35:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 620B3401EA;
	Tue, 30 Nov 2021 23:35:03 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id JdPufv8IIEs3; Tue, 30 Nov 2021 23:35:02 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id BC88E401D4;
	Tue, 30 Nov 2021 23:35:01 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8FB5CC001C;
	Tue, 30 Nov 2021 23:35:01 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id BFC05C000A
 for <virtualization@lists.linux-foundation.org>;
 Tue, 30 Nov 2021 23:35:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 979916075F
 for <virtualization@lists.linux-foundation.org>;
 Tue, 30 Nov 2021 23:35:00 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id G3VrLOJCwhzk
 for <virtualization@lists.linux-foundation.org>;
 Tue, 30 Nov 2021 23:35:00 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id E4993606B1
 for <virtualization@lists.linux-foundation.org>;
 Tue, 30 Nov 2021 23:34:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1638315298;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=GdpNBT7tOVqqTmqVJ8xdgf1nbTSEx6kcMW8RvUyDwUQ=;
 b=X4SwTL5jZvKKrF1kMjDFV2RVhf0S0b4Msu3UoU/xf87iwz3DrcVWGLSkEEXcsr7i7x7BG4
 ALLvuEJ3aH8xd6gCkbKWaRsvJB06Q38n2mgREm8+leKwp89sTtncTx+iWWI1vSWpNf4Dc5
 S8QIBrPTZtNlfgajYQ5WY26c1REMFy4=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-517-PWrRM7elObqWqeynqV0j0w-1; Tue, 30 Nov 2021 18:34:57 -0500
X-MC-Unique: PWrRM7elObqWqeynqV0j0w-1
Received: by mail-ed1-f69.google.com with SMTP id
 30-20020a508e5e000000b003f02e458b17so11649641edx.17
 for <virtualization@lists.linux-foundation.org>;
 Tue, 30 Nov 2021 15:34:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=GdpNBT7tOVqqTmqVJ8xdgf1nbTSEx6kcMW8RvUyDwUQ=;
 b=hFmqOTK+3zsnwE0jcH/qiCI4PKs1aD1b8uYJibO/p0ptn+vyQartvoEBEyjymQ3Bfd
 Kyj5nC9ht256BL4VG983VwIvTVRS4YG89j30wmEXbkGWgeznhgfJkApyCGwySUiV/SiU
 xZwogBpMHbZu7/l718hwePzxWPXokTE9lfjKHwaWeSLxzsyeV/pSgP3GQOhvqsyV5z73
 DB5lo9XsTTTSQj8rgjg62hzPVa4ECRJVFDwwhhJcIzodqVEb3bvtHx4kudJb5X91Dg76
 TFWvSUgXVUQCRhfWdFL7kqitiUuWILddxQKSGqcn1nw9KGYTz4F/TY3h1uIDc7daUaWi
 rH3w==
X-Gm-Message-State: AOAM531Z2YT85BoZ3t3BNpFcglLJQIFsel56fcNxkEqPjqD3FJUqwi/t
 5FBMOiUS1uK2vzeiPB3aKvW0+Np+0q5L7lYvjtaiDq8oIjvilFbH4EdKyLspTg5/WM3dZBvwPe1
 OouljGLJ5WHeDKt48MR9TuvPK8hnVfZesNg6VaiIaJA==
X-Received: by 2002:a17:906:4e42:: with SMTP id
 g2mr2642869ejw.230.1638315296070; 
 Tue, 30 Nov 2021 15:34:56 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyf8H+HN0kOqlHFT43UIstlOhAvrRhtSbI9tcJcD/y7tQP4Qind2uTR2BwAPdeqaxhjTGu6Bw==
X-Received: by 2002:a17:906:4e42:: with SMTP id
 g2mr2642852ejw.230.1638315295943; 
 Tue, 30 Nov 2021 15:34:55 -0800 (PST)
Received: from redhat.com ([2.53.15.215])
 by smtp.gmail.com with ESMTPSA id e1sm12182243edc.27.2021.11.30.15.34.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Nov 2021 15:34:55 -0800 (PST)
Date: Tue, 30 Nov 2021 18:34:51 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Parav Pandit <parav@nvidia.com>
Subject: Re: [PATCH v1] vdpa: Consider device id larger than 31
Message-ID: <20211130183432-mutt-send-email-mst@kernel.org>
References: <20211130042949.88958-1-parav@nvidia.com>
MIME-Version: 1.0
In-Reply-To: <20211130042949.88958-1-parav@nvidia.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: kbuild-all@lists.01.org, lkp@intel.com, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, edumazet@google.com,
 elic@nvidia.com, kbuild@lists.01.org, dan.carpenter@oracle.com
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

On Tue, Nov 30, 2021 at 06:29:49AM +0200, Parav Pandit wrote:
> virtio device id value can be more than 31. Hence, use BIT_ULL in
> assignment.
> 
> Fixes: 33b347503f01 ("vdpa: Define vdpa mgmt device, ops and a netlink interface")
> Reported-by: kernel test robot <lkp@intel.com>
> Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
> Signed-off-by: Parav Pandit <parav@nvidia.com>
> Acked-by: Jason Wang <jasowang@redhat.com>
> ---
> changelog:
> v0->v1:
>  - supporting device id up to 63
> ---
>  drivers/vdpa/vdpa.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/vdpa/vdpa.c b/drivers/vdpa/vdpa.c
> index 7332a74a4b00..09bbe53c3ac4 100644
> --- a/drivers/vdpa/vdpa.c
> +++ b/drivers/vdpa/vdpa.c
> @@ -404,7 +404,8 @@ static int vdpa_mgmtdev_fill(const struct vdpa_mgmt_dev *mdev, struct sk_buff *m
>  		goto msg_err;
>  
>  	while (mdev->id_table[i].device) {
> -		supported_classes |= BIT(mdev->id_table[i].device);
> +		if (mdev->id_table[i].device <= 63)
> +			supported_classes |= BIT_ULL(mdev->id_table[i].device);
>  		i++;
>  	}


Not for this release, but a for loop will be cleaner here.

> -- 
> 2.26.2

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
