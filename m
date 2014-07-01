From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [RFC PATCH v2] Implement Batched (group) ticket lock
Date: Tue, 1 Jul 2014 11:55:21 +0200
Message-ID: <20140701095521.GO6758@twins.programming.kicks-ass.net>
References: <1403947024-3193-1-git-send-email-raghavendra.kt@linux.vnet.ibm.com>
	<20140701080537.GH6758@twins.programming.kicks-ass.net>
	<53B282E9.6060806@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <53B282E9.6060806@linux.vnet.ibm.com>
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

On Tue, Jul 01, 2014 at 03:14:09PM +0530, Raghavendra K T wrote:
> On 07/01/2014 01:35 PM, Peter Zijlstra wrote:
> >On Sat, Jun 28, 2014 at 02:47:04PM +0530, Raghavendra K T wrote:
> >>In virtualized environment there are mainly three problems
> >>related to spinlocks that affects performance.
> >>1. LHP (lock holder preemption)
> >>2. Lock Waiter Preemption (LWP)
> >>3. Starvation/fairness
> >>
> >>Though Ticketlocks solve fairness problem it worsens LWP, LHP problems. Though
> >>pv-ticketlocks tried to address these problems we can further improve at the
> >>  cost of relaxed fairness. The following patch tries to achieve that by grouping
> >>(batched) ticketlocks.
> >
> >And here I stop reading and ignore this patch, right?
> >
> >Why should I look at this?
> >
> 
> For baremetal we continue to have 'fully fair ticketlock' with this patch
> series.
> 

But but but, we're looking at removing ticket locks. So why do we want
to invest in them now?
