From: Ingo Molnar <mingo@elte.hu>
Subject: Re: [patch] x86, paravirt-spinlocks: fix boot hang
Date: Wed, 9 Jul 2008 21:26:30 +0200
Message-ID: <20080709192630.GA4804__43844.4189298481$1215631757$gmane$org@elte.hu>
References: <20080707190749.299430659@goop.org>
	<20080709122852.GA30579@elte.hu> <20080709133358.GA7005@elte.hu>
	<20080709134944.GA15190@elte.hu> <4874DF7F.4080204@goop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <4874DF7F.4080204@goop.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Jeremy Fitzhardinge <jeremy@goop.org>
Cc: Jens Axboe <axboe@kernel.dk>, Nick Piggin <nickpiggin@yahoo.com.au>, Xen devel <xen-devel@lists.xensource.com>, Peter Zijlstra <a.p.zijlstra@chello.nl>, Christoph Lameter <clameter@linux-foundation.org>, the arch/x86 maintainers <x86@kernel.org>, Petr Tesarik <ptesarik@suse.cz>, LKML <linux-kernel@vger.kernel.org>, Virtualization <virtualization@lists.linux-foundation.org>, Thomas Friebel <thomas.friebel@amd.com>
List-Id: virtualization@lists.linuxfoundation.org


* Jeremy Fitzhardinge <jeremy@goop.org> wrote:

>> should never
>>     be built with -pg (which ftrace does). Marking paravirt.o as 
>>     non-pg and marking all spinlock ops as always-inline solve the 
>>     hang.
>>    
>
> Thanks Ingo, that would have taken me a while to work out.

yeah, i figured i'd be the better candidate to debug ftrace related 
problems ;-)

> Presumably that means that xen/smp.o should also be built without -pg.  
> In fact, should I move the spinlock code into its own file, so that 
> ftrace can cover as much as it can?

hm, yeah. Anything that can be called via the lowest level spinlock 
functions should be either notrace, or, better, in a -pg-excluded .o 
file. Putting it all into a separate file would cover it nicely i think.

	Ingo
