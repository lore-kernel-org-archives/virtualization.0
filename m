From: Raghavendra K T <raghavendra.kt@linux.vnet.ibm.com>
Subject: Re: [PATCH] x86 spinlock: Fix memory corruption on completing
	completions
Date: Sun, 08 Feb 2015 23:19:33 +0530
Message-ID: <54D7A1AD.3050108@linux.vnet.ibm.com>
References: <1423234148-13886-1-git-send-email-raghavendra.kt@linux.vnet.ibm.com>
	<CA+55aFwZOgiUe5Zm=o24d6SshvoLbF1bq_VT0hdijR1hfoyi4A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <CA+55aFwZOgiUe5Zm=o24d6SshvoLbF1bq_VT0hdijR1hfoyi4A@mail.gmail.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Jeremy Fitzhardinge <jeremy@goop.org>, KVM list <kvm@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Paul Gortmaker <paul.gortmaker@windriver.com>, Peter Anvin <hpa@zytor.com>, Andi Kleen <ak@linux.intel.com>, Andrey Ryabinin <a.ryabinin@samsung.com>, the arch/x86 maintainers <x86@kernel.org>, Christian Borntraeger <borntraeger@de.ibm.com>, Ingo Molnar <mingo@redhat.com>, xen-devel@lists.xenproject.org, Paul McKenney <paulmck@linux.vnet.ibm.com>, Rik van Riel <riel@redhat.com>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Sasha Levin <sasha.levin@oracle.com>, Dave Jones <davej@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, virtualization <virtualization@lists.linux-foundation.org>, Waiman Long <waiman.long@hp.com>, Oleg Nesterov <oleg@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Andrew
List-Id: virtualization@lists.linuxfoundation.org

On 02/06/2015 09:55 PM, Linus Torvalds wrote:
> On Fri, Feb 6, 2015 at 6:49 AM, Raghavendra K T
> <raghavendra.kt@linux.vnet.ibm.com> wrote:
>> Paravirt spinlock clears slowpath flag after doing unlock.
> [ fix edited out ]
>
> So I'm not going to be applying this for 3.19, because it's much too
> late and the patch is too scary. Plus the bug probably effectively
> never shows up in real life (it is probably easy to trigger the
> speculative *read* but probably never the actual speculative write
> after dropping the lock last).
>

Understood and agreed.

> This will need a lot of testing by the paravirt people - both
> performance and correctness. So *maybe* for 3.20, but maybe for even
> later, and then marked for stable, of course.
>
> Are there any good paravirt stress-tests that people could run for
> extended times?
>

I have been running several benchmarks (kern, sys, hack, ebizzy etc in
in 1x,2x scenarios. I run them for performance test as well.
(In the current patch I did not get kvm hang in normal run, But
overcommit reproduced it).
