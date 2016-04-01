From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v3 5/6] virt, sched: add cpu pinning to
	smp_call_sync_on_phys_cpu()
Date: Fri, 1 Apr 2016 10:44:08 +0200
Message-ID: <20160401084408.GF3448@twins.programming.kicks-ass.net>
References: <1459494874-12194-1-git-send-email-jgross@suse.com>
	<1459494874-12194-6-git-send-email-jgross@suse.com>
	<20160401074325.GC12845@twins.programming.kicks-ass.net>
	<56FE313E.9060804@suse.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <56FE313E.9060804@suse.com>
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
Cc: x86@kernel.org, jeremy@goop.org, jdelvare@suse.com, konrad.wilk@oracle.com, hpa@zytor.com, akataria@vmware.com, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, chrisw@sous-sol.org, mingo@redhat.com, david.vrabel@citrix.com, Douglas_Warzecha@dell.com, pali.rohar@gmail.com, xen-devel@lists.xenproject.org, boris.ostrovsky@oracle.com, tglx@linutronix.de, linux@roeck-us.net
List-Id: virtualization@lists.linuxfoundation.org

On Fri, Apr 01, 2016 at 10:28:46AM +0200, Juergen Gross wrote:
> On 01/04/16 09:43, Peter Zijlstra wrote:
> > On Fri, Apr 01, 2016 at 09:14:33AM +0200, Juergen Gross wrote:
> >> --- a/kernel/smp.c
> >> +++ b/kernel/smp.c
> >> @@ -14,6 +14,7 @@
> >>  #include <linux/smp.h>
> >>  #include <linux/cpu.h>
> >>  #include <linux/sched.h>
> >> +#include <linux/hypervisor.h>
> >>  
> >>  #include "smpboot.h"
> >>  
> >> @@ -758,9 +759,14 @@ struct smp_sync_call_struct {
> >>  static void smp_call_sync_callback(struct work_struct *work)
> >>  {
> >>  	struct smp_sync_call_struct *sscs;
> >> +	unsigned int cpu;
> >>  
> >>  	sscs = container_of(work, struct smp_sync_call_struct, work);
> >> +	cpu = get_cpu();
> >> +	hypervisor_pin_vcpu(cpu);
> >>  	sscs->ret = sscs->func(sscs->data);
> >> +	hypervisor_pin_vcpu(-1);
> >> +	put_cpu();
> >>  
> >>  	complete(&sscs->done);
> >>  }
> > 
> > So I don't really like this; it adds the requirement that the function
> > cannot schedule, which greatly limits the utility of the construct. At
> > this point you might as well use the regular IPI stuff.
> 
> Main reason for disabling preemption was to avoid any suspend/resume
> cycles while vcpu pinning is active.
> 
> With the switch to workqueues this might not be necessary, if I've read
> try_to_freeze_tasks() correctly. Can you confirm, please?

This is not something we should worry about; the caller should ensure
the CPU stays valid; typically I would expect a caller to do
get_online_cpus() before 'computing' what CPU to send the function to.

> > So I would propose you add:
> > 
> > 	smp_call_on_cpu()
> > 
> > As per patch 2. No promises about physical or anything. This means it
> > can be used freely by anyone that wants to run a function on another
> > cpu -- a much more useful thing.
> 
> Okay.
> 
> > And then build a phys variant on top.
> 
> Hmm, I'm not sure I understand what you are suggesting here.
> 
> Should this phys variant make use of smp_call_on_cpu() via an
> intermediate function called on the dedicated cpu which is doing the
> pinning and calling the user function then?
> 
> Or do you want the phys variant to either use smp_call_on_cpu() or to
> do the pinning and call the user function by itself depending on the
> environment (pinning supported)?

Yeah, uhmm.. not sure on the details; my brain is having a hard time
engaging this morning.

Maybe just make the vpin thing an option like:

	smp_call_on_cpu(int (*func)(void *), int phys_cpu);

Also; is something like the vpin thing possible on KVM? because if we're
going to expose it to generic code like this we had maybe look at wider
support.
