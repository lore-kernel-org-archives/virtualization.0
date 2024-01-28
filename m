Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAB6D446C6
	for <virtualization@lists.linux.dev>; Sun, 28 Jan 2024 23:32:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706484762; cv=none; b=Qdc4tDxN8OKQ6aPtq02h5JBmhToRV/uTI/yywpzHtQHX7qLRa5r4Rcls6y1OG/A8ruvCTpP3lYFHLBhjqQBVkVF9rcjke958nMhP5PAYf1hP57/3+DZsYkYK7RVZ+6JXzB5PnSr3dSz06vrpQhxxpWmgaTiSbX7KzoGvEG6HTL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706484762; c=relaxed/simple;
	bh=AzrwOZBkmI/cktwWlukqz0apiIuAlJnEaEkX+/5rYw4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XWBmy4Dd1RZpqFELrfiPmEf0gi+X46azNkDDzHWl0H2zBuxw5SnG4YnOw7jf6mxmpoYWAeA8VgA8c1XeuGPBMSPo92YDoVZRL92KZkVh2zE/kZ84bv79bCxIHZ6xV5823UGQFoLlycFro9xMT5nE3IxLxNVlyS88N/EG4EaVS/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=acm.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-1d8d747a3bcso2500785ad.0
        for <virtualization@lists.linux.dev>; Sun, 28 Jan 2024 15:32:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706484756; x=1707089556;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CCpOX+eVqL1Q4NSGNGjhENwjH4eu1N22wi+8Wiglz6U=;
        b=sLaB6plSzEl3b3+gMhmYbkAa+9ryrkUkn+B3qpvokviHZTI0FpB5zydfYIuOTl1eBh
         T3PxCWo5ZTfTrd5xqbEXtwSqYH56XC3mwG0i1UN0LIP0kJpVFj1vtCisZaQkzQ/1nSIw
         WS3EbOpbsQXbU1MBl3KJgiNoEE35IKsH+jG5pMTX3x81z4L2L2qQchMU5aQq+6w6P/8a
         ZEEDaEupjf32Mqpg8PxLXY67UvzOfF1CJ7TPDxSqMhQjekgmkd8bqKZ+YhBKCyBeIaD8
         LqOf5XL42xpC9xEFTu4kqv+oqHFwhRRD9UwkpeEcHe16JXZovg3R3OfoZcjw2x6QHPcu
         tfTw==
X-Gm-Message-State: AOJu0YwM+5TLgFxZDZ7zm6YVVHlp+hyPMmfL6Bkhvxqe9gUfeSCRHoFB
	uG9ZyzfDgTXJ0ECIx0sGpDE0Wk9wEGEkY1YshWzCB7qeQnwS+9EO
X-Google-Smtp-Source: AGHT+IFJ3QolskO8gZmMl8WqCUtF2qXopukrScYYsgKVaoX4rF5d94P45b/pYv2WAynpqKyF/TT5uA==
X-Received: by 2002:a17:902:8206:b0:1d7:7277:8adf with SMTP id x6-20020a170902820600b001d772778adfmr4844562pln.22.1706484755837;
        Sun, 28 Jan 2024 15:32:35 -0800 (PST)
Received: from [192.168.51.14] (c-73-231-117-72.hsd1.ca.comcast.net. [73.231.117.72])
        by smtp.gmail.com with ESMTPSA id r11-20020a170903014b00b001d8dedeb0casm744723plc.180.2024.01.28.15.32.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 28 Jan 2024 15:32:35 -0800 (PST)
Message-ID: <a0d499e7-ec2d-44f8-9b13-b1ef857e4c14@acm.org>
Date: Sun, 28 Jan 2024 15:32:32 -0800
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/14] block: move max_{open,active}_zones to struct
 queue_limits
Content-Language: en-US
To: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 Damien Le Moal <dlemoal@kernel.org>, Keith Busch <kbusch@kernel.org>,
 Sagi Grimberg <sagi@grimberg.me>, linux-block@vger.kernel.org,
 linux-nvme@lists.infradead.org, virtualization@lists.linux.dev,
 Hannes Reinecke <hare@suse.de>
References: <20240128165813.3213508-1-hch@lst.de>
 <20240128165813.3213508-2-hch@lst.de>
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20240128165813.3213508-2-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 1/28/24 08:58, Christoph Hellwig wrote:
> diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
> index 99e4f5e722132c..4a2e82c7971c86 100644
> --- a/include/linux/blkdev.h
> +++ b/include/linux/blkdev.h
> @@ -189,8 +189,6 @@ struct gendisk {
>   	 * blk_mq_unfreeze_queue().
>   	 */
>   	unsigned int		nr_zones;
> -	unsigned int		max_open_zones;
> -	unsigned int		max_active_zones;
>   	unsigned long		*conv_zones_bitmap;
>   	unsigned long		*seq_zones_wlock;
>   #endif /* CONFIG_BLK_DEV_ZONED */
> @@ -307,6 +305,8 @@ struct queue_limits {
>   	unsigned char		discard_misaligned;
>   	unsigned char		raid_partial_stripes_expensive;
>   	bool			zoned;
> +	unsigned int		max_open_zones;
> +	unsigned int		max_active_zones;

Not all struct queue_limits instances are associated with a gendisk. Do we need
a way to separate the limits that apply to all request queues from the limits
that only apply to disks in struct queue_limits, e.g. a comment that separates
the two?

Thanks,

Bart.

