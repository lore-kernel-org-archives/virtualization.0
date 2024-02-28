Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B79C15DBA1
	for <virtualization@lists.linux.dev>; Wed, 28 Feb 2024 17:42:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709142180; cv=none; b=u/+MaHQVT3/qb7UObypzE3xALUcsPMgTE7gycajGDgzadBrjArfcRZf5azaRjmQ3XoSqKugBX+RA5WJWDIexpn8pgEttOTwAjOhRRJKbJVCvJOv28BqQ9mzEW1hhP8Ufgfj+J7lleB1oTrlsGwiHQrYs+okjsGC3/PeaWGslVHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709142180; c=relaxed/simple;
	bh=OnTfdMWKLwh8ThOMjY8rRqP+fXnwlTEZOKp8/UdqfZs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M0KBEnidGgJ5b8+fUmoVx0Oug2ev+EHttucE/YQT/8K+W6oAb+z6x1gjcm8HymQybqFqxv8S+v4QFcX8VJfTyvoLMxDq3pTPfeinyW+kYnKKeUOPYzQuLyBPhTpkBHn8g/iBDdhpVfr8JOLNseOzlWxViZAubXLlGVft2Qi/oNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=P3wyaWDk; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="P3wyaWDk"
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-33d509ab80eso9707f8f.3
        for <virtualization@lists.linux.dev>; Wed, 28 Feb 2024 09:42:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1709142177; x=1709746977; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=5XTL7Wi5fSoGtPT9aaYhGYa7xeX5imrSZZwRbhwuwVM=;
        b=P3wyaWDkG2oiFYV5DJ6S/i/a5HzEx6O1hwnOYc/0sZDK49a0Tnqj58ldcQvP13TSSa
         0KnwQZt1kYHI1y8LZVmIv68lBc+MmKvLaQyxnPZYC1ZaKAcgzVmw3m30Bue1A2U+ZeSu
         NxCEDPErpj9dqE7MXquGPRWsofxYU0gBHFNCdRiNrA2CmFIOpBU6KoeBBPzT3ALKL57K
         A3eteOki8mH60CMsLCP4TLTYxxWmDEk/Tjf7S8Ps3NK1mr9od29wLhlSd+tjhcTE39KD
         Dtvf+BkhqRouuoRHIaZlympzeBnDRfacnwbXpVvINJWj70me30tfrhHOhtYgiBPwoquK
         aqEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709142177; x=1709746977;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5XTL7Wi5fSoGtPT9aaYhGYa7xeX5imrSZZwRbhwuwVM=;
        b=alUMWBgLkGnpf/X0Vbw35iJRnOAFN3p0kn2tn6z3uoK4l08Uu4uWhyLAbsACY1/SQz
         5DikqhUy4wOgE30y+0LdUXfLZmZVDh7OwnTPZ0b0C2gkwv0+qk9GoD/oI6SVdjbDx3Ee
         AoAIQPFHq05ZNcKTq9T0hutJMukzcS5nJW3ec6XDzVcBQPC5Zf7vojv5/myQAGrwVc/5
         WkvYnhiEnhfqOyWs3c6650M89AWbmnB7j0yk2escLdFGZHcjw2Vc7zcTFwAy4DIev4Io
         f5g6buxO4oLfbcFatUB3rnWezTsa2BEwVD6Q2xjZt7U5bQGXjPKcMkXt/l79bVeiog0i
         ksEg==
X-Forwarded-Encrypted: i=1; AJvYcCVvC5en/mL83uDP5tBT64hrJd5I+6MgzbQM0IHc+iDTqLCYQNiv3i23cyJd6InJyPX1vKsFQZMbb5lgtHJ1VKv83Swa3NxnKS3gU85qtoE=
X-Gm-Message-State: AOJu0YwakaUiba4X0WWmEInH7PIcoIkyL5Pzjh89Pbg2wNmyJcweMCGI
	lwaMAHwxmUPjZQRq1gHt/TAbMwcWBoj1xOTdNuqZ2tRoS3mEqmm9n3E1+N0uHyM=
X-Google-Smtp-Source: AGHT+IEPgnl6zrKV1TWi+lu4XTy2PTm0dyVStykU3E0t1mjb2hp9hd9ASfakK+UaUYWfPrmiDRXcrw==
X-Received: by 2002:adf:f049:0:b0:33d:3099:e67b with SMTP id t9-20020adff049000000b0033d3099e67bmr157217wro.63.1709142176705;
        Wed, 28 Feb 2024 09:42:56 -0800 (PST)
Received: from localhost ([102.222.70.76])
        by smtp.gmail.com with ESMTPSA id bw11-20020a0560001f8b00b0033da4b06632sm15535993wrb.6.2024.02.28.09.42.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Feb 2024 09:42:55 -0800 (PST)
Date: Wed, 28 Feb 2024 20:42:52 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Cindy Lu <lulu@redhat.com>, Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Xie Yongji <xieyongji@bytedance.com>,
	Maxime Coquelin <maxime.coquelin@redhat.com>,
	Christian Brauner <brauner@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] vduse: Fix off by one in vduse_dev_mmap()
Message-ID: <81e2238e-3ed8-44dc-82fe-256155c271ba@moroto.mountain>
References: <e26476e0-68ae-412d-a5d9-4996bc30d038@moroto.mountain>
 <20240227104743-mutt-send-email-mst@kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240227104743-mutt-send-email-mst@kernel.org>

On Tue, Feb 27, 2024 at 10:48:49AM -0500, Michael S. Tsirkin wrote:
> On Tue, Feb 27, 2024 at 06:21:46PM +0300, Dan Carpenter wrote:
> > The dev->vqs[] array has "dev->vq_num" elements.  It's allocated in
> > vduse_dev_init_vqs().  Thus, this > comparison needs to be >= to avoid
> > reading one element beyond the end of the array.
> > 
> > Fixes: 316ecd1346b0 ("vduse: Add file operation for mmap")
> > Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
> 
> 
> Oh wow and does this not come from userspace? If yes we
> need the speculation magic macro when using the index, do we not?
> 

Yes, it does come from userspace.

To be honest, I'm not sure about speculation.  The similar places in
this file protect against speculation so, probably?  I'll resend the
patch.

regards,
dan carpenter

