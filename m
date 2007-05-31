From: Anthony Liguori <anthony@codemonkey.ws>
Subject: Re: [kvm-devel] [PATCH 1/3] KVM paravirt_ops infrastructure
Date: Wed, 30 May 2007 20:15:33 -0500
Message-ID: <465E21B5.1090605@codemonkey.ws>
References: <465D8F03.7000201@us.ibm.com> <465D8FA7.9050600@us.ibm.com>
	<1180573347.30202.135.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1180573347.30202.135.camel@localhost.localdomain>
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
Cc: kvm-devel <kvm-devel@lists.sourceforge.net>, virtualization <virtualization@lists.osdl.org>, Anthony Liguori <aliguori@us.ibm.com>
List-Id: virtualization@lists.linuxfoundation.org

Rusty Russell wrote:
> On Wed, 2007-05-30 at 09:52 -0500, Anthony Liguori wrote:
>   
>> This patch adds the basic infrastructure for paravirtualizing a KVM
>> guest.
>>     
>
> Hi Anthony!
>
> 	Nice patch, comments below.
>
>   
>> Discovery of running under KVM is done by sharing a page of memory
>> between
>> the guest and host (initially through an MSR write).
>>     
>
> I missed the shared page in this patch?  If you are going to do that,
> perhaps putting the hypercall magic in that page is a good idea?
>   

para_state is the shared page.  The address is passed to the KVM via the 
MSR (so it's a shared page owned by the guest).

>> +extern unsigned char hypercall_addr[4];
>>     
>
> Perhaps in a header?
>
>   
>> +asm (
>> +       ".globl hypercall_addr\n"
>> +       ".align 4\n"
>> +       "hypercall_addr:\n"
>> +       "movl $-38, %eax\n"
>> +       "ret\n"
>> +);
>>     
>
> I don't think we want the hypercall returning Linux error numbers, and
> magic numbers are bad too.  ud2 here I think.
>   

Yeah, you're not the first one to suggest this.  The thing is, KVM 
already has host-side support for a hypercall API.  I didn't want to 
change that unless I had to.  However, based on the prior feedback re: 
using CPUID, I will be changing it so I'll update this too.

>> +       para_state->guest_version = KVM_PARA_API_VERSION;
>> +       para_state->host_version = -1;
>> +       para_state->size = sizeof(*para_state);
>> +       para_state->ret = 0;
>> +       para_state->hypercall_gpa = __pa(hypercall_addr);
>>     
>
> Two versions, size *and* ret?  This seems like overkill...
>   

Yeah, I agree :-)  I actually am not a huge fan of using version 
numbers.  I think I'm going to try the next patch using a single version 
number and a feature bitmap.  Some of the optimizations (like MMU 
batching) don't make sense in a NPT/EPT environment but the guest 
shouldn't have to be aware of that.

>> +       if (wrmsr_safe(MSR_KVM_API_MAGIC, __pa(para_state), 0)) {
>> +               printk(KERN_INFO "KVM guest: WRMSR probe failed.\n");
>> +               return -ENOENT;
>> +       }
>>     
>
> How about printk(KERN_INFO "I am not a KVM guest\n");?
>
>   
>> +static int __init kvm_guest_init(void)
>> +{
>> +       int rc;
>> +
>> +       rc = kvm_guest_register_para(smp_processor_id());
>> +       if (rc) {
>> +               printk(KERN_INFO "paravirt KVM unavailable\n");
>>     
>
> Double-printk when KVM isn't detected seems overkill.  Perhaps you could
> just fold this all into one function...
>   

Already have.

> (Personal gripe: I consider a variable named "rc" to be an admission of
> semantic defeat... "err" would be better here...)
>   

I'm not sure I agree that's one's better than the other.  Although I 
guess if (err) { reads a little better...

Regards,

Anthony Liguori

> Thanks!
> Rusty.
>
>
> -------------------------------------------------------------------------
> This SF.net email is sponsored by DB2 Express
> Download DB2 Express C - the FREE version of DB2 express and take
> control of your XML. No limits. Just data. Click to get it now.
> http://sourceforge.net/powerbar/db2/
> _______________________________________________
> kvm-devel mailing list
> kvm-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/kvm-devel
>
>   
