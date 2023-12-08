Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 343EB1851
	for <virtualization@lists.linux.dev>; Fri,  8 Dec 2023 03:15:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="nvxjsLI4"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-1d072f50a44so3674975ad.0
        for <virtualization@lists.linux.dev>; Thu, 07 Dec 2023 19:15:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1702005320; x=1702610120; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jGfLZ/anCgoizin3EJrsBtWsOUnIV8oEkhHw3KAoiyE=;
        b=nvxjsLI4fuaD/epZ+C8JtFa6e5eySj+c2aHetB9lJk0tx1zLZZQiL1D2eo5ybgiqwC
         t4NmYS8rOwBSpZ8+aGhfnBCXoHogupGrbnvdT4zBpZLZMwOfnmEgYV1nnB1iuLqQFlJ+
         NcIOhQbcDmtf1aGYDzB9YLB6RbeYvI7NvDFkG5c9NqpHlxMr1P7Vtp/gxlVYQ/eXLs2j
         1AZjmv3KxWIWAxPmBJLDGC0zN3orjRRaIQ5WOchTPiqeoagQZDxL80xDmBuYhkCd8j7c
         eY/jGKp19NUlY7komea+qycnMRyLK5osM+JYjaj4c5wB/IlNBqSFtZTfRI/1SLzzajo+
         jZpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702005320; x=1702610120;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jGfLZ/anCgoizin3EJrsBtWsOUnIV8oEkhHw3KAoiyE=;
        b=eRD4B/ee1dutP4iyXR0gSFmRHQ3vDtUfgIDTXvgIeZGGx7/6njjzMAVuKhNs26yVGj
         sUXzTNy/IF3XljXHjM9H1ezPsh8Z4SFbNLIDJorqKfdIFvssYXI1YgYqJHAj7uFHiy/A
         ArcHOJenUv710xHKrh5gYuJMTQ2UP5mKtpPlByjFc5tC64JRDRMhD2b6lgPhNSitBakB
         j5wPXHJEMnuyJbY7CXvYOkuFMMUvSm/ob11ct/o8Gshn6mlroLsd1RTGSb4YSPno4/dP
         cF7Tjqlxd8pGJTpKzt0lLPnwWWNrmf3nO2i7lWVBT8LtBeRTt/1LTWizVtAfpSpBmXGt
         CRiA==
X-Gm-Message-State: AOJu0YxpOQielAs2TBLfnR6e6CHVPlInY7fsMlWGQfKjflpgD0GBAVrg
	z5Ms/APvejtPfWTshI+b+hYZKQ==
X-Google-Smtp-Source: AGHT+IEb0VGLsYlBNxLkCRq834nrTlhul/JW2q5GdSZUzgMVZYylVw6G7cr3f6N2ts4MFxlhZfZU8A==
X-Received: by 2002:a05:6a20:1583:b0:18b:4b84:3a1 with SMTP id h3-20020a056a20158300b0018b4b8403a1mr7015450pzj.5.1702005320251;
        Thu, 07 Dec 2023 19:15:20 -0800 (PST)
Received: from [192.168.1.150] ([198.8.77.194])
        by smtp.gmail.com with ESMTPSA id w4-20020aa78584000000b006ce5c583c89sm532425pfn.15.2023.12.07.19.15.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Dec 2023 19:15:19 -0800 (PST)
Message-ID: <d9afeea8-2e67-4a90-8f7e-98b4c904a314@kernel.dk>
Date: Thu, 7 Dec 2023 20:15:18 -0700
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] virtio_blk: set the default scheduler to none
Content-Language: en-US
To: Keith Busch <kbusch@kernel.org>, Ming Lei <ming.lei@redhat.com>
Cc: Li Feng <fengli@smartx.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Jason Wang <jasowang@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Xuan Zhuo
 <xuanzhuo@linux.alibaba.com>,
 "open list:BLOCK LAYER" <linux-block@vger.kernel.org>,
 open list <linux-kernel@vger.kernel.org>,
 "open list:VIRTIO BLOCK AND SCSI DRIVERS" <virtualization@lists.linux.dev>
References: <20231207043118.118158-1-fengli@smartx.com>
 <ZXJ4xNawrSRem2qe@fedora> <ZXKDFdzXN4xQAuBm@kbusch-mbp>
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <ZXKDFdzXN4xQAuBm@kbusch-mbp>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/7/23 7:44 PM, Keith Busch wrote:
> On Fri, Dec 08, 2023 at 10:00:36AM +0800, Ming Lei wrote:
>> On Thu, Dec 07, 2023 at 12:31:05PM +0800, Li Feng wrote:
>>> virtio-blk is generally used in cloud computing scenarios, where the
>>> performance of virtual disks is very important. The mq-deadline scheduler
>>> has a big performance drop compared to none with single queue. In my tests,
>>> mq-deadline 4k readread iops were 270k compared to 450k for none. So here
>>> the default scheduler of virtio-blk is set to "none".
>>
>> The test result shows you may not test HDD. backing of virtio-blk.
>>
>> none can lose IO merge capability more or less, so probably sequential IO perf
>> drops in case of HDD backing.
> 
> More of a curiosity, as I don't immediately even have an HDD to test
> with! Isn't it more useful for the host providing the backing HDD use an
> appropriate IO scheduler? virtio-blk has similiarities with a stacking
> block driver, and we usually don't need to stack IO schedulers.

Indeed, any kind of scheduling or merging should not need to happen
here, but rather at the lower end. But there could be an argument to be
made for having fewer commands coming out of virtio-blk, however. Would
be interesting to test.

-- 
Jens Axboe

