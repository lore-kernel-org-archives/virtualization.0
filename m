From: Anthony Liguori <anthony@codemonkey.ws>
Subject: Re: [PATCH] virtio config_ops refactoring
Date: Fri, 09 Nov 2007 17:45:38 -0600
Message-ID: <4734F122.8000102__46330.6052065038$1194652014$gmane$org@codemonkey.ws>
References: <4730A8F3.6020008@us.ibm.com>
	<200711090924.28659.rusty@rustcorp.com.au>
	<47338EA0.6050100@codemonkey.ws>
	<200711092254.08099.rusty@rustcorp.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <200711092254.08099.rusty@rustcorp.com.au>
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
Cc: lguest <lguest@ozlabs.org>, linux-kernel@vger.kernel.org, Dor Laor <dor.laor@qumranet.com>, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

Rusty Russell wrote:
> On Friday 09 November 2007 09:33:04 Anthony Liguori wrote:
>   
>> switch (addr) {
>> case VIRTIO_BLK_CONFIG_MAX_SEG:
>>    return vdev->max_seg & 0xFF;
>> case VIRTIO_BLK_CONFIG_MAX_SEG + 1:
>>    return (vdev->max_seg >> 8) & 0xFF;
>> case VIRTIO_BLK_CONFIG_MAX_SEG + 2:
>>    return (vdev->max_seg >> 16) & 0xFF;
>> case VIRTIO_BLK_CONFIG_MAX_SEG + 3:
>>    return (vdev->max_seg >> 24) & 0xFF;
>> case VIRTIO_BLK_CONFIG_MAX_SIZE:
>>    return vdev->max_size & 0xFF;
>> case VIRTIO_BLK_CONFIG_MAX_SIZE + 1:
>>    return (vdev->max_size >> 8) & 0xFF;
>> case VIRTIO_BLK_CONFIG_MAX_SIZE + 2:
>>    return (vdev->max_size >> 16) & 0xFF;
>> case VIRTIO_BLK_CONFIG_MAX_SIZE + 3:
>>    return (vdev->max_size >> 24) & 0xFF;
>> ...
>>     
>
> 	struct virtio_blk_config
> 	{
> 		uint32_t max_seg, max_size;
> 	};
>
> 	...
> 	struct virtio_blk_config conf = { vdev->max_seg, vdev->max_size };
>
> 	return ((unsigned char *)&conf)[addr];
>
> (Which strongly implies our headers should expose that nominal struct, rather 
> than numerical constants).
>   

The problem is the ABI.  We can either require that PCI configuration 
values are accessed with natural instructions, or it makes very little 
sense to use the PCI configuration space for virtio configuration 
information.  If we really can't find a way to do this (and I think my 
current implementation is the best compromise since it hides this from 
everything else), then I think I'll switch over to just writing a PFN 
into a PCI configuration slot and then have that page store the virtio 
configuration information (much like is done with lguest).

Either virtio config looks like a shared memory area (as lguest 
currently implements it), or it looks like hardware registers (like 
virtio-pci implements it).  After thinking about it for a while, I don't 
think the two can be reconciled.  There are subtle differences between 
the two that can't be hidden in the virtio interface.  For instance, in 
the PCI model, you get notified when values are read/written whereas in 
the lguest model, you don't and need explicit status bits.

If you're very against the switch() magic, then I'll switch over to just 
using a shared memory area.

Regards,

Anthony Liguori

> Rusty.
>
>   
