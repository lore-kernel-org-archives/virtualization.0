Received: from mail-wr2-f12.google.com (mail-wr2-f12.google.com [74.125.225.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E469582BBF
	for <virtualization@lists.linux.dev>; Wed, 23 Sep 2026 20:15:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.225.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790194535; cv=pass; b=HnGtN0Kr1aH6A8OsTzt9iltjlMWv5dxBKuzrf7R7Ri5kI4sOX+Hg5Ur9qxF1kLE55/iqbQt0Ai720KQBKZVMYhxwJbCfOZuJ7GCdTCwJ9wkwucmsIfEW44o0bMSgvAoDtn9kpeHBLFp53gB+w4NZEzLnxfuT25vm1jweIlkvzGQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790194535; c=relaxed/simple;
	bh=AG+velq+P1x1sJHq2Eyj+yYuHBfJGE1bCcGBCBjr5A4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hR/gRanQcsKvMbj2g+8CBvYnMhRki8gneUU6dakdwkS309Pw2x9zJPu3OlfzN2nd4Sp6Plij0iGvI3fLS8RK7ch/ThxBGOfdC6Z21wKreZPa4+2C7G8hVeFSqvdCS10WPJbbHtOjw7608L0O7kUn8d4tlB2QgYEBHJZU1gVLRfA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=WR1CJfYG; arc=pass smtp.client-ip=74.125.225.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WR1CJfYG"
Received: by mail-wr2-f12.google.com with SMTP id ffacd0b85a97d-482f6356f6bso1098780f8f.2
        for <virtualization@lists.linux.dev>; Wed, 23 Sep 2026 13:15:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790194526; cv=none;
        d=google.com; s=arc-20260327;
        b=eD9uFI+JFnjpXZoM7jJ6ccOvCzgo4u70mSfY5dAbDpCCe7kE9Inuz2Cyc6kQiGRtxX
         +9w+FN4ceNzfwHz7HgxmU2w0DcAqU5t6fH16HMrp62V/o5sO5soE/F8vDUXLnfQh4heU
         d14e+dsB7wGN1+PZTVX/rSR/te/wdovX9dRz4qG6bbQIorOZt92AZ6Tj4sdaQQtMF/An
         C7V0SQJORM7vYq+mkA4H9bzzwL02x3wycTK5dQS3mrGig24H6Mfjcjlk8rN3AtlydrJD
         edPbDAxwU9GtyCW171WyM56FoYNtij81l5UO2iqyNTpduyNpinEbwozNUZnsDS319cfp
         1aeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=kOoYO2x0ceYQoltgnReOSIDMz30qflbKcG3KVK6oiAM=;
        fh=5/gi7Q0SCNxqRGmeuhJDP8o6XR8MJ8c8ZsyfjRmz/EY=;
        b=rR1MypdKI1ogTH2gB+auhzZmbO76cZuujJ3ZNeg+62wr0zDquO/p7gE8oZInUb0kYN
         B6ZZnqKNOfocvKyvEYZGr07m+6cUQ4/ScxW/0qqFhf2lDkDffScs/czQ3z1+uzg/XKtk
         DZMVe73AA0Ic7KacnFnvCSqJX17V1wgiaFkzmlwIoZYQwyLQHY8c9ecL+y/k4JgBIaVd
         Nfhe00ZgbWqS1OsTqO38dJNAAAMRDTi2kEQn0tJ9hj0xCXtNeBsYzOmxdVk393wBgkiG
         NVVCnY9SIuQpGS+U2KaF0v7BvJ/YsqShMisLj7C1capsdb0h56UvvLiNMS39yE71fGvd
         +wDA==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790194526; x=1790799326; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=kOoYO2x0ceYQoltgnReOSIDMz30qflbKcG3KVK6oiAM=;
        b=WR1CJfYGluYZ4Ozv2fHOuIYTmIvZUTW1dySz8G735AU4jnDTcY6UPGK5ptsQ11t5Jh
         19I1Mr3JTlWjkvYmrNgfeCPl8Kyqq48gqtOLr0Lgf2TICzE7DiHfknGfUdMEwKkoOMsK
         jPTxyEDot/A0seqH878x6CgEhd9ltD5ta1Y0PDelxk1wra6P92LHdAW3MBpyDGv+d9y3
         E8p1Q+hqM7vMqbsjz+/kK5WqVU7ps4M6UlAm0D/JB3QsHYi1tR1mVU8a2xek15D/BH0S
         3UGL03aMinEpPUm0QRWt3kQOowrloL+mBXAArKxucNR1G8dKkV+JeCbxx/n26srPjlv/
         X7+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790194526; x=1790799326;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=kOoYO2x0ceYQoltgnReOSIDMz30qflbKcG3KVK6oiAM=;
        b=IdbJNHkSG5Owo+TLlxKF0dNTaJbuClYBLXByvhNAEZT+BxTRdmFy7NPBkbRBu4sA+m
         tO/qxaR2kHgGt95goRHGwakfk3Ae4+6ifLiHO+x3nBmie9REoecl4Kfyja7+KtzWq+eS
         vahCHXXjX1H89Q78mw/tH/wIbc/kSpUrv0EoeoPahVWEh11PJiJJhgXCl2jdl0NfKnOb
         Mg12hYXWpEKil5i+tzH6NF8llvGeMJPuxgqWi7hgf9wv0gzsbHcSgm2Iv1vpa5ePrF19
         8dc9FmX2pZpS6Gu3EwsogMjN4CqJ2TWGdyfARo49R9Slz4p5mHt8Kvr3rRE8faPBh7Fv
         zUuQ==
X-Forwarded-Encrypted: i=1; AKwUvByBMgSJ586o91c4IzA4RdULpazpS8hdbuRcdqgg6qsWwcXbifKJ4Wa5ctc+gkakKf/MS1mVi/KQAND6fwY2oQ==@lists.linux.dev
X-Gm-Message-State: AFuF++lq8tgwYwkKkB2x/b/WVAPpLujC01jSK1ikAUP8RjNQfzdF9NmA
	zxyIsE8C14udvMHKlVgXbgh/uNYLeO6dSmJLqFfjFllc0y3tJ2lRlSXazVuv0eLzBsEr9pFOBNp
	ftr9jbtQd87a8FPIk1LBCtvJHUuK6864fmOgc8388
X-Gm-Gg: AYBFou0YlQ/YFMfztqPAaqEIr97Oqt9RQyYAS4tvPU+zJJ5IoO0CHLBnedUbqtf1FOc
	HRs670Q9kEypxMhPbk4l5FMFFfT7dBjVISAx4+NGYrn1etiVbRZ70Io8Rq7UbbOzErxctYctlDB
	WjrH8mRcMcFDAApXqtU9M4RwmLsITPGX+9YdTYXqDIJ9p1VyldF9XniA/IW3FO+iSZAaaimHGN0
	27Fe/S2o6VdEir2Kl3Gsk8YVpnuCFT93JszcofBy2twRISfL7BYNFCfbCBbGrHAsRjRZBGQFs/+
	g1nenc5Ro0uQNtMxAouvyZT6zWYkZDw+cbyTukMC0biBvHWxHsGQTir8HiU0ReQPlMW5+je4iBs
	a8bSQ8H1y82w6NM662wJyjrKDWf2DkL+5Rs1wkQxhuumOkZrDFbal7CxIfhFTJULSygM0sWdiXY
	XOgg==
X-Received: by 2002:a05:6000:2383:b0:485:ad55:208d with SMTP id
 ffacd0b85a97d-488716c8d48mr511088f8f.18.1790194525443; Wed, 23 Sep 2026
 13:15:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260911084211.3149957-1-jgross@suse.com> <20260923193619.1408940-1-shreshth.srivastava@intel.com>
In-Reply-To: <20260923193619.1408940-1-shreshth.srivastava@intel.com>
From: Nick Desaulniers <ndesaulniers@google.com>
Date: Wed, 23 Sep 2026 13:15:14 -0700
X-Gm-Features: AclHuK-BmScte-vitIZ7FKAidjIiegIYr2tRDSSJKsz3-ZO8Fal-vgtzUYiiixY
Message-ID: <CAKwvOdnKS+E9R3QaFk98dPNNh7uW=8yuJpYWGPHbY7k40Fk=rw@mail.gmail.com>
Subject: Re: [PATCH v5 00/17] x86/msr: Inline rdmsr/wrmsr instructions
To: Shreshth Srivastava <shreshth.srivastava@intel.com>, Juergen Gross <jgross@suse.com>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org, linux-coco@lists.linux.dev, 
	kvm@vger.kernel.org, linux-hyperv@vger.kernel.org, 
	virtualization@lists.linux.dev, llvm@lists.linux.dev, tglx@kernel.org, 
	mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com, hpa@zytor.com, 
	xin@zytor.com, nathan@kernel.org, jpoimboe@kernel.org, peterz@infradead.org, 
	boris.ostrovsky@oracle.com, xen-devel@lists.xenproject.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 23, 2026 at 12:36=E2=80=AFPM Shreshth Srivastava
<shreshth.srivastava@intel.com> wrote:
>
> On 11.09.26 10:41, Juergen Gross wrote:
> > When building a kernel with CONFIG_PARAVIRT_XXL the paravirt
> > infrastructure will always use functions for reading or writing MSRs,
> > even when running on bare metal.
>
> Hi Juergen,
>
> This doesn't build with CONFIG_PARAVIRT_XXL=3Dy. 16/17 and 17/17 are wher=
e
> it breaks, but the cause is the .byte fallbacks: ASM_WRMSRNS_IMM from
> 08/17 and ASM_RDMSR_IMM from 10/17 don't end in a separator, unlike the
> .insn variants above them.
>
>   #define ASM_RDMSR_IMM                         \
>         " .byte 0xc4,0xe7,0x7b,0xf6,0xc0; .long %c[msr]"
>
> That worked while they were only ever the last argument of an
> ALTERNATIVE(), which appends its own newline. 16/17 concatenates them
> with ASM_CLRERR:
>
>         ASM_RDMSR_IMM ASM_CLRERR, X86_FEATURE_MSR_IMM,  \
>
> so the .long operand runs into the xor. From
> make arch/x86/kernel/cpu/common.s:
>
>         .byte 0xc4,0xe7,0x7b,0xf6,0xc0; .long 266xor %rdx,%rdx
>
>   paravirt-msr.h:165: Error: junk at end of line, first unrecognized char=
acter is `x'
>
> clang reports "error: unexpected token" in the same place. 71 objects
> fail, the same 71 either way, no vmlinux.
>
> msr.h chooses between the .insn form and the .byte fallback with:
>
>         #if defined(CONFIG_AS_IS_GNU) && CONFIG_AS_VERSION >=3D 24100
>
> Two kinds of toolchain end up on the .byte side of that test:
>
>   - GNU as older than 2.41. RHEL 9 and CentOS Stream 9 ship 2.35, and
>     Documentation/process/changes.rst sets the minimum at 2.30, so this
>     is a supported configuration rather than an old outlier.
>   - clang, any version. CONFIG_AS_IS_GNU is never set for clang, so the
>     && short-circuits and the version comparison is never reached. Your
>     08/17 comment already notes that clang has no .insn support.

Indeed, looks like we're missing support for .insn for x86.
Filed https://github.com/llvm/llvm-project/issues/225916.
(Please do file bugs against the toolchain when you encounter issues
like this, and cc someone from kernel development).

>
> gcc with binutils 2.41 or newer takes the .insn path, where both macros
> do end in a separator, and is unaffected.
>
> Reproduced on v7.3-rc2 with your v3 00/13, v2 0/5 and v5 00/17 applied in
> that order, x86_64 defconfig plus HYPERVISOR_GUEST, PARAVIRT, XEN and
> XEN_PV. gcc 11.5.0 with GNU as 2.35.2, and clang 21.1.7.
>
> Terminating both fallbacks fixes it, and both toolchains then build
> vmlinux with no errors or warnings:
>
> diff --git a/arch/x86/include/asm/msr.h b/arch/x86/include/asm/msr.h
> index eba325ecfe4c..529c13553c63 100644
> --- a/arch/x86/include/asm/msr.h
> +++ b/arch/x86/include/asm/msr.h
> @@ -78,9 +78,9 @@ static inline void do_trace_rdpmc(u32 msr, u64 val, int=
 failed) {}
>   * form MSR access instructions reference %rax as the register operand.
>   */
>  #define ASM_RDMSR_IMM                          \
> -       " .byte 0xc4,0xe7,0x7b,0xf6,0xc0; .long %c[msr]"
> +       " .byte 0xc4,0xe7,0x7b,0xf6,0xc0; .long %c[msr]\n\t"
>  #define ASM_WRMSRNS_IMM                                \
> -       " .byte 0xc4,0xe7,0x7a,0xf6,0xc0; .long %c[msr]"
> +       " .byte 0xc4,0xe7,0x7a,0xf6,0xc0; .long %c[msr]\n\t"
>  #endif
>
>  #define RDMSR_AND_SAVE_RESULT                  \
>
> ASM_WRMSRNS needs no change, _ASM_BYTES() already emits a semicolon.
>
> The WRMSRNS line belongs in 08/17 and the RDMSR line in 10/17.
>
> Thanks,
> Shreshth



--=20
Thanks,
~Nick Desaulniers
