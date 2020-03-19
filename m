From: Andy Lutomirski <luto@kernel.org>
Subject: Re: [PATCH 70/70] x86/sev-es: Add NMI state tracking
Date: Thu, 19 Mar 2020 11:40:39 -0700
Message-ID: <CALCETrXY5M87C1Fc3QvTkc6MdbQ_3gAuOPUeWJktAzK4T60QNQ@mail.gmail.com>
References: <20200319091407.1481-1-joro@8bytes.org> <20200319091407.1481-71-joro@8bytes.org>
 <CALCETrUOQneBHjoZkP-7T5PDijb=WOyv7xF7TD0GLR2Aw77vyA@mail.gmail.com> <20200319160749.GC5122@8bytes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200319160749.GC5122@8bytes.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Joerg Roedel <joro@8bytes.org>
Cc: Andy Lutomirski <luto@kernel.org>, X86 ML <x86@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>, Dave Hansen <dave.hansen@linux.intel.com>, Peter Zijlstra <peterz@infradead.org>, Thomas Hellstrom <thellstrom@vmware.com>, Jiri Slaby <jslaby@suse.cz>, Dan Williams <dan.j.williams@intel.com>, Tom Lendacky <thomas.lendacky@amd.com>, Juergen Gross <jgross@suse.com>, Kees Cook <keescook@chromium.org>, LKML <linux-kernel@vger.kernel.org>, kvm list <kvm@vger.kernel.org>, Linux Virtualization <virtualization@lists.linux-foundation.org>, Joerg Roedel <jroedel@suse.de>
List-Id: virtualization@lists.linuxfoundation.org

On Thu, Mar 19, 2020 at 9:07 AM Joerg Roedel <joro@8bytes.org> wrote:
>
> Hi Andy,
>
> On Thu, Mar 19, 2020 at 08:35:59AM -0700, Andy Lutomirski wrote:
> > On Thu, Mar 19, 2020 at 2:14 AM Joerg Roedel <joro@8bytes.org> wrote:
> > >
> > > From: Joerg Roedel <jroedel@suse.de>
> > >
> > > Keep NMI state in SEV-ES code so the kernel can re-enable NMIs for the
> > > vCPU when it reaches IRET.
> >
> > IIRC I suggested just re-enabling NMI in C from do_nmi().  What was
> > wrong with that approach?
>
> If I understand the code correctly a nested NMI will just reset the
> interrupted NMI handler to start executing again at 'restart_nmi'.
> The interrupted NMI handler could be in the #VC handler, and it is not
> safe to just jump back to the start of the NMI handler from somewhere
> within the #VC handler.

Nope.  A nested NMI will reset the interrupted NMI's return frame to
cause it to run again when it's done.  I don't think this will have
any real interaction with #VC.  There's no longjmp() here.

>
> So I decided to not allow NMI nesting for SEV-ES and only re-enable the
> NMI window when the first NMI returns. This is not implemented in this
> patch, but I will do that once Thomas' entry-code rewrite is upstream.
>

I certainly *like* preventing nesting, but I don't think we really
want a whole alternate NMI path just for a couple of messed-up AMD
generations.  And the TF trick is not so pretty either.

> > This causes us to pop the NMI frame off the stack.  Assuming the NMI
> > restart logic is invoked (which is maybe impossible?), we get #DB,
> > which presumably is actually delivered.  And we end up on the #DB
> > stack, which might already have been in use, so we have a potential
> > increase in nesting.  Also, #DB may be called from an unexpected
> > context.
>
> An SEV-ES hypervisor is required to intercept #DB, which means that the
> #DB exception actually ends up being a #VC exception. So it will not end
> up on the #DB stack.

With your patch set, #DB doesn't seem to end up on the #DB stack either.

>
> > I think there are two credible ways to approach this:
> >
> > 1. Just put the NMI unmask in do_nmi().  The kernel *already* knows
> > how to handle running do_nmi() with NMIs unmasked.  This is much, much
> > simpler than your code.
>
> Right, and I thought about that, but the implication is that the
> complexity is moved somewhere else, namely into the #VC handler, which
> then has to be restartable.

As above, I don't think there's an actual problem here.

>
> > 2. Have an entirely separate NMI path for the
> > SEV-ES-on-misdesigned-CPU case.  And have very clear documentation for
> > what prevents this code from being executed on future CPUs (Zen3?)
> > that have this issue fixed for real?
>
> That sounds like a good alternative, I will investigate this approach.
> The NMI handler should be much simpler as it doesn't need to allow NMI
> nesting. The question is, does the C code down the NMI path depend on
> the NMI handlers stack frame layout (e.g. the in-nmi flag)?

Nope.  In particular, the 32-bit path doesn't have all this.
