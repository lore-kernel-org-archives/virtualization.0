Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF2D1217F32
	for <virtualization@lists.linux.dev>; Mon,  7 Apr 2025 08:49:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744015763; cv=none; b=O5PvMzWbn3wtChHiFUYa/t5zk2E2UUr899Xb6Wit8q/qsAxNyaZCXlUv8hSR+oxbsoaNSm6yzAnr8Qsm3Go8qnzZTYf/fE4MKVhEpYuQUZTgslMMsF7J2sdwMTnyVLMNaEDf30agFgtZFB00ypRUhZ5EkH55AmSQAj5TafIwqB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744015763; c=relaxed/simple;
	bh=IZtLDURYDTq0b32MVRHTcY8RDwEllmanE9uQZcvW3gk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=B/seJtsGspkx4O73cWDCWpxg1sRta0NGhrzEgD968gxhjytVo0ewFoUoVkK2Se9nPuB06jU1WR2QZirO847AoS4geh6tO/GIe6X7sbjNchZLvvH07ER0Ti1QRmo8OUz4Qb4MMpOF4koamKCfhHgRzlPbHjb2a7obJzO9+da0OiU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EPh2MDY2; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EPh2MDY2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744015760;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Hpu5KqbXEO7FQHIb0ETZFO78MX8aCe7lEYNvf8XqmxY=;
	b=EPh2MDY295e/BmrhhJRCOQ0326XjOmpeysTfkGxk/ZLFfM9a1XYWS2j6P45SFr7wz/DHsQ
	Wxuo7XbOf66qAxyN6Ld6iq1tSpGFw/rv1KgZaeYDNh7otX4hPvq/my1UynsfkNYu5YCDEG
	AN33p+zTJuK1iU18rTdybczgFpTTRAg=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-590-uIOCtg-GPvKdEDYco0yILQ-1; Mon, 07 Apr 2025 04:49:19 -0400
X-MC-Unique: uIOCtg-GPvKdEDYco0yILQ-1
X-Mimecast-MFC-AGG-ID: uIOCtg-GPvKdEDYco0yILQ_1744015758
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-43efa869b19so5389725e9.2
        for <virtualization@lists.linux.dev>; Mon, 07 Apr 2025 01:49:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744015758; x=1744620558;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Hpu5KqbXEO7FQHIb0ETZFO78MX8aCe7lEYNvf8XqmxY=;
        b=gxcpAHJ9GAAiTORpat8qY/F9eBfGKiSlz1A018zmaOSNDaB2f5UiZibB/yv6V5sWXS
         duniXLHSlNrhbVX0eU5N/68ydcjwYiEC7ncibVi9yWnuqxmTPjSkb7WD7X4VItTwD6+H
         BkAOvi9RSVp2XaXsqGMJdUKDNq0RVwRkC8OC38EyTYIm7roYc0VTQYxANbHQGrH/e4WM
         a9yTRPSFjh/XPpsGjolvBApTA01KJrunTyflr4c4oEsFivp21cp7H4riOPIB2w+xrIvv
         FaZYrfdiwDdnx/kpQNVo1Pu7pjDd7+d4GxwFLe6VdTXZexS0N9KQo0Ke+AkCR/MWSPZj
         +gEw==
X-Forwarded-Encrypted: i=1; AJvYcCWTD8wjxjNM/yjqI9yihUzV9pcrBwz3YfCWTSqKQojj7O8hNIi5FMFf5Y0tdyxlmXACNIUe/gXykfIik9LFZQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Yw4u70j8rBnWrnF6F6gKO3f9D2G7hZ+Th58CQ0MeCzLrMc/kXQm
	+4CnTEIKB11LC8dMS9hjTWRSmtn+U6ROwXILU1cRM1se+01hysRtBXK4nw1SQABJeknJ90leSTp
	Jjt1vIVggwEyrUTAm3cd1lhqpaUY33ZvPnp0B4AUA4IZm4m5Je+d7n4MUr2ltARow
X-Gm-Gg: ASbGncvZvAgVQ0fbJXGlHXaDtyQ5Kka1Q82nPPFlnNlMuOqfY8oXn+ZzqV53o7/yj6D
	gjWkTCdEnjyZzeN4IUPQXoWcQ7OdMZtuNn9jZW8XJ7adH1tftSHKe6pgZ2cnRV9r20DI7P1blbP
	BXk7PR/n2YQXIQLYriPF/KwqxnAlD6olWBuM2ugTaqSXuXCj7Qo8WChU0fAt399EWLE6zaD7dU0
	xmPA52UBhl1R2ThNgKdwpGz2lSnXj5DWyHmQ0avUGTjHsILH5P7ZtVSvDal4a4B9kZgjcSTxrSO
	CGKku0z0aQ==
X-Received: by 2002:a05:600c:3306:b0:43d:fa59:be38 with SMTP id 5b1f17b1804b1-43ee2aff1a0mr38130085e9.32.1744015758297;
        Mon, 07 Apr 2025 01:49:18 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHNYPVVGEAhzNqS2UPVe5mcCou0C3HnRif0zA9AGHI8Xqo5GZ7Z22p9jJeCaR5blASlwYtuCg==
X-Received: by 2002:a05:600c:3306:b0:43d:fa59:be38 with SMTP id 5b1f17b1804b1-43ee2aff1a0mr38129915e9.32.1744015757955;
        Mon, 07 Apr 2025 01:49:17 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1517:1000:ea83:8e5f:3302:3575])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-39c301a7586sm11552495f8f.38.2025.04.07.01.49.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Apr 2025 01:49:17 -0700 (PDT)
Date: Mon, 7 Apr 2025 04:49:14 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: David Hildenbrand <david@redhat.com>
Cc: Halil Pasic <pasic@linux.ibm.com>, linux-kernel@vger.kernel.org,
	linux-s390@vger.kernel.org, virtualization@lists.linux.dev,
	kvm@vger.kernel.org, Chandra Merla <cmerla@redhat.com>,
	Stable@vger.kernel.org, Cornelia Huck <cohuck@redhat.com>,
	Thomas Huth <thuth@redhat.com>, Eric Farman <farman@linux.ibm.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	Wei Wang <wei.w.wang@intel.com>
Subject: Re: [PATCH v1] s390/virtio_ccw: don't allocate/assign airqs for
 non-existing queues
Message-ID: <20250407044743-mutt-send-email-mst@kernel.org>
References: <d54fbf56-b462-4eea-a86e-3a0defb6298b@redhat.com>
 <20250404153620.04d2df05.pasic@linux.ibm.com>
 <d6f5f854-1294-4afa-b02a-657713435435@redhat.com>
 <20250404160025.3ab56f60.pasic@linux.ibm.com>
 <6f548b8b-8c6e-4221-a5d5-8e7a9013f9c3@redhat.com>
 <20250404173910.6581706a.pasic@linux.ibm.com>
 <20250407034901-mutt-send-email-mst@kernel.org>
 <2b187710-329d-4d36-b2e7-158709ea60d6@redhat.com>
 <20250407042058-mutt-send-email-mst@kernel.org>
 <0c221abf-de20-4ce3-917d-0375c1ec9140@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <0c221abf-de20-4ce3-917d-0375c1ec9140@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: MTefSChp0P9kwKtLxAs3kGv6dxStyXdeYXxOEbC03MY_1744015758
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Apr 07, 2025 at 10:44:21AM +0200, David Hildenbrand wrote:
> > 
> > 
> > 
> > > Whoever adds new feat_X *must be aware* about all previous features,
> > > otherwise we'd be reusing feature bits and everything falls to pieces.
> > 
> > 
> > The knowledge is supposed be limited to which feature bit to use.
> 
> I think we also have to know which virtqueue bits can be used, right?
> 

what are virtqueue bits? vq number?


-- 
MST

