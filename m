From: Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH v3 74/75] x86/sev-es: Handle NMI State
Date: Wed, 3 Jun 2020 11:59:23 +0200
Message-ID: <20200603095923.GB19711@zn.tnic>
References: <20200428151725.31091-1-joro@8bytes.org>
 <20200428151725.31091-75-joro@8bytes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20200428151725.31091-75-joro@8bytes.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
 <mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
 <mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>
To: Joerg Roedel <joro@8bytes.org>
Cc: Juergen Gross <jgross@suse.com>, Tom Lendacky <thomas.lendacky@amd.com>, Dave Hansen <dave.hansen@linux.intel.com>, Mike Stunes <mstunes@vmware.com>, Kees Cook <keescook@chromium.org>, kvm@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, Cfir Cohen <cfir@google.com>, x86@kernel.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, Joerg Roedel <jroedel@suse.de>, Masami Hiramatsu <mhiramat@kernel.org>, Andy Lutomirski <luto@kernel.org>, hpa@zytor.com, Erdem Aktas <erdemaktas@google.com>, David Rientjes <rientjes@google.com>, Dan Williams <dan.j.williams@intel.com>, Jiri Slaby <jslaby@suse.cz>
List-Id: virtualization@lists.linuxfoundation.org

On Tue, Apr 28, 2020 at 05:17:24PM +0200, Joerg Roedel wrote:
> diff --git a/arch/x86/kernel/nmi.c b/arch/x86/kernel/nmi.c
> index 27d1016ec840..8898002e5600 100644
> --- a/arch/x86/kernel/nmi.c
> +++ b/arch/x86/kernel/nmi.c
> @@ -511,6 +511,13 @@ NOKPROBE_SYMBOL(is_debug_stack);
>  dotraplinkage notrace void
>  do_nmi(struct pt_regs *regs, long error_code)
>  {
> +	/*
> +	 * Re-enable NMIs right here when running as an SEV-ES guest. This might
> +	 * cause nested NMIs, but those can be handled safely.
> +	 */
> +	if (sev_es_active())
> +		sev_es_nmi_complete();

Pls move the comment and the sev_es_active() check into
the sev_es_nmi_complete() function.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
