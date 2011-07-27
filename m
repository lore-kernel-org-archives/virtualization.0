From: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Subject: Re: [PATCH 4/5] x86-64/xen: Enable the vvar mapping
Date: Wed, 27 Jul 2011 09:06:04 -0400
Message-ID: <20110727130604.GD6713__41275.0627067455$1311772123$gmane$org@dumpdata.com>
References: <cover.1311736366.git.luto@mit.edu>
	<b6598d164fbe64eeea37c0369b64dd6ceaeeb504.1311736366.git.luto@mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <b6598d164fbe64eeea37c0369b64dd6ceaeeb504.1311736366.git.luto@mit.edu>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Andy Lutomirski <luto@mit.edu>
Cc: xen-devel@lists.xensource.com, x86@kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, virtualization@lists.linux-foundation.org, keir.xen@gmail.com
List-Id: virtualization@lists.linuxfoundation.org

On Tue, Jul 26, 2011 at 11:20:38PM -0400, Andy Lutomirski wrote:
> Xen needs special treatment for fixmaps.

The description needs a bit more, for example:

"Xen needs to handle the newly introduced VVAR_PAGE introduced by
git commit 9fd67b4ed0714ab718f1f9bd14c344af336a6df7
"x86-64: Give vvars their own page"

Otherwise we die during bootup with this:

<and include snippets of the boot message crash>
"

With that included it looks good to me.

> 
> Signed-off-by: Andy Lutomirski <luto@mit.edu>
> Reported-by: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
> ---
>  arch/x86/xen/mmu.c |    4 +++-
>  1 files changed, 3 insertions(+), 1 deletions(-)
> 
> diff --git a/arch/x86/xen/mmu.c b/arch/x86/xen/mmu.c
> index f987bde..8cce339 100644
> --- a/arch/x86/xen/mmu.c
> +++ b/arch/x86/xen/mmu.c
> @@ -1916,6 +1916,7 @@ static void xen_set_fixmap(unsigned idx, phys_addr_t phys, pgprot_t prot)
>  # endif
>  #else
>  	case VSYSCALL_LAST_PAGE ... VSYSCALL_FIRST_PAGE:
> +	case VVAR_PAGE:
>  #endif
>  	case FIX_TEXT_POKE0:
>  	case FIX_TEXT_POKE1:
> @@ -1956,7 +1957,8 @@ static void xen_set_fixmap(unsigned idx, phys_addr_t phys, pgprot_t prot)
>  #ifdef CONFIG_X86_64
>  	/* Replicate changes to map the vsyscall page into the user
>  	   pagetable vsyscall mapping. */
> -	if (idx >= VSYSCALL_LAST_PAGE && idx <= VSYSCALL_FIRST_PAGE) {
> +	if ((idx >= VSYSCALL_LAST_PAGE && idx <= VSYSCALL_FIRST_PAGE) ||
> +	    idx == VVAR_PAGE) {
>  		unsigned long vaddr = __fix_to_virt(idx);
>  		set_pte_vaddr_pud(level3_user_vsyscall, vaddr, pte);
>  	}
> -- 
> 1.7.6
