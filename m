Received: from mail-qv1-f65.google.com (mail-qv1-f65.google.com [209.85.219.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA6F1492506
	for <virtualization@lists.linux.dev>; Wed, 21 Jan 2026 15:39:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769010001; cv=none; b=jFghCEHaiN/bBF83djI81tcH7B41F4mF38vfJ94o6vkjP9XuzEOkUJPHcB/230vHqytpE+RK7Pitah+yL38qTs8wq2HAOFsgQUV8nTHyn7/F5unah2LI0Fms6Z45Vx/zFAzNqspFEVIz8XhYgerBSasY20z+424tdudEjtI4KjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769010001; c=relaxed/simple;
	bh=6/tSgLR7J3UgafXRAX+XBEPxIV3H81+kUIgU8b8gh7Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ilw6g4EdszQBGp5W1u3OQfkCbdr+I9nnekfSLtE54KsL1OHQ/R+9Zn2Rjbw7FVgDJW1yZswhlg5IXO7dsEha04/5ZKzeLQeaM4b2d92aH8atgPWI9XO5QlHtfedwqaBJDTDT7JnYor6CKzjpTu3GSrtM/r4zil7WI/hyR3Q+gq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=iXA4LEGz; arc=none smtp.client-ip=209.85.219.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="iXA4LEGz"
Received: by mail-qv1-f65.google.com with SMTP id 6a1803df08f44-88a35a00506so117086d6.2
        for <virtualization@lists.linux.dev>; Wed, 21 Jan 2026 07:39:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1769009999; x=1769614799; darn=lists.linux.dev;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Q/gIihsafKtPWuGmVrtzbFv3/1+tW3nx1RJPQscpuso=;
        b=iXA4LEGz5fsD2Eu9JKiw/1gGTfcaXvZsVKDFmPj/ELmcYytwNcpZpl8y5V3+T+enIq
         NtPuI0X0k5sFAjZUkYi+4Zd9q4hBpdPEgj5qEJpQzbpaGVfebFAm0dw3ZD8CRtIY69Is
         YSAEJTXR9/rAN2Ahmk0+ltOiGVz5PyDdhkx8Qn6BQU2kbjg0w0ySOdwGZV/RLvzu4Km7
         hh/zHg9/k58jNCgiZL9TjXT2B7xicvJRKC2BZBFSjFLuqxZW6H7fTGrb6GViAhlOVXP4
         8b5xpzqmjGmDBXY6POP6lvnCnkKxhKkN4khjV7nseg8WiU+CwsvP2OdXiM8IQB2AB4UI
         0TYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769009999; x=1769614799;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Q/gIihsafKtPWuGmVrtzbFv3/1+tW3nx1RJPQscpuso=;
        b=bXJ5OgtrPif8b1XXuQVFJKWSajFvyxK9yQknZvWLXvbkVKvapC5Fl68RFGMrEce2n+
         pq4FMP/nb01bZ9U5YACbyfrLqdXrJ8zNE88NW3hDCYUYO+JjgKyfvDFWq4mFv9abPNHb
         S5dDxQQrxq69fYOUJzqq4FbSwNysO02UdldtI3WniYRNhRMMRYi6MM4HhvzXBn7Tr5Rl
         FwxeN20dQP8hthjJEmGyUj16z2d46yoF4A9hd991qEQET+0lyJz2SZ8+Q3syqu5BReQw
         UOpim2lvLxI/avrpVAtg+988UuFzEccbUGKZynwEXPXCQ3RZPyvvB9nqQxo4gWy5GETg
         ZaWA==
X-Forwarded-Encrypted: i=1; AJvYcCWvVSh7XqUmJHUZokFWAIh6cKww76jrK9nzFVoPDV5yx+t4ZRvtWZW3WGVYHc/ofrew2iFsY1CoXy6yQ8ALCQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YzQEfKWQydENBAXC2QLVGUh5EB5KSyIepyHLki31Q4NfXSgeuCs
	TATShID3gtgOeaxE9wu3RUuHt5/vIKfCZYG5OfMus7YhWtYUNGf3rXh5XdbAMJXVrDA=
X-Gm-Gg: AZuq6aJcaHM82g1VeCyzjE4wXKmeIyFEydQL7JApg6Zs992nUk0GbRmaiSlBxE+3xI2
	w1ZPq2WYOaROXyy1OfIOS6VjS/QItrxCyd8GGtWQZ72/6swUYWrMQD/jZfqNBLNlhS9OlqLc2F6
	EhbdeXLyag76V8Xod14/dr+OmfLwB6xwylv8BaxQc/nsvimTxMkSjPbdM0TDOOtE+YXI6Qyzvzu
	tW/ExZuKVB9RFg0/SAduOKEd9Awo2lAK+qSblpkZQrHZsac7w7DJb/kEv0H5xPBc1aq0Nh6JT7W
	PZCpftcAuFy082kJkMhtSrhlq41Wr3jeKIDWJxTe7zsohMzeVXMPSe5fbgE8tSSBw38FXfcnckF
	uVtD8ssfCKzBy52BI2vLw9AuBqcodM12myIGImxhfS1q7OnQzwc6pV0DrvDntQWjjX8U/N1931W
	qwT2AFEOAsrlx6U3zvJBlNQP40O7m+wOz5qNsijYkG68zrljOaRT0H/UxNpHEiOYYvJEA=
X-Received: by 2002:a05:6214:469b:b0:894:3cde:f81e with SMTP id 6a1803df08f44-8943cdef85amr237172426d6.41.1769009998640;
        Wed, 21 Jan 2026 07:39:58 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-162-112-119.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.112.119])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-894592ba642sm58791866d6.57.2026.01.21.07.39.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jan 2026 07:39:57 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1viaJJ-00000006EiI-13u3;
	Wed, 21 Jan 2026 11:39:57 -0400
Date: Wed, 21 Jan 2026 11:39:57 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>
Cc: Leon Romanovsky <leon@kernel.org>,
	Sumit Semwal <sumit.semwal@linaro.org>,
	Alex Deucher <alexander.deucher@amd.com>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	Gerd Hoffmann <kraxel@redhat.com>,
	Dmitry Osipenko <dmitry.osipenko@collabora.com>,
	Gurchetan Singh <gurchetansingh@chromium.org>,
	Chia-I Wu <olvaffe@gmail.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Lucas De Marchi <lucas.demarchi@intel.com>,
	Thomas =?utf-8?Q?Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Kevin Tian <kevin.tian@intel.com>, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	Felix Kuehling <Felix.Kuehling@amd.com>,
	Alex Williamson <alex@shazbot.org>,
	Ankit Agrawal <ankita@nvidia.com>,
	Vivek Kasireddy <vivek.kasireddy@intel.com>,
	linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
	linaro-mm-sig@lists.linaro.org, linux-kernel@vger.kernel.org,
	amd-gfx@lists.freedesktop.org, virtualization@lists.linux.dev,
	intel-xe@lists.freedesktop.org, linux-rdma@vger.kernel.org,
	iommu@lists.linux.dev, kvm@vger.kernel.org
Subject: Re: [PATCH v3 3/7] dma-buf: Document RDMA non-ODP
 invalidate_mapping() special case
Message-ID: <20260121153957.GC961572@ziepe.ca>
References: <20260120-dmabuf-revoke-v3-0-b7e0b07b8214@nvidia.com>
 <20260120-dmabuf-revoke-v3-3-b7e0b07b8214@nvidia.com>
 <4fe42e7e-846c-4aae-8274-3e9a5e7f9a6d@amd.com>
 <20260121091423.GY13201@unreal>
 <7cfe0495-f654-4f9d-8194-fa5717eeafff@amd.com>
 <20260121131852.GX961572@ziepe.ca>
 <8a8ba092-6cfa-41d2-8137-e5e9d917e914@amd.com>
 <20260121135948.GB961572@ziepe.ca>
 <8689345b-241a-47f4-8e9a-61cde285bf8b@amd.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8689345b-241a-47f4-8e9a-61cde285bf8b@amd.com>

On Wed, Jan 21, 2026 at 03:15:46PM +0100, Christian König wrote:
> > And let's clarify what I said in my other email that this new revoke
> > semantic is not just a signal to maybe someday unmap but a hard
> > barrier that it must be done once the fences complete, similar to
> > non-pinned importers.
> 
> Well, I would avoid that semantics.
>
> Even when the exporter requests the mapping to be invalidated it
> does not mean that the mapping can go away immediately.
> 
> It's fine when accesses initiated after an invalidation and then
> waiting for fences go into nirvana and have undefined results, but
> they should not trigger PCI AER, warnings from the IOMMU or even
> worse end up in some MMIO BAR of a newly attached devices.

So what's the purpose of the fence if accesses can continue after
waiting for fences?

If we always have to wait for the unmap call, is the importer allowed
to call unmap while its own fences are outstanding?

> So if the exporter wants to be 100% sure that nobody is using the
> mapping any more then it needs to wait for the importer to call
> dma_buf_unmap_attachment().

We are trying to introduce this new idea called "revoke".

Revoke means the exporter does some defined sequence and after the end
of that sequence it knows there are no further DMA or CPU accesses to
its memory at all.

It has to happen in bounded time, so it can't get entangled with
waiting for userspace to do something (eg importer unmap via an ioctl)

It has to be an absolute statement because the VFIO and RDMA exporter
use cases can trigger UAFs and AERs if importers keep accessing.

So, what exactly should the export sequence be? We were proposing to
call invalidate_mapping() and when it returns there is no access.

The fence is missing, so now the sequences includes wait for the
fences.

And now you are saying we have to wait for all unmaps? Not only wait
for the unmaps, but the importers now also must call unmap as part of
their invalidate_mapping() callback.. Is that OK? Do existing
importers do that?

If all the above are yes, then lets document explicitly this is the
required sequence and we can try to make it work. Please say, because
we just don't know and keep getting surprised :)

Thanks,
Jason
