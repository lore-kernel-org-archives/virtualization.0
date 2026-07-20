Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8257225775;
	Mon, 20 Jul 2026 09:19:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784539154; cv=none; b=Pt0gpxgFIpzTefu11hI2G4rf/iyOMpOpGjaKJrcvyyRDFJI1fIY4irodJjPsCHIYELuT6+i/qf8VhjZKs90M8h+ToJWlCzoAk3F7nsD1opiCYIjEfw09shxfFThyFsgiNPMrKNfsaBCF5nq62EergSwCT/HB+iIoviv41Fb/TXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784539154; c=relaxed/simple;
	bh=ofItN/0KklKTFKqq2IJ1f8qp/AjbRaGdZsnOCa00tnA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kNSJHPqetNN6ELYWiPI+jQ0ahiDPb1ehOL1UokEw7+RU+P9amAWK5WP7YhxmccgKQRmu9y08FZmDRqnCSCb32PtJUcoNdeGbODCqZrUHIZY1iFSpFDMt7XANEr7CBs/RABS2jtAZhhw7QJO1Tbb3QzqN9dJpP8790U2jFtHt+/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V9A7v2Uw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V9A7v2Uw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 272D01F000E9;
	Mon, 20 Jul 2026 09:19:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784539153;
	bh=sOZ25ao2M2d19WvDiN3lH8T4Vu10ouOQROWrJY5Nxkw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=V9A7v2UwKNZyhKWq7ZrKejum3QmW+L8sNyc8l64ga1ZcNGA9a/7Ke8sEeUwZNIcAf
	 9ma/UFI4g2LPhJ5DV4geTumwCm/8W2al5cQWyVk6dNAUOFqDAostDpCB64GNCTQG8/
	 4n7os4daWZUxgGdmkHj0ehZVK78tDnIjLGOHeI/H6lRBTwd7se1ormFawONgZi3F5s
	 fmuC6pei1px1fuJJEAZzKETu38VwL1gNg4OORl/+6mTG6qMnWeZrKpXIyfcASRwTFY
	 jGcWrUF1w53RFODPJSkqHKRFtp82MTH176k+vz+P8+L7R6kg3gUk2UX96NUPjwS3uP
	 Epc4ekV5TIY6A==
Message-ID: <8237ffef-4fb4-40b4-82c3-e9236032ab7e@kernel.org>
Date: Mon, 20 Jul 2026 10:19:09 +0100
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/4] virtio-mem: validate device-reported block size
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Carlos Bilbao <carlos.bilbao.osdev@gmail.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Hari Mishal <harimishal1@gmail.com>,
 Jason Wang <jasowangio@gmail.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
 =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>,
 virtualization@lists.linux.dev, linux-kernel@vger.kernel.org,
 elena.reshetova@intel.com, huster@cs.uni-goettingen.de, mhollick@seemoo.de,
 jiska.classen@hpi.de
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
 <2026072036-outburst-rebel-c71b@gregkh>
From: "David Hildenbrand (Arm)" <david@kernel.org>
Content-Language: en-US
Autocrypt: addr=david@kernel.org; keydata=
 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
 qIws/H2t
In-Reply-To: <2026072036-outburst-rebel-c71b@gregkh>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

>>> We've the virto-mem config struct layout and the kernel source, so for
>>> obvious fixes like a NULL check, static analysis is better than fuzzing.
>>> Claude took a few mins to find me two examples:
>>>
>>> Patch 1: virtio-mem: reject non-power-of-two device_block_size
>>> This one is for virtio_mem_init() to check if
>>> !is_power_of_2(vm->device_block_size)
>>>
>>> Patch 2: virto-mem: validate region_size and usable_region_size
>>> THis one checks region_size != 0 and vm->usable_reion_size >
>>> vm->region_size.
>>>
>>> An endless factory of "silly" checks like these are low hanging fruit.
>>
>> "silly" is the right word.
> 
> "silly" in what way?
>

As in producing "silly" low-hanging fruit patches that don't move the needle
when it comes to security.

> Seriously, I'm trying to figure out what you all care about here and
> what exactly the threat model you want this driver to work in, and I'm
> getting conflicting answers.
> 
> Either you all do worry about the "device" sending bad data and want to
> protect from that, or you don't and you trust it.  Pick one please so
> that we know how to deal with these bug reports we are getting.
> 
> For example, for USB we have said our threat model is:
> 
>   - we do NOT trust the device before a driver is bound to the device,
>     so if a malicious device can do something to the kernel, the kernel
>     needs to be fixed.
>   - During the probe() call for a USB driver, the driver does NOT trust
>     the device, and again, anything a malicious device can do to the
>     kernel, the kernel should fix.
>   - After probe() for a USB driver succeeds, it's up to the driver if it
>     wants to validate all data coming from the device or not.  Right
>     now, in general, the kernel trusts the device at that point in time
>     so additional checks are discretionary and at the whim of the
>     maintainer.
> 
> For that last point, I will note that some BIG users of Linux (i.e.
> billions of Android devices) still explicitly do NOT want to trust the
> USB device at this point in time, and are relying on the kernel to
> protect the system from bad devices.  In that case, various patches have
> been taken to different drivers and subsystems to play whack-a-mole on
> while Android gets their act together to finally come up with a solid
> defensive plan (like ChromeOS has had for a decade.)  It will be seen
> which happens first, all drivers are properly fuzzed and fixed up, or
> Android gets their act together and finally fixes their b0rked system
> trust model.  I think Android management is relying on the kernel
> community to do the kernel work as they keep refusing to staff the
> userspace work that they need to do here...

Right, and for virtio devices trusting the device after probe is just extremely
questionable.

What changes during probe that the device suddenly sends us good data?

Why would a hypervisor that tried to break us before probe not try to break us
after probe?

> 
> And yes, I really need to write this up in a more solid document for USB
> and get it into the tree, but at least this email thread has forced me
> to write down the above :)
> 
> 
> So, again, for virtio drivers, what exactly do you all want to say is
> your threat model that the drivers need to handle?  Can you all agree on
> something please?  Otherwise, for new developers like Hari, this is
> totaly confusion as to what they should be doing.

Well, I am also totally confused why we end up checking against some MUST
clauses in the spec, but not against others.

I am very much in favor of making virtio-mem completely safe to use even in
coco, where it is currently not used at all.

If it's really about "don't let a device trigger any unexpected kernel code
execution by sanitizing all input data", fine with me. We should do exactly
that. Try checking all MUST clauses etc.

But I don't think doing the "low hanging fruit" adds any security. It should be
done properly or not at all.

-- 
Cheers,

David
