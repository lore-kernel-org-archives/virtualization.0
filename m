Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D35D136347
	for <virtualization@lists.linux.dev>; Tue, 17 Dec 2024 04:22:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734409373; cv=none; b=RLM5WIsXAElTvtKrtPqSyBeioHfxQCsr+oQJRFUkd95JurpCX6c1+S01cocf79yvyRIEtoeZhWO+ViSNPkKeXRA8D63vyZi4zXQxs5JhmCCx+kOP5aYfUTBjDxxnADAoMaAQ1BJ+7UkQtOOuzvbq0Rn+lIRWSq20LR90ylFzGaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734409373; c=relaxed/simple;
	bh=zqpqLDi9o2HN9pkhqRL/t6PUB037p1nJeo7h79OIEuU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b0vxlNreZ3BONvneXGB2dq9s49fPeLabX/B1BIf9zsxNKhyLZ2y5Bbq6GNbpDKJ+R9G9uAfq3jCFY4Wg7+JZNeqm14kYae/4HzsMDCWKopo0IVupjWyoYxAykRA38Fy+mu1jVW7KnGJq9NFeEWfu01OHmKvsec+mscoNx4hgEYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=HhAq/YGa; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HhAq/YGa"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2166651f752so51120965ad.3
        for <virtualization@lists.linux.dev>; Mon, 16 Dec 2024 20:22:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1734409371; x=1735014171; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=07JoRp2HdL+fGtPDXl2NqAHgCCvT4umPfbJtAb58RtM=;
        b=HhAq/YGa3h9Sc1pX/ntmq7zkIE36LnO+O5JVOneFXiX2crWpcXO6At/BVWN5e1wD3H
         IzVaSbQAvmBLcvQBxnrRPMMfFPauCz8MK4dDJGL3k7nflq1/7z+R8vRWDd0oea9RKlrl
         R1rd4Ve/wSYt7KVY0VYhABdUPktnI2BLbT/CaYWLj/5lrF7JmdVd1Rthdj7I3GisG91e
         1uYM1qlHY2AFncpt69M85E6Z72b4FzheAdUR81A7qSydagfW/tTUU/masURs1b51MkWb
         0h8eEALbaqJoGHUTRBXLHy+8I8Vu10fOagPuEF6nKZ+tEMHxDff0Bjj3Neo+xwTcgQkg
         vUWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734409371; x=1735014171;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=07JoRp2HdL+fGtPDXl2NqAHgCCvT4umPfbJtAb58RtM=;
        b=GG6hsz3pKZCEn7wOd14eKVia4j6k3hfdaUDzE222Twhaean1KwMN0E6RPbONUw4kjv
         N3xfcMVGmiLrkhfjgpkEGfulb7ut+jcRRvUL9N4As+UzpU9vdT6NZW8cv51jCmulTR1G
         3E14yiOuyIi6vGTaWVKFqgTT7djHBEa42Bu+E+srm2jS6aOyXrgHTor3kkvRaDp6hbb/
         ZSy61Cc9E11MvIa5p0n3Q6rxiGf5rNqNGC4mPkUzt027/Oyb1XOkDfhfcVutOEWWLWm2
         ag28vtkVPNBk2vLD0R4N4y7uBjNw+qi7ZqFHHcjFJXlgAr8afzI6mRVtGEnlBneZOd1x
         aebg==
X-Forwarded-Encrypted: i=1; AJvYcCXTtif3lN17U5K4S6iYGhYe2t9ZZDv8ehCVA8uySBO6MN8UefpL+kSnAOq6Xi97dT+HPv3eUw7qRwaR6PlAJg==@lists.linux.dev
X-Gm-Message-State: AOJu0YyWmKJa0+RV9NcI1rtY9rkK4/zo+Gy8SjY9FmtuZISso6689/eb
	CBmP5IvSRV2tDLNKCitSDNvr3W889vmzkFC0J7q7KvPKW2F9ogVxUWG6YHaASXo=
X-Gm-Gg: ASbGncsbDyFlFwhj0MHSpPHqh6h+yH1MhksC/BLvVMxUNoiO/uuXVyT1heGQmpFMmEk
	15CR9m2VBDaE9KbE550mVrln6BHxH9jtEXBNVaTveGTXbAgZB3ca7Q74EE3SPVfHEsrQy3OeCjP
	D3oGnM8ruMOjqKrMH1iO0X0Ijss89xAI43BFPRPBSKzreqh5gWNvtduxuCpMiRWOqL3455BGtAc
	7SywE7YrnVGfN8xfVvdfhaGN30kOXcEjyXzh1jFyGf+gkt7va0vDyZtswk=
X-Google-Smtp-Source: AGHT+IEKbIgA6J6tdVvc/CKVL0o8Qbd3JlzKf10BNjP+GnyYPGnHpKt+dWfA7AT7ES0/R2gK7S0k+g==
X-Received: by 2002:a17:902:d484:b0:215:431f:268f with SMTP id d9443c01a7336-21892999536mr230452625ad.10.1734409370906;
        Mon, 16 Dec 2024 20:22:50 -0800 (PST)
Received: from localhost ([122.172.83.132])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-218a1e7227asm50376595ad.272.2024.12.16.20.22.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Dec 2024 20:22:50 -0800 (PST)
Date: Tue, 17 Dec 2024 09:52:48 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Ma Ke <make_ruc2021@163.com>
Cc: mst@redhat.com, jasowang@redhat.com, xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com, arnd@arndb.de, virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] virtio: fix reference leak in register_virtio_device()
Message-ID: <20241217042248.omldhsl4royrfo4o@vireshk-i7>
References: <20241217035432.2892059-1-make_ruc2021@163.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241217035432.2892059-1-make_ruc2021@163.com>

On 17-12-24, 11:54, Ma Ke wrote:
> When device_add(&dev->dev) failed, calling put_device() to explicitly
> release dev->dev. Otherwise, it could cause double free problem.
> 
> Found by code review.
> 
> Cc: stable@vger.kernel.org
> Fixes: 694a1116b405 ("virtio: Bind virtio device to device-tree node")

The fixes tag looks incorrect as the problem must be present before this commit
too.

> Signed-off-by: Ma Ke <make_ruc2021@163.com>
> ---
>  drivers/virtio/virtio.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/virtio/virtio.c b/drivers/virtio/virtio.c
> index b9095751e43b..ac721b5597e8 100644
> --- a/drivers/virtio/virtio.c
> +++ b/drivers/virtio/virtio.c
> @@ -503,6 +503,7 @@ int register_virtio_device(struct virtio_device *dev)
>  
>  out_of_node_put:
>  	of_node_put(dev->dev.of_node);
> +	put_device(&dev->dev);
>  out_ida_remove:
>  	ida_free(&virtio_index_ida, dev->index);
>  out:
> -- 
> 2.25.1

-- 
viresh
