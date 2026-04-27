Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E6D22F12AC;
	Mon, 27 Apr 2026 15:02:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777302123; cv=none; b=rYioFoI1Vw3JeFt6fI26YcFxgfOzoYakcUgse2HG8xv38lj2V0rTwVSFJ0GM29+aYoMe03DJq6bxdpqsDdeR5nP8nI2AkSuNaKh88g0qqoisEQwrLoITCJJ/+FWAI2/fEHUZcoh6REFGEaVo+j/v0wnPBaDEONTjNhE58NJCW50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777302123; c=relaxed/simple;
	bh=RmGS7PElg22weDoba6HQeduCjm48+E50PAaNKfbtK7M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Vl4y7RofEuQCbNfoq31M3AiYUnpmH/Fa9e0jM5Lf4ztUzbsdfkTPLcxOBqxHE5EALZbOxFtCzlSLQJ6C4BTOpDdex4lxd/Y8o0piR4wPXEifXporHUVQ2mYtUSP7DrjwcYY36Ld0iJvhhRCD2gK/Yj8dksA6fmjL7CsVdGzcUJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TQsBv7/M; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TQsBv7/M"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8B50C19425;
	Mon, 27 Apr 2026 15:02:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777302123;
	bh=RmGS7PElg22weDoba6HQeduCjm48+E50PAaNKfbtK7M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TQsBv7/MASQ3oMBj7R4dq6IvR8LI8u80pPAcSAeivjNs3OvgO4uoMtGN9Q43vUQUp
	 QBLyaeOFEFZipX5GEIL9rAZbodnSWhw8e4rHAuE+kuOvdMEJQNweQ9FNoKMC6gBTvN
	 xbIvLjdje4MZR6YzdUjOVJ/WJ3unheeqFoUyoFafONYGq9BNIq0xEWZOwbMWTX8IUC
	 BMCnm7pD2mpna58DTLuQr6jzhGDchZWqufqi8RE1uoX14IsyCpZwhw5BxCmhI7GJPo
	 GnYmcg6Vy6aHsV+iGeLyIvHfF4O11CYE8CwWep+QYJTQWs3ra2L82c/lVa5T+mYnWI
	 yiJG7Nw0Y9W9g==
Received: from johan by theta with local (Exim 4.99.1)
	(envelope-from <johan@kernel.org>)
	id 1wHNTC-000000004PS-3Tud;
	Mon, 27 Apr 2026 17:01:58 +0200
Date: Mon, 27 Apr 2026 17:01:58 +0200
From: Johan Hovold <johan@kernel.org>
To: Jason Wang <jasowang@redhat.com>
Cc: "Michael S . Tsirkin" <mst@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org, Pawel Moll <pawel.moll@arm.com>
Subject: Re: [PATCH] virtio-mmio: fix device release warning on module unload
Message-ID: <ae96Zsike81dBxTS@hovoldconsulting.com>
References: <20260424104820.2619227-1-johan@kernel.org>
 <CACGkMEvJ4CZt9mVhn5TRCz5yCYzY_yHNFh8pbT4hOmJoWDiKOA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACGkMEvJ4CZt9mVhn5TRCz5yCYzY_yHNFh8pbT4hOmJoWDiKOA@mail.gmail.com>

On Mon, Apr 27, 2026 at 12:16:47PM +0800, Jason Wang wrote:
> On Fri, Apr 24, 2026 at 6:48 PM Johan Hovold <johan@kernel.org> wrote:
> >
> > Driver core expects devices to be allocated dynamically and complains
> > loudly when a device that lacks a release function is freed.
> >
> > Use __root_device_register() to allocate and register the root device
> > instead of open coding using a static device.

> > -static struct device vm_cmdline_parent = {
> > -       .init_name = "virtio-mmio-cmdline",
> > -};
> > +static struct device *vm_cmdline_parent;
> 
> vm_cmdline_get() is the .get callback for the device module parameter.
> It is invoked when userspace reads
> /sys/module/virtio_mmio/parameters/device. This function uses
> vm_cmdline_parent unconditionally, without checking whether the device
> has been registered. This would cause NULL pointer dereference.

Indeed, Sashiko flagged this as well. Just sent a v2 here:

	https://lore.kernel.org/r/20260427143710.14702-1-johan@kernel.org

Johan
