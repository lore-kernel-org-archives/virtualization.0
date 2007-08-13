From: Avi Kivity <avi@qumranet.com>
Subject: Re: [kvm-devel] [PATCH 0/2][KVM] guest time accounting
Date: Mon, 13 Aug 2007 17:19:49 +0300
Message-ID: <46C06885.3020908__14525.0801499516$1187015112$gmane$org@qumranet.com>
References: <46BC8B39.6050202@bull.net> <46C00FC1.1070306@qumranet.com>
	<46C012A8.2040908@bull.net>
	<200708131615.42643.borntraeger@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <200708131615.42643.borntraeger@de.ibm.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: kvm-devel@lists.sourceforge.net, Laurent Vivier <Laurent.Vivier@bull.net>, cotte@de.ibm.com, linux-kernel <linux-kernel@vger.kernel.org>, virtualization <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

Christian Borntraeger wrote:
> Am Montag, 13. August 2007 schrieb Laurent Vivier:
>   
>>> [copying Ingo and Rusty]
>>>       
>
> @Avi, seems that sourceforge is mangling the cc list?
>
>   

It's not configured to do so.  Can you be more specific?


>>> The patches look good.  A couple of comments:
>>>
>>> - perhaps the new fields should be guarded by a #ifdef CONFIG_HYPERVISOR
>>> (selected by CONFIG_KVM)?  that way the (minor) additional overhead is
>>> only incurred if it can possibly be used.  I imagine that our canine
>>> cousin will want to use this as well.
>>>       
>> There is also a CONFIG_VIRTUALIZATION and a CONFIG_VIRT_CPU_ACCOUNTING (from
>> s390 and powerpc) Which one to use ?
>>     
>
> CONFIG_VIRT_CPU_ACCOUNTING is used for the precise accouting of user,system, 
> steal and irq time on these platforms and is not what you want for the on/off 
> decision. 
>   

Ah, ok.

>> I'm wondering if we can have a more accurate accounting:
>>
>> - For the moment we add all system time since the previous entering to the
>> VCPU to the guest time (and I guess there is some real system time in
>> it ???) 
>> - Perhaps we can sum nanoseconds spent in the VCPU and add it to cpustat
>> when these ns are greater than 1 ms ? (I'm trying to make something in this 
>>     
> way)
>
> If you look at the patch I have posted some minutes ago, I use a method 
> similar to irq_enter and irq_exit to separate real system time from guest 
> time. 

Yes.  This is orthogonal to the current accounting patch and should make 
a nice extension.  It's probably useful with dynamic tick where timer 
interrupts can be rare.


-- 
error compiling committee.c: too many arguments to function
