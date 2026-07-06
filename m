Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 917161B7910
	for <virtualization@lists.linux.dev>; Mon,  6 Jul 2026 04:09:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783310942; cv=none; b=gk2RlhnKDMvWc3CXBVD+PvUYdPuBUrFU1U3u65a9+WJr9l37Fig+RhiaOEJbvwrun/ebk1naq6k9JiqF4o7INAciXfxfZ4++dOyFaMSiFMNwlihmd4nxivYe8pKEha7HAp4NKsht7G3I4oOq/RC4vKvh22zac0q7Fcb3fMp8FT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783310942; c=relaxed/simple;
	bh=gesLhmjDATHcNmyKwVTHjKEW+LBwNmx7XQdwBmxHfxA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MQYLsmQ3LqPhcSWdWmrb0m/u4sAETubjN1RVJuRcr2+vd7yiG2J4tKtE6lIeeKow7WjjM3uYnNWefx1D0Kuty+ORXImFAwfzEq/EKXmLuVZtQHv+lEZzFGSimrPEXpqv+0SwHurPDWO3HIiYmdtL/UIMpj1tGqc9nN8SvEIDMKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=K7sc3ZmR; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="K7sc3ZmR"
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-c96cb024ee0so1756407a12.1
        for <virtualization@lists.linux.dev>; Sun, 05 Jul 2026 21:09:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1783310941; x=1783915741; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=nUpTmSp9slqIVLS0De2fE7WAIj9ccgm7yyep1NzPYZg=;
        b=K7sc3ZmRHolFPGCkjNqrWSU8HPG812G9BOjo+aEHqpcf6FO7Odr2rO9MZjEQrMNHY8
         A9pjLVtbRI33kCe1EGMYwzl169ymlwejjmCaS5TotJAXDlPK2Yo5lYIC01Mf+CK/noan
         GyGuGYmIGt5Mn09lPM6tjKLuQAHHBc//RSe9O4U9UjTYUadHy75PtcNX7fJa+lxodbPJ
         Km+MOnkP8eoOjNeI5geX9H3lnXRrvQLhGyiik9Wqxqkbzd/wgqzPCXguiKWZ+1VG1ivQ
         1hrUFl776bSim5UQxC/VGZKGPzb/u4AKi30hG7+6qvfDWw5Pfrv7GdUT5WnJwJeuPeES
         3jWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783310941; x=1783915741;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nUpTmSp9slqIVLS0De2fE7WAIj9ccgm7yyep1NzPYZg=;
        b=NWxrsRBTvYMq6Mlqd5GMBzeJOiyE5hO5nXnTqJu5V5PZwikpb8za79RfFs4vZYNjAo
         afJIBM5xJfOw8hj3DCB2kFcBJTvjH3CGZwK+z+QcMmQXu56tEZ3KGGai6UHCuygtCcrv
         uNEvQr8gZLiBTzCxCyxVvzcTwFJzKVY62maf9grHkZLSH72paIyuP+IZ5ilYeTmXPJ1T
         RxcDZRsVj2G35w2xFdIVR+bKlefFitMxKVSsIoKPTMsONteJeBVdw9QMyMrfGTvk43Ll
         Su00IKAthGYssz18O1sJgPQVPQoZwLN5cSrEe4ZQbe/JPAwcKNmfv08S8VzlDUVaki/5
         n2fw==
X-Forwarded-Encrypted: i=1; AHgh+Rr+k7w0U3+20BWrJJzPxdNmqZ0xGtnq0/QWYdFWQAaPXRnVbI0T+90QMGyzUSs2dDw0SN53Y0j5GfFsnXgQjw==@lists.linux.dev
X-Gm-Message-State: AOJu0YwCVh86FvSDvupW9CpY8d58FZXLaAYyrjhka35wJBoNj2hA7/S6
	6knipqLnRwF2h2AwfFuGWlq59sGKRorWmPYURGOXMt/uBz3yfZ2JKSk4IqXyWG3MwGA=
X-Gm-Gg: AfdE7cndtKHlT76VQntpiAkgBZo49n5uu1671kMDHi2PgGaHl5EEX/FRXp8N5z00Bic
	VWPKmjkwZVOU0zFBu1x409V4sRULP8erMc763mF8c1Jb88N8Y6Dzuy7jgykB3CuuF/V/zLx+ICP
	sBX8CMlqOKPaMHSXBkz/6fHxT0bbJFEO1iPEFgYuK+A3EtTZh50hRpt+BBrKxKBldGdb+9ho3IC
	FSEMXTyepNkbxMJwJr7Q7j1EYpFH0z8cFuvR0aA0Lr+aVzks9hdx/SMI7ZZPR32nYfO81zlHU5s
	53RKcai4+i499Mlgzn3QLZgWi4ye6IwdLChD7Dy1qRVxXO0CSgBlEhmhfL5WBNW9q/HB4ESE9GV
	MWbkp4otSUBkDpObaZv8vNJqLphJKn0tnsYxsvMHER1W5GMkdmrBW5Xu7M0sUmUSNQwJrA5SwWZ
	bzrMIhpPfLE3TK
X-Received: by 2002:a05:6a21:310e:b0:3bf:9fc0:f6c2 with SMTP id adf61e73a8af0-3c03e18bc01mr8997778637.11.1783310940716;
        Sun, 05 Jul 2026 21:09:00 -0700 (PDT)
Received: from localhost ([122.172.82.94])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30f0bc2e119sm48016654eec.28.2026.07.05.21.08.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Jul 2026 21:08:59 -0700 (PDT)
Date: Mon, 6 Jul 2026 09:38:56 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Guangshuo Li <lgs201920130244@gmail.com>, 
	Gavin Li <gavin.li@samsara.com>
Cc: "Chen, Jian Jun" <jian.jun.chen@intel.com>, 
	Andi Shyti <andi.shyti@kernel.org>, linux-i2c@vger.kernel.org, virtualization@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] i2c: virtio: Reset virtqueue before freeing interrupted
 requests
Message-ID: <krqh3ya6km5g43tp3nmtq5n6liwghilfsvzrsyh7zdywtn23of@5iztbohhsxfg>
References: <20260705155925.292765-1-lgs201920130244@gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260705155925.292765-1-lgs201920130244@gmail.com>

On 05-07-26, 23:59, Guangshuo Li wrote:
> virtio_i2c_complete_reqs() waits for each queued request to complete
> before releasing the per-message DMA-safe buffer. The request array is
> then freed by virtio_i2c_xfer().
> 
> After wait_for_completion_interruptible() was introduced, the wait can
> return before the current request has completed. In that case, the
> request and the remaining requests may still be owned by the virtqueue
> and may still be completed by the device later.
> 
> The error path nevertheless continues to release each message buffer and
> virtio_i2c_xfer() frees the request array. A later device completion can
> then write to freed request memory or call complete() on a freed
> completion object.
> 
> Reset the virtqueue when the wait is interrupted so that outstanding
> buffers are recovered before the request array and message buffers are
> freed.
> 
> Fixes: a663b3c47ab1 ("i2c: virtio: Avoid hang by using interruptible completion wait")
> Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
> ---
>  drivers/i2c/busses/i2c-virtio.c | 13 ++++++++++---
>  1 file changed, 10 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/i2c/busses/i2c-virtio.c b/drivers/i2c/busses/i2c-virtio.c
> index 5da6fef92bec..6ef09eda3ed0 100644
> --- a/drivers/i2c/busses/i2c-virtio.c
> +++ b/drivers/i2c/busses/i2c-virtio.c
> @@ -117,12 +117,19 @@ static int virtio_i2c_complete_reqs(struct virtqueue *vq,
>  		struct virtio_i2c_req *req = &reqs[i];
>  
>  		if (!failed) {
> -			if (wait_for_completion_interruptible(&req->completion))
> +			if (wait_for_completion_interruptible(&req->completion)) {
> +				/*
> +				 * The remaining buffers may still be owned by
> +				 * the device. Reset the virtqueue before freeing
> +				 * the request array and message buffers.
> +				 */
> +				virtqueue_reset(vq, NULL, NULL);
>  				failed = true;
> -			else if (req->in_hdr.status != VIRTIO_I2C_MSG_OK)
> +			} else if (req->in_hdr.status != VIRTIO_I2C_MSG_OK) {
>  				failed = true;
> -			else
> +			} else {
>  				j++;
> +			}
>  		}
>  
>  		i2c_put_dma_safe_msg_buf(reqs[i].buf, &msgs[i], !failed);

+ Gavin, who was also trying to solve this path recently.

https://lore.kernel.org/all/20260610155834.79207-1-gavin.li@samsara.com/

-- 
viresh
