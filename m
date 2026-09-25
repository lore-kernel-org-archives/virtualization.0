Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 108BF3AD538;
	Fri, 25 Sep 2026 16:48:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790354918; cv=none; b=utmtaOl1dHvK1k7J2QwtBP7FRSN+Oc7k4OGGCSSs0MxQsWQb4HaRBbV9ZjdKVE38fwTAys6tz6oyfoIeqWNUCZeJ4FxluzBJS65vc7XVCwB6TESqXLXTJ2PWq+wxNXQqAX4VgJYc6Mz7EsnGnN+TLuX7IPr/V7ZWp4F2Mt7CR8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790354918; c=relaxed/simple;
	bh=TzUGic9pMOny7EGR5g7usgpgx797/IJRE1u9ts1Wm0g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PYaDOq2pH2g7tjofFCXb3aJkCvgujZzZohgKz/IbVq+kxKKDXcmbpxdQiNI43k3q/wvWjjTbBtoBMsDD69QGQLVTJ/uhtVr41wgA1sLlXMhirsZ7pAAicB9L9yAdDiSvx3EygrtG6QTVdem3zJsK45vQYm1QHtcCwcg+g+gxUSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=ofYM+MpN; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="ofYM+MpN"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 02AD4169C;
	Fri, 25 Sep 2026 09:48:26 -0700 (PDT)
Received: from [10.2.212.23] (e121345-lin.cambridge.arm.com [10.2.212.23])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 22A6D3F86F;
	Fri, 25 Sep 2026 09:48:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1790354909; bh=TzUGic9pMOny7EGR5g7usgpgx797/IJRE1u9ts1Wm0g=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=ofYM+MpN4pf0AQiHkEr6+VnR19TayQDECqyBJXDP5SqIguchrv1aGdXz4dXVLNmhb
	 dfFleGp0EeFmpr1ed3q40j4OQLi8cop06TNfATdKAfliLLJDCFKwbpMmZn39nVKi1m
	 Qn97RoWBgt5cO39iAOiYsEnFxJY7QXFKUVOFe83M=
Message-ID: <1b55f680-2413-4db1-b928-ed5741696d07@arm.com>
Date: Fri, 25 Sep 2026 17:48:25 +0100
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 06/12] remoteproc: virtio: add bounce buffering for
 data buffers
To: Mathieu Poirier <mathieu.poirier@linaro.org>,
 Francesco Valla <francesco@valla.it>
Cc: Bjorn Andersson <andersson@kernel.org>, Kees Cook <kees@kernel.org>,
 "Gustavo A. R. Silva" <gustavoars@kernel.org>,
 Marek Szyprowski <m.szyprowski@samsung.com>, Mark Brown
 <broonie@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Frank Li <Frank.Li@nxp.com>,
 Peng Fan <peng.fan@nxp.com>, Sascha Hauer <s.hauer@pengutronix.de>,
 linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, virtualization@lists.linux.dev,
 imx@lists.linux.dev, iommu@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org
References: <20260916-remoteproc_virtio_map-v1-0-dac8c5eb4aa9@valla.it>
 <20260916-remoteproc_virtio_map-v1-6-dac8c5eb4aa9@valla.it>
 <arKlvZGqu2nt6Ci0@p14s> <arLXthhYbKkwZ9zY@bywater>
 <CANLsYkwNOukGX68=NVvwNP7iudP3EcKN6C2L2o9nVCTRxFVxFg@mail.gmail.com>
 <arP38OEaabFFu8lJ@bywater> <araOI_duKIAbphq6@p14s>
From: Robin Murphy <robin.murphy@arm.com>
Content-Language: en-GB
In-Reply-To: <araOI_duKIAbphq6@p14s>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 25/09/2026 4:07 pm, Mathieu Poirier wrote:
> On Wed, Sep 23, 2026 at 06:05:35PM +0200, Francesco Valla wrote:
>> On Wed, Sep 23, 2026 at 08:44:41AM -0600, Mathieu Poirier wrote:
>>> On Tue, 22 Sept 2026 at 13:39, Francesco Valla <francesco@valla.it> wrote:
>>>>
>>>> On Tue, Sep 22, 2026 at 09:58:53AM -0600, Mathieu Poirier wrote:
>>>>> On Wed, Sep 16, 2026 at 11:10:51PM +0200, Francesco Valla wrote:
>>>>>> Depending on the driver originating them, data buffers used for virtio
>>>>>> communication can either:
>>>>>>
>>>>>>    - already be allocated from the coherent memory area that is
>>>>>>      accessible by the remote processor; this is the case of rpmsg
>>>>>>      and the rproc flavor of virtio-console;
>>>>>>    - be allocated from generic kmem, and thus not accessible directly by
>>>>>>      the remote processor.
>>>>>>
>>>>>> Exploiting the map operations, which are used by the virtio framework
>>>>>> when VIRTIO_F_ACCESS_PLATFORM is part of a vdev's feature flags, add
>>>>>> bounce buffering for the second case: when the map() callback is called
>>>>>> for a buffer, one or more pages of coherent memory are allocated and
>>>>>> data is copied to them, then they are exposed to the remote processor;
>>>>>> the data is  then bounced back on unmap().
>>>>>>
>>>>>> The first case is not impacted, since buffers already suitable for
>>>>>> remote transmission are passed through.
>>>>>>
>>>>>> With the bounce buffering in place, any kind of virtio device can be
>>>>>> supported through the remoteproc-virtio transport, at least from a
>>>>>> data exchange standpoint.
>>>>>
>>>>> Is this _necessary_ for the imx93 platform you are implementing feature for?
>>>>>
>>>>
>>>> If I don't want to fundamentally change how the remoteproc integration
>>>> works (i.e.: using buffers only from a pre-shared area), yes. While in
>>>> my test environment the Cortex-M33 serving as remoteproc is able to
>>>> access the whole RAM space, that is not always the case.
>>>
>>> The first sentence tells me it is mandatory while the second says it
>>> is not.  I understand the use case but don't want to bloat the
>>> subsystem with code that is trying to address a problem you currently
>>> don't have.
>>>
>>
>> Let me rephrase: while on i.MX93 the Cortex-M33 can theoretically access
>> the whole RAM space, that is not a good idea from a security point of
>> view and can be the source of a number of bugs. The target is to
>> statically define a static shared memory area (as I am doing on i.MX95)
>> and only use that.
> 
> As Robin pointed out, have you looked at using a restricted-dma-pool for that?
> Note that I am not familiar with the concept but open to go that way if it can
> work for us.
> 
> Robin, can you point us to a simple example we could look at?
The only in-tree example is mt8192-asurada.dtsi, but even there the 
fundamental principle seems exactly the same - the system interconnect 
is locked down such that there's only a particular region of "shared" 
memory that PCIe DMA can access, so the restricted pool is placed there, 
and in that case can occupy the entire region since the wifi adapter 
only really does streaming DMA - restricted pools have some limited 
ability to act as a fallback for coherent allocations, which won't work 
for everything, but does happen to be enough for that wifi driver.

Here it would be a case of reserving some of the shared region for a 
restricted pool alongside the "vdevbuffer" coherent pool, adding it to 
the memory-region list of the relevant device(s), and usually that would 
then just work, since the setup is all done automatically by the core DT 
code. However I know remoteproc does some funky stuff with child 
devices, so it's quite possible there might need to be something more 
done there. But still far, far less than reimplementing a whole other 
bounce-buffering system.

Thanks,
Robin.
