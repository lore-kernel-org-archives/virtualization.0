From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH tip/core/rcu 21/21] drivers/vhost: Remove now-redundant
	read_barrier_depends()
Date: Tue, 5 Dec 2017 20:57:46 +0200
Message-ID: <20171205204928-mutt-send-email-mst@kernel.org>
References: <20171201195053.GA23494@linux.vnet.ibm.com>
	<1512157876-24665-21-git-send-email-paulmck@linux.vnet.ibm.com>
	<20171205202928-mutt-send-email-mst@kernel.org>
	<20171205183946.GP3165@worktop.lehotels.local>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20171205183946.GP3165@worktop.lehotels.local>
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

On Tue, Dec 05, 2017 at 07:39:46PM +0100, Peter Zijlstra wrote:
> On Tue, Dec 05, 2017 at 08:31:20PM +0200, Michael S. Tsirkin wrote:
> 
> > Apropos, READ_ONCE is now asymmetrical with WRITE_ONCE.
> > 
> > I can read a pointer with READ_ONCE and be sure the value
> > is sane, but only if I also remember to put in smp_wmb before
> > WRITE_ONCE. Otherwise the pointer is ok but no guarantees
> > about the data pointed to.
> 
> That was already the case on everything except Alpha. And the canonical
> match do the data dependency is store_release, not wmb.

Oh, interesting

static __always_inline void __write_once_size(volatile void *p, void *res, int size)
{
        switch (size) {
        case 1: *(volatile __u8 *)p = *(__u8 *)res; break;
        case 2: *(volatile __u16 *)p = *(__u16 *)res; break;
        case 4: *(volatile __u32 *)p = *(__u32 *)res; break;
        case 8: *(volatile __u64 *)p = *(__u64 *)res; break;
        default:
                barrier();
                __builtin_memcpy((void *)p, (const void *)res, size);
                barrier();
        }
}

#define WRITE_ONCE(x, val) \
({                                                      \
        union { typeof(x) __val; char __c[1]; } __u =   \
                { .__val = (__force typeof(x)) (val) }; \
        __write_once_size(&(x), __u.__c, sizeof(x));    \
        __u.__val;                                      \
})

I don't see WRITE_ONCE inserting any barriers, release or
write.

So it seems that on an architecture where writes can be reordered,
if I do

*pointer = 0xa;
WRITE_ONCE(array[x], pointer);

array write might bypass the pointer write,
and readers will read a stale value.




-- 
MST
