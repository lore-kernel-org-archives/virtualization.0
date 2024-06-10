Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 374C552F6A
	for <virtualization@lists.linux-foundation.org>; Mon, 10 Jun 2024 10:30:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718015452; cv=none; b=uIjFxCoqj6F9U46YIYI8h1YhKVWj52S5HdNHkiEISX+r928qf3h8AdlvwrO8isAW4VMr4wvOtqP2iYJhTtuxVePASlk9ExYtm7MQu3enm05acGNus26sWKve1nI5GRUMr7gxlVzW++0sgXeilLYr02/VIORlMD57Xok0yaVn7qk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718015452; c=relaxed/simple;
	bh=zeW049fuoqE+ykETuiDe/btmCUo6QQMkrefjBUhjkIs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OVtWjsohRRMAK63FRVvwfkW84nml4PMv+eVFV6K68flEyvPS14GQVPmjh6yk0+kc9AweXHi6riafv7cI6zkytfvg3C+JZ+Z/4SxtHLN/N+FNEMcEv68dL0FPMsviyr8SdOAnb/2s27K3mAJOX2Eujh11YhF/eP9/tQNi/zTHLTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=t0RG0fhY; arc=none smtp.client-ip=140.211.166.138
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="t0RG0fhY"
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id BD7BF821BD
	for <virtualization@lists.linux-foundation.org>; Mon, 10 Jun 2024 10:30:50 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -4.401
X-Spam-Level:
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id oA06xG8RFlE6 for <virtualization@lists.linux-foundation.org>;
 Mon, 10 Jun 2024 10:30:49 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2604:1380:40e1:4800::1; helo=sin.source.kernel.org; envelope-from=gregkh@linuxfoundation.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 2A59182082
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 2A59182082
Authentication-Results: smtp1.osuosl.org;
	dkim=pass (1024-bit key, unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=t0RG0fhY
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 2A59182082
	for <virtualization@lists.linux-foundation.org>; Mon, 10 Jun 2024 10:30:48 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id 893CBCE0C4D;
	Mon, 10 Jun 2024 10:30:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4BE28C2BBFC;
	Mon, 10 Jun 2024 10:30:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1718015443;
	bh=zeW049fuoqE+ykETuiDe/btmCUo6QQMkrefjBUhjkIs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=t0RG0fhYn7XuwUJKw6O2I+oypzDIv/lEMGDWhP1ifnw/3XvjKrHGbluCLXtTSgXmn
	 xst3b7UlJOnLN9ThSWF8o4n+HvAjBxw6LdodMyypKPUNCE93wV3dNpIdITBjRZOben
	 KzrqxyLcG3WSqG80CW9i+Uj7fAFCWjWUW4OZfkA8=
Date: Mon, 10 Jun 2024 12:30:40 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: vsntk18@gmail.com
Cc: x86@kernel.org, Borislav.Petkov@amd.com, Dhaval.Giani@amd.com,
	ashish.kalra@amd.com, cfir@google.com, dan.j.williams@intel.com,
	dave.hansen@linux.intel.com, ebiederm@xmission.com,
	erdemaktas@google.com, hpa@zytor.com, jgross@suse.com,
	jroedel@suse.de, jslaby@suse.cz, keescook@chromium.org,
	kexec@lists.infradead.org, kvm@vger.kernel.org,
	linux-coco@lists.linux.dev, linux-kernel@vger.kernel.org,
	luto@kernel.org, martin.b.radev@gmail.com, mhiramat@kernel.org,
	michael.roth@amd.com, mstunes@vmware.com, nivedita@alum.mit.edu,
	peterz@infradead.org, rientjes@google.com, seanjc@google.com,
	stable@vger.kernel.org, thomas.lendacky@amd.com,
	virtualization@lists.linux-foundation.org, vkarasulli@suse.de
Subject: Re: [PATCH v6 00/10] x86/sev: KEXEC/KDUMP support for SEV-ES guests
Message-ID: <2024061024-portside-richly-5be4@gregkh>
References: <20240610102113.20969-1-vsntk18@gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240610102113.20969-1-vsntk18@gmail.com>

On Mon, Jun 10, 2024 at 12:21:03PM +0200, vsntk18@gmail.com wrote:
> From: Vasant Karasulli <vkarasulli@suse.de>
> 
> Hi,
> 
> here are changes to enable kexec/kdump in SEV-ES guests. The biggest
> problem for supporting kexec/kdump under SEV-ES is to find a way to
> hand the non-boot CPUs (APs) from one kernel to another.
> 
> Without SEV-ES the first kernel parks the CPUs in a HLT loop until
> they get reset by the kexec'ed kernel via an INIT-SIPI-SIPI sequence.
> For virtual machines the CPU reset is emulated by the hypervisor,
> which sets the vCPU registers back to reset state.
> 
> This does not work under SEV-ES, because the hypervisor has no access
> to the vCPU registers and can't make modifications to them. So an
> SEV-ES guest needs to reset the vCPU itself and park it using the
> AP-reset-hold protocol. Upon wakeup the guest needs to jump to
> real-mode and to the reset-vector configured in the AP-Jump-Table.
> 
> The code to do this is the main part of this patch-set. It works by
> placing code on the AP Jump-Table page itself to park the vCPU and for
> jumping to the reset vector upon wakeup. The code on the AP Jump Table
> runs in 16-bit protected mode with segment base set to the beginning
> of the page. The AP Jump-Table is usually not within the first 1MB of
> memory, so the code can't run in real-mode.
> 
> The AP Jump-Table is the best place to put the parking code, because
> the memory is owned, but read-only by the firmware and writeable by
> the OS. Only the first 4 bytes are used for the reset-vector, leaving
> the rest of the page for code/data/stack to park a vCPU. The code
> can't be in kernel memory because by the time the vCPU wakes up the
> memory will be owned by the new kernel, which might have overwritten it
> already.
> 
> The other patches add initial GHCB Version 2 protocol support, because
> kexec/kdump need the MSR-based (without a GHCB) AP-reset-hold VMGEXIT,
> which is a GHCB protocol version 2 feature.
> 
> The kexec'ed kernel is also entered via the decompressor and needs
> MMIO support there, so this patch-set also adds MMIO #VC support to
> the decompressor and support for handling CLFLUSH instructions.
> 
> Finally there is also code to disable kexec/kdump support at runtime
> when the environment does not support it (e.g. no GHCB protocol
> version 2 support or AP Jump Table over 4GB).
> 
> The diffstat looks big, but most of it is moving code for MMIO #VC
> support around to make it available to the decompressor.
> 
> The previous version of this patch-set can be found here:
> 
> 	https://lore.kernel.org/kvm/20240408074049.7049-1-vsntk18@gmail.com/
> 
> Please review.
> 
> Thanks,
>    Vasant
> 
> Changes v5->v6:
>         - Rebased to v6.10-rc3 kernel
>    
> Changes v4->v5:
>         - Rebased to v6.9-rc2 kernel
> 	- Applied review comments by Tom Lendacky
> 	  - Exclude the AP jump table related code for SEV-SNP guests
> 
> Changes v3->v4:
>         - Rebased to v6.8 kernel
> 	- Applied review comments by Sean Christopherson
> 	- Combined sev_es_setup_ap_jump_table() and sev_setup_ap_jump_table()
>           into a single function which makes caching jump table address
>           unnecessary
>         - annotated struct sev_ap_jump_table_header with __packed attribute
> 	- added code to set up real mode data segment at boot time instead of
>           hardcoding the value.
> 
> Joerg Roedel (9):
>   x86/kexec/64: Disable kexec when SEV-ES is active
>   x86/sev: Save and print negotiated GHCB protocol version
>   x86/sev: Set GHCB data structure version
>   x86/sev: Setup code to park APs in the AP Jump Table
>   x86/sev: Park APs on AP Jump Table with GHCB protocol version 2
>   x86/sev: Use AP Jump Table blob to stop CPU
>   x86/sev: Add MMIO handling support to boot/compressed/ code
>   x86/sev: Handle CLFLUSH MMIO events
>   x86/kexec/64: Support kexec under SEV-ES with AP Jump Table Blob
> 
> Vasant Karasulli (1):
>   x86/sev: Exclude AP jump table related code for SEV-SNP guests
> 
>  arch/x86/boot/compressed/sev.c          |  45 +-
>  arch/x86/include/asm/insn-eval.h        |   1 +
>  arch/x86/include/asm/realmode.h         |   5 +
>  arch/x86/include/asm/sev-ap-jumptable.h |  30 +
>  arch/x86/include/asm/sev.h              |   7 +
>  arch/x86/kernel/machine_kexec_64.c      |  12 +
>  arch/x86/kernel/process.c               |   8 +
>  arch/x86/kernel/sev-shared.c            | 234 +++++-
>  arch/x86/kernel/sev.c                   | 376 +++++-----
>  arch/x86/lib/insn-eval-shared.c         | 921 ++++++++++++++++++++++++
>  arch/x86/lib/insn-eval.c                | 911 +----------------------
>  arch/x86/realmode/Makefile              |   9 +-
>  arch/x86/realmode/init.c                |   5 +-
>  arch/x86/realmode/rm/Makefile           |  11 +-
>  arch/x86/realmode/rm/header.S           |   3 +
>  arch/x86/realmode/rm/sev.S              |  85 +++
>  arch/x86/realmode/rmpiggy.S             |   6 +
>  arch/x86/realmode/sev/Makefile          |  33 +
>  arch/x86/realmode/sev/ap_jump_table.S   | 131 ++++
>  arch/x86/realmode/sev/ap_jump_table.lds |  24 +
>  20 files changed, 1711 insertions(+), 1146 deletions(-)
>  create mode 100644 arch/x86/include/asm/sev-ap-jumptable.h
>  create mode 100644 arch/x86/lib/insn-eval-shared.c
>  create mode 100644 arch/x86/realmode/rm/sev.S
>  create mode 100644 arch/x86/realmode/sev/Makefile
>  create mode 100644 arch/x86/realmode/sev/ap_jump_table.S
>  create mode 100644 arch/x86/realmode/sev/ap_jump_table.lds
> 
> 
> base-commit: 83a7eefedc9b56fe7bfeff13b6c7356688ffa670
> -- 
> 2.34.1
> 
> 

<formletter>

This is not the correct way to submit patches for inclusion in the
stable kernel tree.  Please read:
    https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html
for how to do this properly.

</formletter>
