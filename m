Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7896158D66
	for <virtualization@lists.linux.dev>; Wed, 24 Jul 2024 13:21:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721827277; cv=none; b=LnW6BVc2eoIH5TkmEWns7ULBYVbYAVF2A0EFTueuWnxzfDw8FHKd1xi7wMUHfmABa3N+nn8VPeOfqJysqKYXH4DB7CPnIttREAhfxqorJ6jgK2LtoJQirLNdJt0Ze2CY9iXZc66hn2rD6PelSDPFyB7apdJmSF1DZjhCdaPApJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721827277; c=relaxed/simple;
	bh=/8VMl2EwwDFZmY2uUkJyXZpa99IFV6FSdKvR/AqSx5A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C2Ehd28EG4zSKYeQoJgDXXEbO1qm99xkzTe2D5zoFYNRpJzgAIaMqfB62NO8NGQCtabZAgYGGY6xLBmv0+RMv1Uoq6LAo18mA1R5oT/Y8TRrY8DvukqsAH/Z7XvR+dfRlFSRsOddxZiKExV3oCMnsHThXRoN5D02aCV/MdnaKVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=K2skBCB3; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="K2skBCB3"
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a77e392f59fso102187166b.1
        for <virtualization@lists.linux.dev>; Wed, 24 Jul 2024 06:21:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1721827274; x=1722432074; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=YNUPYZPUPF5IRuryyMfTcw97wY72+AFm6FhJO5pkfgM=;
        b=K2skBCB3ufKV5k/SkHu36GIOG4DISRyY55IodHxo7SFX/N1YCK5mGr437mwuVlyXY3
         GbslvLJwXeM50uFaiVeUkjViOxguiIrr5H6hx3V8yPX7fPwCPyvZ+T1AJe8JfzTROHyC
         Sv0XwjcAMTddcuXTXg/aQbNdVri5rOMgFw4jEl69WjHY8bigA0LoWFpuOlV3lf/bRbfG
         TbQGwjXepwZinJE9KpF2xs8caS/EwxVu20nNEuUAdcugbwi2a79va+SGuNHfOlWe1kYd
         b3PQ3kOpDlAcnj+6G2ZToOZ04YtNeCKGPaBnim5R8CZ/6OkrhSis4byb8pqSoBfz9WF6
         iKBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721827274; x=1722432074;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YNUPYZPUPF5IRuryyMfTcw97wY72+AFm6FhJO5pkfgM=;
        b=COlZB/mMQG08I8TfpfpQMSOHjQIhvSelro3VVV9lYC00vzbhertOSbDsgwj9J2Hi0N
         Ujw1UFSXnDgHIM5iseW0wueDtbYDNyOmponL2EI4jlWBfnUCDE62G9TKD2OfmSHPPhIY
         yufMuPF6OYntcu3cDjA8lgKMTlBkNCYFtKvrkqLEItqub286ysuFN3+PWMCjqDmrS+8K
         gFMiZ88FMbcDM6PRK6Q7Aqy4CAIQqqV9GQcsGvV9LohmCqyDKZbVnWRRSZ4jRDrsTsf9
         9u6vyYxaT2wBPcYq+vPcmCUvEAWailk5U8tjB4Hu1t770gIW3I/q+qXpwQEseaS/t5lH
         78Yw==
X-Forwarded-Encrypted: i=1; AJvYcCXoM2/vDNMKL1V31pxARfmC9L6o2vhpiXCVw9330wALA/sTmyjfevSk1NqmGo3Ylqg4rcST7ddbVbW0hqLfopG53KrqDsPwHJHSkMYOKfk=
X-Gm-Message-State: AOJu0YxuR+eBI7RS4iLVmRdzEVgkixumH22kHqFWzzLKfZ6Ia2GD33kM
	dVIr1Ehp26dtqYSeSO0hMxeVehNp3IxklMoK5LiZYqj5pCVRoTTIj6VyfjhN14PQNU9m1XburyU
	y
X-Google-Smtp-Source: AGHT+IHOa18wtKZsfJu4ca/qsfjBm4+18JCliIzvAL038tAW2+zRsGw87m3n3V661dKG7nwo8bwhbQ==
X-Received: by 2002:a17:907:d18:b0:a72:8c15:c73e with SMTP id a640c23a62f3a-a7a4c2a32famr843447466b.55.1721827274170;
        Wed, 24 Jul 2024 06:21:14 -0700 (PDT)
Received: from localhost (109-81-94-157.rct.o2.cz. [109.81.94.157])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7a92dddccdsm188399366b.79.2024.07.24.06.21.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jul 2024 06:21:13 -0700 (PDT)
Date: Wed, 24 Jul 2024 15:21:13 +0200
From: Michal Hocko <mhocko@suse.com>
To: Christoph Hellwig <hch@infradead.org>
Cc: Vlastimil Babka <vbabka@suse.cz>, Barry Song <21cnbao@gmail.com>,
	akpm@linux-foundation.org, linux-mm@kvack.org, 42.hyeyoo@gmail.com,
	cl@linux.com, iamjoonsoo.kim@lge.com, lstoakes@gmail.com,
	penberg@kernel.org, rientjes@google.com, roman.gushchin@linux.dev,
	urezki@gmail.com, v-songbaohua@oppo.com,
	virtualization@lists.linux.dev, hailong.liu@oppo.com,
	torvalds@linux-foundation.org
Subject: Re: [PATCH RFC 5/5] non-mm: discourage the usage of __GFP_NOFAIL and
 encourage GFP_NOFAIL
Message-ID: <ZqD_ydjhUI_GCgSg@tiehlicka>
References: <20240724085544.299090-1-21cnbao@gmail.com>
 <20240724085544.299090-6-21cnbao@gmail.com>
 <68ee812b-3b96-4c8b-9a54-70d4742488bb@suse.cz>
 <ZqD9-yzGxQIFlxGQ@infradead.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZqD9-yzGxQIFlxGQ@infradead.org>

On Wed 24-07-24 06:13:31, Christoph Hellwig wrote:
> On Wed, Jul 24, 2024 at 11:53:49AM +0200, Vlastimil Babka wrote:
> > GFP_KERNEL_NOFAIL which is GFP_KERNEL | __GFP_NOFAIL
> > 
> > And probably also GFP_NOFS_NOFAIL and GFP_NOIO_NOFAIL (sigh).
> 
> Let's not add these and force people to use the scope API which
> we're trying to move to.  I think we should be able to simply
> have GFP_NOFAIL which includes GFP_KERNEL and no variant.

Scope API is tricky here. Exactly because the scope itself could have
opportunistic GFP_NOWAIT allocations. It just takes a library function
to call from a scope that could become a risk because it doesn't know
about potential scopes it can live in.

-- 
Michal Hocko
SUSE Labs
