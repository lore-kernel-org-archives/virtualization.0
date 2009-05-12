From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH RFC 0/2] qemu-kvm: MSI-X support
Date: Tue, 12 May 2009 16:45:21 +0300
Message-ID: <20090512134521.GC23796__11552.9545037591$1242136071$gmane$org@redhat.com>
References: <20090511221350.GA22776@redhat.com>
	<4A08A599.1070708@codemonkey.ws>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <4A08A599.1070708@codemonkey.ws>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Anthony Liguori <anthony@codemonkey.ws>
Cc: Carsten Otte <cotte@de.ibm.com>, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org, Christian Borntraeger <borntraeger@de.ibm.com>, avi@redhat.com
List-Id: virtualization@lists.linuxfoundation.org

On Mon, May 11, 2009 at 05:24:25PM -0500, Anthony Liguori wrote:
> Michael S. Tsirkin wrote:
>> Here's a draft MSI-X support patch. Among missing features:
>> save/load support, and command-line flag to control the
>> feature. This is on top of qemu-kvm: msi-x is disabled
>> without kvm interrupt injection support for now.
>>   
>
> What's your impression of how much work would be to get this going on  
> top of upstream QEMU?
>
> I'm willing to borrow a few cycles to help out here.  I'd really like to  
> see this series go in via QEMU if possible.

It seems that if I just call apic_deliver_irq each time
I want to send MSI, things will work.

However, large part of the msix code is managing IRQs versus kernel,
and I'm not sure it's a wise investment of effort to rip it all out. So
IMHO, what's missing is API that abstracts managing irq routes in kvm,
specifically abstract this stuff in some way:
	kvm_get_irq_route_gsi
	kvm_add_routing_entry
	kvm_del_routing_entry
	kvm_commit_irq_routes
	kvm_set_irq
How hard is that?

For now, this API could be a stub that just stores the routes somewhere,
and set_irq would call the local apic emulation, along the lines of:

	uint8_t dest = (addr_lo & MSI_ADDR_DEST_ID_MASK)
		>> MSI_ADDR_DEST_ID_SHIFT;
	uint8_t vector = (addr_hi & MSI_DATA_VECTOR_MASK)
		>> MSI_DATA_VECTOR_SHIFT;
	uint8_t dest_mode = (addr_lo >> MSI_ADDR_DEST_MODE_SHIFT) & 0x1;
	uint8_t trigger_mode = (data >> MSI_DATA_TRIGGER_SHIFT) & 0x1;
	uint8_t delivery_mode = (data >> MSI_DATA_DELIVERY_MODE_SHIFT) &
		0x7;
	apic_deliver_irq(dest, dest_mode, delivery_mode, vector, 0,
			 trigger_mode);

I would be happy to port my msix code to work on top of this API.
Willing to help?


-- 
MST
