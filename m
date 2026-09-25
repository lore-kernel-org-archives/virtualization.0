Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB78D3403F4;
	Fri, 25 Sep 2026 05:30:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790314227; cv=none; b=SLzUnBhSa2nffmXHgQ+4eaAk+gedUDwzJtQaLMadmJE5J0+4EQtKUtSsBjO+QYwpSgpfH+GHXOs0N38+Qg5Slrdo5qc/gmMN4COe6KVISRuEz61dvZjE2ac2t0LDUx2b1hpb9tthyNkoT2PLm5cnBWQHQlQ/3gi/D86Djaa+CFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790314227; c=relaxed/simple;
	bh=BEyFt2kX6vUm6wIKNCxwnG4wQCyOH8PIQWMbkM+amU8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cAJicgyyvo2EcFBdRUnTK+GqVwhjBf9zFF9OxOIp/YFLmVjfR31gSjoQfBMJD+V8Rh9C6CdzhNai1CkxvFpL21bfo4DMVtNy79D4p0h+DGVxt7wEJretTlKLXFhDNlSaFk2rg+HuDu5s82T4S+mIBRzLq6mUmsbvzc0HC0SqsXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=RSXgdkpy; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="RSXgdkpy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DDC331F000FF;
	Fri, 25 Sep 2026 05:30:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1790314226;
	bh=4umcq4ejWoWKa2eK79QEKitceloddRpxYZ2bgbOiWzw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=RSXgdkpyIXgy5k1l0jNs+LWFDXEhXgRnFE0Cu4Uh8sQgMiOWEHXB3v467VIZULY75
	 Kje+M64EeznjgP6oP6KkiHzm8EdpgORpbgzR583wFwJ/RyBrVgovP78kFcKqXnR0f9
	 uygKVx2BZeDDnzmSPPu9i5NKM27dYFmoOPGKo1FA=
Date: Fri, 25 Sep 2026 07:17:13 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Igor Skalkin <igor.skalkin@oss.qualcomm.com>
Cc: "Michael S . Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowangio@gmail.com>, virtualization@lists.linux.dev,
	linux-usb@vger.kernel.org,
	Vasilii Ianikeev <vasilii.ianikeev@oss.qualcomm.com>,
	Aiswarya Cyriac <aiswarya.cyriac@oss.qualcomm.com>,
	Anton Yakovlev <anton.yakovlev@oss.qualcomm.com>,
	Trilok Soni <trilok.soni@oss.qualcomm.com>
Subject: Re: [PATCH 0/8] virtio-usb: add dual-role virtio USB driver
Message-ID: <2026092520-aerosol-brim-22d1@gregkh>
References: <20260924160907.145405-1-igor.skalkin@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260924160907.145405-1-igor.skalkin@oss.qualcomm.com>

On Thu, Sep 24, 2026 at 06:08:59PM +0200, Igor Skalkin wrote:
> This series adds a new virtio-usb driver: a dual-role virtio device
> capable of acting as a USB host controller, a USB device controller,
> or both simultaneously with runtime role switching between the two
> (USB OTG-style role switching) on ports that support it.
> 
> The corresponding virtio-usb device specification has been posted to
> virtio-comment for review. This series matches the v2 revision of
> that spec, which reconciles a small number of protocol details
> (per-role virtqueue presentation, host-role vp_idx for hub/multi-VP
> support, and the device-role BIND/UNBIND event split) that were
> clarified while integrating and testing this driver against the
> spec:

Why do we need this at all when we have other ways of doing usb devices
through virtio?

Why is a USB virtio spec needed at all, who is going to use it?


> 
>   [RFC PATCH v2] virtio-usb: Add initial virtio-usb specification
>   Igor Skalkin <igor.skalkin@oss.qualcomm.com>
>   virtio-comment@lists.linux.dev
>   https://lore.kernel.org/virtio-comment/20260924154007.143927-1-igor.skalkin@oss.qualcomm.com/
> 
> This driver has been tested end-to-end against our own userspace
> virtio-usb device implementation (host-side backend) in two setups:

Where is that code and why isn't it part of this submission?

>   4-5: USB OTG-style role query and role-switching support.

There's a reason OTG isn't used anymore by devices, how have you
addressed those problems here?  And why duplicate the failures of the
past?

>   6:   endpoint-lifecycle robustness rework (async split-phase state
>        machine, replacing an earlier out-of-tree gadget.nonatomic
>        patch that didn't pass upstream review).
>   7:   SuperSpeed device-role support.

Why should speed settings matter to a virtual connection?

thanks,

greg k-h
