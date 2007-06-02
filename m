From: Avi Kivity <avi@qumranet.com>
Subject: Re: [kvm-devel] [PATCH RFC 1/3] virtio infrastructure
Date: Sat, 02 Jun 2007 09:30:37 +0300
Message-ID: <46610E8D.10706__5440.96428570828$1180765899$gmane$org@qumranet.com>
References: <1180613947.11133.58.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1180613947.11133.58.camel@localhost.localdomain>
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
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, Xen Mailing List <xen-devel@lists.xensource.com>, "jmk@plan9.bell-labs.com" <jmk@plan9.bell-labs.com>, Herbert Xu <herbert@gondor.apana.org.au>, kvm-devel <kvm-devel@lists.sourceforge.net>, virtualization <virtualization@lists.linux-foundation.org>, Christian Borntraeger <cborntra@de.ibm.com>, Suzanne McIntosh <skranjac@us.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-Id: virtualization@lists.linuxfoundation.org

Rusty Russell wrote:
> This attempts to implement a "virtual I/O" layer which should allow
> common drivers to be efficiently used across most virtual I/O
> mechanisms.  It will no-doubt need further enhancement.
>
> The details of probing the device are left to hypervisor-specific
> code: it simple constructs the "struct virtio_device" and hands it to
> the probe function (eg. virtnet_probe() or virtblk_probe()).
>
> The virtio drivers add and detach input and output buffers; as the
> buffers are used up their associated "used" pointers are filled in.
>
>   

Good stuff.

> +/**
> + * virtio_ops - virtio abstraction layer
> + * @add_outbuf: prepare to send data to the other end:
> + *	vdev: the virtio_device
> + *	sg: the description of the buffer(s).
> + *	num: the size of the sg array.
> + *	used: the length sent (set once sending is done).
> + *      Returns an identifier or an error.
> + * @add_inbuf: prepare to receive data from the other end:
> + *	vdev: the virtio_device
> + *	sg: the description of the buffer(s).
> + *	num: the size of the sg array.
> + *	used: the length sent (set once data received).
> + *      Returns an identifier or an error (eg. -ENOSPC).
>   

Instead of 'used', how about a completion callback (with associated data
pointer)?  A new helper, virtio_complete(), would call the callback for
all completed requests.  It would eliminate all the tedious scanning
used to match the identifier.

It would also be nice to support a bit of non-buffer data, like a set of
bitflags.


-- 
Do not meddle in the internals of kernels, for they are subtle and quick to panic.
