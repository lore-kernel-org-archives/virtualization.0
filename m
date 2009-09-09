From: Anthony Liguori <anthony@codemonkey.ws>
Subject: Re: [PATCH] SCSI driver for VMware's virtual HBA - V4.
Date: Wed, 09 Sep 2009 18:34:32 -0500
Message-ID: <4AA83B88.2020104__45652.8364601128$1252539406$gmane$org@codemonkey.ws>
References: <1252458903.24914.73.camel@ank32.eng.vmware.com>
	<4AA8177A.2020606@codemonkey.ws>
	<1252533093.24633.40.camel@ank32.eng.vmware.com>
	<4AA8284A.3010908@codemonkey.ws>
	<20090909230854.GA4495@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20090909230854.GA4495@infradead.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Christoph Hellwig <hch@infradead.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>, "pv-drivers@vmware.com" <pv-drivers@vmware.com>, LKML <linux-kernel@vger.kernel.org>, virtualization <virtualization@lists.linux-foundation.org>, "Chetan.Loke@Emulex.Com" <Chetan.Loke@Emulex.Com>, James Bottomley <James.Bottomley@suse.de>, akataria@vmware.com, Rolf Eike Beer <eike-kernel@sf-tec.de>
List-Id: virtualization@lists.linuxfoundation.org

Christoph Hellwig wrote:
> On Wed, Sep 09, 2009 at 05:12:26PM -0500, Anthony Liguori wrote:
>   
>> Alok Kataria wrote:
>>     
>>> I see your point, but the ring logic or the ABI that we use to
>>> communicate between the hypervisor and guest is not shared between our
>>> storage and network drivers. As a result, I don't see any benefit of
>>> separating out this ring handling mechanism, on the contrary it might
>>> just add some overhead of translating between various layers for our
>>> SCSI driver.
>>>   
>>>       
>> But if you separate out the ring logic, it allows the scsi logic to be  
>> shared by other paravirtual device drivers.  This is significant and  
>> important from a Linux point of view.
>>     
>
> As someone who has been hacking on a virtio scsi prototype I don't think
> it's a good idea.  The vmware driver is a horrible design and I don't
> think it should be merged.

What are the issues with the design compared to how you're approaching 
virtio-scsi?

>   Besides beeing a ugly driver and ABI we
> really should not support this kind of closed protocol development.
>   

I don't see how a VMM that doesn't share the source code for it's 
backends or doesn't implement standard ABIs is any different than the 
hundreds of hardware vendors that behave exactly the same way.

We haven't even been successful in getting the Xen folks to present 
their work on lkml before shipping it to their users.  Why would we 
expect more from VMware if we're willing to merge the Xen stuff?

Regards,

Anthony Liguori
