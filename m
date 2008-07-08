From: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: Re: [PATCH RFC 4/4] xen: implement Xen-specific spinlocks
Date: Tue, 08 Jul 2008 00:15:21 -0700
Message-ID: <48731409.9070304__25081.9983579733$1215501456$gmane$org@goop.org>
References: <20080707190749.299430659@goop.org>	<20080707190838.710151521@goop.org>
	<87tzf0q3te.fsf@saeurebad.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <87tzf0q3te.fsf@saeurebad.de>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Johannes Weiner <hannes@saeurebad.de>
Cc: Jens Axboe <axboe@kernel.dk>, Nick Piggin <nickpiggin@yahoo.com.au>, Xen devel <xen-devel@lists.xensource.com>, Peter Zijlstra <a.p.zijlstra@chello.nl>, Christoph Lameter <clameter@linux-foundation.org>, Petr Tesarik <ptesarik@suse.cz>, LKML <linux-kernel@vger.kernel.org>, Virtualization <virtualization@lists.linux-foundation.org>, Thomas Friebel <thomas.friebel@amd.com>, Jeremy Fitzhardinge <jeremy.fitzhardinge@citrix.com>, Ingo Molnar <mingo@elte.hu>
List-Id: virtualization@lists.linuxfoundation.org

Johannes Weiner wrote:
>> +static DEFINE_PER_CPU(int, lock_kicker_irq) = -1;
>> +static DEFINE_PER_CPU(struct xen_spinlock *, lock_spinners);
>>     
>
> The plural is a bit misleading, as this is a single pointer per CPU.
>   

Yeah.  And it's wrong because it's specifically *not* spinning, but 
blocking.

>> +static noinline void xen_spin_unlock_slow(struct xen_spinlock *xl)
>> +{
>> +	int cpu;
>> +
>> +	for_each_online_cpu(cpu) {
>>     
>
> Would it be feasible to have a bitmap for the spinning CPUs in order to
> do a for_each_spinning_cpu() here instead?  Or is setting a bit in
> spinning_lock() and unsetting it in unspinning_lock() more overhead than
> going over all CPUs here?
>   

Not worthwhile, I think.  This is a very rare path: it will only happen 
if 1) there's lock contention, that 2) wasn't resolved within the 
timeout.  In practice, this gets called a few thousand times per cpu 
over a kernbench, which is nothing.

My very original version of this code kept a bitmask of interested CPUs 
within the lock, but there's only space for 24 cpus if we still use a 
byte for the lock itself.  It all turned out fairly awkward, and this 
version is a marked improvement.

    J
