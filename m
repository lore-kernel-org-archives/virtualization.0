Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30B533502A3;
	Mon, 20 Jul 2026 07:57:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784534240; cv=none; b=CpgCJoj25yJdm2DmXOUso3ev56CWE1iFMBo/Kf6c51YOLDbWC6w9piQ6BBlZUyfXnvhPp54evYbh8XynxRLfDwesm1lb1HP7WDb26VAcvmQBaf7LwYYK6pd4ByEFASYb+ItO9MRNjcZC5BCnMNF7eY7OTGATS+CtfKje7fVW+lw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784534240; c=relaxed/simple;
	bh=f+dSLCKr1c4O6kogYfegUckh3s10EtfuZYBQSeHXMlw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kKbfTPevPn+D7Q3oxUL6AdTI91JUulsp75Ah6i7Q8Sc+QGpx/9OUoebF2we4x6iYS+4BV4QB1RxMzWStYlbYfsNthqgoeZ9etiaGYM3r0SzeBqremXhQXsvmndCAp5UVZ0K4dowT6fZSdISXm/Q9mMdfJ00hXewyeqN8WWnflpU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kc2fksw2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kc2fksw2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B33801F000E9;
	Mon, 20 Jul 2026 07:57:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784534238;
	bh=HTc1DdLuxgcB4tAC6qIpYWdsraepckByndfkQacfo3E=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=kc2fksw2n0fS7T8FbzwsS+4nd1wgFpXutcmujZ6YV9Hq7MwHv+/ERaexD+5JiBZGF
	 C9G2Gdumn2RdSLx0PIGQCfDH6y7PBjNodKdeo9wHNdLtYS5v6IOfYBJB1ughfHLW0s
	 eVKdrQyDbzCXdp1SQJpJ5/LUtObIoPGxLXklB9LW4iy/kw7rhCnEO7GWTuVL0PeJvq
	 rryWuT+yF4tc8j5c2de+u7H+slxY30jtuP4KrkTZW2xjEOq9mR17g2h2tx2Z49JWkc
	 GlX5ZQel089zVaTTK66jzn/AULNloKjDZ8eikNw1eQSQw1mk6/GxSWlfAGgP/X1j4s
	 quRrXdWMq4Z+g==
Message-ID: <9569e577-aa82-4642-b9d9-fd496fc12849@kernel.org>
Date: Mon, 20 Jul 2026 08:57:13 +0100
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/4] virtio-mem: validate device-reported block size
To: Carlos Bilbao <carlos.bilbao.osdev@gmail.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Hari Mishal
 <harimishal1@gmail.com>, Jason Wang <jasowangio@gmail.com>,
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, =?UTF-8?Q?Eugenio_P=C3=A9rez?=
 <eperezma@redhat.com>, virtualization@lists.linux.dev,
 linux-kernel@vger.kernel.org, elena.reshetova@intel.com,
 huster@cs.uni-goettingen.de, mhollick@seemoo.de, jiska.classen@hpi.de
References: <20260717044019-mutt-send-email-mst@kernel.org>
 <2026071746-deviation-clad-1712@gregkh>
 <20260717060822-mutt-send-email-mst@kernel.org>
 <2026071757-grout-composer-165d@gregkh>
 <20260717061901-mutt-send-email-mst@kernel.org>
 <2026071724-asleep-pedigree-ea54@gregkh>
 <20260717065219-mutt-send-email-mst@kernel.org>
 <2026071759-thermal-synopsis-7568@gregkh>
 <20260717085838-mutt-send-email-mst@kernel.org>
 <1fe328d1-edf9-4e72-a145-be74ede20e60@gmail.com>
 <2026071803-passage-dares-8240@gregkh>
 <ae5bc86b-cb8d-4530-9e58-d285007deac0@gmail.com>
From: "David Hildenbrand (Arm)" <david@kernel.org>
Content-Language: en-US
Autocrypt: addr=david@kernel.org; keydata=
 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
 qIws/H2t
In-Reply-To: <ae5bc86b-cb8d-4530-9e58-d285007deac0@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 7/18/26 18:07, Carlos Bilbao wrote:
> On 7/17/26 22:29, Greg Kroah-Hartman wrote:
> 
>> On Fri, Jul 17, 2026 at 08:31:09PM -0700, Carlos Bilbao wrote:
>>> Historically, one of the biggest criticisms of coco, especially around
>>> device hardening, was that there were too many values that a
>>> malicious/buggy device could misreport, making it a losing battle. That is
>>> no longer the case with LLMs, and we have the advantage (and challenge) of
>>> open-source dev, which allows us to receive many of these fixes "for free".
>>> If others want to burn their tokens, let them :)
>> I have lots of tokens to burn :)
>>
>> So along those lines, any suggestions on how best to fuzz these code
>> paths?  Any workloads you all use for testing that I can take advantage
>> of?
> 
> 
> We've the virtio-mem config struct layout and the kernel source, so for
> obvious fixes like a NULL check, static analysis is better than fuzzing.
> Claude took a few mins to find me two examples:
> 
> Patch 1: virtio-mem: reject non-power-of-two device_block_size
> This one is for virtio_mem_init() to check if
> !is_power_of_2(vm->device_block_size)
> 
> Patch 2: virto-mem: validate region_size and usable_region_size
> THis one checks region_size != 0 and vm->usable_reion_size >
> vm->region_size.
> 
> An endless factory of "silly" checks like these are low hanging fruit.
> 
> Now, for harder bugs, looking around for fuzz options, VirtFuzz [1] looks
> like a great candidate for those interested in pursuing this direction.
> 
> 
> Their PoC fuzzes wireless/Bluetooth stack, but nothing our AI overlords
> can't quickly adapt for virtio-mem and other virtio drivers; the JSON
> definition to describe device behavior is easily extensible. Their threat
> model [2] describes an external attacker, but in the context of coco, the
> virtio device itself is the attacker. Here's a vibe coded PR of what I mean:
> 
> https://github.com/seemoo-lab/VirtFuzz/pull/7
> 
> CCed the creators/authors, thanks for open sourcing this!
> 
> Thanks,
> Carlos
> 
> [1] https://github.com/seemoo-lab/VirtFuzz
> 
> On 7/17/26 22:29, Greg Kroah-Hartman wrote:
> 
>> On Fri, Jul 17, 2026 at 08:31:09PM -0700, Carlos Bilbao wrote:
>>> Historically, one of the biggest criticisms of coco, especially around
>>> device hardening, was that there were too many values that a
>>> malicious/buggy device could misreport, making it a losing battle. That is
>>> no longer the case with LLMs, and we have the advantage (and challenge) of
>>> open-source dev, which allows us to receive many of these fixes "for free".
>>> If others want to burn their tokens, let them :)
>> I have lots of tokens to burn :)
>>
>> So along those lines, any suggestions on how best to fuzz these code
>> paths?  Any workloads you all use for testing that I can take advantage
>> of?
> 
> 
> We've the virto-mem config struct layout and the kernel source, so for
> obvious fixes like a NULL check, static analysis is better than fuzzing.
> Claude took a few mins to find me two examples:
> 
> Patch 1: virtio-mem: reject non-power-of-two device_block_size
> This one is for virtio_mem_init() to check if
> !is_power_of_2(vm->device_block_size)
> 
> Patch 2: virto-mem: validate region_size and usable_region_size
> THis one checks region_size != 0 and vm->usable_reion_size >
> vm->region_size.
> 
> An endless factory of "silly" checks like these are low hanging fruit.

"silly" is the right word.

-- 
Cheers,

David
