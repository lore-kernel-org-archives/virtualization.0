From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v2 09/11] x86/paravirt: move the Xen-only pv_irq_ops
	under the PARAVIRT_XXL umbrella
Date: Fri, 24 Aug 2018 16:10:45 +0200
Message-ID: <20180824141045.GO24124@hirez.programming.kicks-ass.net>
References: <20180813073739.26108-1-jgross@suse.com>
	<20180813073739.26108-10-jgross@suse.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20180813073739.26108-10-jgross@suse.com>
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
Cc: rusty@rustcorp.com.au, x86@kernel.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, mingo@redhat.com, tglx@linutronix.de, hpa@zytor.com, xen-devel@lists.xenproject.org, akataria@vmware.com, boris.ostrovsky@oracle.com
List-Id: virtualization@lists.linuxfoundation.org

On Mon, Aug 13, 2018 at 09:37:37AM +0200, Juergen Gross wrote:
> Some of the paravirt ops defined in pv_irq_ops are for Xen PV guests
> only. Define them only if CONFIG_PARAVIRT_XXL is set.
> diff --git a/arch/x86/include/asm/paravirt_types.h b/arch/x86/include/asm/paravirt_types.h
> index e652ec27d945..ae53ee36d8fb 100644
> --- a/arch/x86/include/asm/paravirt_types.h
> +++ b/arch/x86/include/asm/paravirt_types.h
> @@ -197,8 +197,10 @@ struct pv_irq_ops {
>  	struct paravirt_callee_save irq_disable;
>  	struct paravirt_callee_save irq_enable;
>  
> +#ifdef CONFIG_PARAVIRT_XXL
>  	void (*safe_halt)(void);
>  	void (*halt)(void);
> +#endif

that makes me sad... but it appears VSMP also uses them. Can't you
simply make VSMP also select XXL, I don't think that's used quite as
much as Xen is :-)
