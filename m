Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 978B52367D9
	for <virtualization@lists.linux.dev>; Fri, 30 Jan 2026 00:17:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769732235; cv=none; b=TgxbS80FwEYKtOFxXxoYhDuFo01LNJNnx9qplGFmYV1iQ8lWwDDEJV9r0SQgMGpqXpK6q5ZtTS0O4iIUL14PMpIF2pS7B9sBIL5n40Pp3VkMwH06qvSJHBk50ep3zzf0TWKjPSxc0BCXXZ5HK3eyDJEiBL35FilbOlVfb+Wo8Yc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769732235; c=relaxed/simple;
	bh=PgxWXxtJeqUdvgjP5KxrfenUWVrCXmnl/Ip3hY3gzr0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UvouIQ6g2kNqLIb6fj22eqAXXiMl8jRN2qyTq0PNtyNrQXsiqLHqVEpWewkYWNdZohX+Slf3sP7VE2sNIwyY91xiI08jHhoDKvW6KXM+uZVIGu0S4Rw60lApI1L1JtXiYf/mECaf/zZZt+Ht+FrJZxaqCdk0bQl/gl5f4Nu0wdE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=H0gg8EBt; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="H0gg8EBt"
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-50146483bf9so16970461cf.3
        for <virtualization@lists.linux.dev>; Thu, 29 Jan 2026 16:17:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1769732232; x=1770337032; darn=lists.linux.dev;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=JQnCcQDZjp9U0R1Q7JCyNDeekOxxS8phMo1p2crcsis=;
        b=H0gg8EBtPMqKEknAuFR0p4aWl8eOqMRb8JU0ZEmmQKX3QI58fYfis1Cws/2r7bCqSt
         KmTt4Zk3BevOEr0dNXM+F0wRCSpfCEtAaLHfTeQYaUcy4rb/V9Wgg4ohcP4l+oHs5v8i
         QWkVVWJhd1AMQBVc7wr1UoFPpZo8WorQQTv+Gn7Wt9HEilZMX7rfTfqz8DXdU2dMhwMw
         8rtUMs3JFrk9PG6HIevEk6brIVwznppFk7A40p8jaCQi+jAu/kzaRE3BwjrBYr8ezCye
         Irl7Uyd9nK2tA91yaYSpR1uPrzmJLPkFZJfQqoEMzvT/kALn2UOBsp5IfxRtMr1GRe19
         cdkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769732232; x=1770337032;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JQnCcQDZjp9U0R1Q7JCyNDeekOxxS8phMo1p2crcsis=;
        b=a/vgXlrbHrFZt6uv/DmLeW8VenT3GS2VkzgIx8B3mEcKcZCkpkC3M3nDj2v4fGvoG5
         CIb1GWqEiuvlhjsq5lrTtDJF3cBEkPRD2H9ZmBc0iZ4T1Hwdc4addCaGyKz9QqBU9Bzj
         0q9cfJOx0YuYrzyC0d6jP7CkByV4KNqyDfq9h/LwtaTJgSS7AgXWuBcZe66XkDWOLCNe
         1FME5a1yt6pTSUtjvg6CycNVH0uvd4WUjAYco1yK78rS4CWRoTSDY6pmq+Hm/D4ljYwU
         OykYLlgnNYoaHfjgJEfZ02ROd7qWb9j72WrDu623vR+qFjxKsd+duiuIjKNaSr+tr58W
         Oj2A==
X-Forwarded-Encrypted: i=1; AJvYcCUh/OdyWAGFGNWomisJrGiu52Cgx4lAKKWYprfNBhwBXDWI4Z4GlCwZLFCb8FD3wPe7ATiu5raDOYlIv2QUwA==@lists.linux.dev
X-Gm-Message-State: AOJu0Yz11OsZKTYx85WtorRcuZLGH1WSIfOofYZ2oZ5pVlztXMJIvlAs
	lsQgZcoxAl1uNcPTcGlohqhzdQV/0H27RJiiK6J2wQCccuPAx2E7Ky8tVebtzu7l3kk=
X-Gm-Gg: AZuq6aJY2WdjKASkBsmx9trQQbnm20J6Sehqeq/JrUuxc0vvn4v3W9Pw4KmS3dY8aDN
	/WrK2Q9hbqUgXuLdKeZbxGNzhobrb6NlUrnbvuey7FJ59IOcsGHIPetnyNsOJvwFlpIcPzTT9at
	MCssZB3zoitJcJo0bkomjRbI05Gbr7kT1EppRtNSnEDA7D+ew1LebRsopscapgu+F4jvgQO146/
	wfLTgIuXatwBIQIb6dkRv+X2sHGS/c2cCR/daeClBWnr9UAHupeJnv2Mes9YLdVoaNTEeJ1z9Xh
	padhPS8cXHQfZb2pKLpMWYnV8R2bGAlYAf/YDU7kYvP6g8gyP+friDgNXMFxaxDhNbxPWHXUPHq
	U63keZwrePZoHTSrJ9JvqfyBesWXfM/FoM0+X8PjR4RsyoxZ6ylAzCTnRZeHXXz1GaRe93OcfvW
	cmrLg7vSNi8AdAUdI1ESWixBDwAIUquiPSHEvmEgWPD5Arru/CgbpRYd5wwHvfjz3LIUTqU0B1K
	fg5CA==
X-Received: by 2002:ac8:5781:0:b0:4f3:5f7b:cc1d with SMTP id d75a77b69052e-505d21846b4mr19549181cf.34.1769732232444;
        Thu, 29 Jan 2026 16:17:12 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-162-112-119.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.112.119])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-50337cc19d7sm45008611cf.35.2026.01.29.16.17.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Jan 2026 16:17:11 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1vlcCE-0000000AQZD-13C4;
	Thu, 29 Jan 2026 20:17:10 -0400
Date: Thu, 29 Jan 2026 20:17:10 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Leon Romanovsky <leon@kernel.org>
Cc: Sumit Semwal <sumit.semwal@linaro.org>,
	Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>,
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
Subject: Re: [PATCH v5 8/8] iommufd: Add dma_buf_pin()
Message-ID: <20260130001710.GB2328995@ziepe.ca>
References: <20260124-dmabuf-revoke-v5-0-f98fca917e96@nvidia.com>
 <20260124-dmabuf-revoke-v5-8-f98fca917e96@nvidia.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260124-dmabuf-revoke-v5-8-f98fca917e96@nvidia.com>

On Sat, Jan 24, 2026 at 09:14:20PM +0200, Leon Romanovsky wrote:
> From: Leon Romanovsky <leonro@nvidia.com>
> 
> IOMMUFD relies on a private protocol with VFIO, and this always operated
> in pinned mode.
> 
> Now that VFIO can support pinned importers update IOMMUFD to invoke the
> normal dma-buf flow to request pin.
> 
> This isn't enough to allow IOMMUFD to work with other exporters, it still
> needs a way to get the physical address list which is another series.
> 
> IOMMUFD supports the defined revoke semantics. It immediately stops and
> fences access to the memory inside it's invalidate_mappings() callback,
> and it currently doesn't use scatterlists so doesn't call map/unmap at
> all.
> 
> It is expected that a future revision can synchronously call unmap from
> the move_notify callback as well.
> 
> Acked-by: Christian König <christian.koenig@amd.com>
> Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
> ---
>  drivers/iommu/iommufd/pages.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason
