From: Srivatsa Vaddagiri <vatsa@linux.vnet.ibm.com>
Subject: Re: [PATCH 2/3] kvm hypervisor : Add hypercalls to support
	pv-ticketlock
Date: Thu, 20 Jan 2011 17:29:58 +0530
Message-ID: <20110120115958.GB11177__28864.9389091463$1295525364$gmane$org@linux.vnet.ibm.com>
References: <cover.1289940821.git.jeremy.fitzhardinge@citrix.com>
	<20110119164432.GA30669@linux.vnet.ibm.com>
	<20110119171239.GB726@linux.vnet.ibm.com>
	<1295457672.28776.144.camel@laptop> <4D373340.60608@goop.org>
Reply-To: vatsa@linux.vnet.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <4D373340.60608@goop.org>
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
Cc: Xen-devel <xen-devel@lists.xensource.com>, Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>, Nick Piggin <npiggin@kernel.dk>, kvm@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Jan Beulich <JBeulich@novell.com>, Eric Dumazet <dada1@cosmosbay.com>, Jeremy Fitzhardinge <jeremy.fitzhardinge@citrix.com>, suzuki@in.ibm.com, Avi Kivity <avi@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, =?iso-8859-1?Q?Am=E9rico?= Wang <xiyou.wangcong@gmail.com>, Linux Virtualization <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

On Wed, Jan 19, 2011 at 10:53:52AM -0800, Jeremy Fitzhardinge wrote:
> > I didn't really read the patch, and I totally forgot everything from
> > when I looked at the Xen series, but does the Xen/KVM hypercall
> > interface for this include the vcpu to await the kick from?
> >
> > My guess is not, since the ticket locks used don't know who the owner
> > is, which is of course, sad. There are FIFO spinlock implementations
> > that can do this though.. although I think they all have a bigger memory
> > footprint.
> 
> At least in the Xen code, a current owner isn't very useful, because we
> need the current owner to kick the *next* owner to life at release time,
> which we can't do without some structure recording which ticket belongs
> to which cpu.

If we had a yield-to [1] sort of interface _and_ information on which vcpu
owns a lock, then lock-spinners can yield-to the owning vcpu, while the
unlocking vcpu can yield-to the next-vcpu-in-waiting. The key here is not to
sleep when waiting for locks (as implemented by current patch-series, which can 
put other VMs at an advantage by giving them more time than they are entitled 
to) and also to ensure that lock-owner as well as the next-in-line lock-owner 
are not unduly made to wait for cpu. 

Is there a way we can dynamically expand the size of lock only upon contention
to include additional information like owning vcpu? Have the lock point to a
per-cpu area upon contention where additional details can be stored perhaps?

1. https://lkml.org/lkml/2011/1/14/44

- vatsa
