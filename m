From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [RFC PATCH 15/26] x86/alternatives: Non-emulated text poking
Date: Wed, 8 Apr 2020 13:23:29 +0200
Message-ID: <20200408112329.GW20713@hirez.programming.kicks-ass.net>
References: <20200408050323.4237-1-ankur.a.arora@oracle.com>
 <20200408050323.4237-16-ankur.a.arora@oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20200408050323.4237-16-ankur.a.arora@oracle.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
 <mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
 <mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>
To: Ankur Arora <ankur.a.arora@oracle.com>
Cc: jgross@suse.com, hpa@zytor.com, xen-devel@lists.xenproject.org, kvm@vger.kernel.org, x86@kernel.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, pbonzini@redhat.com, namit@vmware.com, mhiramat@kernel.org, jpoimboe@redhat.com, mihai.carabas@oracle.com, bp@alien8.de, boris.ostrovsky@oracle.com
List-Id: virtualization@lists.linuxfoundation.org

On Tue, Apr 07, 2020 at 10:03:12PM -0700, Ankur Arora wrote:
> +static int __maybe_unused text_poke_late(patch_worker_t worker, void *stage)
> +{
> +	int ret;
> +
> +	lockdep_assert_held(&text_mutex);
> +
> +	if (system_state != SYSTEM_RUNNING)
> +		return -EINVAL;
> +
> +	text_poke_state.stage = stage;
> +	text_poke_state.num_acks = cpumask_weight(cpu_online_mask);
> +	text_poke_state.head = &alt_modules;
> +
> +	text_poke_state.patch_worker = worker;
> +	text_poke_state.state = PATCH_SYNC_DONE; /* Start state */
> +	text_poke_state.primary_cpu = smp_processor_id();
> +
> +	/*
> +	 * Run the worker on all online CPUs. Don't need to do anything
> +	 * for offline CPUs as they come back online with a clean cache.
> +	 */
> +	ret = stop_machine(patch_worker, &text_poke_state, cpu_online_mask);

This.. that on its own is almost a reason to NAK the entire thing. We're
all working very hard to get rid of stop_machine() and you're adding
one.

Worse, stop_machine() is notoriously crap on over-committed virt, the
exact scenario where you want it.

> +
> +	return ret;
> +}
