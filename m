From: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: Re: [PATCH RFC 0/4] Paravirtual spinlocks
Date: Mon, 07 Jul 2008 17:37:54 -0700
Message-ID: <4872B6E2.5080003__31271.1250306622$1215477603$gmane$org@goop.org>
References: <20080707190749.299430659@goop.org>
	<200807081029.19242.rusty@rustcorp.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <200807081029.19242.rusty@rustcorp.com.au>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: Jens Axboe <axboe@kernel.dk>, Nick Piggin <nickpiggin@yahoo.com.au>, Xen devel <xen-devel@lists.xensource.com>, Peter Zijlstra <a.p.zijlstra@chello.nl>, Christoph Lameter <clameter@linux-foundation.org>, Petr Tesarik <ptesarik@suse.cz>, LKML <linux-kernel@vger.kernel.org>, virtualization@lists.linux-foundation.org, Thomas Friebel <thomas.friebel@amd.com>, Ingo Molnar <mingo@elte.hu>
List-Id: virtualization@lists.linuxfoundation.org

Rusty Russell wrote:
> On Tuesday 08 July 2008 05:07:49 Jeremy Fitzhardinge wrote:
>   
>> At the most recent Xen Summit, Thomas Friebel presented a paper
>> ("Preventing Guests from Spinning Around",
>> http://xen.org/files/xensummitboston08/LHP.pdf) investigating the
>> interactions between spinlocks and virtual machines.  Specifically, he
>> looked at what happens when a lock-holding VCPU gets involuntarily
>> preempted.
>>     
>
> I find it interesting that gang scheduling the guest was not suggested as an 
> obvious solution.
>   

It's an obvious answer, but not an obvious solution.  You trade off 
wasting time spinning vs wasting time waiting for N vcpus to be free for 
scheduling.  Or something; seems much more complex, particularly if you 
can do a small guest tweak to solve the problem.

> Anyway, concept looks fine; lguest's solution is more elegant of course :)
>   

You could remove all mutable state and call it "erlang".

> A little disappointing that you can't patch your version inline.

Spinlock code isn't inlined currently, so I hadn't considered it.  The 
fast path code for both lock and unlock is nearly small enough to 
consider it, but it seems a bit fiddly.

If the "spin_lock" and "spin_unlock" functions were inlined functions 
which called the out of line __raw_spin_lock/unlock functions, then 
after patching they would result in a direct call to the backend lock 
functions, which would be exactly equivalent to what happens now (since 
I hook __raw_spin_lock into calls via pv_lock_ops).

    J
