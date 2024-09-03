Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 470E41A0BCA
	for <virtualization@lists.linux.dev>; Tue,  3 Sep 2024 09:39:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725356389; cv=none; b=As9T0hiKrgc8GoeNzIjsFlh2B0Dmlt75eLab7O6mIdemhle9GwsTEnnM4RdDOJ1cpp8F0IaUOEOpxuNg2T0n7lhj2TfXNF100C71o0leSFXcWnDptMsiqYjHQN3aInChLYJ9rq+GQSgNLQSlrDdfCT/oiJr7VDKjQ0QrkZLcMfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725356389; c=relaxed/simple;
	bh=pE3Mr0PnS9xl+CUiCEH2hxI4fWM92/vwv+iNfIiq4l8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=tq3uFtJ/ksZW6eildbAXpJKN4cfR8dQsaokqHG5aPoYuUktpi/BF/bjyMUwLNjDHqW4MRJWDx6XqQqond8btb/fWGCIoi2+vxi0ETdEybmCllu7yqHzw3kIynKPplCSYGg9R50oYwowzewIq8TUzAZyxYzlqbDSZGNpfzAwYt9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Hh5kBEjO; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Hh5kBEjO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1725356387;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=cIxA/7+yR2jXA4ieeKPuD5EUL5lArHR8csGiCMl6eW4=;
	b=Hh5kBEjOrdKZk3kRJinPc6wdUa5u6DXLTuWECSxYMTKrHHUGqSFrQ2EZzMzn9n3jPjSkDp
	GC6ifzE63Y1thpL3mpxcPpx/fxnMhjD+tQ5mrxZr3Pk0X0fXkFZ29JbgHWf97tb3WJzpaF
	VBc2DqBSZXXc3dJ3AutwG9VxR12KmZ0=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-34-BinJi44qOoiutxCfYQuTdg-1; Tue, 03 Sep 2024 05:39:46 -0400
X-MC-Unique: BinJi44qOoiutxCfYQuTdg-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-42bbe70c1c2so34424115e9.1
        for <virtualization@lists.linux.dev>; Tue, 03 Sep 2024 02:39:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725356385; x=1725961185;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cIxA/7+yR2jXA4ieeKPuD5EUL5lArHR8csGiCMl6eW4=;
        b=kDjPW0scO4P0iZOjiHFDgHUwsKOcF3cSkMXH6buFXWsxAVD2qQuRmYi5PlaUWTs8Va
         MhWiePRVXijTvE+b7fLZlyC5MnvtfAwE//q1Z1TmL0GfxLpWKke41TlHVlQ4dGUM2r4S
         ntTAsW8c8MzOlOBXnPEeNnpmQsMD3z6Fd4oOT28gjm4TZJKfPSIlIndLmLnLIRQKVfu8
         Se2KlX+IVc3gpvL/9dDeziwZjf6Gnr1lF1ICpGZxz7EY/05W51R1xgLhZd9vromIJbwx
         kZYxhcD2THarIDcVouUPTUidjO3Tsvptg5DNnYp/RwanZrBr5zO9QtnFv9EfVETvVaWp
         4zcw==
X-Forwarded-Encrypted: i=1; AJvYcCX/GGme8MgW8sqdHgHdUkSSQ2yAu3ERLFE+xeHv27UX31D9S4eri+d/oHSNNEQS3A4XdRXD9ZPpyw9M1NiE7g==@lists.linux.dev
X-Gm-Message-State: AOJu0YyE1NXOyQuOWj/NcSWWie8iWi9YbYuziph//hRUSXDfCjwIthWi
	vBa/V3O3hG8WOeHUe6hYsg17sG8sUUUO84xkIkUoJDCRIYn5hN4pEjrx0mtcvb6acNIGYMmrWfg
	KJT70UJHrYSwmL4NXW2yQ3ihNlfqXoUwd6y/LP/v/SCuAMDuD8nQIgnMXpQc3BV5g
X-Received: by 2002:a05:600c:1f90:b0:429:dc88:7e65 with SMTP id 5b1f17b1804b1-42bb02ecb7emr124596485e9.12.1725356385065;
        Tue, 03 Sep 2024 02:39:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEx9ZT+cp/JOzMdJ0eMMwlRMn2QkU5Mi38V0c6sZIqJTMhc/MD50iSbcQF046e0ymvaKlJlng==
X-Received: by 2002:a05:600c:1f90:b0:429:dc88:7e65 with SMTP id 5b1f17b1804b1-42bb02ecb7emr124595995e9.12.1725356384137;
        Tue, 03 Sep 2024 02:39:44 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc7:441:95c6:9977:c577:f3d1:99e1])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42bb6df0f41sm164222235e9.19.2024.09.03.02.39.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Sep 2024 02:39:43 -0700 (PDT)
Date: Tue, 3 Sep 2024 05:39:39 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Christoph Hellwig <hch@lst.de>
Cc: iommu@lists.linux.dev, Marek Szyprowski <m.szyprowski@samsung.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Bingbu Cao <bingbu.cao@intel.com>, Jason Wang <jasowang@redhat.com>,
	linux-kernel@vger.kernel.org, linux-alpha@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-mips@vger.kernel.org,
	linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	linux-s390@vger.kernel.org, sparclinux@vger.kernel.org,
	linux-media@vger.kernel.org, virtualization@lists.linux.dev,
	xen-devel@lists.xenproject.org
Subject: Re: clearly mark DMA_OPS support as an architecture feature v2
Message-ID: <20240903053917-mutt-send-email-mst@kernel.org>
References: <20240828061104.1925127-1-hch@lst.de>
 <20240903072744.GA2082@lst.de>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20240903072744.GA2082@lst.de>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Sep 03, 2024 at 09:27:44AM +0200, Christoph Hellwig wrote:
> I've pulled this into the dma-mapping for-next tree, although I'd
> love to see one of the vdpa maintainers look over patch 1.  I'm
> pretty sure it's correct, but a confirmation would be good.

Missed patch 1, I was wondering why I'm CC'd. Looks good, thanks.

