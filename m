From: Avi Kivity <avi@qumranet.com>
Subject: Re: [PATCH] KVM x86: Handle hypercalls for assigned PCI devices
Date: Wed, 30 Apr 2008 01:48:38 +0300
Message-ID: <4817A5C6.7070704__13352.913017343$1209509652$gmane$org@qumranet.com>
References: <1209465451-3758-1-git-send-email-amit.shah@qumranet.com>
	<1209465451-3758-3-git-send-email-amit.shah@qumranet.com>
	<48173440.304@redhat.com>
	<200804292128.52268.amit.shah@qumranet.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <200804292128.52268.amit.shah@qumranet.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Amit Shah <amit.shah@qumranet.com>
Cc: chrisw@redhat.com, kvm-devel@lists.sourceforge.net, allen.m.kay@intel.com, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, Glauber Costa <gcosta@redhat.com>, BENAMI@il.ibm.com
List-Id: virtualization@lists.linuxfoundation.org

Amit Shah wrote:
>
>>> +	if (is_error_page(host_page)) {
>>> +		printk(KERN_INFO "%s: gfn %p not valid\n",
>>> +		       __func__, (void *)page_gfn);
>>> +		r = -1;
>>>       
>> r = -1 is not really informative. Better use some meaningful error.
>>     
>
> The error's going to the guest. The guest, as we know, has already done a 
> successful DMA allocation. Something went wrong in the hypercall, and we 
> don't know why (bad page). Any kind of error here isn't going to be 
> intelligible to the guest anyway. It's mostly a host thing if we ever hit 
> this.
>
>   

If the guest is not able to handle it, why bother returning an error?  
Better to kill it.

But in any case, -1 is not a good error number.

>>> +	if (find_pci_pt_dev(&vcpu->kvm->arch.pci_pt_dev_head,
>>> +			    &pci_pt_info, 0, KVM_PT_SOURCE_ASSIGN))
>>> +		r++; /* We have assigned the device */
>>> +
>>> +	kunmap(host_page);
>>>       
>> better use atomic mappings here.
>>     
>
> We can't use atomic mappings for guest pages. They can be swapped out.
>   

kmap()ed pages can't be swapped out either.  The atomic in kmap_atomic() 
only refers to the context in which the pages are used.  Atmoic kmaps 
are greatly preferable to the nonatomic ones.

-- 
Any sufficiently difficult bug is indistinguishable from a feature.
