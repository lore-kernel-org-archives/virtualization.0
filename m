From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH RFC 0/8] virtio: add guest MSI-X support
Date: Tue, 28 Apr 2009 20:41:52 +0300
Message-ID: <20090428174152.GA7604__45691.0883346156$1240940773$gmane$org@redhat.com>
References: <20090427123136.GA1152@redhat.com>
	<200904271600.30599.borntraeger@de.ibm.com>
	<49F5CA08.6060003@redhat.com> <20090427153936.GA2276@redhat.com>
	<49F6A672.8050704@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <49F6A672.8050704@redhat.com>
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

On Tue, Apr 28, 2009 at 09:47:14AM +0300, Avi Kivity wrote:
> Michael S. Tsirkin wrote:
>>> That saves us the new API (at the expense of a lot more code, but 
>>> with  added flexibility).
>>>     
>>
>> So we'll probably need to rename request_vqs to request_vectors,
>> but we probably still need the driver to pass the number of
>> vectors it wants to the transport. Right?
>>
>>   
>
> I don't think so - virtio will provide the number of interrupts it  
> supports, and virtio-net will tell it to bind ring X to interrupt Y.

This does not work for MSIX - in linux, you must map all MSI-X entries
to interrupt vectors upfront.

So what I see is transports providing something like:

struct virtio_interrupt_mapping {
	int virtqueue;
	int interrupt;
};

map_vqs_to_interrupt(dev, struct virtio_interrupt_mapping *, int nvirtqueues);
unmap_vqs(dev);

-- 
MST
