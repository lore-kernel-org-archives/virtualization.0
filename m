From: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: Re: huh startup_ipi_hook?
Date: Sat, 28 Apr 2007 01:26:02 -0700
Message-ID: <4633051A.3000200@goop.org>
References: <m1d51pgeby.fsf@ebiederm.dsl.xmission.com>	<4632F653.3000102@goop.org>
	<m14pn0hqij.fsf@ebiederm.dsl.xmission.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <m14pn0hqij.fsf@ebiederm.dsl.xmission.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: virtualization@lists.osdl.org
List-Id: virtualization@lists.linuxfoundation.org

Eric W. Biederman wrote:
> That may work but at first glance that feels a little to high level,
> and a little lacking.
>
> What I am certain of is that we need a general ability to send
> inter processor interrupts.  Beyond that I haven't looked closely
> yet.
>   

IPIs are used for three things: function calls, reschedule and tlb
flush. smp_ops covers function calls and reschedule, and paravirt_ops
has a cross-cpu tlb flush operation (which is not implemented as an IPI
under Xen, since it knows what real cpus actually have stale state).

>> This is a fairly close match to Xen's requirements. Certainly, anything
>> APIC-related is useless for us, since there's no APIC emulation going on.
>>     
>
> I almost agree.  Real hardware in a paravirtualized setting is
> something we have to deal with.  This means while we may not have to
> deal with APICs we do have to deal with irqs from real hardware,
> and there are a lot of implications there.
>   

In the Xen model, hardware interrupts are mapped to event channels, and
you can arrange for even channel IDs to be mapped directly to hardware
irqs. But this is why I'm very interested in making the irq space
dynamically allocatable, so that we can use event channel IDs directly
as irqs, and easily have disjoint ranges for hardware statically
allocated events and dynamic events.

> Partly I suspect you haven't been getting some of the review you could
> have because arch/i386 is not that interesting right now.  arch/x86_64
> is where the code is generally clean, and new hardware support work
> tends to focus.
>   

That may be. I've been waiting to see what the outcome of the 32/64 bit
merge discussions before launching into 64-bit paravirt_ops (though
rostedt and glommer have made a good start on it).

>> I won't speak for Zach, but his counter-argument is generally along the
>> lines of "we can just make use of the existing code with a couple of
>> little hooks near the bottom". But I wonder if the existing genapic
>> interface can be used (or extended) to cover these cases without having
>> needing to have APIC-level interfaces in paravirt_ops.
>>     
>
> Things need to be abstracted properly.  Not to high or we don't share
> what should be common.  Not to low or we place the hooks in the wrong
> location and we have a voyager on steroids problem.
>   

Yes, and its tricky in places to have a single interface which is
supposed to deal with both Xen and VMI, since they're often at opposite
ends of the abstraction spectrum. So we end up with a high-level
interface which calls into Xen code and the existing native code, and
then some hooks in the native code to call out to Xen. If the native
code were refactored a little more, I think this would come out fairly
cleanly (ie, use it as a library of code which talks to hardware and
things (mostly) emulating hardware). Things get a bit strange with VMI
where it mixes hardware emulation with paravirtualization - the timer
stuff, for example.

> are what I stumbled onto.  I figured it best if I took
> a few minutes spoke up, and mentioned what I saw.
>   

Thanks,
J
