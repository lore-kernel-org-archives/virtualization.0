From: Andy Lutomirski <luto@kernel.org>
Subject: Re: [PATCH 70/70] x86/sev-es: Add NMI state tracking
Date: Thu, 19 Mar 2020 14:27:49 -0700
Message-ID: <CALCETrXzyUGjPYBR_NDSvTG8TqLuQP2Q+v_mwXPne4O0U-18NA@mail.gmail.com>
References: <20200319091407.1481-1-joro@8bytes.org> <20200319091407.1481-71-joro@8bytes.org>
 <CALCETrUOQneBHjoZkP-7T5PDijb=WOyv7xF7TD0GLR2Aw77vyA@mail.gmail.com>
 <20200319160749.GC5122@8bytes.org> <CALCETrXY5M87C1Fc3QvTkc6MdbQ_3gAuOPUeWJktAzK4T60QNQ@mail.gmail.com>
 <20200319192654.GD611@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <20200319192654.GD611@suse.de>
Sender: kvm-owner@vger.kernel.org
To: Joerg Roedel <jroedel@suse.de>
Cc: Andy Lutomirski <luto@kernel.org>, Joerg Roedel <joro@8bytes.org>, X86 ML <x86@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>, Dave Hansen <dave.hansen@linux.intel.com>, Peter Zijlstra <peterz@infradead.org>, Thomas Hellstrom <thellstrom@vmware.com>, Jiri Slaby <jslaby@suse.cz>, Dan Williams <dan.j.williams@intel.com>, Tom Lendacky <thomas.lendacky@amd.com>, Juergen Gross <jgross@suse.com>, Kees Cook <keescook@chromium.org>, LKML <linux-kernel@vger.kernel.org>, kvm list <kvm@vger.kernel.org>, Linux Virtualization <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

On Thu, Mar 19, 2020 at 12:26 PM Joerg Roedel <jroedel@suse.de> wrote:
>
> On Thu, Mar 19, 2020 at 11:40:39AM -0700, Andy Lutomirski wrote:
>
> > Nope.  A nested NMI will reset the interrupted NMI's return frame to
> > cause it to run again when it's done.  I don't think this will have
> > any real interaction with #VC.  There's no longjmp() here.
>
> Ahh, so I misunderstood that part, in this case your proposal of sending
> the NMI-complete message right at the beginning of do_nmi() should work
> just fine. I will test this and see how it works out.
>
> > I certainly *like* preventing nesting, but I don't think we really
> > want a whole alternate NMI path just for a couple of messed-up AMD
> > generations.  And the TF trick is not so pretty either.
>
> Indeed, if it could be avoided, it should.
>
> >
> > > > This causes us to pop the NMI frame off the stack.  Assuming the NMI
> > > > restart logic is invoked (which is maybe impossible?), we get #DB,
> > > > which presumably is actually delivered.  And we end up on the #DB
> > > > stack, which might already have been in use, so we have a potential
> > > > increase in nesting.  Also, #DB may be called from an unexpected
> > > > context.
> > >
> > > An SEV-ES hypervisor is required to intercept #DB, which means that the
> > > #DB exception actually ends up being a #VC exception. So it will not end
> > > up on the #DB stack.
> >
> > With your patch set, #DB doesn't seem to end up on the #DB stack either.
>
> Right, it does not use the #DB stack or shift-ist stuff. Maybe it
> should, is this needed for anything else than making entry code
> debugable by kgdb?

AIUI the shift-ist stuff is because we aren't very good about the way
that we handle tracing right now, and that can cause a limited degree
of recursion.  #DB uses IST for historical reasons that don't
necessarily make sense.  Right now, we need it for only one reason:
the MOV SS issue.  IIRC this isn't actually triggerable without
debugging enabled -- MOV SS with no breakpoint but TF on doesn't seem
to malfunction quite as badly.

--Andy

>
> Regards,
>
>         Joerg
