Received: from mail-il1-f169.google.com (mail-il1-f169.google.com [209.85.166.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47BAC1F8F0C
	for <virtualization@lists.linux.dev>; Tue, 17 Dec 2024 17:54:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734458070; cv=none; b=V29VDG2ys+ymmM7XtlxDGsPG44+IjwSuGlqkr2rVHgrMzDQ68Fwk/UxDycCcEmowJyxMnl5YMHzQyjoNXFhBJwmnw5cDi1kJqFHzPRBFP2NdNqQa58qhgGbgEtL/a79DgMwJL11FDz6oOKQ1ae3+p1EdZOfxrxmOBtYfhEmDwvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734458070; c=relaxed/simple;
	bh=Lyz3pxba+WfjDFPIDQ6xn8XAtkSqhUaQDO2p6HbBcnE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=txsrUupS99MOqBURrK+g8pFeoa6eqg5ASag1vmUb8WmHtugKChvEDrf28RhWZUFe8qjacmAlEPFRR1fd89RcbP7w5+W6WMi7cl64kemo0aTI0NzcuT7CiLxZVhgacTOd2FiSwL54goSLK4v6v9PcqRJL2suNUIb8RA/sb/MMNv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=SLvWjtCT; arc=none smtp.client-ip=209.85.166.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="SLvWjtCT"
Received: by mail-il1-f169.google.com with SMTP id e9e14a558f8ab-3a81a0277d3so17198155ab.3
        for <virtualization@lists.linux.dev>; Tue, 17 Dec 2024 09:54:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1734458067; x=1735062867; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+S2KbhIrhYKECFApyJjGLk7qrmZwBnp+gEfOwbZqgUo=;
        b=SLvWjtCT3JSkzRu2h/aDNUz9RUkJn7EHucWobkgoxAh3zPFeKDT21PntUmloX366Kt
         gQT/qP4pysu0CsPdo8axcLncZpI8x3oAUxtgOHdff2f5LfccLyzNzM1R+kVCYmc0rYRo
         rtXUrBLz8sDVhdK0g3C5BxQiyPrGqoj2/+kBW3b/bsiKlh62VfYASx33IJSxvQxJ9lzq
         GpCCN/lhiB6KLy4VpCNcfH2VKjFhJEGBe8mO75M597YhW7uaXHFFB1dj4v80W2TnUSEt
         LT3f67DmaduI7v+6thBKY/3IOuoWZowJQK2J9qraE+Rz7yoJ+iTjRvidteROGU2XBDsy
         btIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734458067; x=1735062867;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+S2KbhIrhYKECFApyJjGLk7qrmZwBnp+gEfOwbZqgUo=;
        b=usbpOvo5U0bmzpBY6ZOYvyf94vYR/dMoyGJLtBW175QJaSphb6xrEzg1+ofmndZzZu
         CjXKK0rJ/TqX+hJZSvcRqW0J6qwzNbVOAvrxhccWPK16X1saySgkhVNuI9TEHxz0f6lF
         TH9m/HcNK4ogn4gfDfnIxR14qI8bwSpvqpG6/nzofLZJBpFoyrRHpdggRwC0ABVJ2p96
         kEKocr6jmKXa0byyS3/ZSJqzxrOhufCv1By3giw+vzg9DPmZ5hm3YtNHmC8ztkt779K6
         oqZvRwpHMOteswsj+mtrSk+zMN/wnAfbzM7v65B2AdxOLcOCKGJUdhUPvnw9G6XT8o08
         JcIQ==
X-Forwarded-Encrypted: i=1; AJvYcCXbs4yFSApz5GWP14ZmCNYRO4GWb9k07CUoJpYpPR5ALV67ReVF0t3hwb71adTautB4o7yHnOrgj1IAqXS2uw==@lists.linux.dev
X-Gm-Message-State: AOJu0YxQmU4CCywzNMVIFMX1q4QQIpejGQCj4ynbPYByCW/MGyaxgbnf
	MR31K0fbw1n6VVadTaMAuBlowlOmH3pgayYNj8nsrqykbAe0hwnnuLJ2HzzhAaE=
X-Gm-Gg: ASbGncuPu5tn0Q43jEcmx9ZZwfUPa1AREx1lTeFzvJEpMFzf7psM1XQcxfEIqF3eGmD
	vKXP50RLxFIcU/iMsILvYWAlJG2OGiR23suOpUxngBEuktp0jIGppDu4DwnKmJhC51bVjZ+ERDJ
	777NAgPaghc/QpumkxEew20i0Fj8GjGVBK+yjQas784YHOTbvoySGGDmJ+dr3sLRzwtZycw+Sh/
	KsuckP7G6OU0viMVB3WDSypjqpwhcqJN5gJ102rKR52Ewu9ZGtB
X-Google-Smtp-Source: AGHT+IEu4IjNs/5xorwpYlZBESvq5LvFi/8gufZqjoD/nmtALPkmYF9FSVwvwu7wAaOMQC3j/4k6gQ==
X-Received: by 2002:a92:c564:0:b0:3a7:6636:eb3b with SMTP id e9e14a558f8ab-3aff800d5d2mr172047215ab.17.1734458067401;
        Tue, 17 Dec 2024 09:54:27 -0800 (PST)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4e5e32a33cdsm1793038173.81.2024.12.17.09.54.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Dec 2024 09:54:26 -0800 (PST)
Message-ID: <acaf46f3-3f6c-44c9-86b5-98aa7845f1b6@kernel.dk>
Date: Tue, 17 Dec 2024 10:54:26 -0700
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3][RFC] virtio-blk: add io_uring passthrough support for
 virtio-blk
To: Jingbo Xu <jefflexu@linux.alibaba.com>,
 Stefan Hajnoczi <stefanha@gmail.com>, Christoph Hellwig <hch@infradead.org>
Cc: Ferry Meng <mengferry@linux.alibaba.com>,
 "Michael S . Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 linux-block@vger.kernel.org, virtualization@lists.linux.dev,
 linux-kernel@vger.kernel.org, io-uring@vger.kernel.org,
 Joseph Qi <joseph.qi@linux.alibaba.com>
References: <20241203121424.19887-1-mengferry@linux.alibaba.com>
 <Z2BNHWFWgLjEMiAn@infradead.org>
 <CAJSP0QXU_uNqL-9LmLRkDdPPSdUAGdesQ2DFuCMHnjyEuREvXQ@mail.gmail.com>
 <0535520b-a6a6-4578-9aca-c698e148004e@linux.alibaba.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <0535520b-a6a6-4578-9aca-c698e148004e@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/16/24 11:08 PM, Jingbo Xu wrote:
>> That's why I asked Jens to weigh in on whether there is a generic
>> block layer solution here. If uring_cmd is faster then maybe a generic
>> uring_cmd I/O interface can be defined without tying applications to
>> device-specific commands. Or maybe the traditional io_uring code path
>> can be optimized so that bypass is no longer attractive.

It's not that the traditional io_uring code path is slower, it's in fact
basically the same thing. It's that all the other jazz that happens
below io_uring slows things down, which is why passthrough ends up being
faster.

-- 
Jens Axboe
