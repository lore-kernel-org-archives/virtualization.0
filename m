From: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: Re: [PATCH] stopmachine: add stopmachine_timeout
Date: Mon, 14 Jul 2008 11:56:18 -0700
Message-ID: <487BA152.1070102__4017.23669278926$1216061937$gmane$org@goop.org>
References: <487B05CE.1050508@jp.fujitsu.com>
	<200807141351.25092.borntraeger@de.ibm.com>
	<200807142234.40700.rusty@rustcorp.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <200807142234.40700.rusty@rustcorp.com.au>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: Hidetoshi Seto <seto.hidetoshi@jp.fujitsu.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, Christian Borntraeger <borntraeger@de.ibm.com>
List-Id: virtualization@lists.linuxfoundation.org

Rusty Russell wrote:
> On Monday 14 July 2008 21:51:25 Christian Borntraeger wrote:
>   
>> Am Montag, 14. Juli 2008 schrieb Hidetoshi Seto:
>>     
>>> +	/* Wait all others come to life */
>>> +	while (cpus_weight(prepared_cpus) != num_online_cpus() - 1) {
>>> +		if (time_is_before_jiffies(limit))
>>> +			goto timeout;
>>> +		cpu_relax();
>>> +	}
>>> +
>>>       
>> Hmm. I think this could become interesting on virtual machines. The
>> hypervisor might be to busy to schedule a specific cpu at certain load
>> scenarios. This would cause a failure even if the cpu is not really locked
>> up. We had similar problems with the soft lockup daemon on s390.
>>     
>
> 5 seconds is a fairly long time.  If all else fails we could have a config 
> option to simply disable this code.
>
>   
>> It would be good to not-use wall-clock time, but really used cpu time
>> instead. Unfortunately I have no idea, if that is possible in a generic
>> way. Heiko, any ideas?
>>     
>
> Ah, cpu time comes up again.  Perhaps we should actually dig that up again; 
> Zach and Jeremy CC'd.

Hm, yeah. But in this case, it's tricky. CPU time is an inherently
per-cpu quantity. If cpu A is waiting for cpu B, and wants to do the
timeout in cpu-seconds, then it has to be in *B*s cpu-seconds (and if A
is waiting on B,C,D,E,F... it needs to measure separate timeouts with
separate timebases for each other CPU). It also means that if B is
unresponsive but also not consuming any time (blocked in IO,
administratively paused, etc), then the timeout will never trigger.

So I think monotonic wallclock time actually makes the most sense here.

The other issue is whether cpu_relax() is the right thing to put in the
busywait. We don't hook it in pvops, so it's just an x86 "pause"
instruction, so from the hypervisor's perspective it just looks like a
spinning CPU. We could either hook cpu_relax() into a hypervisor yield,
or come up with a heavier-weight cpu_snooze() (cpu_relax() is often used
in loops which are expected to have a short duration, where doing a
hypercall+yield would be overkill).

J
