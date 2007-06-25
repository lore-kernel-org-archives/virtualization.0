From: Brian King <brking@linux.vnet.ibm.com>
Subject: Re: [kvm-devel] [PATCH RFC 2/3] Virtio draft III: example net driver
Date: Mon, 25 Jun 2007 17:13:34 -0500
Message-ID: <46803E0E.7080103__31507.7333165847$1182809801$gmane$org@linux.vnet.ibm.com>
References: <1181217762.14054.192.camel@localhost.localdomain>	<1181999552.6237.255.camel@localhost.localdomain>	<1181999669.6237.257.camel@localhost.localdomain>	<1181999825.6237.260.camel@localhost.localdomain>	<467FDEAD.4030204@linux.vnet.ibm.com>
	<20070625193304.GB25736@infradead.org>
	<46803999.4040500@qumranet.com>
Reply-To: brking@linux.vnet.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <46803999.4040500@qumranet.com>
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
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, Xen Mailing List <xen-devel@lists.xensource.com>, "jmk@plan9.bell-labs.com" <jmk@plan9.bell-labs.com>, Herbert Xu <herbert@gondor.apana.org.au>, kvm-devel <kvm-devel@lists.sourceforge.net>, virtualization <virtualization@lists.linux-foundation.org>, Christoph Hellwig <hch@infradead.org>, Christian Borntraeger <cborntra@de.ibm.com>, Latchesar Ionkov <lionkov@lanl.gov>, Suzanne McIntosh <skranjac@us.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-Id: virtualization@lists.linuxfoundation.org

Avi Kivity wrote:
> Christoph Hellwig wrote:
>> On Mon, Jun 25, 2007 at 10:26:37AM -0500, Brian King wrote:
>>   
>>> 1. The add_inbuf interface passes an sg list. This causes problems for
>>>    ibmveth since its rx buffers cannot be scatterlists.
>>>     
> 
> I'm probably missing something.  What is wrong with a scatterlist of 
> length 1?

Absolutely nothing, as long as the interface guarantees I don't see a larger
scatterlist. With the current implementation it looks to me like this is
always true, but if we were to stick to using a scatterlist, it would
make sense to allow the user to specify a max sg length supported. This
value could be different for in vs. out buffers.

>>> 2. The user of this API does not have access to the sk_buf. This causes
>>>    issues for ibmveth since it needs to reserve the first 8 bytes of the
>>>    rx buffer for use by the firmware. It currently uses skb_reserve to do this.
>>>
>>> Would it be simpler to just pass an sk_buf rather than the scatterlist
>>> on these interfaces for virtio_net users?
>>>     
>> It probably should pass the sk_buff.
> 
> But virtio is a generic layer that is useful for more than just networking.

Agreed. However, this one is a huge issue for ibmveth. ibmveth must write a tag
to the first 8 bytes of each rx buffer before passing the buffer to the pSeries
hypervisor. The hypervisor then writes this tag to the rx queue when the buffer
is used. This first 8 bytes of the rx buffer is not overlayed with data. Additionally,
the hypervisor may offset further than 8 bytes into the buffer for the start
of the payload if it so desires. The offset is also written to the rx queue.

Another option which would solve this problem would be if the get_inbuf
interface also returned an offset into the original data buffer where the
payload starts.

-Brian

-- 
Brian King
Linux on Power Virtualization
IBM Linux Technology Center
