From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v12 09/11] pvqspinlock, x86: Add para-virtualization
	support
Date: Fri, 24 Oct 2014 10:47:38 +0200
Message-ID: <20141024084738.GU21513__36652.3594515913$1414142987$gmane$org@worktop.programming.kicks-ass.net>
References: <1413483040-58399-1-git-send-email-Waiman.Long@hp.com>
	<1413483040-58399-10-git-send-email-Waiman.Long@hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1413483040-58399-10-git-send-email-Waiman.Long@hp.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Waiman Long <Waiman.Long@hp.com>
Cc: linux-arch@vger.kernel.org, Rik van Riel <riel@redhat.com>, Raghavendra K T <raghavendra.kt@linux.vnet.ibm.com>, Oleg Nesterov <oleg@redhat.com>, kvm@vger.kernel.org, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Scott J Norton <scott.norton@hp.com>, x86@kernel.org, Paolo Bonzini <paolo.bonzini@gmail.com>, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, Ingo Molnar <mingo@redhat.com>, David Vrabel <david.vrabel@citrix.com>, "H. Peter Anvin" <hpa@zytor.com>, xen-devel@lists.xenproject.org, Thomas Gleixner <tglx@linutronix.de>, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, Linus Torvalds <torvalds@linux-foundation.org>, Boris Ostrovsky <boris.ostrovsky@oracle.com>, Douglas Hatch <doug.hatch@hp.com>
List-Id: virtualization@lists.linuxfoundation.org

On Thu, Oct 16, 2014 at 02:10:38PM -0400, Waiman Long wrote:
> +static inline void pv_init_node(struct mcs_spinlock *node)
> +{
> +	struct pv_qnode *pn = (struct pv_qnode *)node;
> +
> +	BUILD_BUG_ON(sizeof(struct pv_qnode) > 5*sizeof(struct mcs_spinlock));
> +
> +	if (!pv_enabled())
> +		return;
> +
> +	pn->cpustate = PV_CPU_ACTIVE;
> +	pn->mayhalt  = false;
> +	pn->mycpu    = smp_processor_id();
> +	pn->head     = PV_INVALID_HEAD;
> +}


> @@ -333,6 +393,7 @@ queue:
>  	node += idx;
>  	node->locked = 0;
>  	node->next = NULL;
> +	pv_init_node(node);
>  
>  	/*
>  	 * We touched a (possibly) cold cacheline in the per-cpu queue node;


So even if !pv_enabled() the compiler will still have to emit the code
for that inline, which will generate additional register pressure,
icache pressure and lovely stuff like that.

The patch I had used pv-ops for these things that would turn into NOPs
in the regular case and callee-saved function calls for the PV case.

That still does not entirely eliminate cost, but does reduce it
significant. Please consider using that.
