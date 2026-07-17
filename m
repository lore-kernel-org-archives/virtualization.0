Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA4573F8704;
	Fri, 17 Jul 2026 12:07:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784290080; cv=none; b=gY5/I2cBOIilyg4/o1ujkXpL7CTDWdpXt382RTfM0gzPY3eiI0g2HF1FT64O4548z5asvcDhztLPvK86nyrd5VALVjoHp2BB3pHo2tD5rmet3V3mavnqoh9x/iHciwmGHcMXHCgAeE9cFlAt1793h/NoPnSsmEFLIbrxe3i4UuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784290080; c=relaxed/simple;
	bh=bH+Azl2zlzQLwAb4+C643ctLn+iJsC8XVoPVMibxQVs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sa2FElf0oQz0Mx4J5KViHLwCEkeajWLsowcJAFJGQfzPMaNNpFq6yxDIw1WLGoCFg8BorX0kxQsrGhnHg4pGCptCKVOAWhvk73XD8GnAT4GaXgAUbUDSAxpc/O08ZNUjlOi8LO7PTHpT+YF6XMacoEW3MfchvglBOhIiYsNtpsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=0X+Aybfb; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="0X+Aybfb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6DDFF1F00A3A;
	Fri, 17 Jul 2026 12:07:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1784290077;
	bh=5Ohy4MlQUpb6Ytahlo3Ms+m9aKUdmQLui4ovBQn2O9k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=0X+AybfbqlsqCGaHbcn1RtJgT/4H8yx2/xhZgxbTIbnZhccTsaJmRKgAh7fUNCsGM
	 pKfa9GnKNQPLflCBNUb21hhdmdKZxGJsHyUTmYEV4u6C5CWQd281+gEugNcRo9H73p
	 iraTjRRvzZLlNnfB9wx434c8MEMLxEIuFOmD98qA=
Date: Fri, 17 Jul 2026 14:07:50 +0200
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
Message-ID: <2026071759-thermal-synopsis-7568@gregkh>
References: <4dda47ba-534a-4297-a25e-0d63d9167033@kernel.org>
 <20260717014134-mutt-send-email-mst@kernel.org>
 <3b32a38f-0964-45b9-9529-933abedbf69b@kernel.org>
 <20260717044019-mutt-send-email-mst@kernel.org>
 <2026071746-deviation-clad-1712@gregkh>
 <20260717060822-mutt-send-email-mst@kernel.org>
 <2026071757-grout-composer-165d@gregkh>
 <20260717061901-mutt-send-email-mst@kernel.org>
 <2026071724-asleep-pedigree-ea54@gregkh>
 <20260717065219-mutt-send-email-mst@kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260717065219-mutt-send-email-mst@kernel.org>

On Fri, Jul 17, 2026 at 06:52:46AM -0400, Michael S. Tsirkin wrote:
> On Fri, Jul 17, 2026 at 12:46:52PM +0200, Greg Kroah-Hartman wrote:
> > On Fri, Jul 17, 2026 at 06:23:57AM -0400, Michael S. Tsirkin wrote:
> > > On Fri, Jul 17, 2026 at 12:15:09PM +0200, Greg Kroah-Hartman wrote:
> > > > On Fri, Jul 17, 2026 at 06:10:41AM -0400, Michael S. Tsirkin wrote:
> > > > > On Fri, Jul 17, 2026 at 11:14:23AM +0200, Greg Kroah-Hartman wrote:
> > > > > > On Fri, Jul 17, 2026 at 04:59:32AM -0400, Michael S. Tsirkin wrote:
> > > > > > > On Fri, Jul 17, 2026 at 10:39:40AM +0200, David Hildenbrand (Arm) wrote:
> > > > > > > > On 7/17/26 07:48, Michael S. Tsirkin wrote:
> > > > > > > > > On Thu, Jul 16, 2026 at 05:59:05PM +0200, David Hildenbrand (Arm) wrote:
> > > > > > > > >>> Or do we just always trust virtio mem devices explicitly?
> > > > > > > > >>
> > > > > > > > >> It's hard for me to understand where we draw the line, really.
> > > > > > > > >>
> > > > > > > > >> But maybe MST can clarify what we care about in virtio world where the
> > > > > > > > >> hypervisor is fully in charge of the device,
> > > > > > > > > 
> > > > > > > > > Generally:
> > > > > > > > > - The guest is expected to whitelist drivers (most drivers have not
> > > > > > > > >   been audited).
> > > > > > > > 
> > > > > > > > But even if you audited your driver, who makes sure that we consider all ways
> > > > > > > > where the device could mess with us?
> > > > > > > 
> > > > > > > A lot of this is up to a correct setup. For example, make sure all
> > > > > > > filesystems are encrypted and refuse to mount unencrypted ones.
> > > > > > > 
> > > > > > > > Something feels off here.
> > > > > > > > 
> > > > > > > > Handling selected out-of-spec scenarios like this feels like a band-aid. Happy
> > > > > > > > to be corrected.
> > > > > > > 
> > > > > > > Well Documentation/security/snp-tdx-threat-model.rst puts it like this:
> > > > > > > 	It is important to note
> > > > > > > 	that this doesn’t imply that the host or VMM are intentionally
> > > > > > > 	malicious, but that there exists a security value in having a small CoCo
> > > > > > > 	VM TCB.
> > > > > > > 
> > > > > > > and
> > > > > > > 
> > > > > > > 	While traditionally the host has unlimited access to guest data and can
> > > > > > > 	leverage this access to attack the guest, the CoCo systems mitigate such
> > > > > > > 	attacks by adding security features like guest data confidentiality and
> > > > > > > 	integrity protection.
> > > > > > > 
> > > > > > > 
> > > > > > > now, when we are talking about "mitigation" it is indeed becoming a bit
> > > > > > > murky.
> > > > > > > 
> > > > > > > 
> > > > > > > For me, a rule of thumb I came up with is that if the validation happens
> > > > > > > to also be helful for users e.g. to work around buggy devices,
> > > > > > > or maybe because we feel failing gracefully is nice because this
> > > > > > > will allow to later make use of this config and old drivers will
> > > > > > > fail but at least not panic, then it is good to include.
> > > > > > 
> > > > > > Why not do what USB does?  Don't trust the device until AFTER probe()
> > > > > > succeeds?  All of the needed checking should happen before then, as that
> > > > > > is a "slow path" so lots of validation and the like can happen at that
> > > > > > point.
> > > > > > 
> > > > > > After that, during the normal data paths, after the driver is bound,
> > > > > > trust it all you want as attempting to validate every single packet is
> > > > > > just going to be impossible.
> > > > > > 
> > > > > > thanks,
> > > > > > 
> > > > > > greg k-h
> > > > > 
> > > > > People do expect that data path validation at this point.
> > > > 
> > > > Ok, so you want this patch :)
> > > > 
> > > > And more, as you need to treat everything from the host as "untrusted",
> > > > and it must be "verified".
> > > 
> > > Well. First it's not me) Second it's only specific configurations -
> > > for example there's no short term plan to validate filesystem code, people
> > > are expected to rely on encryption. The reasons have more to do
> > > with the available manpower than anything else.
> > 
> > Sure, but again, for subsystems, you have to define your threat model as
> > the LLMs are churning against the code base and coming up with lots of
> > crazy ideas if a device should or should not be trusted and spitting out
> > patches and reports like the ones that are in the first few patches of
> > this series.
> > 
> > So please, pick a model, let's document it, and go with that.  I am
> > getting directly conflicting responses here.
> > 
> > thanks,
> > 
> > greg k-h
> 
> Supposed to be this one:
> Documentation/security/snp-tdx-threat-model.rst
> 
> what is missing?

A policy decision that needs to be made.  All that document does is
describe a bunch of different "threats" yet does not decide what to do
about them at all from what I can tell.

And that's just for one subset of the CoC world, right?  Is that
something that all virtio drivers need/want to care about?

So I don't see a real answer to the "does Linux trust the host to give
you good data or not" question in that file, am I missing it?

thanks,

greg k-h
