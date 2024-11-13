Received: from mail-oa1-f51.google.com (mail-oa1-f51.google.com [209.85.160.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38798205ABD
	for <virtualization@lists.linux.dev>; Wed, 13 Nov 2024 20:51:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731531115; cv=none; b=otVTgTBwADvxj+YfMOuFujhXbbsN5CsQ1SUl3iKFQJEs+EpwJ25WkM6KE1ywmTx96nDyNZo8l4dPO1/WjL+908q5PiCXfII0Qm+Hr2OmyP47amTbO38K5vyEQNhjL+nfbPHxD8H74lag3SfybFPo3sv8dMNjgyBww3+Yw7g/y3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731531115; c=relaxed/simple;
	bh=QpWF3KKY11uITtp1LyQktCr06S/wpts4SgMopMh5/iQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZrrIu4t5QRpioLmgvxaVNME7zYVDEELyTFQKTdCGAViFtfl7E7lCiVmeTlqNwHg7SBcuYbxhe5Vdbh6W3i1yaOAq4fubdlH9A/Mm/vdG0ZGC0GAaslEeTz7g3U7cKU9UVZbelNvzMFrIIBaJWDT+hvpxWTCRLozDdpOtjPPXkwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=q9UwKiT6; arc=none smtp.client-ip=209.85.160.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="q9UwKiT6"
Received: by mail-oa1-f51.google.com with SMTP id 586e51a60fabf-296085d59caso119995fac.0
        for <virtualization@lists.linux.dev>; Wed, 13 Nov 2024 12:51:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1731531111; x=1732135911; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FU0Uq6tZfqhLW7zTHB3UvLVsIx1+QgdH15vw3E3v+9I=;
        b=q9UwKiT6dR95U56jvFZtAZ3rxHiyx/xKxiW4XRFG1lduxHz4dl45tJnLeE/DkGxQ/b
         7JcJtokojjNvQZ0aXXOLJZO9c1npP3oWfjk6kexgn7FEm8E7Qef/4kGBYwP/eOynvKfY
         b1e4Sj+s+HWu1m/npWfuAKg6SIyfg6l6gmz4yGM+BB8rZ5UkV82eOKu5lRHHwMR4at/f
         bK7OaDlWKdyKC7rvjAOQYbQ9pAxfxBQHo6M69F0N4nMWuM81sl0fWxcaQdUQyxWb9mw1
         veFDjC9ep10YAxcjuvRMEjqV4EGSVQbLe0eUrt7bocAu5FNl1FT79QtAF1GfVysPbcbK
         M8Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731531111; x=1732135911;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FU0Uq6tZfqhLW7zTHB3UvLVsIx1+QgdH15vw3E3v+9I=;
        b=bqGGv1emm8cf6zp9JaVgYDE+35H5GFza690rXC0hfZFDEn/ABRV9gA5II3op/E8ZZk
         T0Q8EwnBkoZYdlOFO0w6catWwIBPBWmnDiWL7T2CPXwkeisYKAkUvWXSbUUO5RRCb0f6
         joqwEN4hLvDVqSdg7s47tP/V+ZaHx21RSWpHJpod8TcIGzA5CX9EllFkI15ZMR/xDgQf
         weSvswA5dkePAaoNEeFPqHey2GoJcPHqrzTln1EYyFoOxG+E6gMZFsFz3TWThkAvwb11
         AqjLdFE+wdg9rDyGz857i1NiC1SpMvY9YrT6uAeABGLoUh+4nwRHJvWMFFu8IgCsANKN
         c79A==
X-Forwarded-Encrypted: i=1; AJvYcCXRmmY0fVJVH4go4eXKB9qGhqijQgTA14jRtrNGP4bhpg8RaB5JxyNsrepVjoI9QO3qEzEHzXkgaqV+d02RMw==@lists.linux.dev
X-Gm-Message-State: AOJu0Yx95okQCusbYqMhg3Iq8mOSvJi5qhwTTffZfCe9GOkdI+Hg9/Hp
	qhbFPmTHkNYd3arFxiy19YhhL0WOt0AAxEntQSjGSP+Dg6XizkGp1hUDWC37psY=
X-Google-Smtp-Source: AGHT+IGezMqio38lqokF3/YlzSrsEv2nuKdbrSqS8PqApuQDKwmdb/YnN439LHoKX0bRZy3D+8M0gQ==
X-Received: by 2002:a05:6871:209:b0:288:67c0:1bbf with SMTP id 586e51a60fabf-295600f0491mr20870572fac.22.1731531111227;
        Wed, 13 Nov 2024 12:51:51 -0800 (PST)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-295e9337321sm1169214fac.46.2024.11.13.12.51.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Nov 2024 12:51:50 -0800 (PST)
Message-ID: <2f7fa13a-71d9-4a8d-b8f4-5f657fdaab60@kernel.dk>
Date: Wed, 13 Nov 2024 13:51:48 -0700
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
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <eb2faaba-c261-48de-8316-c8e34fdb516c@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/13/24 1:36 PM, Chaitanya Kulkarni wrote:
> On 11/13/24 07:20, Christoph Hellwig wrote:
>> Hi Jens,
>>
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
> Looks good to me. I ran the quick performance numbers [1].
> 
> Reviewed-by: Chaitanya Kulkarni <kch@nvidia.com>
> 
> -ck
> 
> fio randread iouring workload :-
> 
> IOPS :-
> -------
> nvme-orig:           Average IOPS: 72,690
> nvme-new-no-reorder: Average IOPS: 72,580
> 
> BW :-
> -------
> nvme-orig:           Average BW: 283.9 MiB/s
> nvme-new-no-reorder: Average BW: 283.4 MiB/s

Thanks for testing, but you can't verify any kind of perf change with
that kind of setup. I'll be willing to bet that it'll be 1-2% drop at
higher rates, which is substantial. But the reordering is a problem, not
just for zoned devices, which is why I chose to merge this.

-- 
Jens Axboe
