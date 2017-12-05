From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH tip/core/rcu 21/21] drivers/vhost: Remove now-redundant
	read_barrier_depends()
Date: Tue, 5 Dec 2017 23:24:49 +0200
Message-ID: <20171205222857-mutt-send-email-mst__16338.7800603688$1512573006$gmane$org@kernel.org>
References: <20171201195053.GA23494@linux.vnet.ibm.com>
	<1512157876-24665-21-git-send-email-paulmck@linux.vnet.ibm.com>
	<20171205202928-mutt-send-email-mst@kernel.org>
	<20171205183946.GP3165@worktop.lehotels.local>
	<20171205204928-mutt-send-email-mst@kernel.org>
	<20171205191733.GQ3165@worktop.lehotels.local>
	<20171205212053-mutt-send-email-mst@kernel.org>
	<20171205193339.GP7829@linux.vnet.ibm.com>
	<20171205215020-mutt-send-email-mst@kernel.org>
	<20171205200801.GR7829@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20171205200801.GR7829@linux.vnet.ibm.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Cc: tglx@linutronix.de, kvm@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, fweisbec@gmail.com, jiangshanlai@gmail.com, linux-kernel@vger.kernel.org, rostedt@goodmis.org, josh@joshtriplett.org, dhowells@redhat.com, edumazet@google.com, netdev@vger.kernel.org, mathieu.desnoyers@efficios.com, oleg@redhat.com, dipankar@in.ibm.com, akpm@linux-foundation.org, virtualization@lists.linux-foundation.org, mingo@kernel.org
List-Id: virtualization@lists.linuxfoundation.org

On Tue, Dec 05, 2017 at 12:08:01PM -0800, Paul E. McKenney wrote:
> On Tue, Dec 05, 2017 at 09:51:48PM +0200, Michael S. Tsirkin wrote:
> > On Tue, Dec 05, 2017 at 11:33:39AM -0800, Paul E. McKenney wrote:
> > > On Tue, Dec 05, 2017 at 09:24:21PM +0200, Michael S. Tsirkin wrote:
> 
> [ . . . ]
> 
> > > > and this barrier is no longer paired with anything until
> > > > you realize there's a dependency barrier within READ_ONCE.
> > > > 
> > > > Barrier pairing was a useful tool to check code validity,
> > > > maybe there are other, better tools now.
> > > 
> > > There are quite a few people who say that smp_store_release() is
> > > easier for the tools to analyze than is smp_wmb().  My experience with
> > > smp_read_barrier_depends() and rcu_dereference() leads me to believe
> > > that they are correct.
> > 
> > OK, but smp_store_release is still not paired with anything since we
> > rely on READ_ONCE to include the implicit dpendendency barrier.
> 
> Why wouldn't you consider the smp_store_release() to be paired with
> the new improved READ_ONCE()?
> 
> 							Thanx, Paul

READ_ONCE is really all over the place (some code literally replaced all
memory accesses with READ/WRITE ONCE).

And I also prefer smp_wmb as it seems to be cheaper on ARM.

Would an API like WRITE_POINTER()/smp_store_pointer make sense,
and READ_POINTER for symmetry?

-- 
MST
