Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65C173BCD0D;
	Tue, 29 Sep 2026 16:02:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790697723; cv=none; b=dDoIn3FFSydltc5Jw0omYBj9WBwOWLHWpue3HICJEokfsAwC7iHqNHQSG92jj+pE1mX7fncP6UAIcr+QiY0Zu3Bbff5s4qx1CeyNDTSgJh5nfiDW9+S1hdosqP/0xP82EFogCiKRM8AuFIKJcn2fS5N/6RIgPWgITqVYGKl4kzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790697723; c=relaxed/simple;
	bh=3fv7fkaoLvHp2VLVhRj2pgwoEo2C1n1SFtSo/Cqy5Ek=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HAWXaa0yLwfg4H/OoA0vQhhHwOZh7oLqIgQMulZfCxJC+ngOwGxRzbhLPazcVUoSS1ZZ27ZmbxcQk22GRuQBWVD0PpuyWz/WKHWBIMQaHvvMHdWoNPa3M51pIJ3+zE+fFVmF8p7XtF4G8CPXzJF7bo/sKrm1t/FsBy+gHD23vrs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=WvK98MWj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="WvK98MWj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60AF91F00893;
	Tue, 29 Sep 2026 16:02:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1790697721;
	bh=6mkMAQIe+ZCaZzPQhjhseYlT8XNhqWGisHlzgXRyNZo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=WvK98MWjQ+xBslUJx2dhwOhZtn7yoQqVyKP3OZktPgTkq1i+ky3fidLvcnKNm8EYP
	 WV4eBXIBK9YiBpst1HHJQaImU/Lb+/nUj7BLZYBFxvaURxDDoPW9BRBMHdxcCwL4mg
	 b2+PKJcOeua9HAq1POO9OIm9LY52V3EmXMtGzlds=
Date: Tue, 29 Sep 2026 18:01:57 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Igor Skalkin <igor.skalkin@oss.qualcomm.com>,
	Jason Wang <jasowangio@gmail.com>, virtualization@lists.linux.dev,
	linux-usb@vger.kernel.org,
	Vasilii Ianikeev <vasilii.ianikeev@oss.qualcomm.com>,
	Aiswarya Cyriac <aiswarya.cyriac@oss.qualcomm.com>,
	Anton Yakovlev <anton.yakovlev@oss.qualcomm.com>,
	Trilok Soni <trilok.soni@oss.qualcomm.com>
Subject: Re: [PATCH 0/8] virtio-usb: add dual-role virtio USB driver
Message-ID: <2026092928-borough-tried-1ea7@gregkh>
References: <20260924160907.145405-1-igor.skalkin@oss.qualcomm.com>
 <2026092520-aerosol-brim-22d1@gregkh>
 <1149e188-7279-4c60-bd96-f8d75d721ae0@oss.qualcomm.com>
 <20260929054346-mutt-send-email-mst@kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260929054346-mutt-send-email-mst@kernel.org>

On Tue, Sep 29, 2026 at 05:47:30AM -0400, Michael S. Tsirkin wrote:
> On Mon, Sep 28, 2026 at 03:55:38PM +0200, Igor Skalkin wrote:
> > >>
> > >>   [RFC PATCH v2] virtio-usb: Add initial virtio-usb specification
> > >>   Igor Skalkin <igor.skalkin@oss.qualcomm.com>
> > >>   virtio-comment@lists.linux.dev
> > >>   https://lore.kernel.org/virtio-comment/20260924154007.143927-1-igor.skalkin@oss.qualcomm.com/
> > >>
> > >> This driver has been tested end-to-end against our own userspace
> > >> virtio-usb device implementation (host-side backend) in two setups:
> > > 
> > > Where is that code and why isn't it part of this submission?
> > > 
> > The backend we used for the testing described above is an internal
> > implementation that we're not releasing as part of this submission - it
> > integrates with some systems that aren't ready to be public. We
> > recognize that limits independent verification of our specific test
> > results, and we don't think that's an ideal situation.
> 
> Supporting vhost-user with a backend doing pass-through shouldn't be too hard.

Wait, if all you want is adb to work, why not just use it in network
mode?  That should work find across a virtual machine, right?

thanks,

greg k-h
