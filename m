Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CDA41494A8
	for <virtualization@lists.linux.dev>; Tue, 25 Jun 2024 11:07:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719313637; cv=none; b=H0/eiOjmd0l599NHK+vgVI93b5C8r6oRM0NaJBBV3CVVbCRD4XW4NAEmi2SPFTkS5OuA5HrGzy8ZwQgwGryGHYnLcR4sG6kRUbFGnnalg4V670QbUDJ72KBTbCzKmEav7WrVHw7XZMz6CaDuM5kyV9IGFC34UcNSSnShG/MjJ8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719313637; c=relaxed/simple;
	bh=WXZZXM8tSQoqIgeVh3XJX6rEIeOM5cCdAGA0b/UF/0I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MC+u3vaTzAmBztzvDmwD5U/BO0gLx1MqJYYzAGSEKJluJMy2lQkqn2fwLJOMgQp14NKBl7dkUdaioRo5XE14EvezDmyvGKYT4m3IOYUgz9jlA0eaOy14sw0ZEksYYElq5YCcOVsQcrSTw7kjIvEOTvCjHMxyHKr/cZzNCOmMJ4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=UHgKP69P; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="UHgKP69P"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4247f36f689so37803685e9.1
        for <virtualization@lists.linux.dev>; Tue, 25 Jun 2024 04:07:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1719313633; x=1719918433; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ojtvaw3EaYvckA39qDzAhxvVtQ3Bf7RhZ0efVHUHRh4=;
        b=UHgKP69PJZjnRp19XFmvGanv7bAvpzV84/0zPCZ0cu43VzpRBEXn46Uoks4L/1zVWp
         0Jb6AyCU3TaGj4O4+qfFK9QhT80UIyuEGEfYJ59+R5wH/fzitnHBs0tvwUCuShemBhhB
         8JFYGWMiMmJTH9gVyOTFiokiCA1p1WVIaUM1NB2hviT3SCwxKmmNlK+Ce+FLljlKgTZS
         pkbw/xKKMJQi0bjlCacKU1BVfd7+zEZqHS5zXuj2Wg5lPJYot+kTb/QyzxDyfzgFuTWK
         ECMROPEWr5h0RP7jslkKRuu7KFfo/1/9C8mmJOw+rTB0ZiUcMGHHvceW0RiXbDqyIsNU
         H9dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719313633; x=1719918433;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ojtvaw3EaYvckA39qDzAhxvVtQ3Bf7RhZ0efVHUHRh4=;
        b=Us3btLxoc+UhjmeqkSBg/BIlRG/MBVfa9jIrxKgULCk6jpaWw2w21lJushUkEY7zNj
         4jxjXXMfZ+LkCsasIlX8X/O0e9AaNiJe26dj6xX+JsER9R6xaxQ/s8tJrzAsRbXkMS/Y
         WQ2mQmaezycYL754z2HOL2rY3s8ohB/0VpT0+c6tdmMMHXzg3E6K/XT+b+2fa33zcKuD
         x5l1J2StKmOxL0FARYE6JojF4nfkhJoLMLQe1erxYik3xv8qIbFgrMrA3rWGpqRNBcMK
         q6X6Snov+Oclhf0xnx3iMrQD9cAiVhRhVRlEXrFzFqhwFBlQ8/d5iA2T2vVPYzBqWu5B
         F20w==
X-Gm-Message-State: AOJu0YxAYlmokWjIMIBVy2QOJHNyyFBDf85/orFk60Se8kdVTbTD9FTd
	VQKlcAkoT4A+db8N9FuDALqH49keAFfcB3MyJkcOgYhs1ER6cw9RGkQaUKNIBJk=
X-Google-Smtp-Source: AGHT+IHCPBE2QD+7n/InNF4LLwD+HGMm13LtL9ZBMSCNRMe6jcvTq+a+Gj9qFVj3QbpF3Vw8OtezXA==
X-Received: by 2002:a05:600c:6a94:b0:418:fe93:22d0 with SMTP id 5b1f17b1804b1-4248b95dd64mr65151765e9.11.1719313632570;
        Tue, 25 Jun 2024 04:07:12 -0700 (PDT)
Received: from localhost ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3663ada00e7sm12641206f8f.112.2024.06.25.04.07.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jun 2024 04:07:11 -0700 (PDT)
Date: Tue, 25 Jun 2024 13:07:08 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: virtualization@lists.linux.dev, jasowang@redhat.com,
	xuanzhuo@linux.alibaba.com, eperezma@redhat.com, parav@nvidia.com,
	feliu@nvidia.com, Heng Qi <hengqi@linux.alibaba.com>
Subject: Re: [PATCH virtio 7/8] virtio_pci_modern: use completion instead of
 busy loop to wait on admin cmd result
Message-ID: <Znqk3LaiyhKhb2sg@nanopsycho.orion>
References: <20240624090451.2683976-1-jiri@resnulli.us>
 <20240624090451.2683976-8-jiri@resnulli.us>
 <20240624072340-mutt-send-email-mst@kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240624072340-mutt-send-email-mst@kernel.org>

Mon, Jun 24, 2024 at 01:30:54PM CEST, mst@redhat.com wrote:
>On Mon, Jun 24, 2024 at 11:04:50AM +0200, Jiri Pirko wrote:
>> @@ -73,21 +91,30 @@ static int virtqueue_exec_admin_cmd(struct virtio_pci_device *vp_dev,
>>  	    !((1ULL << opcode) & admin_vq->supported_cmds))
>>  		return -EOPNOTSUPP;
>>  
>> -	ret = virtqueue_add_sgs(vq, sgs, out_num, in_num, cmd, GFP_KERNEL);
>> -	if (ret < 0)
>> -		return -EIO;
>> -
>> -	if (unlikely(!virtqueue_kick(vq)))
>> -		return -EIO;
>> +	init_completion(&cmd->completion);
>>  
>> -	while (!virtqueue_get_buf(vq, &len) &&
>> -	       !virtqueue_is_broken(vq))
>> -		cpu_relax();
>> +again:
>> +	spin_lock_irqsave(&admin_vq->lock, flags);
>> +	ret = virtqueue_add_sgs(vq, sgs, out_num, in_num, cmd, GFP_KERNEL);
>> +	if (ret < 0) {
>> +		if (ret == -ENOSPC) {
>> +			spin_unlock_irqrestore(&admin_vq->lock, flags);
>> +			cpu_relax();
>> +			goto again;
>> +		}
>> +		goto unlock_err;
>> +	}
>> +	if (WARN_ON_ONCE(!virtqueue_kick(vq)))
>> +		goto unlock_err;
>> +	spin_unlock_irqrestore(&admin_vq->lock, flags);
>>  
>> -	if (virtqueue_is_broken(vq))
>> -		return -EIO;
>> +	wait_for_completion(&cmd->completion);
>>  
>>  	return 0;
>> +
>> +unlock_err:
>> +	spin_unlock_irqrestore(&admin_vq->lock, flags);
>> +	return -EIO;
>>  }
>>  
>
>
>The reason we had the virtqueue_is_broken check previously,
>is because this way surprise removal works: it happens to set
>vq broken flag on all vqs.
>
>
>So if you are changing that to a completion, I think surprise
>removal needs to trigger a callback so the completion
>can be signalled.

What exacly do you mean by "surprise removal"?


>
>I think the cvq work also needs this, BTW.
>
>
>
>
>-- 
>MST
>
