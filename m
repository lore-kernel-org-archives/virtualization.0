From: Rik van Riel <riel@redhat.com>
Subject: Re: [RFC] Implement Batched (group) ticket lock
Date: Wed, 28 May 2014 21:18:10 -0400
Message-ID: <53868AD2.7020902@redhat.com>
References: <1401279399-23854-1-git-send-email-raghavendra.kt@linux.vnet.ibm.com>	<53865B53.7050809@redhat.com>
	<CA+55aFx9d1dP+A3tdR-GaASQYBkkJHcV-=t9FdA7AGrMN12S0w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <CA+55aFx9d1dP+A3tdR-GaASQYBkkJHcV-=t9FdA7AGrMN12S0w@mail.gmail.com>
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
Cc: Jeremy Fitzhardinge <jeremy@goop.org>, Raghavendra K T <raghavendra.kt@linux.vnet.ibm.com>, KVM list <kvm@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>, Oleg Nesterov <oleg@redhat.com>, Paul Gortmaker <paul.gortmaker@windriver.com>, Peter Anvin <hpa@zytor.com>, Andi Kleen <ak@linux.intel.com>, Gleb Natapov <gleb@redhat.com>, the arch/x86 maintainers <x86@kernel.org>, Ingo Molnar <mingo@redhat.com>, xen-devel@lists.xenproject.org, Paul McKenney <paulmck@linux.vnet.ibm.com>, virtualization <virtualization@lists.linux-foundation.org>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Dave Jones <davej@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, fernando_b1@lab.ntt.co.jp, "Vinod, Chegu" <chegu_vinod@hp.com>, Waiman Long <waiman.long@hp.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Paolo Bonzini <pbonzini@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

On 05/28/2014 06:19 PM, Linus Torvalds wrote:

> If somebody has a P4 still, that's likely the worst case by far.

I'm sure cmpxchg isn't the only thing making P4 the worst case :)

-- 
All rights reversed
