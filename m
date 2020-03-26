From: Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH 06/70] x86/umip: Factor out instruction fetch
Date: Thu, 26 Mar 2020 18:21:46 +0100
Message-ID: <20200326172146.GF11398@zn.tnic>
References: <20200319091407.1481-1-joro@8bytes.org>
 <20200319091407.1481-7-joro@8bytes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20200319091407.1481-7-joro@8bytes.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Joerg Roedel <joro@8bytes.org>
Cc: x86@kernel.org, hpa@zytor.com, Andy Lutomirski <luto@kernel.org>, Dave Hansen <dave.hansen@linux.intel.com>, Peter Zijlstra <peterz@infradead.org>, Thomas Hellstrom <thellstrom@vmware.com>, Jiri Slaby <jslaby@suse.cz>, Dan Williams <dan.j.williams@intel.com>, Tom Lendacky <thomas.lendacky@amd.com>, Juergen Gross <jgross@suse.com>, Kees Cook <keescook@chromium.org>, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org, Joerg Roedel <jroedel@suse.de>
List-Id: virtualization@lists.linuxfoundation.org

On Thu, Mar 19, 2020 at 10:13:03AM +0100, Joerg Roedel wrote:
> From: Joerg Roedel <jroedel@suse.de>
> 
> Factor out the code to fetch the instruction from user-space to a helper
> function.

Add "No functional changes." here.

> Signed-off-by: Joerg Roedel <jroedel@suse.de>
> ---
>  arch/x86/include/asm/insn-eval.h |  2 ++
>  arch/x86/kernel/umip.c           | 26 +++++-----------------
>  arch/x86/lib/insn-eval.c         | 38 ++++++++++++++++++++++++++++++++
>  3 files changed, 46 insertions(+), 20 deletions(-)

...

> +int insn_fetch_from_user(struct pt_regs *regs,
> +			 unsigned char buf[MAX_INSN_SIZE])

No need for that linebreak - fits in 80 cols.

> +{
> +	unsigned long seg_base = 0;
> +	int not_copied;
> +
> +	/*
> +	 * If not in user-space long mode, a custom code segment could be in
> +	 * use. This is true in protected mode (if the process defined a local
> +	 * descriptor table), or virtual-8086 mode. In most of the cases
> +	 * seg_base will be zero as in USER_CS.
> +	 */
> +	if (!user_64bit_mode(regs))
> +		seg_base = insn_get_seg_base(regs, INAT_SEG_REG_CS);
> +
> +	if (seg_base == -1L)
> +		return 0;

This reads strange: seg_base is changed only inside that if test so I
guess we could test it there too:

        if (!user_64bit_mode(regs)) {
                seg_base = insn_get_seg_base(regs, INAT_SEG_REG_CS);
                if (seg_base == -1L)
                        return 0;
        }

which is a small enough change to not require a separate patch.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
