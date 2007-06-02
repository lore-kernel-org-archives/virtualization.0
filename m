From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [kvm-devel] [PATCH RFC 1/3] virtio infrastructure
Date: Sat, 02 Jun 2007 19:50:36 +1000
Message-ID: <1180777836.9228.44.camel__27591.6022401818$1180777908$gmane$org@localhost.localdomain>
References: <1180613947.11133.58.camel@localhost.localdomain>
	<46610E8D.10706@qumranet.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <46610E8D.10706@qumranet.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Avi Kivity <avi@qumranet.com>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, Xen Mailing List <xen-devel@lists.xensource.com>, "jmk@plan9.bell-labs.com" <jmk@plan9.bell-labs.com>, Herbert Xu <herbert@gondor.apana.org.au>, kvm-devel <kvm-devel@lists.sourceforge.net>, virtualization <virtualization@lists.linux-foundation.org>, Christian Borntraeger <cborntra@de.ibm.com>, Suzanne McIntosh <skranjac@us.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-Id: virtualization@lists.linuxfoundation.org

On Sat, 2007-06-02 at 09:30 +0300, Avi Kivity wrote:
> Rusty Russell wrote:
> > + * virtio_ops - virtio abstraction layer
> > + * @add_outbuf: prepare to send data to the other end:
> > + *	vdev: the virtio_device
> > + *	sg: the description of the buffer(s).
> > + *	num: the size of the sg array.
> > + *	used: the length sent (set once sending is done).
> > + *      Returns an identifier or an error.
> > + * @add_inbuf: prepare to receive data from the other end:
> > + *	vdev: the virtio_device
> > + *	sg: the description of the buffer(s).
> > + *	num: the size of the sg array.
> > + *	used: the length sent (set once data received).
> > + *      Returns an identifier or an error (eg. -ENOSPC).
> >   
> 
> Instead of 'used', how about a completion callback (with associated data
> pointer)?  A new helper, virtio_complete(), would call the callback for
> all completed requests.  It would eliminate all the tedious scanning
> used to match the identifier.

Hi Avi,

	There were several considerations here.  My first was that the drivers
look much more like normal devices than getting a callback for every
buffer.   Secondly, "used" batches much more nicely than a completion.
Finally, it's also something you really want to know, so the driver
doesn't have to zero its inbufs (an untrusted other side says it sends
you 1500 bytes but actually sent nothing, and now you spray kernel
memory out the NIC).

	I also considered some scheme like:

	struct virtio_used_info
	{
		unsigned long len;
		void *next_token;
	};
	...
	unsigned long (*add_outbuf)(struct virtio_device *vdev,
				    const struct scatterlist sg[],
				    unsigned int num,
				    void *token,
				    struct virtio_used_info *used_info);

So the "used" becomes a "used/next" pair and you can just walk the
linked list.  But I wasn't convinced that walking the buffers is going
to be a performance issue (tho the net driver puts them in a continuous
array for cache friendliness as a nod to this concern).

> It would also be nice to support a bit of non-buffer data, like a set of
> bitflags.

	I expect this might be necessary, but it wasn't so far.  The non-buffer
data tends to go in sg[0]: the block driver works this way, and the
network driver will for GSO.  Of course, a specialized virtio_ops
backend might well take this and put the info somewhere else.

	I also considered a separate "publish"/"examine" interface for things
which aren't really messages, but again, haven't needed it yet.

Thanks!
Rusty.
