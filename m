From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [RFC PATCH 19/26] x86/alternatives: NMI safe runtime patching
Date: Wed, 8 Apr 2020 13:36:31 +0200
Message-ID: <20200408113631.GX20713@hirez.programming.kicks-ass.net>
References: <20200408050323.4237-1-ankur.a.arora@oracle.com>
 <20200408050323.4237-20-ankur.a.arora@oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20200408050323.4237-20-ankur.a.arora@oracle.com>
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

On Tue, Apr 07, 2020 at 10:03:16PM -0700, Ankur Arora wrote:
> @@ -1807,12 +1911,20 @@ static int __maybe_unused text_poke_late(patch_worker_t worker, void *stage)
>  	text_poke_state.state = PATCH_SYNC_DONE; /* Start state */
>  	text_poke_state.primary_cpu = smp_processor_id();
>  
> +	text_poke_state.nmi_context = nmi;
> +
> +	if (nmi)
> +		register_nmi_handler(NMI_LOCAL, text_poke_nmi,
> +				     NMI_FLAG_FIRST, "text_poke_nmi");
>  	/*
>  	 * Run the worker on all online CPUs. Don't need to do anything
>  	 * for offline CPUs as they come back online with a clean cache.
>  	 */
>  	ret = stop_machine(patch_worker, &text_poke_state, cpu_online_mask);
>  
> +	if (nmi)
> +		unregister_nmi_handler(NMI_LOCAL, "text_poke_nmi");
> +
>  	return ret;
>  }

This is completely bonghits crazy.
