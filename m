Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5790E38DE9
	for <virtualization@lists.linux.dev>; Mon, 24 Feb 2025 19:31:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740425489; cv=none; b=uSA/SlFa3thQUO5LiOM+2NBlFoSmpn5fedIe13xpS+/dI5Fs/t+hV/FknobZSXrfEEkDJvbEd+amO/GLgV2w+dGR9KdBlJPyNha2kcF9dMf63VP0RjPlOE7OTbJIlpwQVKvCWcB6LTm4ZXk1PMUzJu0WyYFzhxB6W7V6FUcnyGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740425489; c=relaxed/simple;
	bh=YBDsHACouaN+aMfoUrjYIa8r0lB8hOlZNo+jZD9yBEo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=HQL394q59o20o/Df49fXCL1eoSj28d9Fj03JkC/WEZ3OCcwHDSIaXNuCrY9uKdzLpan63GswiwpDg4Mw3a9nSQPSS9CYad1ULWlXuSMhdxc4eppHrf5DF/f6b+tmGM/L1NntjnaX6QNMfVO0y5tJ614aQBnhzXTVZ33uu9ZdYAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IoF9v1Fi; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IoF9v1Fi"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740425486;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=idT/vy1HvD2D4hD5nG4G0mRg704udpm8C/gIW77jkPE=;
	b=IoF9v1FiwPCUmIMU1HvXVI6T6hHvNv9WPRGqSynQ+sev27+IrHvMvB4F8CID7MxLkjhX00
	XcHEAecdYNzdMmjUuiNtEehY5juWo67Gp8R19TXHaIEpGViZPvIY5jwetCKh11iJuNE5dI
	8PsIPF67ZJqE8xB1kbu9PbpnzU9VWc4=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-640-f8QvCE2jNZKgr-FhNhGRgg-1; Mon, 24 Feb 2025 14:31:24 -0500
X-MC-Unique: f8QvCE2jNZKgr-FhNhGRgg-1
X-Mimecast-MFC-AGG-ID: f8QvCE2jNZKgr-FhNhGRgg_1740425483
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-abb76bd0feeso452641666b.0
        for <virtualization@lists.linux.dev>; Mon, 24 Feb 2025 11:31:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740425483; x=1741030283;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=idT/vy1HvD2D4hD5nG4G0mRg704udpm8C/gIW77jkPE=;
        b=BySZ9XGDabt1cns1FaM/EwrAHZOfJhQDOQKVTCE6VZFojYCd0VXjBk+avIdDgNU5/3
         rWEJ+dv2IF22XW8W/MfG4HU/d9GMLgehPtdVwSftf5BoL6xASUcQdLm3wWiPkx+8Q6wv
         r+TkWNdzspYi8efd+vDZe8+0ntBUQgmzeCDwYNUoZCIM0n7Bi5RezrxwDOielM2swgfy
         VcxsYYncwefk/1yqrsGXdLX8hlQEZQAQ8EnLy4LO7osi9w5Usq2kjowLedgo6yuuvx7l
         UdYSIWgoyRGnzQLGQFAsX7uO/HaDFT6meZSMji6KLoULXXAZv+m1F4SUjTbJ28RGHOWU
         nmKQ==
X-Forwarded-Encrypted: i=1; AJvYcCVjb1WLzeINyJtNIiEMBuMQ9EVwkIbKwnKl+zWaoc4H32yPxPHyYEstAmQ2CFFi7hgZGbHsCoz0Cr5SRkCKXA==@lists.linux.dev
X-Gm-Message-State: AOJu0YzvGx5mIxZCuLuyES934tHzOpAUiTGNEKgf+yCBiu2pO6avM85R
	gMTFdCeZGW1iCTrIkZrlMbIAUbXzHm17fPn4LlBruvLL0aW00a5q4qtQUmyc74/8jaqiEhZqwNJ
	sglr3FsQ+wdijrfGdo6RzfuOEg3NUCBlQBeNdOT9mtL5G8dKyqVyG0FTWoSWKg3AR
X-Gm-Gg: ASbGnctgAhDK4eORSsd6dXkx874WLay8Ga4R8tGCjPhORX8DgILRJp/vkptsjDb4fuI
	vEXhlEoFv5wZ8NbwyRyssVTtffnJiDkH21iZ5qFbMYt+u577JsNlg2+hA3HkgGzJWe5YKFYeCMs
	S+l87oIemLDIJ9PPFmeZ/qM4gWbVplstCOZO1UlBILWOF2TKvuQoPZCIck7c57SnTBNxCjvufed
	CreR9o3XEp8D73DkFACqeY6ei5O+JoO6nFxPvBGwRhsMAOsiSHhI52yCLSsyLn+Tm3auyAtV9Rf
	x6YMcM8boQ==
X-Received: by 2002:a17:906:6209:b0:abb:b602:6350 with SMTP id a640c23a62f3a-abbedf561d3mr1802818966b.25.1740425483414;
        Mon, 24 Feb 2025 11:31:23 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEreZlvieIjHWrvIDKuMy4Qi8XnpbU4EBr9I74kSWjhWKQiF+lYJGIGdmXQF0nqO4S1HziFxA==
X-Received: by 2002:a17:906:6209:b0:abb:b602:6350 with SMTP id a640c23a62f3a-abbedf561d3mr1802816366b.25.1740425483032;
        Mon, 24 Feb 2025 11:31:23 -0800 (PST)
Received: from redhat.com ([2a0d:6fc7:441:1929:22c5:4595:d9bc:489e])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abed20121c0sm9919666b.99.2025.02.24.11.31.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Feb 2025 11:31:22 -0800 (PST)
Date: Mon, 24 Feb 2025 14:31:19 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Eric Auger <eauger@redhat.com>
Cc: linux-kernel@vger.kernel.org, Hongyu Ning <hongyu.ning@linux.intel.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	virtualization@lists.linux.dev
Subject: Re: [PATCH] virtio: break and reset virtio devices on
 device_shutdown()
Message-ID: <20250224143029-mutt-send-email-mst@kernel.org>
References: <c1dbc7dbad9b445245d3348f19e6742b0be07347.1740094946.git.mst@redhat.com>
 <7fa37894-7d73-4087-a849-2957f31ad7f4@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <7fa37894-7d73-4087-a849-2957f31ad7f4@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: SFNlbBFN4ioCKucRle7llQ33ClZh7SHSQPFu_vXJ6zQ_1740425483
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Feb 24, 2025 at 08:49:09AM +0100, Eric Auger wrote:
> Hi Michael,
> 
> On 2/21/25 12:42 AM, Michael S. Tsirkin wrote:
> > Hongyu reported a hang on kexec in a VM. QEMU reported invalid memory
> > accesses during the hang.
> > 
> > 	Invalid read at addr 0x102877002, size 2, region '(null)', reason: rejected
> > 	Invalid write at addr 0x102877A44, size 2, region '(null)', reason: rejected
> > 	...
> > 
> > It was traced down to virtio-console. Kexec works fine if virtio-console
> > is not in use.
> > 
> > The issue is that virtio-console continues to write to the MMIO even after
> > underlying virtio-pci device is reset.
> > 
> > Additionally, Eric noticed that IOMMUs are reset before devices, if
> > devices are not reset on shutdown they continue to poke at guest memory
> > and get errors from the IOMMU. Some devices get wedged then.
> > 
> > The problem can be solved by breaking all virtio devices on virtio
> > bus shutdown, then resetting them.
> > 
> > Reported-by: Eric Auger <eauger@redhat.com>
> > Reported-by: Hongyu Ning <hongyu.ning@linux.intel.com>
> > Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> Tested-by: Eric Auger <eric.auger@redhat.com>
> 
> Thanks!
> 
> Eric
> > ---
> >  drivers/virtio/virtio.c | 31 +++++++++++++++++++++++++++++++
> >  1 file changed, 31 insertions(+)
> > 
> > diff --git a/drivers/virtio/virtio.c b/drivers/virtio/virtio.c
> > index c1cc1157b380..e5b29520d3b2 100644
> > --- a/drivers/virtio/virtio.c
> > +++ b/drivers/virtio/virtio.c
> > @@ -377,6 +377,36 @@ static void virtio_dev_remove(struct device *_d)
> >  	of_node_put(dev->dev.of_node);
> >  }
> >  
> > +static void virtio_dev_shutdown(struct device *_d)
> > +{
> > +	struct virtio_device *dev = dev_to_virtio(_d);
> > +	struct virtio_driver *drv = drv_to_virtio(dev->dev.driver);
> > +
> > +	/*
> > +	 * Stop accesses to or from the device.
> > +	 * We only need to do it if there's a driver - no accesses otherwise.
> > +	 */
> > +	if (!drv)
> > +		return;
> > +
> > +	/*
> > +	 * Some devices get wedged if you kick them after they are
> > +	 * reset. Mark all vqs as broken to make sure we don't.
> > +	 */
> > +	virtio_break_device(dev);
> > +	/*
> > +	 * The below virtio_synchronize_cbs() guarantees that any interrupt
> > +	 * for this line arriving after virtio_synchronize_vqs() has completed
> > +	 * is guaranteed to see vq->broken as true.
> > +	 */
> > +	virtio_synchronize_cbs(dev);
> > +	/*
> > +	 * As IOMMUs are reset on shutdown, this will block device access to memory.
> > +	 * Some devices get wedged if this happens, so reset to make sure it does not.
> > +	 */

Eric,
Could you pls drop the below line (reset), and retest?
I want to make sure the above comment is right.
Thanks!

> > +	dev->config->reset(dev);


> > +}
> > +
> >  static const struct bus_type virtio_bus = {
> >  	.name  = "virtio",
> >  	.match = virtio_dev_match,
> > @@ -384,6 +414,7 @@ static const struct bus_type virtio_bus = {
> >  	.uevent = virtio_uevent,
> >  	.probe = virtio_dev_probe,
> >  	.remove = virtio_dev_remove,
> > +	.shutdown = virtio_dev_shutdown,
> >  };
> >  
> >  int __register_virtio_driver(struct virtio_driver *driver, struct module *owner)

