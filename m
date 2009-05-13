From: Avi Kivity <avi@redhat.com>
Subject: Re: [PATCH RFC 0/2] qemu-kvm: MSI-X support
Date: Wed, 13 May 2009 10:17:17 +0300
Message-ID: <4A0A73FD.4030002@redhat.com>
References: <20090511221350.GA22776@redhat.com>
	<4A08A599.1070708@codemonkey.ws>
	<20090512134521.GC23796@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20090512134521.GC23796@redhat.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Carsten Otte <cotte@de.ibm.com>, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org, Christian Borntraeger <borntraeger@de.ibm.com>, Anthony Liguori <anthony@codemonkey.ws>
List-Id: virtualization@lists.linuxfoundation.org

Michael S. Tsirkin wrote:
> It seems that if I just call apic_deliver_irq each time
> I want to send MSI, things will work.
>
> However, large part of the msix code is managing IRQs versus kernel,
> and I'm not sure it's a wise investment of effort to rip it all out. So
> IMHO, what's missing is API that abstracts managing irq routes in kvm,
> specifically abstract this stuff in some way:
> 	kvm_get_irq_route_gsi
> 	kvm_add_routing_entry
> 	kvm_del_routing_entry
> 	kvm_commit_irq_routes
>   

All these are just games with qemu_irq objects.  Should be a lot simpler 
in userspace.


> 	kvm_set_irq
>   

qemu_set_irq().

> How hard is that?
>   

Should be pretty easy, once you get the hang of qemu_irq.

> For now, this API could be a stub that just stores the routes somewhere,
> and set_irq would call the local apic emulation, along the lines of:
>
> 	uint8_t dest = (addr_lo & MSI_ADDR_DEST_ID_MASK)
> 		>> MSI_ADDR_DEST_ID_SHIFT;
> 	uint8_t vector = (addr_hi & MSI_DATA_VECTOR_MASK)
> 		>> MSI_DATA_VECTOR_SHIFT;
> 	uint8_t dest_mode = (addr_lo >> MSI_ADDR_DEST_MODE_SHIFT) & 0x1;
> 	uint8_t trigger_mode = (data >> MSI_DATA_TRIGGER_SHIFT) & 0x1;
> 	uint8_t delivery_mode = (data >> MSI_DATA_DELIVERY_MODE_SHIFT) &
> 		0x7;
> 	apic_deliver_irq(dest, dest_mode, delivery_mode, vector, 0,
> 			 trigger_mode);
>   

qemu_set_irq() eventually calls a callback that you specify; just set it 
do look up the entry and call apic_deliver_irq.

-- 
Do not meddle in the internals of kernels, for they are subtle and quick to panic.
