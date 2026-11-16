Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.177
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794861220;
	b=LwkdjLIsxryhBRBh5mLXCcuRryiQeP10bB7gcWOtmmXEU9q+wiHj7/NcMt36KQDOOeKl
	 j0skMc6qF9q9Z2OmMkgt/Vqy4CFWmNwCqFP+5+zd3Xp8s0O2Vn5h3o09IxOOXs9MSb+t3
	 bB/lmnw+Gr6KLXUcb2SL4vODpwl0ejSKJj+q6PUvutsC4OU7s2fVzuluf8xl2rXFrkeiw
	 /Zf+m1pE5lrUCUViVeW1JXnVkSrAioXIMiDKApEEfPGrkNJpgfZ+rNvSYNPAP9Rk9AFR5
	 sRSXu1H5zo0UQGig3HTtLNqenVnnEAdNhRxRVwV9n3ZWRxcddYrtldnJB8CTYw81FGg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794861220;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Received:Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=FRUBObM4vFL1TGf3o6s1ZDBsKZdTJ/3jimI0MzXw8Fk=;
	b=TWwOa9TmH4z+dHC4nrSbcj3iAs5u3XOyFMKbsCdNT5eaWvazTRuj+M2uI/yBBoLff5zx
	 p1mMNIN9120sh2QrS4n4syz8IVtsKlwKOk4YT0xkJJeLq68OIvzB/raku1eRt2V91ePLw
	 tSY+A1yYoYujMkOMzZH8seijtJLZs11AVZP2DZNVrYUiHdGOfnfP8Ph1Qc0j//sHvwcoM
	 a9dFxRpRGErqZakZicG58+wxIsIpK6ZlQBIuiAMgec0LvXusEQKeZCWSoAxRsNx5Xe7Rp
	 UKuYN62+WNX7xd8jZuN5QOVZyNxmucMCjq59vTuVjrtlS6de4dvEaBLEgcGNajm6FOw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=ziepe.ca;
	spf=pass smtp.mailfrom=ziepe.ca;
	dkim=pass header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=kAsnXZpE;
	arc=none smtp.remote-ip=209.85.222.177
Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2446F606A338
	for <virtualization@lists.linux.dev>; Mon, 16 Nov 2026 20:33:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2446F606A338
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=kAsnXZpE
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-93f20b304c0so449914785a.3
        for <virtualization@lists.linux.dev>; Mon, 16 Nov 2026 12:33:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1794861219; x=1795466019; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=FRUBObM4vFL1TGf3o6s1ZDBsKZdTJ/3jimI0MzXw8Fk=;
        b=kAsnXZpExiAIWPmGzPTxjXRnvY22yUNZo8IvGAnAt93p93VdfBNRgkk+rHXtfePTa5
         SLgZSTCt0tEePcPa3jjt2Tv24amZ+2/BzEvnZyrxH/FQe5qg85bhEq+/dPpsObSIDYOg
         CKTFxHBogL2IxEx0spgHXOcP4LmOlFvxgnsiWgerOcuGh9ZQmrXrUlF7cvdtVz3tdDym
         S5t9/Qz7PzLUWg7jo1EG1t3k9QtQ+FcJM/0nU3OtsQBDVPuxzRsmHTFr36g+D4JY6t9Z
         sRI5WVrC0hULHDYPvhtXn+JmpCXZw972mYlRrWG/COY7LWY8UCaMoyDwMFvHZm8l2vQ8
         MFCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794861219; x=1795466019;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=FRUBObM4vFL1TGf3o6s1ZDBsKZdTJ/3jimI0MzXw8Fk=;
        b=uZbrKbEAIG+uLIJwj1tNjHHzcy8ctbOp5MyBXAwiZuO+MpcsNmzC8+8PaX1PNSCQE7
         7KFKTwYMVZG+A5TmBaH+SDBm9GKSCrOk4zDe2AK52ObjpZ9Xb2rbB+QgI+WzZb+p4YjC
         sev04RjUemRCm+VTOQCnEIS98Vdv1sLGRtTnwACR4ZQz0nNFrZ+XqpmOyqtmX1Ag4NTP
         eyfB2ByrMBqBqgsJvi4DR7//vScWy+Qh5jFMKEC4Mo8EsoeGBlfzynw3+wLTip648Kev
         xRxbXm3ALXB+xJJ+rg52WcRVu6f53QUJw3/wmYBw2T7249H0nV4ozNNEqaGbfuMxu//5
         0p8A==
X-Forwarded-Encrypted: i=1; AL+hErEUJ0ZbkCf14sZsCoJ0OJJBy5rxfm1B3oeRko529SgJC/Y+tiW35aHUXAVbV7KoZBmyRq2dFV5eHzZZqgZHOg==@lists.linux.dev
X-Gm-Message-State: APuU4Z+dRIdSSj7zBkVRvLu+wQd+Si/OTNJ+qldYuqXbDvvSJvc6LWuo
	gl7lL4srnm37TjIw6Oa4bfGhAgfPyvKmctgGttYWlJHqCCDo15xaOWE0tqiOGViid5A=
X-Gm-Gg: AYBFou3iBn8aYp0LlEI1L/IBqwIwyxa+oEnH/+ziv9CptkWNMNDby/LomMEYtdw5wmh
	RG7i7+1XbVold15CbwPcrB9mVZ+sc1ecRuOgRvqzIjte7K/MB6SJkHrCAPqU4el7RvQiqnnVXaK
	kPjQznPkolK5dlAgab7KY4kf1MNEAx7qKhHYFLi3Pte9uulFfzsQIU5duTsOys2ZmXZSs/cSxPS
	w3mNeMnkBnnohpOyJ2EO3QIa2hqy+kFDvMBoPLqnlgeu0cAjrT8+odcP3vlHstSE0V/FXvp9zlG
	QuypV2BkH/E4HMI85rF/K1WS43U09TJ9DMUyNQqeEoOpcsKZK0+9hgS5kwqjwv6CURZEFHY+zbP
	/70ClaPzP9kjCEhVzEakrH4cCS6teeYbGg3gasrrh8QH0rSpLlBhvvOO+x5LqmZrM8jliA20Z1n
	22kyy1sE8RXpwIPbi0p3jKqFqjWIwfSU/WqZMjls6vqHRyLxEyp3fqiF473vYsI2ypzDortZXe/
	SC0O6foame6Tt68lmUw+1/o61r24fqfM4mcaiCEKuYvzmlzaThoq5MSsyB2AAIf0HcECW784VQS
	UVdAPQ==
X-Received: by 2002:a05:620a:46a6:b0:949:733e:ddd8 with SMTP id af79cd13be357-949733ee766mr1034555085a.54.1794861219140;
        Mon, 16 Nov 2026 12:33:39 -0800 (PST)
Received: from ziepe.ca ([142.166.156.71])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9494c804f9esm930800685a.11.2026.11.16.12.33.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2026 12:33:38 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1xT3OT-0000000ARJs-2rZa;
	Mon, 16 Nov 2026 16:33:37 -0400
Date: Mon, 16 Nov 2026 16:33:37 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Tao Cui <cui.tao@linux.dev>
Cc: akpm@linux-foundation.org, dgilbert@interlog.com, mkp@kernel.org,
	loberman@redhat.com, jmeneghi@redhat.com, kraxel@redhat.com,
	vivek.kasireddy@intel.com, mst@redhat.com, jasowangio@gmail.com,
	eperezma@redhat.com, stefanha@redhat.com, sgarzare@redhat.com,
	rostedt@goodmis.org, vdonnefort@google.com, mhiramat@kernel.org,
	kevin.tian@intel.com, axboe@kernel.dk, linux-mm@kvack.org,
	James.Bottomley@hansenpartnership.com, sumit.semwal@linaro.org,
	christian.koenig@amd.com, phasta@kernel.org, joro@8bytes.org,
	will@kernel.org, linux-scsi@vger.kernel.org,
	dri-devel@lists.freedesktop.org, linux-media@vger.kernel.org,
	linaro-mm-sig@lists.linaro.org, kvm@vger.kernel.org,
	virtualization@lists.linux.dev, linux-trace-kernel@vger.kernel.org,
	iommu@lists.linux.dev, io-uring@vger.kernel.org,
	linux-kernel@vger.kernel.org, bobbyeshleman@meta.com,
	mathieu.desnoyers@efficios.com, robin.murphy@arm.com,
	mason@kernel.org, aesteve@redhat.com, tjmercier@google.com,
	harry@kernel.org, vbabka@suse.cz, cuitao@kylinos.cn
Subject: Re: [PATCH 5/7] iommufd: account the hw_queue page array to memcg
Message-ID: <20261116203337.GA2481588@ziepe.ca>
References: <20261106131829.3228926-1-cui.tao@linux.dev>
 <20261106131829.3228926-6-cui.tao@linux.dev>
 <20261116195213.GF2452510@ziepe.ca>
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261116195213.GF2452510@ziepe.ca>

On Mon, Nov 16, 2026 at 03:52:13PM -0400, Jason Gunthorpe wrote:
> On Fri, Nov 06, 2026 at 09:18:27PM +0800, Tao Cui wrote:
> > From: Tao Cui <cuitao@kylinos.cn>
> > 
> > IOMMUFD_CMD_HW_QUEUE_ALLOC pins up to max_npages pages just to check
> > that a user supplied queue region is physically contiguous, and the
> > page array for that check is plain GFP_KERNEL.  The size comes from
> > cmd->length, a u64 that is only overflow checked, and the array is
> > freed again as soon as the contiguity check fails, so the allocation
> > can be repeated concurrently: a 1GB region costs about 2MB of
> > uncharged memory per attempt.
> > 
> > Every other iommufd allocation that scales with user input is already
> > charged, and the pinned pages charge the mapper at map time.  Charge
> > this array like the rest.
> > 
> > Signed-off-by: Tao Cui <cuitao@kylinos.cn>
> > ---
> >  drivers/iommu/iommufd/viommu.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

I'll just apply it, thanks

Jason
