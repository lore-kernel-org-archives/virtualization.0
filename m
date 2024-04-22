Received: from out30-101.freemail.mail.aliyun.com (out30-101.freemail.mail.aliyun.com [115.124.30.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F8DD13F442
	for <virtualization@lists.linux.dev>; Mon, 22 Apr 2024 09:04:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713776679; cv=none; b=Rux6RV0TAN7sym+vPnvlHRfjpvQ330KkvmuhwnksABVeHJFp7yWcg48YC8L/KUnU/WPAziuExhcGwec5NTXx1im3VBpMhTjte4Z+AZQXKI+PRKJXyQ3T6TLtmQLsDuZxfIa2A2yOuYLWRNsrR2Ob5An6FZhkAeQW3oC02tBhi2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713776679; c=relaxed/simple;
	bh=VCDi0b6H9++Q/mdIE6+PmeVSPcSFlEcG/DW7KI2h1Uc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VWhhxSJiWweFqG4oiaLi4aNdBtq8rH1bN9RLh8W67mCboW7kQbhq7I1teRTM31XPzgzOysoMA1kV6+qSE3mXo7EjmDXtaz2GpISzt/4+s26X4YXZmi4FCV5Knnh8S0i8nmfpMT2WwCx4ebXav+SU42pWY2FL2vskMwcBHmh1GGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=GhNBU6X/; arc=none smtp.client-ip=115.124.30.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="GhNBU6X/"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1713776649; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=YBdh3d4NG7zhEjgVLeaTSgMeUhDFAFZPUPg3nLFAOF8=;
	b=GhNBU6X/eUB1NraWdMc9rSx8PohH+mmbCgcmyqt+8dgXaBHJKbudY1ce4kf8SAt5tAen9yknCgeHkbvoGM3lR6QQPw97MY+znbdMwAZwPziarJd24nyPVAnzq2+C1hY8mbedqkmqR8W+zB1O8efALD0crlpo7YCV1iaZ9QrFSso=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R911e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046059;MF=hengqi@linux.alibaba.com;NM=1;PH=DS;RN=23;SR=0;TI=SMTPD_---0W50qzB3_1713776646;
Received: from 30.221.148.142(mailfrom:hengqi@linux.alibaba.com fp:SMTPD_---0W50qzB3_1713776646)
          by smtp.aliyun-inc.com;
          Mon, 22 Apr 2024 17:04:08 +0800
Message-ID: <6509d9f4-09b1-43ee-ab38-8949f51a806d@linux.alibaba.com>
Date: Mon, 22 Apr 2024 17:04:06 +0800
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v9 2/4] ethtool: provide customized dim profile
 management
To: Brett Creeley <bcreeley@amd.com>
Cc: Jakub Kicinski <kuba@kernel.org>, "David S . Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, Jason Wang <jasowang@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Ratheesh Kannoth <rkannoth@marvell.com>,
 Alexander Lobakin <aleksander.lobakin@intel.com>,
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Tal Gilboa <talgi@nvidia.com>,
 Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
 Maxime Chevallier <maxime.chevallier@bootlin.com>,
 Jiri Pirko <jiri@resnulli.us>, Paul Greenwalt <paul.greenwalt@intel.com>,
 Ahmed Zaki <ahmed.zaki@intel.com>, Vladimir Oltean
 <vladimir.oltean@nxp.com>, Kory Maincent <kory.maincent@bootlin.com>,
 Andrew Lunn <andrew@lunn.ch>, "justinstitt@google.com"
 <justinstitt@google.com>,
 "open list:NETWORKING DRIVERS" <netdev@vger.kernel.org>,
 "open list:VIRTIO CORE AND NET DRIVERS" <virtualization@lists.linux.dev>
References: <20240417155546.25691-1-hengqi@linux.alibaba.com>
 <20240417155546.25691-3-hengqi@linux.alibaba.com>
 <c59ebd40-fe9c-477f-9ed5-958163470f03@amd.com>
From: Heng Qi <hengqi@linux.alibaba.com>
In-Reply-To: <c59ebd40-fe9c-477f-9ed5-958163470f03@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2024/4/21 下午11:53, Brett Creeley 写道:
> On 4/17/2024 8:55 AM, Heng Qi wrote:
>> Caution: This message originated from an External Source. Use proper 
>> caution when opening attachments, clicking links, or responding.
>>
>>
>> The NetDIM library, currently leveraged by an array of NICs, delivers
>> excellent acceleration benefits. Nevertheless, NICs vary significantly
>> in their dim profile list prerequisites.
>>
>> Specifically, virtio-net backends may present diverse sw or hw device
>> implementation, making a one-size-fits-all parameter list impractical.
>> On Alibaba Cloud, the virtio DPU's performance under the default DIM
>> profile falls short of expectations, partly due to a mismatch in
>> parameter configuration.
>>
>> I also noticed that ice/idpf/ena and other NICs have customized
>> profilelist or placed some restrictions on dim capabilities.
>>
>> Motivated by this, I tried adding new params for "ethtool -C" that 
>> provides
>> a per-device control to modify and access a device's interrupt 
>> parameters.
>>
>> Usage
>> ========
>> The target NIC is named ethx.
>>
>> Assume that ethx only declares support for 
>> ETHTOOL_COALESCE_RX_EQE_PROFILE
>> in ethtool_ops->supported_coalesce_params.
>>
>> 1. Query the currently customized list of the device
>>
>> $ ethtool -c ethx
>> ...
>> rx-eqe-profile:
>> {.usec =   1, .pkts = 256, .comps =   0,},
>> {.usec =   8, .pkts = 256, .comps =   0,},
>> {.usec =  64, .pkts = 256, .comps =   0,},
>> {.usec = 128, .pkts = 256, .comps =   0,},
>> {.usec = 256, .pkts = 256, .comps =   0,}
>> rx-cqe-profile:   n/a
>> tx-eqe-profile:   n/a
>> tx-cqe-profile:   n/a
>>
>> 2. Tune
>> $ ethtool -C ethx rx-eqe-profile 1,1,0_2,2,0_3,3,0_4,4,0_5,5,0
>
> With all of this work to support custom dim profiles (which I think is 
> a great idea FWIW), I wonder if it would be worth supporting a dynamic 
> number of profile entries instead of being hard-coded to 5?
>

In my practice, I have not found that fewer or more profile entries lead 
to better performance.

Thanks.

> Thanks,
>
> Brett
>
> <snip>

