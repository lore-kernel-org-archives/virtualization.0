From: Anthony Liguori <anthony-rdkfGonbjUSkNkDKm+mE6A@public.gmane.org>
Subject: Re: [PATCH 0/5] KVM paravirt_ops backend (v3)
Date: Thu, 21 Jun 2007 08:19:31 -0500
Message-ID: <467A7AE3.505@codemonkey.ws>
References: <4679EAAF.2060103@codemonkey.ws> <467A4280.9060503@qumranet.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <kvm-devel-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <467A4280.9060503-atKUWr5tajBWk0Htik3J/w@public.gmane.org>
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
>> Hi,
>>
>> This is an update to the paravirt_ops KVM backend series.  I've made 
>> a number of changes and attempted to incorporate all the feedback 
>> from the last review.  Some highlights:
>>
>> 1) Clean up the paravirt time source patch to use a more Xen-like model
>> 2) Change the hypercall queueing to pass a PA on the flush hypercall
>> 3) Add MMU support for release_{pt,pd} and TLB flush
>> 4) Use KVM specific errno values
>> 5) Switch from per_cpu to more appropriate functions
>>
>> As for performance, I've got a few interesting results.  kbuild with 
>> a guest using 2G of memory goes from 19 minutes to 12 minutes with 
>> the full series applied.  Using 512mb, the build time goes from 10.75 
>> minutes to 9 minutes.  For 512mb, native is around 7 minutes so 
>> that's pretty close to what Avi had seen.  The more dramatic 
>> improvement with large memory guests is probably because of the 
>> increased shadow page table activity due to high mem.
>
> Ah, that explains why we were getting such different results.  My 
> tests were on x86-64.
>
>>
>> virtbench shows major improvements but I'm not 100% confident yet in 
>> the results as they are not very stable.  I don't yet have a 
>> benchmark that shows the benefit of the CR caching so if I don't find 
>> one, I'll drop that from the queue.
>>
>
> The only barrier to merging is that we're introducing yet another 
> stable ABI.  Since we can turn off things that turn out not so good 
> later, and expect the guest to survive, I'm not to worried, so I'm 
> inclined to merge this.

Some unsigned longs are in kvm_para.h so x86_64 won't work ATM as a 
host.  I'll fix that and do proper testing on a 64 bit host for the next 
posting (along with save/restore support).

Regards,

Anthony Liguori


-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
