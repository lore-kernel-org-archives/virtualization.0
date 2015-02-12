From: Oleg Nesterov <oleg@redhat.com>
Subject: Re: [PATCH V3] x86 spinlock: Fix memory corruption on completing
	completions
Date: Thu, 12 Feb 2015 14:50:56 +0100
Message-ID: <20150212135056.GA10646@redhat.com>
References: <1423741647-2156-1-git-send-email-raghavendra.kt@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1423741647-2156-1-git-send-email-raghavendra.kt@linux.vnet.ibm.com>
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

On 02/12, Raghavendra K T wrote:
>
> @@ -191,8 +189,7 @@ static inline void arch_spin_unlock_wait(arch_spinlock_t *lock)
>  		 * We need to check "unlocked" in a loop, tmp.head == head
>  		 * can be false positive because of overflow.
>  		 */
> -		if (tmp.head == (tmp.tail & ~TICKET_SLOWPATH_FLAG) ||
> -		    tmp.head != head)
> +		if (__tickets_equal(tmp.head, tmp.tail) || tmp.head != head)
>  			break;

Ah, it seems that "tmp.head != head" should be turned into
!__tickets_equal(), no?

Suppose that TICKET_SLOWPATH_FLAG is set after the first ACCESS_ONCE(head),
then tmp.head != head will be true before the first unlock we are waiting
for.

And perhaps you can turn these ACCESS_ONCE into READ_ONCE as well.

Oleg.
