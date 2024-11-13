Received: from mail-oa1-f45.google.com (mail-oa1-f45.google.com [209.85.160.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEF1F18A6CC
	for <virtualization@lists.linux.dev>; Wed, 13 Nov 2024 22:27:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731536833; cv=none; b=EShJHOIHvjOfC/4vN9PRB+twgsRTfmP3PjazJjjXuUFldbbKOJj1K2M9LdmrAzK9rVrCvPnNuWHAb/8Lci4eWF+FS4ZXVaOeUg/GyGDnx6+vcHsduw/WzNw8z/cUAj4BSHClsw9z8yucOdaAFBK4OGw5c8nAcj4GVXAukLkF3TY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731536833; c=relaxed/simple;
	bh=nsozifW1bJaUXQvcoeJUy8/Gj7E4/mT/cosGv0myfXI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=b2E+tiHzMsYvNow3PP6SsgBb2UnfVPNHJIXV2CAFAFhj7iSwvye7tfDFutAQ1KKMH7Zy95G37C6+KrtiTM9ucTuIpmp6fNSvJvSVhKQQRcuSo+ZpnTby8xVx1G1KMXSXDZAaWaAy4ZgG6EifB6jz9Nm1egS4w6fs9bXQ2gwtKXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=ctpgDx4q; arc=none smtp.client-ip=209.85.160.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="ctpgDx4q"
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-290d8d5332cso3608530fac.2
        for <virtualization@lists.linux.dev>; Wed, 13 Nov 2024 14:27:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1731536830; x=1732141630; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Gk4zJTuuGCZq8YdlR7rEOEIOkX+EpzyKcyBLyLJ6C58=;
        b=ctpgDx4qXDPmOZEGqUxgUUVz4poQIys7zUlIGZK4z+lM06/QcmbZfrXNTHnfb2upFi
         JPhOZtjNZ99FA7QySwe//dwDxFLTwRnfuj9e9RWfGXw57KWHfoW2fWv0zBOMvsUW8fe7
         06mjRXpkGDqF2EhQW0ORvOM59M8bDyCeyVp2qWkTJy1vudjz5sSQWi5d6Gm1y6A+H8z5
         FtVbhHJSH+Mo+LESCsKwNxS4wWqgTre7NqkeEA3sh4iqkjF+jQ8i2A++pbAg2t8/UN5Y
         S2wGUEbC9zQIPm/oQmiMTAXL9jQ9y6RLOrOW8jiocgGsqJrvHtHhZAvyGZzCtt/KphJI
         LKog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731536830; x=1732141630;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Gk4zJTuuGCZq8YdlR7rEOEIOkX+EpzyKcyBLyLJ6C58=;
        b=X0tFlTbfVbm++sjKr9QOU2sauoWlOiQqNogwgjvHc+SSqgnvD4aN+56DUE+1lt4e57
         JBnEeXc4ycSeEJTyLmh52+flG0k+lo9lxWcuAV6nim4U1pcjKV4AXOF2zG3AlhEcCnCA
         wsp15H1RH9be3wWpFQB/4ywupMXbDZ8ViipAg2B2zgPOwda4d2R9fti/MURVke5hORay
         bJS3T6h1wZu1Giurq6XO0vEkq6Y8ai6XiCG71zudgdGTDX7paGKfGEmNNHcdkHSjgdnF
         AegWCh3wirqH3G/gl2vrJhIclMMPICb+QK7kdZ+ynf/gU8eVdJcwXu3m7ej2jw8Q5SKo
         xy/w==
X-Forwarded-Encrypted: i=1; AJvYcCXoVfhtCG4K9BdbwIIfKDXSgOtcXajYzfwkJ72l1xQRODzufKGMmdBg82yitOXMX5BbCvaQIREPHAVS56rXBA==@lists.linux.dev
X-Gm-Message-State: AOJu0Yy7CMVHFq0qY7wBKSv+5bGJj+d2TCIRoNFTB8qm0nWl0TJnW0v+
	iUWTiUWzcbic1IXyn9WmOUGUs5tR23Droq33Bt83DwKIK9irK/KTt1Zb+E6J9gA=
X-Google-Smtp-Source: AGHT+IGoqd96MY7bfoXv+9tibkBAuG/6TDsL/wWWwAgL5vAB2DYrndf+hvSgNBskdlUVxt9rcbSY2A==
X-Received: by 2002:a05:6870:a58f:b0:288:570d:8fe2 with SMTP id 586e51a60fabf-2956010ababmr20540208fac.11.1731536829597;
        Wed, 13 Nov 2024 14:27:09 -0800 (PST)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-295e9351aeasm1230872fac.54.2024.11.13.14.27.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Nov 2024 14:27:08 -0800 (PST)
Message-ID: <0376df05-0b60-480d-84b8-76dd2d58f1a8@kernel.dk>
Date: Wed, 13 Nov 2024 15:27:07 -0700
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: don't reorder requests passed to ->queue_rqs
To: Chaitanya Kulkarni <chaitanyak@nvidia.com>, Christoph Hellwig <hch@lst.de>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
 Pavel Begunkov <asml.silence@gmail.com>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 "virtualization@lists.linux.dev" <virtualization@lists.linux.dev>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "io-uring@vger.kernel.org" <io-uring@vger.kernel.org>
References: <20241113152050.157179-1-hch@lst.de>
 <eb2faaba-c261-48de-8316-c8e34fdb516c@nvidia.com>
 <2f7fa13a-71d9-4a8d-b8f4-5f657fdaab60@kernel.dk>
 <8156ea70-12a2-46f4-b977-59c9d76a4a65@nvidia.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <8156ea70-12a2-46f4-b977-59c9d76a4a65@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/13/24 3:23 PM, Chaitanya Kulkarni wrote:
> On 11/13/2024 12:51 PM, Jens Axboe wrote:
>>> Looks good to me. I ran the quick performance numbers [1].
>>>
>>> Reviewed-by: Chaitanya Kulkarni<kch@nvidia.com>
>>>
>>> -ck
>>>
>>> fio randread iouring workload :-
>>>
>>> IOPS :-
>>> -------
>>> nvme-orig:           Average IOPS: 72,690
>>> nvme-new-no-reorder: Average IOPS: 72,580
>>>
>>> BW :-
>>> -------
>>> nvme-orig:           Average BW: 283.9 MiB/s
>>> nvme-new-no-reorder: Average BW: 283.4 MiB/s
>> Thanks for testing, but you can't verify any kind of perf change with
>> that kind of setup. I'll be willing to bet that it'll be 1-2% drop at
>> higher rates, which is substantial. But the reordering is a problem, not
>> just for zoned devices, which is why I chose to merge this.
>>
>> -- Jens Axboe
> 
> Agree with you. My intention was to test it, since it was touching NVMe,
> I thought sharing results will help either way with io_uring?
> but no intention to stop this patchset and make an argument
> against it (if at all) for potential drop :).

Oh all good, and like I said, the testing is appreciated! The functional
testing is definitely useful.

-- 
Jens Axboe
