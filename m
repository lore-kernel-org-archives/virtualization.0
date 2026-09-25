Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E632F43B6C1;
	Fri, 25 Sep 2026 05:30:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790314225; cv=none; b=VwT9kTDU15QFWhMlTDGQswmJ6Br/MzShch75OPszM+PBN6BN602lQnc6P1DXk/fBIyanGLzJco2Hk5nZOAmg/KyY4JYI/G4FEQw/KlhJYpoLOfyM88IMHJG3UXoh+s8K3ekpBexbITFUPw794KO0uYAdiss0Tg2YYSQZWxZMtuw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790314225; c=relaxed/simple;
	bh=fDgOahO/A/EbHiIZOfgUHkJ2oYdnog6hVanThi59N+E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eHz5puPOgdcx0qPaXnIS4kcsqsez5Ey4bZuuT09LLIQxROz9cwyRc5POUBW5OZV94Yy6+Huo1YvKY+9Rgkj5cR0vC6ixJ4thwsYNUG14hheeYHrMDXwD6olW6pXQ5Ok3DnyKZaGFdWrlhRavlihayXNtd2SFFGggZjeMUv5+NNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=P/lefAuK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="P/lefAuK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 184C81F000FF;
	Fri, 25 Sep 2026 05:30:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1790314223;
	bh=RnWHYl02BB8v+ezbhuX60mFEti5SfTkQILA/roLAwJw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=P/lefAuK4d1oIizhAZ9FeEEYD8i+WjJ3uCrUggzoM0A+ZGpzH/vwG2coCZV0f4QqQ
	 f+MDjIjY2pTysHeXofmAmph0yt7Tj9EJFewGRW+Kcnv0LjabdG/6DSy5+ggKc0kPhY
	 a/VwL532N0VwaTJxzbXm75vfZcQ3nEEei9iejgsA=
Date: Fri, 25 Sep 2026 07:14:11 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Igor Skalkin <igor.skalkin@oss.qualcomm.com>
Cc: "Michael S . Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowangio@gmail.com>, virtualization@lists.linux.dev,
	linux-usb@vger.kernel.org,
	Vasilii Ianikeev <vasilii.ianikeev@oss.qualcomm.com>,
	Aiswarya Cyriac <aiswarya.cyriac@oss.qualcomm.com>,
	Anton Yakovlev <anton.yakovlev@oss.qualcomm.com>,
	Trilok Soni <trilok.soni@oss.qualcomm.com>
Subject: Re: [PATCH 1/8] virtio-usb: add protocol header and skeleton
 dual-role driver
Message-ID: <2026092557-condiment-surviving-ec8f@gregkh>
References: <20260924160907.145405-1-igor.skalkin@oss.qualcomm.com>
 <20260924160907.145405-2-igor.skalkin@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260924160907.145405-2-igor.skalkin@oss.qualcomm.com>

On Thu, Sep 24, 2026 at 06:09:00PM +0200, Igor Skalkin wrote:
> From: Aiswarya Cyriac <aiswarya.cyriac@oss.qualcomm.com>
> 
> Add the virtio_usb device and virtqueue-wrapper skeleton, the
> protocol header shared with the vhost gadget driver and userspace
> backend, and probe()/remove() plumbing with no role support yet.
> 
> Introduce a per-port virtio_usb_port array (vports[]), sized to the
> device's negotiated port count, ahead of any code that actually
> populates or reads it. Every later commit that adds a role to a port
> (host, device, OTG) builds on this same array from the start, instead
> of the host, device, and OTG subsystems each growing their own
> separate port-indexed storage that later has to be reconciled.
> 
> Wire the new drivers/usb/virtio_usb/ directory into the USB
> subsystem's build (drivers/usb/Kconfig, drivers/usb/Makefile) as a
> new CONFIG_USB_VIRTIO option, listed alongside the other USB
> dual-mode controller drivers.
> 
> Signed-off-by: Igor Skalkin <igor.skalkin@oss.qualcomm.com>

Why does this not match the author name?

thanks,

greg k-h
