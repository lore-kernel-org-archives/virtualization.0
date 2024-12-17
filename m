Received: from mail-io1-f51.google.com (mail-io1-f51.google.com [209.85.166.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 938AF1DC18F
	for <virtualization@lists.linux.dev>; Tue, 17 Dec 2024 21:07:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734469650; cv=none; b=SYKoct83OBoN5qa6QEh3RGoExaU4s4OtRtr/a5SAo/z+5TOFbEH6R6+oFjllq32GN47+/9Lz4RgcoFK1vlGfnHHSNEaIpwkd8YfoNQw7Qswu33rQ88xQnt6i2ZA89mkmuzwnDrhOFtdQ2KpiEMevXE5hTEY6lagmR0nMMINT1Ek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734469650; c=relaxed/simple;
	bh=DYXCpIfYdRHNRG32/Ni0pl1LzbN+rMCEr35BN5GBtqo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=H1cGR8RgKqKbMBIodyFWCU2R4/U+BxFVtFbss5t42wWgYEBYNn6Ab3Fnf+zoEATlOV6yzlw+MlxBsQWq46J7rq4Ep/tEOlNRzY+LEh8olxSWiUR0KuwmhZYPPRXfjhw1bUDufpaY18CR0bgED4jkWaGhkOWk63W2SSZmFJWx1CQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=MgBz3o3d; arc=none smtp.client-ip=209.85.166.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="MgBz3o3d"
Received: by mail-io1-f51.google.com with SMTP id ca18e2360f4ac-844e39439abso155446539f.1
        for <virtualization@lists.linux.dev>; Tue, 17 Dec 2024 13:07:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1734469648; x=1735074448; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xxTHFAi0ufizCl7I67BVly4Us0FktZFreE3PeudaUmw=;
        b=MgBz3o3dnLy0a9ftqWZHJy4rfb5HxyimUBT9xASqKJVE17sXRc3kf+uivbQiZ1vrmv
         LFw6XXdLYTS3xKgvlultfhCTzi3X6IfzGSwF0fPcVuruMIZ4NE40SA+RtecWYu0QszdP
         59nAs/eM7fPJjN1+xUUnQX68JCMV3AaNhRRfjTIQtgcp+LIsNpjPNAKgjx+KhpUrqmcg
         QEEZJOzad8ePDAp2uepySBbJKy4hgC3rV4hhNnF6x1U/yAZXRzFSBaLu/atdgKYnNBfW
         xJM9AMfTZve068m93EZTDYcxGdY/7rAKNFaBKTnXet1D2kCYS5VxhThTCnIaiiPqgeOG
         RiqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734469648; x=1735074448;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xxTHFAi0ufizCl7I67BVly4Us0FktZFreE3PeudaUmw=;
        b=QAZGszzTKT4FBqbs5bD3cSJfq1PGxzP/UGXUiXDYTKbervCS8F4d0nGPVvFliG296Y
         4DeUZrShs6cPG6ie//TyUMG8LSMyit1rrULPQB6UP0iizaQC9WTpAv7/20wBRIasdEB6
         Jeqdv/jdoLkIAz4TGRS+QbYPF/D32/2DW58lW9t5dgdPIx4BypmC/uikw9FdCFimMFMu
         PhGa/tCktv1RGPDCLl73eDBfTGnySNZGnVOVqGYruSkgBwDVmNajyrkSn3L1osy6tQsw
         YtAKXp5ZhPqCSxgwvV+IbIje+heWjzIXhnki1eYk4x1kPbvJUAxxoGMjM7YCi/p7wTur
         FZcQ==
X-Forwarded-Encrypted: i=1; AJvYcCWk75WDGy3JhGaUsLvx97edeMRIe/55TaMI5CIS2+QdfYTLZcj0K83FVhbuDf+nB9mjU8opVAc6zCI+eDMX+A==@lists.linux.dev
X-Gm-Message-State: AOJu0Yw1GCHFlfEFfexAhDCdYnrkYexkGm4jTZaZcRG2sN97tipJHTLm
	f4+rboG7z2hp5010R+snMjJOmcC1CAT6m13D6HHX8WLXqZ+f2Ua+7+T5x3KGfoQ=
X-Gm-Gg: ASbGncvNXCbJs7qPyH9icaKIck0Nwy50JQDY0Z16S9oooI36cJnEPfflqoCf50nRKzF
	KYKMjx1+Zdvb2v7RJ17Bbnt1Jundds5fOqyVzFj6thXBPrP8xcgx0g2dfNIfoQdEzTZx4oxKSLw
	f6lGPNB+G0nq/EWaNhShzchs2UmQE6XeizrpBWyfJu7dirEgllrCxlqz7axUFAoHylCxBErhSTl
	apRRpmcWjnQVn7cUaClFZ1J4vqDcVCJpL7eax40CtJjWq3x97hS
X-Google-Smtp-Source: AGHT+IEZuOks5bPSEmDavYC9qmsQ8z1l/snRQxoEwkEepPxAkIeF35dwOhWBSaIIdJE+B3U31qo95A==
X-Received: by 2002:a05:6602:2c88:b0:803:5e55:ecb2 with SMTP id ca18e2360f4ac-8475831e21emr49355439f.0.1734469647813;
        Tue, 17 Dec 2024 13:07:27 -0800 (PST)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-844f62583ebsm194676439f.11.2024.12.17.13.07.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Dec 2024 13:07:27 -0800 (PST)
Message-ID: <92eafd0f-943a-4595-8df3-45128cac5ee9@kernel.dk>
Date: Tue, 17 Dec 2024 14:07:26 -0700
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3][RFC] virtio-blk: add io_uring passthrough support for
 virtio-blk
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: Jingbo Xu <jefflexu@linux.alibaba.com>,
 Christoph Hellwig <hch@infradead.org>,
 Ferry Meng <mengferry@linux.alibaba.com>,
 "Michael S . Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 linux-block@vger.kernel.org, virtualization@lists.linux.dev,
 linux-kernel@vger.kernel.org, io-uring@vger.kernel.org,
 Joseph Qi <joseph.qi@linux.alibaba.com>
References: <20241203121424.19887-1-mengferry@linux.alibaba.com>
 <Z2BNHWFWgLjEMiAn@infradead.org>
 <CAJSP0QXU_uNqL-9LmLRkDdPPSdUAGdesQ2DFuCMHnjyEuREvXQ@mail.gmail.com>
 <0535520b-a6a6-4578-9aca-c698e148004e@linux.alibaba.com>
 <acaf46f3-3f6c-44c9-86b5-98aa7845f1b6@kernel.dk>
 <CAJSP0QWfSzD8Z+22SEjUMkG07nrBa+6WU_APYkrvwzNbScRRCw@mail.gmail.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <CAJSP0QWfSzD8Z+22SEjUMkG07nrBa+6WU_APYkrvwzNbScRRCw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/17/24 2:00 PM, Stefan Hajnoczi wrote:
> On Tue, 17 Dec 2024 at 12:54, Jens Axboe <axboe@kernel.dk> wrote:
>>
>> On 12/16/24 11:08 PM, Jingbo Xu wrote:
>>>> That's why I asked Jens to weigh in on whether there is a generic
>>>> block layer solution here. If uring_cmd is faster then maybe a generic
>>>> uring_cmd I/O interface can be defined without tying applications to
>>>> device-specific commands. Or maybe the traditional io_uring code path
>>>> can be optimized so that bypass is no longer attractive.
>>
>> It's not that the traditional io_uring code path is slower, it's in fact
>> basically the same thing. It's that all the other jazz that happens
>> below io_uring slows things down, which is why passthrough ends up being
>> faster.
> 
> Are you happy with virtio_blk passthrough or do you want a different approach?

I think it looks fine.

-- 
Jens Axboe

