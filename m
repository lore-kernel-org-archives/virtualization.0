From: Anthony Liguori <anthony@codemonkey.ws>
Subject: Re: [Qemu-devel] Re: [PATCH] qemu/virtio: move features to an inline
	function
Date: Mon, 10 Aug 2009 17:35:13 -0500
Message-ID: <4A80A0A1.2020905__33900.3167966895$1249943873$gmane$org@codemonkey.ws>
References: <20090810192809.GA16800@redhat.com>
	<4A8076F0.5050700@codemonkey.ws>
	<20090810194753.GA16803@redhat.com>
	<4A808437.8040307@codemonkey.ws>
	<20090810221940.GB17099@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20090810221940.GB17099@redhat.com>
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
> On Mon, Aug 10, 2009 at 03:33:59PM -0500, Anthony Liguori wrote:
>   
>> There ought to be a way to layer qdev properties that achieves this goal  
>> so that when you create a virtio-pci-block device, you have the ability  
>> to turn off indirect sg without virtio-block having to know what that is.
>>     
>
> I don't understand, sorry. Why do you insist on involving pci here?
> ring layout has nothing to do with pci, does it?

What I'm saying is that virtio-blk-pci, which is the qdev instantiation 
of virtio-pci + virtio-blk, should be able to have a set of qdev 
properties that is composed of a combination of at least two sets of 
properties: virtio-blk's qdev properties and virtio-pci's qdev properties.

Right now, all of the properties are defined in virtio-pci.c, so you 
could add a property that was DEFINE_PROP_BOOL("indirect-sg", ...), that 
you could then use to selectively enable/disable indirect sg on 
virtio-blk-pci devices without ever having to involve virtio-blk.c.

Ideally, we wouldn't have the properties centralized in virtio-pci.c.  
Rather, it would be nice if virtio-blk.c could have a set of properties 
and virtio-pci.c could just add those properties to it's own set of 
properties.

Today, we don't have a concept of a ring abstraction.  If we did, then 
virtio-ring.c could have it's own set of properties.

N.B. I expect that the in-kernel virtio-net device is going to be 
separate qdev device than virtio-net-pci.  It can have an identical 
guest interface but within qemu, it should be a separate device.  This 
is how we handle the in-kernel PIT and it's how we should handle the 
in-kernel APIC.

Regards,

Anthony Liguori
