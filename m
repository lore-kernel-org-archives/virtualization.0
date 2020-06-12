From: Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH v3 47/75] x86/sev-es: Add Runtime #VC Exception Handler
Date: Fri, 12 Jun 2020 15:13:19 +0200
Message-ID: <20200612131310.GB22660@zn.tnic>
References: <20200428151725.31091-1-joro@8bytes.org>
 <20200428151725.31091-48-joro@8bytes.org>
 <20200523075924.GB27431@zn.tnic>
 <20200611114831.GA11924@8bytes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <kvm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20200611114831.GA11924@8bytes.org>
Sender: kvm-owner@vger.kernel.org
To: Joerg Roedel <joro@8bytes.org>
Cc: x86@kernel.org, hpa@zytor.com, Andy Lutomirski <luto@kernel.org>, Dave Hansen <dave.hansen@linux.intel.com>, Peter Zijlstra <peterz@infradead.org>, Jiri Slaby <jslaby@suse.cz>, Dan Williams <dan.j.williams@intel.com>, Tom Lendacky <thomas.lendacky@amd.com>, Juergen Gross <jgross@suse.com>, Kees Cook <keescook@chromium.org>, David Rientjes <rientjes@google.com>, Cfir Cohen <cfir@google.com>, Erdem Aktas <erdemaktas@google.com>, Masami Hiramatsu <mhiramat@kernel.org>, Mike Stunes <mstunes@vmware.com>, Joerg Roedel <jroedel@suse.de>, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Thu, Jun 11, 2020 at 01:48:31PM +0200, Joerg Roedel wrote:
> The most important use-case is #VC->NMI->#VC. When an NMI hits while the
> #VC handler uses the GHCB and the NMI handler causes another #VC, then
> the contents of the GHCB needs to be backed up, so that it doesn't
> destroy the GHCB contents of the first #VC handling path.

That's a good example, please add it to the next version of the patch,
preferrably in a comment somewhere.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
