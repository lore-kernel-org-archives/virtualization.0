From: Waiman Long <longman@redhat.com>
Subject: Re: [PATCH 3/4] paravirt: add virt_spin_lock pvops function
Date: Tue, 5 Sep 2017 10:02:57 -0400
Message-ID: <3eee978b-e570-5675-7840-c448375b02fc__30327.8025858619$1504620223$gmane$org@redhat.com>
References: <20170905132444.7163-1-jgross@suse.com>
	<20170905132444.7163-4-jgross@suse.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20170905132444.7163-4-jgross@suse.com>
Content-Language: en-US
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Juergen Gross <jgross@suse.com>, linux-kernel@vger.kernel.org, xen-devel@lists.xenproject.org, x86@kernel.org, virtualization@lists.linux-foundation.org
Cc: jeremy@goop.org, peterz@infradead.org, chrisw@sous-sol.org, mingo@redhat.com, tglx@linutronix.de, hpa@zytor.com, akataria@vmware.com, boris.ostrovsky@oracle.com
List-Id: virtualization@lists.linuxfoundation.org

On 09/05/2017 09:24 AM, Juergen Gross wrote:
> There are cases where a guest tries to switch spinlocks to bare metal
> behavior (e.g. by setting "xen_nopvspin" boot parameter). Today this
> has the downside of falling back to unfair test and set scheme for
> qspinlocks due to virt_spin_lock() detecting the virtualized
> environment.
>
> Make virt_spin_lock() a paravirt operation in order to enable users
> to select an explicit behavior like bare metal.
>
> Signed-off-by: Juergen Gross <jgross@suse.com>
> ---
>  arch/x86/include/asm/paravirt.h       |  5 ++++
>  arch/x86/include/asm/paravirt_types.h |  1 +
>  arch/x86/include/asm/qspinlock.h      | 48 ++++++++++++++++++++++++-----------
>  arch/x86/kernel/paravirt-spinlocks.c  | 14 ++++++++++
>  arch/x86/kernel/smpboot.c             |  2 ++
>  5 files changed, 55 insertions(+), 15 deletions(-)
>
> diff --git a/arch/x86/include/asm/paravirt.h b/arch/x86/include/asm/paravirt.h
> index c25dd22f7c70..d9e954fb37df 100644
> --- a/arch/x86/include/asm/paravirt.h
> +++ b/arch/x86/include/asm/paravirt.h
> @@ -725,6 +725,11 @@ static __always_inline bool pv_vcpu_is_preempted(long cpu)
>  	return PVOP_CALLEE1(bool, pv_lock_ops.vcpu_is_preempted, cpu);
>  }
>  
> +static __always_inline bool pv_virt_spin_lock(struct qspinlock *lock)
> +{
> +	return PVOP_CALLEE1(bool, pv_lock_ops.virt_spin_lock, lock);
> +}
> +
>  #endif /* SMP && PARAVIRT_SPINLOCKS */
>  
>  #ifdef CONFIG_X86_32
> diff --git a/arch/x86/include/asm/paravirt_types.h b/arch/x86/include/asm/paravirt_types.h
> index 19efefc0e27e..928f5e7953a7 100644
> --- a/arch/x86/include/asm/paravirt_types.h
> +++ b/arch/x86/include/asm/paravirt_types.h
> @@ -319,6 +319,7 @@ struct pv_lock_ops {
>  	void (*kick)(int cpu);
>  
>  	struct paravirt_callee_save vcpu_is_preempted;
> +	struct paravirt_callee_save virt_spin_lock;
>  } __no_randomize_layout;
>  
>  /* This contains all the paravirt structures: we get a convenient
> diff --git a/arch/x86/include/asm/qspinlock.h b/arch/x86/include/asm/qspinlock.h
> index 48a706f641f2..fbd98896385c 100644
> --- a/arch/x86/include/asm/qspinlock.h
> +++ b/arch/x86/include/asm/qspinlock.h
> @@ -17,6 +17,25 @@ static inline void native_queued_spin_unlock(struct qspinlock *lock)
>  	smp_store_release((u8 *)lock, 0);
>  }
>  
> +static inline bool native_virt_spin_lock(struct qspinlock *lock)
> +{
> +	if (!static_cpu_has(X86_FEATURE_HYPERVISOR))
> +		return false;
> +

I think you can take the above if statement out as you has done test in
native_pv_lock_init(). So the test will also be false here.

As this patch series is x86 specific, you should probably add "x86/" in
front of paravirt in the patch titles.

Cheers,
Longman
