From: Juergen Gross <jgross@suse.com>
Subject: Re: [PATCH v4 3/6] smp: add function to execute a function
	synchronously on a cpu
Date: Tue, 5 Apr 2016 12:05:34 +0200
Message-ID: <57038DEE.3070201@suse.com>
References: <1459833007-11618-1-git-send-email-jgross@suse.com>
	<1459833007-11618-4-git-send-email-jgross@suse.com>
	<20160405081107.GH3448@twins.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20160405081107.GH3448@twins.programming.kicks-ass.net>
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
Cc: x86@kernel.org, jeremy@goop.org, jdelvare@suse.com, hpa@zytor.com, akataria@vmware.com, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, chrisw@sous-sol.org, mingo@redhat.com, david.vrabel@citrix.com, Douglas_Warzecha@dell.com, pali.rohar@gmail.com, xen-devel@lists.xenproject.org, boris.ostrovsky@oracle.com, tglx@linutronix.de, linux@roeck-us.net
List-Id: virtualization@lists.linuxfoundation.org

On 05/04/16 10:11, Peter Zijlstra wrote:
> On Tue, Apr 05, 2016 at 07:10:04AM +0200, Juergen Gross wrote:
>> +int smp_call_on_cpu(unsigned int cpu, bool pin, int (*func)(void *), void *par)
> 
> Why .pin and not .phys? .pin does not (to me) reflect the
> hypervisor/physical-cpu thing.

I don't mind either way. As you don't like .pin, lets name it .phys.

> Also, as per smp_call_function_single() would it not be more consistent
> to make this the last argument?

Okay, I'll change it.

> 
>> +{
>> +	struct smp_call_on_cpu_struct sscs = {
>> +		.work = __WORK_INITIALIZER(sscs.work, smp_call_on_cpu_callback),
>> +		.done = COMPLETION_INITIALIZER_ONSTACK(sscs.done),
>> +		.func = func,
>> +		.data = par,
>> +		.cpu  = pin ? cpu : -1,
>> +	};
>> +
>> +	if (cpu >= nr_cpu_ids)
> 
> You might want to also include cpu_online().
> 
> 	if (cpu >= nr_cpu_ids || !cpu_online(cpu))

Indeed, good idea.

>> +		return -ENXIO;
> 
> Seeing how its fairly hard to schedule work on a cpu that's not actually
> there.

Really? ;-)


Juergen
