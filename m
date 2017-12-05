From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH tip/core/rcu 21/21] drivers/vhost: Remove now-redundant
	read_barrier_depends()
Date: Tue, 5 Dec 2017 21:24:21 +0200
Message-ID: <20171205212053-mutt-send-email-mst@kernel.org>
References: <20171201195053.GA23494@linux.vnet.ibm.com>
	<1512157876-24665-21-git-send-email-paulmck@linux.vnet.ibm.com>
	<20171205202928-mutt-send-email-mst@kernel.org>
	<20171205183946.GP3165@worktop.lehotels.local>
	<20171205204928-mutt-send-email-mst@kernel.org>
	<20171205191733.GQ3165@worktop.lehotels.local>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20171205191733.GQ3165@worktop.lehotels.local>
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

On Tue, Dec 05, 2017 at 08:17:33PM +0100, Peter Zijlstra wrote:
> On Tue, Dec 05, 2017 at 08:57:46PM +0200, Michael S. Tsirkin wrote:
> 
> > I don't see WRITE_ONCE inserting any barriers, release or
> > write.
> 
> Correct, never claimed there was.
> 
> Just saying that:
> 
> 	obj = READ_ONCE(*foo);
> 	val = READ_ONCE(obj->val);
> 
> Never needs a barrier (except on Alpha and we want to make that go
> away). Simply because a CPU needs to complete the load of @obj before it
> can compute the address &obj->val. Thus the second load _must_ come
> after the first load and we get LOAD-LOAD ordering.
> 
> Alpha messing that up is a royal pain, and Alpha not being an
> active/living architecture is just not worth the pain of keeping this in
> the generic model.
> 

Right. What I am saying is that for writes you need

WRITE_ONCE(obj->val, 1);
smp_wmb();
WRITE_ONCE(*foo, obj);

and this barrier is no longer paired with anything until
you realize there's a dependency barrier within READ_ONCE.

Barrier pairing was a useful tool to check code validity,
maybe there are other, better tools now.


-- 
MST
