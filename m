From: Anthony Liguori <anthony@codemonkey.ws>
Subject: Re: [Qemu-devel] Re: [PATCH] qemu/virtio: move features to an inline
	function
Date: Tue, 11 Aug 2009 08:15:23 -0500
Message-ID: <4A816EEB.4070707@codemonkey.ws>
References: <20090810192809.GA16800@redhat.com>
	<4A8076F0.5050700@codemonkey.ws>
	<20090810194753.GA16803@redhat.com>
	<4A808437.8040307@codemonkey.ws>
	<20090810221940.GB17099@redhat.com>
	<4A80A0A1.2020905@codemonkey.ws> <20090811084807.GA3029@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20090811084807.GA3029@redhat.com>
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
Cc: qemu-devel@nongnu.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

Michael S. Tsirkin wrote:
> On Mon, Aug 10, 2009 at 05:35:13PM -0500, Anthony Liguori wrote:
>   
>> What I'm saying is that virtio-blk-pci, which is the qdev instantiation  
>> of virtio-pci + virtio-blk, should be able to have a set of qdev  
>> properties that is composed of a combination of at least two sets of  
>> properties: virtio-blk's qdev properties and virtio-pci's qdev 
>> properties.
>>     
>
> Yea. But indirect ring entries is not virtio-pci property.

It's a ring feature and the ring implementation is currently in the 
generic virtio code.  Ring features really have no home today so 
virtio-pci seems logical.

>   And ev
> with virtio-pci properies, such as MSI, specific device should
> have control over number of vectors.
>   

Devices, or instantiation of the devices?  The later is what I'm suggesting.

Let's say we supported virtio-vbus along with virtio-pci.  What does 
virtio_blk_get_features() do to mask out sg_indirect?  For all 
virtio-blk knows, it could be on top of virtio-vbus.

> Me as a user? We can't expect the user to tweak such low level stuff for
> each device.  So devices such as block should have a say in which ring
> format options are used, in a way optimal for the specific usage.  My
> example is that virtio net has merged buffers so indirect ring is
> probably just useless.  And again, pci seems to have nothing to do with
> it, so why drag it in?
>   

If you want to tweak such thing, why not use default property values for 
virtio-blk-pci's definition in virtio-pci.c?  That keeps it out of 
virtio-blk.c.

>> separate qdev device than virtio-net-pci.  It can have an identical  
>> guest interface but within qemu, it should be a separate device.  This  
>> is how we handle the in-kernel PIT and it's how we should handle the  
>> in-kernel APIC.
>>     
>
> Ugh. What advantages does this have?

It keeps a clean separate of the two devices.  It actually ends up 
making things a lot easier to understand because it's clear what 
portions of code are not being used for the in-kernel device models.

>   This would break things like
> migrating between userspace and kernel virtio (something that I
> support).

The PIT uses a common state structure and common code for save/restore.  
This makes migration compatible.

>   IMO, this should work like MSI, detect capability and just
> have virtio go faster, with a disable flag for troubleshooting purposes.
>
> Can migration between in-kernel and userspace PIT work?
> If yes we would be better off changing that, as well.
>   

Take a look at i8524{,-kvm.c} in qemu-kvm and how it's instantiated in 
pc.c.  It ends up being really straight forward.

> Separate devices should be for things that have guest-visible
> differences. Don't try to encode random information into the device
> name.
>   

In this case, it's two separate implementations of the same device.  I 
think it makes sense for them to be separate devices.

Regards,

Anthony Liguori
