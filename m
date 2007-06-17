From: Avi Kivity <avi@qumranet.com>
Subject: Re: [kvm-devel] [PATCH RFC 0/3] Virtio draft III
Date: Sun, 17 Jun 2007 17:14:55 +0300
Message-ID: <467541DF.5060907__4547.44364037669$1182089774$gmane$org@qumranet.com>
References: <1181217762.14054.192.camel@localhost.localdomain>
	<1181999552.6237.255.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1181999552.6237.255.camel@localhost.localdomain>
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
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, Xen Mailing List <xen-devel@lists.xensource.com>, "jmk@plan9.bell-labs.com" <jmk@plan9.bell-labs.com>, Herbert Xu <herbert@gondor.apana.org.au>, kvm-devel <kvm-devel@lists.sourceforge.net>, virtualization <virtualization@lists.linux-foundation.org>, Christian Borntraeger <cborntra@de.ibm.com>, Latchesar Ionkov <lionkov@lanl.gov>, Suzanne McIntosh <skranjac@us.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-Id: virtualization@lists.linuxfoundation.org

Rusty Russell wrote:
> In this episode, Rusty tries to NAPI-ize the driver and discovers that
> virtio callbacks are a bad idea: NAPI needs to turn interrupts off and
> still be able to query for new incoming packets.
>
> Changes to core:
> 1) Back to "interrupt" model with get_inbuf()/get_outbuf() calls.
>   

Seems to be these are just two different ways of iterating over the 
pending buffers, and one could be implemented in terms of the other in a 
few lines.  I think that new new way is better, though, due to less 
indirection.

btw, I'm not sure that the name 'virtio' is correct.  Probably any 
network or block driver which has support for batching (the vast 
majority) could use this to good effect.


-- 
error compiling committee.c: too many arguments to function
