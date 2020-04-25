From: Joerg Roedel <joro@8bytes.org>
Subject: Re: [PATCH] Allow RDTSC and RDTSCP from userspace
Date: Sat, 25 Apr 2020 22:23:16 +0200
Message-ID: <20200425202316.GL21900@8bytes.org>
References: <20200425191032.GK21900@8bytes.org>
 <910AE5B4-4522-4133-99F7-64850181FBF9@amacapital.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <910AE5B4-4522-4133-99F7-64850181FBF9@amacapital.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Andy Lutomirski <luto@amacapital.net>
Cc: Andy Lutomirski <luto@kernel.org>, Joerg Roedel <jroedel@suse.de>, Dave Hansen <dave.hansen@intel.com>, Tom Lendacky <Thomas.Lendacky@amd.com>, Mike Stunes <mstunes@vmware.com>, Dan Williams <dan.j.williams@intel.com>, Dave Hansen <dave.hansen@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>, Juergen Gross <JGross@suse.com>, Jiri Slaby <jslaby@suse.cz>, Kees Cook <keescook@chromium.org>, kvm list <kvm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>, Thomas Hellstrom <thellstrom@vmware.com>, Linux Virtualization <virtualization@lists.linux-foundation.org>, X86 ML <x86@kernel.org>, Sean Christopherson <sean.j.christopherson@intel.com>
List-Id: virtualization@lists.linuxfoundation.org

On Sat, Apr 25, 2020 at 12:47:31PM -0700, Andy Lutomirski wrote:
> I assume the race you mean is:
> 
> #VC
> Immediate NMI before IST gets shifted
> #VC
> 
> Kaboom.
> 
> How are you dealing with this?  Ultimately, I think that NMI will need
> to turn off IST before engaging in any funny business. Let me ponder
> this a bit.

Right, I dealt with that by unconditionally shifting/unshifting the #VC IST entry
in do_nmi() (thanks to Davin Kaplan for the idea). It might cause
one of the IST stacks to be unused during nesting, but that is fine. The
stack memory for #VC is only allocated when SEV-ES is active (in an
SEV-ES VM).

Regards,

	Joerg
