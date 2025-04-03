Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 098FB24EF6D
	for <virtualization@lists.linux.dev>; Thu,  3 Apr 2025 14:35:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743690944; cv=none; b=W+xg7Xb+1DO140QpCdYce0S0HYa2hZB2OHi6LFw/q/cf39EOQvJmunZ4K2JIeBeOVubBYJnKawZ6MMno2IaQWkXoOlCnmnbhqoOaDtIt1Wss+lPpDnRTIh/diFFOwQqav7+vxacNVgALV62HJJBIQrWFoR9MBg0y5Jfh4J63FfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743690944; c=relaxed/simple;
	bh=VVx6R47TuFIQGBjJefnPKH6pjjD0ilkcfGKvlV0Oiyo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=lyvoRU9go2ktt0hlul5iHd9Eaxrs1Pd7seFr6En4uOIrMO4TrZU1QuAXFXhX2E3EetSzBxThmOo/5Qj+o8A7ZaWOrNc7xte5ISSctjASSLX5VGotmVT6YqwHP23F+PU9YHoFe02xirhZ8ZDvD6tbV7eaTtM5jUCH+78drXI/EI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dHDL0UH7; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dHDL0UH7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1743690941;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=378ZLKAn6VFAF4a5RVvN8NmNgzNa+OCnXLX5wlVPRjk=;
	b=dHDL0UH7R0W/rPZNyHf6yxFz97XaivNSey5rxLqkPyk/NFs1GfR4v1/jig1XuK8PBaE76u
	VLJ3abWCZB3JY5NC9czIyVD6JNh/kdtz+wV310LQzanbL/cEIyV0q8tjUefb7HSgR/F2cj
	fFwS+u6G3JM7sbC+562/ry2vEViy93k=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-34-wPPQlElVMbCrI-RdubUHxQ-1; Thu, 03 Apr 2025 10:35:38 -0400
X-MC-Unique: wPPQlElVMbCrI-RdubUHxQ-1
X-Mimecast-MFC-AGG-ID: wPPQlElVMbCrI-RdubUHxQ_1743690937
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-43d5ca7c86aso6132965e9.0
        for <virtualization@lists.linux.dev>; Thu, 03 Apr 2025 07:35:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743690937; x=1744295737;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=378ZLKAn6VFAF4a5RVvN8NmNgzNa+OCnXLX5wlVPRjk=;
        b=a9GVjltyC8MlHdRvCFPpCGLnKQwgtJZT+DIzEkKjVm3I0X2hkOjt5eEbVGT5M+ruF0
         FtXA2Gwee8dr/32z+DiStiSno7I9DB+Azf2tj61yYYx9aOUWqIyMQBmid5e6iu8Dnvab
         8dwNcjDGASBZACGpHWKtQUtyQVP2TsD4mWmqEez3r9mKHU7jRIt7vWbQRCyaViEbxGlB
         iOQ+Q1McGmVYCYtL2T3D/WMFCaIzooei/h3oyL0WWvmEzLW5va7GA0vtQsj3fxY2GpI/
         sNPfEA0tWXKGEJfYH9LJCt7RVd+Z9ceBWj/chMrM08DVtO/YSFzIhL6oqVQV/YTflORG
         m/Hw==
X-Forwarded-Encrypted: i=1; AJvYcCVzbpWGrjDchWHfY0hJPr9LGWqUKO1mX2YMRuBcSEDchE+mfaJiWel6Po/TjkvwcJvDNsF4clqkQ40aX/Z7bQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YwnB0aFyWlPKAj+LDN0IQP30q22Wtut4uQ0CL6ZbXJLGN0tVUN8
	D+sH76F0rhF+L8ZSScRz6ZK95hjPL/bwClS3EnJjot8ojGOk/IoKvkZZLJfSJOAQ3XI8I5YVT4s
	hHiwn/iQ6jswnlV0x4pGAS1Zb4XW1lFWmXkg58Wd9pKTKagQgN17pZr7w0qCsqnVA
X-Gm-Gg: ASbGnctcA4Fg6O2f7SFHekt1brOdS3yRHqHlZoaKNoztxPqKZoopOzjqhrx2mur860w
	u7DdPfmn3YRxm2v1kpbFpJtGKTgoyRKEnn4/7Ck5zFXrwwnejdeS7bklwMM1ElNTHH9uWR/9e9W
	5lnfiuNW9cFd1fQvwo9RiN+UKt5+LFYeNdR76XBKudhUxGI0eyie//2eU2NeiKxXyZCkAzVuP11
	mVMweJhepbT6IMl2iq9DOlWx2GWxxjAdUKTon52wuSZnyVAMPiymLAQM1tnu+o0OPKpg6t2+bel
	cSJK/pdQUg==
X-Received: by 2002:a05:6000:2503:b0:399:737f:4de3 with SMTP id ffacd0b85a97d-39c303389ecmr2163821f8f.29.1743690937506;
        Thu, 03 Apr 2025 07:35:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEMqd/k72wEUHJmQoR1gc5ioRBplFkIbZAtw9O7H6BmO4sOWQ/nHk2zg4ZobK6Yp864CCo+5w==
X-Received: by 2002:a05:6000:2503:b0:399:737f:4de3 with SMTP id ffacd0b85a97d-39c303389ecmr2163797f8f.29.1743690937132;
        Thu, 03 Apr 2025 07:35:37 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1517:1000:ea83:8e5f:3302:3575])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-39c300968c4sm1999368f8f.9.2025.04.03.07.35.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Apr 2025 07:35:36 -0700 (PDT)
Date: Thu, 3 Apr 2025 10:35:33 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Halil Pasic <pasic@linux.ibm.com>
Cc: David Hildenbrand <david@redhat.com>, linux-kernel@vger.kernel.org,
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
Message-ID: <20250403103127-mutt-send-email-mst@kernel.org>
References: <20250402203621.940090-1-david@redhat.com>
 <20250403161836.7fe9fea5.pasic@linux.ibm.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20250403161836.7fe9fea5.pasic@linux.ibm.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: Nz3K76q_dKre4YvnW8QdYH5sq36HsCySaAIt6p7TDDw_1743690937
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Apr 03, 2025 at 04:18:36PM +0200, Halil Pasic wrote:
> On Wed,  2 Apr 2025 22:36:21 +0200
> David Hildenbrand <david@redhat.com> wrote:
> 
> > If we finds a vq without a name in our input array in
> > virtio_ccw_find_vqs(), we treat it as "non-existing" and set the vq pointer
> > to NULL; we will not call virtio_ccw_setup_vq() to allocate/setup a vq.
> > 
> > Consequently, we create only a queue if it actually exists (name != NULL)
> > and assign an incremental queue index to each such existing queue.
> 
> First and foremost: thank you for addressing this! I have to admit, I'm
> still plagued by some cognitive dissonance here. Please bear with me.
> 
> For starters the commit message of a229989d975e ("virtio: don't
> allocate vqs when names[i] = NULL") goes like this:
> """
>     virtio: don't allocate vqs when names[i] = NULL
>     
>     Some vqs may not need to be allocated when their related feature bits
>     are disabled. So callers may pass in such vqs with "names = NULL".
>     Then we skip such vq allocations.
> """
> 
> In my reading it does not talk about "non-existent" queues, but queues
> that do not need to be allocated. This could make sense for something
> like virtio-net where controlq 2N is with N being max_virtqueue_pairs.
> 
> I guess for the guest it could make sense to not set up some of the
> queues initially, but those, I guess would be perfectly existent queues
> spec-wise and we would expect the index of controlq being 2N. And the
> queues that don't get set up initially can get set up later. At least
> this is my naive understanding at the moment.
> 
> Now apparently there is a different case where queues may or may not
> exist, but we would, for some reason like to have the non-existent
> queues in the array, because for an other set of features negotiated
> those queues would actually exist and occupy and index. Frankly
> I don't fully comprehend it at the moment, but I will have another look
> at the code and at the spec.
> 
> So lookign at the spec for virtio-ballon I see:
> 
> 
> 
> 5.5.2 Virtqueues
> 
> 0
>     inflateq 
> 1
>     deflateq 
> 2
>     statsq 
> 3
>     free_page_vq 
> 4
>     reporting_vq

Indeed. Unfortunately, no one at all implemented this properly as
per spec :(.

Balloon is the worst offender here but other devices are broken
too in some configurations.


Given it has been like this for many years I'm inclined in this
instance to fix the spec not the implementations.




> statsq only exists if VIRTIO_BALLOON_F_STATS_VQ is set.
> 
> free_page_vq only exists if VIRTIO_BALLOON_F_FREE_PAGE_HINT is set.
> 
> reporting_vq only exists if VIRTIO_BALLOON_F_PAGE_REPORTING is set. 
> 
> Which is IMHO weird.  I used to think about the number in front of the
> name as the virtqueue index. But based on this patch I'm wondering if
> that is compatible with the approach of this patch.
> 
> What does for example mean if we have VIRTIO_BALLOON_F_STATS_VQ not
> offered, VIRTIO_BALLOON_F_FREE_PAGE_HINT offered but not negotiated
> and VIRTIO_BALLOON_F_PAGE_REPORTING negotiated.
> 
> One reading of the things is that statq is does not exist for sure,
> free_page_vq is a little tricky because "is set" is not precise enough,
> and reporting_vq exists for sure. And in your reading of the spec, if
> I understood you correctly and we assume that free_page_vq does not
> exist, it has index 2. But I from the top of my head, I don't know why
> interpreting the spec like it reporting_vq has index 4 and indexes 2
> and 3 are not mapped to existing-queues would be considered wrong.
> 
> And even if we do want reportig_vq to have index 2, the virtio-balloon
> code could still give us an array where reportig_vq is at index 2. Why
> not?
> 
> Sorry this ended up being a very long rant. the bottom line is that, I
> lack conceptual clarity on where the problem exactly is and how it needs
> to be addressed. I would like to understand this properly before moving
> forward.
> 
> [..]
> > 
> > There was recently a discussion [1] whether the "holes" should be
> > treated differently again, effectively assigning also non-existing
> > queues a queue index: that should also fix the issue, but requires other
> > workarounds to not break existing setups.


Yep. I tried that, and it is basically a terrible mess :(.


> > 
> 
> Sorry I have to have a look at that discussion. Maybe it will answer
> some my questions.
> 
> > Let's fix it without affecting existing setups for now by properly ignoring
> > the non-existing queues, so the indicator bits will match the queue
> > indexes.
> 
> Just one question. My understanding is that the crux is that Linux
> and QEMU (or the driver and the device) disagree at which index
> reporting_vq is actually sitting. Is that right?
> 
> Regards,


> Halil

