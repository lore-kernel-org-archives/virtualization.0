From: ebiederm@xmission.com (Eric W. Biederman)
Subject: Re: huh startup_ipi_hook?
Date: Sat, 28 Apr 2007 02:06:28 -0600
Message-ID: <m14pn0hqij.fsf@ebiederm.dsl.xmission.com>
References: <m1d51pgeby.fsf@ebiederm.dsl.xmission.com>
	<4632F653.3000102@goop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <4632F653.3000102@goop.org> (Jeremy Fitzhardinge's message of
	"Sat, 28 Apr 2007 00:22:59 -0700")
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Jeremy Fitzhardinge <jeremy@goop.org>
Cc: virtualization@lists.osdl.org
List-Id: virtualization@lists.linuxfoundation.org

Jeremy Fitzhardinge <jeremy@goop.org> writes:

> Eric W. Biederman wrote:
>> So conceptually I think the concept makes sense but implementation
>> wise I think what is currently present is totally ridiculous.
>
> I tend to agree. For Xen I added smp_ops as an adjunct to paravirt_ops,
> which is basically the interface defined in linux/smp.h:
>
> struct smp_ops
> {
> 	void (*smp_prepare_boot_cpu)(void);
> 	void (*smp_prepare_cpus)(unsigned max_cpus);
> 	int (*cpu_up)(unsigned cpu);
> 	void (*smp_cpus_done)(unsigned max_cpus);
>
> 	void (*smp_send_stop)(void);
> 	void (*smp_send_reschedule)(int cpu);
> 	int (*smp_call_function_mask)(cpumask_t mask,
> 				      void (*func)(void *info), void *info,
> 				      int wait);
> };

That may work but at first glance that feels a little to high level,
and a little lacking.

What I am certain of is that we need a general ability to send
inter processor interrupts.  Beyond that I haven't looked closely
yet.

> This is a fairly close match to Xen's requirements. Certainly, anything
> APIC-related is useless for us, since there's no APIC emulation going on.

I almost agree.  Real hardware in a paravirtualized setting is
something we have to deal with.  This means while we may not have to
deal with APICs we do have to deal with irqs from real hardware,
and there are a lot of implications there.

Partly I suspect you haven't been getting some of the review you could
have because arch/i386 is not that interesting right now.  arch/x86_64
is where the code is generally clean, and new hardware support work
tends to focus.

> I won't speak for Zach, but his counter-argument is generally along the
> lines of "we can just make use of the existing code with a couple of
> little hooks near the bottom". But I wonder if the existing genapic
> interface can be used (or extended) to cover these cases without having
> needing to have APIC-level interfaces in paravirt_ops.

Things need to be abstracted properly.  Not to high or we don't share
what should be common.  Not to low or we place the hooks in the wrong
location and we have a voyager on steroids problem.

A big part of my problem with the startup_ipi_hook is that I am not
convinced we were passing it the proper parameters.  We care about
some of the work that head.S does and that was just cavalierly
bypassing it.  Maintenance wise it looked as easy to maintain as
voyager is today (way to easy to overlook).

If you are going to feed a function start function and start stack
you hook in where we are feeding the kernel start function and start
stack.

> Are you reviewing -mm? That's basically OK, but there's newer stuff in
> Andi's patch queue.

I wasn't even trying to review anything.  Since I was touching some stuff
in the general area while I was in there I was hoping to clean up
arch/i386/head.S.  It looks like there is currently too much other
activity to do this easily.

What you have are what I stumbled onto.  I figured it best if I took
a few minutes spoke up, and mentioned what I saw.

Eric
