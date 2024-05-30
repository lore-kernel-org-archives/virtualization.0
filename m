Received: from out30-98.freemail.mail.aliyun.com (out30-98.freemail.mail.aliyun.com [115.124.30.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1033113777E
	for <virtualization@lists.linux.dev>; Thu, 30 May 2024 03:57:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717041482; cv=none; b=KXUQ3Vs2HLYMTE4vXn/QprauDfQACQWEXwrN7KsEZ0eB9YmyH8Jwd+iSFr6yJlFIbiCQAmFFhE99+e/b8IlaQgRDf6zlHo6fOxNAJGPzAhZf0uaWsS+nyZJD+Uotz5MYai+7lgWwIwBGar459l9XUWJ962vShoxrVbsu9EvT7dI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717041482; c=relaxed/simple;
	bh=uUv6AhNvMx6WlFeofx7ehtpINtZ6aM5IJs0Q+yQFSwc=;
	h=Message-ID:Subject:Date:From:To:Cc:References:In-Reply-To; b=tezqVFFky9bds9whtT3JLYNRZxHmurtIjktnuv7kI8VpQmX5g/BpzubzQUVRvr/ogJ2v1Y6wkBXNByPBrPxO+KOBVpT9rXVXU6LOYcqHpX8plymhSRF9ZlTQ2/l5kLI/tLGimaD9PrqvIAylFGyYgB+EaxxBKOzay2qwIX6adDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=mJL20TPn; arc=none smtp.client-ip=115.124.30.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="mJL20TPn"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1717041477; h=Message-ID:Subject:Date:From:To;
	bh=ZbZ4Z21lz7ppnxwsjw/Iag0omCFAmUVoOusD/Ck66a0=;
	b=mJL20TPnMHrcvPqDFCrZEHgPkJ9lfQstVNn3aLypJOHo4XdHYGUX7SHuBS2m9tZBIj8dTpzYyWEfjlrP14FygH4nqlYFaLBx8pj9otcZDnxeCXuBzCgV5iGR1hCBjq/A6rCB4lnLULFvHTSu+/BZF2v82DE2tNcrbgK6VD6GUOM=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R731e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033045075189;MF=xuanzhuo@linux.alibaba.com;NM=1;PH=DS;RN=13;SR=0;TI=SMTPD_---0W7VeU0._1717041476;
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0W7VeU0._1717041476)
          by smtp.aliyun-inc.com;
          Thu, 30 May 2024 11:57:57 +0800
Message-ID: <1717041469.8007479-2-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH net v2] virtio_net: fix missing lock protection on control_buf access
Date: Thu, 30 May 2024 11:57:49 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: Heng Qi <hengqi@linux.alibaba.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 Jason Wang <jasowang@redhat.com>,
 =?utf-8?q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>,
 "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>,
 Jiri Pirko <jiri@resnulli.us>,
 Daniel Jurgens <danielj@nvidia.com>,
 Hariprasad Kelam <hkelam@marvell.com>,
 netdev@vger.kernel.org,
 virtualization@lists.linux.dev
References: <20240530034143.19579-1-hengqi@linux.alibaba.com>
In-Reply-To: <20240530034143.19579-1-hengqi@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>

On Thu, 30 May 2024 11:41:43 +0800, Heng Qi <hengqi@linux.alibaba.com> wrote:
> Refactored the handling of control_buf to be within the cvq_lock
> critical section, mitigating race conditions between reading device
> responses and new command submissions.
>
> Fixes: 6f45ab3e0409 ("virtio_net: Add a lock for the command VQ.")
> Signed-off-by: Heng Qi <hengqi@linux.alibaba.com>
> Reviewed-by: Hariprasad Kelam <hkelam@marvell.com>

Reviewed-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>

> ---
> v1->v2:
>   - Use the ok instead of ret.
>
>  drivers/net/virtio_net.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index 4a802c0ea2cb..1ea8e6a24286 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -2686,6 +2686,7 @@ static bool virtnet_send_command_reply(struct virtnet_info *vi, u8 class, u8 cmd
>  {
>  	struct scatterlist *sgs[5], hdr, stat;
>  	u32 out_num = 0, tmp, in_num = 0;
> +	bool ok;
>  	int ret;
>
>  	/* Caller should know better */
> @@ -2731,8 +2732,9 @@ static bool virtnet_send_command_reply(struct virtnet_info *vi, u8 class, u8 cmd
>  	}
>
>  unlock:
> +	ok = vi->ctrl->status == VIRTIO_NET_OK;
>  	mutex_unlock(&vi->cvq_lock);
> -	return vi->ctrl->status == VIRTIO_NET_OK;
> +	return ok;
>  }
>
>  static bool virtnet_send_command(struct virtnet_info *vi, u8 class, u8 cmd,
> --
> 2.32.0.3.g01195cf9f
>
