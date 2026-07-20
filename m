Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FF823B14D4;
	Mon, 20 Jul 2026 08:28:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784536094; cv=none; b=K9Z0fjy4KR6wJE0S2tgXYO7aGI+LXghBH/iBRUPCZxJAiHnk3335HkjYjtm5UhjomZfUAm4rgLLKOdeUV9TwpcGjE16oWSOE7mobJr5rEjEhJZN7e0xcP7XI5wCZXAEm3MVg7SfGYwwu2aTj6t5cBFdRlHwOvN2pTejVCOW+8+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784536094; c=relaxed/simple;
	bh=pQm8wE1zzfwQ1Q1y8IWZKswczt609jybIymdmS7u7jU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MimVoE1War4NldtxiwMY4H6z8FtSsqO9D7T3wpOIEHcmOpVd5KmaJ2vJEPp0cNblKwEmpl4j2JwM/yNCWtiUFEEAXIwssh680Sw6oetQyN8KR/AWtd3Yt8hcNDva2Km+GIeZUecTk8Rx495EZpCuNpf8TLKPys3gczyAAgdeRxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=lEnivznq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="lEnivznq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B14241F000E9;
	Mon, 20 Jul 2026 08:28:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1784536092;
	bh=f2OcSUcTGX9uAPUPbSgVN6K2hpU1dKBs/Tgszp+UqfM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=lEnivznq73gMaQAmE1zJH52LJ6t8PMqQLPLotaYaEsYVxVOOEb0ykTa3farbSAG/p
	 VlhQAa9hUY6cz99KL2gen7D4/MuuT6ROHkrcxc6HUPpH/gmYhjr5LdC+qwYF+BdXe9
	 /dO4od+BNnKIPMQZXBon7qNYNXdrBRf6WkKrskns=
Date: Mon, 20 Jul 2026 10:28:03 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: Carlos Bilbao <carlos.bilbao.osdev@gmail.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Hari Mishal <harimishal1@gmail.com>,
	Jason Wang <jasowangio@gmail.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org,
	elena.reshetova@intel.com, huster@cs.uni-goettingen.de,
	mhollick@seemoo.de, jiska.classen@hpi.de
Subject: Re: [PATCH v2 1/4] virtio-mem: validate device-reported block size
Message-ID: <2026072036-outburst-rebel-c71b@gregkh>
References: <2026071757-grout-composer-165d@gregkh>
 <20260717061901-mutt-send-email-mst@kernel.org>
 <2026071724-asleep-pedigree-ea54@gregkh>
 <20260717065219-mutt-send-email-mst@kernel.org>
 <2026071759-thermal-synopsis-7568@gregkh>
 <20260717085838-mutt-send-email-mst@kernel.org>
 <1fe328d1-edf9-4e72-a145-be74ede20e60@gmail.com>
 <2026071803-passage-dares-8240@gregkh>
 <ae5bc86b-cb8d-4530-9e58-d285007deac0@gmail.com>
 <9569e577-aa82-4642-b9d9-fd496fc12849@kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9569e577-aa82-4642-b9d9-fd496fc12849@kernel.org>

On Mon, Jul 20, 2026 at 08:57:13AM +0100, David Hildenbrand (Arm) wrote:
> On 7/18/26 18:07, Carlos Bilbao wrote:
> > On 7/17/26 22:29, Greg Kroah-Hartman wrote:
> > 
> >> On Fri, Jul 17, 2026 at 08:31:09PM -0700, Carlos Bilbao wrote:
> >>> Historically, one of the biggest criticisms of coco, especially around
> >>> device hardening, was that there were too many values that a
> >>> malicious/buggy device could misreport, making it a losing battle. That is
> >>> no longer the case with LLMs, and we have the advantage (and challenge) of
> >>> open-source dev, which allows us to receive many of these fixes "for free".
> >>> If others want to burn their tokens, let them :)
> >> I have lots of tokens to burn :)
> >>
> >> So along those lines, any suggestions on how best to fuzz these code
> >> paths?  Any workloads you all use for testing that I can take advantage
> >> of?
> > 
> > 
> > We've the virtio-mem config struct layout and the kernel source, so for
> > obvious fixes like a NULL check, static analysis is better than fuzzing.
> > Claude took a few mins to find me two examples:
> > 
> > Patch 1: virtio-mem: reject non-power-of-two device_block_size
> > This one is for virtio_mem_init() to check if
> > !is_power_of_2(vm->device_block_size)
> > 
> > Patch 2: virto-mem: validate region_size and usable_region_size
> > THis one checks region_size != 0 and vm->usable_reion_size >
> > vm->region_size.
> > 
> > An endless factory of "silly" checks like these are low hanging fruit.
> > 
> > Now, for harder bugs, looking around for fuzz options, VirtFuzz [1] looks
> > like a great candidate for those interested in pursuing this direction.
> > 
> > 
> > Their PoC fuzzes wireless/Bluetooth stack, but nothing our AI overlords
> > can't quickly adapt for virtio-mem and other virtio drivers; the JSON
> > definition to describe device behavior is easily extensible. Their threat
> > model [2] describes an external attacker, but in the context of coco, the
> > virtio device itself is the attacker. Here's a vibe coded PR of what I mean:
> > 
> > https://github.com/seemoo-lab/VirtFuzz/pull/7
> > 
> > CCed the creators/authors, thanks for open sourcing this!
> > 
> > Thanks,
> > Carlos
> > 
> > [1] https://github.com/seemoo-lab/VirtFuzz
> > 
> > On 7/17/26 22:29, Greg Kroah-Hartman wrote:
> > 
> >> On Fri, Jul 17, 2026 at 08:31:09PM -0700, Carlos Bilbao wrote:
> >>> Historically, one of the biggest criticisms of coco, especially around
> >>> device hardening, was that there were too many values that a
> >>> malicious/buggy device could misreport, making it a losing battle. That is
> >>> no longer the case with LLMs, and we have the advantage (and challenge) of
> >>> open-source dev, which allows us to receive many of these fixes "for free".
> >>> If others want to burn their tokens, let them :)
> >> I have lots of tokens to burn :)
> >>
> >> So along those lines, any suggestions on how best to fuzz these code
> >> paths?  Any workloads you all use for testing that I can take advantage
> >> of?
> > 
> > 
> > We've the virto-mem config struct layout and the kernel source, so for
> > obvious fixes like a NULL check, static analysis is better than fuzzing.
> > Claude took a few mins to find me two examples:
> > 
> > Patch 1: virtio-mem: reject non-power-of-two device_block_size
> > This one is for virtio_mem_init() to check if
> > !is_power_of_2(vm->device_block_size)
> > 
> > Patch 2: virto-mem: validate region_size and usable_region_size
> > THis one checks region_size != 0 and vm->usable_reion_size >
> > vm->region_size.
> > 
> > An endless factory of "silly" checks like these are low hanging fruit.
> 
> "silly" is the right word.

"silly" in what way?

Seriously, I'm trying to figure out what you all care about here and
what exactly the threat model you want this driver to work in, and I'm
getting conflicting answers.

Either you all do worry about the "device" sending bad data and want to
protect from that, or you don't and you trust it.  Pick one please so
that we know how to deal with these bug reports we are getting.

For example, for USB we have said our threat model is:

  - we do NOT trust the device before a driver is bound to the device,
    so if a malicious device can do something to the kernel, the kernel
    needs to be fixed.
  - During the probe() call for a USB driver, the driver does NOT trust
    the device, and again, anything a malicious device can do to the
    kernel, the kernel should fix.
  - After probe() for a USB driver succeeds, it's up to the driver if it
    wants to validate all data coming from the device or not.  Right
    now, in general, the kernel trusts the device at that point in time
    so additional checks are discretionary and at the whim of the
    maintainer.

For that last point, I will note that some BIG users of Linux (i.e.
billions of Android devices) still explicitly do NOT want to trust the
USB device at this point in time, and are relying on the kernel to
protect the system from bad devices.  In that case, various patches have
been taken to different drivers and subsystems to play whack-a-mole on
while Android gets their act together to finally come up with a solid
defensive plan (like ChromeOS has had for a decade.)  It will be seen
which happens first, all drivers are properly fuzzed and fixed up, or
Android gets their act together and finally fixes their b0rked system
trust model.  I think Android management is relying on the kernel
community to do the kernel work as they keep refusing to staff the
userspace work that they need to do here...

And yes, I really need to write this up in a more solid document for USB
and get it into the tree, but at least this email thread has forced me
to write down the above :)


So, again, for virtio drivers, what exactly do you all want to say is
your threat model that the drivers need to handle?  Can you all agree on
something please?  Otherwise, for new developers like Hari, this is
totaly confusion as to what they should be doing.

thanks,

greg k-h
