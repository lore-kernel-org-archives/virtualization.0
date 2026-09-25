Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48F2542254A;
	Fri, 25 Sep 2026 05:30:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790314233; cv=none; b=EhaQQ4/+aknpAbFzkhHkGugWJ3+74OM1aTFjxzsi8FlOPtMOgznuYDlGtdVlzlMHCF76yxHn7NRoNV++7onipE5WjXoEMTDeA++bkwsJPNlGwecT7NwwMFd+5urQzAfqD0JSmp5zEH1Zr2PPPXLgBN4WIBKIAsusUBBNx4dPhgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790314233; c=relaxed/simple;
	bh=Vm6y+kb6d3AAicaKw5V1YqyzTIfFAOWsPoeWj0Za46M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tiGMetAHpbrXHWxFe4zR+l7HtwfQ9cJdjorQYUWmDt2Ct6QD6SRyEFmH9wf3SOXP6QyVrQRoFhTZ0yMOQWrDQq4hsDMhdrchTMoTUBAXrod4q7Cdz4I+IwsCYUgUsf1PYQA9y3ttJh4ZecCwZbX25cdIsfICUskYIM2Kbdp7JWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ymvcJ1o3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ymvcJ1o3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A61A31F000FF;
	Fri, 25 Sep 2026 05:30:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1790314232;
	bh=fsmfaAlwomBG7ZWIcRIUtE2yiIAyNCmMx2YuHDSU5dw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ymvcJ1o3M+Jc9bm3fuvrUUOillZujQZ/L9jbW0oNuQucAJ3kcv78m2M3H6DeMLlmX
	 fbzXKpJOtmck9yiGKvQAh5I0Nm6b9YaDQ+Nynqq1GHdZlUqUAi8p9R+zB3lE5ZzPgA
	 fARkEIp4hAynU8mB5j2Pdzm7fX7YK/KD9a7DVXpI=
Date: Fri, 25 Sep 2026 07:21:39 +0200
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
Message-ID: <2026092509-slightly-driver-1b18@gregkh>
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
> +/* VIRTIO_USB_EVT_HOST_PORT_CONNECTED/DISCONNECTED */
> +enum {
> +	VIRTIO_USB_SPEED_UNKNOWN = 0,
> +	VIRTIO_USB_SPEED_LOW,
> +	VIRTIO_USB_SPEED_FULL, /* usb 1.1 */
> +	VIRTIO_USB_SPEED_HIGH, /* usb 2.0 */
> +	VIRTIO_USB_SPEED_WIRELESS, /* wireless (usb 2.5) */
> +	VIRTIO_USB_USB_SPEED_SUPER, /* usb 3.0 */
> +	VIRTIO_USB_SPEED_SUPER_PLUS, /* usb 3.1 */

Please enumerate all of your enums with explicit values as these are
going to userspace.

> +};
> +
> +struct virtio_usb_host_port_event {
> +	__le32 code; /* VIRTIO_USB_EVT_HOST_PORT_XXX */
> +	__le32 port_id;
> +	__le32 speed; /* VIRTIO_USB_SPEED_XXX */
> +	__le32 padding;

All of your padding fields MUST be verified to only be set to 0.

These are basic "how to write a uapi" things, did you all not read the
in-kernel documentation for this?

thanks,

greg k-h
