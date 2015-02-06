From: Andrey Ryabinin <a.ryabinin@samsung.com>
Subject: Re: [PATCH] x86 spinlock: Fix memory corruption on completing
	completions
Date: Fri, 06 Feb 2015 20:03:14 +0300
Message-ID: <54D4F3D2.3010807__5717.14262846417$1423247214$gmane$org@samsung.com>
References: <1423234148-13886-1-git-send-email-raghavendra.kt@linux.vnet.ibm.com>
	<54D4DBA1.1030905@oracle.com>
	<CA+55aFwhf0iCKDzv-CiC7qMYa9x8C9keRCUDkXu6KLb8sXsC2w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-reply-to: <CA+55aFwhf0iCKDzv-CiC7qMYa9x8C9keRCUDkXu6KLb8sXsC2w@mail.gmail.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Linus Torvalds <torvalds@linux-foundation.org>, Sasha Levin <sasha.levin@oracle.com>
Cc: Jeremy Fitzhardinge <jeremy@goop.org>, Raghavendra K T <raghavendra.kt@linux.vnet.ibm.com>, KVM list <kvm@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Paul Gortmaker <paul.gortmaker@windriver.com>, Peter Anvin <hpa@zytor.com>, Andi Kleen <ak@linux.intel.com>, the arch/x86 maintainers <x86@kernel.org>, Christian Borntraeger <borntraeger@de.ibm.com>, Ingo Molnar <mingo@redhat.com>, xen-devel@lists.xenproject.org, Paul McKenney <paulmck@linux.vnet.ibm.com>, Rik van Riel <riel@redhat.com>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Dave Jones <davej@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, virtualization <virtualization@lists.linux-foundation.org>, Waiman Long <waiman.long@hp.com>, Oleg Nesterov <oleg@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Andrew Morton <akpm@linux-foundation.or>
List-Id: virtualization@lists.linuxfoundation.org

On 02/06/2015 07:15 PM, Linus Torvalds wrote:
> On Fri, Feb 6, 2015 at 7:20 AM, Sasha Levin <sasha.levin@oracle.com> wrote:
>>
>> Can we modify it slightly to avoid potentially accessing invalid memory:
> 
> So I think there's a race with that.
> 
> And I'll warn you: the kernel does do speculative reads of memory that
> might be invalid, not just in places like this. See the comment in
> get_user_huge_page() for example, where we knowingly do speculative
> reads, but hide it if DEBUG_PAGEALLOC is set.
> 
> More commonly, CONFIG_DCACHE_WORD_ACCESS is very much about doing
> speculative reads. Now, that access is hidden inside an asm, so KASan
> won't see it, but there might well be others.
> 
> You probably don't see them very much just because they are so rarely
> a problem, and most of the time it's not to other processes stack but
> to allocated structures where freeing takes long enough to basically
> hide any small race..
> 
> In other words: I suspect it would be good to instead just teach KASan
> about "this is a speculative read" and just suppress the warning for
> those instead.
> 

We can suppress warnings by wrapping such speculative reads with
kasan_disable_current()/kasan_enable_current() calls.
