Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3DC5CC636CC
	for <virtualization@archiver.kernel.org>; Mon, 13 Feb 2023 12:19:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id C861481437;
	Mon, 13 Feb 2023 12:19:28 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org C861481437
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=M5S7xoJo
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id BypFBQBFSBnL; Mon, 13 Feb 2023 12:19:28 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 5B5028142C;
	Mon, 13 Feb 2023 12:19:27 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 5B5028142C
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 34186C0032;
	Mon, 13 Feb 2023 12:19:27 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 630CEC002B
 for <virtualization@lists.linux-foundation.org>;
 Mon, 13 Feb 2023 12:19:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 3154E40613
 for <virtualization@lists.linux-foundation.org>;
 Mon, 13 Feb 2023 12:19:26 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 3154E40613
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=M5S7xoJo
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 3be6ACv9MhwC
 for <virtualization@lists.linux-foundation.org>;
 Mon, 13 Feb 2023 12:19:25 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 69F82403EA
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 69F82403EA
 for <virtualization@lists.linux-foundation.org>;
 Mon, 13 Feb 2023 12:19:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1676290763;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=oDnt5PK/UegV16aqc8u4iwm5wDCJSMDwfzgLnt/OavA=;
 b=M5S7xoJo4Z4kLm5IBFYvseZtaRouVjMFdYRggjiilcuveuG5+RZ5WDhiGkhezbedlc78hj
 sKDfxoh0oulOPcRWtGPXOHwWHg+WcZh6FpxSmcKSEka81Xnsj0cLaSPhuaDOSYlKCjOikd
 AyG3L5V+Awg2BQwtQio0uFRBMemk2LA=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-169-y4ydC3SaMA65f1Hdj2ueIA-1; Mon, 13 Feb 2023 07:19:18 -0500
X-MC-Unique: y4ydC3SaMA65f1Hdj2ueIA-1
Received: by mail-wr1-f71.google.com with SMTP id
 l15-20020adff48f000000b002c55dbddb59so363727wro.6
 for <virtualization@lists.linux-foundation.org>;
 Mon, 13 Feb 2023 04:19:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oDnt5PK/UegV16aqc8u4iwm5wDCJSMDwfzgLnt/OavA=;
 b=Kr9ZINHnJw5gBGaaWp50IvOao7SVu+rVb2h190hMkfSqy/g7zp5h68RW4/xujUt1YR
 qPBRbKefmJp3wrnDX4nWchJpT19+BEoSzz3r3HLHfLDrcjqvg+y+sUkmBHBb/a5LdqI6
 AHq9T5jx9G0RNKj+n3C4B7kGCDOlD9L4BSdz6WxrJeKPjNGrYmUg2At1A9iL1S82DI6J
 tHizSzpgWzAPEu3URuO3qhWYWZu80dMKktQCcnksvXDYSvDK0oeE1SdbCyA/X0g7xdro
 NDUha26B5R8nu76wbWPdejBvNNHn5hMB9zHpL1hzoK4CJC33lga2UfuL3JbJJDV5qfWg
 GyCA==
X-Gm-Message-State: AO0yUKUIsad7Xy+ID0SkjDNhPrvDANESnxhPhpSj2rear5BCyuSWKmnC
 TdHefbMnUmaOoESHIDx833Dncd2hBGcdzrcqaQDZ0bibU3R+Z2CnFXMnMGGL5OBxLlISC8DYDAg
 jNoumt23XVVZkUlsFu32kHKCc3YlF2k11eLtgkP4Y0g==
X-Received: by 2002:a5d:5588:0:b0:2c5:6046:9244 with SMTP id
 i8-20020a5d5588000000b002c560469244mr513120wrv.53.1676290755869; 
 Mon, 13 Feb 2023 04:19:15 -0800 (PST)
X-Google-Smtp-Source: AK7set+xU34cCOOirxqXp6rIcvtao8qZMReQ7svnyFJcAZ1hW0XVm6jaz4gWG87NqrJrnIeiNihewA==
X-Received: by 2002:a5d:5588:0:b0:2c5:6046:9244 with SMTP id
 i8-20020a5d5588000000b002c560469244mr513107wrv.53.1676290755666; 
 Mon, 13 Feb 2023 04:19:15 -0800 (PST)
Received: from redhat.com ([2.52.132.212]) by smtp.gmail.com with ESMTPSA id
 q1-20020a05600000c100b002c54d8b89efsm6389678wrx.26.2023.02.13.04.19.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 Feb 2023 04:19:15 -0800 (PST)
Date: Mon, 13 Feb 2023 07:19:11 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Eli Cohen <elic@nvidia.com>
Subject: Re: [PATCH 2/2] vdpa/mlx5: Initialize CVQ iotlb spinlock
Message-ID: <20230213071855-mutt-send-email-mst@kernel.org>
References: <20230206122016.1149373-1-elic@nvidia.com>
MIME-Version: 1.0
In-Reply-To: <20230206122016.1149373-1-elic@nvidia.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: eperezma@redhat.com, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org
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

On Mon, Feb 06, 2023 at 02:20:16PM +0200, Eli Cohen wrote:
> Initialize itolb spinlock.
> 
> Fixes: 5262912ef3cf ("vdpa/mlx5: Add support for control VQ and MAC setting")
> Signed-off-by: Eli Cohen <elic@nvidia.com>

threading was broken here but whatevs.

> ---
>  drivers/vdpa/mlx5/core/resources.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/vdpa/mlx5/core/resources.c b/drivers/vdpa/mlx5/core/resources.c
> index 45ad41287a31..d5a59c9035fb 100644
> --- a/drivers/vdpa/mlx5/core/resources.c
> +++ b/drivers/vdpa/mlx5/core/resources.c
> @@ -233,6 +233,7 @@ static int init_ctrl_vq(struct mlx5_vdpa_dev *mvdev)
>  	if (!mvdev->cvq.iotlb)
>  		return -ENOMEM;
>  
> +	spin_lock_init(&mvdev->cvq.iommu_lock);
>  	vringh_set_iotlb(&mvdev->cvq.vring, mvdev->cvq.iotlb, &mvdev->cvq.iommu_lock);
>  
>  	return 0;
> -- 
> 2.38.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
