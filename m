Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 755EA1EFF80
	for <virtualization@lists.linux.dev>; Fri, 13 Jun 2025 07:32:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749799937; cv=none; b=KeIBqr74PGXJsbtd6he6p/sn8UR1w/gjOKLIuMlSb8JcNZczr2bcx/kDU6fOIea1fEbYp/EYONyAmsNKNduMOvZPQw7AC8Shl1pAmqgJ8/Byiib584lCrL448QduVs3QyOipDx8uaR/jJNk3j7RT83kjpwXZ2y8YOIfFJyncCMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749799937; c=relaxed/simple;
	bh=zck7WMGgzZa3cnxbw9rpUAXo+PXfsfoJCR4vIZekB7s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BMaUzjIs+p5XfqQawstWAIcDJl4xJAFJln0YhNAlo2rOrjSUGg12THO/PdFL0CEvepchP32ulh+Fsh5lHzY+YaDja9FpeRoMYREIw5kWVJk8QAcVw4z1nqQgBM/6oYS/DZ0nN3by7Lmqk6t+FNk7N5ZteE9WJmvdyH9K3SlRxa8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com; spf=pass smtp.mailfrom=zytor.com; dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b=ssHkh09E; arc=none smtp.client-ip=198.137.202.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zytor.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="ssHkh09E"
Received: from [192.168.7.202] ([71.202.166.45])
	(authenticated bits=0)
	by mail.zytor.com (8.18.1/8.17.1) with ESMTPSA id 55D7VjwM3704239
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
	Fri, 13 Jun 2025 00:31:46 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 55D7VjwM3704239
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2025052101; t=1749799910;
	bh=krbuP/fm6w7WAkYJYWFwpvmZlC0fDISskA1NKizA7xQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=ssHkh09EYcaM0Ax6sdq6MtHrSSxYTaTdcsnzbRZgcdG+Isq/WnrBYczUvXTg5CwxN
	 pcVjrm3xKQn0yhcf7jb4dEx6sAKdEgZR2whPfrJi89pD9zuGgdch3sodHzB0WrMC7R
	 znHrQnL1Zvv+QUqFkfvmElRpjUN5lFqBkpRJm4PrSkrsX90V3GU0gMSIA7JFCrIutu
	 PwNP6YQlhIiu/pootMO99LR+3o2402BhzCDOvvFgc9nC53bLkUx4x+coky0NVxfIxv
	 7y4XiCFqoDT400d95pn8JvIEA/eXVRCbaX7CtNG3q80d78+ryMmj16UFMuEHvO2ytx
	 T+ZJnfwKScM6Q==
Message-ID: <0c2dab1d-9b5c-4d34-af0e-8a14907d7335@zytor.com>
Date: Fri, 13 Jun 2025 00:31:44 -0700
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/6] x86/paravirt: Switch MSR access pv_ops functions to
 instruction interfaces
To: Juergen Gross <jgross@suse.com>, linux-kernel@vger.kernel.org,
        x86@kernel.org, virtualization@lists.linux.dev
Cc: Ajay Kaher <ajay.kaher@broadcom.com>,
        Broadcom internal kernel review list
 <bcm-kernel-feedback-list@broadcom.com>,
        Thomas Gleixner
 <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        xen-devel@lists.xenproject.org,
        Andrew Cooper <andrew.cooper3@citrix.com>
References: <20250506092015.1849-1-jgross@suse.com>
 <20250506092015.1849-6-jgross@suse.com>
 <722f5b30-20e9-4540-98e4-d211d7c44cbe@zytor.com>
 <9f4e33d5-9cb3-4079-b764-87a15265fd52@suse.com>
 <2365af70-d36f-4663-b819-59d886936ef5@zytor.com>
 <8a82946a-6c3e-41d1-b3bd-be164dc6eeba@suse.com>
Content-Language: en-US
From: Xin Li <xin@zytor.com>
Autocrypt: addr=xin@zytor.com; keydata=
 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
 l75w1xInsg==
In-Reply-To: <8a82946a-6c3e-41d1-b3bd-be164dc6eeba@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 6/11/2025 5:58 AM, Juergen Gross wrote:
>> Here is a patch I cooked.  I added an ALTERNATIVE() hack because the 
>> new instructions can't be more than 6 bytes long.  But with the patch you
>> just sent, it shouldn't be needed.
> 
> I have meanwhile dropped the patch copying the original indirect call.
> 
> Reason is that I'm seeing a potential risk with current alternative
> patching when using ALTERNATIVE_[23](): depending on the tested features
> it might happen that an instruction sequence not suitable for the current
> runtime environment is patched in as an intermediate step. In case there
> is an interrupt happening just then AND the handling of the interrupt is
> using the patch site, this could result in crashes or undefined behavior.

Oh, I had assumed that Linux disables interrupts during the patching
process. Just out of curiosity, why are interrupts allowed in this case?

> 
> I have meanwhile a set of 3 patches fixing that problem by merging all
> alternative patching of a patch site in the local buffer and only then
> patching the code at the target site with the final result.
> 
> The same problem arises with your code below, but this time it isn't
> fixed by my patches: the two ALTERNATIVE() instances in the asm() construct
> would need to be patched in a single atomic operation to be consistent.
> Otherwise you could end up e.g. on bare metal with paravirt_read_msr()
> having replaced the indirect call with "rdmsr", but not yet having added
> the code to merge %rdx into %rax.
> 
> I'm just doing a V2 of my series, but this time including the additional
> support of the non-serializing and immediate forms. Lets see how this will
> look like. I will drop using the EAX_EDX_* macros, but due to the reason
> mentioned above I won't switch to your variant completely.

Great!

Thanks!
     Xin
