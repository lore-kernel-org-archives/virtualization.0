From: Juergen Gross <jgross@suse.com>
Subject: Re: [RFC PATCH] x86/paravirt: Kill some unused patching functions
Date: Thu, 5 Nov 2015 12:15:07 +0100
Message-ID: <563B3A3B.8020804@suse.com>
References: <1446542329-32037-1-git-send-email-bp@alien8.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1446542329-32037-1-git-send-email-bp@alien8.de>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Borislav Petkov <bp@alien8.de>, LKML <linux-kernel@vger.kernel.org>
Cc: Jeremy Fitzhardinge <jeremy@goop.org>, "Peter Zijlstra (Intel)" <peterz@infradead.org>, virtualization@lists.linux-foundation.org, Chris Wright <chrisw@sous-sol.org>, Ingo Molnar <mingo@redhat.com>, Andy Lutomirski <luto@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>, xen-devel@lists.xenproject.org, Andrew Morton <akpm@linux-foundation.org>, Thomas Gleixner <tglx@linutronix.de>
List-Id: virtualization@lists.linuxfoundation.org

On 11/03/2015 10:18 AM, Borislav Petkov wrote:
> From: Borislav Petkov <bp@suse.de>
>
> paravirt_patch_ignore() is completely unused and paravirt_patch_nop()
> doesn't do a whole lot. Remove them both.
>
> Signed-off-by: Borislav Petkov <bp@suse.de>

Reviewed-by: Juergen Gross <jgross@suse.com>

> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Andy Lutomirski <luto@kernel.org>
> Cc: Chris Wright <chrisw@sous-sol.org>
> Cc: "H. Peter Anvin" <hpa@zytor.com>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Jeremy Fitzhardinge <jeremy@goop.org>
> Cc: Juergen Gross <jgross@suse.com>
> Cc: "Peter Zijlstra (Intel)" <peterz@infradead.org>
> Cc: Rusty Russell <rusty@rustcorp.com.au>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: virtualization@lists.linux-foundation.org
> Cc: xen-devel@lists.xenproject.org
> ---
>   arch/x86/include/asm/paravirt_types.h |  2 --
>   arch/x86/kernel/paravirt.c            | 13 +------------
>   2 files changed, 1 insertion(+), 14 deletions(-)
>
> diff --git a/arch/x86/include/asm/paravirt_types.h b/arch/x86/include/asm/paravirt_types.h
> index 31247b5bff7c..e1f31dfc3b31 100644
> --- a/arch/x86/include/asm/paravirt_types.h
> +++ b/arch/x86/include/asm/paravirt_types.h
> @@ -402,10 +402,8 @@ extern struct pv_lock_ops pv_lock_ops;
>   	__visible extern const char start_##ops##_##name[], end_##ops##_##name[];	\
>   	asm(NATIVE_LABEL("start_", ops, name) code NATIVE_LABEL("end_", ops, name))
>
> -unsigned paravirt_patch_nop(void);
>   unsigned paravirt_patch_ident_32(void *insnbuf, unsigned len);
>   unsigned paravirt_patch_ident_64(void *insnbuf, unsigned len);
> -unsigned paravirt_patch_ignore(unsigned len);
>   unsigned paravirt_patch_call(void *insnbuf,
>   			     const void *target, u16 tgt_clobbers,
>   			     unsigned long addr, u16 site_clobbers,
> diff --git a/arch/x86/kernel/paravirt.c b/arch/x86/kernel/paravirt.c
> index c2130aef3f9d..4f32a10979db 100644
> --- a/arch/x86/kernel/paravirt.c
> +++ b/arch/x86/kernel/paravirt.c
> @@ -74,16 +74,6 @@ void __init default_banner(void)
>   /* Undefined instruction for dealing with missing ops pointers. */
>   static const unsigned char ud2a[] = { 0x0f, 0x0b };
>
> -unsigned paravirt_patch_nop(void)
> -{
> -	return 0;
> -}
> -
> -unsigned paravirt_patch_ignore(unsigned len)
> -{
> -	return len;
> -}
> -
>   struct branch {
>   	unsigned char opcode;
>   	u32 delta;
> @@ -152,8 +142,7 @@ unsigned paravirt_patch_default(u8 type, u16 clobbers, void *insnbuf,
>   		/* If there's no function, patch it with a ud2a (BUG) */
>   		ret = paravirt_patch_insns(insnbuf, len, ud2a, ud2a+sizeof(ud2a));
>   	else if (opfunc == _paravirt_nop)
> -		/* If the operation is a nop, then nop the callsite */
> -		ret = paravirt_patch_nop();
> +		ret = 0;
>
>   	/* identity functions just return their single argument */
>   	else if (opfunc == _paravirt_ident_32)
>
