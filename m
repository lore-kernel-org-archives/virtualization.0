From: Josh Poimboeuf <jpoimboe@redhat.com>
Subject: Re: [PATCH 10/13] x86/alternative: Support indirect call replacement
Date: Thu, 16 Nov 2017 15:19:29 -0600
Message-ID: <20171116211929.g4q5wa52sq64nhe5@treble>
References: <cover.1507128293.git.jpoimboe@redhat.com>
	<efabcfb022d29fb0a9ccb39380623573555c2bcb.1507128293.git.jpoimboe@redhat.com>
	<c57fb310-141b-2262-7e17-bf37d3afdf82@suse.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <c57fb310-141b-2262-7e17-bf37d3afdf82@suse.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Juergen Gross <jgross@suse.com>
Cc: Boris Ostrovsky <boris.ostrovsky@oracle.com>, Rusty Russell <rusty@rustcorp.com.au>, Mike Galbraith <efault@gmx.de>, xen-devel@lists.xenproject.org, Peter Zijlstra <peterz@infradead.org>, Jiri Slaby <jslaby@suse.cz>, x86@kernel.org, linux-kernel@vger.kernel.org, Sasha Levin <alexander.levin@verizon.com>, Chris Wright <chrisw@sous-sol.org>, Thomas Gleixner <tglx@linutronix.de>, Andy Lutomirski <luto@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>, Borislav Petkov <bp@alien8.de>, live-patching@vger.kernel.org, Alok Kataria <akataria@vmware.com>, virtualization@lists.linux-foundation.org, Linus Torvalds <torvalds@linux-foundation.org>, Ingo Molnar <mingo@kernel.org>
List-Id: virtualization@lists.linuxfoundation.org

On Wed, Oct 25, 2017 at 01:25:02PM +0200, Juergen Gross wrote:
> On 04/10/17 17:58, Josh Poimboeuf wrote:
> > Add alternative patching support for replacing an instruction with an
> > indirect call.  This will be needed for the paravirt alternatives.
> > 
> > Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
> > ---
> >  arch/x86/kernel/alternative.c | 22 +++++++++++++++-------
> >  1 file changed, 15 insertions(+), 7 deletions(-)
> > 
> > diff --git a/arch/x86/kernel/alternative.c b/arch/x86/kernel/alternative.c
> > index 3344d3382e91..81c577c7deba 100644
> > --- a/arch/x86/kernel/alternative.c
> > +++ b/arch/x86/kernel/alternative.c
> > @@ -410,20 +410,28 @@ void __init_or_module noinline apply_alternatives(struct alt_instr *start,
> >  		insnbuf_sz = a->replacementlen;
> >  
> >  		/*
> > -		 * 0xe8 is a relative jump; fix the offset.
> > -		 *
> > -		 * Instruction length is checked before the opcode to avoid
> > -		 * accessing uninitialized bytes for zero-length replacements.
> > +		 * Fix the address offsets for call and jump instructions which
> > +		 * use PC-relative addressing.
> >  		 */
> >  		if (a->replacementlen == 5 && *insnbuf == 0xe8) {
> > +			/* direct call */
> >  			*(s32 *)(insnbuf + 1) += replacement - instr;
> > -			DPRINTK("Fix CALL offset: 0x%x, CALL 0x%lx",
> > +			DPRINTK("Fix direct CALL offset: 0x%x, CALL 0x%lx",
> >  				*(s32 *)(insnbuf + 1),
> >  				(unsigned long)instr + *(s32 *)(insnbuf + 1) + 5);
> > -		}
> >  
> > -		if (a->replacementlen && is_jmp(replacement[0]))
> > +		} else if (a->replacementlen == 6 && *insnbuf == 0xff &&
> > +			   *(insnbuf+1) == 0x15) {
> > +			/* indirect call */
> > +			*(s32 *)(insnbuf + 2) += replacement - instr;
> > +			DPRINTK("Fix indirect CALL offset: 0x%x, CALL *0x%lx",
> > +				*(s32 *)(insnbuf + 2),
> > +				(unsigned long)instr + *(s32 *)(insnbuf + 2) + 6);
> > +
> > +		} else if (a->replacementlen && is_jmp(replacement[0])) {
> 
> Is this correct? Without your patch this was:
> 
> if (*insnbuf == 0xe8) ...
> if (is_jmp(replacement[0])) ...
> 
> Now you have:
> 
> if (*insnbuf == 0xe8) ...
> else if (*insnbuf == 0xff15) ...
> else if (is_jmp(replacement[0])) ...
> 
> So only one or none of the three variants will be executed. In the past
> it could be none, one or both.

It can't be a call *and* a jump.  It's either one or the other.

Maybe it's a little confusing that the jump check uses replacement[0]
while the other checks use *insnbuf?  They have the same value, so the
same variable should probably be used everywhere for consistency.  I can
make them more consistent.

-- 
Josh
