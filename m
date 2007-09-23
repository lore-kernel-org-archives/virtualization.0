From: Avi Kivity <avi@qumranet.com>
Subject: Re: [kvm-devel] [PATCH 6/6] virtio ring helper
Date: Sun, 23 Sep 2007 12:05:24 +0200
Message-ID: <46F63A64.9070200__48535.9655497179$1190542105$gmane$org@qumranet.com>
References: <1190289808.7262.223.camel@localhost.localdomain>	
	<1190290140.7262.228.camel@localhost.localdomain>	
	<1190290369.7262.231.camel@localhost.localdomain>	
	<1190290495.7262.235.camel@localhost.localdomain>	
	<1190290606.7262.239.camel@localhost.localdomain>	
	<1190290761.7262.242.camel@localhost.localdomain>	
	<1190291234.7262.246.camel@localhost.localdomain>	
	<46F26AF6.60904@qumranet.com>
	<1190340251.19451.36.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1190340251.19451.36.camel@localhost.localdomain>
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
Cc: kvm-devel <kvm-devel@lists.sourceforge.net>, lguest <lguest@ozlabs.org>, virtualization <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

Rusty Russell wrote:
> On Thu, 2007-09-20 at 14:43 +0200, Avi Kivity wrote:
>   
>> Rusty Russell wrote:
>>     
>>> These helper routines supply most of the virtqueue_ops for hypervisors
>>> which want to use a ring for virtio.  Unlike the previous lguest
>>> implementation:
>>>
>>> 3) The page numbers are always 64 bit (PAE anyone?)
>>>   
>>>       
>> 32 bits of page numbers give 44 bits of physical address on x86.  That's 
>> 16TB per guest.  Admittedly it's smaller on a VAX.
>>     
>
> I like to feel that I make these mistakes to ensure others are paying
> attention.  However, it does mean that I can just put an address in
> there and increase the length field to 32 bits.  Much rejoicing.
>
>   

Why are we sending page numbers anyway?  See below.

>> I don't like the chaining and would prefer the descriptor to refer to an 
>> array of page descriptors.  However I can't complain since this isn't 
>> common code.
>>     
>
> The intent is for kvm to use it.  I'll certainly consider your patches,
> although I suspect that managing descriptor pages will make things ugly
> enough to cause you to reconsider.
>   

How about, instead:

    struct vring_desc {
         __u64 address;
         __u32 length;
         __u32 flags;
    };

Where one of the flags is VRING_DESC_INDIRECT, which means that the 
memory within (address, length) is a bunch of descriptors instead of raw 
data.

This has the following nice properties:
- no dependency on page size, for archs where the page size definition 
is muddy
- no indirection for ethernet rx on Linux, even with jumbograms (a 
buffer can span pages in one descriptor, as long as they're physically 
contiguous)
- reward OSes that can do contiguous I/O (with a 32-bit length, too)
- keeps the interface simple at the expense of the implementation 
(address vs. page+offset)
- no nasty 16-bit fields, which some archs don't like
- be free! cast off your chains!


-- 
error compiling committee.c: too many arguments to function
