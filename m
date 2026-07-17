Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD67C42A16F;
	Fri, 17 Jul 2026 14:31:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784298673; cv=none; b=FtiP0tjaUpHogKSCmBQ0CryYa4o/eJFPnKpNOXiWspjLw7r8f7f2EijNOLltPFfsWS1f6cUi7Bc3E4MD5FbGIYF+e8rn6EjlKMtLOVcZ5DcBG5MeZ9iz9TjwJEmsgv1FfxU92qXUwnMeXXo118aYh7mtvULegBy4gHEw5mwRjgc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784298673; c=relaxed/simple;
	bh=X9cb+F6qwZC3ztetdxQOTfVcYhasc4YEgJSVwRRlmII=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Po3P5UBYi7BdAyyQSXWdKbA/VBPtTTetUs+i1WDw5UD65FACNZe+a/41LwqB2HrSRrjRcUqi6FMUdTcK9mQtJK4aikuVIFG5sg7KWL8XgyeZKwebmMlWdthg70egCuQSblmVx/5rWB7/pqIr6JV7wadrRvCEzpqlPzDTYbjSBOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=POnXVIZt; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="POnXVIZt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF61A1F00A3E;
	Fri, 17 Jul 2026 14:31:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1784298671;
	bh=CA1hGmq5/HP9bsQO5WvT6ejkleX26fnK+7FdnEm0190=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=POnXVIZtzjqmQZAEE2mSKRdPlIIqxPNuFg91tDr6b5rvvfqLVOJJVgpyPhpXW1tX8
	 dscQE/u0qYCrYyN023cfqWmFDKtp7jbNYcV9+lKyHT3DgxfnsC4pL6Ye8AlWpvLPIA
	 H6gHpyUDuM77qusU+529cBPRWVni3L8OFx1MkhCQ=
Date: Fri, 17 Jul 2026 16:31:03 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: "David Hildenbrand (Arm)" <david@kernel.org>,
	Hari Mishal <harimishal1@gmail.com>,
	Jason Wang <jasowangio@gmail.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org,
	elena.reshetova@intel.com, carlos.bilbao.osdev@gmail.com
Subject: Re: [PATCH v2 1/4] virtio-mem: validate device-reported block size
Message-ID: <2026071724-modulator-pliable-fa1c@gregkh>
References: <3b32a38f-0964-45b9-9529-933abedbf69b@kernel.org>
 <20260717044019-mutt-send-email-mst@kernel.org>
 <2026071746-deviation-clad-1712@gregkh>
 <20260717060822-mutt-send-email-mst@kernel.org>
 <2026071757-grout-composer-165d@gregkh>
 <20260717061901-mutt-send-email-mst@kernel.org>
 <2026071724-asleep-pedigree-ea54@gregkh>
 <20260717065219-mutt-send-email-mst@kernel.org>
 <2026071759-thermal-synopsis-7568@gregkh>
 <20260717085838-mutt-send-email-mst@kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260717085838-mutt-send-email-mst@kernel.org>

On Fri, Jul 17, 2026 at 09:08:23AM -0400, Michael S. Tsirkin wrote:
> On Fri, Jul 17, 2026 at 02:07:50PM +0200, Greg Kroah-Hartman wrote:
> > On Fri, Jul 17, 2026 at 06:52:46AM -0400, Michael S. Tsirkin wrote:
> > > On Fri, Jul 17, 2026 at 12:46:52PM +0200, Greg Kroah-Hartman wrote:
> > > > On Fri, Jul 17, 2026 at 06:23:57AM -0400, Michael S. Tsirkin wrote:
> > > > > On Fri, Jul 17, 2026 at 12:15:09PM +0200, Greg Kroah-Hartman wrote:
> > > > > > On Fri, Jul 17, 2026 at 06:10:41AM -0400, Michael S. Tsirkin wrote:
> > > > > > > On Fri, Jul 17, 2026 at 11:14:23AM +0200, Greg Kroah-Hartman wrote:
> > > > > > > > On Fri, Jul 17, 2026 at 04:59:32AM -0400, Michael S. Tsirkin wrote:
> > > > > > > > > On Fri, Jul 17, 2026 at 10:39:40AM +0200, David Hildenbrand (Arm) wrote:
> > > > > > > > > > On 7/17/26 07:48, Michael S. Tsirkin wrote:
> > > > > > > > > > > On Thu, Jul 16, 2026 at 05:59:05PM +0200, David Hildenbrand (Arm) wrote:
> > > > > > > > > > >>> Or do we just always trust virtio mem devices explicitly?
> > > > > > > > > > >>
> > > > > > > > > > >> It's hard for me to understand where we draw the line, really.
> > > > > > > > > > >>
> > > > > > > > > > >> But maybe MST can clarify what we care about in virtio world where the
> > > > > > > > > > >> hypervisor is fully in charge of the device,
> > > > > > > > > > > 
> > > > > > > > > > > Generally:
> > > > > > > > > > > - The guest is expected to whitelist drivers (most drivers have not
> > > > > > > > > > >   been audited).
> > > > > > > > > > 
> > > > > > > > > > But even if you audited your driver, who makes sure that we consider all ways
> > > > > > > > > > where the device could mess with us?
> > > > > > > > > 
> > > > > > > > > A lot of this is up to a correct setup. For example, make sure all
> > > > > > > > > filesystems are encrypted and refuse to mount unencrypted ones.
> > > > > > > > > 
> > > > > > > > > > Something feels off here.
> > > > > > > > > > 
> > > > > > > > > > Handling selected out-of-spec scenarios like this feels like a band-aid. Happy
> > > > > > > > > > to be corrected.
> > > > > > > > > 
> > > > > > > > > Well Documentation/security/snp-tdx-threat-model.rst puts it like this:
> > > > > > > > > 	It is important to note
> > > > > > > > > 	that this doesn’t imply that the host or VMM are intentionally
> > > > > > > > > 	malicious, but that there exists a security value in having a small CoCo
> > > > > > > > > 	VM TCB.
> > > > > > > > > 
> > > > > > > > > and
> > > > > > > > > 
> > > > > > > > > 	While traditionally the host has unlimited access to guest data and can
> > > > > > > > > 	leverage this access to attack the guest, the CoCo systems mitigate such
> > > > > > > > > 	attacks by adding security features like guest data confidentiality and
> > > > > > > > > 	integrity protection.
> > > > > > > > > 
> > > > > > > > > 
> > > > > > > > > now, when we are talking about "mitigation" it is indeed becoming a bit
> > > > > > > > > murky.
> > > > > > > > > 
> > > > > > > > > 
> > > > > > > > > For me, a rule of thumb I came up with is that if the validation happens
> > > > > > > > > to also be helful for users e.g. to work around buggy devices,
> > > > > > > > > or maybe because we feel failing gracefully is nice because this
> > > > > > > > > will allow to later make use of this config and old drivers will
> > > > > > > > > fail but at least not panic, then it is good to include.
> > > > > > > > 
> > > > > > > > Why not do what USB does?  Don't trust the device until AFTER probe()
> > > > > > > > succeeds?  All of the needed checking should happen before then, as that
> > > > > > > > is a "slow path" so lots of validation and the like can happen at that
> > > > > > > > point.
> > > > > > > > 
> > > > > > > > After that, during the normal data paths, after the driver is bound,
> > > > > > > > trust it all you want as attempting to validate every single packet is
> > > > > > > > just going to be impossible.
> > > > > > > > 
> > > > > > > > thanks,
> > > > > > > > 
> > > > > > > > greg k-h
> > > > > > > 
> > > > > > > People do expect that data path validation at this point.
> > > > > > 
> > > > > > Ok, so you want this patch :)
> > > > > > 
> > > > > > And more, as you need to treat everything from the host as "untrusted",
> > > > > > and it must be "verified".
> > > > > 
> > > > > Well. First it's not me) Second it's only specific configurations -
> > > > > for example there's no short term plan to validate filesystem code, people
> > > > > are expected to rely on encryption. The reasons have more to do
> > > > > with the available manpower than anything else.
> > > > 
> > > > Sure, but again, for subsystems, you have to define your threat model as
> > > > the LLMs are churning against the code base and coming up with lots of
> > > > crazy ideas if a device should or should not be trusted and spitting out
> > > > patches and reports like the ones that are in the first few patches of
> > > > this series.
> > > > 
> > > > So please, pick a model, let's document it, and go with that.  I am
> > > > getting directly conflicting responses here.
> > > > 
> > > > thanks,
> > > > 
> > > > greg k-h
> > > 
> > > Supposed to be this one:
> > > Documentation/security/snp-tdx-threat-model.rst
> > > 
> > > what is missing?
> > 
> > A policy decision that needs to be made.  All that document does is
> > describe a bunch of different "threats" yet does not decide what to do
> > about them at all from what I can tell.
> 
> That would be this section I think:
> 
> 	The **Linux kernel CoCo VM security objectives** can be summarized as follows:
> 
> it does, indeed, not go into detail about how to interact, safely,
> with untrusted entities. Does it really need to be spelled out?

Seems like it as I didn't figure it out at all :)

> > And that's just for one subset of the CoC world, right?  Is that
> > something that all virtio drivers need/want to care about?
> 
> What is missing, and what you seem to be asking for, is an opinionated
> stance on which drivers we care about in this world?
> True.

Yes.

> coco guys tried to annotate drivers at some point to do exactly that.
> this was rejected upstream from the position that this is not
> different from handling buggy hardware, and just to fix all drivers.
> so it's up to users, and I guess for virtio the answer is yes
> with some exceptions because we don't have a better answer right now.

Ok, so back to the original question here:

> > So I don't see a real answer to the "does Linux trust the host to give
> > you good data or not" question in that file, am I missing it?
> > 
> > thanks,
> > 
> > greg k-h
> 
> This? Note the last sentence.
> 
> The **Linux CoCo VM attack surface** is any interface exposed from a CoCo
> guest Linux kernel towards an untrusted host that is not covered by the
> CoCo technology SW/HW protection. This includes any possible
> side-channels, as well as transient execution side channels. Examples of
> explicit (not side-channel) interfaces include accesses to port I/O, MMIO
> and DMA interfaces, access to PCI configuration space, VMM-specific
> hypercalls (towards Host-side VMM), access to shared memory pages,
> interrupts allowed to be injected into the guest kernel by the host, as
> well as CoCo technology-specific hypercalls, if present. Additionally, the
> host in a CoCo system typically controls the process of creating a CoCo
> guest: it has a method to load into a guest the firmware and bootloader
> images, the kernel image together with the kernel command line. All of this
> data should also be considered untrusted until its integrity and
> authenticity is established via attestation.

Great, so you are saying that we need to fix any bug found where a host
could be sending "bad" data over the virtio path before, and after, the
driver is bound to the device.  That's a solid answer, and let's let the
LLMs run with that!

Which also implies that the first 3 patches here are acceptable, right?
:)

thanks,

greg k-h
