From: Juergen Gross <jgross@suse.com>
Subject: Re: [PATCH v2 10/11] x86/paravirt: move the Xen-only pv_mmu_ops under
	the PARAVIRT_XXL umbrella
Date: Fri, 24 Aug 2018 16:15:08 +0200
Message-ID: <e4862ca0-ccff-1662-0db2-86891b95f598@suse.com>
References: <20180813073739.26108-1-jgross@suse.com>
	<20180813073739.26108-11-jgross@suse.com>
	<20180824141218.GP24124@hirez.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20180824141218.GP24124@hirez.programming.kicks-ass.net>
Content-Language: de-DE
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
Cc: rusty@rustcorp.com.au, x86@kernel.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, mingo@redhat.com, tglx@linutronix.de, hpa@zytor.com, xen-devel@lists.xenproject.org, akataria@vmware.com, boris.ostrovsky@oracle.com
List-Id: virtualization@lists.linuxfoundation.org

On 24/08/18 16:12, Peter Zijlstra wrote:
> On Mon, Aug 13, 2018 at 09:37:38AM +0200, Juergen Gross wrote:
>>  struct pv_mmu_ops {
>> +	/* TLB operations */
>> +	void (*flush_tlb_user)(void);
>> +	void (*flush_tlb_kernel)(void);
>> +	void (*flush_tlb_one_user)(unsigned long addr);
>> +	void (*flush_tlb_others)(const struct cpumask *cpus,
>> +				 const struct flush_tlb_info *info);
>> +
>> +	/* Hook for intercepting the destruction of an mm_struct. */
>> +	void (*exit_mmap)(struct mm_struct *mm);
> 
> Right, so I just wrecked that for you by adding a new:
> tlb_remove_table virt function. But I don't suppose that's a difficult
> thing to fix up.

Right. This will stay outside of XXL, I think. :-)


Juergen
