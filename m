From: Anthony Liguori <aliguori@us.ibm.com>
Subject: Re: [PATCH] KVM simplified virtio balloon driver
Date: Thu, 17 Jan 2008 07:56:21 -0600
Message-ID: <478F5E85.9020009@us.ibm.com>
References: <20080114200357.GA18354@dmt>
	<1200525166.26281.103.camel@localhost.localdomain>
	<200801171245.59510.rusty@rustcorp.com.au>
	<200801171032.26198.borntraeger@de.ibm.com>
	<1200565558.22385.13.camel@localhost>
	<1200570025.26281.141.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1200570025.26281.141.camel@localhost.localdomain>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: dor.laor@qumranet.com
Cc: Marcelo Tosatti <marcelo@kvack.org>, virtualization@lists.linux-foundation.org, Christian Borntraeger <borntraeger@de.ibm.com>, schwidefsky@de.ibm.com, kvm-devel <kvm-devel@lists.sourceforge.net>
List-Id: virtualization@lists.linuxfoundation.org

Dor Laor wrote:
> On Thu, 2008-01-17 at 11:25 +0100, Martin Schwidefsky wrote:
>   
>>> Another idea: Martin added an oom notifier to the cmm driver. Before the 
>>> oom-killer kicks in cmm will try to free 256 pages. I think your virtio 
>>> balloon driver should do the same - it seems to be the correct tradeoff. 
>>>       
>> Nod, you definitly want to add an oom notifier. If 256 pages is the
>> correct number of pages to free is debatable. We have seen long delays
>> for a process that quickly eats up memory if there are lots of pages in
>> the balloon. The problem is that the memory management tries hard to
>> find memory until it decides to oom kill a process, only to be stopped
>> in the last second by the oom notifier. The 1MB is quickly eaten up
>> again so the whole things starts again. The profile of such a scenario
>> shows that almost all cpu is burned in the page reclaim code.
>>
>>     
>
> Seconded, in that case we can add a config space notification from the
> guest to the host that will be triggered by the oom.
> The host will get this notification and will decide whether to allow the
> guest to deflate the balloon or to keep the current balloon size because
> the whole host is over committed.
>   

The host doesn't decide whether to allow the guest to deflate.  Virtual 
memory size and resident memory side are independent in KVM.  The host 
decides what the RSS is but the guest is free to determine it's VSS.  
The host provides hints to the guest about it's RSS size (via 
ballooning) so the guest can optimize it's VSS size.  If guest chooses 
to make it's VSS size to large, it will only hurt itself (by being 
forced to swap by the host).

Regards,

Anthony Liguori

> Regards,
> Dor.
>
>   
