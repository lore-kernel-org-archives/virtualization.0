Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37952C61DA4
	for <virtualization@archiver.kernel.org>; Thu,  2 Feb 2023 12:26:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id B5C45813A7;
	Thu,  2 Feb 2023 12:26:37 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org B5C45813A7
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=resnulli-us.20210112.gappssmtp.com header.i=@resnulli-us.20210112.gappssmtp.com header.a=rsa-sha256 header.s=20210112 header.b=4q0dez63
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id t2fAXA5Z7OJp; Thu,  2 Feb 2023 12:26:35 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 431BE813CD;
	Thu,  2 Feb 2023 12:26:35 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 431BE813CD
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 22CA9C0032;
	Thu,  2 Feb 2023 12:26:35 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0A290C002B
 for <virtualization@lists.linux-foundation.org>;
 Thu,  2 Feb 2023 12:26:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id C119A40285
 for <virtualization@lists.linux-foundation.org>;
 Thu,  2 Feb 2023 12:26:32 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org C119A40285
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=resnulli-us.20210112.gappssmtp.com
 header.i=@resnulli-us.20210112.gappssmtp.com header.a=rsa-sha256
 header.s=20210112 header.b=4q0dez63
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id YbWsIRd8ApAA
 for <virtualization@lists.linux-foundation.org>;
 Thu,  2 Feb 2023 12:26:32 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org D2A9B4023F
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com
 [IPv6:2a00:1450:4864:20::535])
 by smtp4.osuosl.org (Postfix) with ESMTPS id D2A9B4023F
 for <virtualization@lists.linux-foundation.org>;
 Thu,  2 Feb 2023 12:26:31 +0000 (UTC)
Received: by mail-ed1-x535.google.com with SMTP id d26so1450934eds.12
 for <virtualization@lists.linux-foundation.org>;
 Thu, 02 Feb 2023 04:26:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=resnulli-us.20210112.gappssmtp.com; s=20210112;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=S7sYYgg2jsSsqfHYoOgYRUdGHEvEeX7qXOLmHeKC8p8=;
 b=4q0dez63wK0NxgTf7F5Zykcqw+4CeVc/0tCYDtNPiMSqy9vSY3yKOlTkx6tXFZrqws
 I6Ug43xgnRW3iDn84HqXY5QuHaT1rWko/LNygdSFBmnRoEJ4x8cL668qKJMV67vo5Y3K
 HWgTz/a5D+jEpKoow0KIL0pd2C5kqJX13jh8hjCbFmy+LCS4FT3opw14/ESECSCaZOCS
 J6oKYmrrcOQ1Ridle3vUVcVErgNQm4L9d4LrgY+giiYBazUoEBMSmFGhNcqb+MWYlSH8
 eIOPwTDDmLVAY1MXX0GXR3Zn8IWEehBdXy7Y2RLjmana5EhvG6eiuUyQMqnCefTRCFTY
 VQHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=S7sYYgg2jsSsqfHYoOgYRUdGHEvEeX7qXOLmHeKC8p8=;
 b=yxm6scvoIJeCIxIXO0B7Wu4YBCyeCc9chart/rHJaGP1ipwfANwHo6Z708d7kxm+Zc
 jRywhVy5moQLt38bIwEi4/oKnAwJVBQv6z77Nl2SkDD/Csh13t0p2zuH5ualfszmDULV
 2nbFH9RH9Jfubc0k9Lu+7cToLtz7UmPO3NVVZnXdDstdL657HrCUbCAAdc02jI7KZaoK
 Rw3qtehFoEdGWdzOdO5nd6uWrtdGGW6t47qRKsfu6r9DIu91VjFPKT6F6AawU2o3ZS3Y
 B6T55osA9rEn2t3Sr1q6CbXG1JWmRjDnmLyQJnoFCxRIhlvYihHrlw+iCbBr/7BaQppg
 9JRw==
X-Gm-Message-State: AO0yUKWc8muF5iHb139veGgzbEBx4aQbjt0n+X/7avsmpaUyK7aUpZnH
 wUQrv1MFaWCbOxY4F/ZBm97vvw==
X-Google-Smtp-Source: AK7set9sq3vNdJzvyaY5Du3K2nGppq7h0EwWyufstEm28JWF8u8oBIMBlWycDc8DBS6RvVl1eI4e3A==
X-Received: by 2002:a05:6402:3488:b0:49d:9ff4:d82b with SMTP id
 v8-20020a056402348800b0049d9ff4d82bmr7422571edc.15.1675340790099; 
 Thu, 02 Feb 2023 04:26:30 -0800 (PST)
Received: from localhost ([86.61.181.4]) by smtp.gmail.com with ESMTPSA id
 t15-20020a508d4f000000b004a0e2fe619esm11152263edt.39.2023.02.02.04.26.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Feb 2023 04:26:29 -0800 (PST)
Date: Thu, 2 Feb 2023 13:26:28 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: Parav Pandit <parav@nvidia.com>
Subject: Re: [PATCH 2/2] virtio-net: Maintain reverse cleanup order
Message-ID: <Y9ur9B6CDIwThMN6@nanopsycho>
References: <20230202050038.3187-1-parav@nvidia.com>
 <20230202050038.3187-3-parav@nvidia.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20230202050038.3187-3-parav@nvidia.com>
Cc: hawk@kernel.org, daniel@iogearbox.net, mst@redhat.com,
 netdev@vger.kernel.org, ast@kernel.org,
 virtualization@lists.linux-foundation.org, edumazet@google.com,
 kuba@kernel.org, bpf@vger.kernel.org, pabeni@redhat.com, davem@davemloft.net
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

Thu, Feb 02, 2023 at 06:00:38AM CET, parav@nvidia.com wrote:
>To easily audit the code, better to keep the device stop()
>sequence to be mirror of the device open() sequence.
>
>Signed-off-by: Parav Pandit <parav@nvidia.com>

Reviewed-by: Jiri Pirko <jiri@nvidia.com>

If this is not fixing bug (which I believe is the case), you should
target it to net-next ([patch net-next] ..).


>---
> drivers/net/virtio_net.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>
>diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
>index b7d0b54c3bb0..1f8168e0f64d 100644
>--- a/drivers/net/virtio_net.c
>+++ b/drivers/net/virtio_net.c
>@@ -2279,9 +2279,9 @@ static int virtnet_close(struct net_device *dev)
> 	cancel_delayed_work_sync(&vi->refill);
> 
> 	for (i = 0; i < vi->max_queue_pairs; i++) {
>+		virtnet_napi_tx_disable(&vi->sq[i].napi);
> 		napi_disable(&vi->rq[i].napi);
> 		xdp_rxq_info_unreg(&vi->rq[i].xdp_rxq);
>-		virtnet_napi_tx_disable(&vi->sq[i].napi);
> 	}
> 
> 	return 0;
>-- 
>2.26.2
>
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
