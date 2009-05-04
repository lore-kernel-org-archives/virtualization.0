From: Avi Kivity <avi@redhat.com>
Subject: Re: [PATCH RFC 0/8] virtio: add guest MSI-X support
Date: Mon, 04 May 2009 12:21:28 +0300
Message-ID: <49FEB398.4020906__6206.70391149378$1241429047$gmane$org@redhat.com>
References: <20090427123136.GA1152@redhat.com>
	<200904271600.30599.borntraeger@de.ibm.com>
	<49F5CA08.6060003@redhat.com> <20090427153936.GA2276@redhat.com>
	<49F6A672.8050704@redhat.com> <20090428174152.GA7604@redhat.com>
	<49F7420C.5070505@redhat.com> <20090428180248.GB7604@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20090428180248.GB7604@redhat.com>
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
Cc: Christian Borntraeger <borntraeger@de.ibm.com>, kvm@vger.kernel.org, Anthony Liguori <anthony@codemonkey.ws>, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

Michael S. Tsirkin wrote:
>>> So what I see is transports providing something like:
>>>
>>> struct virtio_interrupt_mapping {
>>> 	int virtqueue;
>>> 	int interrupt;
>>> };
>>>
>>> map_vqs_to_interrupt(dev, struct virtio_interrupt_mapping *, int nvirtqueues);
>>> unmap_vqs(dev);
>>>   
>>>       
>> Isn't that the same thing?  Please explain the flow.
>>     
>
> So to map vq 0 to vector 0, vq 1 to vector 1 and vq 2 to vector 2 the driver would do:
>
> struct virtio_interrupt_mapping mapping[3] = { {0, 0}, {1, 1}, {2, 2} };
> vec = map_vqs_to_interrupt(dev, mapping, 3);
> if (vec) {
>   error handling
> }
>
> and then find_vq as usual.
>   

Yes, that works.

Given that pci_enable_msix() can fail, we can put the retry loop in 
virtio-pci, and instead of a static mapping, supply a dynamic mapping:

    static void get_vq_interrupt(..., int nr_interrupts, int vq)
    {
        /* reserve interrupt 0 to config changes; round-robin vqs to 
interrupts */
        return 1 + (vq % (nr_interrupts - 1));
    }

    driver_init()
    {
        map_vqs_to_interrupt(dev, get_vq_interrupt);
    }

map_vqs_to_interrupts() would call get_vq_interrupt() for each vq, 
assuming the maximum nr_interrupts, and retry with smaller nr_interrupts 
on failure.

-- 
Do not meddle in the internals of kernels, for they are subtle and quick to panic.
