From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH tip/core/rcu 21/21] drivers/vhost: Remove now-redundant
	read_barrier_depends()
Date: Wed, 6 Dec 2017 00:09:36 +0200
Message-ID: <20171206000541-mutt-send-email-mst__16501.0068951689$1512561793$gmane$org@kernel.org>
References: <20171205202928-mutt-send-email-mst@kernel.org>
	<20171205183946.GP3165@worktop.lehotels.local>
	<20171205204928-mutt-send-email-mst@kernel.org>
	<20171205191733.GQ3165@worktop.lehotels.local>
	<20171205212053-mutt-send-email-mst@kernel.org>
	<20171205193339.GP7829@linux.vnet.ibm.com>
	<20171205215020-mutt-send-email-mst@kernel.org>
	<20171205200801.GR7829@linux.vnet.ibm.com>
	<20171205222857-mutt-send-email-mst@kernel.org>
	<20171205215700.GV3165@worktop.lehotels.local>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20171205215700.GV3165@worktop.lehotels.local>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Peter Zijlstra <peterz@infradead.org>
Cc: tglx@linutronix.de, kvm@vger.kernel.org, fweisbec@gmail.com, jiangshanlai@gmail.com, linux-kernel@vger.kernel.org, rostedt@goodmis.org, josh@joshtriplett.org, dhowells@redhat.com, edumazet@google.com, netdev@vger.kernel.org, mathieu.desnoyers@efficios.com, oleg@redhat.com, dipankar@in.ibm.com, akpm@linux-foundation.org, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, virtualization@lists.linux-foundation.org, mingo@kernel.org
List-Id: virtualization@lists.linuxfoundation.org

On Tue, Dec 05, 2017 at 10:57:00PM +0100, Peter Zijlstra wrote:
> On Tue, Dec 05, 2017 at 11:24:49PM +0200, Michael S. Tsirkin wrote:
> > READ_ONCE is really all over the place (some code literally replaced all
> > memory accesses with READ/WRITE ONCE).
> 
> Yeah, so?

Oh my point was I can't just look for READ_ONCE and go
*that's the pair*. there are too many of these.
At Paul's suggestion I will document the pairing *this read once has a
barrier that is paired with that barrier*.

> Complain to the compiler people for forcing us into that.

In some cases when you end up with all accesses
going through read/write once volatile just might better.

> > Would an API like WRITE_POINTER()/smp_store_pointer make sense,
> > and READ_POINTER for symmetry?
> 
> No, the whole point of the exercise was to get away from the fact that
> dependent loads are special.

It's a pity that dependent stores are still special.

-- 
MST
