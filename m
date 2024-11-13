Received: from mail-oo1-f41.google.com (mail-oo1-f41.google.com [209.85.161.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D75402036EE
	for <virtualization@lists.linux.dev>; Wed, 13 Nov 2024 18:39:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731523199; cv=none; b=F+1bO3Z2gv944JHwriTNQWAFF3nQZgVeCuJpkiXjJyBJYLY/QpZtgbIY4z2xoyDrgh9mPph3ZHc6DVgIwi8E1/lzCU9DNl6bj6Ol/6fiXDpBy/wGONuzBq6xDgXOgeD+d8PJgggKHdNzdDAg0MHhX+3yuhqkBdZ/fLNZBryhpbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731523199; c=relaxed/simple;
	bh=2oozyG9UXwFWfpyRebPhngHz207nrqCB7dySSeD1/u4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hvjMmGAELj+QaHR/MdE163vHLrmGTZ1v7ZbDdTuwB5RfaGh64DwioYQZIXnb9ZfG/VWac8JC5QgmFnSulzx+bIwZmXunh176ECqQXjV8nDWmp57eSkqWtsB7gDpksa5o7ffF4eGVSdKjfG+NB0moKo31zBt0tOLdeMfgeXICCjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=sFh3oiIs; arc=none smtp.client-ip=209.85.161.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="sFh3oiIs"
Received: by mail-oo1-f41.google.com with SMTP id 006d021491bc7-5ee53b30470so2957700eaf.3
        for <virtualization@lists.linux.dev>; Wed, 13 Nov 2024 10:39:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1731523196; x=1732127996; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WgXDWP6uTO9OvPO11ONSGz0dajsnDJA8Ia+wd76L1pU=;
        b=sFh3oiIsIyRm9L/ZOevAsvigwSkOhF4OgYpa3YShoHYCGeQaajgvZ/7xxmiZmVMgI4
         tNKEfpAOWS5zR/7tLhBk7ZqCz+EDtpJvaOnVqMEsIAw+8ElsDC3Y0n7rwr5gCBS2rRi1
         sbZ7dlzAIhPhzHsEojxi2p/vZF0oDVFJ+GJlgHFUagPUhh/4PmgEpfPyTku+28MBZHaG
         wzCvrCgTdCebfT6/glSqNjUxH2ZzI9precDbMzJnZWF1No4v7K/dOiCjF+cbMEwPW86k
         Y6Ysm9MVN62zGaSqe0+x7CioFB7AJ3heZQiPopvSO1IrVo7FwRYLarOUEQef50ADMm2D
         hEQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731523196; x=1732127996;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WgXDWP6uTO9OvPO11ONSGz0dajsnDJA8Ia+wd76L1pU=;
        b=g414ApAkyvBLfvdTEVJ1cBNb6u/7QcTG8Yfc4kKh/I6+0iGJ4wzqRLgwRE28t9SMDJ
         DPaUrKv2OH/ZjaVud7aBpUW0A0OxKlG8D0bIuCRL9uXyBSrRKp4dMQxjt1c9V/zG01vs
         QgakNJEUAPP41We9ca/Br/nx169yEMhBXnwf9LCTZS3jNKufQFWhLUTjFg5FmUE100Ld
         zzyb1fD34KdOy5lK+hFg/tegUIQG1eEutlnAMUS7TyXswQSeEk15zJS13w+2ZGswQgLN
         vmjQNGN3Mpt+EfGpltr+DDdxeAQ1zlGErXvM0mZQCIptyhJZsbNqCMwuS80s0K+DgM6m
         +oEw==
X-Forwarded-Encrypted: i=1; AJvYcCWq/Kh3GfaU6ri2iTqGZqEzBhRoAJce1HnxAtAMUy8IkOniFwl4FB93HPwxxZSmOoTwyKTUuz+vfhIg3pr07Q==@lists.linux.dev
X-Gm-Message-State: AOJu0YwN18Z3SAB/tgc+2J9GAJpTqoD53WWb0JD3xPzllnMFqYr4zYME
	yN970ZMYZ03xUKkhtEAyfk3do83N0XiaLOcVJhfsG2hJA4xPe25Ccl+7mTokdNY=
X-Google-Smtp-Source: AGHT+IESBxgtKu/tqS069ieokYdQsF86VTGk5XXSX9JBOM6NYNLoE/FOQHmxs2aJ76kIzJOEXUf+Gw==
X-Received: by 2002:a4a:ec4c:0:b0:5e1:cd24:c19c with SMTP id 006d021491bc7-5ee868b0bf0mr6129208eaf.0.1731523194524;
        Wed, 13 Nov 2024 10:39:54 -0800 (PST)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-5ee4950edfesm3141888eaf.14.2024.11.13.10.39.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Nov 2024 10:39:54 -0800 (PST)
Message-ID: <ffe1f8e9-5484-43f9-a410-2927d0c63659@kernel.dk>
Date: Wed, 13 Nov 2024 11:39:52 -0700
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: don't reorder requests passed to ->queue_rqs
To: Bart Van Assche <bvanassche@acm.org>, Christoph Hellwig <hch@lst.de>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
 Pavel Begunkov <asml.silence@gmail.com>, linux-block@vger.kernel.org,
 virtualization@lists.linux.dev, linux-nvme@lists.infradead.org,
 io-uring@vger.kernel.org
References: <20241113152050.157179-1-hch@lst.de>
 <92954431-349d-4b75-b63f-948b1df9a3fc@acm.org>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <92954431-349d-4b75-b63f-948b1df9a3fc@acm.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/13/24 11:33 AM, Bart Van Assche wrote:
> 
> On 11/13/24 7:20 AM, Christoph Hellwig wrote:
>> currently blk-mq reorders requests when adding them to the plug because
>> the request list can't do efficient tail appends.  When the plug is
>> directly issued using ->queue_rqs that means reordered requests are
>> passed to the driver, which can lead to very bad I/O patterns when
>> not corrected, especially on rotational devices (e.g. NVMe HDD) or
>> when using zone append.
>>
>> This series first adds two easily backportable workarounds to reverse
>> the reording in the virtio_blk and nvme-pci ->queue_rq implementations
>> similar to what the non-queue_rqs path does, and then adds a rq_list
>> type that allows for efficient tail insertions and uses that to fix
>> the reordering for real and then does the same for I/O completions as
>> well.
> 
> Hi Christoph,
> 
> Could something like the patch below replace this patch series? I
> don't have a strong opinion about which approach to select.

I mean it obviously could, but it'd be a terrible way to go as we're now
iterating the full list just to reverse it...

-- 
Jens Axboe
