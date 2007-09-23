From: Avi Kivity <avi@qumranet.com>
Subject: Re: [kvm-devel] [PATCH 6/6] virtio ring helper
Date: Sun, 23 Sep 2007 13:46:21 +0200
Message-ID: <46F6520D.5020103__9517.55799255825$1190548201$gmane$org@qumranet.com>
References: <1190289808.7262.223.camel@localhost.localdomain>	
	<1190290140.7262.228.camel@localhost.localdomain>	
	<1190290369.7262.231.camel@localhost.localdomain>	
	<1190290495.7262.235.camel@localhost.localdomain>	
	<1190290606.7262.239.camel@localhost.localdomain>	
	<1190290761.7262.242.camel@localhost.localdomain>	
	<1190291234.7262.246.camel@localhost.localdomain>	
	<46F26AF6.60904@qumranet.com>	
	<1190340251.19451.36.camel@localhost.localdomain>	
	<46F63A64.9070200@qumranet.com>
	<1190547607.27805.120.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1190547607.27805.120.camel@localhost.localdomain>
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
> On Sun, 2007-09-23 at 12:05 +0200, Avi Kivity wrote:
>   
>> Rusty Russell wrote:
>>     
>>> On Thu, 2007-09-20 at 14:43 +0200, Avi Kivity wrote:  
>>>       
>>>> 32 bits of page numbers give 44 bits of physical address on x86.  That's 
>>>> 16TB per guest.  Admittedly it's smaller on a VAX.
>>>>         
>>> I like to feel that I make these mistakes to ensure others are paying
>>> attention.  However, it does mean that I can just put an address in
>>> there and increase the length field to 32 bits.  Much rejoicing.
>>>   
>>>       
>> Why are we sending page numbers anyway?  See below.
>>     
>
> Perhaps I was unclear.  I already changed to a 64-bit address.  I
> haven't send out another set of patches because I'm changing to Arnd's
> explicit virtio bus too.  Will send out a new set tomorrow at this rate.
>
>   

It does say so quite explicitly in the quoted text.  Sorry.

>> Where one of the flags is VRING_DESC_INDIRECT, which means that the 
>> memory within (address, length) is a bunch of descriptors instead of raw 
>> data.
>>     
>
> If that's all we wanted, it's fairly easy to do as a future extension
> even if we didn't change it today.  My concern was the allocation and
> management of those sg pages; hence my desire for a patch 8)
>   

Won't kmalloc()/kfree() suffice?  IMO the tradeoff (compared to chaining 
with its reduction in ring size, and handling ood) is positive.

I'll try a patch based on the next patchset.

-- 
error compiling committee.c: too many arguments to function
