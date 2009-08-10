From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [Qemu-devel] Re: [PATCH] qemu/virtio: move features to an
	inline function
Date: Mon, 10 Aug 2009 22:47:53 +0300
Message-ID: <20090810194753.GA16803@redhat.com>
References: <20090810192809.GA16800@redhat.com>
	<4A8076F0.5050700@codemonkey.ws>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <4A8076F0.5050700@codemonkey.ws>
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

On Mon, Aug 10, 2009 at 02:37:20PM -0500, Anthony Liguori wrote:
> Michael S. Tsirkin wrote:
>> devices should have the final say over which virtio features they
>> support. E.g. indirect entries may or may not make sense in the context
>> of virtio-console.  Move the common bits from virtio-pci to an inline
>> function and let each device call it.
>>   
>
> What drove this in vhost?

vhost does not support indirect ring entries and notify on empty yet.

> Normally, the common features are transport features and the devices  
> should have absolutely no knowledge of transport feature (since they're  
> transport dependent).

Good point. But

1. note that with my patch they don't. They call
virtio_get_common_features and that's all.

2. some features may not make sense for some devices. For example, it is
quite possible that indirect ring entries feature improves performance
on block but hurts on net, as net has a similar merged buffers feature.
Someone should try benchmarking with it disabled, and it becomes
possible with my patch.

> IOW, VIRTIO_RING_F_INDIRECT_DESC is meaningless to virtio-console  
> because virtio-console has no idea what the ring implementation is that  
> it sits on top of.

At some level.  Same can be said to be true for virtio-pci: it sits
below the ring implementation. However, it is not *completely*
meaningless: some devices may benefit from indirect entries, others may
not, or may benefit from disabling them.

> Regards,
>
> Anthony Liguori
>
