Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795631663;
	b=OC7XoLAwxt6ddnhMqgCar2A4Ckx3jjkn0+NGjctwrQKfBN7Xu6CJeBjdC0KKyDFVTbHD
	 bIm0HMhMxjIRWjNiQDvluQcRwg90b25xFH7fF419Jzp3cpqbvm4L9nONFqm8xA/DYMtVN
	 PmCTHWia/mMlXwSmubWU1BrBOrQt4MYyeYBzWQaP+KwQ8xsE7USULkqjvvk5KRpyXmI23
	 CNvRpvQu1uSzugKCVGfzGAOg56TpFMbXfYvhYkVKX0Mw9ZHB3bJXR3PJ4HU/yiB36Yh5Y
	 NiEY1AIQ7uJzZng2Slk0A37eSsPD+CScUQLqfuWDauvtDDmQnn72daZDr1asX0CrwBA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795631663;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=csfdLTJs5WNIS3/yTk4X/ezL7bBBfz9RtBAOvaFYlpc=;
	b=wSsG60iIFSld1WU6w4fmA2qbXfoV7oDvJ+nN9aoLPe0B2yOTk9AWRf7W2vc0nSWN8zqz
	 bbYTmcHrCCDgtALR2hrqxba7wUIF/XQFAWmkw5m6LXgnfJdNWElOXuHcZ6n0RmoNK5Q3o
	 39V8S3QxQNcphPC9ig8QI/Re4TZZaG1pUxGheBx1U+G74UXAV8iZYsnIerz/jCzt537ZB
	 rsX8smwu4kX5pdPdS9XyexubpTABAQliEkj8ks7hjmSGirqToSybSjtmxHDh95iuUUQqB
	 z3qha2g0IPAIO//tCcxHn9IIKcmYKI6mSno7colq5Um8UJo1rwMoeDZH7ptcTCKun7A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VjP3b3Dn;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24871606A31E;
	Wed, 25 Nov 2026 18:34:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VjP3b3Dn
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 628CC1F000CF;
	Wed, 25 Nov 2026 18:34:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795631662;
	bh=csfdLTJs5WNIS3/yTk4X/ezL7bBBfz9RtBAOvaFYlpc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=VjP3b3Dnip+9fyQMC9MhXIqQUUXrOEoFIGwUkKGZOAWeOtQX1C/3ii8eAe3SsOO7J
	 jJRP9D9RWgcz2ICgoATDCZEVSzrqphRZiU01SWe6Sq52V3ZSNJN+no9l4UG3Nejs7o
	 37WOR7H4Xxq8XFVKcRYI3CXeHBgi3ZUj4ntDGM4WuhG213qMMhUM00EIgzj2PzXBwq
	 XcX7iiq+t0rf8o6btZ+bjCq2naJcT0i2ys1wo8iqRHvdr6KA3tPVZ7rqFXpMDXa3HG
	 aTgp5iE/VkyMJJOnb0iulEYERYP+Q7Tk3UzlOtzxbG3T5rFRy3kk9vh8IuS7hvxmgI
	 qlWaYMK3AMNew==
Date: Wed, 25 Nov 2026 18:34:17 +0000
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: "chenglong.ma" <longpareto@gmail.com>, 
	Jason Wang <jasowangio@gmail.com>, Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Xie Yongji <xieyongji@bytedance.com>, 
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] vduse: don't set VM_IO on the domain file mapping
Message-ID: <awcp0JCwWQVLIuPD@gremlin>
References: <20261125160128.796-1-longpareto@gmail.com>
 <awcNt5C6jkZQLy0M@gremlin>
 <20261125130424-mutt-send-email-mst@kernel.org>
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
In-Reply-To: <20261125130424-mutt-send-email-mst@kernel.org>

On Wed, Nov 25, 2026 at 01:05:37PM -0500, Michael S. Tsirkin wrote:
> why cc stable did stable backport the buggy patch?

That patch itself is cc: stable so this will need to be too to propagate it.

--
Cheers, Lorenzo
