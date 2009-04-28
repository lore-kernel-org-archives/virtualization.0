From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH RFC 0/8] virtio: add guest MSI-X support
Date: Tue, 28 Apr 2009 21:02:48 +0300
Message-ID: <20090428180248.GB7604__46226.9287709661$1240942399$gmane$org@redhat.com>
References: <20090427123136.GA1152@redhat.com>
	<200904271600.30599.borntraeger@de.ibm.com>
	<49F5CA08.6060003@redhat.com> <20090427153936.GA2276@redhat.com>
	<49F6A672.8050704@redhat.com> <20090428174152.GA7604@redhat.com>
	<49F7420C.5070505@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <49F7420C.5070505@redhat.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Avi Kivity <avi@redhat.com>
Cc: Christian Borntraeger <borntraeger@de.ibm.com>, kvm@vger.kernel.org, Anthony Liguori <anthony@codemonkey.ws>, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Tue, Apr 28, 2009 at 08:51:08PM +0300, Avi Kivity wrote:
> Michael S. Tsirkin wrote:
>> This does not work for MSIX - in linux, you must map all MSI-X entries
>> to interrupt vectors upfront.
>>   
>
> What?  that's very inflexible.
>
> Can you point me at the code?

See pci_enable_msix in include/linux/pci.h

>> So what I see is transports providing something like:
>>
>> struct virtio_interrupt_mapping {
>> 	int virtqueue;
>> 	int interrupt;
>> };
>>
>> map_vqs_to_interrupt(dev, struct virtio_interrupt_mapping *, int nvirtqueues);
>> unmap_vqs(dev);
>>   
>
> Isn't that the same thing?  Please explain the flow.

So to map vq 0 to vector 0, vq 1 to vector 1 and vq 2 to vector 2 the driver would do:

struct virtio_interrupt_mapping mapping[3] = { {0, 0}, {1, 1}, {2, 2} };
vec = map_vqs_to_interrupt(dev, mapping, 3);
if (vec) {
  error handling
}

and then find_vq as usual.

-- 
MST
