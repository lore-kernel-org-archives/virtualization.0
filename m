From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v3 0/2] guard virt_spin_lock() with a static key
Date: Mon, 2 Oct 2017 16:19:11 +0200
Message-ID: <20171002141911.ucl4c73ztqt54hby@hirez.programming.kicks-ass.net>
References: <20170906173625.18158-1-jgross@suse.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20170906173625.18158-1-jgross@suse.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Juergen Gross <jgross@suse.com>
Cc: jeremy@goop.org, rusty@rustcorp.com.au, x86@kernel.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, chrisw@sous-sol.org, mingo@redhat.com, tglx@linutronix.de, longman@redhat.com, hpa@zytor.com, xen-devel@lists.xenproject.org, akataria@vmware.com, boris.ostrovsky@oracle.com
List-Id: virtualization@lists.linuxfoundation.org

On Wed, Sep 06, 2017 at 07:36:23PM +0200, Juergen Gross wrote:
> With virt_spin_lock() being guarded by a static key the bare metal case
> can be optimized by patching the call away completely. In case a kernel
> running as a guest it can decide whether to use paravitualized
> spinlocks, the current fallback to the unfair test-and-set scheme, or
> to mimic the bare metal behavior.
> 
> V3:
> - remove test for hypervisor environment from virt_spin_lock(9 as
>   suggested by Waiman Long
> 
> V2:
> - use static key instead of making virt_spin_lock() a pvops function
> 
> Juergen Gross (2):
>   paravirt/locks: use new static key for controlling call of
>     virt_spin_lock()
>   paravirt,xen: correct xen_nopvspin case
> 
>  arch/x86/include/asm/qspinlock.h     | 11 ++++++++++-
>  arch/x86/kernel/paravirt-spinlocks.c |  6 ++++++
>  arch/x86/kernel/smpboot.c            |  2 ++
>  arch/x86/xen/spinlock.c              |  2 ++
>  kernel/locking/qspinlock.c           |  4 ++++
>  5 files changed, 24 insertions(+), 1 deletion(-)

Sorry for the delay, picked it up now.
