Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E4A12E3FE
	for <virtualization@lists.linux.dev>; Mon, 27 May 2024 07:52:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716796368; cv=none; b=l8hDGuCl4KFo8i0QlAbZy7Ve4rjNGGVaLynR1LMdy+4BKFqRmaQtag//0hO8821Wuz2b429s6K73jkZDQIDvVqsrR/4shK4rAENLAqS3PApkuDYrP0XEz8JZkk3PtDCnkYiR9PxtDQZwi+LAHJSh/Sgsy9tLXJRIb1Js6DVFxMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716796368; c=relaxed/simple;
	bh=TM1t05Bam2TI9Og9Ycmjuz9Th+Jrc0NoOIk5tBLaklI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=GMQPl1BuBaz4Ek4e+oCKQjX/65ZZAtkc46bQQyWNBa6SXO3t2Xn0OpeUzNRGmin8VQidsYF9zlUHZQngeOZ8g+ICsKjfa5tAhyNnguyU3+eavCoqzYvVeoeM9mxndxoO+40cv6P3JHqslpJnbQj8s3zgRd0WJnsZsPSy5/22NmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Hwc1CaGE; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Hwc1CaGE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1716796366;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=thc/L9s+2sOtDwAm/KUlb0xgz4MZpvoKHDvg7DhDHKo=;
	b=Hwc1CaGENNNvSy+mO4EnYKMRcGMeJjK7heC17+DGuRKNHt243O1Dl3SoJxHkh+R0HeGpQ3
	WM7QDUurAvHGOMiAKYnCB9CAwWFj5DQ4O2w0KGI7HrRtXaGVjavmIIFQlYN5K+GPjfpEiW
	850kjVu8+QVbk7kqZnJSrenv1vmM+Jk=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-488-aS3kLeYlP22V3BI-l1BhHA-1; Mon, 27 May 2024 03:52:39 -0400
X-MC-Unique: aS3kLeYlP22V3BI-l1BhHA-1
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-35858762c31so241704f8f.0
        for <virtualization@lists.linux.dev>; Mon, 27 May 2024 00:52:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716796358; x=1717401158;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=thc/L9s+2sOtDwAm/KUlb0xgz4MZpvoKHDvg7DhDHKo=;
        b=LEjRc+qtoaCeIpRyUIjgx3BCPGFm19MFHbnso4yz+yeHzQ48O/66A8V+kqqM61G8CV
         sQf3LT9nfi9m04fcoIcz3aaPCupYj1jnMscCXAp/gzi3GwXx9nsQzl2Yx7+rE+myo3AP
         IVLf3ONNAh0FJ+/0J61sD2P4Q5aLy3/CWKEsAem2uo13ClIrymyxAmp/rpe0PsNvJzjY
         2bNTZ7rLF+q5uVXCGhTkmaiC0ntxFTRdlqjR6sDlWsf5q4iJ3UcYxkia6aPhyDZrxAMq
         alsu51EiiRWiBF9bfHPgoTqN7gR2uJBECI2R4GxJcmk+jQ4gvCFnMKNkRiH1/qfIs61l
         me6w==
X-Forwarded-Encrypted: i=1; AJvYcCUV661O2AIfPSrYQnzR69divu6pRF9F4GQa5OyNDgwgZwLGO05IRfPcdgON0sx/dAUoSHKYu61vBuF/7fSUyce06xsJamcQ1p1et7QspdA=
X-Gm-Message-State: AOJu0YzQ8J6/K+Hbybj3Fx1xkWQrektElMvrrfFLzvO3YAKiUhq2RBYB
	vIgIZzjuCrYcYf4wJw1Sg+h1wCP/+zilIAr6QrPVEIDZ1km+/dA8Idp2l7oRqbi5z3n6YlHSolc
	3HAL3OxJDevyR7gidDiyqaDel3YYR5m+4z2sE2x1aL6U+BcUSvQMk8t0T4HvoW8X5
X-Received: by 2002:adf:ee8a:0:b0:354:f622:fc5d with SMTP id ffacd0b85a97d-354f75219a7mr9417776f8f.20.1716796358265;
        Mon, 27 May 2024 00:52:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEUJgA9y8QUFq6+A/jElmXWEBdvPCJT9Gb6c+IL3oX/gqOcRBCgLttm/wO7nHhToDnUdxOC0w==
X-Received: by 2002:adf:ee8a:0:b0:354:f622:fc5d with SMTP id ffacd0b85a97d-354f75219a7mr9417746f8f.20.1716796357625;
        Mon, 27 May 2024 00:52:37 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc7:342:cd82:9c62:7faf:9d73:ba3f])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-35579d7d963sm8271015f8f.21.2024.05.27.00.52.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 May 2024 00:52:37 -0700 (PDT)
Date: Mon, 27 May 2024 03:52:33 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: yskelg@gmail.com
Cc: Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	skhan@linuxfoundation.org, Austin Kim <austindh.kim@gmail.com>,
	shjy180909@gmail.com, virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-kernel-mentees@lists.linuxfoundation.org
Subject: Re: [PATCH] tools/virtio: pipe assertion in vring_test.c
Message-ID: <20240527035009-mutt-send-email-mst@kernel.org>
References: <20240527071330.105268-1-yskelg@gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20240527071330.105268-1-yskelg@gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, May 27, 2024 at 04:13:31PM +0900, yskelg@gmail.com wrote:
> From: Yunseong Kim <yskelg@gmail.com>
> 
> The virtio_device need to fail checking when create the geust/host pipe.

typo

> 
> Signed-off-by: Yunseong Kim <yskelg@gmail.com>


I guess ... 

> ---
>  tools/virtio/vringh_test.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/virtio/vringh_test.c b/tools/virtio/vringh_test.c
> index 98ff808d6f0c..b1af8807c02a 100644
> --- a/tools/virtio/vringh_test.c
> +++ b/tools/virtio/vringh_test.c
> @@ -161,8 +161,8 @@ static int parallel_test(u64 features,
>  	host_map = mmap(NULL, mapsize, PROT_READ|PROT_WRITE, MAP_SHARED, fd, 0);
>  	guest_map = mmap(NULL, mapsize, PROT_READ|PROT_WRITE, MAP_SHARED, fd, 0);
>  
> -	pipe(to_guest);
> -	pipe(to_host);
> +	assert(pipe(to_guest) == 0);
> +	assert(pipe(to_host) == 0);


I don't like == 0, prefer ! .
Also, calling pipe outside assert is preferable, since in theory
assert can be compiled out.
Not an issue here but people tend to copy/paste text.

>  	CPU_ZERO(&cpu_set);
>  	find_cpus(&first_cpu, &last_cpu);
> -- 
> 2.34.1

