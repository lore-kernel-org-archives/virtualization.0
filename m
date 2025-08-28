Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2463B2E1753;
	Thu, 28 Aug 2025 08:18:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756369116; cv=none; b=WZLWtylQbNa+gA/yHPxCQpq7jhAVx55srqJL3ZKetN8tbrb1JjcdFFB8R/ibsma/0Ciu4IvWCgXiVFfxvCk7ZKTeAcxBCypLpxR0xSvt9jXfnb2j/8JLVPOtRQP6BbELWREp3CW0dXJKmHTIbU1lqU3Mydx5y62qrS+3DIdw8v8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756369116; c=relaxed/simple;
	bh=+dYxoMUqGPEc9iqIX9bUKHerO98X4htKPSSAx2YoAuY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h20WEMLR6x+jL9BGlg6k4v9lr0sOS0Tih8s3RJExcxqpusJ3g2sgZF76JsfR0fVf+hjNqc4+YGAJ/bUvjzczv2YXDBcaY48kMk6q0bHQwuoahNSh0kj2ed+ZHyQFffRTHqQK8GgdL643WTjA9dQuVmRAPcYTPpxsk9ojpB3XIlE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jQZWIv3/; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jQZWIv3/"
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-61a8c134609so867012a12.3;
        Thu, 28 Aug 2025 01:18:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756369112; x=1756973912; darn=lists.linux.dev;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CFlTc2o50xP7q9jUUn86Cat3HkUhlqoaXfvof6seHm8=;
        b=jQZWIv3/SkP8VrNxL8UuB63bFQIWRTIXwokKwnctC5Asdo5CzQ0eTHSNdbosJWwOlY
         8a3QBh/1wx1npM5OEq3DaAtHKuy+fzp4vidS/2Swi4IjeJatmDgiXyvpjgpj0zqeM9Va
         g3of4mEUJ3VKR8ChLQ9ctB4uqQmGvIftNGQ80DZ4kL6gc9vrKncCZME6gIpw3Hitm3vi
         hNFPv+IrPuUDZd+jW/dL9rVWayYpe77Pi6r4CQrmswqOi6RGbZfJOxTyUmP6Pl4016Yy
         C+xn0b7LUCrw2GRNFPo/doxJVUh6lTnAzAWB5pZjy/Ge2koasmhXL98WeRTDyT2ZFhTD
         t9Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756369112; x=1756973912;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=CFlTc2o50xP7q9jUUn86Cat3HkUhlqoaXfvof6seHm8=;
        b=HAzEbYuWj0gKIIMJn6YWqRGdrRxW9fdujEpdU0i/iZFopOLw6c72K/uswPOe9zoku3
         GdX47iOsl0mvCfVlLCH0GYx5dHEE7fxCr+uk9NGscAhGCzt0OtQvKSwNdbXfSDodvBhG
         cmm1VwTRnDbZO2bZ3j+y0/JESYxm1dC4eOo5l2zeV3N3+4NVyIJdi0f743Fttn6oqRJZ
         AOf+AOaKkAEfwCdVZtWpX+TJ9k8j95SY3bKOjJl4bNTlruTNV1lKNf0Bhkg1hr6/nVet
         /xsPynX+HMMT3ilqfxcPiNDTl+H+3VlMfKtNY/FFrDrXh66xdu4Dzu6RNF3E9uXglJv6
         K7RQ==
X-Forwarded-Encrypted: i=1; AJvYcCV5zbPGtYTPfdzMmZ5lcjZ7lW3P6YAESQLNNR+SUbdaYYbpygV+m9vN8rtyLvxjmkXt43+bhXpP0eTQ6EuJ7L4=@lists.linux.dev, AJvYcCXlQqo/P5C9HdtYmrmPqVg20U11YZOPQVb6VSe0a/d21QBEouZZj+WxuoJpSrTDQwEWRAJ2tQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Yy8mGpYuU9zl2W7IVvNPXZXCtr9Aj6YbIDWqmUwx0b8H8G5GABY
	FmkcVxIjh6iGdoXuoKmifvR3NG4dPfazxgUwu6hlTl3Ec8MqHPksV67x
X-Gm-Gg: ASbGncvFmcbh9mZW3IF2LOB1YMFgaQ0LZDNdTRlqnCYQvZOiDQvjTYDijn3z3qXK0xi
	HY2JKIdDjUh8ij3nb86Ugg7OhBBRqzQr1SgwIqTCo4qpSWnVZnoAEIf23lUSSvF4qmGms3sSJfL
	BRKDUHOKliSDpN72suAwqMP2Xmua6ItLdurmU+DUn744WmLcVtEj+kGjc4ZNUikgl8fZyFgc/7J
	d75oigbYm9EY9wMGlmXB1bldJaH+N9JnxqvojgZuuGvodk9VK5Qkr6XPvcva9bYeTTvYM2a64fR
	FWRYH9Sodn49A97KkPn3tkLg0yOgMlLn0o79OilEWOLMZmsFVKCPfM7UQLg1YgkGDfiMut/Vmf8
	HMYP+bHRczqOwljBpGtCJxClsLE3psZyOVZsj
X-Google-Smtp-Source: AGHT+IFrqyfe7g2Zl+sLgEHASy1+ip6WVy4aEpiIRxktJ8PetprRYIIgoW+xQR/WhySTtvxcEvhJTw==
X-Received: by 2002:a17:907:1c27:b0:afe:b878:a164 with SMTP id a640c23a62f3a-afeb878abecmr620398166b.50.1756369112172;
        Thu, 28 Aug 2025 01:18:32 -0700 (PDT)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-afe80daceb5sm811531866b.68.2025.08.28.01.18.31
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 28 Aug 2025 01:18:31 -0700 (PDT)
Date: Thu, 28 Aug 2025 08:18:31 +0000
From: Wei Yang <richard.weiyang@gmail.com>
To: David Hildenbrand <david@redhat.com>
Cc: Wei Yang <richard.weiyang@gmail.com>, linux-kernel@vger.kernel.org,
	Zi Yan <ziy@nvidia.com>, Alexander Potapenko <glider@google.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Brendan Jackman <jackmanb@google.com>,
	Christoph Lameter <cl@gentwo.org>, Dennis Zhou <dennis@kernel.org>,
	Dmitry Vyukov <dvyukov@google.com>, dri-devel@lists.freedesktop.org,
	intel-gfx@lists.freedesktop.org, iommu@lists.linux.dev,
	io-uring@vger.kernel.org, Jason Gunthorpe <jgg@nvidia.com>,
	Jens Axboe <axboe@kernel.dk>, Johannes Weiner <hannes@cmpxchg.org>,
	John Hubbard <jhubbard@nvidia.com>, kasan-dev@googlegroups.com,
	kvm@vger.kernel.org, "Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	linux-arm-kernel@axis.com, linux-arm-kernel@lists.infradead.org,
	linux-crypto@vger.kernel.org, linux-ide@vger.kernel.org,
	linux-kselftest@vger.kernel.org, linux-mips@vger.kernel.org,
	linux-mmc@vger.kernel.org, linux-mm@kvack.org,
	linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org,
	linux-scsi@vger.kernel.org,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Marco Elver <elver@google.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Michal Hocko <mhocko@suse.com>, Mike Rapoport <rppt@kernel.org>,
	Muchun Song <muchun.song@linux.dev>, netdev@vger.kernel.org,
	Oscar Salvador <osalvador@suse.de>, Peter Xu <peterx@redhat.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Suren Baghdasaryan <surenb@google.com>, Tejun Heo <tj@kernel.org>,
	virtualization@lists.linux.dev, Vlastimil Babka <vbabka@suse.cz>,
	wireguard@lists.zx2c4.com, x86@kernel.org
Subject: Re: [PATCH v1 12/36] mm: simplify folio_page() and folio_page_idx()
Message-ID: <20250828081831.fv4bs77kihwbffdi@master>
Reply-To: Wei Yang <richard.weiyang@gmail.com>
References: <20250827220141.262669-1-david@redhat.com>
 <20250827220141.262669-13-david@redhat.com>
 <20250828074356.3xiuqugokg36yuxw@master>
 <0e1c0fe1-4dd1-46dc-8ce8-a6bf6e4c3e80@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0e1c0fe1-4dd1-46dc-8ce8-a6bf6e4c3e80@redhat.com>
User-Agent: NeoMutt/20170113 (1.7.2)

On Thu, Aug 28, 2025 at 09:46:25AM +0200, David Hildenbrand wrote:
>> 
>> Curious about why it is in page-flags.h. It seems not related to page-flags.
>
>Likely because we have the page_folio() in there as well.
>

Hmm... sorry for this silly question.

>-- 
>Cheers
>
>David / dhildenb

-- 
Wei Yang
Help you, Help me
