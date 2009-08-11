From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [Qemu-devel] Re: [PATCH] qemu/virtio: move features to an
	inline function
Date: Tue, 11 Aug 2009 11:48:09 +0300
Message-ID: <20090811084807.GA3029__34044.2831897692$1249980826$gmane$org@redhat.com>
References: <20090810192809.GA16800@redhat.com>
	<4A8076F0.5050700@codemonkey.ws>
	<20090810194753.GA16803@redhat.com>
	<4A808437.8040307@codemonkey.ws>
	<20090810221940.GB17099@redhat.com>
	<4A80A0A1.2020905@codemonkey.ws>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <4A80A0A1.2020905@codemonkey.ws>
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
Cc: qemu-devel@nongnu.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Mon, Aug 10, 2009 at 05:35:13PM -0500, Anthony Liguori wrote:
> Michael S. Tsirkin wrote:
>> On Mon, Aug 10, 2009 at 03:33:59PM -0500, Anthony Liguori wrote:
>>   
>>> There ought to be a way to layer qdev properties that achieves this 
>>> goal  so that when you create a virtio-pci-block device, you have the 
>>> ability  to turn off indirect sg without virtio-block having to know 
>>> what that is.
>>>     
>>
>> I don't understand, sorry. Why do you insist on involving pci here?
>> ring layout has nothing to do with pci, does it?
>
> What I'm saying is that virtio-blk-pci, which is the qdev instantiation  
> of virtio-pci + virtio-blk, should be able to have a set of qdev  
> properties that is composed of a combination of at least two sets of  
> properties: virtio-blk's qdev properties and virtio-pci's qdev 
> properties.

Yea. But indirect ring entries is not virtio-pci property.  And even
with virtio-pci properies, such as MSI, specific device should
have control over number of vectors.

> Right now, all of the properties are defined in virtio-pci.c, so you  
> could add a property that was DEFINE_PROP_BOOL("indirect-sg", ...), that  
> you could then use to selectively enable/disable indirect sg on  
> virtio-blk-pci devices without ever having to involve virtio-blk.c.

Me as a user? We can't expect the user to tweak such low level stuff for
each device.  So devices such as block should have a say in which ring
format options are used, in a way optimal for the specific usage.  My
example is that virtio net has merged buffers so indirect ring is
probably just useless.  And again, pci seems to have nothing to do with
it, so why drag it in?

> Ideally, we wouldn't have the properties centralized in virtio-pci.c.   
> Rather, it would be nice if virtio-blk.c could have a set of properties  
> and virtio-pci.c could just add those properties to it's own set of  
> properties.

That's what my patch did. think of feature bits as properties.  The set
of properties can not currently be controlled by user, but this can be
added if there is need.


> Today, we don't have a concept of a ring abstraction.  If we did, then  
> virtio-ring.c could have it's own set of properties.

Yes but devices might and do care about which of these properties
get used.

> N.B. I expect that the in-kernel virtio-net device is going to be  
> separate qdev device than virtio-net-pci.  It can have an identical  
> guest interface but within qemu, it should be a separate device.  This  
> is how we handle the in-kernel PIT and it's how we should handle the  
> in-kernel APIC.

Ugh. What advantages does this have?  This would break things like
migrating between userspace and kernel virtio (something that I
support).  IMO, this should work like MSI, detect capability and just
have virtio go faster, with a disable flag for troubleshooting purposes.

Can migration between in-kernel and userspace PIT work?
If yes we would be better off changing that, as well.

Separate devices should be for things that have guest-visible
differences. Don't try to encode random information into the device
name.

> Regards,
>
> Anthony Liguori
