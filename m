From: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: Re: [PATCH 09/14] xen/pvticketlock: Xen implementation for PV	 ticket
	locks
Date: Wed, 17 Nov 2010 00:52:55 -0800
Message-ID: <4CE397E7.2010107__18171.0435929292$1289984007$gmane$org@goop.org>
References: <cover.1289940821.git.jeremy.fitzhardinge@citrix.com><cover.1289940821.git.jeremy.fitzhardinge@citrix.com>
	<aa32da076143b8e13c23c1f589d7e6cbedb22907.1289940821.git.jeremy.fitzhardinge@citrix.com>
	<4CE39C3C0200007800022AE2@vpn.id2.novell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <4CE39C3C0200007800022AE2@vpn.id2.novell.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Jan Beulich <JBeulich@novell.com>
Cc: Jeremy Fitzhardinge <jeremy.fitzhardinge@citrix.com>, Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>, Nick Piggin <npiggin@kernel.dk>, Peter Zijlstra <peterz@infradead.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Srivatsa Vaddagiri <vatsa@linux.vnet.ibm.com>, Eric Dumazet <dada1@cosmosbay.com>, Xen-devel <xen-devel@lists.xensource.com>, Avi Kivity <avi@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, xiyou.wangcong@gmail.com, Linux Virtualization <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

On 11/17/2010 12:11 AM, Jan Beulich wrote:
>>>> On 16.11.10 at 22:08, Jeremy Fitzhardinge <jeremy@goop.org> wrote:
>> +static void xen_lock_spinning(struct arch_spinlock *lock, unsigned want)
>>  {
>> -	struct xen_spinlock *xl = (struct xen_spinlock *)lock;
>> -	struct xen_spinlock *prev;
>>  	int irq = __get_cpu_var(lock_kicker_irq);
>> -	int ret;
>> +	struct xen_lock_waiting *w = &__get_cpu_var(lock_waiting);
>> +	int cpu = smp_processor_id();
>>  	u64 start;
>>  
>>  	/* If kicker interrupts not initialized yet, just spin */
>>  	if (irq == -1)
>> -		return 0;
>> +		return;
>>  
>>  	start = spin_time_start();
>>  
>> -	/* announce we're spinning */
>> -	prev = spinning_lock(xl);
>> +	w->want = want;
>> +	w->lock = lock;
>> +
>> +	/* This uses set_bit, which atomic and therefore a barrier */
>> +	cpumask_set_cpu(cpu, &waiting_cpus);
> Since you don't allow nesting, don't you need to disable
> interrupts before you touch per-CPU state?

Yes, I think you're right - interrupts need to be disabled for the bulk
of this function.

    J
