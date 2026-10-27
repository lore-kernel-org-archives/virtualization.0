Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793096980;
	b=fV6Jxbf6nvHuHic2bX7I8q42iBZ72Uh06GW7PwuNgWJVRaCBChkALGx6lgf3MFt6l8T0
	 8O3oqllD+a5Zr2iDj3E0rxB7VfJ+sKW8DP5qDBEjb54p5ty+tUtCcPeQqw8xKYbUyd33s
	 rztx8VtW2nxBmXEpdIALCv9KIzShbyFa9HqsI0/qKEkxdXNIcNvEQaNKb45TOFexbmibf
	 FzFSe3K5+LXICiiTam04/BAFUsb5+DOBV3Z1mLLT/8KYj03ZyvCyjpb7SGqVKHKox0ebA
	 qBENeiArzQ5c9GL3YcLFQ2mzhYcGm5VFCoZKmrdbolcZh7zVo/kaB0IqlV4cV+irR1w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793096980;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:In-Reply-To:X-Mimecast-Spam-Score:X-Mimecast-MFC-PROC-ID:
	 X-Mimecast-Originator:Content-Type:Content-Disposition;
	bh=h84z7fd1Ik8wN7YTsUmwTZKDWUsWH0q82RExH9eag3k=;
	b=DiIY9AqrtIexJEiibuN+ebI83RNrXUgBAu82H423CKYRGdxYH7o7/Nr8Ny2eQeiYKqDm
	 5+f/mif+pzxhX8e7H1lCUUj8iQNakAH+LNqVlUJ8OSob6Uxm/B9NTzT3go2qFgNe8fB7K
	 UEFR93RhI3/MYzIb4/Bq3HTqyZZs+NbVsklOAzGHIK4OIr/otVckPdJm+QOvxQQeB13NP
	 /RbQIFs8I8XkQRfZJHUHmngw0KnW4R5HVOZXnHE8KQCL+REHVhCQ+VyB9ZdxjfuZylDfk
	 TQvDSlVTxGUb+5C1Af9UpdTJTb/q+Sz84MIy+7Db79HtyN/vbRQvelneSnY9dU5Ir/Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=gLb9YpG7;
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC043606A32D
	for <virtualization@lists.linux.dev>; Tue, 27 Oct 2026 10:29:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AC043606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=gLb9YpG7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1793096978;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=h84z7fd1Ik8wN7YTsUmwTZKDWUsWH0q82RExH9eag3k=;
	b=gLb9YpG7t7aAG5zdrtnhvrwl+EWJbl8BAas3vnSQvE7RZFC1to4hrFJ2HzYEXlEd7BUFNl
	AQp/dEfFDJW0EhBTKWGntzjWOoRNCmTG3CAPNCoGP2WFDppFPrRHTHwVg7Povykn7MS4Hz
	YOoQJy/9sO9n4UL2QB3b4MknMrzEpLQ=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-422-qJRXz7-lOQ6L3PfNhCtdWA-1; Tue, 27 Oct 2026 06:29:37 -0400
X-MC-Unique: qJRXz7-lOQ6L3PfNhCtdWA-1
X-Mimecast-MFC-AGG-ID: qJRXz7-lOQ6L3PfNhCtdWA_1793096976
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-48dfdc0f491so2201343f8f.1
        for <virtualization@lists.linux.dev>; Tue, 27 Oct 2026 03:29:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793096976; x=1793701776;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=h84z7fd1Ik8wN7YTsUmwTZKDWUsWH0q82RExH9eag3k=;
        b=yvELcd3vGbzO7bDMo4mS6FIf06aYvzfiaQHKr41g8klr35dLyCw9yr0eM/eyJoiMRW
         jFf4IRXq89BqJn9KtFbrIkGGQojWHZlssP3DHqUORcfYs8SECJ0UXNXFhxz9/bcvWLDt
         yDmLJSjm46K+h5N8RnohvTZ+saGZgZJFpSqkZkvbv9fQ6C1pIAkOjJyKICn/DIRZaNhK
         Z9tGKyf8zfsA5eBQy/UMeUu4+3FpERTXkhcq3uANcaIDDQFL3PZiB9be8RGFPjAer7vC
         LmndpV1iEWm0q8qMurtyqvlimrhgvDIUg2SiVqQzqh3bBDrlISq/u41NaHrJCj1Uj954
         pOJw==
X-Forwarded-Encrypted: i=1; AKwUvBypbMixDigMjdKWb4wDCykrIh1Hvmb24ATBr/6dB+4oqmXwJ5zmez1/pOzIy2jShmzgNHZFw9mZiY/N41KRHg==@lists.linux.dev
X-Gm-Message-State: AFq9FYJtgJoGgB//nec+iRmXE57aYiZSNXZZg4X7k09hxeEbMDyflhIM
	rBdyE+bM7umIDellvs65ft7/7kL6FDzmtUW0My8WSSUQorU/2bcN9ctf0DskHzCzGMI2Q4yiS3p
	NADHPiuAqAwalT5TqgXga0r+8CDL+tITZXoFaCMQ82qOIIl5qT92JAG6+NAnf51LXfotB
X-Gm-Gg: AYBFou3HcGqpqQPIJJFOojzg0wMJkhA44BbHGptJ7B8t8RDaybXum1+JYZYaNxOBX81
	iZqH+ArQ47eguj/5lSg2HvzzDwzDcytrapk7aZ+7RJVbXmVFlo1Q8axSWPJert3HsGGo+iodkkz
	7/1fO0ZrHmaLOFCaaWzs7SdWgN5EdtgtLg851SsyaUpGZylhDex/7uQqb0BPMnmsFArVIoujRTO
	WlzUlIMb8Y0ypFPwR3Kshnfm9MDxpITxDbVpxnOGFP3GThXGP98wg7zeskLmUy2CeqCoFmoR1fo
	3yK9vm3+xnp79YH1dT1s6qgXkjncTmjCALp04tCbFnervEscWZFYJVr7c4mNLhlvOjY=
X-Received: by 2002:a05:600c:8b86:b0:4a3:59c9:a754 with SMTP id 5b1f17b1804b1-4a35acb17bfmr175618455e9.22.1793096975879;
        Tue, 27 Oct 2026 03:29:35 -0700 (PDT)
X-Received: by 2002:a05:600c:8b86:b0:4a3:59c9:a754 with SMTP id 5b1f17b1804b1-4a35acb17bfmr175617615e9.22.1793096975354;
        Tue, 27 Oct 2026 03:29:35 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1536:fc00:b838:383:1c7:6e81])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a35a2d9280sm254068375e9.13.2026.10.27.03.29.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2026 03:29:34 -0700 (PDT)
Date: Tue, 27 Oct 2026 06:29:29 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Kevin Loughlin <kevinloughlin@google.com>
Cc: David Hildenbrand <david@kernel.org>, Jason Wang <jasowangio@gmail.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Ard Biesheuvel <ardb@kernel.org>, Kiryl Shutsemau <kas@kernel.org>,
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	Tom Lendacky <thomas.lendacky@amd.com>,
	Ashish Kalra <ashish.kalra@amd.com>,
	Michael Roth <michael.roth@amd.com>,
	Rick Edgecombe <rick.p.edgecombe@intel.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Vlastimil Babka <vbabka@kernel.org>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	Brendan Jackman <brendan.jackman@linux.dev>,
	Johannes Weiner <hannes@cmpxchg.org>, Zi Yan <ziy@nvidia.com>,
	Alexander Duyck <alexanderduyck@fb.com>,
	virtualization@lists.linux.dev, linux-coco@lists.linux.dev,
	linux-efi@vger.kernel.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Sidharth Telang <sidtelang@google.com>,
	Punit Salian <psalian@google.com>, Peter Gonda <pgonda@google.com>,
	Ackerley Tng <ackerleytng@google.com>,
	Jacky Li <jackyli@google.com>,
	Steve Rutherford <srutherford@google.com>,
	David Skidmore <davidskidmore@google.com>
Subject: Re: [PATCH 00/13] virtio_balloon, efi/unaccepted: support memory
 ballooning and free page reporting in CoCo guests
Message-ID: <20261027051245-mutt-send-email-mst@kernel.org>
References: <20261027025616.1632690-1-kevinloughlin@google.com>
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
In-Reply-To: <20261027025616.1632690-1-kevinloughlin@google.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: nXu-5GGt6QEyMV72Q2qlq6GrnfcxlEu_sH5L0dBIDoo_1793096976
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Oct 27, 2026 at 02:56:03AM +0000, Kevin Loughlin wrote:
> This series enables virtio-balloon free page reporting and memory balloon
> inflation/deflation in Confidential Computing (CoCo) guests, starting
> with architectural hooks implemented for AMD SEV variants, in order to
> support dynamic CoCo guest resizing.
> 
> Today, memory ballooning and free page reporting are essentially unusable
> in CoCo guests due to three main roadblocks:


For me, the bigger question is not whether we can, but whether we
should. Considerations I would like to see addressed:

Security, e.g.: does knowing which memory is free leak information from
the guest? If no, why not?
Consider CONFIG_SHUFFLE_PAGE_ALLOCATOR, RANDSTRUCT, etc.

correctness, e.g.:  Linux has init on free (and default on windows), if
initialized pages are dropped and host can not be trusted, they have to be
re-initialized. Is this handled? I don't see it in code.

Also, performance, e.g.: How much does this re-initialization cost?

Management: it was simple with balloon off unconditionally.
Now we are in murkier waters with various features offering
various performance/security tradeoffs.
What if some guests want the tradeoffs but others don't?

Documentation: for all of the above.

-- 
MST

