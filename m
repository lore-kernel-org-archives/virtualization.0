Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4891B2609DC;
	Fri, 17 Jul 2026 05:04:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784264671; cv=none; b=JK5dnIKIRPyUsc6hUZIYZQyOyK4dMANQL3tg3O517wRWcfdgpo/sLJj0w1lPjqwdy3BIPtKG/ok9c5S7z9Ghp8W0iUHtaSqAw0i+xRNZRE91GZAgoEMwOM89nOZ46z6tT72v47k47yRpqKhfFN5HjXWLF1ts/uKUZ92j31jSRFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784264671; c=relaxed/simple;
	bh=cxdPs20Eu/jhJfQgTq9D5ZvNhHnuWGdOsGV8PHnoC5I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aPmJNKfhSltbaYjGH5t1zZTLm/70i8OJze9IYCHr91AT5GiDrt25E7J30cAtMVfsjRNTQe/nRghH/28K+/Qh0BKwcWMRS92K3XVaQjtvia8nFbVRdrq+mJb5g+IIv8HZ5KS5dh1MgwF9ExKqysXUupFg/AOiUJOmMEDW3wdTk4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=DKU/4MGr; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="DKU/4MGr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 421D41F000E9;
	Fri, 17 Jul 2026 05:04:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1784264669;
	bh=uqMDORnaDkb/GazZKXO/AHenm3CZXjcna9P91ykw3nY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=DKU/4MGrsY+hKg6T5FMZM5LGN7ToXxw7YfujZ2inFssxJMfsnxCef3DreRxx31GaQ
	 iqcmbeHyrHqIA0bh8AfpRmmTfrDutBEGames8D6XB9ohue9TE04BvLC9VR0qfxq+JY
	 VSFHA6XTuUl62EhEKXh975+E4W9SVIMlycH1MjFc=
Date: Fri, 17 Jul 2026 07:03:09 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: Hari Mishal <harimishal1@gmail.com>,
	"Michael S . Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowangio@gmail.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/4] virtio-mem: validate device-reported block size
Message-ID: <2026071700-kitten-contort-cad2@gregkh>
References: <20260715142337.22811-2-harimishal1@gmail.com>
 <20260715164139.40957-1-harimishal1@gmail.com>
 <b2176313-b444-4f66-a71c-647b92cc16a8@kernel.org>
 <2026071635-relive-flogging-2a81@gregkh>
 <4dda47ba-534a-4297-a25e-0d63d9167033@kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4dda47ba-534a-4297-a25e-0d63d9167033@kernel.org>

On Thu, Jul 16, 2026 at 05:59:05PM +0200, David Hildenbrand (Arm) wrote:
> On 7/16/26 16:18, Greg Kroah-Hartman wrote:
> > On Thu, Jul 16, 2026 at 10:55:42AM +0200, David Hildenbrand (Arm) wrote:
> >> On 7/15/26 18:41, Hari Mishal wrote:
> >>> The device_block_size read from the virtio-mem config space is used as a
> >>> divisor and also in ALIGN_DOWN() further down the code path in the
> >>> driver without further validation. A zero value leads to a division by
> >>> zero, and a non-power-of-two value corrupts the ALIGN_DOWN() bitmask
> >>> arithmetic leading to a misreporting of guest-usable ram, post crash.
> >>>
> >>> Reject both at init time instead of trusting the device.
> >>>
> >>> Signed-off-by: Hari Mishal <harimishal1@gmail.com>
> >>> ---
> >>> v2: dropped the redundant explicit zero check, since
> >>>     is_power_of_2(0) already returns false.
> >>>
> >>>  drivers/virtio/virtio_mem.c | 6 ++++++
> >>>  1 file changed, 6 insertions(+)
> >>>
> >>> diff --git a/drivers/virtio/virtio_mem.c b/drivers/virtio/virtio_mem.c
> >>> index 11c441501582..0e04fec458af 100644
> >>> --- a/drivers/virtio/virtio_mem.c
> >>> +++ b/drivers/virtio/virtio_mem.c
> >>> @@ -2847,6 +2847,12 @@ static int virtio_mem_init(struct virtio_mem *vm)
> >>>  			&vm->plugged_size);
> >>>  	virtio_cread_le(vm->vdev, struct virtio_mem_config, block_size,
> >>>  			&vm->device_block_size);
> >>> +	if (!is_power_of_2(vm->device_block_size)) {
> >>> +		dev_err(&vm->vdev->dev,
> >>> +			"invalid device block size: 0x%llx\n",
> >>> +			(unsigned long long)vm->device_block_size);
> >>> +		return -EINVAL;
> >>> +	}
> >>
> >> The spec states "The device MUST set block_size to a power of two."
> >>
> >> I'm missing the point here.
> > 
> > So what happens if we have a non-spec-compliant device?  Shouldn't we be
> > attempting to verify this before doing something with the data?
> 
> The problem I see is that there are plenty of other devices where a
> non-compliant device might cause problems.
> 
> Like, we request to hotplug some memory block and our device ACKs it, but it
> simply didn't do that.
> 
> Or we request to hotunplug a memory block and instead it hotplugs some random
> other memory block.
> 
> Or we sense whether a memory block is plugged and the device lies to us.
> 
> > 
> > Or do we just always trust virtio mem devices explicitly?
> 
> It's hard for me to understand where we draw the line, really.
> 
> But maybe MST can clarify what we care about in virtio world where the
> hypervisor is fully in charge of the device,

That would be good to figure out, and write down somewhere, so we know
what to worry about here.

Right now, for almost all subsystems, Linux trusts the hardware
explicitly.  But for some subsystems, it doesn't, or doesn't until
"something" happens (example, USB devices are untrusted until we bind a
driver to the device, and then they are trusted.)

But there are some people that want to never trust the hardware, or have
it in different states, specifically for virtual machines like this
driver operates in.  The CoC model is just that, and patches from Dan
are working toward clearing this up a lot for some types of devices (PCI
and IOMMU), but I don't think they have thought about virtio devices
yet...

thanks,

greg k-h
