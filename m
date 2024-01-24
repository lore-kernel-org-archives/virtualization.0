Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEBB914F86
	for <virtualization@lists.linux-foundation.org>; Wed, 24 Jan 2024 06:56:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706079381; cv=none; b=hLTKg1zPYWuSuPlQIJGZHeyyA/vAYO0nudts8m07dezBhJDVXurbmfNK2sKuqWyuwblWJ2UHU/OjtnuQoyhd+XZIq//tJ8MgJXhWFRi8yS4PtKfbHkA6e/GbiuY3NuV6yoZFdzfYlCW04kVnAoUwew7y57yJ0dLipgAowtJnuFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706079381; c=relaxed/simple;
	bh=RXWqDRhO09xJ/eIEv2W5nBjTW9lNxTBkUCG4WRAuSaw=;
	h=Message-ID:Subject:Date:From:To:Cc:References:In-Reply-To; b=pBj3I436gYz+LqvL4AVob+YMCiI8Rr2E7mtT1YKF8QpLEhZzI/gPkVRFuwIRhnc06RQr/6/K6lCCpO/wpvNJLVIAJHC2dAR6xhS3P72UQfxXRnQ7vd4/kzvmjFL5+3qLGbflEzPHnWQqPZ8b1BMhyl1xahK15Naq99nIjKgIXf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.133
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 10D3042975
	for <virtualization@lists.linux-foundation.org>; Wed, 24 Jan 2024 06:56:19 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 10D3042975
X-Virus-Scanned: amavisd-new at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -9.899
X-Spam-Level:
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Hd_u5klZb0fv
	for <virtualization@lists.linux-foundation.org>;
	Wed, 24 Jan 2024 06:56:18 +0000 (UTC)
Received: from out30-101.freemail.mail.aliyun.com (out30-101.freemail.mail.aliyun.com [115.124.30.101])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 95BCE40017
	for <virtualization@lists.linux-foundation.org>; Wed, 24 Jan 2024 06:56:17 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 95BCE40017
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R611e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046059;MF=xuanzhuo@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0W.FWfaR_1706079371;
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0W.FWfaR_1706079371)
          by smtp.aliyun-inc.com;
          Wed, 24 Jan 2024 14:56:11 +0800
Message-ID: <1706079361.9479501-2-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH vhost] virtio_ring: add BUG_ON() when vq is set to premapped mode and vq is not empty
Date: Wed, 24 Jan 2024 14:56:01 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 Jason Wang <jasowang@redhat.com>,
 virtualization@lists.linux-foundation.org
References: <20231019070958.22919-1-xuanzhuo@linux.alibaba.com>
In-Reply-To: <20231019070958.22919-1-xuanzhuo@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>

On Thu, 19 Oct 2023 15:09:58 +0800, Xuan Zhuo <xuanzhuo@linux.alibaba.com> wrote:
> Add BUG_ON check to make sure virtqueue_set_dma_premapped() is not
> misused. This function must be called immediately after creating the vq,
> or after vq reset, and before adding any buffers to it.
>
> Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>

Hi Michael,

Is this in your list?

Thanks

> ---
>  drivers/virtio/virtio_ring.c | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
>
> diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> index 51d8f3299c10..3a3232272067 100644
> --- a/drivers/virtio/virtio_ring.c
> +++ b/drivers/virtio/virtio_ring.c
> @@ -2793,10 +2793,7 @@ int virtqueue_set_dma_premapped(struct virtqueue *_vq)
>
>  	num = vq->packed_ring ? vq->packed.vring.num : vq->split.vring.num;
>
> -	if (num != vq->vq.num_free) {
> -		END_USE(vq);
> -		return -EINVAL;
> -	}
> +	BUG_ON(num != vq->vq.num_free);
>
>  	if (!vq->use_dma_api) {
>  		END_USE(vq);
> --
> 2.32.0.3.g01195cf9f
>
