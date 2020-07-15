From: Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH v4 15/75] x86/boot/compressed/64: Always switch to own
 page-table
Date: Tue, 14 Jul 2020 18:23:47 -0700
Message-ID: <202007141823.326D9DC102@keescook>
References: <20200714120917.11253-1-joro@8bytes.org>
 <20200714120917.11253-16-joro@8bytes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20200714120917.11253-16-joro@8bytes.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Joerg Roedel <joro@8bytes.org>
Cc: x86@kernel.org, Joerg Roedel <jroedel@suse.de>, hpa@zytor.com, Andy Lutomirski <luto@kernel.org>, Dave Hansen <dave.hansen@linux.intel.com>, Peter Zijlstra <peterz@infradead.org>, Jiri Slaby <jslaby@suse.cz>, Dan Williams <dan.j.williams@intel.com>, Tom Lendacky <thomas.lendacky@amd.com>, Juergen Gross <jgross@suse.com>, David Rientjes <rientjes@google.com>, Cfir Cohen <cfir@google.com>, Erdem Aktas <erdemaktas@google.com>, Masami Hiramatsu <mhiramat@kernel.org>, Mike Stunes <mstunes@vmware.com>, Sean Christopherson <sean.j.christopherson@intel.com>, Martin Radev <martin.b.radev@gmail.com>, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Tue, Jul 14, 2020 at 02:08:17PM +0200, Joerg Roedel wrote:
> From: Joerg Roedel <jroedel@suse.de>
> 
> When booted through startup_64 the kernel keeps running on the EFI
> page-table until the KASLR code sets up its own page-table. Without
> KASLR the pre-decompression boot code never switches off the EFI
> page-table. Change that by unconditionally switching to a kernel
> controlled page-table after relocation.
> 
> This makes sure we can make changes to the mapping when necessary, for
> example map pages unencrypted in SEV and SEV-ES guests.
> 
> Also remove the debug_putstr() calls in initialize_identity_maps()
> because the function now runs before console_init() is called.
> 
> Signed-off-by: Joerg Roedel <jroedel@suse.de>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
