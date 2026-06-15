Received: from out30-113.freemail.mail.aliyun.com (out30-113.freemail.mail.aliyun.com [115.124.30.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C75D23DBD57
	for <virtualization@lists.linux.dev>; Mon, 15 Jun 2026 10:06:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.113
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781517971; cv=none; b=dLePk4aTGIPOAJ5DrCK6F3k2MTQ4JWsE0IqMdC6v39sGQBH3TUReIROCXTeynCVt02bGO4pVD9/72w2X2+cQLlncLU9jBxT147xyeqIpY8QCML/IVzv3+mj9YWAgSuEzy6Z2BbaLBGqidEplAtwINfZ39tjWjUDPnRm+09Q3hy4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781517971; c=relaxed/simple;
	bh=pvnRMq3g0n8tZYBOOvXeald195FmXJRZIdYaiNzBlLA=;
	h=Message-ID:Subject:Date:From:To:Cc:References:In-Reply-To; b=Zi2tFXcmeXjsSDSUTDE+VsYogO6sfboEgYQ4mMzViF3adeIkM58R9oRRCcya2+G4mWSubdir92tlkhPAMDrMTKHcNJau17g28YWdhFdmuTucg1CaA2Ra+dw1iujGtsLrTU4bONOj8mAyLbXYV0QVDYzukA818Y79L87weP3qv80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=q1+n/lwP; arc=none smtp.client-ip=115.124.30.113
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="q1+n/lwP"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1781517960; h=Message-ID:Subject:Date:From:To;
	bh=A90ALL3MRU359y8gsp7kOLkxOVfQRS4+37o3xi2RYhg=;
	b=q1+n/lwPjLh+QsOg73/VYQ/0NlXwnBki7Hy/SKVknJ7b8BjgUdxh0ZE4OWYzebo/tQt4uwfE1hax+SpIhBGJp4de302U3vbspeUuMkBQHLGfA1fcgVsLa+hq4WXfmq4lBMnNGH3dqIFbgd/+FKK01FcXTWL293frzHU4QMJgaCQ=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R101e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033045098064;MF=xuanzhuo@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0X4tFk1V_1781517958;
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0X4tFk1V_1781517958 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 15 Jun 2026 18:05:59 +0800
Message-ID: <1781517700.4206195-1-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH] virtio_net: disable cb when napi_schedule_prep fails during busy-poll
Date: Mon, 15 Jun 2026 18:01:40 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: Longjun Tang <lange_tang@163.com>
Cc: edumazet@google.com,
 kuba@kernel.org,
 virtualization@lists.linux.dev,
 lange_tang@163.com,
 tanglongjun@kylinos.cn,
 mst@redhat.com,
 jasowang@redhat.com
References: <20260615094550.106391-1-lange_tang@163.com>
In-Reply-To: <20260615094550.106391-1-lange_tang@163.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>

On Mon, 15 Jun 2026 17:45:50 +0800, Longjun Tang <lange_tang@163.com> wrote:
> From: Longjun Tang <tanglongjun@kylinos.cn>
>
> When busy-poll is active, napi_schedule_prep() returns false in
> skb_recv_done(), so virtqueue_disable_cb() is skipped. The device
> may keep firing irqs until the next poll round reaches
> virtqueue_napi_complete(). If cb is enabled under busy-poll case,
> it will lead to a large number of spurious interrupts. Explicitly
> disable callbacks in this case to prevent spurious interrupts.
>
> Signed-off-by: Longjun Tang <tanglongjun@kylinos.cn>
> ---
>  drivers/net/virtio_net.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index f4adcfee7a80..6d675fddc59b 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -728,6 +728,8 @@ static void virtqueue_napi_schedule(struct napi_struct *napi,
>  	if (napi_schedule_prep(napi)) {
>  		virtqueue_disable_cb(vq);
>  		__napi_schedule(napi);
> +	} else if (test_bit(NAPI_STATE_IN_BUSY_POLL, &napi->state)) {
> +		virtqueue_disable_cb(vq);

I see, but we should avoid checking NAPI_STATE_IN_BUSY_POLL directly in the
drivers. The NIC driver should remain agnostic to busy polling. I think we need
a better way, maybe we should rewrite virtqueue_napi_schedule instead.

Thanks.

>  	}
>  }
>
> --
> 2.25.1
>
