From: Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH v3 40/75] x86/sev-es: Compile early handler code into
 kernel image
Date: Thu, 4 Jun 2020 17:19:53 +0200
Message-ID: <20200604151945.GB2246@zn.tnic>
References: <20200428151725.31091-1-joro@8bytes.org>
 <20200428151725.31091-41-joro@8bytes.org>
 <20200520091415.GC1457@zn.tnic>
 <20200604115413.GB30945@8bytes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20200604115413.GB30945@8bytes.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Joerg Roedel <joro@8bytes.org>
Cc: x86@kernel.org, hpa@zytor.com, Andy Lutomirski <luto@kernel.org>, Dave Hansen <dave.hansen@linux.intel.com>, Peter Zijlstra <peterz@infradead.org>, Jiri Slaby <jslaby@suse.cz>, Dan Williams <dan.j.williams@intel.com>, Tom Lendacky <thomas.lendacky@amd.com>, Juergen Gross <jgross@suse.com>, Kees Cook <keescook@chromium.org>, David Rientjes <rientjes@google.com>, Cfir Cohen <cfir@google.com>, Erdem Aktas <erdemaktas@google.com>, Masami Hiramatsu <mhiramat@kernel.org>, Mike Stunes <mstunes@vmware.com>, Joerg Roedel <jroedel@suse.de>, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Thu, Jun 04, 2020 at 01:54:13PM +0200, Joerg Roedel wrote:
> It is not only the trace-point, this would also eliminate exception
> handling in case the MSR access triggers a #GP. The "Unhandled MSR
> read/write" messages would turn into a "General Protection Fault"
> message.

But the early ones can trigger a #GP too. And there we can't handle
those #GPs.

Why would the late ones need exception handling all of a sudden? And
for the GHCB MSR, of all MSRs which the SEV-ES guest has used so far to
bootstrap?!

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
