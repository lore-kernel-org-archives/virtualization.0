From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v2 0/4] implement vcpu preempted check
Date: Wed, 6 Jul 2016 08:52:55 +0200
Message-ID: <20160706065255.GH30909@twins.programming.kicks-ass.net>
References: <1467124991-13164-1-git-send-email-xinhui.pan@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1467124991-13164-1-git-send-email-xinhui.pan@linux.vnet.ibm.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Pan Xinhui <xinhui.pan@linux.vnet.ibm.com>
Cc: linux-s390@vger.kernel.org, dave@stgolabs.net, mpe@ellerman.id.au, boqun.feng@gmail.com, will.deacon@arm.com, linux-kernel@vger.kernel.org, waiman.long@hpe.com, virtualization@lists.linux-foundation.org, mingo@redhat.com, paulus@samba.org, benh@kernel.crashing.org, schwidefsky@de.ibm.com, pbonzini@redhat.com, paulmck@linux.vnet.ibm.com, linuxppc-dev@lists.ozlabs.org
List-Id: virtualization@lists.linuxfoundation.org

On Tue, Jun 28, 2016 at 10:43:07AM -0400, Pan Xinhui wrote:
> change fomr v1:
> 	a simplier definition of default vcpu_is_preempted
> 	skip mahcine type check on ppc, and add config. remove dedicated macro.
> 	add one patch to drop overload of rwsem_spin_on_owner and mutex_spin_on_owner. 
> 	add more comments
> 	thanks boqun and Peter's suggestion.
> 
> This patch set aims to fix lock holder preemption issues.
> 
> test-case:
> perf record -a perf bench sched messaging -g 400 -p && perf report
> 
> 18.09%  sched-messaging  [kernel.vmlinux]  [k] osq_lock
> 12.28%  sched-messaging  [kernel.vmlinux]  [k] rwsem_spin_on_owner
>  5.27%  sched-messaging  [kernel.vmlinux]  [k] mutex_unlock
>  3.89%  sched-messaging  [kernel.vmlinux]  [k] wait_consider_task
>  3.64%  sched-messaging  [kernel.vmlinux]  [k] _raw_write_lock_irq
>  3.41%  sched-messaging  [kernel.vmlinux]  [k] mutex_spin_on_owner.is
>  2.49%  sched-messaging  [kernel.vmlinux]  [k] system_call
> 
> We introduce interface bool vcpu_is_preempted(int cpu) and use it in some spin
> loops of osq_lock, rwsem_spin_on_owner and mutex_spin_on_owner.
> These spin_on_onwer variant also cause rcu stall before we apply this patch set
> 

Paolo, could you help out with an (x86) KVM interface for this?

Waiman, could you see if you can utilize this to get rid of the
SPIN_THRESHOLD in qspinlock_paravirt?
