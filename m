From: Borislav Petkov <bp@alien8.de>
Subject: Re: Should SEV-ES #VC use IST? (Re: [PATCH] Allow RDTSC and RDTSCP
 from userspace)
Date: Tue, 23 Jun 2020 17:51:44 +0200
Message-ID: <20200623155144.GD32590@zn.tnic>
References: <20200425191032.GK21900@8bytes.org>
 <910AE5B4-4522-4133-99F7-64850181FBF9@amacapital.net>
 <20200425202316.GL21900@8bytes.org>
 <CALCETrW2Y6UFC=zvGbXEYqpsDyBh0DSEM4NQ+L=_pp4aOd6Fuw@mail.gmail.com>
 <CALCETrXGr+o1_bKbnre8cVY14c_76m8pEf3iB_i7h+zfgE5_jA@mail.gmail.com>
 <20200428075512.GP30814@suse.de>
 <20200623110706.GB4817@hirez.programming.kicks-ass.net>
 <20200623113007.GH31822@suse.de>
 <8413fe52-04ee-f4e1-873c-17595110856a@citrix.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <kvm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <8413fe52-04ee-f4e1-873c-17595110856a@citrix.com>
Sender: kvm-owner@vger.kernel.org
To: Andrew Cooper <andrew.cooper3@citrix.com>
Cc: Joerg Roedel <jroedel@suse.de>, Peter Zijlstra <peterz@infradead.org>, Andy Lutomirski <luto@kernel.org>, Joerg Roedel <joro@8bytes.org>, Dave Hansen <dave.hansen@intel.com>, Tom Lendacky <Thomas.Lendacky@amd.com>, Mike Stunes <mstunes@vmware.com>, Dan Williams <dan.j.williams@intel.com>, Dave Hansen <dave.hansen@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>, Juergen Gross <JGross@suse.com>, Jiri Slaby <jslaby@suse.cz>, Kees Cook <keescook@chromium.org>, kvm list <kvm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Thomas Hellstrom <thellstrom@vmware.com>, Linux Virtualization <virtualization@lists.linux-foundation.org>, X86 ML <x86@kernel.org>, Sean Christopherson <sean.j.christopherson@intel.com>
List-Id: virtualization@lists.linuxfoundation.org

On Tue, Jun 23, 2020 at 12:51:03PM +0100, Andrew Cooper wrote:
> Crashing out hard if the hypervisor is misbehaving is acceptable.  In a
> cloud, I as a customer would (threaten to?) take my credit card
> elsewhere, while for enterprise, I'd shout at my virtualisation vendor
> until a fix happened (also perhaps threaten to take my credit card
> elsewhere).

This is called customer, credit-card-enforced bug fixing.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
