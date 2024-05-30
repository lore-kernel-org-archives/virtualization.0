Received: from out30-100.freemail.mail.aliyun.com (out30-100.freemail.mail.aliyun.com [115.124.30.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEBEF2F32
	for <virtualization@lists.linux.dev>; Thu, 30 May 2024 09:57:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717063050; cv=none; b=uQDbaiHe2yZ23PVnHt02ZallBr73t1FnbavcMWd/Y45jHP3IajhCs2bpQbrL8HMh/StimqbR64jrnZ1Rer2o9TxzKGBeZxvP1Ny4aQ7ZUl0lTnjkBuy9KlWgtfxJ3radKmAQkELiTqGLIAKe4XpQxJahqLj30162SmWiUdpwjQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717063050; c=relaxed/simple;
	bh=6tPPF5p07qqE4+gfixCRSXVmBopCTP0rtZ88qOVjB6o=;
	h=Message-ID:Subject:Date:From:To:Cc:References:In-Reply-To; b=palz4VTzt3McZDZ9gKpabksRtp3Vb/8T2snmacxDHlMF0h4s78EyTI3LRsbg7piP+698SB0He8nuj2NrVLwjs1FR7w2VlBGl9qtIODTeqlMmBd1HOdaexi3jknHXEr7A0OhmK2jhDYbyGSqa5tB5BmK50CPYi6en7tbEJ3QY5P4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=l7aUEFL3; arc=none smtp.client-ip=115.124.30.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="l7aUEFL3"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1717063045; h=Message-ID:Subject:Date:From:To;
	bh=tSV0376ZojWcMEF9RtRlTHwjGLM92k+YogAGvqY4OTE=;
	b=l7aUEFL3h2WHwlajO0VZEetEsfOcNWRawyHWSLvwp6KRz3PZJjDOAaALdR0Qk9MvDs51hvI4F9f4C8Z9G4HJbjClOHwEe0PP/41KgOZqsvJ4OJmOS6xviM9PioTWYIdFIVMUBFQyJ1v1M2PRMR71OoztKJJKo8U1XhUsnCWDHKU=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R121e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037067111;MF=xuanzhuo@linux.alibaba.com;NM=1;PH=DS;RN=12;SR=0;TI=SMTPD_---0W7WdnBk_1717063044;
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0W7WdnBk_1717063044)
          by smtp.aliyun-inc.com;
          Thu, 30 May 2024 17:57:24 +0800
Message-ID: <1717063037.5295053-1-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH net v3 1/2] virtio_net: fix possible dim status unrecoverable
Date: Thu, 30 May 2024 17:57:17 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: Heng Qi <hengqi@linux.alibaba.com>
Cc: Jason Wang <jasowang@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>,
 Jiri Pirko <jiri@resnulli.us>,
 Daniel Jurgens <danielj@nvidia.com>,
 Jiri Pirko <jiri@nvidia.com>,
 netdev@vger.kernel.org,
 virtualization@lists.linux.dev
References: <20240528134116.117426-1-hengqi@linux.alibaba.com>
 <20240528134116.117426-2-hengqi@linux.alibaba.com>
In-Reply-To: <20240528134116.117426-2-hengqi@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>

On Tue, 28 May 2024 21:41:15 +0800, Heng Qi <hengqi@linux.alibaba.com> wrote:
> When the dim worker is scheduled, if it no longer needs to issue
> commands, dim may not be able to return to the working state later.
>
> For example, the following single queue scenario:
>   1. The dim worker of rxq0 is scheduled, and the dim status is
>      changed to DIM_APPLY_NEW_PROFILE;
>   2. dim is disabled or parameters have not been modified;
>   3. virtnet_rx_dim_work exits directly;
>
> Then, even if net_dim is invoked again, it cannot work because the
> state is not restored to DIM_START_MEASURE.
>
> Fixes: 6208799553a8 ("virtio-net: support rx netdim")
> Signed-off-by: Heng Qi <hengqi@linux.alibaba.com>
> Reviewed-by: Jiri Pirko <jiri@nvidia.com>

Reviewed-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>

> ---
>  drivers/net/virtio_net.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index 4a802c0ea2cb..4f828a9e5889 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -4417,9 +4417,9 @@ static void virtnet_rx_dim_work(struct work_struct *work)
>  		if (err)
>  			pr_debug("%s: Failed to send dim parameters on rxq%d\n",
>  				 dev->name, qnum);
> -		dim->state = DIM_START_MEASURE;
>  	}
>  out:
> +	dim->state = DIM_START_MEASURE;
>  	mutex_unlock(&rq->dim_lock);
>  }
>
> --
> 2.32.0.3.g01195cf9f
>
