From: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Subject: Re: [PATCH v2 4/6] x86-64/xen: Enable the vvar mapping
Date: Wed, 3 Aug 2011 09:49:34 -0400
Message-ID: <20110803134934.GA29501__27972.7143621587$1312379538$gmane$org@dumpdata.com>
References: <cover.1312378163.git.luto@mit.edu>
	<4659478ed2f3480938f96491c2ecbe2b2e113a23.1312378163.git.luto@mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <4659478ed2f3480938f96491c2ecbe2b2e113a23.1312378163.git.luto@mit.edu>
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

On Wed, Aug 03, 2011 at 09:31:52AM -0400, Andy Lutomirski wrote:
> Xen needs to handle VVAR_PAGE, introduced in git commit:
> 9fd67b4ed0714ab718f1f9bd14c344af336a6df7
> x86-64: Give vvars their own page
> 
> Otherwise we die during bootup with a message like:
> 
> (XEN) mm.c:940:d10 Error getting mfn 1888 (pfn 1e3e48) from L1 entry
>       8000000001888465 for l1e_owner=10, pg_owner=10
> (XEN) mm.c:5049:d10 ptwr_emulate: could not get_page_from_l1e()
> [    0.000000] BUG: unable to handle kernel NULL pointer dereference at (null)
> [    0.000000] IP: [<ffffffff8103a930>] xen_set_pte+0x20/0xe0
> 
> Signed-off-by: Andy Lutomirski <luto@mit.edu>
> Reported-by: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>

Reviewed-by: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
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
