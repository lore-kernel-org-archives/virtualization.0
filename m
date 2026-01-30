Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE952311C06
	for <virtualization@lists.linux.dev>; Fri, 30 Jan 2026 13:56:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769781382; cv=none; b=cxCFfqCi7AF2jH7s7a4y2EYbeCmxI5yaeWbhTA+mcBTj8Hsr4JMyg/k3ToGKlMf/dl0PHkjvZyzIESrQ2Ghvu15N+3Wu78Tn2kB2wy2UHKkIGct/oABVA5Fq1236qUa6Ey5xJBd7FrbdA0/BGc753hLSKuenBRgWmgAtusKjF7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769781382; c=relaxed/simple;
	bh=SL16M++KtfIb+4uJE+a/R7kOylXhnM5j4tZGOMk8fro=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qmMcXxlNij2wMang2+J/SXiGgllIhPTXLiyppaJ9guRgJFlkDFwOTkdeGu+hj4Nnc+nTQ7U1fbTU78FgPkjHBLvhBdUEXVijeq3m+dROJkEk4pTCG9bttzW3hATyZxrZ7i22AmLj0vbIWi1m5Soha2jNT5Bw3fTM5qlPCivs4/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=S64ToH4N; arc=none smtp.client-ip=209.85.219.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="S64ToH4N"
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-88ffcb14e11so27843186d6.0
        for <virtualization@lists.linux.dev>; Fri, 30 Jan 2026 05:56:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1769781379; x=1770386179; darn=lists.linux.dev;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=nHaCd4HrbYw78ScpRIoaj6AeaBJaVtnx8urFDLScj1Y=;
        b=S64ToH4NaF49kPJsUwF3aOvFtqGZZ/9lHsTXj1o1U7Hrzyn0LqSOmCPalwM0fj1m8m
         WYI9iz0Q6OOqn7esnBSYHHrUzz+pRccfMSE/i0/9f6yEcsCcjx4q44YlPdai04NQjfDt
         IfkdLZ3G7Jrav7wZiUBmpgIUZ8j7hn/jPPXbr+0Q3bHni/czsPpL0fXLTBuIl7NVRrT8
         bMqo9YyGwvSXmlR2TAG2WQNhKQt+MaevLaWZVfcqL4vVwIF1KP3R3BIOAPlNuCM/rYyd
         ZbzEfZJ2KKS6zFD8aFR/MEOCDlDti1jAXBfLcBLonYyE4kyx1/nkqha77MedwCcjUl62
         ukCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769781379; x=1770386179;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nHaCd4HrbYw78ScpRIoaj6AeaBJaVtnx8urFDLScj1Y=;
        b=GD6g57g6/+1fEABE6YLE0u6OA7aV9or307nppjEhVJe+uZF5i2XxI4Wii7lzaKPyj8
         fjaRPlD8NbmoC/J4Mev83S+om9pJJRed74FMVyAIqYJQ9MFr0E+sczP+BEmo9h8E79gQ
         FFGCH8G8s5O1YpRdUoGeCMkmy+k4mr8rmF+hNF6Z2J6Z19ITgLfMHvV9cnLajgIEU/js
         J0q0U6ANlicevXdqBT8XIKWXQn6xn2yfiO0xeP0jjsqvOPf2afluUQ+kwaahG2L7CYIb
         1dd8ThSgo7Nk+/v9OpJUPWhaBIMkFwS6VL47TaJxHWAUYgA7rAyIk5ILhB5h8S8YySzk
         4kKA==
X-Forwarded-Encrypted: i=1; AJvYcCXqQSO5s3QhefSJhk0ra9bkte+aE7I8Mhebv8Daj9Ws/38ZOsmsRxJOoSDW7AYEWM+sJCXEhNbae/bYYJjAlA==@lists.linux.dev
X-Gm-Message-State: AOJu0Yx4ZbfjcLhuY67tlak/lX3LmuFLF56RgdVUOODZDOIeMSyUzXQc
	yJkT82OJNKxBejmzYkqkASyKF/r8PJXyJm6+WdbubJ1Hx0ACq7e6zyCFrFgfiYRRum4=
X-Gm-Gg: AZuq6aLeUkVrPtSQ8vT8r2uwRbLDAAnRJXmdO9D9YWbQyyBaExa/tJsW1c22RRdG71F
	yf+x9DNUYjMhQP6lFJQlpx1tf88kux4onZ7fQOqb9ZSZG8N54aprBoJZkK2Sfx/YquaZyz48k8b
	EgvO3DbMQNGFxQzvlCnaYyieAI4c+O5w1LxVl9A2xJGshMb+4sxHqfwryc7bSNhxXwGOL3wiieS
	7WDgBrTsB72qUYk9fVvF4+u7nF/YwodUKYnUomWDqiVPlK+0H2zr56Un+pMnHNhdyBQOPrgSHe8
	yqu5BHn6RGeipuWTgJH5IAMDjha9u2RSvHut9ys4LxvYSy6rj1KiVI1TyFIVmcqt+ucKHmIOEtr
	N+ZiI9nBzA64q7baU9OygtITMyzTQxPP9iH6h2qN7hGe4e82IXhvpw0O1hRgRItMYaAjsUSQpTQ
	RPg7LtsW4yKx2Mky6heWwB5LXJujFaIOibS42NW06Ao59S/8vVSiVHqb+uPPRuveE8HjfpRJKFL
	0ysEQ==
X-Received: by 2002:a05:6214:2a48:b0:88a:529a:a53a with SMTP id 6a1803df08f44-894ea09691emr43666386d6.51.1769781379597;
        Fri, 30 Jan 2026 05:56:19 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-162-112-119.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.112.119])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-894d376da66sm59670316d6.50.2026.01.30.05.56.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Jan 2026 05:56:19 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1vloyw-0000000AmRb-29H1;
	Fri, 30 Jan 2026 09:56:18 -0400
Date: Fri, 30 Jan 2026 09:56:18 -0400
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
Subject: Re: [PATCH v5 4/8] vfio: Wait for dma-buf invalidation to complete
Message-ID: <20260130135618.GC2328995@ziepe.ca>
References: <20260124-dmabuf-revoke-v5-0-f98fca917e96@nvidia.com>
 <20260124-dmabuf-revoke-v5-4-f98fca917e96@nvidia.com>
 <31872c87-5cba-4081-8196-72cc839c6122@amd.com>
 <20260130130131.GO10992@unreal>
 <d25bead8-8372-4791-a741-3371342f4698@amd.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d25bead8-8372-4791-a741-3371342f4698@amd.com>

On Fri, Jan 30, 2026 at 02:21:08PM +0100, Christian König wrote:

> That would work for me.
> 
> Question is if you really want to do it this way? See usually
> exporters try to avoid blocking such functions.

Yes, it has to be this way, revoke is a synchronous user space
triggered operation around things like FLR or device close. We can't
defer it into some background operation like pm.

> >>>  		}
> >>>  		fput(priv->dmabuf->file);
> >>
> >> This is also extremely questionable. Why doesn't the dmabuf have
> >> a reference while on the linked list?

If we hold a refcount while on the list then the FD can never be
closed.

There is locking protecting the list so that it is safe and close
continues to work right.

Jason
