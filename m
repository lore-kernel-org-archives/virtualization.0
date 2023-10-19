Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9CFD8CDB465
	for <virtualization@archiver.kernel.org>; Thu, 19 Oct 2023 09:48:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 294A840253;
	Thu, 19 Oct 2023 09:48:38 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 294A840253
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=bid4Be20
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id mk69UYZLHyEl; Thu, 19 Oct 2023 09:48:37 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 0EC1740151;
	Thu, 19 Oct 2023 09:48:36 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 0EC1740151
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C3FF4C0071;
	Thu, 19 Oct 2023 09:48:35 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B8526C0032
 for <virtualization@lists.linux-foundation.org>;
 Thu, 19 Oct 2023 09:48:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 8095342C57
 for <virtualization@lists.linux-foundation.org>;
 Thu, 19 Oct 2023 09:48:34 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 8095342C57
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com
 header.a=rsa-sha256 header.s=google header.b=bid4Be20
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id b7nUsZAC8poR
 for <virtualization@lists.linux-foundation.org>;
 Thu, 19 Oct 2023 09:48:33 +0000 (UTC)
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com
 [IPv6:2607:f8b0:4864:20::62e])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 7C8DE42C58
 for <virtualization@lists.linux-foundation.org>;
 Thu, 19 Oct 2023 09:48:33 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 7C8DE42C58
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-1c9b70b9656so51254265ad.1
 for <virtualization@lists.linux-foundation.org>;
 Thu, 19 Oct 2023 02:48:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance.com; s=google; t=1697708912; x=1698313712;
 darn=lists.linux-foundation.org; 
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=JY2RHi8J0dknAQahRfvff3wFWP0EUTol6JY9TKNymCE=;
 b=bid4Be20iXjmnvJuPv2QlQlQPHXZ6rnmkYlxdTsUvWqxPgkJ2FX0qYJz4sooCCjcvc
 vt12JE/wiryuAKTuXCVQlwXNlZ43dYTxNOG+hbD1xb0n3yI6M649bEy7wcDevVO1KRER
 AASc4ciHpKK1hUo++BJYZHZKqX8dnHSMs7t4z0CpEA0S1kPauiMudLPAn55fxGvT3t9f
 a7YiaSMeTMq8mAPyNcAGrWxPV8dIVpjE+y5GUrFrhY04Mxq4t+fUHaAPJy+7Aq3dB4XP
 6MykU/pdD4TIGW46uFJHtw9qD30XL4+yXCr0/vF6IE9jKov2sQnWlSEpGJQYzAp9J5Wm
 b3iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697708912; x=1698313712;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=JY2RHi8J0dknAQahRfvff3wFWP0EUTol6JY9TKNymCE=;
 b=VGAR6qiJwFBEWBcp6s8JVzflhK/7J62cNGwSTZujLSKv0PKCuLZP+stfZ69FRnlGmm
 tR0ez1CDoQSz2AKpZROKt3tyOYZkuQVuRqlMx5lqjmCGMkQFgpJMu1Ye/AwDhNAEJpq8
 +kR/CnWbBq9ywE72kLVj73twwiXmTXuze44caoY++K6URaE+RU/LjAriByQeDfMCC5NC
 VCn0THQ5qJBt/9DUdjg0MB0tVlSu9ZyN4SwmNDM8Lw6OUHTxNbDCmen+N6hOZC56zrPn
 XNOjOnv6vnLsOOkKV/l4LzBvKoYnlLg6ubBSg05Y/gJSlKzJOEBtAwjzFQACF7fPAnPY
 DDMg==
X-Gm-Message-State: AOJu0YxWRHKGtVFMwAPKn7jj/A/5RtuoEXOVrPA8hp3HPU9T7LcGKUDA
 QK+DUVAExkioLZreSO08Iu/P3w==
X-Google-Smtp-Source: AGHT+IFM9A5zHwr54bBJYZlxUokLUP7giAPuLnQTdz9Hgfwz+qQW/yzUe6+uFHzohQT8sKMvSM6sEw==
X-Received: by 2002:a17:902:ce81:b0:1ca:3d53:2867 with SMTP id
 f1-20020a170902ce8100b001ca3d532867mr2054272plg.15.1697708912629; 
 Thu, 19 Oct 2023 02:48:32 -0700 (PDT)
Received: from [10.3.43.196] ([61.213.176.12])
 by smtp.gmail.com with ESMTPSA id
 p6-20020a170902e74600b001bdd7579b5dsm1478111plf.240.2023.10.19.02.48.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 19 Oct 2023 02:48:32 -0700 (PDT)
Message-ID: <dedde8ee-6edb-4950-aa8b-e89e025440b7@bytedance.com>
Date: Thu, 19 Oct 2023 17:43:55 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: PING: [PATCH] virtio-blk: fix implicit overflow on virtio_max_dma_size
Content-Language: en-US
To: mst@redhat.com
References: <20230904061045.510460-1-pizhenwei@bytedance.com>
In-Reply-To: <20230904061045.510460-1-pizhenwei@bytedance.com>
Cc: axboe@kernel.dk, xuanzhuo@linux.alibaba.com, linux-kernel@vger.kernel.org,
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
From: zhenwei pi via Virtualization <virtualization@lists.linux-foundation.org>
Reply-To: zhenwei pi <pizhenwei@bytedance.com>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

Hi Michael,

This seems to have been ignored as you suggested.

LINK: https://www.spinics.net/lists/linux-virtualization/msg63015.html

On 9/4/23 14:10, zhenwei pi wrote:
> The following codes have an implicit conversion from size_t to u32:
> (u32)max_size = (size_t)virtio_max_dma_size(vdev);
> 
> This may lead overflow, Ex (size_t)4G -> (u32)0. Once
> virtio_max_dma_size() has a larger size than U32_MAX, use U32_MAX
> instead.
> 
> Signed-off-by: zhenwei pi <pizhenwei@bytedance.com>
> ---
>   drivers/block/virtio_blk.c | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
> index 1fe011676d07..4a4b9bad551e 100644
> --- a/drivers/block/virtio_blk.c
> +++ b/drivers/block/virtio_blk.c
> @@ -1313,6 +1313,7 @@ static int virtblk_probe(struct virtio_device *vdev)
>   	u16 min_io_size;
>   	u8 physical_block_exp, alignment_offset;
>   	unsigned int queue_depth;
> +	size_t max_dma_size;
>   
>   	if (!vdev->config->get) {
>   		dev_err(&vdev->dev, "%s failure: config access disabled\n",
> @@ -1411,7 +1412,8 @@ static int virtblk_probe(struct virtio_device *vdev)
>   	/* No real sector limit. */
>   	blk_queue_max_hw_sectors(q, UINT_MAX);
>   
> -	max_size = virtio_max_dma_size(vdev);
> +	max_dma_size = virtio_max_dma_size(vdev);
> +	max_size = max_dma_size > U32_MAX ? U32_MAX : max_dma_size;
>   
>   	/* Host can optionally specify maximum segment size and number of
>   	 * segments. */

-- 
zhenwei pi
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
