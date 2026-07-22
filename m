Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDBE13E7BCF;
	Wed, 22 Jul 2026 21:42:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784756546; cv=none; b=HkW25qfah7TFaoECOX8IxVMqQgJluR0PnHUhQ8PNyTFS6w0Y37yhWwq4cDnQKXfbqk7F/Gkp0nC3h3OZxFP3pHhjD96KUnDhugR90qL+pazzXc4GfSGFWzw1YSQahjhdlFVO8KF/3V0wkc3+ImSX1HiStpyYEH2pk6Q98USKiB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784756546; c=relaxed/simple;
	bh=I+wmfNKmB3DrhY1Q33W8hC23I48GMX5dwejjapOVdPw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fcO4eZXjg91ufZxop2ViGSy4ehBTsQQg0p1JpGPpDqY+5f2kPqFrEZvK/HefL0uvWNxCuaBmcnbRgDtOAABgQjHUcoZDmaIomEowCYuh9NyFKcIPgsr03B+zTjDYebzqXuXWavCUeFcj4g4gjAriTPQSBbo7h+f4HwtIZr3dP00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WeE+7xNq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WeE+7xNq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 655F31F000E9;
	Wed, 22 Jul 2026 21:42:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784756544;
	bh=kL3wgzhg+dhGzM1PKnXiRppSahOyzEVgFoSgao9WTjo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=WeE+7xNqZuBNKtL+FoQtbFhCjlr26zFyNwDRjxHXlpAbgXKuDdL33a0cQ9nYLqshr
	 lBaaNeWf/6DrYXUX0zmGfiKVRFxL2XFT+QPdNI2syMY8AS3HKUBXO/Ry0AYnonx6Cb
	 ygonTs42ZqwUZRf9sHrFkH37Ymk8/K6ZKLEyBWiSCBwxEvgTNkLWT+xpA5MFAAubJj
	 mhHw2BAjjwzzCE9529mGI9GPFshfZe3yUomTLCHy160qFIdpyR8kUWrMBXC9QAO5dt
	 gg+CE3ehVJ6Hwss7ENu3p3oiCX0kPUCmw1Wwqnuvaq2BAC7XO6GO8doowq61Ea8y9n
	 i8ORqfY3s18qw==
Date: Wed, 22 Jul 2026 22:42:20 +0100
From: Will Deacon <will@kernel.org>
To: Weimin Xiong <xiongwm2026@163.com>
Cc: virtualization@lists.linux.dev, iommu@lists.linux.dev, jpb@kernel.org,
	joro@8bytes.org, robin.murphy@arm.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iommu/virtio: Handle iommu_device_register() failures
Message-ID: <amE5PCkhwq84-_6g@willie-the-truck>
References: <20260716012157.88769-1-xiongwm2026@163.com>
 <20260716012157.88769-2-xiongwm2026@163.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260716012157.88769-2-xiongwm2026@163.com>

On Thu, Jul 16, 2026 at 09:21:57AM +0800, Weimin Xiong wrote:
> From: Xiong Weimin <xiongweimin@kylinos.cn>
> 
> iommu_device_register() returns an error when the IOMMU core fails to
> register the hardware instance or probe the buses. viommu_probe()
> currently ignores that error and continues as if the device was
> registered successfully.
> 
> Propagate the failure and unwind the sysfs entry and virtqueues that
> were set up earlier. Clear the driver data on the error path as well,
> since it is set before registration so bus probing can find the
> virtio-IOMMU instance.
> 
> Signed-off-by: Xiong Weimin <xiongweimin@kylinos.cn>
> ---
>  drivers/iommu/virtio-iommu.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)

It's really hard to keep track of all the patches you have on the list.

Some of them are grouped in a series [1] with a dependency on another
unmerged patch, others are in-reply to unordered patches [2], nothing is
versioned and there are unlinked reply-to messages asking us to ignore
things [3].

Please can you group all related changes into a series, with a cover
letter and then use versioning so that it's clear which is the latest
revision?

As an aside, Sashiko has lots of comments about the error handling in
the virtio IOMMU probe:

https://sashiko.dev/#/patchset/20260716012157.88769-2-xiongwm2026@163.com

Will

[1] https://lore.kernel.org/all/20260714025914.193580-1-15927021679@163.com/
[2] https://lore.kernel.org/all/20260716012157.88769-2-xiongwm2026@163.com/
[3] https://lore.kernel.org/all/20260716012513.89178-1-xiongwm2026@163.com/
