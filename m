Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08EC54BEE37;
	Mon, 28 Sep 2026 16:10:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790611823; cv=none; b=Me3vo8zEjGuXWDd9hXKW4jOvD9Pz4zfj1zBVDm/kBhrTt6Ar8TzChQECTcKEDI4QQIf29ayqal90BtnM93Xo3EZgMjnQT/LSKIpBZJ6NA6PKjBrPILdbCECMYLSEpq75Dk9X3uy3DozdSgNiKosSYrdjvS7X2C2ze1qBHTG0LCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790611823; c=relaxed/simple;
	bh=IXbegGBKXFWuBHM/xh+i1Cm5C7G7OQIimvDBHiAWSFg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D5QQVxSSFdKSx1AufJMvWuIg1XztWXiI2BUpiqzMEM5ymrgb/F3vH0eMyYMVQLO+q0F9KiKFAybpJX1kAdXyWwg/qTN5SX3iHpD1iUy8ec2YTb1hm0KFXEcHuzpMXqw3MZdNJS3a7xldtaymhf9b+x1mbxtmNr+bG+oycM9rUBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=i9k2bD4x; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="i9k2bD4x"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14ABE1F000FF;
	Mon, 28 Sep 2026 16:10:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1790611821;
	bh=vcpekEA2miDUdQeAB2lng+6/mjlbJ4vyERP8lq5vsOA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=i9k2bD4x1FcdOpuILhHHN3avGEFk8LNhsOPSp579srpL63XhR33HXMKP5chvkUk4s
	 jlgy5V359flXZNWJCoCRUVErWfbcfogZYzGTV+DUVuDS3YBfFi1xlMQQFUZLX7z+Bu
	 pYDVwDYlGVeDqQfWcneOVfChQXAItPbktrRbDXJ8=
Date: Mon, 28 Sep 2026 18:10:16 +0200
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
Message-ID: <2026092836-majority-troubling-ba47@gregkh>
References: <20260924160907.145405-1-igor.skalkin@oss.qualcomm.com>
 <2026092520-aerosol-brim-22d1@gregkh>
 <1149e188-7279-4c60-bd96-f8d75d721ae0@oss.qualcomm.com>
 <2026092846-word-shape-dab9@gregkh>
 <92343daf-eae9-400e-b865-528569b028b2@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <92343daf-eae9-400e-b865-528569b028b2@oss.qualcomm.com>

On Mon, Sep 28, 2026 at 05:56:22PM +0200, Igor Skalkin wrote:
> 
> 
> On 9/28/2026 4:44 PM, Greg Kroah-Hartman wrote:
> > On Mon, Sep 28, 2026 at 03:55:38PM +0200, Igor Skalkin wrote:
> >>
> >>
> >> On 9/25/2026 7:17 AM, Greg Kroah-Hartman wrote:
> >>> On Thu, Sep 24, 2026 at 06:08:59PM +0200, Igor Skalkin wrote:
> >>>> This series adds a new virtio-usb driver: a dual-role virtio device
> >>>> capable of acting as a USB host controller, a USB device controller,
> >>>> or both simultaneously with runtime role switching between the two
> >>>> (USB OTG-style role switching) on ports that support it.
> >>>>
> >>>> The corresponding virtio-usb device specification has been posted to
> >>>> virtio-comment for review. This series matches the v2 revision of
> >>>> that spec, which reconciles a small number of protocol details
> >>>> (per-role virtqueue presentation, host-role vp_idx for hub/multi-VP
> >>>> support, and the device-role BIND/UNBIND event split) that were
> >>>> clarified while integrating and testing this driver against the
> >>>> spec:
> >>>
> >>> Why do we need this at all when we have other ways of doing usb devices
> >>> through virtio?
> >>>
> >>> Why is a USB virtio spec needed at all, who is going to use it?
> >>>
> >>>
> >> For device classes that already have a virtio equivalent (storage, HID,
> >> video, audio) there's no need for virtio-usb: we can use
> >> virtio-blk/virtio-input/virtio-video/virtio-snd directly.
> >> What virtio-usb actually addresses is different: protocols that are
> >> about raw USB semantics itself, not about any particular device class.
> >> Two concrete cases we care about. ADB (Android Debug Bridge), a specific
> >> USB interface/vendor-class protocol used throughout Android development
> >> and debugging, with no meaningful way to express it as a block or HID
> >> device. And Android Auto (AOA) / Apple CarPlay, USB-level
> >> control-transfer and vendor-negotiation protocols used when a phone is
> >> plugged into an automotive head unit.
> >> Our motivating use case is automotive cockpit virtualization: a physical
> >> USB port where a phone is plugged in needs to be handed to a guest VM
> >> running the head-unit stack, and that guest needs to run one of these
> >> USB-native protocols. The existing software on both sides already speaks
> >> raw USB and works unmodified if it sees a real-looking USB device.
> >> virtio-usb lets that keep working, instead of needing a new bespoke
> >> virtio spec for every such protocol as new USB-based ecosystems show up.
> > 
> > So you just want "raw" usb, then why not use usb-ip?  Isn't that what
> > it's there for?  Or just mount usbfs and expose that to the host as
> > that's what adb is using already, right?
> > 
> usb-ip's host and guest sides are both Linux-specific - in some of our
> target deployments the host OS isn't Linux at all (e.g. QNX), so there's
> no usb-ip host-side implementation to use in the first place.
> virtio-usb's backend only needs to speak the virtio transport, which is
> host-OS-agnostic.

But you are making a brand new virtio transport, which will have to be
written for all OSes.  usb-ip already works on other operating systems
today.  Same for usbfs through libusb.

> Separately, usb-ip requires explicit manual configuration on both sides
> for every device. Its own checklist also calls for disabling SELinux and
> opening a TCP port. We're trying to avoid that operational overhead
> (ideally - fully virtualized vanilla Android as a guest).
> usbfs is a different layer - it lets a local process talk to a
> locally-attached device (how the ADB host daemon works today), but
> doesn't address getting the USB device into the guest in the first place.
> And usbfs is Linux-specific too.

No, see libusb, it abstracts that away.

And really, why do you want to do anything other than Linux.  Or more
realisticly, why should _I_ care about anything other than Linux?  :)

Again, mount usbfs and away you go, libusb is your friend :)

thanks,

greg k-h
