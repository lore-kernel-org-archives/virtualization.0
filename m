Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB5362EF67A
	for <virtualization@lists.linux.dev>; Thu, 25 Sep 2025 10:35:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758796552; cv=none; b=nP/0mo/pQnt7xBJOH1RFrX2qUT/Uog4BameVsUCMxf8D3Vpck0yPTYfI+0Km5IRyVu763Klf2gqp5zpnXiCcs0OIMwLSG50uFntjb3c9YDspdulU9NMow60PInts0bQ9IjHqeXnj8ib28JB2+Plms5FhgZziFvQ7YsBTSq3gwNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758796552; c=relaxed/simple;
	bh=xUNLHeoXDRqlz24TV5AEjntAUr9nhMODMN2h5qvvvjA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=Zq9LX5afeUnzL4RSF10Amn6hKVIjYJhZdYvG0attdx++tjRHZmQTEfgg1JNRvqmPXqfITDihHhcBC7yYNuPaSFWSTc472iB2xcN1/qrn2C3LATnQujOqOBMYH/jDqZpMG03Y4TOfEUJV6AZ4ioIIxaTckcXHL20+KZOLZumfwVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Pd6HZnQ2; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Pd6HZnQ2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758796549;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=g3EH6WUwwcgnGQdg2Ar9vB2aGlwaK5xQW7oTXv4mu5E=;
	b=Pd6HZnQ2L6NJPql/qJ1XMZh5120ybOCC66s6O1OiRCz87D6tdb6/ymOhikqv+K4KCHNc6q
	WhFpsN+3wty5eGv7Qi8mPQxKRNV4NGfhkVObRb3MGslQ1I3ApzyLCgKFEBf95vEUwxLJGc
	nKl25xofCFWkpVfj2iVH8TNnI1LQnqc=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-470-DmNFpLHpN4Cb4P79RAp3lg-1; Thu, 25 Sep 2025 06:35:48 -0400
X-MC-Unique: DmNFpLHpN4Cb4P79RAp3lg-1
X-Mimecast-MFC-AGG-ID: DmNFpLHpN4Cb4P79RAp3lg_1758796548
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-3ecdb10a612so710970f8f.2
        for <virtualization@lists.linux.dev>; Thu, 25 Sep 2025 03:35:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758796547; x=1759401347;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g3EH6WUwwcgnGQdg2Ar9vB2aGlwaK5xQW7oTXv4mu5E=;
        b=kIJnS5Qqwf3gxVTTKk6kGq8qTpGqN2B2iYfhlNtWnoZnvUYxx+jfA3mW1u2QI/Rrql
         kP10Xr0Sh0kdu52W/sGdnRZs3nKCgBn+hCWyULVzcuAUroPf3bG/rqRlOuCr+cjOuhc3
         d4IUkgeNroHH4a4twixKVv9+V/nnUuLz6DqZhO2m+XfFByD1wOe+rsaeaglK7/p3L0dt
         m6ekdgDeG3YeDBAwQ+E/zaTsGlfkIOMWG1XqPob9+86bNH/2aZP+viUJniQqq+PZ0Wv0
         ZZWjejtzIBK2Mj7nggzkDzKk9QjcTmVsU3Xa3/CYUSejUe7JB78mTk64K/xCnWo1tgNA
         8nDg==
X-Forwarded-Encrypted: i=1; AJvYcCUM0n4n5Vp40+4gRahuqNzTN3rhFytbG0ot7BoUoKT+a5DuSbdPHhbA/R2N/79XN9Aq9LcwOCiJwBQvxKyFCA==@lists.linux.dev
X-Gm-Message-State: AOJu0YzkpQWnqaZz5ask+C39W8eSIrVQCOu4fuq7K7h1wxPk6LITq6nW
	47UqZsWkwPb5w0/1RE2gqmb+jTWyWHtT78kdy6cvAe+i1hcESLEHcvGUUa4PeodmlGXiAUrjrfx
	fAs6p29GKVBcoJEQ0T/8R+D2cPHHcr6cyirEZ4giZmY4nKloiDqIfcN+zcoDFjRj2Kc3I
X-Gm-Gg: ASbGncvmWLLwtNVVNuJZtgcscciv5K2RYw1LjfJbBAcESUuVdi52Fi5gaP0NNdSiaPk
	TP/eBZ3b1GDd3dnFWeoV+yNgXSf8WewbTwoJVipN7jNJQnRNtoZ14RpB7HjvPkfOBZoFpyxuHxX
	4ndlyo4cI1hfxo5kMqS3CQK0PehouudBBN4OHg+k3+2gDfVB/fuBT8Ha7JypPsvtjp/dOqzVhJD
	UFJvGIgmYlWiqWQDEr2wcc8xpE2iJiPDfbeq3ljJ6JH5t1cnm77+0u3mQbJVTkNiXuYHdy1Uvaw
	wVUdoPRUhdT3O1czgfn0kh3UjscikXo/jw==
X-Received: by 2002:a05:6000:2203:b0:3ee:1125:fb61 with SMTP id ffacd0b85a97d-40e46514e09mr2505820f8f.7.1758796547116;
        Thu, 25 Sep 2025 03:35:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGkWcoaeMZPfqEXToR9d4KGUCRtGAeqcReS6VWVUDQh5w1llQDfRRLhSrQOqVg0wGLgDM00VQ==
X-Received: by 2002:a05:6000:2203:b0:3ee:1125:fb61 with SMTP id ffacd0b85a97d-40e46514e09mr2505786f8f.7.1758796546654;
        Thu, 25 Sep 2025 03:35:46 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1538:2200:56d4:5975:4ce3:246f])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-40fac4a5e41sm2803768f8f.0.2025.09.25.03.35.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Sep 2025 03:35:46 -0700 (PDT)
Date: Thu, 25 Sep 2025 06:35:42 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Parav Pandit <parav@nvidia.com>
Cc: Dan Jurgens <danielj@nvidia.com>, Jason Wang <jasowang@redhat.com>,
	netdev@vger.kernel.org, alex.williamson@redhat.com,
	pabeni@redhat.com, virtualization@lists.linux.dev,
	shshitrit@nvidia.com, yohadt@nvidia.com, xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com, shameerali.kolothum.thodi@huawei.com,
	jgg@ziepe.ca, kevin.tian@intel.com, kuba@kernel.org,
	andrew+netdev@lunn.ch, edumazet@google.com,
	Yishai Hadas <yishaih@nvidia.com>
Subject: Re: [PATCH net-next v3 01/11] virtio-pci: Expose generic device
 capability operations
Message-ID: <20250925062741-mutt-send-email-mst@kernel.org>
References: <20250923141920.283862-1-danielj@nvidia.com>
 <20250923141920.283862-2-danielj@nvidia.com>
 <CACGkMEtkqhvsP1-b8zBnrFZwnK3LvEO4GBN52rxzdbOXJ3J7Qw@mail.gmail.com>
 <20250924021637-mutt-send-email-mst@kernel.org>
 <16019785-ca9e-4d63-8a0f-c2f3fdcd32b8@nvidia.com>
 <20250925021351-mutt-send-email-mst@kernel.org>
 <4fa7bf85-e935-45aa-bb2f-f37926397c31@nvidia.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <4fa7bf85-e935-45aa-bb2f-f37926397c31@nvidia.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: eRaCjTyeHbFQxsEbA5EwAgomGBoSqtcgto19ReUGpe4_1758796548
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Sep 25, 2025 at 03:21:38PM +0530, Parav Pandit wrote:
> Function pointers are there for multiple transports to implement their own
> implementation.

My understanding is that you want to use flow control admin commands 
in virtio net, without making it depend on virtio pci.
This why the callbacks are here. Is that right?

That is fair enough, but it looks like every new command then
needs a lot of boilerplate code with a callback a wrapper and
a transport implementation.


Why not just put all this code in virtio core? It looks like the
transport just needs to expose an API to find the admin vq.

-- 
MST

