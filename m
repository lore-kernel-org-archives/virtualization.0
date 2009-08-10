From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [Qemu-devel] Re: [PATCH] qemu/virtio: move features to an
	inline function
Date: Tue, 11 Aug 2009 01:19:40 +0300
Message-ID: <20090810221940.GB17099@redhat.com>
References: <20090810192809.GA16800@redhat.com>
	<4A8076F0.5050700@codemonkey.ws>
	<20090810194753.GA16803@redhat.com>
	<4A808437.8040307@codemonkey.ws>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <4A808437.8040307@codemonkey.ws>
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

On Mon, Aug 10, 2009 at 03:33:59PM -0500, Anthony Liguori wrote:
> Michael S. Tsirkin wrote:
>>> Normally, the common features are transport features and the devices  
>>> should have absolutely no knowledge of transport feature (since 
>>> they're  transport dependent).
>>>     
>>
>> Good point. But
>>
>> 1. note that with my patch they don't. They call
>> virtio_get_common_features and that's all.
>>
>> 2. some features may not make sense for some devices. For example, it is
>> quite possible that indirect ring entries feature improves performance
>> on block but hurts on net, as net has a similar merged buffers feature.
>> Someone should try benchmarking with it disabled, and it becomes
>> possible with my patch.
>>   
>
> I don't necessarily disagree but I think your patch goes about it the  
> wrong way.
>
> There ought to be a way to layer qdev properties that achieves this goal  
> so that when you create a virtio-pci-block device, you have the ability  
> to turn off indirect sg without virtio-block having to know what that is.

I don't understand, sorry. Why do you insist on involving pci here?
ring layout has nothing to do with pci, does it?  With my patch,
virtio-block does not know what indirect sg is. It just does
enable/disable.

virtio net has device-specific feature that overlaps with
indirect entries. So insisting that devices should just ignore
transport does not make sense, to me.

> For your use-case, I wonder if you're integrating at the wrong level.   

Forget about that for now. Let's solve the generic problem.

> Regards,
>
> Anthony Liguori
