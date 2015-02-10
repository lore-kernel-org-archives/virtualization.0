From: Sasha Levin <sasha.levin@oracle.com>
Subject: Re: [PATCH] x86 spinlock: Fix memory corruption on completing
	completions
Date: Tue, 10 Feb 2015 08:23:10 -0500
Message-ID: <54DA063E.3080803@oracle.com>
References: <1423234148-13886-1-git-send-email-raghavendra.kt@linux.vnet.ibm.com>
	<54D7D19B.1000103@goop.org>	<54D87F1E.9060307@linux.vnet.ibm.com>
	<20150209120227.GT21418@twins.programming.kicks-ass.net>
	<CA+55aFympdPOotzEgdhQULidN+nxb-VUdfym+qU9LOsHScvpzw@mail.gmail.com>
	<54D9CFC7.5020007@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <54D9CFC7.5020007@linux.vnet.ibm.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Raghavendra K T <raghavendra.kt@linux.vnet.ibm.com>, Linus Torvalds <torvalds@linux-foundation.org>, Jeremy Fitzhardinge <jeremy@goop.org>, Davidlohr Bueso <dave@stgolabs.net>
Cc: KVM list <kvm@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Paul Gortmaker <paul.gortmaker@windriver.com>, Peter Anvin <hpa@zytor.com>, Andi Kleen <ak@linux.intel.com>, Andrey Ryabinin <a.ryabinin@samsung.com>, the arch/x86 maintainers <x86@kernel.org>, Christian Borntraeger <borntraeger@de.ibm.com>, Ingo Molnar <mingo@redhat.com>, xen-devel@lists.xenproject.org, Paul McKenney <paulmck@linux.vnet.ibm.com>, Rik van Riel <riel@redhat.com>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Dave Jones <davej@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, virtualization <virtualization@lists.linux-foundation.org>, Waiman Long <waiman.long@hp.com>, Oleg Nesterov <oleg@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Andrew Morton <akpm@linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

On 02/10/2015 04:30 AM, Raghavendra K T wrote:
>>
>> So I think Raghavendra's last version (which hopefully fixes the
>> lockup problem that Sasha reported) together with changing that
> 
> V2 did pass the stress, but getting confirmation Sasha would help.

I've been running it for the last two days, and didn't see any lockups
or other strange behaviour aside from some invalid reads which we
expected.


Thanks,
Sasha
