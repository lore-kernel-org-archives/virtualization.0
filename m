From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [RFC] Implement Batched (group) ticket lock
Date: Thu, 29 May 2014 08:46:06 +0200
Message-ID: <20140529064606.GH19143@laptop.programming.kicks-ass.net>
References: <1401279399-23854-1-git-send-email-raghavendra.kt@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1401279399-23854-1-git-send-email-raghavendra.kt@linux.vnet.ibm.com>
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
Cc: jeremy@goop.org, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org, paul.gortmaker@windriver.com, hpa@zytor.com, ak@linux.intel.com, gleb@redhat.com, x86@kernel.org, mingo@redhat.com, xen-devel@lists.xenproject.org, paulmck@linux.vnet.ibm.com, riel@redhat.com, konrad.wilk@oracle.com, oleg@redhat.com, davej@redhat.com, tglx@linutronix.de, fernando_b1@lab.ntt.co.jp, chegu_vinod@hp.com, waiman.long@hp.com, linux-kernel@vger.kernel.org, pbonzini@redhat.com, torvalds@linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Wed, May 28, 2014 at 05:46:39PM +0530, Raghavendra K T wrote:
> In virtualized environment there are mainly three problems
> related to spinlocks that affect performance.
> 1. LHP (lock holder preemption)
> 2. Lock Waiter Preemption (LWP)
> 3. Starvation/fairness
> 
>  Though ticketlocks solve the fairness problem, it worsens LWP, LHP problems.
> pv-ticketlocks tried to address this. But we can further improve at the
> cost of relaxed fairness.

So I really hate the idea of having different locks for paravirt and
normal kernels.

And we're looking to move to that queued lock for normal kernels.
