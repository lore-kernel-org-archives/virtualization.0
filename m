From: Carsten Otte <cotte@de.ibm.com>
Subject: Re: [kvm-devel] [PATCH RFC 3/3] virtio infrastructure: example block
 driver
Date: Mon, 04 Jun 2007 15:40:26 +0200
Message-ID: <4664164A.40604__23732.8757568777$1180964511$gmane$org@de.ibm.com>
References: <1180613947.11133.58.camel@localhost.localdomain>
	<1180614044.11133.61.camel@localhost.localdomain>
	<1180614091.11133.63.camel@localhost.localdomain>
	<465EC637.7020504@de.ibm.com>
	<1180654765.10999.6.camel@localhost.localdomain>
	<465FC65C.6020905@de.ibm.com> <20070601131315.GW32105@kernel.dk>
Reply-To: carsteno@de.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20070601131315.GW32105@kernel.dk>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Jens Axboe <jens.axboe@oracle.com>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, Xen Mailing List <xen-devel@lists.xensource.com>, "jmk@plan9.bell-labs.com" <jmk@plan9.bell-labs.com>, Herbert Xu <herbert@gondor.apana.org.au>, carsteno@de.ibm.com, mschwid2@linux.vnet.ibm.com, virtualization <virtualization@lists.linux-foundation.org>, kvm-devel <kvm-devel@lists.sourceforge.net>, Suzanne McIntosh <skranjac@us.ibm.com>, Christian Borntraeger <cborntra@de.ibm.com>
List-Id: virtualization@lists.linuxfoundation.org

Jens Axboe wrote:
> On Fri, Jun 01 2007, Carsten Otte wrote:
>> With regard to compute power needed, almost none. The penalty is 
>> latency, not overhead: A small request may sit on the request queue to 
>> wait for other work to arrive until the queue gets unplugged. This 
>> penality is compensated by the benefit of a good chance that more 
>> requests will be merged during this time period.
>> If we have this method both in host and guest, we have twice the 
>> penalty with no added benefit.
> 
> I don't buy that argument. We can easily expose the unplug delay, so you
> can kill it at what ever level you want. Or you could just do it in the
> driver right now, but that is a bit hackish.
That would be preferable if the device driver can chose the unplug 
delay, or even better it could be (guest)sysfs tuneable.

so long,
Carsten
