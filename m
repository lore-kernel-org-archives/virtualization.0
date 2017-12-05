From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH tip/core/rcu 21/21] drivers/vhost: Remove now-redundant
	read_barrier_depends()
Date: Tue, 5 Dec 2017 19:39:46 +0100
Message-ID: <20171205183946.GP3165@worktop.lehotels.local>
References: <20171201195053.GA23494@linux.vnet.ibm.com>
	<1512157876-24665-21-git-send-email-paulmck@linux.vnet.ibm.com>
	<20171205202928-mutt-send-email-mst@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20171205202928-mutt-send-email-mst@kernel.org>
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
Cc: tglx@linutronix.de, kvm@vger.kernel.org, fweisbec@gmail.com, jiangshanlai@gmail.com, linux-kernel@vger.kernel.org, rostedt@goodmis.org, josh@joshtriplett.org, dhowells@redhat.com, edumazet@google.com, netdev@vger.kernel.org, mathieu.desnoyers@efficios.com, oleg@redhat.com, dipankar@in.ibm.com, akpm@linux-foundation.org, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, virtualization@lists.linux-foundation.org, mingo@kernel.org
List-Id: virtualization@lists.linuxfoundation.org

On Tue, Dec 05, 2017 at 08:31:20PM +0200, Michael S. Tsirkin wrote:

> Apropos, READ_ONCE is now asymmetrical with WRITE_ONCE.
> 
> I can read a pointer with READ_ONCE and be sure the value
> is sane, but only if I also remember to put in smp_wmb before
> WRITE_ONCE. Otherwise the pointer is ok but no guarantees
> about the data pointed to.

That was already the case on everything except Alpha. And the canonical
match do the data dependency is store_release, not wmb.
