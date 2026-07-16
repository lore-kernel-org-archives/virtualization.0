Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE1F5326939;
	Thu, 16 Jul 2026 15:59:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784217549; cv=none; b=QbECHYs47e7q1zCr5XlPXeGWKQWimyarSuSaUyn4qOTsO1RrAjQDRx49Y/IQ0NdjkGOHkRtudiASVbN8vhfbw9If8DHbmuyBrXpBReAYElqy4n1oj928Skvjag8qrbXiO3S/jc4fh+zu7p3JqMFpx8yUTDV0xknfxHNdOtK8/uk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784217549; c=relaxed/simple;
	bh=o9J/LzxGBatWLKXqnEywvDyDPx7v734TbngQgdcQdu8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LPvHFKMV6pgNw20VGh4NcU6tC48Orvizg5AfKfNfnx6XW0YdK/kJiaQQ0unqzi2XS5CYcns2KsKN2MMc3kOZE6kiXul0yu+xF52yUX0r37/ppYvglwML8r1B3QH4zDWzcEwDhX7JGThjOgkuGlHjeRGH4M7UlQtlIGiO9yIH9Xc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hvhizm3c; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hvhizm3c"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12CCE1F000E9;
	Thu, 16 Jul 2026 15:59:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784217548;
	bh=VvrAaVuJW2sJqd5QlurBdy47wMk/grx8DjUuKRz+kNo=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=hvhizm3cEUd0tiIyUAGB+X7wFnEYxAEVoYmT5A+icAS5L0y72o1pgB1mPISoso9TQ
	 fM8M1d96fm3i8dL9QiKRTG2x0OtIVl5cZz6eAAg9EGQaxYZVIB3IacKLtkZIxcNRB4
	 nQ6XxyIHD35n6/olcc4q2liTh7ipLnbB1yzvi2FBKe4cCUzPZs0fyJgrgEf69mPCz+
	 +zVuX57YbeDG2lgJ6TbXTvpSMW00biFUbJuw8g89wKmHU2yS+R4EwXsOniFkb29WKG
	 UtJXj9x+xdGiQtOMUrGPAwrGgFZf9q2xfiSQ6JBD2p4LClVjmA6ZuxPspnHbtHUVKH
	 gdYRZ6JaOjtUQ==
Message-ID: <4dda47ba-534a-4297-a25e-0d63d9167033@kernel.org>
Date: Thu, 16 Jul 2026 17:59:05 +0200
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/4] virtio-mem: validate device-reported block size
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Hari Mishal <harimishal1@gmail.com>, "Michael S . Tsirkin"
 <mst@redhat.com>, Jason Wang <jasowangio@gmail.com>,
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, =?UTF-8?Q?Eugenio_P=C3=A9rez?=
 <eperezma@redhat.com>, virtualization@lists.linux.dev,
 linux-kernel@vger.kernel.org
References: <20260715142337.22811-2-harimishal1@gmail.com>
 <20260715164139.40957-1-harimishal1@gmail.com>
 <b2176313-b444-4f66-a71c-647b92cc16a8@kernel.org>
 <2026071635-relive-flogging-2a81@gregkh>
From: "David Hildenbrand (Arm)" <david@kernel.org>
Content-Language: en-US
Autocrypt: addr=david@kernel.org; keydata=
 xsFNBFXLn5EBEAC+zYvAFJxCBY9Tr1xZgcESmxVNI/0ffzE/ZQOiHJl6mGkmA1R7/uUpiCjJ
 dBrn+lhhOYjjNefFQou6478faXE6o2AhmebqT4KiQoUQFV4R7y1KMEKoSyy8hQaK1umALTdL
 QZLQMzNE74ap+GDK0wnacPQFpcG1AE9RMq3aeErY5tujekBS32jfC/7AnH7I0v1v1TbbK3Gp
 XNeiN4QroO+5qaSr0ID2sz5jtBLRb15RMre27E1ImpaIv2Jw8NJgW0k/D1RyKCwaTsgRdwuK
 Kx/Y91XuSBdz0uOyU/S8kM1+ag0wvsGlpBVxRR/xw/E8M7TEwuCZQArqqTCmkG6HGcXFT0V9
 PXFNNgV5jXMQRwU0O/ztJIQqsE5LsUomE//bLwzj9IVsaQpKDqW6TAPjcdBDPLHvriq7kGjt
 WhVhdl0qEYB8lkBEU7V2Yb+SYhmhpDrti9Fq1EsmhiHSkxJcGREoMK/63r9WLZYI3+4W2rAc
 UucZa4OT27U5ZISjNg3Ev0rxU5UH2/pT4wJCfxwocmqaRr6UYmrtZmND89X0KigoFD/XSeVv
 jwBRNjPAubK9/k5NoRrYqztM9W6sJqrH8+UWZ1Idd/DdmogJh0gNC0+N42Za9yBRURfIdKSb
 B3JfpUqcWwE7vUaYrHG1nw54pLUoPG6sAA7Mehl3nd4pZUALHwARAQABzS5EYXZpZCBIaWxk
 ZW5icmFuZCAoQ3VycmVudCkgPGRhdmlkQGtlcm5lbC5vcmc+wsGQBBMBCAA6AhsDBQkmWAik
 AgsJBBUKCQgCFgICHgUCF4AWIQQb2cqtc1xMOkYN/MpN3hD3AP+DWgUCaYJt/AIZAQAKCRBN
 3hD3AP+DWriiD/9BLGEKG+N8L2AXhikJg6YmXom9ytRwPqDgpHpVg2xdhopoWdMRXjzOrIKD
 g4LSnFaKneQD0hZhoArEeamG5tyo32xoRsPwkbpIzL0OKSZ8G6mVbFGpjmyDLQCAxteXCLXz
 ZI0VbsuJKelYnKcXWOIndOrNRvE5eoOfTt2XfBnAapxMYY2IsV+qaUXlO63GgfIOg8RBaj7x
 3NxkI3rV0SHhI4GU9K6jCvGghxeS1QX6L/XI9mfAYaIwGy5B68kF26piAVYv/QZDEVIpo3t7
 /fjSpxKT8plJH6rhhR0epy8dWRHk3qT5tk2P85twasdloWtkMZ7FsCJRKWscm1BLpsDn6EQ4
 jeMHECiY9kGKKi8dQpv3FRyo2QApZ49NNDbwcR0ZndK0XFo15iH708H5Qja/8TuXCwnPWAcJ
 DQoNIDFyaxe26Rx3ZwUkRALa3iPcVjE0//TrQ4KnFf+lMBSrS33xDDBfevW9+Dk6IISmDH1R
 HFq2jpkN+FX/PE8eVhV68B2DsAPZ5rUwyCKUXPTJ/irrCCmAAb5Jpv11S7hUSpqtM/6oVESC
 3z/7CzrVtRODzLtNgV4r5EI+wAv/3PgJLlMwgJM90Fb3CB2IgbxhjvmB1WNdvXACVydx55V7
 LPPKodSTF29rlnQAf9HLgCphuuSrrPn5VQDaYZl4N/7zc2wcWM7BTQRVy5+RARAA59fefSDR
 9nMGCb9LbMX+TFAoIQo/wgP5XPyzLYakO+94GrgfZjfhdaxPXMsl2+o8jhp/hlIzG56taNdt
 VZtPp3ih1AgbR8rHgXw1xwOpuAd5lE1qNd54ndHuADO9a9A0vPimIes78Hi1/yy+ZEEvRkHk
 /kDa6F3AtTc1m4rbbOk2fiKzzsE9YXweFjQvl9p+AMw6qd/iC4lUk9g0+FQXNdRs+o4o6Qvy
 iOQJfGQ4UcBuOy1IrkJrd8qq5jet1fcM2j4QvsW8CLDWZS1L7kZ5gT5EycMKxUWb8LuRjxzZ
 3QY1aQH2kkzn6acigU3HLtgFyV1gBNV44ehjgvJpRY2cC8VhanTx0dZ9mj1YKIky5N+C0f21
 zvntBqcxV0+3p8MrxRRcgEtDZNav+xAoT3G0W4SahAaUTWXpsZoOecwtxi74CyneQNPTDjNg
 azHmvpdBVEfj7k3p4dmJp5i0U66Onmf6mMFpArvBRSMOKU9DlAzMi4IvhiNWjKVaIE2Se9BY
 FdKVAJaZq85P2y20ZBd08ILnKcj7XKZkLU5FkoA0udEBvQ0f9QLNyyy3DZMCQWcwRuj1m73D
 sq8DEFBdZ5eEkj1dCyx+t/ga6x2rHyc8Sl86oK1tvAkwBNsfKou3v+jP/l14a7DGBvrmlYjO
 59o3t6inu6H7pt7OL6u6BQj7DoMAEQEAAcLBfAQYAQgAJgIbDBYhBBvZyq1zXEw6Rg38yk3e
 EPcA/4NaBQJonNqrBQkmWAihAAoJEE3eEPcA/4NaKtMQALAJ8PzprBEXbXcEXwDKQu+P/vts
 IfUb1UNMfMV76BicGa5NCZnJNQASDP/+bFg6O3gx5NbhHHPeaWz/VxlOmYHokHodOvtL0WCC
 8A5PEP8tOk6029Z+J+xUcMrJClNVFpzVvOpb1lCbhjwAV465Hy+NUSbbUiRxdzNQtLtgZzOV
 Zw7jxUCs4UUZLQTCuBpFgb15bBxYZ/BL9MbzxPxvfUQIPbnzQMcqtpUs21CMK2PdfCh5c4gS
 sDci6D5/ZIBw94UQWmGpM/O1ilGXde2ZzzGYl64glmccD8e87OnEgKnH3FbnJnT4iJchtSvx
 yJNi1+t0+qDti4m88+/9IuPqCKb6Stl+s2dnLtJNrjXBGJtsQG/sRpqsJz5x1/2nPJSRMsx9
 5YfqbdrJSOFXDzZ8/r82HgQEtUvlSXNaXCa95ez0UkOG7+bDm2b3s0XahBQeLVCH0mw3RAQg
 r7xDAYKIrAwfHHmMTnBQDPJwVqxJjVNr7yBic4yfzVWGCGNE4DnOW0vcIeoyhy9vnIa3w1uZ
 3iyY2Nsd7JxfKu1PRhCGwXzRw5TlfEsoRI7V9A8isUCoqE2Dzh3FvYHVeX4Us+bRL/oqareJ
 CIFqgYMyvHj7Q06kTKmauOe4Nf0l0qEkIuIzfoLJ3qr5UyXc2hLtWyT9Ir+lYlX9efqh7mOY
 qIws/H2t
In-Reply-To: <2026071635-relive-flogging-2a81@gregkh>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/16/26 16:18, Greg Kroah-Hartman wrote:
> On Thu, Jul 16, 2026 at 10:55:42AM +0200, David Hildenbrand (Arm) wrote:
>> On 7/15/26 18:41, Hari Mishal wrote:
>>> The device_block_size read from the virtio-mem config space is used as a
>>> divisor and also in ALIGN_DOWN() further down the code path in the
>>> driver without further validation. A zero value leads to a division by
>>> zero, and a non-power-of-two value corrupts the ALIGN_DOWN() bitmask
>>> arithmetic leading to a misreporting of guest-usable ram, post crash.
>>>
>>> Reject both at init time instead of trusting the device.
>>>
>>> Signed-off-by: Hari Mishal <harimishal1@gmail.com>
>>> ---
>>> v2: dropped the redundant explicit zero check, since
>>>     is_power_of_2(0) already returns false.
>>>
>>>  drivers/virtio/virtio_mem.c | 6 ++++++
>>>  1 file changed, 6 insertions(+)
>>>
>>> diff --git a/drivers/virtio/virtio_mem.c b/drivers/virtio/virtio_mem.c
>>> index 11c441501582..0e04fec458af 100644
>>> --- a/drivers/virtio/virtio_mem.c
>>> +++ b/drivers/virtio/virtio_mem.c
>>> @@ -2847,6 +2847,12 @@ static int virtio_mem_init(struct virtio_mem *vm)
>>>  			&vm->plugged_size);
>>>  	virtio_cread_le(vm->vdev, struct virtio_mem_config, block_size,
>>>  			&vm->device_block_size);
>>> +	if (!is_power_of_2(vm->device_block_size)) {
>>> +		dev_err(&vm->vdev->dev,
>>> +			"invalid device block size: 0x%llx\n",
>>> +			(unsigned long long)vm->device_block_size);
>>> +		return -EINVAL;
>>> +	}
>>
>> The spec states "The device MUST set block_size to a power of two."
>>
>> I'm missing the point here.
> 
> So what happens if we have a non-spec-compliant device?  Shouldn't we be
> attempting to verify this before doing something with the data?

The problem I see is that there are plenty of other devices where a
non-compliant device might cause problems.

Like, we request to hotplug some memory block and our device ACKs it, but it
simply didn't do that.

Or we request to hotunplug a memory block and instead it hotplugs some random
other memory block.

Or we sense whether a memory block is plugged and the device lies to us.

> 
> Or do we just always trust virtio mem devices explicitly?

It's hard for me to understand where we draw the line, really.

But maybe MST can clarify what we care about in virtio world where the
hypervisor is fully in charge of the device,

-- 
Cheers,

David
