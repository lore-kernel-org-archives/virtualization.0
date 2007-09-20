From: Avi Kivity <avi@qumranet.com>
Subject: Re: [kvm-devel] [PATCH 1/6] virtio interace
Date: Thu, 20 Sep 2007 14:27:54 +0200
Message-ID: <46F2674A.2050403__8693.16966641254$1190291407$gmane$org@qumranet.com>
References: <1190289808.7262.223.camel@localhost.localdomain>
	<1190290140.7262.228.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1190290140.7262.228.camel@localhost.localdomain>
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
Cc: kvm-devel <kvm-devel@lists.sourceforge.net>, lguest <lguest@ozlabs.org>, virtualization <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

Rusty Russell wrote:
> (Changes: 
>  - renamed sync to kick as Dor suggested
>  - added new_vq and free_vq hooks to create virtqueues
>  - define a simple virtio driver, which uses PCI ids
>  - provide register/unregister_virtio_driver hooks)
>
> This attempts to implement a "virtual I/O" layer which should allow
> common drivers to be efficiently used across most virtual I/O
> mechanisms.  It will no-doubt need further enhancement.
>
> The virtio drivers add and get I/O buffers; as the buffers are consumed
> the driver "interrupt" callbacks are invoked.
>
> It also provides driver register and unregister hooks, which are
> simply overridden at run time (eg. for a guest kernel which supports
> KVM paravirt and lguest).
>   

> +++ b/drivers/virtio/virtio.c
> @@ -0,0 +1,20 @@
> +#include <linux/virtio.h>
> +
> +struct virtio_backend_ops virtio_backend_ops;
> +EXPORT_SYMBOL_GPL(virtio_backend_ops);
>   

Suggest calling this virtio_transport_ops rather than the too-generic 
virtio_backend_ops.  Especially since Xen uses backend for something 
completely different.

> +
> +/**
> + * virtqueue_ops - operations for virtqueue abstraction layer
> + * @new_vq: create a new virtqueue
> + *	config: the virtio_config_space field describing the queue
> + *	off: the offset in the config space of the queue configuration
> + *	len: the length of the virtio_config_space field
>   

'off, len' are really a magic cookie.  Why does the interface care about 
their meaning?

> + *	callback: the driver callback when the queue is used.
>   

Missing callback return value description.
> + * @kick: update after add_buf
> + *	vq: the struct virtqueue
> + *	After one or more add_buf calls, invoke this to kick the virtio layer.
>   

'the other side'


I'm not thrilled about reusing pci ids.  Maybe the s390 can say whether 
this is a real issue.

-- 
error compiling committee.c: too many arguments to function
