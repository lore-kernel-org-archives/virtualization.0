From: Oleg Nesterov <oleg@redhat.com>
Subject: Re: [PATCH V5] x86 spinlock: Fix memory corruption on completing
	completions
Date: Sun, 15 Feb 2015 17:17:33 +0100
Message-ID: <20150215161733.GB27608@redhat.com>
References: <1423979744-18320-1-git-send-email-raghavendra.kt@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1423979744-18320-1-git-send-email-raghavendra.kt@linux.vnet.ibm.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Raghavendra K T <raghavendra.kt@linux.vnet.ibm.com>
Cc: jeremy@goop.org, kvm@vger.kernel.org, peterz@infradead.org, virtualization@lists.linux-foundation.org, paul.gortmaker@windriver.com, hpa@zytor.com, ak@linux.intel.com, a.ryabinin@samsung.com, x86@kernel.org, borntraeger@de.ibm.com, mingo@redhat.com, xen-devel@lists.xenproject.org, paulmck@linux.vnet.ibm.com, riel@redhat.com, konrad.wilk@oracle.com, dave@stgolabs.net, sasha.levin@oracle.com, davej@redhat.com, tglx@linutronix.de, waiman.long@hp.com, linux-kernel@vger.kernel.org, pbonzini@redhat.com, akpm@linux-foundation.org, torvalds@linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

Well, I regret I mentioned the lack of barrier after enter_slowpath ;)

On 02/15, Raghavendra K T wrote:
>
> @@ -46,7 +46,8 @@ static __always_inline bool static_key_false(struct static_key *key);
>
>  static inline void __ticket_enter_slowpath(arch_spinlock_t *lock)
>  {
> -	set_bit(0, (volatile unsigned long *)&lock->tickets.tail);
> +	set_bit(0, (volatile unsigned long *)&lock->tickets.head);
> +	barrier();
>  }

Because this barrier() looks really confusing.

Firsty, it is equally unneeded on x86. At the same time, it can not help.
We need a memory barrier() between set_bit(SLOWPATH) and READ_ONCE(head)
to avoid the race with spin_unlock().

So I think you should replace it with smp_mb__after_atomic() or remove it.



Other than that I believe this version is correct. So I won't insist, this
is cosmetic after all.

Oleg.
