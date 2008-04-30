From: Muli Ben-Yehuda <muli@il.ibm.com>
Subject: Re: [PATCH] KVM x86: Handle hypercalls for assigned PCI devices
Date: Wed, 30 Apr 2008 09:05:13 +0300
Message-ID: <20080430060513.GB7378__7207.53333666853$1209535586$gmane$org@il.ibm.com>
References: <1209465451-3758-1-git-send-email-amit.shah@qumranet.com>
	<1209465451-3758-3-git-send-email-amit.shah@qumranet.com>
	<48173440.304@redhat.com>
	<200804292128.52268.amit.shah@qumranet.com>
	<4817A5C6.7070704@qumranet.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <4817A5C6.7070704@qumranet.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Avi Kivity <avi@qumranet.com>
Cc: chrisw@redhat.com, kvm-devel@lists.sourceforge.net, allen.m.kay@intel.com, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, Glauber Costa <gcosta@redhat.com>, Ben-Ami Yassour1 <BENAMI@il.ibm.com>
List-Id: virtualization@lists.linuxfoundation.org

On Wed, Apr 30, 2008 at 01:48:38AM +0300, Avi Kivity wrote:
> Amit Shah wrote:
>>
>>>> +	if (is_error_page(host_page)) {
>>>> +		printk(KERN_INFO "%s: gfn %p not valid\n",
>>>> +		       __func__, (void *)page_gfn);
>>>> +		r = -1;
>>>>       
>>> r = -1 is not really informative. Better use some meaningful error.
>>>     
>>
>> The error's going to the guest. The guest, as we know, has already
>> done a successful DMA allocation. Something went wrong in the
>> hypercall, and we don't know why (bad page). Any kind of error here
>> isn't going to be intelligible to the guest anyway. It's mostly a
>> host thing if we ever hit this.
>>   
>
> If the guest is not able to handle it, why bother returning an
> error?  Better to kill it.
>
> But in any case, -1 is not a good error number.

The guest should be able to deal with transient DMA mapping errors,
either by retrying, or quiescing the device. This is in line with how
HW IOMMUs work - they may run out of mappings for example and the
driver should be able to cope with it. Killing the guest is a last
resort.

Cheers,
Muli
