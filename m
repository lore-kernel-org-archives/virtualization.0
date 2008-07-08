From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [PATCH RFC 0/4] Paravirtual spinlocks
Date: Tue, 8 Jul 2008 11:01:55 +1000
Message-ID: <200807081101.56004.rusty__20821.7807150961$1215479104$gmane$org@rustcorp.com.au>
References: <20080707190749.299430659@goop.org>
	<200807081029.19242.rusty@rustcorp.com.au>
	<4872B6E2.5080003@goop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <4872B6E2.5080003@goop.org>
Content-Disposition: inline
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
Cc: Jens Axboe <axboe@kernel.dk>, Nick Piggin <nickpiggin@yahoo.com.au>, Xen devel <xen-devel@lists.xensource.com>, Peter Zijlstra <a.p.zijlstra@chello.nl>, Christoph Lameter <clameter@linux-foundation.org>, Petr Tesarik <ptesarik@suse.cz>, LKML <linux-kernel@vger.kernel.org>, virtualization@lists.linux-foundation.org, Thomas Friebel <thomas.friebel@amd.com>, Ingo Molnar <mingo@elte.hu>
List-Id: virtualization@lists.linuxfoundation.org

On Tuesday 08 July 2008 10:37:54 Jeremy Fitzhardinge wrote:
> Rusty Russell wrote:
> > On Tuesday 08 July 2008 05:07:49 Jeremy Fitzhardinge wrote:
> >> At the most recent Xen Summit, Thomas Friebel presented a paper
> >> ("Preventing Guests from Spinning Around",
> >> http://xen.org/files/xensummitboston08/LHP.pdf) investigating the
> >> interactions between spinlocks and virtual machines.  Specifically, he
> >> looked at what happens when a lock-holding VCPU gets involuntarily
> >> preempted.
> >
> > I find it interesting that gang scheduling the guest was not suggested as
> > an obvious solution.
>
> It's an obvious answer, but not an obvious solution.  You trade off
> wasting time spinning vs wasting time waiting for N vcpus to be free for
> scheduling.

Perhaps, but with huge numbers of cores (as The Future seems to promise) and 
significant overcommit not sure how bad this would be.

> Or something; seems much more complex, particularly if you
> can do a small guest tweak to solve the problem.

But AFAICT it's one of a related set of problems where all VCPUs are required 
for a task.  Hackbench comes to mind.  There's going to be a lot of 
ping-ponging and you'll approach gang scheduling to get decent performance.

> > A little disappointing that you can't patch your version inline.
>
> Spinlock code isn't inlined currently, so I hadn't considered it.  The
> fast path code for both lock and unlock is nearly small enough to
> consider it, but it seems a bit fiddly.

Yeah, OK.

Thanks,
Rusty.
