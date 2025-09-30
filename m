Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 010B81EE02F
	for <virtualization@lists.linux.dev>; Tue, 30 Sep 2025 19:59:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759262383; cv=none; b=oj1BrAP5lZbk/B1JunPyXCnal/hMaQFDqblYE6nOdUZEUBLblTfkj9lUCrwga4qEgkAxi9JafonRU19mxBzgJd7+nQUxCwFRM/+QN8W9oO3xxQkrLFrOn/cpbUgfrupXMY5VyZJptht78dIbcDM73xgWyMHVnZgZN09wZGfe9xc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759262383; c=relaxed/simple;
	bh=Hy7YTC353G/i8KcCKTnHdodQD4/ARaG2eoCv6OzYxhw=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=SXnwlRUB/dareZ4+ubKsTDNuNf/0yFGZtanz/hyNWInsZNMQzLxm6eyAzcItc6TrhcgyNJyAO/t+h89CiEG3swy/VMkhjtVr/0bN858HtUVIyOa9wyln0venZxVIQAd7h0S70ZQvG6pEca/WQjztS+1JrUiPDR+zY0lfpyTpJak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com; spf=pass smtp.mailfrom=zytor.com; dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b=QaNz4Je2; arc=none smtp.client-ip=198.137.202.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zytor.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="QaNz4Je2"
Received: from [IPV6:2601:646:8081:9484:3373:e8bd:aaa4:7c23] ([IPv6:2601:646:8081:9484:3373:e8bd:aaa4:7c23])
	(authenticated bits=0)
	by mail.zytor.com (8.18.1/8.17.1) with ESMTPSA id 58UJxGxQ388770
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
	Tue, 30 Sep 2025 12:59:16 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 58UJxGxQ388770
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2025092201; t=1759262357;
	bh=GUDfo0ggb2Kf0OLA6XTPKyaZ5hpYV0SrMLjTdCbuESQ=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
	b=QaNz4Je2UXuQTSWaK4KMZazVcUDgrcjdxPf7vCTlHy0S5KlindalLZY9iSdbN0LPO
	 dZb78UBGhBI6zN+vsilEaxZSxAvZBA+b2DzFqnhlIs+P7vKdM8tGRUo3+SmH+ShgM7
	 b4ebKEuKD7ubKHHtEaatmx3ExNblsR56/PR+F2q18PSsag/YCLricKcIsLGhYsD8fm
	 +3Bi3bmpb/VjsC+tI1oc2MfG6eB2Odcjqkxn6QEL3QbDHW/e4z7LKSf4okznFo2Wwy
	 Y0OorC4QkeM6DrHa7SK6xfWjFIfjwzCLKSxx7dd3XM+E31C01/RFVTptacurWTbYs0
	 oHt+fMunsTYzg==
Message-ID: <2ca6c68f-16a7-402f-adb0-327583695d4a@zytor.com>
Date: Tue, 30 Sep 2025 12:59:11 -0700
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 11/12] x86/paravirt: Don't use pv_ops vector for MSR
 access functions
From: "H. Peter Anvin" <hpa@zytor.com>
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
 <d2c68cbe-2e92-4801-b1a3-af4645e9ba78@zytor.com>
Content-Language: en-US, sv-SE
In-Reply-To: <d2c68cbe-2e92-4801-b1a3-af4645e9ba78@zytor.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2025-09-30 12:49, H. Peter Anvin wrote:
> 
> /* Xen code, stub sets CF = 1 on failure */
> 
>    0:   e8 xx xx xx xx          call   asm_xen_pv_wrmsr
>    5:   73 03                   jnc    0xa
>    7:   0f 0b                   ud2
>    9:   90                      nop
>    a:
> 
> The trap point even ends up in the same place! UD2 can be any 1-, 2-, or
> 3-byte trapping instruction.
> 

You can, of course, also simply have a conditional jump, at the expense of
making the whole alternative block one byte longer:

  0:   e8 xx xx xx xx          call   asm_xen_pv_wrmsr
  5:   0f 82 xx xx xx xx       jc     wrmsr_failed

	-hpa

