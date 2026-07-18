Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4D312EEE6E
	for <virtualization@lists.linux.dev>; Sat, 18 Jul 2026 17:07:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784394456; cv=none; b=krhhNvvTKbkI/DAKLUUsZ8JxQG6ynTueVqv58jKIuqfur9XxABXkE5WN3/8BFu1cnAGIp9rhSvY5X28m/l7tVcbSXbkJG9JhdeiKc8MR/+cwNQIdmbrJ/sPbtH9QD2NX9cRXv+dI2v35SBlO84ENSiVyBYe/v2o3WkFsZvtt82Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784394456; c=relaxed/simple;
	bh=9oenhziDUtv13zV3obwo8PSJq5KghJW/R1qHQeEgEBs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jHL7WpBGji1k2hMxe7qLoFLj8jepE1WQYtiDJuSAYnGm/gzNO4WwOGNs1ofII66FD3LOxS4o01pktxYycNProXY/nvxXmCA6qbXlLpu/0rGBSLpHlPIybjjehurYu1fWXoTtutH52D+tXtJvVcvOgYk4gVvmRpi4cmVQu+WqHdg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nLzuU2eX; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nLzuU2eX"
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-ca7bea5e5b3so6311826a12.1
        for <virtualization@lists.linux.dev>; Sat, 18 Jul 2026 10:07:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784394454; x=1784999254; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=6AMl0iO86IWTwZS9RKYqeagiNPn+Qxng/j1BN8a1GWs=;
        b=nLzuU2eXZxkQmNG1hPW7A3OSLaMmpG6Z1i6WgNNkxaTI9PtxbmqRkDJD83jGAHK8uD
         rI/HNKT/e/ZzwrfDU1a7qas8xcxNgzeuRir4VCW4n+msBx+S7haqdBBReXvEvUT/4Q6e
         FXE46yRyPS1rLuQt5g8A9u1WMrApG08vHJ0Ds6fhga8NorD+h2XLegvoNCIe8YWNjEhA
         K9Fd3WNzJwCEHp7vEzCbZfIXZwgx3jG4lvMbXrdc+bnrvBv/alKl2QbqNu57V+bmuFVE
         oJFt6RbqVX7/GVT7BCm/Wt0crkrtJHs3x53s5Hx3TSXsw9+NsUGyKDhnwJugriGQRoe7
         /vVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784394454; x=1784999254;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=6AMl0iO86IWTwZS9RKYqeagiNPn+Qxng/j1BN8a1GWs=;
        b=VDRQkNQDVh0OZimXFlFLxs+Fmhx01T/xyaUxCz3PlaCzi+rm6dVCIVfhQvB5wQ94SC
         C1t3LQm4jJiMartaLVCjANBHE4nRaQIUkBEvOD67JD6AsFp0n60IjQu0YdhLNMGfTcr6
         DqYA+Khhs2vFV/qeGpfJ/I35PNv8cxjZFyHKmNDQUiCuEGS5rXGL2BcisgpYkSdoVOo6
         yQT/FFBIu94p68xyppnPVxNwvpFo/NOcDF3MjOyugY+Cje5hq4dhWJz7WYnBLRxq8wa9
         KJ/ajF9YO8buywJMDjTZ24+vJ/44V0oWUS5HFN38DM9CkYBDU1mSnW6ROoTBPEbTtWrc
         bCqw==
X-Forwarded-Encrypted: i=1; AHgh+Rp7Q9dZEw5buAebgKT5Hx6XwFNIBpsBUuOut9CZxgTagwgiw3B+le/aIjWpC0HwPtfmmUyj2an7nY54mwu+vg==@lists.linux.dev
X-Gm-Message-State: AOJu0Yw+krMJGsRrA2EVWvNYFyeSQaH6h9hlja7zm5o7fMkcAQQBtib/
	1P0kmFctAsjES3Lfbrzul7POHcVgRHcCmqiq/Pv8eq4i3tJw6uKyV1HW
X-Gm-Gg: AfdE7cnRofJ7wEf6wd5qYDQEVOniJGC4Gwyj9nfKyDhuB6NNqjX22cT5oqJRu0AoLBc
	sgjDnbdupB8wVCih96U+Ujf3QxgG2TBfoj9/ecmnA8Xk82NdDLkXLWmRFHVgBpLuGx3ZHYrWANd
	e9OTMcU4GQW46+gqTSnoEcHlKqpPBePyY2G87xN1MZ8MVsE1QiN2lysBWAsn0leV86D6udY+Iei
	m7GZLWAMx9GYagq2zUTmAJIPGKDTwItJ4ZmTPYCIBlnxBEqBikEXEq1Z47gxc9oFd3IBZC0NRkM
	9v4UXsGBP7NhCkBCPvjQaY+vnrBVdcCyb1CqI11Aztfkqy9Igbz4d8xepCoUaO72qX1stQmj0ft
	KPE4uPHmozlloT2iOBbj21cbZMTnseoCgKnP+VLpozj8OhTzJHXI4Lo82ZeZu//RzycDdvOoY3y
	pvmQr4ZyqruRMcGLcYOAs=
X-Received: by 2002:a17:90b:2f85:b0:381:a766:efc9 with SMTP id 98e67ed59e1d1-38e4b4227b8mr7057120a91.7.1784394453960;
        Sat, 18 Jul 2026 10:07:33 -0700 (PDT)
Received: from [192.168.86.23] ([136.25.189.61])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3142a1dde81sm36015303eec.21.2026.07.18.10.07.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 18 Jul 2026 10:07:33 -0700 (PDT)
Message-ID: <ae5bc86b-cb8d-4530-9e58-d285007deac0@gmail.com>
Date: Sat, 18 Jul 2026 10:07:30 -0700
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/4] virtio-mem: validate device-reported block size
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 "David Hildenbrand (Arm)" <david@kernel.org>,
 Hari Mishal <harimishal1@gmail.com>, Jason Wang <jasowangio@gmail.com>,
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
Content-Language: en-US
From: Carlos Bilbao <carlos.bilbao.osdev@gmail.com>
In-Reply-To: <2026071803-passage-dares-8240@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 7/17/26 22:29, Greg Kroah-Hartman wrote:

> On Fri, Jul 17, 2026 at 08:31:09PM -0700, Carlos Bilbao wrote:
>> Historically, one of the biggest criticisms of coco, especially around
>> device hardening, was that there were too many values that a
>> malicious/buggy device could misreport, making it a losing battle. That is
>> no longer the case with LLMs, and we have the advantage (and challenge) of
>> open-source dev, which allows us to receive many of these fixes "for free".
>> If others want to burn their tokens, let them :)
> I have lots of tokens to burn :)
>
> So along those lines, any suggestions on how best to fuzz these code
> paths?  Any workloads you all use for testing that I can take advantage
> of?


We've the virtio-mem config struct layout and the kernel source, so for
obvious fixes like a NULL check, static analysis is better than fuzzing.
Claude took a few mins to find me two examples:

Patch 1: virtio-mem: reject non-power-of-two device_block_size
This one is for virtio_mem_init() to check if
!is_power_of_2(vm->device_block_size)

Patch 2: virto-mem: validate region_size and usable_region_size
THis one checks region_size != 0 and vm->usable_reion_size >
vm->region_size.

An endless factory of "silly" checks like these are low hanging fruit.

Now, for harder bugs, looking around for fuzz options, VirtFuzz [1] looks
like a great candidate for those interested in pursuing this direction.


Their PoC fuzzes wireless/Bluetooth stack, but nothing our AI overlords
can't quickly adapt for virtio-mem and other virtio drivers; the JSON
definition to describe device behavior is easily extensible. Their threat
model [2] describes an external attacker, but in the context of coco, the
virtio device itself is the attacker. Here's a vibe coded PR of what I mean:

https://github.com/seemoo-lab/VirtFuzz/pull/7

CCed the creators/authors, thanks for open sourcing this!

Thanks,
Carlos

[1] https://github.com/seemoo-lab/VirtFuzz

On 7/17/26 22:29, Greg Kroah-Hartman wrote:

> On Fri, Jul 17, 2026 at 08:31:09PM -0700, Carlos Bilbao wrote:
>> Historically, one of the biggest criticisms of coco, especially around
>> device hardening, was that there were too many values that a
>> malicious/buggy device could misreport, making it a losing battle. That is
>> no longer the case with LLMs, and we have the advantage (and challenge) of
>> open-source dev, which allows us to receive many of these fixes "for free".
>> If others want to burn their tokens, let them :)
> I have lots of tokens to burn :)
>
> So along those lines, any suggestions on how best to fuzz these code
> paths?  Any workloads you all use for testing that I can take advantage
> of?


We've the virto-mem config struct layout and the kernel source, so for
obvious fixes like a NULL check, static analysis is better than fuzzing.
Claude took a few mins to find me two examples:

Patch 1: virtio-mem: reject non-power-of-two device_block_size
This one is for virtio_mem_init() to check if
!is_power_of_2(vm->device_block_size)

Patch 2: virto-mem: validate region_size and usable_region_size
THis one checks region_size != 0 and vm->usable_reion_size >
vm->region_size.

An endless factory of "silly" checks like these are low hanging fruit.

Now, for harder bugs, looking around for fuzz options, VirtFuzz [1] looks
like a great candidate for those interested in pursuing this direction.


Their PoC fuzzes wireless/Bluetooth stack, but nothing our AI overlords
can't quickly adapt for virtio-mem and other virtio drivers; the JSON
definition to describe device behavior is easily extensible. Their threat
model [2] describes an external attacker, but in the context of coco, the
virtio device itself is the attacker. Here's a vibe coded PR of what I mean:

https://github.com/seemoo-lab/VirtFuzz/pull/7

CCed the creators/authors, thanks for open sourcing this!

Thanks,
Carlos

[1] https://github.com/seemoo-lab/VirtFuzz
[2] 
https://www.computer.org/csdl/proceedings-article/sp/2024/313000a024/1RjEa0y9RMQ


> thanks,
>
> greg k-h

[2] 
https://www.computer.org/csdl/proceedings-article/sp/2024/313000a024/1RjEa0y9RMQ


>
> thanks,
>
> greg k-h
