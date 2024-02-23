Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89AA4175AB
	for <virtualization@lists.linux.dev>; Fri, 23 Feb 2024 08:07:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708675670; cv=none; b=plcl+mk/BdUd9sp5UFvWPFsJiIRRG93PBnA0n1qzs1jWcNd0ew6eyPnW9cgu5LmbuL3iXrdewVt+SzDu2oALp06HE+baLFibBCZa4LDe0EW2b/lQfEBk6yqJL/+It50a3ba8X6SK5JQKwsx4hKKgC4+vjdLJ+Pad7huW4W1dqVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708675670; c=relaxed/simple;
	bh=DNHZee+XcgGpqhbeML1UkHBmgn9qbg3ptmfP88KNB6I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=jcZMQfk4BHYhawtBfYMVPCIXgUqRHoPEhQGW4gWhOu+s39pIAJyKukL+R4BaW19+QSe4vQ8Z4v/YIKHxkpbJJ9YVMxnieSNKmpwzxtWk6Fs5g6GKoOXbwO3YFcavc/5ztnrTG9iIT6zy3RNqkgb3vhW7hg2A5kYtoWIjIDn4rfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZBEejzXQ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZBEejzXQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1708675667;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=FYGnVDuOUOzN376Dec8nS0W4C0cCcX6YgBNBZdpZb+A=;
	b=ZBEejzXQ6Wz9pq/sJVPWDKZeZ42tYrdlIce5uU4sUhb04dfw08rmMnUJxGPAV9xUZL1N2e
	NVHcemTCZLNtqI0XN+MUJldSJsdWeDazLh6vKlGOKFGGIwEApXuKLc6qLMvvxWfUiv3ljI
	WJAN0JgY1dW2j+L2aBhRRqqwSdsk1CE=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-194-fLgIUAccMIW3Bcsh1CB7lQ-1; Fri, 23 Feb 2024 03:07:46 -0500
X-MC-Unique: fLgIUAccMIW3Bcsh1CB7lQ-1
Received: by mail-lf1-f70.google.com with SMTP id 2adb3069b0e04-512bdd07758so480556e87.1
        for <virtualization@lists.linux.dev>; Fri, 23 Feb 2024 00:07:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708675664; x=1709280464;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FYGnVDuOUOzN376Dec8nS0W4C0cCcX6YgBNBZdpZb+A=;
        b=p0UKyQBqY+Hos7B7orGh5hkR4fHLKHhA9uDm2jP/MpbFRrpbTy0NP0oyCu17IelBos
         7ytgivk3nvIZuRTZoLjUbEb2tB0IKFl4QACkGu6s/vtR4Yjowod0KjvQ5NmWjlGboB3l
         pqj7GHBJ0xsGEuhRtkUiAnRrV/VjcrDkLlJTeJINdp6nRUsUSKBIkrZ5nBOab2uYwXtv
         oEm+oo0snEBsoSYhioEemFKP+rCtpH9fov+ZxVKZnDTju26R9RdGYIHPfSI/vCz1xk5K
         4emBdKLa0j0osBPtjF8vT75tRFF5gGu4tvQzouzZeSUMTDB5dId7hGzjCZ1APZvT8Dit
         042w==
X-Forwarded-Encrypted: i=1; AJvYcCVrWOzaJHDUadOQWv7adYeE1THqTehyrAQyKphP1nYWa0hZ7oBrwrcj7WEUd0VKA6NJFnFurwTIqRmlC1Pllv1a+GtfUfnyeqCBGyLPG1k=
X-Gm-Message-State: AOJu0YxSfbAd9hOVFE7qO8wR8fjbmGP7LYaNrDTimJHkfMXnVlLjvH/P
	snjouvhrauHLNkh8aD0u0Ao9d7FrlrlpWcRjncD99d2UcZnwRxh18vxh19B+9DfbUkkWlQqS5Ef
	hzTjbFRtqAGUyoprhKzoI46BiAJzkz3mm3/efGT/bI3rKHDUZf5qSrIgUKojci4kQ
X-Received: by 2002:a05:6512:388f:b0:512:b858:2ac2 with SMTP id n15-20020a056512388f00b00512b8582ac2mr745618lft.55.1708675664590;
        Fri, 23 Feb 2024 00:07:44 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFu9CCEwmfSaqKwPGD1L/tzZQvMDbb2NOZKx10PuT4J316mtOybBCCtbpJw8jJNXS8wF+KX/g==
X-Received: by 2002:a05:6512:388f:b0:512:b858:2ac2 with SMTP id n15-20020a056512388f00b00512b8582ac2mr745609lft.55.1708675664242;
        Fri, 23 Feb 2024 00:07:44 -0800 (PST)
Received: from redhat.com ([109.253.221.205])
        by smtp.gmail.com with ESMTPSA id y2-20020a05600c20c200b004126a6ee498sm1361817wmm.12.2024.02.23.00.07.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Feb 2024 00:07:43 -0800 (PST)
Date: Fri, 23 Feb 2024 03:07:39 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Randy Dunlap <rdunlap@infradead.org>
Cc: linux-kernel@vger.kernel.org, Cindy Lu <lulu@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	virtualization@lists.linux.dev, Jonathan Corbet <corbet@lwn.net>
Subject: Re: [PATCH -next] VDUSE: fix another doc underline warning
Message-ID: <20240223030721-mutt-send-email-mst@kernel.org>
References: <20240223062341.26914-1-rdunlap@infradead.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20240223062341.26914-1-rdunlap@infradead.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Feb 22, 2024 at 10:23:41PM -0800, Randy Dunlap wrote:
> Extend the underline for a heading to prevent a documentation
> build warning. Also spell "reconnection" correctly.
> 
> Documentation/userspace-api/vduse.rst:236: WARNING: Title underline too short.
> HOW VDUSE devices reconnectoin works
> ----------------
> 
> Fixes: 2b3fd606c662 ("Documentation: Add reconnect process for VDUSE")
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Cindy Lu <lulu@redhat.com>
> Cc: Michael S. Tsirkin <mst@redhat.com>
> Cc: Jason Wang <jasowang@redhat.com>
> Cc: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> Cc: virtualization@lists.linux.dev
> Cc: Jonathan Corbet <corbet@lwn.net>

Thanks, I fixed this in my tree already.

> ---
>  Documentation/userspace-api/vduse.rst |    4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff -- a/Documentation/userspace-api/vduse.rst b/Documentation/userspace-api/vduse.rst
> --- a/Documentation/userspace-api/vduse.rst
> +++ b/Documentation/userspace-api/vduse.rst
> @@ -232,8 +232,8 @@ able to start the dataplane processing a
>  
>  For more details on the uAPI, please see include/uapi/linux/vduse.h.
>  
> -HOW VDUSE devices reconnectoin works
> -----------------
> +HOW VDUSE devices reconnection works
> +------------------------------------
>  0. Userspace APP checks if the device /dev/vduse/vduse_name exists.
>     If it does not exist, need to create the instance.goto step 1
>     If it does exist, it means this is a reconnect and goto step 3.

