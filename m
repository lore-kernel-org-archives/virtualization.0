From: Carsten Otte <cotte@de.ibm.com>
Subject: Re: [kvm-devel] [PATCH RFC 3/3] virtio infrastructure: example block
 driver
Date: Thu, 31 May 2007 14:57:27 +0200
Message-ID: <465EC637.7020504__13502.3038987585$1180616302$gmane$org@de.ibm.com>
References: <1180613947.11133.58.camel@localhost.localdomain>
	<1180614044.11133.61.camel@localhost.localdomain>
	<1180614091.11133.63.camel@localhost.localdomain>
Reply-To: carsteno@de.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1180614091.11133.63.camel@localhost.localdomain>
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
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, Xen Mailing List <xen-devel@lists.xensource.com>, "jmk@plan9.bell-labs.com" <jmk@plan9.bell-labs.com>, Herbert Xu <herbert@gondor.apana.org.au>, kvm-devel <kvm-devel@lists.sourceforge.net>, mschwid2@linux.vnet.ibm.com, virtualization <virtualization@lists.linux-foundation.org>, Christian Borntraeger <cborntra@de.ibm.com>, Suzanne McIntosh <skranjac@us.ibm.com>
List-Id: virtualization@lists.linuxfoundation.org

Rusty Russell wrote:
> Example block driver using virtio.
> 
> The block driver uses outbufs with sg[0] being the request information
> (struct virtio_blk_outhdr) with the type, sector and inbuf id.  For a
> write, the rest of the sg will contain the data to be written.
> 
> The first segment of the inbuf is a result code (struct
> virtio_blk_inhdr).  For a read, the rest of the sg points to the input
> buffer.
> 
> TODO:
> 	1) Ordered tag support.
Implementing a do_request function has quite a few disadvantages over 
hooking into q->make_request_fn. This way, we have the device plug 
(latency), request merging, and I/O scheduling inside the guest.
It seems preferable to do that in the host, especially when requests 
of multiple guests end up on the same physical media (shared access, 
or partitioned).
