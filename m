Received: from mail-ua1-f99.google.com (mail-ua1-f99.google.com [209.85.222.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F5CA37D114
	for <virtualization@lists.linux.dev>; Thu, 17 Sep 2026 23:08:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789686485; cv=none; b=IG0gEdzbkc2r3VSPM4sD/2Jb2DEWF3kfjRk2kcJQxivGd2zV9gdVAyopW4XLaGTiq6DPTJVk4zFfQOy5l24UNGf9M2vU6ktxURhfF3lsVtG/W9VX9K3moejkHb8f8DtuueTqXqv6fxwU6coPfKvz/l2E5DQkjUY1PBF8PKM67DY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789686485; c=relaxed/simple;
	bh=Qyk7IaW5D9rtnfADN57JI/cA1ywHq81PbOJcwVPWGSs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XhEhGQUYQSaDEZQiWGyESbHhTDOc1Sp4IUrn0MSEjoZLYjkzFCa2vSIepzgNIEs1g0FaZqjz2WvRXdAcbbrfX7sp3yCdHHQL9COFBuXe8yO91PewPBb8rauSQO94naghmB5w9l0nO8qpUdyW2QPQaJ6mwp0OBiH1DonIsHVsKfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=ZIOfmENo; arc=none smtp.client-ip=209.85.222.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="ZIOfmENo"
Received: by mail-ua1-f99.google.com with SMTP id a1e0cc1a2514c-98089686ee7so25806241.0
        for <virtualization@lists.linux.dev>; Thu, 17 Sep 2026 16:08:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789686476; x=1790291276;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=KkBkFvNjZkmBQ+ciR5KjrTSHBNZ+IYK3WHfHxYYYMK8=;
        b=vWPtqr74eQjzlnRtY/gXCZoj/sOm39/kLNKsUMoSqKg5YLwXpEcjHklKyiKK6hfhHZ
         EB27V0IBFru4Rf1/90hCgdDbdb3hMsFVviYTpKvApw2OV7w1/J7GOkr8ciW4DNtz5E1Y
         AmjfV+OqZD83vqquxeu0O76Pdt3jwxU8hIhBbJzZ1TURYAtKQ2jg2iYl6nAjFrCef7VM
         JAgF+bXthUVCrG7GzEGDh4UUlSIwPLD3sJatIicMNM47lvcpjyxv6iCQVe2XPQPNGqB0
         5n0TcHUiXnZGHBRRng5tR0Cdg18L/mD4nHFqqr1q3tlPbfjJuk0NXa8d3JAo8rgL4/Zd
         iU0w==
X-Forwarded-Encrypted: i=1; AKwUvBwrOasdlXU6Gumn3ZdCy5TOaFCV1VHbBEubKDTnmP4vjyltbmAMnAZd7SHiqOTnsJ/ZsCR4u2ST8D2AE8ZcVg==@lists.linux.dev
X-Gm-Message-State: AFuF++nzYce/5fEWvSuaZ7d5i2NTPr3Zh35C0MoDzXIPloa70T73PVfC
	0pwgmepEHOIZTfDQeXYRlN1xMpfXh7Ee6YBIDQd7SLoyEoHj8/PXoVHcBppz41GFJWZwav6PrJl
	f7geoDL2Mn6zW29Bm9VBUeu3sRU++fKEyfvaIFVEcLPalRc/+XuTnapVBUN2nK9x85IDeuHsRuJ
	b+lYT+RjzD2B6u0/uReLIirtdjmHiDI/35dXRJ6LVOg20KGq3m7ZfFzKYeWgVlJnIOwKx4yHbQm
	lPMliBe7s72XKQwugGoPWBJQyA=
X-Gm-Gg: AYBFou2eH8ht8/utFnp2TmL9+nQnu2P/NaFerixpLspZea78ndMeSvrb9cdZfnp1FMr
	KiL5f3kMN5sNFELnr/RKsaHY8jOIZaaK7CAGBjNhLflxKdadhkFglSakmeaXbfxB+DothGU8yBX
	HoqcsMNJeBzVjg/6bp9rMjpAlSQspnqJ4oRvSbGl76AUA3L82o424sRjQ+FSezqDLZ/lUjYsQV1
	Zfm7MTzR6EV9CfKAW0FQNGjbHk8wx/+O6zne62ouOqsFTGDe4EbrUSAokCXOjE5uzkk/dkGuk5N
	ZQRoFoS0TSss4V0Vdt9NY6yzQqRRNM8blddmA/w953kvYyqk8PD5hllhDMUxTUd5BkMRjObVgZG
	HlOBpWiBiwOWEaPPz4r0CwPzcn1scKv/lfGPthBOGpQFvGDl5TY9J5MEc2/S1QwShw21M8vY3P2
	xn2GxEJxTKFlcthqZ8gN0sRMS2/fd0nRIMt6/KSz3nfb4=
X-Received: by 2002:a05:6102:510a:b0:7a1:f7e2:aadf with SMTP id ada2fe7eead31-7a55c28a242mr349409137.17.1789686476391;
        Thu, 17 Sep 2026 16:07:56 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-125.dlp.protect.broadcom.com. [144.49.247.125])
        by smtp-relay.gmail.com with ESMTPS id 71dfb90a1353d-5c9a524df98sm1578614e0c.3.2026.09.17.16.07.56
        for <virtualization@lists.linux.dev>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 17 Sep 2026 16:07:56 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-cc4e496e5c3so55235a12.0
        for <virtualization@lists.linux.dev>; Thu, 17 Sep 2026 16:07:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1789686475; x=1790291275; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=KkBkFvNjZkmBQ+ciR5KjrTSHBNZ+IYK3WHfHxYYYMK8=;
        b=ZIOfmENoyHAtAHpc8jvCgMRgnSKHdMSnmRahUNYFdZtXbKkCmej0+P+GXnpEXcW/Iu
         RRJyOGFp+hGfz5EODAfR4a4aruBz3yxaOixIR0mlfNYqyseDS6SMB3IIck/ft5jbFter
         Ub62w2rCjDBMTSbwToWSQfEPx7mTFWunlp6to=
X-Forwarded-Encrypted: i=1; AKwUvBxStJNSw5/r/CUvwZ/QiA0cZNUtPd1re+iAdkWrVAt+L6Nf4PVyyJdIkBvhvOjKnc7gV8Jb7VDG72Q/s0h1ig==@lists.linux.dev
X-Received: by 2002:a17:90b:1e04:b0:39e:4c80:f680 with SMTP id 98e67ed59e1d1-39e54f3dba9mr1123049a91.31.1789686474961;
        Thu, 17 Sep 2026 16:07:54 -0700 (PDT)
X-Received: by 2002:a17:90b:1e04:b0:39e:4c80:f680 with SMTP id 98e67ed59e1d1-39e54f3dba9mr1122991a91.31.1789686474393;
        Thu, 17 Sep 2026 16:07:54 -0700 (PDT)
Received: from [10.211.247.235] ([216.221.25.44])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-33bf596e1f6sm21060020eec.1.2026.09.17.16.07.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Sep 2026 16:07:54 -0700 (PDT)
Message-ID: <58026818-7737-4560-be64-5cf22f2d8d69@broadcom.com>
Date: Thu, 17 Sep 2026 16:07:56 -0700
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 0/4] x86/vmware: Preserve panic diagnostics in
 vmware.log
To: Zack Rusin <zack.rusin@broadcom.com>, Borislav Petkov <bp@alien8.de>,
 Ajay Kaher <ajay.kaher@broadcom.com>,
 Alexey Makhalov <alexey.makhalov@broadcom.com>, x86@kernel.org,
 Petr Mladek <pmladek@suse.com>, Joel Granados <joel.granados@kernel.org>,
 Baoquan He <baoquan.he@linux.dev>
Cc: Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
 Dave Hansen <dave.hansen@linux.intel.com>, "H . Peter Anvin"
 <hpa@zytor.com>, virtualization@lists.linux.dev,
 bcm-kernel-feedback-list@broadcom.com, linux-kernel@vger.kernel.org,
 John Ogness <john.ogness@linutronix.de>, Steven Rostedt
 <rostedt@goodmis.org>, Sergey Senozhatsky <senozhatsky@chromium.org>,
 Kees Cook <kees@kernel.org>, Andrew Morton <akpm@linux-foundation.org>,
 Mike Rapoport <rppt@kernel.org>, Pasha Tatashin <pasha.tatashin@soleen.com>,
 Pratyush Yadav <pratyush@kernel.org>, Dave Young <ruirui.yang@linux.dev>,
 Jonathan Corbet <corbet@lwn.net>, Bo Gan <bo.gan@broadcom.com>,
 Brennan Lamoreaux <brennan.lamoreaux@broadcom.com>,
 kexec@lists.infradead.org, linux-doc@vger.kernel.org
References: <cover.1788414671.git.zack.rusin@broadcom.com>
From: Maaz Mombasawala <maaz.mombasawala@broadcom.com>
Content-Language: en-US
In-Reply-To: <cover.1788414671.git.zack.rusin@broadcom.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

On 9/8/26 11:07 AM, Zack Rusin wrote:
> A virtual machine may have neither guest-local persistent storage nor
> working userspace after a panic. The host's vmware.log remains available
> after the VM terminates, and a production encrypted guest is the only
> component able to export readable panic text. Hyper-V already provides
> this class of host-persistent panic reporting.
> 
> Add a panic-only VMware logger that copies the newest 4 KiB of the kernel
> log and sends it with bounded low-bandwidth RPC work. Ordinary guests
> enable text transfer by default; encrypted guests require an administrator
> to opt in through kernel.vmware_record_panic_msg. A separate late dumper
> reports the structured crash event after built-in dumpers and suppresses
> the event while a crash kernel is loaded, because a configured VMware host
> may terminate the VM before the reporting hypercall returns.
> 
> Patch 4 makes panic diagnostics run before kdump by default on VMware
> guests. This follows existing platform uses of
> crash_kexec_post_notifiers, with Hyper-V as the closest guest-reporting
> precedent. Unlike Hyper-V, VMware exposes no capability bit for this
> behavior. An explicit crash_kexec_post_notifiers=0 still wins, and patch 4
> can be dropped without affecting patches 1 through 3.
> 
> This replaces patches 2 and 3 of Alexey's v2 posting:
> https://lore.kernel.org/all/20260309235250.2611115-1-alexey.makhalov@broadcom.com/
> 
> The intended merge path is tip's x86/vmware branch. Boris please review the
> VMware transport and policy. Petr and John, please review the panic-only
> dumper use and registration ordering. Joel and Kees, please review the
> sysctl. Baoquan and the KEXEC/KDUMP team, please review the 
> loaded-crash-kernel guard and the default in patch 4.
> 
> Zack Rusin (4):
>   x86/vmware: Add a bounded panic log sender
>   x86/vmware: Add the vmware_record_panic_msg sysctl
>   x86/vmware: Report guest crashes after kmsg dumpers
>   x86/vmware: Run panic diagnostics before kdump by default
> 
>  Documentation/admin-guide/sysctl/kernel.rst |  14 ++
>  arch/x86/include/asm/vmware.h               |   2 +
>  arch/x86/kernel/cpu/vmware.c                | 245 ++++++++++++++++++++
>  3 files changed, 261 insertions(+)
> 
> 
> base-commit: cee9395acd8043be0644b25c34bfa86623f2b935


LGTM for the series

Reviewed-by: Maaz Mombasawala <maaz.mombasawala@broadcom.com>

-- 
Maaz Mombasawala <maaz.mombasawala@broadcom.com>
