From: Jeremy Fitzhardinge <jeremy-TSDbQ3PG+2Y@public.gmane.org>
Subject: Re: [PATCH 5/5] KVM: paravirt time source
Date: Mon, 18 Jun 2007 16:56:16 -0700
Message-ID: <46771BA0.2000308@goop.org>
References: <4675F462.1010708@codemonkey.ws> <4675F601.3090706@codemonkey.ws>
	<4676D8E4.3020806@goop.org> <4676FEB9.6060308@codemonkey.ws>
	<46770162.6030101@goop.org> <4677163F.2030308@codemonkey.ws>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <kvm-devel-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <4677163F.2030308-rdkfGonbjUSkNkDKm+mE6A@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/kvm-devel>,
	<mailto:kvm-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=kvm-devel>
List-Post: <mailto:kvm-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:kvm-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/kvm-devel>,
	<mailto:kvm-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Sender: kvm-devel-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: kvm-devel-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
To: Anthony Liguori <anthony-rdkfGonbjUSkNkDKm+mE6A@public.gmane.org>
Cc: kvm-devel <kvm-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>, virtualization <virtualization-qjLDD68F18O7TbgM5vRIOg@public.gmane.org>
List-Id: virtualization@lists.linuxfoundation.org

Anthony Liguori wrote:
> Jeremy Fitzhardinge wrote:
>> Anthony Liguori wrote:
>>  
>>> Okay.  I may remove this patch from the patch series and attempt to
>>> sit down next week and work out something more complete that also
>>> implements stolen time accounting.
>>>     
>>
>> Well, that's a separate problem.  clocksource.read should always return
>> real time passed, so stolen time doesn't come into it.
>
> Right.
>
>>  
>> paravirt_ops.sched_clock should take stolen time into account, but
>> that's almost completely orthogonal.
>>   
>
> Except that I wanted to change the hypercall to allow querying of real
> time or "available" time as VMI puts it.

I see.  You could have an interface like Xen's runstate interface, which
gives you a breakdown of how long each vcpu spends in each state
(running, runnable, paused or blocked).  The sum of all of them gives
you real time, or you can use a subset to work out stolen time
(runnable+paused), busyness (blocked / (running+runnable+blocked)), etc.

> Right now, I'm relying on the PIT but it would be nice to eliminate
> that.  I'd like to move to something PV so that I can make use of
> tickless guest kernels.  I'm very open to suggestion and even more
> open to reusing other people's code :-)

A simple hypercall interface which says "raise irq X after N ns" is
probably the easiest way to go.  Try to avoid the pitfalls of VMI's
interface in this area, which tries to recycle existing architectural
interrupt sources for hypervisor timers, and gets into a bit of mess. 
Xen is relatively clean, but I'm not sure how it would fit into the
mostly-emulated kvm model.  If you keep things simple, most of the Xen
clockevent code could be reused with little change.

    J

-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
