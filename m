Received: from mail-oa1-f54.google.com (mail-oa1-f54.google.com [209.85.160.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC0C12038DD
	for <virtualization@lists.linux.dev>; Wed, 13 Nov 2024 19:05:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731524720; cv=none; b=OkrMNTwnmhgvTvdVgue+P+pwyXuM8wi+3InYITx7jCFNyTrBBvcOEIJU0lLMW4Xktsbs7wBRYJPGv97ecTGkT/uczaEHDGFhZ+v/mnGtpxy9JFqspkD6LIgNfa7yoLRRb6cIc1/U6snfw9jynqYwZx8oEgMNZKrIf5tdH8zs6h8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731524720; c=relaxed/simple;
	bh=vMd+aHFymQRaieFOgY6PI/o9FZajNVmFTMmwzzSIehg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bW3KBOQBCF+THnpl0k+8vVF4UcqbhWvmP2tLwYBbJzkGXo14rNmlvu46UvbFD09eXVCrxIiEiiXtk3xcRVYaRdt5Twb5H0k68ZtDEIfkw4VbS8SSPlc4TJh3bEICvKV0s5rc4n24wAYZGRkkfs1cbnyRJ/l2foeUKC00GVsFc/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=N0FaKNRP; arc=none smtp.client-ip=209.85.160.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="N0FaKNRP"
Received: by mail-oa1-f54.google.com with SMTP id 586e51a60fabf-290d8d53893so3013513fac.2
        for <virtualization@lists.linux.dev>; Wed, 13 Nov 2024 11:05:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1731524718; x=1732129518; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5d6zxdFkPsU+sD0oXkQof2KZyod3gas1uEecLduAVek=;
        b=N0FaKNRPCAElH+FZju0GtIfshUEzUX18Ut+EuTturHlF6ea1WVBwhv5jUGkzrovwtr
         KARlv6boZqNAPyNioBBOrovigSqz0kqygunNuwkbkCptqH5h6ahEzjL+JPsbsSMd2a8s
         TSnLidYxvPWnYU5SobslAqrMBbqssCbEtEkAIFbjFk5ceGvVTfV0AFPkEvOTMzXD1eUG
         DtyO7DHf6avhazmYBAQawH4BkgCqlotZZW+b80xKjmEAg8Xkglkc94KYwizF3hAgCl0X
         J5L0X2xgUpPq5XNi72lIKxPJLJ9xMhCCIrO3E1QK8/xtXuFiWu4qSA88GFxgPRwBDb4+
         qG+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731524718; x=1732129518;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5d6zxdFkPsU+sD0oXkQof2KZyod3gas1uEecLduAVek=;
        b=quF3UWnALL7uPAxdfECy1WLnH4BZdy9LgE0wd/LmDRQpCSQo3Ljzaj+wvU6uQQufO1
         TY+e/QRU0YbZBo9g7V31XcsojRJS5uNBj99R3HZ5UrVw5tUTVhC0PMhzbcIOy2Y4yD8J
         9l99m+ye5ZNQUIHcUgArK6eTlwmze69mRYRl9kZzO9LZDohTsHOs9wJpMS83SSB9YgWM
         ohrK9MU6/JOGUhQKk+0GiA2ct7Na/6Fotk+cbC0PKJY/aF2rDqsjUGSW0ymEx/zXGBhV
         ZbLlEzTYBfgK3gkh/u+Q3EABlngUVk8GN/Z+3hANKNHlvCN638teyP12HTcOVdrYRKjB
         SH6Q==
X-Forwarded-Encrypted: i=1; AJvYcCVFcL8piJNnZNMEF68lXOl4KTEQIBJ06iUJh0BrsIvOA568LfnSXwifPxG19yxkyxa4WvhhE18J3cjk4EfWCQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Yyt3poUz617JjeQ1hVXsnUuJrbNQy9JHVsZOaIJ3eWHXIWaIoTG
	4JKZcGOHZ8Q39WNLqu35jG93OhsrXcoFu/4uxDdQvZDq4tErq5V5+VhbVRXJdUQ=
X-Google-Smtp-Source: AGHT+IEqEfISzu+U6ZtkcyQQ168T1b3zcTYcdZM+b6/RCKr3qC5Y1tU76M7H+wd+oi8YKkF3o4FBcw==
X-Received: by 2002:a05:6871:6c9a:b0:295:f651:da2e with SMTP id 586e51a60fabf-295f652881dmr2201325fac.21.1731524717878;
        Wed, 13 Nov 2024 11:05:17 -0800 (PST)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-71a5fe673a1sm865837a34.3.2024.11.13.11.05.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Nov 2024 11:05:17 -0800 (PST)
Message-ID: <c09728ae-1a53-4b6d-8407-07c18fc27e50@kernel.dk>
Date: Wed, 13 Nov 2024 12:05:16 -0700
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/6] virtio_blk: reverse request order in virtio_queue_rqs
To: Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Sagi Grimberg <sagi@grimberg.me>, Pavel Begunkov <asml.silence@gmail.com>,
 linux-block@vger.kernel.org, virtualization@lists.linux.dev,
 linux-nvme@lists.infradead.org, io-uring@vger.kernel.org
References: <20241113152050.157179-1-hch@lst.de>
 <20241113152050.157179-3-hch@lst.de> <ZzT4CHjrmD5mW2we@kbusch-mbp>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <ZzT4CHjrmD5mW2we@kbusch-mbp>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/13/24 12:03 PM, Keith Busch wrote:
> On Wed, Nov 13, 2024 at 04:20:42PM +0100, Christoph Hellwig wrote:
>> in rotational devices.  Fix this by rewriting nvme_queue_rqs so that it
> 
> You copied this commit message from the previous one for the nvme
> driver. This message should say "virtio_queue_rqs".

I fixed it up. As well as the annoying "two spaces after a period", that
should just go away.

-- 
Jens Axboe

