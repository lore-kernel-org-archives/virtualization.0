Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE97E241665
	for <virtualization@lists.linux.dev>; Tue, 29 Apr 2025 16:26:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745944008; cv=none; b=ribgVmfKc11YOAVVUysvZjlRlCk9CeIiMFN029Z8N83CFwH1j8YgdDTEbn0VeAtZZbkeyefbLGzfdFIpPRddUrG76V6CPYYYuoZqm8Qr9pzHJbasO4NK9ckxXBQj60KBZLJjvjNxWbLlgaC+VQuShSCGQqR6uMB9zhzT3cK2fjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745944008; c=relaxed/simple;
	bh=3H0JTSYEGxPhjlYRtn/Nv0Vv9nZxrJjvYoSjVLqecN8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pY+wuvFKCR1CM2anJRD/LI+Xz682Omc8H3bu6Iag8VTy1xBhIKeiSVpf+9DBGx8Ijlm99M2VlDn8O5Inna8J72SZYAuzfsVsfEFFvqLB4HQ+nNolew6b+DfBPErQExKS7azlPZIrBmIUdetZbzHG3CmfSVRpmd3ipoa0AKq+qhA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P6DreI1S; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P6DreI1S"
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-b170c99aa49so3676117a12.1
        for <virtualization@lists.linux.dev>; Tue, 29 Apr 2025 09:26:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745944006; x=1746548806; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CGCEkSX+59MDfrCtQdhXXvbqwMXoqiT57UYCG87NkWo=;
        b=P6DreI1S3jpTdDlrZbz/q36xoaO4EDjeaXykVu3ZlHVnh24oa6a1ADAzGrgxmCAfyi
         xj7Jl0fRzlUA4lyyIdXeRJfeMDT5yjJoeHnVTI+wWrUasvgpLbxWYqQHMSsqVOso7HZx
         b3bbtN7v69RqEHc2cxEDhL88je/oXCC1nN8/ch3hUngUg0CxUV5kmYgHKWvO+CSAHOUH
         ii5F390PDjfeZZQ3tsp7m1ypUaZFpmn7bs9cQPAqZDsjtVf6A8CtaYLebd4/sWKX7Sip
         2+N/+CYAur8JpSW38W/pIWJdF5SWSCFAprIMzEPtLj6xYL+TUWZfd/fxMzztX7kyONJ9
         J3dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745944006; x=1746548806;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CGCEkSX+59MDfrCtQdhXXvbqwMXoqiT57UYCG87NkWo=;
        b=sNqJ+sg2+7BvlDmfbVkW20oL7luklA80eQ4M0Oy1/nxx/agrp1bBicFfXD31pppm02
         QMLNsxEDhMD8I6wBBhMLnAyKnCZgKPy5K22Pd6LdIMifH4IUZxbDuYmt5gAzbHJYVy1f
         hK7hRVyegPzkVQXxoUs1FBG+bh86oL1mVNUplELlgz1rPs3FSAn/ppUqFCY0Mh6jW1Hu
         WOMgCjnSA49MFQPPVSWS3fUZwMvU8YfH/qTUMsHpaZrP2SSsFUo+HQjEDfkE/sHHeOjG
         qYiiTFp+pElqim8XPCeuYY1zTpplJMl6zpNFZKcTR887/72IrOpzvFXRX7lLJHUKUM0P
         R5BA==
X-Forwarded-Encrypted: i=1; AJvYcCXs9EyuUrorDC5WkQ39k4gPhZ5Ba6QxlHNX5TFQThhP3uMQ7rIunAR1+FaMVPoDFyKgn9rvGW1lJy2dWRemzg==@lists.linux.dev
X-Gm-Message-State: AOJu0Yx8uNal+X3sBj8a3/FtnZHzIAWTtIPF0vClkL1lDexprMS24P3x
	BWMxsLb1wIXNMUqYIjscjynTijvtRE4GVcwkkDdEwEAfYaSz0So7
X-Gm-Gg: ASbGncvdMVaxehGYL7t/0MlZPXeD2jYrSUr+57jMpKrTy3y8fSmPFsySXuyhgPNXeAl
	VGwVPpl2JYoM/ImKilqZBe0UJ/dGPnLJvIYCuQaJBb76JDqfy7oJcf42LNbv2vWW8HPQ3d4Acfa
	RpwVL1L+YAdQYsSl1AszmHdfp29RWOrZWf0kzChm8F7cqQjswwSW3N4Gt6bOJTfDj1xjoL1C3b0
	/UvG4/NT6YG+JHsy9z+Qw3q2W7PY1MYRQc/t+pg0qzgKMGF73b01YxQOROrIZnjTT8seDXVE7av
	xum6BhzXZbhpvuwZFaWyIZHkDhs6kJaYH7FytE/wGHBiM6B1gkmVMcZaUb+8RIOGTAadmEEAcYj
	FWKcSqFWjL4Dd9yaG+tY=
X-Google-Smtp-Source: AGHT+IFYtxVTfVoUCdjEWv7KpPL5vInCXNQ/fvHP67A7c8ZKhmTj/5x4uwxkwIzoTVsCd3Lvt0ThGg==
X-Received: by 2002:a17:90b:586b:b0:2fe:8902:9ecd with SMTP id 98e67ed59e1d1-30a23dc1f81mr4052117a91.1.1745944005793;
        Tue, 29 Apr 2025 09:26:45 -0700 (PDT)
Received: from ?IPV6:2001:ee0:4f0e:fb30:8dc5:2d78:200a:494d? ([2001:ee0:4f0e:fb30:8dc5:2d78:200a:494d])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-309f782d4d6sm9637291a91.38.2025.04.29.09.26.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Apr 2025 09:26:45 -0700 (PDT)
Message-ID: <ed15f7f3-b74d-4884-bdce-afa8f35b841a@gmail.com>
Date: Tue, 29 Apr 2025 23:26:37 +0700
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] virtio-net: don't re-enable refill work too early
 when NAPI is disabled
To: Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net
Cc: netdev@vger.kernel.org, edumazet@google.com, pabeni@redhat.com,
 andrew+netdev@lunn.ch, horms@kernel.org, mst@redhat.com,
 jasowang@redhat.com, xuanzhuo@linux.alibaba.com, eperezma@redhat.com,
 romieu@fr.zoreil.com, kuniyu@amazon.com, virtualization@lists.linux.dev
References: <20250429143104.2576553-1-kuba@kernel.org>
Content-Language: en-US
From: Bui Quang Minh <minhquangbui99@gmail.com>
In-Reply-To: <20250429143104.2576553-1-kuba@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/29/25 21:31, Jakub Kicinski wrote:
> Commit 4bc12818b363 ("virtio-net: disable delayed refill when pausing rx")
> fixed a deadlock between reconfig paths and refill work trying to disable
> the same NAPI instance. The refill work can't run in parallel with reconfig
> because trying to double-disable a NAPI instance causes a stall under the
> instance lock, which the reconfig path needs to re-enable the NAPI and
> therefore unblock the stalled thread.
>
> There are two cases where we re-enable refill too early. One is in the
> virtnet_set_queues() handler. We call it when installing XDP:
>
>     virtnet_rx_pause_all(vi);
>     ...
>     virtnet_napi_tx_disable(..);
>     ...
>     virtnet_set_queues(..);
>     ...
>     virtnet_rx_resume_all(..);
>
> We want the work to be disabled until we call virtnet_rx_resume_all(),
> but virtnet_set_queues() kicks it before NAPIs were re-enabled.
>
> The other case is a more trivial case of mis-ordering in
> __virtnet_rx_resume() found by code inspection.
>
> Fixes: 4bc12818b363 ("virtio-net: disable delayed refill when pausing rx")
> Fixes: 413f0271f396 ("net: protect NAPI enablement with netdev_lock()")
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
> CC: mst@redhat.com
> CC: jasowang@redhat.com
> CC: xuanzhuo@linux.alibaba.com
> CC: eperezma@redhat.com
> CC: minhquangbui99@gmail.com
> CC: romieu@fr.zoreil.com
> CC: kuniyu@amazon.com
> CC: virtualization@lists.linux.dev
> ---
>   drivers/net/virtio_net.c | 9 ++++++---
>   1 file changed, 6 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index 848fab51dfa1..4c904e176495 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -3383,12 +3383,15 @@ static void __virtnet_rx_resume(struct virtnet_info *vi,
>   				bool refill)
>   {
>   	bool running = netif_running(vi->dev);
> +	bool schedule_refill = false;
>   
>   	if (refill && !try_fill_recv(vi, rq, GFP_KERNEL))
> -		schedule_delayed_work(&vi->refill, 0);
> -
> +		schedule_refill = true;
>   	if (running)
>   		virtnet_napi_enable(rq);
> +
> +	if (schedule_refill)
> +		schedule_delayed_work(&vi->refill, 0);
>   }
>   
>   static void virtnet_rx_resume_all(struct virtnet_info *vi)
> @@ -3728,7 +3731,7 @@ static int virtnet_set_queues(struct virtnet_info *vi, u16 queue_pairs)
>   succ:
>   	vi->curr_queue_pairs = queue_pairs;
>   	/* virtnet_open() will refill when device is going to up. */
> -	if (dev->flags & IFF_UP)
> +	if (dev->flags & IFF_UP && vi->refill_enabled)
>   		schedule_delayed_work(&vi->refill, 0);
>   
>   	return 0;

Reviewed-by: Bui Quang Minh <minhquangbui99@gmail.com>

Thanks,
Quang Minh.
