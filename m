Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC28730C158
	for <virtualization@lists.linux.dev>; Sun,  5 Jul 2026 08:26:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783239963; cv=none; b=YlIfulUb/zkjK8BvX8uJ1VoITampzcH4JFBCRUc/mvbt+LAnseVsaDYAKSeaD+t8VLBEwkPFqgUvV4P9Cnk/Xti+/2RRikGImoxKO3DiQaNsrApDojPEUh+uS+ZERxmdk0rb2h821yiPo4Jb0YIVGNuYILLB3GP93eKrXUJR9kg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783239963; c=relaxed/simple;
	bh=7U9R/BgGzycEyFVA/zLCcA9BsS+PXBMQtdKxjzYfIeo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=Hj2iNXoCGTchCZI5eZ9PtfWRtxmQ+H5/8HZ+etCL6H255ocVrx+KZz/IjC/MdWhhB7cVzWuWF7DTW2DSvcRmy8TSVhhI/N65nTqH25D4+IpkezOfhcld4LSEx/EDIRiOB4mcL05LXpHaHX54vs0teQUjZWivd7MlUaTKVAhPNhE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=F+YZOPQe; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="F+YZOPQe"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1783239960;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8QARhhZ6+Yy8zGrmYtr8GGmZltZ9TCRLEJ8tCyAg6hw=;
	b=F+YZOPQeG63laOWkgYgsvgsy2n6L7gIfgP+3zbsPXR3obyxi4Tu0MgD94aAYZuy+LkmH0D
	dLT4Ky1h5zvnsYijNJ3SVC+npQBv3mAJkGjOIYtqWGhleKcmv09EPazrl8+W85vBZb4RgU
	svJd1uBA/HMlp31uYg49NV4iwb5qLTA=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-682-7KdndrXPMi-v7j99bRZUqw-1; Sun, 05 Jul 2026 04:25:59 -0400
X-MC-Unique: 7KdndrXPMi-v7j99bRZUqw-1
X-Mimecast-MFC-AGG-ID: 7KdndrXPMi-v7j99bRZUqw_1783239958
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-493d742c668so1852465e9.2
        for <virtualization@lists.linux.dev>; Sun, 05 Jul 2026 01:25:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783239958; x=1783844758;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8QARhhZ6+Yy8zGrmYtr8GGmZltZ9TCRLEJ8tCyAg6hw=;
        b=orL5Cr9Vqyy4y28ZaoLcn8JxXVcsaIN9zX0+DsbwkclQCU+SLkvq3KqT99F0z47/Ps
         /Gx93UPmdwaaZmdIzdBek4iRPOR67g97X2ZAg1rpF6S0yJAFCZ8sf0BK+TwM2yBTznrT
         1SlSFPy2HupD/cFg0EZteeZ+DMsTLf1p+IFlsL5j5vv/7I7MuTndJ9t6kbjDieVLxlVk
         RiGdV9r6tNtr3zFGl55hwxLW2a3BJiD4v8cqJ2XHAx8I/zjAB01++yRtSWWJDON+/CRq
         3QtBnsM7yvXNwIFxSCTl82vvQFnreO/m4Uao/QdyXtqDwTp5uhKCK3zq2PMQ9SXBzXlv
         KB4g==
X-Forwarded-Encrypted: i=1; AFNElJ/dW2BbP6AIURtqsqtcbYFmqweADa427ZX76Fg1Uq2humZgX+4DQ5T/KmbhfFt6s5e90DGNPVytuYdiJGPEaA==@lists.linux.dev
X-Gm-Message-State: AOJu0YzcWPrFtGMp1Demz1i4OfQQ8MpWfItnVgB3RVl8t1PTv2bHyvnu
	zfb2JbGdKBRZ/joiQGvmJJEO9FOaJfUxQG1wb/wHbt2bg0dDmHu1b3dNdubSAGrnEexe1iiangh
	xV2/7scC7t3WqrDIPcT9qkkwhrnmk3ClwT6+4nnvjiCzUa7aqIA/YBqWwInt0anUxqVjp
X-Gm-Gg: AfdE7ckuuze9rrdYlDEkN4zG+lQBfs/370Pu2QkRQDMnq4fv8lnR291YBHjS9J+9Se1
	rQLh7Nr00bKTw2VXOt4VbUkyfl0BTZ+EDHe9xT8z2VXYy/qfRZDJfx7rsJEFeVlgxR7ky/32HpZ
	O8F2wX1FAy6F9o6s/CJHCTe0bCASuwK1t7cTxm4xL1pGKb3HKe3mNpqvg+7yLdIqVpf0XMJrPxN
	1S4s3ij6Y9B8VmIQq5qzvAVscPl52qGXYByuelxjnRgrE2Gca39de9YlKgeAH7EJy67G31AKxCI
	PaWWXqq60ZsXtbMJf5JKYwHd4z8Gc5w1MNjAIcZyEYftlc5EdxOfPDYLn2x5cat9cXC2MGsSgNd
	mjbHq41kIU6GVAaWq0wurhCSqov+6QR8+
X-Received: by 2002:a05:600c:4687:b0:493:bd2f:c5dd with SMTP id 5b1f17b1804b1-493d11f3769mr69488845e9.21.1783239958249;
        Sun, 05 Jul 2026 01:25:58 -0700 (PDT)
X-Received: by 2002:a05:600c:4687:b0:493:bd2f:c5dd with SMTP id 5b1f17b1804b1-493d11f3769mr69488415e9.21.1783239957721;
        Sun, 05 Jul 2026 01:25:57 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-68-31.inter.net.il. [80.230.68.31])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47aa0960816sm13749921f8f.29.2026.07.05.01.25.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Jul 2026 01:25:57 -0700 (PDT)
Date: Sun, 5 Jul 2026 04:25:53 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org,
	"David Hildenbrand (Arm)" <david@kernel.org>,
	Gregory Price <gourry@gourry.net>, Zi Yan <ziy@nvidia.com>,
	Pankaj Gupta <pankaj.gupta@amd.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	Lorenzo Stoakes <ljs@kernel.org>,
	"Liam R. Howlett" <liam@infradead.org>,
	Vlastimil Babka <vbabka@kernel.org>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	Brendan Jackman <jackmanb@google.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Alexander Duyck <alexander.h.duyck@linux.intel.com>,
	virtualization@lists.linux.dev, linux-mm@kvack.org
Subject: Re: [PATCH v3] mm: page_reporting: allow driver to set batch capacity
Message-ID: <20260705042313-mutt-send-email-mst@kernel.org>
References: <444c24cf39f3f3620fc90ef4695bd6b0979f4c4b.1783232420.git.mst@redhat.com>
 <20260705011635.9974cac7f0defec9961e85c4@linux-foundation.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20260705011635.9974cac7f0defec9961e85c4@linux-foundation.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: mkB_uBVQ7vPNPJV-mVAPOG8Cd5iLrj2vfalK68zdm3w_1783239958
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Jul 05, 2026 at 01:16:35AM -0700, Andrew Morton wrote:
> On Sun, 5 Jul 2026 02:25:13 -0400 "Michael S. Tsirkin" <mst@redhat.com> wrote:
> 
> > At the moment, if a virtio balloon device has a page reporting vq but
> > its size is < PAGE_REPORTING_CAPACITY (32), the balloon driver fails
> > probe.
> > 
> > But, there's no way for host to know this value, so it can easily
> > create a smaller vq and suddenly adding the reporting capability
> > to the device makes all of the driver fail. Not pretty.
> > 
> > Add a capacity field to page_reporting_dev_info so drivers can
> > control the maximum number of pages per report batch.
> > 
> > In virtio-balloon, set the capacity to the reporting virtqueue size,
> > letting page_reporting adapt to whatever the device provides.
> > 
> > Capacity need not be a power of two.  Code previously called out
> > division by PAGE_REPORTING_CAPACITY as cheap since it was a power
> > of 2, but no performance difference was observed with non-power-of-2
> > values.
> > 
> > If capacity is 0 or exceeds PAGE_REPORTING_CAPACITY, it defaults
> > to PAGE_REPORTING_CAPACITY.  The 0 check and the clamping is done in
> > page_reporting_register(), before the reporting work is scheduled,
> > so we never get division by 0.
> 
> Thanks.  What's the priority here?  Should we fix 7.2?  Earlier?

If possible, I'd like it in 7.2, have a setup like this (small
queue is useful for perf testing).
It's very early in the cycle and the code seems straight forward...
I judge the chances of breaking anything is tiny because
it just failed probe previously.

> It seems that Sashiko has found a pre-existing issue, a hard-to-hit
> error path thing:
> 
> 	https://sashiko.dev/#/patchset/444c24cf39f3f3620fc90ef4695bd6b0979f4c4b.1783232420.git.mst@redhat.com
>

will look into this, thanks!

