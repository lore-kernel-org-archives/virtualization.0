From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [RFC PATCH 00/62] Linux as SEV-ES Guest Support
Date: Tue, 11 Feb 2020 15:50:08 +0100
Message-ID: <20200211145008.GT14914@hirez.programming.kicks-ass.net>
References: <20200211135256.24617-1-joro@8bytes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20200211135256.24617-1-joro@8bytes.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Joerg Roedel <joro@8bytes.org>
Cc: x86@kernel.org, hpa@zytor.com, Andy Lutomirski <luto@kernel.org>, Dave Hansen <dave.hansen@linux.intel.com>, Thomas Hellstrom <thellstrom@vmware.com>, Jiri Slaby <jslaby@suse.cz>, Dan Williams <dan.j.williams@intel.com>, Tom Lendacky <thomas.lendacky@amd.com>, Juergen Gross <jgross@suse.com>, Kees Cook <keescook@chromium.org>, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org, Joerg Roedel <jroedel@suse.de>
List-Id: virtualization@lists.linuxfoundation.org

On Tue, Feb 11, 2020 at 02:51:54PM +0100, Joerg Roedel wrote:
> NMI Special Handling
> --------------------
> 
> The last thing that needs special handling with SEV-ES are NMIs.
> Hypervisors usually start to intercept IRET instructions when an NMI got
> injected to find out when the NMI window is re-opened. But handling IRET
> intercepts requires the hypervisor to access guest register state and is
> not possible with SEV-ES. The specification under [1] solves this
> problem with an NMI_COMPLETE message sent my the guest to the
> hypervisor, upon which the hypervisor re-opens the NMI window for the
> guest.
> 
> This patch-set sends the NMI_COMPLETE message before the actual IRET,
> while the kernel is still on a valid stack and kernel cr3. This opens
> the NMI-window a few instructions early, but this is fine as under
> x86-64 Linux NMI-nesting is safe. The alternative would be to
> single-step over the IRET, but that requires more intrusive changes to
> the entry code because it does not handle entries from kernel-mode while
> on the entry stack.
> 
> Besides the special handling above the patch-set contains the handlers
> for the #VC exception and all the exit-codes specified in [1].

Oh gawd; so instead of improving the whole NMI situation, AMD went and
made it worse still ?!?
