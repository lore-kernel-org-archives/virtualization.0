Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3BB1431A46;
	Thu, 16 Jul 2026 14:35:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784212543; cv=none; b=qFa4rEIAjrdscYRa2SiGZHd7CxHHTOkgxo7iDNZbk+B+oqOg7ZL/MoDJIIg0OiLFPS4dIs+cLrg2q6lZWViD/GOFl3qQNfbJ95UKGw5fwYKu9k3RdkFjx5AJzfCtvoQQvXuKzjYi2dXS7xMj2V4lg7yKOLhbTJe3jtpRTw81/PM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784212543; c=relaxed/simple;
	bh=KBGhPkLlPUjiawF9CSqhyo0XELNsvW0WJDM/kR3y9c8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FT+nBx7jwuIq0bOkpj9TAax4wfU0+Hs+pPfFPcncvHkQKntm1RwhW0PJddhTdQkYvRGRvSR9ga5tmpn7NOj74hXAyDOn9TQ+QZQM1yT8khs958E+gRKtuJrxaVwZtyiUsfZBU5jQuDFDiO675V/do/YgWc1ECsQAg/RrxDZ+7wQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=xBkXsUzw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="xBkXsUzw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13A8C1F000E9;
	Thu, 16 Jul 2026 14:35:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1784212542;
	bh=VAQI5/bP6cE81OnZxY1uvO/hzXk+oznZOdYA2ZXQnkc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=xBkXsUzw8I2RZYHgqjpqnBovCCZ/6o0m866rQPB5M1eDjfNFqoDtLV30WxGdnABUm
	 JSqsTVZ8f00BCCXnfN/rOr15wLpadxHWtp94Gnj2/+rJ+6ubXo14FLnHw/2BsLIehv
	 0WZF15ug+tto9in4vhRyA5g1NooQg7GV99L/y/R4=
Date: Thu, 16 Jul 2026 16:18:17 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: Hari Mishal <harimishal1@gmail.com>,
	"Michael S . Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowangio@gmail.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/4] virtio-mem: validate device-reported block size
Message-ID: <2026071635-relive-flogging-2a81@gregkh>
References: <20260715142337.22811-2-harimishal1@gmail.com>
 <20260715164139.40957-1-harimishal1@gmail.com>
 <b2176313-b444-4f66-a71c-647b92cc16a8@kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b2176313-b444-4f66-a71c-647b92cc16a8@kernel.org>

On Thu, Jul 16, 2026 at 10:55:42AM +0200, David Hildenbrand (Arm) wrote:
> On 7/15/26 18:41, Hari Mishal wrote:
> > The device_block_size read from the virtio-mem config space is used as a
> > divisor and also in ALIGN_DOWN() further down the code path in the
> > driver without further validation. A zero value leads to a division by
> > zero, and a non-power-of-two value corrupts the ALIGN_DOWN() bitmask
> > arithmetic leading to a misreporting of guest-usable ram, post crash.
> > 
> > Reject both at init time instead of trusting the device.
> > 
> > Signed-off-by: Hari Mishal <harimishal1@gmail.com>
> > ---
> > v2: dropped the redundant explicit zero check, since
> >     is_power_of_2(0) already returns false.
> > 
> >  drivers/virtio/virtio_mem.c | 6 ++++++
> >  1 file changed, 6 insertions(+)
> > 
> > diff --git a/drivers/virtio/virtio_mem.c b/drivers/virtio/virtio_mem.c
> > index 11c441501582..0e04fec458af 100644
> > --- a/drivers/virtio/virtio_mem.c
> > +++ b/drivers/virtio/virtio_mem.c
> > @@ -2847,6 +2847,12 @@ static int virtio_mem_init(struct virtio_mem *vm)
> >  			&vm->plugged_size);
> >  	virtio_cread_le(vm->vdev, struct virtio_mem_config, block_size,
> >  			&vm->device_block_size);
> > +	if (!is_power_of_2(vm->device_block_size)) {
> > +		dev_err(&vm->vdev->dev,
> > +			"invalid device block size: 0x%llx\n",
> > +			(unsigned long long)vm->device_block_size);
> > +		return -EINVAL;
> > +	}
> 
> The spec states "The device MUST set block_size to a power of two."
> 
> I'm missing the point here.

So what happens if we have a non-spec-compliant device?  Shouldn't we be
attempting to verify this before doing something with the data?

Or do we just always trust virtio mem devices explicitly?

thanks,
greg k-h
