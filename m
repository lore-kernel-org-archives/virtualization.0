From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH RFC 0/8] virtio: add guest MSI-X support
Date: Mon, 27 Apr 2009 18:39:36 +0300
Message-ID: <20090427153936.GA2276__45217.9832770073$1240856628$gmane$org@redhat.com>
References: <20090427123136.GA1152@redhat.com>
	<200904271600.30599.borntraeger@de.ibm.com>
	<49F5CA08.6060003@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <49F5CA08.6060003@redhat.com>
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

On Mon, Apr 27, 2009 at 06:06:48PM +0300, Avi Kivity wrote:
> Christian Borntraeger wrote:
>> Am Monday 27 April 2009 14:31:36 schrieb Michael S. Tsirkin:
>>   
>>> Add optional MSI-X support: use a vector per virtqueue with
>>> fallback to a common vector and finally to regular interrupt.
>>> Teach all drivers to use it.
>>>
>>> I added 2 new virtio operations: request_vqs/free_vqs because MSI
>>> needs to know the total number of vectors upfront.
>>>
>>> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
>>>     
>>
>> I dont know, if that is feasible for MSI, but the transport(virtio_pci) should
>> already know the number of virtqueues, which should match the number of
>> vectors, no?
>>
>> In fact, the transport has to have a way of getting the number of virtqeues
>> because find_vq returns ENOENT on invalid index numbers.
>>   
>
> One thing I thought was to decouple the virtqueue count from the MSI  
> entry count, and let the guest choose how many MSI entries it wants to  
> use.  This is useful if it wants several queues to share an interrupt,  
> perhaps it wants both rx and tx rings on one cpu to share a single 
> vector.
>
> So the device could expose a large, constant number of MSI entries, and  
> in addition expose a table mapping ring number to msi entry number.  The  
> guest could point all rings to one entry, or have each ring use a  
> private entry, or anything in between.

Sounds good ... and it might not be a lot of code I think.

> That saves us the new API (at the expense of a lot more code, but with  
> added flexibility).

So we'll probably need to rename request_vqs to request_vectors,
but we probably still need the driver to pass the number of
vectors it wants to the transport. Right?

-- 
MST
