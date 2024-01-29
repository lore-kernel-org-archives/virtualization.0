Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A126FBEB
	for <virtualization@lists.linux.dev>; Mon, 29 Jan 2024 02:59:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706497176; cv=none; b=TTYx1u90OUmInRpvWPGV5/ZHHceVywGztm7DipciIlwhf+MyTIvb75l1tm8SGt5UbhU3mY3Xhc4i5LQ9ss5EKkyTeXHLXPTIyjFHPWYoSU66fRHyQngjpNaf8f/aW2JKuBB/7SXm6DBVCWJGMzRpZ2+BY+UWgpd8jDqIDVvq6eg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706497176; c=relaxed/simple;
	bh=DZUg1XoT8wokjq4uWFSKm1U2glAHD2r08GSBb58s88Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gwbAP0JfkFomMOoXdBuaGFor5ar+DtgiJhf3cSayH8dTG1k9o0OhsCzfMW0fj6MHU1ybFe9uG2h79VSW0yDD685VHQM3c4b9CSI08iRzTtBkztCFMNA6NZyjbPuVIbj+xIH4fh103F/hmzfpqdGDbLDvO8Y8QEJ0hU0SYTHvEgA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=acm.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-1d8ef972451so368675ad.2
        for <virtualization@lists.linux.dev>; Sun, 28 Jan 2024 18:59:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706497174; x=1707101974;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=g2srdy/gEkxZEQX8yqvPWjPa+KiI9RaTtwGAFirYHPc=;
        b=F+KjAGQEO49f0WiLH0uqgcXyGJCwIxAnPSL4J4oC+Bqkp0nX8ZCsz/ZsbbTNs9kJsn
         31I4FN4BG8dMB3v++vh4+b04C1nSI1lXa7l9Nv3qWJ1oBVB41n0Wc/T9pnICP59DgBK1
         eWMvWRXY5d0wc8ElpF2kC9X4uYHZYi8TYH/Z5aTa9g8JLByJrVFnkwxx9gCdPYPtKtBV
         ED1JDcd+VZkfzSiK96d9Me2PnOeqKhRC8RslMWiIssT1WjMcFbN/Ajv1F4ThAFvjr09G
         d3cFlii4LwlHOoC08Idp7ZRTcEavB618uuAc4VlnPQDkhRTeG8Av7UDAdTw8fBUBdiD8
         olxg==
X-Gm-Message-State: AOJu0Yx3Y8BBpBDaUfD5XlAaj9os7tyaszlcRcGClJwuEda55U3aJp7V
	eW6fIdomdAFzl0XfTWLPKlkM/+snnOqOaFVKYNLuxHBC6xdVtJJQ
X-Google-Smtp-Source: AGHT+IHLzWKpOpr3cILvZHyHMjuA82VdDmKya3ofyHQ2fh7NkcXPc/ZbcxRl9w9fzz4kk68FVx7Wdw==
X-Received: by 2002:a17:903:246:b0:1d7:147d:6a1d with SMTP id j6-20020a170903024600b001d7147d6a1dmr2077904plh.55.1706497174501;
        Sun, 28 Jan 2024 18:59:34 -0800 (PST)
Received: from [192.168.51.14] (c-73-231-117-72.hsd1.ca.comcast.net. [73.231.117.72])
        by smtp.gmail.com with ESMTPSA id z2-20020a170902708200b001d89ed2d651sm4239317plk.102.2024.01.28.18.59.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 28 Jan 2024 18:59:34 -0800 (PST)
Message-ID: <df263948-07e0-4aab-a645-ea401d4d413b@acm.org>
Date: Sun, 28 Jan 2024 18:59:31 -0800
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/14] block: refactor disk_update_readahead
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
 <20240128165813.3213508-3-hch@lst.de>
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20240128165813.3213508-3-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 1/28/24 08:58, Christoph Hellwig wrote:
> +static void blk_apply_bdi_limits(struct backing_dev_info *bdi,
> +		struct queue_limits *lim)
> +{
> +	/*
> +	 * For read-ahead of large files to be effective, we need to read ahead
> +	 * at least twice the optimal I/O size.
> +	 */
> +	bdi->ra_pages = max(lim->io_opt * 2 / PAGE_SIZE, VM_READAHEAD_PAGES);
> +	bdi->io_pages = lim->max_sectors >> (PAGE_SHIFT - 9);
> +}

Would this be a good opportunity to change (PAGE_SHIFT - 9) into PAGE_SECTORS_SHIFT?

Thanks,

Bart.
