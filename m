From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH v3 1/1] Shared memory uio_pci driver
Date: Thu, 25 Mar 2010 18:33:22 +0200
Message-ID: <20100325163322.GB16235__5235.67258283055$1269535055$gmane$org@redhat.com>
References: <1269497376-21903-1-git-send-email-cam@cs.ualberta.ca>
	<20100325091552.GB11153@redhat.com>
	<8286e4ee1003250918x659e87ai9e5ca7c68c23a7c3@mail.gmail.com>
	<4BAB8DE9.9080603@codemonkey.ws>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <4BAB8DE9.9080603@codemonkey.ws>
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
Cc: qemu-devel@nongnu.org, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Thu, Mar 25, 2010 at 11:23:05AM -0500, Anthony Liguori wrote:
> On 03/25/2010 11:18 AM, Cam Macdonell wrote:
>> On Thu, Mar 25, 2010 at 3:15 AM, Michael S. Tsirkin<mst@redhat.com>  wrote:
>>    
>>> On Thu, Mar 25, 2010 at 12:09:36AM -0600, Cam Macdonell wrote:
>>>      
>>>> This patch adds a driver for my shared memory PCI device using the uio_pci
>>>> interface.  The driver has three memory regions.  The first memory region is for
>>>> device registers for sending interrupts. The second BAR is for receiving MSI-X
>>>> interrupts and the third memory region maps the shared memory.  The device only
>>>> exports the first and third memory regions to userspace.
>>>>
>>>> This driver supports MSI-X and regular pin interrupts.  Currently, the number of
>>>> MSI vectors is set to 4 which could be increased, but the driver will work with
>>>> fewer vectors.  If MSI is not available, then regular interrupts will be used.
>>>>        
>>> Some high level questions, sorry if they have been raised in the past:
>>> - Can this device use virtio framework?
>>>   This gives us some standards to work off, with feature negotiation,
>>>   ability to detect config changes, support for non-PCI
>>>   platforms, decent documentation that is easy to extend,
>>>   legal id range to use.
>>>   You would thus have your driver in uio/uio_virtio_shmem.c
>>>      
>> There has been previous discussion of virtio, however while virtio is
>> good for exporting guest memory, it's not ideal for importing memory
>> into a guest.
>>    
>
> virtio is a DMA-based API which means that it doesn't assume cache  
> coherent shared memory.  The PCI transport takes advantage of cache  
> coherent shared memory but it's not strictly required.
>
> Memory sharing in virtio would be a layering violation because it forces  
> cache coherent shared memory for all virtio transports.
>
> Regards,
>
> Anthony Liguori

I am not sure I understand the argument.  We can still reuse feature
negotiation, notifications etc from virtio.  If some transports can not
support cache coherent shared memory, the device won't work there.
But it won't work there anyway, even without using virtio.
We are not forcing all devices to assume cache coherency.

In other words, let's not fall into midlayer mistake, let's
treat virtio as a library.

-- 
MST
