From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [RFC] Implement Batched (group) ticket lock
Date: Wed, 28 May 2014 15:19:49 -0700
Message-ID: <CA+55aFx9d1dP+A3tdR-GaASQYBkkJHcV-=t9FdA7AGrMN12S0w@mail.gmail.com>
References: <1401279399-23854-1-git-send-email-raghavendra.kt@linux.vnet.ibm.com>
	<53865B53.7050809@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <53865B53.7050809@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Rik van Riel <riel@redhat.com>
Cc: Jeremy Fitzhardinge <jeremy@goop.org>, Raghavendra K T <raghavendra.kt@linux.vnet.ibm.com>, KVM list <kvm@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>, Oleg Nesterov <oleg@redhat.com>, Paul Gortmaker <paul.gortmaker@windriver.com>, Peter Anvin <hpa@zytor.com>, Andi Kleen <ak@linux.intel.com>, Gleb Natapov <gleb@redhat.com>, the arch/x86 maintainers <x86@kernel.org>, Ingo Molnar <mingo@redhat.com>, xen-devel@lists.xenproject.org, Paul McKenney <paulmck@linux.vnet.ibm.com>, virtualization <virtualization@lists.linux-foundation.org>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Dave Jones <davej@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, fernando_b1@lab.ntt.co.jp, "Vinod, Chegu" <chegu_vinod@hp.com>, Waiman Long <waiman.long@hp.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Paolo Bonzini <pbonzini@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

On Wed, May 28, 2014 at 2:55 PM, Rik van Riel <riel@redhat.com> wrote:
>
> Or maybe cmpxchg is cheap once you already own the cache line
> exclusively?

A locked cmpxchg ends up being anything between ~15-50 cycles
depending on microarchitecture if things are already exclusively in
the cache (with the P4 being an outlier, and all locked instructions
tend to take ~100+ cycles, but I can't say I can really find it in
myself to even care about netburst any more).

The most noticeable downside we've seen has been when we've used
"read-op-cmpxchg" as a _replacement_ for something like "lock [x]add",
when that "read+cmpxchg" has caused two cacheline ops (cacheline first
loaded shared by the read, then exclusive by the cmpxchg). That's bad.

But if preceded by a write (or, in this case, an xadd), that doesn't
happen. Still, those roughly 15-50 cycles can certainly be noticeable
(especially at the high end), but you need to have some load that
doesn't bounce the lock, and largely fit in the caches to see it. And
you probably want to test one of the older CPU's, I think Haswell is
the lower end (ie in the ~20 cycle range).

If somebody has a P4 still, that's likely the worst case by far.

              Linus
