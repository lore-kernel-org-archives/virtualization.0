From: Avi Kivity <avi@qumranet.com>
Subject: Re: [kvm-devel] [PATCH RFC 1/3] virtio	infrastructure
Date: Mon, 04 Jun 2007 14:25:32 +0300
Message-ID: <4663F6AC.7070100__25569.207131821$1180956368$gmane$org@qumranet.com>
References: <1180613947.11133.58.camel@localhost.localdomain>	
	<46610E8D.10706@qumranet.com>	
	<1180777836.9228.44.camel@localhost.localdomain>	
	<46625192.5020108@qumranet.com>	
	<1180866540.17442.74.camel@localhost.localdomain>	
	<4662A86A.7010706@qumranet.com>	
	<1180914836.17442.104.camel@localhost.localdomain>	
	<4663E18D.4030007@qumranet.com>
	<1180955964.25878.27.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1180955964.25878.27.camel@localhost.localdomain>
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
>   
>> Networking hardware generally services descriptors in a FIFO manner.
>>     
>
> Well, ethernet guarantees order.  Not sure about others tho...
>
>   

OT: Does that hold for bonded interfaces too?

>> virtio may not (for example, it may offload copies of larger packets to 
>> a dma engine such as I/OAT, resulting in a delay, but copy smaller 
>> packets immediately).  that means that there will be some mismatch 
>> between virtio drivers and real hardware drivers.
>>     
>
> I think your point is that the completion bitmap (or indeed, the current
> approach) does not maintain order?  Hmm, this is more convincing to me
> than cache arguments, since some devices might want ordering and want
> more than a single io in flight.
>   

Well, it wasn't really; sorry for being unclear.  My point was that 
virtio interfaces will not match hardware exactly.

My objection is to "scan all slots, occupied or not, for completion".  I 
think virtio should present completed descriptors without the need for 
scanning, even if it means looking a bit different from a typical 
ethernet driver.


-- 
error compiling committee.c: too many arguments to function
