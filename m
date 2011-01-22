From: Srivatsa Vaddagiri <vatsa@linux.vnet.ibm.com>
Subject: Re: [PATCH 2/3] kvm hypervisor : Add hypercalls to support
	pv-ticketlock
Date: Sat, 22 Jan 2011 11:44:17 +0530
Message-ID: <20110122061417.GA7258__6038.95512545041$1295677035$gmane$org@linux.vnet.ibm.com>
References: <cover.1289940821.git.jeremy.fitzhardinge@citrix.com>
	<20110119164432.GA30669@linux.vnet.ibm.com>
	<20110119171239.GB726@linux.vnet.ibm.com>
	<1295457672.28776.144.camel@laptop> <4D373340.60608@goop.org>
	<20110120115958.GB11177@linux.vnet.ibm.com>
	<4D38774B.6070704@goop.org>
	<20110121140208.GA13609@linux.vnet.ibm.com>
	<4D399CBD.10506@redhat.com>
Reply-To: vatsa@linux.vnet.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <4D399CBD.10506@redhat.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Rik van Riel <riel@redhat.com>
Cc: Xen-devel <xen-devel@lists.xensource.com>, Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>, Nick Piggin <npiggin@kernel.dk>, kvm@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Jan Beulich <JBeulich@novell.com>, Eric Dumazet <dada1@cosmosbay.com>, Jeremy Fitzhardinge <jeremy.fitzhardinge@citrix.com>, suzuki@in.ibm.com, Avi Kivity <avi@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, =?iso-8859-1?Q?Am=E9rico?= Wang <xiyou.wangcong@gmail.com>, Linux Virtualization <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

On Fri, Jan 21, 2011 at 09:48:29AM -0500, Rik van Riel wrote:
> >>Why?  If a VCPU can't make progress because its waiting for some
> >>resource, then why not schedule something else instead?
> >
> >In the process, "something else" can get more share of cpu resource than its
> >entitled to and that's where I was bit concerned. I guess one could
> >employ hard-limits to cap "something else's" bandwidth where it is of real
> >concern (like clouds).
> 
> I'd like to think I fixed those things in my yield_task_fair +
> yield_to + kvm_vcpu_on_spin patch series from yesterday.

Speaking of the spinlock-in-virtualized-environment problem as whole, IMHO
I don't think that kvm_vcpu_on_spin + yield changes will provide the best
results, especially where ticketlocks are involved and they are paravirtualized 
in a manner being discussed in this thread. An important focus of pv-ticketlocks
is to reduce the lock _acquisition_ time by ensuring that the next-in-line 
vcpu gets to run asap when a ticket lock is released. With the way 
kvm_vcpu_on_spin+yield_to is implemented, I don't see how we can provide the 
best lock acquisition times for threads. It would be nice though to compare 
the two approaches (kvm_vcpu_on_spin optimization and the pv-ticketlock scheme) 
to get some real-world numbers. I unfortunately don't have access to a PLE
capable hardware which is required to test your kvm_vcpu_on_spin changes?

Also it may be possible for the pv-ticketlocks to track owning vcpu and make use
of a yield-to interface as further optimization to avoid the 
"others-get-more-time" problem, but Peterz rightly pointed that PI would be a 
better solution there than yield-to. So overall IMO kvm_vcpu_on_spin+yield_to
could be the best solution for unmodified guests, while paravirtualized
ticketlocks + some sort of PI would be a better solution where we have the
luxury of modifying guest sources!

- vatsa
