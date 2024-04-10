Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8571D13CAB4
	for <virtualization@lists.linux.dev>; Wed, 10 Apr 2024 07:28:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712734092; cv=none; b=No20c3FPRnreVPo9EVP4Pf5jHroQoWu7DAgzULkQbMmqWbAwAEUJnpgxeHw/NId8BfGpoRJyAWJjQADZn4jJte8ak1iJr178HnGOSVNOD3nYotKeb6zeGUesI700FaJnBVWkmpVjKHwwrQ68hU2e3MoQGiMxzX0m2A9O//G385c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712734092; c=relaxed/simple;
	bh=EkKWgtjZ08/3JU/NJqPbGnAGIGRetFZ9LJ/ZTT3RuXs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=M+jFTGz1YlvW8OLA9szRH2QoCr5EMHvpMJNQmHR1SvfR2WXBQxtpY0LZQSymrny6xJYwtgX1K1jYo/tLAGMbu614EGYnHVxynFUsp4DoWDpzT/o6yhQWsD7BNFBvCUf6VRVFJtP3S/auKwXoa8N/Q86zsk2+oiCyXF7r1N7q4n0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=Z0eeMWJs; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="Z0eeMWJs"
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-6ead4093f85so5253969b3a.3
        for <virtualization@lists.linux.dev>; Wed, 10 Apr 2024 00:28:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1712734090; x=1713338890; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3Ig32zWmBFLYBqQb21rAU7TmYkM7kXOo2WhlPw8o8aY=;
        b=Z0eeMWJswnv/ZtxNcaab+qdnWyfGo9wMf7wVcdTdBSLvh1Hs7ntnMCOAT2dNq5xD9d
         h9JX5R2CZ45nXEnljlGB67sJPjtEOY3Isg+WIHBmeg+TkB90M80r0DV8chUy3g46y6ew
         IgzdMXUJlGdhUonxkL71cqCEGuVUOFKN9VMaNnIEHrQWLIkUdWFGvQBARPhL2CNIC2DT
         xMympAT/3KoDcw7CA1nUvNaBRuYNCy8Y85QAiWYW1rrdiPiEtxbyd70dY4TUzRLBUnu6
         FMU/BZ+Gi93kfjkA8hGUZK8TC4KRbLZPQBhDtaK4Yw75K5logP2bx+ciVaJCUZXj0JEZ
         I0OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712734090; x=1713338890;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3Ig32zWmBFLYBqQb21rAU7TmYkM7kXOo2WhlPw8o8aY=;
        b=Fn4hHcWiPL1Ss2FyLPJ2CGvDrPN9ri2HWSCv0F2jIh5+q84zv89QHd15/XYcDyDoV8
         x5qL03wvjAnwsd7FUE+zQX/6bN7SXCjbhbrqK96a3VZaL6ZifiCQsg1f0UBFCxZqnLjc
         PucFovvgN6vr/hXDoXmyQZgMyWNLlb4vpc8GYVICyjgtpCMs65dGxfFY7JNA4UHL/X9/
         6jdacc1HO7M8I7B3bwNNAwLRMvr2S1586Eb0fXO83ZUMewRCYZ11rFY7gB7R6zoqkmyL
         cl27D5+3nJFd4e6bCg6eVw8DOTpsGuWKexfyQQgVImx0X4XEh6eC+aqvF29/Jif63YnP
         fI9A==
X-Forwarded-Encrypted: i=1; AJvYcCWUQvFOiUZfFWZmK8g8gguFu/XCk+pHuiWbZwljlCa8ZXG90PqEYh6GFUhdISYCGmLRx4EtFcJ9cPo2n1uiiA7Rbqh/ji/lrM1vDfQ96JE=
X-Gm-Message-State: AOJu0YyyqkVFlR8UcaWCefo/lFV4prMC4Zv1krp1C6BJ0M9LiT/Lp1+0
	JSMqDukCZ1Gjqok+sMoa+2lzDrej49Lm2TIAm4zWLa34n3ufgfXmQELCazH/hG8=
X-Google-Smtp-Source: AGHT+IGnAZXE/XiGFQ0xzq27+Bwb+2iBqYQega7VKj5SmqFQEmNOu1qpGgpcd92WDjvowGcA4TzlPQ==
X-Received: by 2002:a05:6a20:7488:b0:1a3:53e7:16da with SMTP id p8-20020a056a20748800b001a353e716damr2250861pzd.15.1712734089807;
        Wed, 10 Apr 2024 00:28:09 -0700 (PDT)
Received: from [172.16.0.21] (c-67-188-2-18.hsd1.ca.comcast.net. [67.188.2.18])
        by smtp.gmail.com with ESMTPSA id n15-20020a170903110f00b001e20587b552sm10131456plh.163.2024.04.10.00.28.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Apr 2024 00:28:09 -0700 (PDT)
Message-ID: <4a428500-4e37-4e7d-968d-3da20dd822af@rivosinc.com>
Date: Wed, 10 Apr 2024 00:28:08 -0700
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 21/22] KVM: riscv: selftests: Add a test for PMU
 snapshot functionality
Content-Language: en-US
To: Andrew Jones <ajones@ventanamicro.com>
Cc: linux-kernel@vger.kernel.org, Anup Patel <anup@brainfault.org>,
 Ajay Kaher <akaher@vmware.com>, Alexandre Ghiti <alexghiti@rivosinc.com>,
 Alexey Makhalov <amakhalov@vmware.com>,
 Conor Dooley <conor.dooley@microchip.com>, Juergen Gross <jgross@suse.com>,
 kvm-riscv@lists.infradead.org, kvm@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-riscv@lists.infradead.org,
 Mark Rutland <mark.rutland@arm.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Paul Walmsley
 <paul.walmsley@sifive.com>, Shuah Khan <shuah@kernel.org>,
 virtualization@lists.linux.dev,
 VMware PV-Drivers Reviewers <pv-drivers@vmware.com>,
 Will Deacon <will@kernel.org>, x86@kernel.org
References: <20240403080452.1007601-1-atishp@rivosinc.com>
 <20240403080452.1007601-22-atishp@rivosinc.com>
 <20240405-4e840120e8117c286cb593f9@orel>
 <8748dbed-d105-4f26-a808-667c3b56c8ec@rivosinc.com>
 <20240410-2a41e43624596a442d6a95cd@orel>
From: Atish Patra <atishp@rivosinc.com>
In-Reply-To: <20240410-2a41e43624596a442d6a95cd@orel>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 4/10/24 00:10, Andrew Jones wrote:
> On Tue, Apr 09, 2024 at 03:52:40PM -0700, Atish Patra wrote:
>> On 4/5/24 06:11, Andrew Jones wrote:
>>> On Wed, Apr 03, 2024 at 01:04:50AM -0700, Atish Patra wrote:
> ...
>>>> +	probe = guest_sbi_probe_extension(SBI_EXT_PMU, &out_val);
>>>> +	GUEST_ASSERT(probe && out_val == 1);
>>>> +
>>>> +	if (get_host_sbi_spec_version() < sbi_mk_version(2, 0))
>>>> +		__GUEST_ASSERT(0, "SBI implementation version doesn't support PMU Snapshot");
>>>> +}
>>> It's a pity we can't check the SBI spec version that KVM is advertising
>>> from KVM userspace. Normally we'd want to check something like this at
>>> the start of the test with TEST_REQUIRE() before running a VCPU in order
>>> to generate a skip exit.
>>>
>> Agreed. I will send a separate series for that as it is an ABI change.
>>
>>> (We probably should allow reading and even writing the SBI spec version
>>> from the VMM in order to better support migration.)
>>>
>> How that would work for SBI spec version write use case ? For migraiton, you
>> can't go back to older SBI versions in the host. Isn't it ?
>>
>> Considering this case your VM is running with PMU snapshot as the host has
>> SBI v2.0. It can't be migrated to v1.0 and expecting it work. Correct ?
>>
> We can start a VM on a host with SBI v2.0, but tell KVM to tell the VM
> that it has v1.0. Then, the guest shouldn't use any features from SBI
> that appear after v1.0 and it should be safe to migrate to a host with
> v1.0.

That depends on when the VMM request to KVM to change the version.
Most of SBI implementation checks the SBI version at the boot and 
enable/disable
feature based on the SBI version available. If the SBI version supported 
by KVM changes
to an older one, the calls from VM will fail unexpectedly.

> A more likely scenario might be this though:
>
>   1. KVM userspace checks and captures the SBI version of the host where
>      the VM is first being launched, e.g. v2.0
>   2. The VM gets migrated to another host which supports something later,
>      e.g. v3.0, but to
>      - avoid possibly confusing the guest we tell the destination host
>        that it should expose v2.0 as the SBI version
>      - allow rollback to the source host without concern that the guest
>        has already seen v3.0 and started to use something that the
>        source can't provide

This makes sense though. As per my understanding, we should not allow 
modifying
the SBI version that is less that the version VM already boot with.
However, we can allow modifying the SBI version that is higher or same 
as the VM booted with.

I can't think of a use case for the higher version though.

> Thanks,
> drew
