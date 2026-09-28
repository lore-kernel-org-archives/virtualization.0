Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 016BF4D6C3F;
	Mon, 28 Sep 2026 14:44:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790606693; cv=none; b=Jtf9wCinAZoh8aBeh80XdmpB+ENB8cFvtF9cxpHMyHmbyZ56hUWJtQsMX1Og5deZe0KatmxgxOZJMGFoDiwvvc3tgF1ZFXvP6s7gCMJhawD52XLwqKKZjGmJyDtzFcnvDu2LUeT5SXy1oBM/Ie08oYjGm3TxpcTxazz5veXz+7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790606693; c=relaxed/simple;
	bh=ke9JBBtwtylHKdeQZ1wwGoeFC0gM2nZZGn1nsc7tj3o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PUKfXsTFFDZwP6WQdoVlWvlxfapVZ+fJz9k0sLnD9kug1W2ABGACnLAiAmYzgmzN//OAeFK7GjV6dmy85k8Rj0kKm3y9+WjcVgQzF0pISNlzbifpJGo0PDmvR7k7zp1uonv2bIGR2ZwwpVSLxujY1yAjyvrkfqivKOPNtoj/i4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=nbEuX46B; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="nbEuX46B"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E50FB1F00893;
	Mon, 28 Sep 2026 14:44:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1790606691;
	bh=fss5/qW2KRPxMx2bFllwYMgwLmwU+5fSludVz5uECCQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=nbEuX46BYgySxw8NlsdBzixeoKoIP130DIb7IHtw95XNdhuz/Bqik10EefmXQrQe3
	 Ks0ugd5BiLP5zi4u/vuD3fcopLZ4Y3emQH9MpqtkZYafP2p2ZNvfjscOb8KyeQgjPv
	 ojzCdSGcrSpNaVCNKdP8scMWiVF0LRsGJiZ7O0Ls=
Date: Mon, 28 Sep 2026 16:44:45 +0200
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
Message-ID: <2026092846-word-shape-dab9@gregkh>
References: <20260924160907.145405-1-igor.skalkin@oss.qualcomm.com>
 <2026092520-aerosol-brim-22d1@gregkh>
 <1149e188-7279-4c60-bd96-f8d75d721ae0@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1149e188-7279-4c60-bd96-f8d75d721ae0@oss.qualcomm.com>

On Mon, Sep 28, 2026 at 03:55:38PM +0200, Igor Skalkin wrote:
> 
> 
> On 9/25/2026 7:17 AM, Greg Kroah-Hartman wrote:
> > On Thu, Sep 24, 2026 at 06:08:59PM +0200, Igor Skalkin wrote:
> >> This series adds a new virtio-usb driver: a dual-role virtio device
> >> capable of acting as a USB host controller, a USB device controller,
> >> or both simultaneously with runtime role switching between the two
> >> (USB OTG-style role switching) on ports that support it.
> >>
> >> The corresponding virtio-usb device specification has been posted to
> >> virtio-comment for review. This series matches the v2 revision of
> >> that spec, which reconciles a small number of protocol details
> >> (per-role virtqueue presentation, host-role vp_idx for hub/multi-VP
> >> support, and the device-role BIND/UNBIND event split) that were
> >> clarified while integrating and testing this driver against the
> >> spec:
> > 
> > Why do we need this at all when we have other ways of doing usb devices
> > through virtio?
> > 
> > Why is a USB virtio spec needed at all, who is going to use it?
> > 
> > 
> For device classes that already have a virtio equivalent (storage, HID,
> video, audio) there's no need for virtio-usb: we can use
> virtio-blk/virtio-input/virtio-video/virtio-snd directly.
> What virtio-usb actually addresses is different: protocols that are
> about raw USB semantics itself, not about any particular device class.
> Two concrete cases we care about. ADB (Android Debug Bridge), a specific
> USB interface/vendor-class protocol used throughout Android development
> and debugging, with no meaningful way to express it as a block or HID
> device. And Android Auto (AOA) / Apple CarPlay, USB-level
> control-transfer and vendor-negotiation protocols used when a phone is
> plugged into an automotive head unit.
> Our motivating use case is automotive cockpit virtualization: a physical
> USB port where a phone is plugged in needs to be handed to a guest VM
> running the head-unit stack, and that guest needs to run one of these
> USB-native protocols. The existing software on both sides already speaks
> raw USB and works unmodified if it sees a real-looking USB device.
> virtio-usb lets that keep working, instead of needing a new bespoke
> virtio spec for every such protocol as new USB-based ecosystems show up.

So you just want "raw" usb, then why not use usb-ip?  Isn't that what
it's there for?  Or just mount usbfs and expose that to the host as
that's what adb is using already, right?

> >>   [RFC PATCH v2] virtio-usb: Add initial virtio-usb specification
> >>   Igor Skalkin <igor.skalkin@oss.qualcomm.com>
> >>   virtio-comment@lists.linux.dev
> >>   https://lore.kernel.org/virtio-comment/20260924154007.143927-1-igor.skalkin@oss.qualcomm.com/
> >>
> >> This driver has been tested end-to-end against our own userspace
> >> virtio-usb device implementation (host-side backend) in two setups:
> > 
> > Where is that code and why isn't it part of this submission?
> > 
> The backend we used for the testing described above is an internal
> implementation that we're not releasing as part of this submission - it
> integrates with some systems that aren't ready to be public. We
> recognize that limits independent verification of our specific test
> results, and we don't think that's an ideal situation.

Then we can't even review this at all, sorry, you all know better than
that.

> >>   4-5: USB OTG-style role query and role-switching support.
> > 
> > There's a reason OTG isn't used anymore by devices, how have you
> > addressed those problems here?  And why duplicate the failures of the
> > past?
> > 
> We're not implementing ID-pin detection, HNP, or SRP - none of that.
> "OTG" here is just a reused name for something much simpler: an explicit
> role-switch command exposed to the guest via sysfs. Device-to-host is
> driver-initiated (guest writes to that sysfs entry); host-to-device is
> host-initiated (the host switches on its own and notifies the guest).
> Either direction is always granted - no negotiation step to get wrong.
> Happy to rename the OTG-tagged commands/constants if the naming is
> causing confusion.

"OTG" has a _VERY_ specific definition in the USB world, don't attempt
to re-define it please.  That way lies madness...

> >>   6:   endpoint-lifecycle robustness rework (async split-phase state
> >>        machine, replacing an earlier out-of-tree gadget.nonatomic
> >>        patch that didn't pass upstream review).
> >>   7:   SuperSpeed device-role support.
> > 
> > Why should speed settings matter to a virtual connection?
> >
> Because the kernel APIs we're implementing on top of are inherently
> speed-typed, not because of any real electrical/physical constraint.
> usb_hcd (host role) and the USB Gadget API (device role) both bake speed
> into their core design - it drives enumeration, bandwidth scheduling,
> and descriptor selection (e.g. SuperSpeed companion descriptors) in the
> USB core and in gadget function drivers. dummy_hcd is a good precedent:
> it's also a purely virtual host controller with no real signaling, and
> it still has to declare and support different speed configurations,
> because the framework requires it. We're in the same position -
> unmodified guest USB class drivers and gadget function drivers depend on
> accurate speed information regardless of what's actually behind the
> interface.

This is a virtual connection, speed means nothing here other than some
descriptor stuff in a few places.

Again, try using the existing code, usb-ip or usbfs, don't invent
something new, especially when it's not even visable to anyone.  Would
you want to attempt to review something like this in that situation?

thanks,

greg k-h
