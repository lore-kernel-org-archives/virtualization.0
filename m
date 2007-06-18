From: Anthony Liguori <anthony-rdkfGonbjUSkNkDKm+mE6A@public.gmane.org>
Subject: Re: [PATCH 4/5] KVM: Add hypercall queue for
	paravirt_ops implementation
Date: Mon, 18 Jun 2007 07:40:39 -0500
Message-ID: <46767D47.1010104@codemonkey.ws>
References: <4675F462.1010708@codemonkey.ws> <4675F568.90608@codemonkey.ws>
	<46764B47.5060403@qumranet.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <kvm-devel-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <46764B47.5060403-atKUWr5tajBWk0Htik3J/w@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/kvm-devel>,
	<mailto:kvm-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=kvm-devel>
List-Post: <mailto:kvm-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:kvm-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/kvm-devel>,
	<mailto:kvm-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Sender: kvm-devel-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: kvm-devel-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
To: Avi Kivity <avi-atKUWr5tajBWk0Htik3J/w@public.gmane.org>
Cc: kvm-devel <kvm-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>, virtualization <virtualization-qjLDD68F18O7TbgM5vRIOg@public.gmane.org>
List-Id: virtualization@lists.linuxfoundation.org

Avi Kivity wrote:
> Anthony Liguori wrote:
>
>> Implemented a hypercall queue that can be used when paravirt_ops lazy 
>> mode
>> is enabled.  This patch enables queueing of MMU write operations and CR
>> updates.  This results in about a 50% bump in kernbench performance.
>>   
>
> Nice!  But 50%? a kernel build is at native-25%, so we're now 25% 
> faster than native?

Well, I haven't measured KVM to be 25% of native with kernbench :-)  On 
my LS21 (AMD), I get:

KVM
Elapsed Time 1054.39 (25.8237)
User Time 371.844 (8.57204)
System Time 682.61 (17.7778)
Percent CPU 99.8 (0.447214)  
Sleeps 50115 (475.693)

KVM PV
Elapsed Time 595.85 (13.7058)
User Time 360.99 (9.56093)
System Time 234.704 (4.21283)
Percent CPU 99 (0)
Context Switches 46989.8 (328.277)
Sleep 47882.8 (242.583)

NATIVE
Elapsed Time 328.602 (0.212415)
User Time 304.364 (0.353171)
System Time 23.99 (0.325192)
Percent CPU 99 (0)
Context Switches 39785.2 (159.796)
Sleeps 46398.6 (311.466)

With Intel, we're still only about 60% of native to start out with.  The 
PV patches take us to about 72%.

>> +    state->vmca->queue_gpa = __pa(state->queue);
>> +    state->vmca->max_queue_index
>> +        = (PAGE_SIZE / sizeof(struct kvm_hypercall_entry));
>>  
>
> Why not pass the queue address as an argument to KVM_HYPERCALL_FLUSH?  
> That reduces the amount of setup, and allows more flexibility (e.g. 
> multiple queues).

I agree.  I had that at first and then changed it to not take the queue 
address.  I'll change it for the next rev.

> I'm not thrilled with having queues of hypercalls; instead  I'd prefer 
> queues of mmu operations, but I guess it won't do any good to go 
> against prevailing custom here.

lguest uses a hypercall queue and I figured that puppies were never a 
bad thing :-)

Having multiple queues would get pretty ugly.  We're still pretty slow 
on context-switch some I'm hoping that we can more aggressive queuing wise.

Regards,

Anthony Liguori


-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
