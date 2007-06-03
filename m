From: Avi Kivity <avi@qumranet.com>
Subject: Re: [kvm-devel] [PATCH RFC 1/3] virtio infrastructure
Date: Sun, 03 Jun 2007 08:28:50 +0300
Message-ID: <46625192.5020108__17976.9303570085$1180848584$gmane$org@qumranet.com>
References: <1180613947.11133.58.camel@localhost.localdomain>	
	<46610E8D.10706@qumranet.com>
	<1180777836.9228.44.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1180777836.9228.44.camel@localhost.localdomain>
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
> On Sat, 2007-06-02 at 09:30 +0300, Avi Kivity wrote:
>   
>> Rusty Russell wrote:
>>     
>>> + * virtio_ops - virtio abstraction layer
>>> + * @add_outbuf: prepare to send data to the other end:
>>> + *	vdev: the virtio_device
>>> + *	sg: the description of the buffer(s).
>>> + *	num: the size of the sg array.
>>> + *	used: the length sent (set once sending is done).
>>> + *      Returns an identifier or an error.
>>> + * @add_inbuf: prepare to receive data from the other end:
>>> + *	vdev: the virtio_device
>>> + *	sg: the description of the buffer(s).
>>> + *	num: the size of the sg array.
>>> + *	used: the length sent (set once data received).
>>> + *      Returns an identifier or an error (eg. -ENOSPC).
>>>   
>>>       
>> Instead of 'used', how about a completion callback (with associated data
>> pointer)?  A new helper, virtio_complete(), would call the callback for
>> all completed requests.  It would eliminate all the tedious scanning
>> used to match the identifier.
>>     
>
> Hi Avi,
>
> 	There were several considerations here.  My first was that the drivers
> look much more like normal devices than getting a callback for every
> buffer.   Secondly, "used" batches much more nicely than a completion.
> Finally, it's also something you really want to know, so the driver
> doesn't have to zero its inbufs (an untrusted other side says it sends
> you 1500 bytes but actually sent nothing, and now you spray kernel
> memory out the NIC).
>   

Sure, 'used' is important (how else do you get the packet size on
receive?),  I'm just bitching about the linear scan.

> 	I also considered some scheme like:
>
> 	struct virtio_used_info
> 	{
> 		unsigned long len;
> 		void *next_token;
> 	};
> 	...
> 	unsigned long (*add_outbuf)(struct virtio_device *vdev,
> 				    const struct scatterlist sg[],
> 				    unsigned int num,
> 				    void *token,
> 				    struct virtio_used_info *used_info);
>
> So the "used" becomes a "used/next" pair and you can just walk the
> linked list.  But I wasn't convinced that walking the buffers is going
> to be a performance issue (tho the net driver puts them in a continuous
> array for cache friendliness as a nod to this concern).
>   

Well, if you have 256 slots per direction, you will scan 4KB of memory
per interrupt (256 slots x 2 directions x 8 bytes).  You may need a
queue length greater than 256 for a high bandwidth interface, if you
want to reduce your interrupt rate, or if your guest is scheduled out
for lengthy periods (say, a millisecond).


>   
>> It would also be nice to support a bit of non-buffer data, like a set of
>> bitflags.
>>     
>
> 	I expect this might be necessary, but it wasn't so far.  The non-buffer
> data tends to go in sg[0]: the block driver works this way, and the
> network driver will for GSO.  Of course, a specialized virtio_ops
> backend might well take this and put the info somewhere else.
>   

Yeah.  Well, it's a somewhat roundabout way of doing things.


-- 
Do not meddle in the internals of kernels, for they are subtle and quick to panic.
