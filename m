From: Waiman Long <waiman.long@hp.com>
Subject: Re: [PATCH v9 06/19] qspinlock: prolong the stay in the pending bit
	path
Date: Fri, 18 Apr 2014 14:07:06 -0400
Message-ID: <535169CA.8060209__1221.22924444756$1397844464$gmane$org@hp.com>
References: <1397747051-15401-1-git-send-email-Waiman.Long@hp.com>
	<1397747051-15401-7-git-send-email-Waiman.Long@hp.com>
	<20140417163640.GT11096@twins.programming.kicks-ass.net>
	<535083DC.2040406@hp.com>
	<20140418083342.GA11096@twins.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20140418083342.GA11096@twins.programming.kicks-ass.net>
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
Cc: linux-arch@vger.kernel.org, Rik van Riel <riel@redhat.com>, Raghavendra K T <raghavendra.kt@linux.vnet.ibm.com>, Gleb Natapov <gleb@redhat.com>, kvm@vger.kernel.org, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Scott J Norton <scott.norton@hp.com>, x86@kernel.org, Paolo Bonzini <paolo.bonzini@gmail.com>, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, Ingo Molnar <mingo@redhat.com>, Chegu Vinod <chegu_vinod@hp.com>, David Vrabel <david.vrabel@citrix.com>, "H. Peter Anvin" <hpa@zytor.com>, xen-devel@lists.xenproject.org, Thomas Gleixner <tglx@linutronix.de>, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, Linus Torvalds <torvalds@linux-foundation.org>, Oleg Nesterov <oleg@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

On 04/18/2014 04:33 AM, Peter Zijlstra wrote:
> On Thu, Apr 17, 2014 at 09:46:04PM -0400, Waiman Long wrote:
>> BTW, I didn't test out your atomic_test_and_set() change. Did it provide a
>> noticeable performance benefit when compared with cmpxchg()?
> I've not tested that I think. I had a hard time showing that cmpxchg
> loops were slower, but once I did, I simply replaced all cmpxchg loops
> with unconditional ops where possible.
>
> The machine that was big enough to show it lived in a lab half way
> around the world and using it was a right pain in the ass, so I didn't
> use it more than I absolutely had to.

Thank for letting me know about it. The cmpxchg() slowdown that I 
observed happens when it is heavily contended. In other words, if many 
CPUs are trying to grab it at roughly the same time. If there is just a 
few contending CPUs, the difference shouldn't be too big.

-Longman
