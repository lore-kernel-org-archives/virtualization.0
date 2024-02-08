Received: from mail-io1-f46.google.com (mail-io1-f46.google.com [209.85.166.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89EF685C7E
	for <virtualization@lists.linux.dev>; Thu,  8 Feb 2024 18:29:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707416947; cv=none; b=eJALGOVBFQV8ZidTXqg3dRAobgHObpkeViBhZeZPkOvTC7nx0pMfyC0J6TVDSR2cXKSPQA96I2D021TxAnnrCCfwozzLlVNCBP9ZzYTUMLJxx3+EKxuiRxApsoH4bnppUAeeYp+efx79zTGwUhQ7YZIKfQq7WMMYIz+xO8vZpdc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707416947; c=relaxed/simple;
	bh=X312NcRqGDzo3a+hjPanu7AG/bF3zerZBP7qLRfu54Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kt30mOd8P4tGz1Zfd9S0f8y+VHAalz+b4yytbyV/yaQ6nWR8LY2paIxiEz5P2z3FVls+A6zGMWci/eNBC5mf4/9DqdA/BYEzI3tCibkfEgqnOIUUwt2aahHrn4GCrd9iTUfzflnJGdR0V96gRl686s/S9NHONCouRweMih2fScQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=H0ky7bCI; arc=none smtp.client-ip=209.85.166.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="H0ky7bCI"
Received: by mail-io1-f46.google.com with SMTP id ca18e2360f4ac-7c3e06c8608so528539f.1
        for <virtualization@lists.linux.dev>; Thu, 08 Feb 2024 10:29:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1707416944; x=1708021744; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=sdH/0G2IBsoyHFVG72lmJAQbtMWReZVvbZcO5tSlp90=;
        b=H0ky7bCIekLp3orNZZ1s9furE1jfDyhVPnVKdTBZLfiAvFic62t99m0WYJZkpVgaw5
         j1BDg2DdeQG8iDbKJGgjHRlKwvB0vCfq59eSrTJMAanrevopaWOL4UGe4oADyQK2MTiC
         ArevtCi/q57s8aLUSCPcxROQmxh6NiERDWec8MQj7OjE1iN7FS90TVcnxj4Zv4HWFZlK
         w7lCTF8XlfLHJD2mZIB8lUtskKZqh8tdddrtU+LPMV62t62d/iPjXwxBNjPbZVKmGOaa
         NZMU0QhGHx/EBY4gJ2M0K+Ei9BYbJRuBtfQBoszN3EUUD1x4c7dJIHxHEsH7/9Cb1m0X
         2QyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707416944; x=1708021744;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sdH/0G2IBsoyHFVG72lmJAQbtMWReZVvbZcO5tSlp90=;
        b=n0vi+tTiJCd7ZRYXpT8AkIVyhDm66VwhQ73zJ2kSsgeCyzrBqR8aUI6mKeaQqcRlXQ
         apcvB7NUB8QcUrGrPGXtkIpygzBmvOK1F80CAPMTEPXIt9n3xGUWExg48afI1dE+NjDA
         ZU6Pc4K37u49sYfluNiqK+l29zvbVZN8wPNkaHx8JYkJSsbFFPDE+eGQNN0tKLFPthwF
         /G7NZdozkXoiogrBD5FHG7+vBW+TnSFPbXmZ8j4026spGVX87vzMZoHmxJqiGUWhCgu2
         kwII476UnmrkdYNfBCaxfI80U/9iBF78EaVQwS8Hz50yd9cyHuvdreX/zlUP4E+o9xe8
         KVzg==
X-Gm-Message-State: AOJu0YyOfbtV4olDU4hA0O5EME0v1BnAj2fn84XcG70xBdZrNCuikIwp
	izCuYrdIyfopvPmJYfAVL6+jILXQT4s+aBa7CbJ+SfuPayyBL38dGtwHcGvXgiw=
X-Google-Smtp-Source: AGHT+IFqbHKf7cPgN0X5em6Y1kLI0jRdWM7LS6AskmauYhPDzg044dyEHURNZu9F1Y7+7Tm9RVMQGw==
X-Received: by 2002:a05:6e02:1aaa:b0:363:c82e:57d9 with SMTP id l10-20020a056e021aaa00b00363c82e57d9mr400409ilv.3.1707416944662;
        Thu, 08 Feb 2024 10:29:04 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXzAEdoSY3xPHBtUIFtqk0AMLZNS/0tU/vP7IrLxCoF2IMjRgUWH/yFmcDfQni+nFr/eFuIU5THZwqUdU7TgRKXHPa4agxcOCe6OHMu59HSHyYotixnXTGtVSyzooAQ9IiwBWwiFHMbNIcanB7wUtREgCoWJMROdq9FILPpwnHa7fGaNPx1OXx/kq6YZq+GaWSGBtEQUzZGigGp04JxFy0bFpsKi26UEnYqW8wXAZwBozpiDMVNxBliRd+yXDODJ6kFTcvhS/MGL+UVXejhIwaxv7g/K3jsqBoB0GP/D4B47BcvoY5qOpwc3dMopGaIN3AAjWftPuDgVJYjCauTwR+NKRxy9glzYFl05LYoDNqycUoJAfbfP/uNpwRfv1vz/rT8rEzT8ijbJeWC3IbFBA1xc+nBLyGqwmKdWvg=
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id c7-20020a02a607000000b004712aee5509sm976989jam.134.2024.02.08.10.29.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Feb 2024 10:29:04 -0800 (PST)
Message-ID: <78eae4a6-cec6-43e9-ae91-4bcce3831cbf@kernel.dk>
Date: Thu, 8 Feb 2024 11:29:02 -0700
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: atomic queue limits updates v3
Content-Language: en-US
To: Christoph Hellwig <hch@lst.de>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 Damien Le Moal <dlemoal@kernel.org>, Keith Busch <kbusch@kernel.org>,
 Sagi Grimberg <sagi@grimberg.me>, linux-block@vger.kernel.org,
 linux-nvme@lists.infradead.org, virtualization@lists.linux.dev
References: <20240131130400.625836-1-hch@lst.de>
 <20240201071027.GA17571@lst.de>
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20240201071027.GA17571@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/1/24 12:10 AM, Christoph Hellwig wrote:
> I don't want to spam the list with a full resend again, but I've
> updated the branch here:
> 
>    git://git.infradead.org/users/hch/block.git blk-limits-base
> 
>    http://git.infradead.org/?p=users/hch/block.git;a=shortlog;h=refs/heads/blk-limits-base
> 
> with the bisection hazard found by Keith and the various review tags.

Can you send a v4 so we can get it applied?

-- 
Jens Axboe


