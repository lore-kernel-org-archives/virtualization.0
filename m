Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87079145B16
	for <virtualization@lists.linux.dev>; Tue, 30 Sep 2025 19:49:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759261796; cv=none; b=g6wIxhJBW6o+tKBXwmAC5g/yp3BxsudDTMRIqFWN+jlAcYz+8RZ8sGPRd5wdt8FNErHPehwivtTpQP5vsbmjUcKtZnDgRFCyjEmnq1amErfaECYS9DQccC9Loo1LWRO1kWKdyxQ6OwqbFvXe0k33vSnmmL/qIAG0JbvTnHNRzsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759261796; c=relaxed/simple;
	bh=0iia0nU5x4rf/WRQNytlMZVqDa6lvfFSyPcVsFZYvhA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TByVmbxkruHvulQR9PkNLEFixozCpjwQqe37k0Pzuih4kxSnQTY40wdDCbyzNUQM9HDbNGS9ehE0ql3ORy1Ubwpq55G966oBzzmk9xLArTmcdUt8Sn3gvE4MXLG/6l/WF3XObHE6AF1icOuiWwVCkqE/T/0qKwTB7o0zI8R+sYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com; spf=pass smtp.mailfrom=zytor.com; dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b=WiyLGMbm; arc=none smtp.client-ip=198.137.202.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zytor.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="WiyLGMbm"
Received: from [IPV6:2601:646:8081:9484:3373:e8bd:aaa4:7c23] ([IPv6:2601:646:8081:9484:3373:e8bd:aaa4:7c23])
	(authenticated bits=0)
	by mail.zytor.com (8.18.1/8.17.1) with ESMTPSA id 58UJnQA9386545
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
	Tue, 30 Sep 2025 12:49:26 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 58UJnQA9386545
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2025092201; t=1759261768;
	bh=dNL6gt2iTdh66H47BLI0CoB/8tRPotODaDlCai0q5ho=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=WiyLGMbm41DpWdoeFYmeIGVkzQksa98mG1NxGVlgSKXuYKU94ud4wLZ7uWpxfPuEy
	 agrf020XSbTAABlOgFng9j8R0aUTAlhh8N4AbNkK7OtFKM4XBL5T+bw8rH0Ior1O36
	 d8xSMWC+DmFRLEoRqjd1FCcA+EXGAfQpkXVgBdxyyHwULfVwwtSo44n43XvsC2wxxq
	 oOahoknddZ6uUCoCZm5exOA58kIYDTgqNEKDhxGWaVkGHkjjb/cIU7HqkYJstxgGZA
	 kj7y8CQwndjMAtLhfHU/20MMHxiiTw5jxddwRlYgxkm3lHpT9lSXQZ+ZCErnA5CJh3
	 20RtYF/Dy2WRA==
Message-ID: <d2c68cbe-2e92-4801-b1a3-af4645e9ba78@zytor.com>
Date: Tue, 30 Sep 2025 12:49:21 -0700
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 11/12] x86/paravirt: Don't use pv_ops vector for MSR
 access functions
To: =?UTF-8?B?SsO8cmdlbiBHcm/Dnw==?= <jgross@suse.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org,
        virtualization@lists.linux.dev, xin@zytor.com,
        Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Ajay Kaher <ajay.kaher@broadcom.com>,
        Alexey Makhalov <alexey.makhalov@broadcom.com>,
        Broadcom internal kernel review list
 <bcm-kernel-feedback-list@broadcom.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        xen-devel@lists.xenproject.org
References: <20250930070356.30695-1-jgross@suse.com>
 <20250930070356.30695-12-jgross@suse.com>
 <20250930083827.GI3245006@noisy.programming.kicks-ass.net>
 <1541b670-8b29-42a5-a58d-34d85197751d@suse.com>
 <20250930100404.GK4067720@noisy.programming.kicks-ass.net>
 <fefbd1ee-ab8c-465e-89bf-39cd2601fc60@suse.com>
Content-Language: en-US, sv-SE
From: "H. Peter Anvin" <hpa@zytor.com>
In-Reply-To: <fefbd1ee-ab8c-465e-89bf-39cd2601fc60@suse.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 2025-09-30 03:43, Jürgen Groß wrote:
>>
>>> In Xin's series there was a patch written initially by you to solve such
>>> a problem by adding the _ASM_EXTABLE_FUNC_REWIND() exception table method.
>>> I think this is a dead end, as it will break when using a shadow stack.
>>
>> No memories, let me go search. I found this:
>>
>>    https://patchwork.ozlabs.org/project/linux-ide/
>> patch/20250331082251.3171276-12-xin@zytor.com/
>>
>> That's the other Peter :-)
> 
> Oh, my bad, sorry. :-)

Yes, you would have to patch both the stack and the shadow stack.

BUT: in the end it really doesn't really buy much. The only thing that
benefits is Xen, but it is fairly easy for Xen (my original POC did this) to
filter out the quite few MSRs that they do special dispatch for (plus the
variable case), and then they can just use the native code including the
benefit of using WRMSRNS and immediates.

The other approach that I also came up with looks like this:

/* Native code (non-immediate): trap point at +7 */

   0:   48 89 c2                mov    %rax,%rdx
   3:   48 c1 ea 20             shr    $0x20,%rdx
   7:   0f 01 c6                wrmsrns
   a:

/* Native code (immediate): trap point at +0 */

   0:   36 c4 e7 7a f6 c0 xx    ds wrmsrns %rax,$XX
        xx xx xx
   a:

/* Xen code, stub sets CF = 1 on failure */

   0:   e8 xx xx xx xx          call   asm_xen_pv_wrmsr
   5:   73 03                   jnc    0xa
   7:   0f 0b                   ud2
   9:   90                      nop
   a:

The trap point even ends up in the same place! UD2 can be any 1-, 2-, or
3-byte trapping instruction.

> 
>>> Additionally I found a rather ugly hack only to avoid re-iterating most of
>>> the bare metal ALTERNATIVE() for the paravirt case. It is possible, but the
>>> bare metal case is gaining one additional ALTERNATIVE level, resulting in
>>> patching the original instruction with an identical copy first.
>>
>> OTOH the above generates atrocious crap code :/
> 
> Yes.

Please don't generate crap code -- that's exactly The Wrong Thing. I didn't
actually look at the output code; I honestly didn't think that that would even
be an issue.

If it is REALLY evil, then do something like shell script to generate the code
instead...

(One big problem here is that cpp doesn't understand colons as separators...)

	-hpa

