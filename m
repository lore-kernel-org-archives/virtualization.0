Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6A3E4084C
	for <virtualization@lists.linux.dev>; Wed, 28 Feb 2024 18:16:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709144170; cv=none; b=QUDd3JQPHlQqJWVeSUVb2vU2soGmvBIsEqgMd9EKYWo83Tc2OKbSeQZSs8MO82ffsdk/d2kOY+Lnt1zzJTNfn8jTUZuy0CslHu5rC2Rx4P3Cs06Fwc67cW7Igc0qVpbc83GHOf3qAAN2VHmlgJZgq7OsXxrv7vQEbl3Cdb6OuPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709144170; c=relaxed/simple;
	bh=1kWaysEbsM70DaSeLNKQutuegUR4y2SpD1yzaZdBcZQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CXK2+k4Otqm9hMoh2JWT5Q6G98KPghPLn42D38o4wluc3gk/hXXz39T8gjwAOOGf+PpZ/0ZQ5O0pCa64LfS/6OKLtaBIF5IUSI0A0G3giItXLo7+qzUVsYBoXpQ622uYacVyLYvLzgNXYEo20H+9gkusyEZjSOHubrQsUCP7Kog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=jtFfAERx; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jtFfAERx"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-412b7bb0bd3so243685e9.1
        for <virtualization@lists.linux.dev>; Wed, 28 Feb 2024 10:16:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1709144166; x=1709748966; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=4RgBQLcrgH3gOWvIgwazhE5Cb5mh+fuN2kUzWGSABzg=;
        b=jtFfAERx0Zlu1qvqosI1g9d476vMWum4siwoiki/+8etlP8EwzzpEAnV+TGOorJtdz
         uJglXTcop3/2woeMjH4buGOcHlR22QhF9f6/2DE/fuTKSwQZ6v17/7fCsGiLmxTcVodi
         vATriH2KP+/sn3uVl51k0GKIk7w/XL/y8ELENDxhhhVRppQirbsNv7sXuj62Y2nTiF8m
         UA/uwFoNoKWSRg70HzJgWnujBh/dKRRKlQbzaBnIY102cAKuP91wLz2EAH8Z9u/T6dK9
         PVN+g7IhQBpVW8cOxAzL70zKtqcZ5GbWtEzopjUYTnccRnQgbFF4HtZZiPTP47pDmAEQ
         IlSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709144166; x=1709748966;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4RgBQLcrgH3gOWvIgwazhE5Cb5mh+fuN2kUzWGSABzg=;
        b=fHNs2ItRs47aDnENtZdJ0ycfNVu6oMV/+G+iPcYG5n+dupDC+8OCyIBjrvr1T+B8ob
         23izdoVNHC3w0sIHi/L4EDzdeYqW1AdYIp0WXP4AD0wbhz/dKqegQ5ZZpp8xG5sowOD+
         PbfEpYPWhK7JR/XEDMscvrGRTEhn4dg1gDCInSLb7khsOjdaE2S0XAxfIkQkcunhPYV+
         aRu/hdAciUzF5AjE39Bo6NxfS5KBp92s3H7jeTuldQnIeVT/LOD2WX8aKfoPIqS3xzAM
         Ti20Z7FEVLGuRY50uG63msGgMEVTur8+3W5ALdYabfLR9GZ6Yz70KZzd0o9KTV8ERkT7
         QV9g==
X-Forwarded-Encrypted: i=1; AJvYcCXjbZkvYXVGqd+OT1HTXqXx3cMYaPkS8/ZRd3nZZe7krKARbOY5qI7pz90UhQVrzB9TJ9fnnSqV0zo1v/SzQRZypAYi6dQrCXIxtIMNRwY=
X-Gm-Message-State: AOJu0YxhHD3Pa6Lqpj+4h+hRgwwsT99hGMYI/pAOilLC7M0bjBlVFe0u
	MYwt4yjHQ9A5MKcfcNv038/AlB8Rc9ml0oHkjv6S6seH2XToTLV+Fmxcy7Mb0po=
X-Google-Smtp-Source: AGHT+IGZsW2+DV+RLS5eEUTSzNTy/jmxqTHtHvCRKzCxwdxk8Ibsv3Vpe1wv06Z7qlQn/p0QV+SOnw==
X-Received: by 2002:a05:600c:450c:b0:412:b3bf:8143 with SMTP id t12-20020a05600c450c00b00412b3bf8143mr272467wmo.12.1709144166247;
        Wed, 28 Feb 2024 10:16:06 -0800 (PST)
Received: from localhost ([102.222.70.76])
        by smtp.gmail.com with ESMTPSA id s15-20020a7bc38f000000b004128f1ace2asm2757215wmj.19.2024.02.28.10.16.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Feb 2024 10:16:05 -0800 (PST)
Date: Wed, 28 Feb 2024 21:16:02 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: Cindy Lu <lulu@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Xie Yongji <xieyongji@bytedance.com>,
	Maxime Coquelin <maxime.coquelin@redhat.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Christian Brauner <brauner@kernel.org>,
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: Re: [PATCH v2] vduse: Fix off by one in vduse_dev_mmap()
Message-ID: <67af4fbe-9dc1-45f7-aef2-ed397da733ef@moroto.mountain>
References: <e2361611-e8e3-4c6a-9f71-30e81a65f793@moroto.mountain>
 <CAJSP0QVYUrkbk6beMB6nW1q9G3jMqeDzGwMagyXh1B1skFdHjQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJSP0QVYUrkbk6beMB6nW1q9G3jMqeDzGwMagyXh1B1skFdHjQ@mail.gmail.com>

On Wed, Feb 28, 2024 at 12:53:28PM -0500, Stefan Hajnoczi wrote:
> On Wed, 28 Feb 2024 at 12:44, Dan Carpenter <dan.carpenter@linaro.org> wrote:
> >
> > The dev->vqs[] array has "dev->vq_num" elements.  It's allocated in
> > vduse_dev_init_vqs().  Thus, this > comparison needs to be >= to avoid
> > reading one element beyond the end of the array.
> >
> > Add an array_index_nospec() as well to prevent speculation issues.
> >
> > Fixes: 316ecd1346b0 ("vduse: Add file operation for mmap")
> > Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
> > ---
> > v2: add array_index_nospec().
> 
> Did you forget to update the patch, I don't see array_index_nospec()?
> 
> >
> >  drivers/vdpa/vdpa_user/vduse_dev.c | 3 ++-
                                          ^^^^^
I updated the patch but the thing about vim is that every time you
press a button it does something unexpected.  Vim ate my homework.

regards,
dan carpenter

