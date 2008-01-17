From: Anthony Liguori <anthony@codemonkey.ws>
Subject: Re: [kvm-devel] [PATCH] KVM simplified virtio balloon driver
Date: Wed, 16 Jan 2008 22:01:46 -0600
Message-ID: <478ED32A.1060803__36524.263295769$1200542618$gmane$org@codemonkey.ws>
References: <20080114200357.GA18354@dmt>
	<200801171245.59510.rusty@rustcorp.com.au>
	<478EBA22.30301@codemonkey.ws>
	<200801171429.32888.rusty@rustcorp.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <200801171429.32888.rusty@rustcorp.com.au>
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
Cc: Marcelo Tosatti <marcelo@kvack.org>, kvm-devel <kvm-devel@lists.sourceforge.net>, David Miller <davem@davemloft.net>, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

Rusty Russell wrote:
> On Thursday 17 January 2008 13:14:58 Anthony Liguori wrote:
>   
>> Rusty Russell wrote:
>>     
>>> +static struct virtio_device_id id_table[] = {
>>> +	{ VIRTIO_ID_BALLOON, VIRTIO_DEV_ANY_ID},
>>>       
>> Could use a space after VIRTIO_DEV_ANY_ID
>>     
>
> Thanks, fixed.
>
>   
>>> +		__free_page(page);
>>> +		vb->num_pages--;
>>> +		totalram_pages++;
>>>       
>> Do we really want to modify totalram_pages in this driver?  The only
>> other place that I see that modifies it is in mm/memory_hotplug and it
>> also modifies other things (like num_physpages).  The cmm driver doesn't
>> touch totalram_pages.
>>     
>
> I don't think there's a standard here, they're all ad-hoc (eg. no locking)  
> Modifying totalram_pages has the nice effect of showing up in "free" in the 
> guest.
>
> We should probably not modify num_physpages, because some places seem to use 
> it as an address space limit.  But we should probably fix all those 
> networking size heuristics to use totalram_pages instead of num_physpages.
>
>   
>> It would be very useful too to write vb->num_pages into the config space
>> whenever it was updated.  This way, the host can easily keep track of
>> where the guest is at in terms of ballooning.
>>     
>
> OTOH it's currently pretty obvious (and usually fatal) if the guest has 
> trouble meeting the balloon requirements.  A serious host needs a way of 
> detecting stress in the guest anyway, which this doesn't offer until it's too 
> late...
>   

The question I'm interested in answering though is not if but when.  I 
would like to know when the guest has reached it's target.

And while we do get the madvise call outs, it's possible that pages have 
been faulted in since then.

Regards,

Anthony Liguori

> Rusty.
>   
