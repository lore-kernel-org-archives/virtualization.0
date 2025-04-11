Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9D7A298984
	for <virtualization@lists.linux.dev>; Fri, 11 Apr 2025 21:12:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744405964; cv=none; b=RFtD5y1AAdHNZwmcy5RYzD0lP/rrfiHVvilWV4fk1RD8cz/bCP6qN4mDRvcb3TCDB+A8/5IX9MW1D0qOQZg7t8HBR6Nl5UhGg6C0l/wLXWr1++aPySmtD3Nk/biPZXPcc1YAdvI60iK23FhT+uqcRPJ6XMWon4kq66/d+1Xry1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744405964; c=relaxed/simple;
	bh=6nlXqivw5n2s2vI3iH0kICSGFjaF+JSbbOv3yESDDQ8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aiFN0p2GcFaiH0cQ+EnZu2Ip4sSm3R2+P/YRN14Nh0peNfMOn7xQIjwaB48c/JPS2j4ts6SG28mSMtXGOCcp9bR0RtkRYlnE60Qn1rp4YG35dWk3mK0rkSbfdIO6n5dSA2BNXWY606mZcz0y6U7VNR01o3tBaDZc5b6S/uuyabY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=IVb1Yi2R; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IVb1Yi2R"
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-5e5cbd8b19bso1077a12.1
        for <virtualization@lists.linux.dev>; Fri, 11 Apr 2025 14:12:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1744405960; x=1745010760; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5s9O/8O6xeMVl0tLPF60JEEeubmLlBJjqtBbS0i9ciQ=;
        b=IVb1Yi2RJi5i6Ou48TzFcfDzjsfLVnPu21Y3KrQVYaXpxKYspdCf90kOT/+m7we+ZE
         loVQ6itrNzII8DJoisJ/3ads/YOK12a9Z6VJOJ2M9BA/0+e0QJu5BkiScVjglrTLkLbT
         bPRWKzDuC+AZyd+NO3Mw2H4R+Riu1vtNlGHNCIv3PMIJerVm56srQYzp07tZxOJTYbqC
         cQsrA2B1G7cC6eNJ9K6no9iDzzHPEuYLGx8zB8AHE3TynDb6lRBJZ0ZSbjkD1lGIPWqG
         Xrv4upsFP7zllOQh5kZ4ObUxihjR2x+tQnEBeBAz4wtgig6aWa/D7VNVd0b/4KPg3ykc
         ZW0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744405960; x=1745010760;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5s9O/8O6xeMVl0tLPF60JEEeubmLlBJjqtBbS0i9ciQ=;
        b=hNnKmvdzxG0DjF6cRH1Zahc1bQvSSbYHTbmyZqEo0a1QNTrabcl0TQrB0qqDk8I0gC
         2bjU6VGnClRS1nMoMKEKwoo0zsbVxUInNx3pyQplfI8L9MlbW1+HmuS7N9s+JHfgaEzg
         XtCE1BZWNg0FrmHTHUhEFV98x5riIJgNyKrXiyUoaFunuIx0gZqZZYstv62eHGED0Gy6
         Tug9nIoJ1qycmxUefUCYv7gycH4rb4M5xFu5s8xJPU672XUqAawfVNNByMvi6AyrhY5d
         wG999u2Uo6KjydcXr72w+QuVTMF1kPB4O2g1tgQvIQm3TwHIoQUWTxspm+D8NTkg1a0A
         udsw==
X-Forwarded-Encrypted: i=1; AJvYcCXx7v/PwwjKOOhNrjQ85yrGLPOLEwPM8Tuhco1A9Pk7GRWzapu8u+x3OyOuxopOx1q1MHixmT3PSXJUbJiHKA==@lists.linux.dev
X-Gm-Message-State: AOJu0Yx8ecw+QDIVxa5HCNxCnxDn+L7b5PLoZg/DSjBAu5m1gb3wtgzc
	j5aODxyMvgFaZ4jr8KVbVvGw7X3MF805lv5o+o7YEHd6WGI3XxWVGW2yyfnZc5x1LQrQkelJZi0
	ZhglP/b3p73FXnne3V53WBzGM73/V5gAfAQat
X-Gm-Gg: ASbGnctdcgb3URs57/DKtYZRHMV3cx6q+VJVLZHNOyfA6r/ZgEZv5XWQqpLr9FcenTG
	wmsbBE8kFf7h8Rki5GVlUNvSGYACQdttq2ZmUMbBNNY3dyauYPWL3LG1gaOoiP5oZxQ8HiEk+rS
	4AuLj2gP4ftlFVmvGZkvc76Q==
X-Google-Smtp-Source: AGHT+IG84lvI3gcXlEPRkJRlkOu8tneyZgmJwr3mqViY4ItysXFcNimZTO7gtwpNKCM01C6d/tdsOPRrFemjcCrBnfs=
X-Received: by 2002:aa7:cfd6:0:b0:5ec:13d0:4505 with SMTP id
 4fb4d7f45d1cf-5f3ea1e2b1dmr6826a12.5.1744405959793; Fri, 11 Apr 2025 14:12:39
 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250331082251.3171276-1-xin@zytor.com> <20250331082251.3171276-11-xin@zytor.com>
 <Z_hTI8ywa3rTxFaz@google.com>
In-Reply-To: <Z_hTI8ywa3rTxFaz@google.com>
From: Jim Mattson <jmattson@google.com>
Date: Fri, 11 Apr 2025 14:12:27 -0700
X-Gm-Features: ATxdqUHkE9VKKw2s7zj6-Bzo7sFhtVG2VPQmJwr2UovOBmetGvqQ1ElvaKggsjw
Message-ID: <CALMp9eRJkzA2YXf1Dfxt3ONP+P9aTA=WPraOPJPJ6C6j677+6Q@mail.gmail.com>
Subject: Re: [RFC PATCH v1 10/15] KVM: VMX: Use WRMSRNS or its immediate form
 when available
To: Sean Christopherson <seanjc@google.com>
Cc: "Xin Li (Intel)" <xin@zytor.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, linux-hyperv@vger.kernel.org, 
	virtualization@lists.linux.dev, linux-edac@vger.kernel.org, 
	kvm@vger.kernel.org, xen-devel@lists.xenproject.org, 
	linux-ide@vger.kernel.org, linux-pm@vger.kernel.org, bpf@vger.kernel.org, 
	llvm@lists.linux.dev, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, 
	dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com, jgross@suse.com, 
	andrew.cooper3@citrix.com, peterz@infradead.org, acme@kernel.org, 
	namhyung@kernel.org, mark.rutland@arm.com, alexander.shishkin@linux.intel.com, 
	jolsa@kernel.org, irogers@google.com, adrian.hunter@intel.com, 
	kan.liang@linux.intel.com, wei.liu@kernel.org, ajay.kaher@broadcom.com, 
	alexey.amakhalov@broadcom.com, bcm-kernel-feedback-list@broadcom.com, 
	tony.luck@intel.com, pbonzini@redhat.com, vkuznets@redhat.com, 
	luto@kernel.org, boris.ostrovsky@oracle.com, kys@microsoft.com, 
	haiyangz@microsoft.com, decui@microsoft.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 10, 2025 at 4:24=E2=80=AFPM Sean Christopherson <seanjc@google.=
com> wrote:
>
> On Mon, Mar 31, 2025, Xin Li (Intel) wrote:
> > Signed-off-by: Xin Li (Intel) <xin@zytor.com>
> > ---
> >  arch/x86/include/asm/msr-index.h |  6 ++++++
> >  arch/x86/kvm/vmx/vmenter.S       | 28 ++++++++++++++++++++++++----
> >  2 files changed, 30 insertions(+), 4 deletions(-)
> >
> > diff --git a/arch/x86/include/asm/msr-index.h b/arch/x86/include/asm/ms=
r-index.h
> > index e6134ef2263d..04244c3ba374 100644
> > --- a/arch/x86/include/asm/msr-index.h
> > +++ b/arch/x86/include/asm/msr-index.h
> > @@ -1226,4 +1226,10 @@
> >                                               * a #GP
> >                                               */
> >
> > +/* Instruction opcode for WRMSRNS supported in binutils >=3D 2.40 */
> > +#define ASM_WRMSRNS          _ASM_BYTES(0x0f,0x01,0xc6)
> > +
> > +/* Instruction opcode for the immediate form RDMSR/WRMSRNS */
> > +#define ASM_WRMSRNS_RAX              _ASM_BYTES(0xc4,0xe7,0x7a,0xf6,0x=
c0)
> > +
> >  #endif /* _ASM_X86_MSR_INDEX_H */
> > diff --git a/arch/x86/kvm/vmx/vmenter.S b/arch/x86/kvm/vmx/vmenter.S
> > index f6986dee6f8c..9fae43723c44 100644
> > --- a/arch/x86/kvm/vmx/vmenter.S
> > +++ b/arch/x86/kvm/vmx/vmenter.S
> > @@ -64,6 +64,29 @@
> >       RET
> >  .endm
> >
> > +/*
> > + * Write EAX to MSR_IA32_SPEC_CTRL.
> > + *
> > + * Choose the best WRMSR instruction based on availability.
> > + *
> > + * Replace with 'wrmsrns' and 'wrmsrns %rax, $MSR_IA32_SPEC_CTRL' once=
 binutils support them.
> > + */
> > +.macro WRITE_EAX_TO_MSR_IA32_SPEC_CTRL
> > +     ALTERNATIVE_2 __stringify(mov $MSR_IA32_SPEC_CTRL, %ecx;         =
       \
> > +                               xor %edx, %edx;                        =
       \
> > +                               mov %edi, %eax;                        =
       \
> > +                               ds wrmsr),                             =
       \
> > +                   __stringify(mov $MSR_IA32_SPEC_CTRL, %ecx;         =
       \
> > +                               xor %edx, %edx;                        =
       \
> > +                               mov %edi, %eax;                        =
       \
> > +                               ASM_WRMSRNS),                          =
       \
> > +                   X86_FEATURE_WRMSRNS,                               =
       \
> > +                   __stringify(xor %_ASM_AX, %_ASM_AX;                =
       \
> > +                               mov %edi, %eax;                        =
       \
> > +                               ASM_WRMSRNS_RAX; .long MSR_IA32_SPEC_CT=
RL),   \
> > +                   X86_FEATURE_MSR_IMM
> > +.endm
>
> This is quite hideous.  I have no objection to optimizing __vmx_vcpu_run(=
), but
> I would much prefer that a macro like this live in generic code, and that=
 it be
> generic.  It should be easy enough to provide an assembly friendly equiva=
lent to
> __native_wrmsr_constant().

Surely, any CPU that has WRMSRNS also supports "Virtualize
IA32_SPEC_CTRL," right? Shouldn't we be using that feature rather than
swapping host and guest values with some form of WRMSR?

> > +
> >  .section .noinstr.text, "ax"
> >
> >  /**
> > @@ -123,10 +146,7 @@ SYM_FUNC_START(__vmx_vcpu_run)
> >       movl PER_CPU_VAR(x86_spec_ctrl_current), %esi
> >       cmp %edi, %esi
> >       je .Lspec_ctrl_done
> > -     mov $MSR_IA32_SPEC_CTRL, %ecx
> > -     xor %edx, %edx
> > -     mov %edi, %eax
> > -     wrmsr
> > +     WRITE_EAX_TO_MSR_IA32_SPEC_CTRL
> >
> >  .Lspec_ctrl_done:
> >
> > --
> > 2.49.0
> >
>
