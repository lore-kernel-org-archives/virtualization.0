From: Avi Kivity <avi@qumranet.com>
Subject: Re: [kvm-devel] [PATCH RFC 3/3] virtio infrastructure: example block
 driver
Date: Thu, 31 May 2007 20:36:24 +0300
Message-ID: <465F0798.2070708__3765.29491409219$1180633117$gmane$org@qumranet.com>
References: <1180613947.11133.58.camel@localhost.localdomain>	<1180614044.11133.61.camel@localhost.localdomain>	<1180614091.11133.63.camel@localhost.localdomain>	<465EC637.7020504@de.ibm.com>	<20070531150206.GB6474@narn.hozed.org>
	<465EFF72.5070100@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <465EFF72.5070100@de.ibm.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: carsteno@de.ibm.com
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, Xen Mailing List <xen-devel@lists.xensource.com>, "jmk@plan9.bell-labs.com" <jmk@plan9.bell-labs.com>, Herbert Xu <herbert@gondor.apana.org.au>, kvm-devel <kvm-devel@lists.sourceforge.net>, mschwid2@linux.vnet.ibm.com, virtualization <virtualization@lists.linux-foundation.org>, Troy Benjegerdes <hozer@hozed.org>, Suzanne McIntosh <skranjac@us.ibm.com>, Christian Borntraeger <cborntra@de.ibm.com>
List-Id: virtualization@lists.linuxfoundation.org

Carsten Otte wrote:
> Troy Benjegerdes wrote:
>   
>> This kind of a claim needs some benchmark data to document it.
>>     
> We've implemented both for our vdisk driver on 390. At least on our 
> platform, merging in the host is preferable because vmenter/vmexit is 
> very fast and we would merge twice because we submit the result via 
> io_submit() system call from host userland.
>   


If a single hypercall can submit multiple requests, then this may work
well for the newcomer archs too.

-- 
Do not meddle in the internals of kernels, for they are subtle and quick to panic.
