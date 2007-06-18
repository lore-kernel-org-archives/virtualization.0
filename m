From: Anthony Liguori <anthony-rdkfGonbjUSkNkDKm+mE6A@public.gmane.org>
Subject: Re: [PATCH 3/5] KVM: Add paravirt MMU write support
Date: Mon, 18 Jun 2007 07:33:16 -0500
Message-ID: <46767B8C.9050001@codemonkey.ws>
References: <4675F462.1010708@codemonkey.ws> <4675F533.40809@codemonkey.ws>
	<46764061.9080705@qumranet.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <kvm-devel-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <46764061.9080705-atKUWr5tajBWk0Htik3J/w@public.gmane.org>
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
>> +static int kvm_hypercall_mmu_write(struct kvm_vcpu *vcpu, gva_t addr,
>> +                   unsigned long size, unsigned long a0,
>> +                   unsigned long a1)
>> +{
>> +    gpa_t gpa = vcpu->mmu.gva_to_gpa(vcpu, addr);
>> +    u64 value;
>> +
>> +    if (gpa == UNMAPPED_GVA)
>> +        return -EFAULT;
>> +    if (size == 1) {
>> +        if (!emulator_write_phys(vcpu, gpa, &a0, sizeof(a0)))
>> +            return -EFAULT;
>> +    } else if (size == 2) {
>> +        value = (u64)a1 << 32 | a0;
>> +        if (!emulator_write_phys(vcpu, gpa, &value, sizeof(value)))
>> +            return -EFAULT;
>> +    } else
>> +        return -E2BIG;
>> +
>> +    return 0;
>> +}
>
> Hypercalls should return kvm-specific error codes (defined in 
> include/linux/kvm_para.h), not Linux error codes, as they could be 
> used in operating systems which have different values for E2BIG and 
> friends.

If Linux's errnos are stable, we could just use them and let a non-Linux 
guest define a set of KVM_E2BIG, etc.?  It just seemed pretty ugly to 
add a bunch of these.

>> +static void kvm_pte_clear(struct mm_struct *mm,
>> +              unsigned long addr, pte_t *ptep)
>> +{
>> +    pte_t pte = {0};
>>   
>
> Surely there's a nice macro for creating a pte from an int?

Probably :-)

> Any performance measurement?

Yes, surprisingly enough.  COW faults in virtbench drop by a significant 
amount.  I'll repost each patch with virtbench results.  I suspect that 
the vmmcall path is much faster than a page fault.

Regards,

Anthony Liguori


-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
