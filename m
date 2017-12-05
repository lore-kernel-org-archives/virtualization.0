From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: Re: [PATCH tip/core/rcu 21/21] drivers/vhost: Remove now-redundant
	read_barrier_depends()
Date: Tue, 5 Dec 2017 15:39:55 -0800
Message-ID: <20171205233955.GW7829__1331.20523901216$1512566713$gmane$org@linux.vnet.ibm.com>
References: <20171205183946.GP3165@worktop.lehotels.local>
	<20171205204928-mutt-send-email-mst@kernel.org>
	<20171205191733.GQ3165@worktop.lehotels.local>
	<20171205212053-mutt-send-email-mst@kernel.org>
	<20171205193339.GP7829@linux.vnet.ibm.com>
	<20171205215020-mutt-send-email-mst@kernel.org>
	<20171205200801.GR7829@linux.vnet.ibm.com>
	<20171205222857-mutt-send-email-mst@kernel.org>
	<20171205215700.GV3165@worktop.lehotels.local>
	<20171206000541-mutt-send-email-mst@kernel.org>
Reply-To: paulmck@linux.vnet.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20171206000541-mutt-send-email-mst@kernel.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: tglx@linutronix.de, kvm@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, fweisbec@gmail.com, jiangshanlai@gmail.com, linux-kernel@vger.kernel.org, rostedt@goodmis.org, josh@joshtriplett.org, dhowells@redhat.com, edumazet@google.com, netdev@vger.kernel.org, mathieu.desnoyers@efficios.com, oleg@redhat.com, dipankar@in.ibm.com, akpm@linux-foundation.org, virtualization@lists.linux-foundation.org, mingo@kernel.org
List-Id: virtualization@lists.linuxfoundation.org

On Wed, Dec 06, 2017 at 12:09:36AM +0200, Michael S. Tsirkin wrote:
> On Tue, Dec 05, 2017 at 10:57:00PM +0100, Peter Zijlstra wrote:
> > On Tue, Dec 05, 2017 at 11:24:49PM +0200, Michael S. Tsirkin wrote:
> > > READ_ONCE is really all over the place (some code literally replaced all
> > > memory accesses with READ/WRITE ONCE).
> > 
> > Yeah, so?
> 
> Oh my point was I can't just look for READ_ONCE and go
> *that's the pair*. there are too many of these.
> At Paul's suggestion I will document the pairing *this read once has a
> barrier that is paired with that barrier*.
> 
> > Complain to the compiler people for forcing us into that.
> 
> In some cases when you end up with all accesses
> going through read/write once volatile just might better.

That is in fact what the jiffies counter does.  But you lose READ_ONCE()'s
automatic handling of DEC Alpha when you take that approach.

> > > Would an API like WRITE_POINTER()/smp_store_pointer make sense,
> > > and READ_POINTER for symmetry?
> > 
> > No, the whole point of the exercise was to get away from the fact that
> > dependent loads are special.
> 
> It's a pity that dependent stores are still special.

We can make READ_ONCE() not be special at zero cost on non-Alpha
systems, but both smp_wmb() and smp_store_release() are decidedly
not free of added overhead.

							Thanx, Paul
