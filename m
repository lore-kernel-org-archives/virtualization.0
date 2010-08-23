From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: Removing VMI kernel support from 2.6.37
Date: Mon, 23 Aug 2010 16:39:27 -0700
Message-ID: <4C7306AF.4030202@zytor.com>
References: <1282600151.19396.22.camel@ank32.eng.vmware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1282600151.19396.22.camel@ank32.eng.vmware.com>
Sender: linux-kernel-owner@vger.kernel.org
To: akataria@vmware.com
Cc: Ingo Molnar <mingo@elte.hu>, Thomas Gleixner <tglx@linutronix.de>, Jeremy Fitzhardinge <jeremy@xensource.com>, Chris Wright <chrisw@sous-sol.org>, Rusty Russell <rusty@rustcorp.com.au>, virtualization@lists.osdl.org, the arch/x86 maintainers <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
List-Id: virtualization@lists.linuxfoundation.org

On 08/23/2010 02:49 PM, Alok Kataria wrote:
> Hi Peter,
> 
> Removal of VMI(VMware's para-virtualization technique) is scheduled for
> 2.6.37, I was wondering what would be the right time frame for
> submitting a patch which does that. Does the x86-tip tree have any next
> branch where we can park this patch ?
> 
> Below is the patch for your reference which just removes VMI specific
> bits, applies on top of x86-tip.
> 
> There is also an opportunity to remove the alloc_pmd_clone hook from
> paravirt side of the things. This interface is only used for VMI, will
> send a follow-on patch later on to do that though.
> 

That would be nice.  In the meantime I have queued up your patch.

	-hpa
