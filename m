From: Andy Lutomirski <luto@kernel.org>
Subject: Should SEV-ES #VC use IST? (Re: [PATCH] Allow RDTSC and RDTSCP from userspace)
Date: Mon, 27 Apr 2020 10:37:41 -0700
Message-ID: <CALCETrXGr+o1_bKbnre8cVY14c_76m8pEf3iB_i7h+zfgE5_jA@mail.gmail.com>
References: <20200425191032.GK21900@8bytes.org> <910AE5B4-4522-4133-99F7-64850181FBF9@amacapital.net>
 <20200425202316.GL21900@8bytes.org> <CALCETrW2Y6UFC=zvGbXEYqpsDyBh0DSEM4NQ+L=_pp4aOd6Fuw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <CALCETrW2Y6UFC=zvGbXEYqpsDyBh0DSEM4NQ+L=_pp4aOd6Fuw@mail.gmail.com>
Sender: kvm-owner@vger.kernel.org
To: Andy Lutomirski <luto@kernel.org>
Cc: Joerg Roedel <joro@8bytes.org>, Joerg Roedel <jroedel@suse.de>, Dave Hansen <dave.hansen@intel.com>, Tom Lendacky <Thomas.Lendacky@amd.com>, Mike Stunes <mstunes@vmware.com>, Dan Williams <dan.j.williams@intel.com>, Dave Hansen <dave.hansen@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>, Juergen Gross <JGross@suse.com>, Jiri Slaby <jslaby@suse.cz>, Kees Cook <keescook@chromium.org>, kvm list <kvm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>, Thomas Hellstrom <thellstrom@vmware.com>, Linux Virtualization <virtualization@lists.linux-foundation.org>, X86 ML <x86@kernel.org>, Sean Christopherson <sean.j.christopherson@intel.com>, Andrew Cooper <andrew.cooper3@citrix.com>
List-Id: virtualization@lists.linuxfoundation.org

On Sat, Apr 25, 2020 at 3:10 PM Andy Lutomirski <luto@kernel.org> wrote:
>
> On Sat, Apr 25, 2020 at 1:23 PM Joerg Roedel <joro@8bytes.org> wrote:
> >
> > On Sat, Apr 25, 2020 at 12:47:31PM -0700, Andy Lutomirski wrote:
> > > I assume the race you mean is:
> > >
> > > #VC
> > > Immediate NMI before IST gets shifted
> > > #VC
> > >
> > > Kaboom.
> > >
> > > How are you dealing with this?  Ultimately, I think that NMI will need
> > > to turn off IST before engaging in any funny business. Let me ponder
> > > this a bit.
> >
> > Right, I dealt with that by unconditionally shifting/unshifting the #VC IST entry
> > in do_nmi() (thanks to Davin Kaplan for the idea). It might cause
> > one of the IST stacks to be unused during nesting, but that is fine. The
> > stack memory for #VC is only allocated when SEV-ES is active (in an
> > SEV-ES VM).
>
> Blech.  It probably works, but still, yuck.  It's a bit sad that we
> seem to be growing more and more poorly designed happens-anywhere
> exception types at an alarming rate.  We seem to have #NM, #MC, #VC,
> #HV, and #DB.  This doesn't really scale.

I have a somewhat serious question: should we use IST for #VC at all?
As I understand it, Rome and Naples make it mandatory for hypervisors
to intercept #DB, which means that, due to the MOV SS mess, it's sort
of mandatory to use IST for #VC.  But Milan fixes the #DB issue, so,
if we're running under a sufficiently sensible hypervisor, we don't
need IST for #VC.

So I think we have two choices:

1. Use IST for #VC and deal with all the mess that entails.

2. Say that we SEV-ES client support on Rome and Naples is for
development only and do a quick boot-time check for whether #DB is
intercepted.  (Just set TF and see what vector we get.)  If #DB is
intercepted, print a very loud warning and refuse to boot unless some
special sev_es.insecure_development_mode or similar option is set.

#2 results in simpler and more robust entry code.  #1 is more secure.

So my question is: will anyone actually use SEV-ES in production on
Rome or Naples?  As I understand it, it's not really ready for prime
time on those chips.  And do we care if the combination of a malicious
hypervisor and malicious guest userspace on Milan can compromise the
guest kernel?  I don't think SEV-ES is really mean to resist a
concerted effort by the hypervisor to compromise the guest.

--Andy
