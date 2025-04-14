Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25E46288CBB;
	Mon, 14 Apr 2025 17:13:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744650796; cv=none; b=Frzv/z6XOI2iN/pJ53E80meHn1bEBeT4vUCz9oX9SMPZJq7CVC6Nw8as1N5ufzCXsul7G7JM3GD5BtCteWtrasyOsDfiiSD5E+SdAYSv0RS1pVSoXWce2Wx+c6M/nK0JCbTl0xpVTl1v41VgdtfQTn9H+nSOpSLe76B8hFXc0BI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744650796; c=relaxed/simple;
	bh=sFTaMFijVk2HZVriqjm0aoHOUR8tYLFf51KFMR53Zes=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:Content-Type:
	 MIME-Version; b=I1DUy43a2I3NF7bEY88nFzuxIUQN1MlNlc1HE0xkYw9y3O2fCcEH4MER/FE6SwF0eM6mI5BwHfofD0klVjBkrw3aM0p0rfQ6tzb3gu2lNvEsHHZ5Gk+Yox/tO+8IMCYQ8iqu/4EJn7V5tiVNKgBmqEquOrvh0M/lVdjmVfi0MuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=heQozt/B; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="heQozt/B"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-43d2d952eb1so37605175e9.1;
        Mon, 14 Apr 2025 10:13:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744650793; x=1745255593; darn=lists.linux.dev;
        h=mime-version:user-agent:content-transfer-encoding:in-reply-to:date
         :cc:to:from:subject:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AhLhCv09lRa1OLV+bmnI0sicXwTDVpYEF9Itb4YCx/Y=;
        b=heQozt/B7Dt9CND25Gdsn0FFp+JtVUsH2pdoKkTRxrhV/wdGIc+j/mXSMZpRzTVTyS
         mXnZi4Fd33Km8s7x8tM5agm+qYMoCttTgZBGi49nBPeSMgO1I9v+fraMaDDIUaJd+XqY
         ZQ6QJTZqSKC7x6cR8l4YpaNa3Dw0PQ3OeUBb/9MZqPv5mFhTTK3Z6oTqlSWKY13lUvSt
         qWuHUB6lcqZdlfSRiF1rHETwRSJBVJbHl//jN/mHgLPB7V0l4gnH5nNvCGcASyMhGgic
         i3YX/L4ATiH51b8O09UN14IAx1HlotCc6X3K/NTTfres8KnW+/LCy9eKe572H2UiJvNQ
         Wy1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744650793; x=1745255593;
        h=mime-version:user-agent:content-transfer-encoding:in-reply-to:date
         :cc:to:from:subject:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=AhLhCv09lRa1OLV+bmnI0sicXwTDVpYEF9Itb4YCx/Y=;
        b=EUeKrsfQtIu4CfDYWrCD1RlYKF7Z8fQhNv9UtNEmmjpfckDB16iuoz+YpMHXGkni+2
         CmuKf/XIhM08ieSosZXS3rRDjBTLKUI4RnpyEMK+DrzUc+zVmnTjDkChhLwkR0ErEInu
         FO0jn9wNAFUVsjuMsHDm8Rz9PrIKzuyIOyAoASgNxObMJMdxUiagltKIIIqzdPBqUYk6
         na1Xk1UAiNrxCp2REEXzApeuDLrv7ps6QLPVEdciZ1ZQMSuMi5rPOYO9DPq+Bl6pjcNR
         pjgH0R8FBDnafsU6MA2eGfQ7cjPCcToACKZ3fobHtWBvtG9DJFW2rORWVYNaN9FWO03w
         MPGQ==
X-Forwarded-Encrypted: i=1; AJvYcCWDm3F9JUvTvH031L92u6Dr4hUm0Nx+2+yUbYrfjcCbYrdYoommLX3Fjz1FrK5QHr5sX2N7@lists.linux.dev, AJvYcCX0gxUbeeklfbKLtETtowQ8kMEJ1jFAvI7AxIHZ11qTXImla+EBZkV16Ttj/cK/pJH9DOCfN1Mjc0+VRAtdeh8=@lists.linux.dev
X-Gm-Message-State: AOJu0YyyzA28Ujr+VySYHVYuOMgj/YI2Cf9/87dVwaOcZTTrXAWus8H/
	C9SxQOkvWD4fnqGGORluWnSfQo7zNdJSmZe59b9dUI5FJ8HPeD74
X-Gm-Gg: ASbGncv0jyindZBBa0ZIQp1KQ1XfUbCVnUia/nAGdBo7yfe68xE8f6VqpZvy8a2+lwW
	Wphew5uGXF6bUeqYFjlg7tidRTs4ef/x4IbOVf0hOHSFo8+e4ZfUk+j9rhGMYVzNr/2AtPV5HOF
	owgXNs7AcLJK/fYXZyu28gPfr3KnkiuRExKb6l6H+aEgYeSOYyKKXQLsgj1sSmLX4VUu6Vom1sW
	BqinBBaXVFcpsHMfmeRWr/1CHD44LVnDnyJGRC10tq2G93u+f0W1ilGwd3GWto93+ideoSC8Fe1
	uqvQJC98IcsNb9akSx5mPhEDUporblbZgw6sznIKZKvdfno/Jbn3XE7tsx+ThG1gfEd3P+8808m
	dfPs8vJRuS1bS5ERC6W53oA==
X-Google-Smtp-Source: AGHT+IFaPusiZQT0QiFcyLJp0TXK65g3+z16rgMNv9l2dKvCZ0RLPJLCBzoBrYTr6CV/HfnsWx9kLw==
X-Received: by 2002:a05:600c:8519:b0:43d:300f:fa51 with SMTP id 5b1f17b1804b1-43f3a93ebb3mr115773795e9.9.1744650792986;
        Mon, 14 Apr 2025 10:13:12 -0700 (PDT)
Received: from ?IPv6:2001:b07:5d29:f42d:74f6:abb7:53c9:817c? ([2001:b07:5d29:f42d:74f6:abb7:53c9:817c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43f204c500bsm191180875e9.0.2025.04.14.10.13.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Apr 2025 10:13:12 -0700 (PDT)
Message-ID: <0f4f2ed70829fffb2eb816e34e26be22681705a5.camel@gmail.com>
Subject: Re: [RFC PATCH v1 13/15] x86/msr: Use the alternatives mechanism to
 read MSR
From: Francesco Lavra <francescolavra.fl@gmail.com>
To: xin@zytor.com
Cc: acme@kernel.org, adrian.hunter@intel.com, ajay.kaher@broadcom.com, 
 alexander.shishkin@linux.intel.com, alexey.amakhalov@broadcom.com, 
 andrew.cooper3@citrix.com, bcm-kernel-feedback-list@broadcom.com, 
 boris.ostrovsky@oracle.com, bp@alien8.de, bpf@vger.kernel.org, 
 dave.hansen@linux.intel.com, decui@microsoft.com, haiyangz@microsoft.com, 
 hpa@zytor.com, irogers@google.com, jgross@suse.com, jolsa@kernel.org, 
 kan.liang@linux.intel.com, kvm@vger.kernel.org, kys@microsoft.com, 
 linux-edac@vger.kernel.org, linux-hyperv@vger.kernel.org, 
 linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-perf-users@vger.kernel.org, linux-pm@vger.kernel.org,
 llvm@lists.linux.dev,  luto@kernel.org, mark.rutland@arm.com,
 mingo@redhat.com, namhyung@kernel.org,  pbonzini@redhat.com,
 peterz@infradead.org, seanjc@google.com, tglx@linutronix.de, 
 tony.luck@intel.com, virtualization@lists.linux.dev, vkuznets@redhat.com, 
 wei.liu@kernel.org, x86@kernel.org, xen-devel@lists.xenproject.org
Date: Mon, 14 Apr 2025 19:13:09 +0200
In-Reply-To: <20250331082251.3171276-14-xin@zytor.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4-2 
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

On 2025-03-31 at 8:22, Xin Li (Intel) wrote:
> diff --git a/arch/x86/xen/xen-asm.S b/arch/x86/xen/xen-asm.S
> index e672632b1cc0..6e7a9daa03d4 100644
> --- a/arch/x86/xen/xen-asm.S
> +++ b/arch/x86/xen/xen-asm.S
> @@ -399,3 +399,37 @@ SYM_CODE_END(xen_entry_SYSCALL_compat)
>  	RET
>  SYM_FUNC_END(asm_xen_write_msr)
>  EXPORT_SYMBOL_GPL(asm_xen_write_msr)
> +
> +/*
> + * The prototype of the Xen C code:
> + * 	struct { u64 val, bool done } xen_do_read_msr(u32 msr)
> + */
> +SYM_FUNC_START(asm_xen_read_msr)
> +	ENDBR
> +	FRAME_BEGIN
> +	XEN_SAVE_CALLEE_REGS_FOR_MSR
> +	mov %ecx, %edi		/* MSR number */
> +	call xen_do_read_msr
> +	test %dl, %dl		/* %dl=3D1, i.e., ZF=3D0, meaning
> successfully done */
> +	XEN_RESTORE_CALLEE_REGS_FOR_MSR
> +	jnz 2f
> +
> +1:	rdmsr
> +	_ASM_EXTABLE_FUNC_REWIND(1b, -5, FRAME_OFFSET /
> (BITS_PER_LONG / 8))
> +	shl $0x20, %rdx
> +	or %rdx, %rax
> +	/*
> +	 * The top of the stack points directly at the return
> address;
> +	 * back up by 5 bytes from the return address.
> +	 */

This works only if this function has been called directly (e.g. via
`call asm_xen_write_msr`), but doesn't work with alternative call types
(like indirect calls). Not sure why one might want to use an indirect
call to invoke asm_xen_write_msr, but this creates a hidden coupling
between caller and callee.
I don't have a suggestion on how to get rid of this coupling, other
than setting ipdelta in _ASM_EXTABLE_FUNC_REWIND() to 0 and adjusting
the _ASM_EXTABLE_TYPE entries at the call sites to consider the
instruction that follows the function call (instead of the call
instruction) as the faulting instruction (which seems pretty ugly, at
least because what follows the function call could be an instruction
that might itself fault). But you may want to make this caveat explicit
in the comment.
