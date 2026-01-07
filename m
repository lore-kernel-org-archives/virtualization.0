Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 358F332FA2E
	for <virtualization@lists.linux.dev>; Wed,  7 Jan 2026 09:55:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767779717; cv=none; b=cs0+PjebA862jleIfLS1c90OZV7c7efkAJJd3F14F0EwGBXRdQk2W1QG7XsiJ4C7BBHPW2Lf+yPAjeeHO9eEqUqkIJXQLzBnIK+dsbVNFfSMqVq8aWu6UIcZ3TryZONlKa2H43WnZPcjSyEPIMKm/ccip/9I30RPxr5kOqOe4to=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767779717; c=relaxed/simple;
	bh=bJ7aQzrM8P1kvR1z/HiJg+UJewPHtbc4D90VJYDYp4A=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=rSOiKE9vUCZ3ONZYAcOhkzUVFpMrsGa1qZPTONeoZPWH+vibaYCRJ9DW1MYXDUiVNoTb+WD/G0JlKJJjLrTtjYlSuDXFQLRc81f1LM27KbjIvNiBQ7WeOiGV1jU44PspKDMwG7lzuBwVa5HT+TbYzLN09TfQzqPQ7H0i12ZxJro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com; spf=pass smtp.mailfrom=zytor.com; dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b=dyOh+kkb; arc=none smtp.client-ip=198.137.202.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zytor.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="dyOh+kkb"
Received: from ehlo.thunderbird.net (c-76-133-66-138.hsd1.ca.comcast.net [76.133.66.138])
	(authenticated bits=0)
	by mail.zytor.com (8.18.1/8.17.1) with ESMTPSA id 6079sfcm865076
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
	Wed, 7 Jan 2026 01:54:42 -0800
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 6079sfcm865076
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2025122301; t=1767779682;
	bh=f1pwzMim8tFJN1Nnu+bmsnQ1VOmSg5fMU/nWzZotRFQ=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=dyOh+kkbMbIN4s6CZWrMzFq6uFHY619Xgvc+qWXDvh7290QcVqidtUIoX1Szlv2/2
	 7vBcXid9cbpSLPvCy/J363dJ2pcV27gqxpjb3mQngCjT8/zEQplCfEiC9BJIuFeuiX
	 Ij4K07muVkzr/85ziVDOz6hHSHfACurpFhtIjcgx3gZBzNYznY36T/8uLrvyRjzINx
	 ljkro2TMmLc55EA5Gf8JNlY5Ua8tP0FRf+B+taelj5Lb/kNVVMu23EhrUhisF+sluV
	 9pg2Fe4WKhT8MpDt+RoNYU+4YWNBJu18eI101ppz8KXmpZxoVvOMlcLwOMnPbIfhAf
	 PotfmoJ9lrB8Q==
Date: Wed, 07 Jan 2026 01:54:40 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
To: Uros Bizjak <ubizjak@gmail.com>, bcm-kernel-feedback-list@broadcom.com,
        virtualization@lists.linux.dev, x86@kernel.org,
        linux-kernel@vger.kernel.org
CC: Juergen Gross <jgross@suse.com>, Ajay Kaher <ajay.kaher@broadcom.com>,
        Alexey Makhalov <alexey.makhalov@broadcom.com>,
        Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_RESEND_2/2=5D_x86/paravirt=3A_Use_XOR_r32?=
 =?US-ASCII?Q?=2Cr32_to_clear_register_in_pv=5Fvcpu=5Fis=5Fpreempted=28=29?=
User-Agent: K-9 Mail for Android
In-Reply-To: <20260105093944.52387-2-ubizjak@gmail.com>
References: <20260105093944.52387-1-ubizjak@gmail.com> <20260105093944.52387-2-ubizjak@gmail.com>
Message-ID: <E17D1D99-5F9C-4D49-9F4B-91AFE33E6EC4@zytor.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

On January 5, 2026 1:39:07 AM PST, Uros Bizjak <ubizjak@gmail=2Ecom> wrote:
>x86_64 zero extends 32bit operations, so for 64bit operands,
>XOR r32,r32 is functionally equal to XOR r64,r64, but avoids
>a REX prefix byte when legacy registers are used=2E
>
>Signed-off-by: Uros Bizjak <ubizjak@gmail=2Ecom>
>Reviewed-by: Juergen Gross <jgross@suse=2Ecom>
>Cc: Ajay Kaher <ajay=2Ekaher@broadcom=2Ecom>
>Cc: Alexey Makhalov <alexey=2Emakhalov@broadcom=2Ecom>
>Cc: Thomas Gleixner <tglx@linutronix=2Ede>
>Cc: Ingo Molnar <mingo@kernel=2Eorg>
>Cc: Borislav Petkov <bp@alien8=2Ede>
>Cc: Dave Hansen <dave=2Ehansen@linux=2Eintel=2Ecom>
>Cc: "H=2E Peter Anvin" <hpa@zytor=2Ecom>
>---
> arch/x86/include/asm/paravirt=2Eh | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>
>diff --git a/arch/x86/include/asm/paravirt=2Eh b/arch/x86/include/asm/par=
avirt=2Eh
>index 4f6ec60b4cb3=2E=2E59aec695ae5f 100644
>--- a/arch/x86/include/asm/paravirt=2Eh
>+++ b/arch/x86/include/asm/paravirt=2Eh
>@@ -577,7 +577,7 @@ static __always_inline void pv_kick(int cpu)
> static __always_inline bool pv_vcpu_is_preempted(long cpu)
> {
> 	return PVOP_ALT_CALLEE1(bool, lock=2Evcpu_is_preempted, cpu,
>-				"xor %%" _ASM_AX ", %%" _ASM_AX,
>+				"xor %%eax, %%eax",
> 				ALT_NOT(X86_FEATURE_VCPUPREEMPT));
> }
>=20

Acked-by: H=2E Peter Anvin (Intel) <hpa@zytor=2Ecom>
