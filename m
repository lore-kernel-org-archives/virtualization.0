Received: from out30-97.freemail.mail.aliyun.com (out30-97.freemail.mail.aliyun.com [115.124.30.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBCE4168B9
	for <virtualization@lists.linux.dev>; Fri, 15 Mar 2024 07:53:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710489236; cv=none; b=f5ZfvMD6LWRDVcM35ZBHNoxhSdqRLwo512gE/w/gdqwdWlbaFU2tS1f8aKFkN97xk5bCjv04aIEMRsdG1srrpA0COt85n93Nf8KqDpPJ6S016apxxfWi8ufga6oGp57hgmJtnYV08Hjr+uKEn4B2UXVHLcuL5DaerFvICTU5sY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710489236; c=relaxed/simple;
	bh=6FMRl6m8tBGLZaaAzsLem205PhnR/hBTd36NLkHi/Cw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gBVtCe94FvJgOals7IT0pJ9YIXoI5tDdRFQArMtQAfyhHxowIsuPiETJX9kvh4UZAskWJ5XZ8gFFNckRrTdudu8S2mp9kxibt3QiI10s67mS0cczAbwv/hXEB2RH5PdyMWmkXnkOm3rAhRgqEQSPcAxZDU2sG+Xuzl4If4YLUCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=pbcKQ7M4; arc=none smtp.client-ip=115.124.30.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="pbcKQ7M4"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1710489232; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=taaP0Q9u2K5DH9xLuWgNdAcyQdJAZ4Px6dOvD4Tr4Bc=;
	b=pbcKQ7M4jCwCSvtI2xk3pF8GntnYk4TIAZGeeb3NM+WG2nE7z4rer+KGjBLCIET5B1V/l/Hw2TveqOfbPi2U9FQPyi1dHahd3/jgPT4l/avukSS3aB0Mxl1774J/INJq5yS1X46z2qKMBULqB/X/IluYSsLH6AZDuztkROA7zKw=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R111e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045170;MF=xianting.tian@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0W2VZ4oX_1710489199;
Received: from 30.221.98.145(mailfrom:xianting.tian@linux.alibaba.com fp:SMTPD_---0W2VZ4oX_1710489199)
          by smtp.aliyun-inc.com;
          Fri, 15 Mar 2024 15:53:48 +0800
Message-ID: <e004b5d6-e74c-44a8-afaa-b6f4b993817d@linux.alibaba.com>
Date: Fri, 15 Mar 2024 15:53:18 +0800
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] vhost: correct misleading printing information
To: mst@redhat.com, jasowang@redhat.com
Cc: kvm@vger.kernel.org, virtualization@lists.linux.dev,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240311082109.46773-1-xianting.tian@linux.alibaba.com>
From: Xianting Tian <xianting.tian@linux.alibaba.com>
In-Reply-To: <20240311082109.46773-1-xianting.tian@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

it is a very minor fix, I think it can be applied

在 2024/3/11 下午4:21, Xianting Tian 写道:
> Guest moved avail idx not used idx when we need to print log if
> '(vq->avail_idx - last_avail_idx) > vq->num', so fix it.
>
> Signed-off-by: Xianting Tian <xianting.tian@linux.alibaba.com>
> ---
>   drivers/vhost/vhost.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
> index 045f666b4f12..1f3604c79394 100644
> --- a/drivers/vhost/vhost.c
> +++ b/drivers/vhost/vhost.c
> @@ -2515,7 +2515,7 @@ int vhost_get_vq_desc(struct vhost_virtqueue *vq,
>   		vq->avail_idx = vhost16_to_cpu(vq, avail_idx);
>   
>   		if (unlikely((u16)(vq->avail_idx - last_avail_idx) > vq->num)) {
> -			vq_err(vq, "Guest moved used index from %u to %u",
> +			vq_err(vq, "Guest moved avail index from %u to %u",
>   				last_avail_idx, vq->avail_idx);
>   			return -EFAULT;
>   		}
