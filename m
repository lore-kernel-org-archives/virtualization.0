From: Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH v3 23/75] x86/boot/compressed/64: Setup GHCB Based VC
 Exception handler
Date: Wed, 13 May 2020 10:59:28 +0200
Message-ID: <20200513085928.GB4025@zn.tnic>
References: <20200428151725.31091-1-joro@8bytes.org>
 <20200428151725.31091-24-joro@8bytes.org>
 <20200512181157.GD6859@zn.tnic>
 <20200512210812.GF8135@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20200512210812.GF8135@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Joerg Roedel <jroedel@suse.de>, Masami Hiramatsu <mhiramat@kernel.org>
Cc: Joerg Roedel <joro@8bytes.org>, x86@kernel.org, hpa@zytor.com, Andy Lutomirski <luto@kernel.org>, Dave Hansen <dave.hansen@linux.intel.com>, Peter Zijlstra <peterz@infradead.org>, Thomas Hellstrom <thellstrom@vmware.com>, Jiri Slaby <jslaby@suse.cz>, Dan Williams <dan.j.williams@intel.com>, Tom Lendacky <thomas.lendacky@amd.com>, Juergen Gross <jgross@suse.com>, Kees Cook <keescook@chromium.org>, David Rientjes <rientjes@google.com>, Cfir Cohen <cfir@google.com>, Erdem Aktas <erdemaktas@google.com>, Mike Stunes <mstunes@vmware.com>, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Tue, May 12, 2020 at 11:08:12PM +0200, Joerg Roedel wrote:
> No, this is a recent addition, otherwise this breaks out-of-tree builds
> (make O=/some/path ...) because inat-tables.c (included from inat.c) is
> generated during build and ends up in the $(objtree).

Please add a blurb about this above it otherwise no one would have a
clue why it is there.

> Because the immediate is the last part of the instruction which is
> decoded (even if there is no immediate). The .got field is set when
> either the immediate was decoded successfully or, in case the
> instruction has no immediate, when the rest of the instruction was
> decoded successfully. So testing immediate.got is the indicator whether
> decoding was successful.

Hm, whether the immediate was parsed correctly or it wasn't there and
using that as the sign whether the instruction was decoded successfully
sounds kinda arbitrary.

@Masami: shouldn't that insn_get_length() thing return a value to denote
whether the decode was successful or not instead of testing arbitrary
fields?

Pasting for you the code sequence again:

	...
        insn_get_length(&ctxt->insn);

        ret = ctxt->insn.immediate.got ? ES_OK : ES_DECODE_FAILED;
	...

I wonder if one would be able to do instead:

	if (insn_get_length(&ctxt->insn))
		return ES_OK;

	return ES_DECODE_FAILED;

to have it straight-forward...

> Probably better rename the function, it also does the sev-es protocol
> version negotiation and all other related setup tasks. Maybe
> sev_es_setup() is a better name?

Sure.

> If the above call fails its the end of the systems lifetime, because we
> can't continue to boot an SEV-ES guest when we have no GHCB.
> 
> BUG_ON() and friends are also not available in the pre-decompression
> boot stage.

Oh ok, error() does hlt the system.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
