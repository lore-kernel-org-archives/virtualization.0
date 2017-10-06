From: Josh Poimboeuf <jpoimboe@redhat.com>
Subject: Re: [Xen-devel] [PATCH 00/13] x86/paravirt: Make pv ops code
	generation more closely match reality
Date: Fri, 6 Oct 2017 09:36:06 -0500
Message-ID: <20171006143606.tbv4y2te6jvqoach__49700.4074547023$1509080058$gmane$org@treble>
References: <cover.1507128293.git.jpoimboe@redhat.com>
	<87bmlkiv9n.fsf@vitty.brq.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <87bmlkiv9n.fsf@vitty.brq.redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Vitaly Kuznetsov <vkuznets@redhat.com>
Cc: Juergen Gross <jgross@suse.com>, x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, Peter Zijlstra <peterz@infradead.org>, Linus Torvalds <torvalds@linux-foundation.org>, Rusty Russell <rusty@rustcorp.com.au>, Alok Kataria <akataria@vmware.com>, linux-kernel@vger.kernel.org, Sasha Levin <alexander.levin@verizon.com>, Chris Wright <chrisw@sous-sol.org>, live-patching@vger.kernel.org, Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>, Andy Lutomirski <luto@kernel.org>, Mike Galbraith <efault@gmx.de>, xen-devel@lists.xenproject.org, Boris Ostrovsky <boris.ostrovsky@oracle.com>, virtualization@lists.linux-foundation.org, Jiri Slaby <jslaby@suse.cz>, Thomas Gleixner <tglx@linutronix.de>
List-Id: virtualization@lists.linuxfoundation.org

On Fri, Oct 06, 2017 at 09:35:16AM +0200, Vitaly Kuznetsov wrote:
> Josh Poimboeuf <jpoimboe@redhat.com> writes:
> 
> > - For the most common runtime cases (everything except Xen and vSMP),
> >   vmlinux disassembly now matches what the actual runtime code looks
> >   like.  This improves debuggability and kernel developer sanity (a
> >   precious resource).
> >
> > ...
> >
> > - It's hopefully a first step in simplifying paravirt patching by
> >   getting rid of .parainstructions, pv ops, and apply_paravirt()
> >   completely.  (I think Xen can be changed to set CPU feature bits to
> >   specify which ops it needs during early boot, then those ops can be
> >   patched in using early alternatives.)
> 
> JFYI starting 4.14 Xen PV is not the only user of pv_mmu_ops, Hyper-V
> uses it for TLB shootdown now.

Yeah, I saw that.  It should be fine because the pv_alternatives get
patched before the Hyper-V code sets up pv_mmu_ops.

-- 
Josh
