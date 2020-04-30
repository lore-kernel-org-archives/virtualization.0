From: Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH v3 08/75] x86/umip: Factor out instruction decoding
Date: Thu, 30 Apr 2020 18:31:55 +0200
Message-ID: <20200430163155.GB3996@zn.tnic>
References: <20200428151725.31091-1-joro@8bytes.org>
 <20200428151725.31091-9-joro@8bytes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20200428151725.31091-9-joro@8bytes.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Joerg Roedel <joro@8bytes.org>
Cc: x86@kernel.org, hpa@zytor.com, Andy Lutomirski <luto@kernel.org>, Dave Hansen <dave.hansen@linux.intel.com>, Peter Zijlstra <peterz@infradead.org>, Thomas Hellstrom <thellstrom@vmware.com>, Jiri Slaby <jslaby@suse.cz>, Dan Williams <dan.j.williams@intel.com>, Tom Lendacky <thomas.lendacky@amd.com>, Juergen Gross <jgross@suse.com>, Kees Cook <keescook@chromium.org>, David Rientjes <rientjes@google.com>, Cfir Cohen <cfir@google.com>, Erdem Aktas <erdemaktas@google.com>, Masami Hiramatsu <mhiramat@kernel.org>, Mike Stunes <mstunes@vmware.com>, Joerg Roedel <jroedel@suse.de>, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Tue, Apr 28, 2020 at 05:16:18PM +0200, Joerg Roedel wrote:
> +/**
> + * insn_decode() - Decode an instruction
> + * @regs:	Structure with register values as seen when entering kernel mode
> + * @insn:	Structure to store decoded instruction
> + * @buf:	Buffer containing the instruction bytes
> + * @buf_size:   Number of instruction bytes available in buf
> + *
> + * Decodes the instruction provided in buf and stores the decoding results in
> + * insn. Also determines the correct address and operand sizes.
> + *
> + * Returns:
> + *
> + * True if instruction was decoded, False otherwise.
> + */
> +bool insn_decode(struct pt_regs *regs, struct insn *insn,
> +		 unsigned char buf[MAX_INSN_SIZE], int buf_size)

Right, let's have @insn be the first function argument in all those
insn-handling functions.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
