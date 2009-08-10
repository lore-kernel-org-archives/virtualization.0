From: Anthony Liguori <anthony@codemonkey.ws>
Subject: Re: [Qemu-devel] Re: [PATCH] qemu/virtio: move features to an inline
	function
Date: Mon, 10 Aug 2009 15:33:59 -0500
Message-ID: <4A808437.8040307@codemonkey.ws>
References: <20090810192809.GA16800@redhat.com>
	<4A8076F0.5050700@codemonkey.ws>
	<20090810194753.GA16803@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20090810194753.GA16803@redhat.com>
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
>> Normally, the common features are transport features and the devices  
>> should have absolutely no knowledge of transport feature (since they're  
>> transport dependent).
>>     
>
> Good point. But
>
> 1. note that with my patch they don't. They call
> virtio_get_common_features and that's all.
>
> 2. some features may not make sense for some devices. For example, it is
> quite possible that indirect ring entries feature improves performance
> on block but hurts on net, as net has a similar merged buffers feature.
> Someone should try benchmarking with it disabled, and it becomes
> possible with my patch.
>   

I don't necessarily disagree but I think your patch goes about it the 
wrong way.

There ought to be a way to layer qdev properties that achieves this goal 
so that when you create a virtio-pci-block device, you have the ability 
to turn off indirect sg without virtio-block having to know what that is.

For your use-case, I wonder if you're integrating at the wrong level.  
If you implement a ring in-kernel, maybe the thing to do is introduce 
more layering in qemu like we have in the kernel so that you can easily 
add a new ring backend type.  At any rate, see if you can achieve the 
same goal with qdev properties.  If you could, you should be able to 
hack something up easily to disable this for vhost without completely 
overhauling qemu's virtio implementation.

Regards,

Anthony Liguori
