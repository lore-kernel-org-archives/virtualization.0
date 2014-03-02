From: Oleg Nesterov <oleg@redhat.com>
Subject: Re: [PATCH v5 2/8] qspinlock, x86: Enable x86-64 to use queue spinlock
Date: Sun, 2 Mar 2014 15:10:58 +0100
Message-ID: <20140302141058.GA15629__8967.57231462306$1393788612$gmane$org@redhat.com>
References: <1393475567-4453-1-git-send-email-Waiman.Long@hp.com>
	<1393475567-4453-3-git-send-email-Waiman.Long@hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1393475567-4453-3-git-send-email-Waiman.Long@hp.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Waiman Long <Waiman.Long@hp.com>
Cc: Jeremy Fitzhardinge <jeremy@goop.org>, Raghavendra K T <raghavendra.kt@linux.vnet.ibm.com>, kvm@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, virtualization@lists.linux-foundation.org, Andi Kleen <andi@firstfloor.org>, "H. Peter Anvin" <hpa@zytor.com>, Michel Lespinasse <walken@google.com>, Thomas Gleixner <tglx@linutronix.de>, linux-arch@vger.kernel.org, Gleb Natapov <gleb@redhat.com>, x86@kernel.org, Ingo Molnar <mingo@redhat.com>, xen-devel@lists.xenproject.org, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, Rik van Riel <riel@redhat.com>, Arnd Bergmann <arnd@arndb.de>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Scott J Norton <scott.norton@hp.com>, Steven Rostedt <rostedt@goodmis.org>, Chris Wright <chrisw@sous-sol.org>, Alok Kataria <akataria@vmware.com>, Aswin Chandramouleeswaran <aswin@hp.com>, Chegu Vinod <chegu_vinod@hp.com>
List-Id: virtualization@lists.linuxfoundation.org

On 02/26, Waiman Long wrote:
>
> +#define _ARCH_SUPPORTS_ATOMIC_8_16_BITS_OPS
> +
> +/*
> + * x86-64 specific queue spinlock union structure
> + */
> +union arch_qspinlock {
> +	struct qspinlock slock;
> +	u8		 lock;	/* Lock bit	*/
> +};

And this enables the optimized version of queue_spin_setlock().

But why does it check ACCESS_ONCE(qlock->lock) == 0 ? This is called
right after queue_get_lock_qcode() returns 0, this locked should be
likely unlocked.

Oleg.
