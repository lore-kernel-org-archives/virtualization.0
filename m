From: Joerg Roedel <joro@8bytes.org>
Subject: Re: [PATCH] Allow RDTSC and RDTSCP from userspace
Date: Sat, 25 Apr 2020 21:10:32 +0200
Message-ID: <20200425191032.GK21900@8bytes.org>
References: <20200319091407.1481-56-joro@8bytes.org>
 <20200424210316.848878-1-mstunes@vmware.com>
 <2c49061d-eb84-032e-8dcb-dd36a891ce90@intel.com>
 <ead88d04-1756-1190-2b37-b24f86422595@amd.com>
 <4d2ac222-a896-a60e-9b3c-b35aa7e81a97@intel.com>
 <20200425124909.GO30814@suse.de>
 <CALCETrWCiMkA37yf972h+fqsz1_dbfye8AbrkJxDPJzC+1PBEw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CALCETrWCiMkA37yf972h+fqsz1_dbfye8AbrkJxDPJzC+1PBEw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Andy Lutomirski <luto@kernel.org>
Cc: Joerg Roedel <jroedel@suse.de>, Dave Hansen <dave.hansen@intel.com>, Tom Lendacky <thomas.lendacky@amd.com>, Mike Stunes <mstunes@vmware.com>, Dan Williams <dan.j.williams@intel.com>, Dave Hansen <dave.hansen@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>, Juergen Gross <jgross@suse.com>, Jiri Slaby <jslaby@suse.cz>, Kees Cook <keescook@chromium.org>, kvm list <kvm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>, Thomas Hellstrom <thellstrom@vmware.com>, Linux Virtualization <virtualization@lists.linux-foundation.org>, X86 ML <x86@kernel.org>, Sean Christopherson <sean.j.christopherson@intel.com>
List-Id: virtualization@lists.linuxfoundation.org

On Sat, Apr 25, 2020 at 11:15:35AM -0700, Andy Lutomirski wrote:
> shift_ist is gross.  What's it for?  If it's not needed, I'd rather
> not use it, and I eventually want to get rid of it for #DB as well.

The #VC handler needs to be able to nest, there is no way around that
for various reasons, the two most important ones are:

	1. The #VC -> NMI -> #VC case. #VCs can happen in the NMI
	   handler, for example (but not exclusivly) for RDPMC.

	2. In case of an error the #VC handler needs to print out error
	   information by calling one of the printk wrappers. Those will
	   end up doing IO to some console/serial port/whatever which
	   will also cause #VC exceptions to emulate the access to the
	   output devices.

Using shift_ist is perfect for that, the only problem is the race
condition with the NMI handler, as shift_ist does not work well with
exceptions that can also trigger within the NMI handler. But I have
taken care of that for #VC.


Regards,

	Joerg
