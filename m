Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A487918DF7A
	for <virtualization@lists.linux.dev>; Thu,  8 Aug 2024 13:37:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723124246; cv=none; b=bpC9tqISq084t8hbom5jBb4znIq6WilMfKqPk+DRyGjLbQS/cnLMo5BMuVm1ugyWXkgglJM9CtU3HTsgnU1EOI+l93uFiW8vCnxSRL//M9UKiCvvjTS0X544CNY59S1BgiD+hXb/1V0ZC8Nrk4J/SECbpVPiHU9YbKKMOSffcaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723124246; c=relaxed/simple;
	bh=3ZiTOAaXUPmHMS+kcP/7fLCSSJvy0HJAPk8oCSO93e4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LWOkdL/MIMZ9LvGY6TepnXWFWIVttuQPIUjMS9R3cDcSTD4Y3tyJ2iM1hCoTEK3B1VFHOC+2B+07mY2ZEzDCamTyehZU3Q3qhnrpS5BZ5arGsN7mYLKmPnS2Os7TGbMCzJBSB34J+kMHmLULB3j/xvwbMxbBIe5dTMl21es4xZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=g4ug4eFS; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="g4ug4eFS"
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-72703dd2b86so85843a12.1
        for <virtualization@lists.linux.dev>; Thu, 08 Aug 2024 06:37:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1723124241; x=1723729041; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XVChcYY30Mpv4pcrAWYyddiPC20nI4GsEyGh5Z8PoV4=;
        b=g4ug4eFS9iS5MZ4r6wW8FgG+Qv59/QpDE/bOuDfhwg47tE+qf91zQLXmGBF9MSMnGl
         F3HiEQQfmpi2c6Cz8hO1uDZ8vZ9b0uMgcQXKyjMOqYFjOtyAkFUut+5Z9MrHb/m3LChI
         eJ78lLNvujaAv07Tp65jjZIjq153va61lwYywcS7m9agMe9sHvViX1qmsPRxAInNSkgZ
         lpvnqGyNikIYyc2UuXBYS2Fy7gViKoOJa/BrgqqlDPz1mnOwdJ5d4Hbqgy4pDhN4bU51
         P1ckpD/EhIfflWYBZKpB8DmoKsB7QYxLvlAwr0fPLnfT7alZdM8nxhQUtVT92EuDfOrU
         /U2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723124241; x=1723729041;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XVChcYY30Mpv4pcrAWYyddiPC20nI4GsEyGh5Z8PoV4=;
        b=D1Si8GlWNX4jlkWspFodLB5aLjGZqnozLcHOfQgTSs6Z1eLtxjNEbqkZ4Fo7vdMzlb
         0TMqQq1kbz2wUARUKS+2kn81vkWgQdtsnL3yUXOGfg5MafDbd8PhMuxx/A8jdE7LBAnc
         U8Rtt5HcAjmZP9L6l2NaV0Dsd8lSZFVRG89sJYzBLGSFTJbF/kYkTWWD4sEMq4tDLD5a
         MzkYfCy0pBTb7A0WVCcECiHN+KvfVeeDVYRZTUW0MvmkZ/IOyxluwRZuNR+nKQbckIaZ
         5tcIJJvimJRJ0jJTI6PydkW/HH+MvihfpxYld4/iLSDiK1cnD4KrVwwYvjFgYfJq/l68
         WjKA==
X-Forwarded-Encrypted: i=1; AJvYcCVTI2bApy1pI4ZdQen+Czk58ecd2y4QnpnbWKwTIof7sxU37dnwwn6oJNrU1TJ0MBGQLVm/hX91bLiPqLdMqpgGwusoXg0+avNK9g+SqEU=
X-Gm-Message-State: AOJu0YzC6fPUeiccivXu8XoPXWwAXYdvk4KOj7IvvF9/MrgsBZn2biBq
	1c7xwxntvWQ1AKQq2phb+8E1FHpi5AQ6TaNH8k4T1rUWxp7VgPS6M1wzr53wFzkd8g0CRowXt2F
	G
X-Google-Smtp-Source: AGHT+IEk6xoZ/zlRSb3U/GJSm3CHUT6KiD1J07T2LKOms6ygd4Jc8qBlHMKfZG58uLAif+L2dix3TA==
X-Received: by 2002:a05:6a20:7487:b0:1c4:84ee:63d1 with SMTP id adf61e73a8af0-1c6fd05f845mr1187450637.9.1723124241540;
        Thu, 08 Aug 2024 06:37:21 -0700 (PDT)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1ff58f219f5sm124997345ad.29.2024.08.08.06.37.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Aug 2024 06:37:20 -0700 (PDT)
Message-ID: <35c7b39f-415d-4d23-bf44-75e655f3eb8a@kernel.dk>
Date: Thu, 8 Aug 2024 07:37:19 -0600
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] virtio_blk: implement init_hctx MQ operation
To: Max Gurtovoy <mgurtovoy@nvidia.com>, stefanha@redhat.com,
 virtualization@lists.linux.dev, mst@redhat.com
Cc: kvm@vger.kernel.org, linux-block@vger.kernel.org, oren@nvidia.com
References: <20240807224129.34237-1-mgurtovoy@nvidia.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20240807224129.34237-1-mgurtovoy@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/7/24 4:41 PM, Max Gurtovoy wrote:
> Set the driver data of the hardware context (hctx) to point directly to
> the virtio block queue. This cleanup improves code readability and
> reduces the number of dereferences in the fast path.

Looks good, and that is the idiomatic way to do this.

Reviewed-by: Jens Axboe <axboe@kernel.dk>

-- 
Jens Axboe


