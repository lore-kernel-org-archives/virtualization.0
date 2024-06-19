Received: from out30-98.freemail.mail.aliyun.com (out30-98.freemail.mail.aliyun.com [115.124.30.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDED1762D0
	for <virtualization@lists.linux.dev>; Wed, 19 Jun 2024 07:43:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718782992; cv=none; b=gFjXATHyc2Z4o//VDNlMOjy49MFzmQKW0HhRE+xG7CAA4oZBcopvHvg/issk+c3L45HMBm77eXJNzzTwfaWW0iMzAPJsLLet1hCqvWfr5IhKGHDIBgDXwq0OlOIzx9/dDCT7ww6bJw/yp7FtfWN4qjD318Nb57V581k/iUOmh28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718782992; c=relaxed/simple;
	bh=CWFYCLr1S9tlTDsXwd82PYiyX9o/sFArGzlmRlQeeQM=;
	h=Message-ID:Subject:Date:From:To:Cc:References:In-Reply-To; b=IMZ8MHdppV4P4e8C6rS46aW99WkHzrh0HoAiGCwyVxgpXkWrercPdo11ec1l4y9KtpWcKhHFPFlRQddcLT+8OHoaAjkHxqLtD7Cibs3chMhwPLSRjmCm/3rYcTI3FGs83+JmcxAZN8IsSd/ACwE7JfRs3mi1Z/w5ZC0E4LQ//lE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=O9NfQard; arc=none smtp.client-ip=115.124.30.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="O9NfQard"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1718782981; h=Message-ID:Subject:Date:From:To;
	bh=wCgw5wclWH6p97tsJn6yIeHJSR+uCtIF69aE5YHRmqQ=;
	b=O9NfQardvUIqHTHXVFipwL8zB6XiCC1OgVUFWWkzgM7TgwY7m+KsQLTQXL8Ap60NQJTRcDUBhVtmm6N/rVhohd8g78/Q3rBZWCR2F4Ne96eZAlfy+jkCL8BlWv8b1XdcvXSnpXToXKAf9wfTbh6s4Z/i3mX3mybHw1g5bTAkGsE=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R211e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037067111;MF=hengqi@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0W8nS15P_1718782979;
Received: from localhost(mailfrom:hengqi@linux.alibaba.com fp:SMTPD_---0W8nS15P_1718782979)
          by smtp.aliyun-inc.com;
          Wed, 19 Jun 2024 15:43:00 +0800
Message-ID: <1718782933.7258735-3-hengqi@linux.alibaba.com>
Subject: Re: [PATCH] virtio_net: Use u64_stats_fetch_begin() for stats fetch
Date: Wed, 19 Jun 2024 15:42:13 +0800
From: Heng Qi <hengqi@linux.alibaba.com>
To: Li RongQing <lirongqing@baidu.com>
Cc: Li RongQing <lirongqing@baidu.com>,
 mst@redhat.com,
 jasowang@redhat.com,
 xuanzhuo@linux.alibaba.com,
 eperezma@redhat.com,
 virtualization@lists.linux.dev,
 netdev@vger.kernel.org
References: <20240619025529.5264-1-lirongqing@baidu.com>
In-Reply-To: <20240619025529.5264-1-lirongqing@baidu.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>

On Wed, 19 Jun 2024 10:55:29 +0800, Li RongQing <lirongqing@baidu.com> wrote:
> This place is fetching the stats, so u64_stats_fetch_begin
> and u64_stats_fetch_retry should be used

Reviewed-by: Heng Qi <hengqi@linux.alibaba.com>

Thanks!

> 
> Fixes: 6208799553a8 ("virtio-net: support rx netdim")
> Signed-off-by: Li RongQing <lirongqing@baidu.com>
> ---
>  drivers/net/virtio_net.c | 14 ++++++++------
>  1 file changed, 8 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index 61a57d1..b669e73 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -2332,16 +2332,18 @@ static void virtnet_poll_cleantx(struct receive_queue *rq)
>  static void virtnet_rx_dim_update(struct virtnet_info *vi, struct receive_queue *rq)
>  {
>  	struct dim_sample cur_sample = {};
> +	unsigned int start;
>  
>  	if (!rq->packets_in_napi)
>  		return;
>  
> -	u64_stats_update_begin(&rq->stats.syncp);
> -	dim_update_sample(rq->calls,
> -			  u64_stats_read(&rq->stats.packets),
> -			  u64_stats_read(&rq->stats.bytes),
> -			  &cur_sample);
> -	u64_stats_update_end(&rq->stats.syncp);
> +	do {
> +		start = u64_stats_fetch_begin(&rq->stats.syncp);
> +		dim_update_sample(rq->calls,
> +				u64_stats_read(&rq->stats.packets),
> +				u64_stats_read(&rq->stats.bytes),
> +				&cur_sample);
> +	} while (u64_stats_fetch_retry(&rq->stats.syncp, start));
>  
>  	net_dim(&rq->dim, cur_sample);
>  	rq->packets_in_napi = 0;
> -- 
> 2.9.4
> 
