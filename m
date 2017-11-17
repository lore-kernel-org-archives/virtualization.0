From: Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH 01/13] x86/paravirt: remove wbinvd() paravirt interface
Date: Fri, 17 Nov 2017 15:39:45 +0100
Message-ID: <20171117143945.frvi2gkfltwqcyh7__31433.0339002938$1510929614$gmane$org@pd.tnic>
References: <cover.1507128293.git.jpoimboe@redhat.com>
	<3f9bf17f6372ee92d984f6c7fd13e0cb14bc0e0a.1507128293.git.jpoimboe@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <3f9bf17f6372ee92d984f6c7fd13e0cb14bc0e0a.1507128293.git.jpoimboe@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Juergen Gross <jgross@suse.com>, Rusty Russell <rusty@rustcorp.com.au>, Mike Galbraith <efault@gmx.de>, xen-devel@lists.xenproject.org, Peter Zijlstra <peterz@infradead.org>, Jiri Slaby <jslaby@suse.cz>, Boris Ostrovsky <boris.ostrovsky@oracle.com>, x86@kernel.org, linux-kernel@vger.kernel.org, Sasha Levin <alexander.levin@verizon.com>, Chris Wright <chrisw@sous-sol.org>, Thomas Gleixner <tglx@linutronix.de>, Andy Lutomirski <luto@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>, live-patching@vger.kernel.org, Alok Kataria <akataria@vmware.com>, virtualization@lists.linux-foundation.org, Linus Torvalds <torvalds@linux-foundation.org>, Ingo Molnar <mingo@kernel.org>
List-Id: virtualization@lists.linuxfoundation.org

On Wed, Oct 04, 2017 at 10:58:22AM -0500, Josh Poimboeuf wrote:
> Since lguest was removed, only the native version of wbinvd() is used.
> The paravirt interface is no longer needed.
> 
> Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
> ---
>  arch/x86/include/asm/paravirt.h       | 5 -----
>  arch/x86/include/asm/paravirt_types.h | 1 -
>  arch/x86/include/asm/special_insns.h  | 7 +------
>  arch/x86/kernel/paravirt.c            | 1 -
>  arch/x86/kernel/paravirt_patch_64.c   | 2 --
>  arch/x86/xen/enlighten_pv.c           | 2 --
>  6 files changed, 1 insertion(+), 17 deletions(-)

Reviewed-by: Borislav Petkov <bp@suse.de>

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
