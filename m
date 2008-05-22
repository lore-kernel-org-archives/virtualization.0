From: Gerd Hoffmann <kraxel@redhat.com>
Subject: Re: [PATCH 1/4] Add helper functions for paravirtual clocksources.
Date: Thu, 22 May 2008 11:32:36 +0200
Message-ID: <48353DB4.1020303@redhat.com>
References: <1210924885-5353-1-git-send-email-kraxel@redhat.com>
	<1210924885-5353-2-git-send-email-kraxel@redhat.com>
	<4834A630.7060208@goop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <4834A630.7060208@goop.org>
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
Cc: kvm-devel@lists.sourceforge.net, virtualization@lists.osdl.org
List-Id: virtualization@lists.linuxfoundation.org

Jeremy Fitzhardinge wrote:

>> +static unsigned pvclock_get_time_values(struct pvclock_shadow_time *dst,
>> +                    struct kvm_vcpu_time_info *src)
>>   
> 
> I think the kvm_* types should be renamed.  xen_* would make some sense
> since the ABI originated with Xen, but something generic would be OK
> too.  The important thing to get across is that the structure defines a
> guest<->host ABI which happens to be shared by Xen and KVM, and it isn't
> an in-kernel API like the rest of paravirt_ops.

Fine with me, but see below.

> And having defined a common structure, we may as well use it in the
> hypervisor-specific code/headers so there's no strange casting going on.

Hmm, what is the state of include/xen/interface/?  It is a straight copy
of the xen public header files, right?  Is it really ok to modify them?
 We have to do that to make the cast actually go away ...

>> +/*
>> + * This is our read_clock function. The host puts an tsc timestamp
>> each time
>> + * it updates a new time. Without the tsc adjustment, we can have a
>> situation
>> + * in which a vcpu starts to run earlier (smaller system_time), but
>> probes
>> + * time later (compared to another vcpu), leading to backwards time
>> + */
>>   
> 
> This comment is confusing.  Are you explaining why the tsc is read
> within the loop?  I think it can be clarified.

This was just copyed over from somewhere else (kvmclock I think).

>> +++ b/include/asm-x86/pvclock.h
>> @@ -0,0 +1,6 @@
>> +#include <linux/clocksource.h>
>> +#include <asm/kvm_para.h>
>> +cycle_t pvclock_clocksource_read(struct kvm_vcpu_time_info *src);
>> +void pvclock_read_wallclock(struct kvm_wall_clock *wall,
>> +                struct kvm_vcpu_time_info *vcpu,
>> +                struct timespec *ts);
>>   
> 
> No #ifdef guards?

Oh yes, I should better add some ...

thanks,
  Gerd

-- 
http://kraxel.fedorapeople.org/xenner/
