From: Josh Poimboeuf <jpoimboe@redhat.com>
Subject: Re: [PATCH 11/13] x86/paravirt: Add paravirt alternatives
	infrastructure
Date: Fri, 6 Oct 2017 11:30:07 -0500
Message-ID: <20171006163007.gm7jqhz2jvxulpn4__41112.5253573575$1509080072$gmane$org@treble>
References: <cover.1507128293.git.jpoimboe@redhat.com>
	<39743c79546ede3073586403d0836a4f93519b0a.1507128293.git.jpoimboe@redhat.com>
	<3b9fd404-6912-3b58-db29-36202631b438@oracle.com>
	<20171006143259.rs3zh7k5tmsgesqy@treble>
	<8ba871e6-5f61-6441-f0ed-7542327f7164@oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <8ba871e6-5f61-6441-f0ed-7542327f7164@oracle.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Boris Ostrovsky <boris.ostrovsky@oracle.com>
Cc: Juergen Gross <jgross@suse.com>, Rusty Russell <rusty@rustcorp.com.au>, Mike Galbraith <efault@gmx.de>, xen-devel@lists.xenproject.org, Peter Zijlstra <peterz@infradead.org>, Jiri Slaby <jslaby@suse.cz>, x86@kernel.org, linux-kernel@vger.kernel.org, Sasha Levin <alexander.levin@verizon.com>, Chris Wright <chrisw@sous-sol.org>, Thomas Gleixner <tglx@linutronix.de>, Andy Lutomirski <luto@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>, Borislav Petkov <bp@alien8.de>, live-patching@vger.kernel.org, Alok Kataria <akataria@vmware.com>, virtualization@lists.linux-foundation.org, Linus Torvalds <torvalds@linux-foundation.org>, Ingo Molnar <mingo@kernel.org>
List-Id: virtualization@lists.linuxfoundation.org

On Fri, Oct 06, 2017 at 11:29:52AM -0400, Boris Ostrovsky wrote:
> >>> +
> >>>  void __init_or_module apply_paravirt(struct paravirt_patch_site *start,
> >>>  				     struct paravirt_patch_site *end)
> >>>  {
> >>> diff --git a/arch/x86/kernel/cpu/hypervisor.c b/arch/x86/kernel/cpu/hypervisor.c
> >>> index 4fa90006ac68..17243fe0f5ce 100644
> >>> --- a/arch/x86/kernel/cpu/hypervisor.c
> >>> +++ b/arch/x86/kernel/cpu/hypervisor.c
> >>> @@ -71,6 +71,8 @@ void __init init_hypervisor_platform(void)
> >>>  	if (!x86_hyper)
> >>>  		return;
> >>>  
> >>> +	apply_pv_alternatives();
> >> Not for Xen PV guests who have already done this.
> > I think it would be harmless, but yeah, it's probably best to only write
> > it once.
> 
> I also wonder whether calling apply_pv_alternatives() here before
> x86_hyper->init_platform() will work since the latter may be setting
> those op. In fact, that's what Xen HVM does for pv_mmu_ops.exit_mmap.

apply_pv_alternatives() changes:

  (native code)

to

  call *pv_whatever_ops.whatever

So apply_pv_alternatives() should be called *before* any of the ops are
set up.

-- 
Josh
