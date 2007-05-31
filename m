From: Carsten Otte <cotte@de.ibm.com>
Subject: Re: [kvm-devel] [PATCH RFC 1/3] virtio infrastructure
Date: Thu, 31 May 2007 14:53:08 +0200
Message-ID: <465EC534.6040005__949.89505964822$1180616046$gmane$org@de.ibm.com>
References: <1180613947.11133.58.camel@localhost.localdomain>
Reply-To: carsteno@de.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
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
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, Xen Mailing List <xen-devel@lists.xensource.com>, "jmk@plan9.bell-labs.com" <jmk@plan9.bell-labs.com>, Herbert Xu <herbert@gondor.apana.org.au>, kvm-devel <kvm-devel@lists.sourceforge.net>, mschwid2@linux.vnet.ibm.com, virtualization <virtualization@lists.linux-foundation.org>, Christian Borntraeger <cborntra@de.ibm.com>, Suzanne McIntosh <skranjac@us.ibm.com>
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
> I have written two virtio device drivers (net and block) and two
> virtio implementations (for lguest): a read-write socket-style
> implementation, and a more efficient descriptor-based implementation).
These should work for s390 afaics. They seem to fit the requirements 
of network IO.
