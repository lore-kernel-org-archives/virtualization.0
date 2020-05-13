From: Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH v3 24/75] x86/boot/compressed/64: Unmap GHCB page before
 booting the kernel
Date: Wed, 13 May 2020 13:46:33 +0200
Message-ID: <20200513114633.GE4025@zn.tnic>
References: <20200428151725.31091-1-joro@8bytes.org>
 <20200428151725.31091-25-joro@8bytes.org>
 <20200513111340.GD4025@zn.tnic>
 <20200513113011.GG18353@8bytes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <kvm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20200513113011.GG18353@8bytes.org>
Sender: kvm-owner@vger.kernel.org
To: Joerg Roedel <joro@8bytes.org>
Cc: x86@kernel.org, hpa@zytor.com, Andy Lutomirski <luto@kernel.org>, Dave Hansen <dave.hansen@linux.intel.com>, Peter Zijlstra <peterz@infradead.org>, Thomas Hellstrom <thellstrom@vmware.com>, Jiri Slaby <jslaby@suse.cz>, Dan Williams <dan.j.williams@intel.com>, Tom Lendacky <thomas.lendacky@amd.com>, Juergen Gross <jgross@suse.com>, Kees Cook <keescook@chromium.org>, David Rientjes <rientjes@google.com>, Cfir Cohen <cfir@google.com>, Erdem Aktas <erdemaktas@google.com>, Masami Hiramatsu <mhiramat@kernel.org>, Mike Stunes <mstunes@vmware.com>, Joerg Roedel <jroedel@suse.de>, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Wed, May 13, 2020 at 01:30:11PM +0200, Joerg Roedel wrote:
> Yeah, I had this this way in v2, but changed it upon you request[1] :)

Yeah, I was wondering why this isn't a separate function - you like them
so much. :-P

> [1] https://lore.kernel.org/lkml/20200402114941.GA9352@zn.tnic/

But that one didn't have the ghcb_fault check. Maybe it was being added
later... :)

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
