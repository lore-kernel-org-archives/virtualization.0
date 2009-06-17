From: Avi Kivity <avi@redhat.com>
Subject: Re: Configuration vs. compat hints [was Re: [Qemu-devel] [PATCHv3
	03/13] qemu: add routines to manage PCI capabilities]
Date: Wed, 17 Jun 2009 12:26:39 +0300
Message-ID: <4A38B6CF.6000503__26434.5890297138$1245230986$gmane$org@redhat.com>
References: <4A364FE0.40204@redhat.com> <4A3651EB.3070204@codemonkey.ws>	
	<4A36555A.4090303@redhat.com> <4A3659A0.3050108@codemonkey.ws>	
	<4A366348.1030202@redhat.com> <1245083229.3222.103.camel@blaa>	
	<4A368F12.2090504@codemonkey.ws>
	<1245154451.11407.22.camel@blaa>	 <4A378FE5.5050303@redhat.com>
	<1245155992.30082.8.camel@blaa>	
	<20090616184404.GJ11893@shareable.org>
	<1245227632.27028.29.camel@blaa>	 <4A38B147.1030207@redhat.com>
	<1245230283.27028.36.camel@blaa>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1245230283.27028.36.camel@blaa>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Mark McLoughlin <markmc@redhat.com>
Cc: Carsten Otte <cotte@de.ibm.com>, kvm@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>, Glauber Costa <glommer@redhat.com>, Jamie Lokier <jamie@shareable.org>, qemu-devel@nongnu.org, virtualization@lists.linux-foundation.org, Blue Swirl <blauwirbel@gmail.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Paul Brook <paul@codesourcery.com>
List-Id: virtualization@lists.linuxfoundation.org

On 06/17/2009 12:18 PM, Mark McLoughlin wrote:
> On Wed, 2009-06-17 at 12:03 +0300, Avi Kivity wrote:
>    
>> On 06/17/2009 11:33 AM, Mark McLoughlin wrote:
>>      
>>>> I particularly don't like the idea of arcane machine-dependent slot
>>>> allocation knowledge living in libvirt, because it needs to be in Qemu
>>>> anyway for non-libvirt users.  No point in having two implementations
>>>> of something tricky and likely to have machine quirks, if one will do.
>>>>          
>>> Indeed.
>>>        
>> I don't understand this.
>>      
>
> Take note of the "arcane machine-dependent slot allocation knowledge"
> bit.
>
> If the algorithm in for management apps is as simple as "query qemu for
> available slots and sequentially allocate slots", then that's perfectly
> fine.
>    

That's the thinking.

> If management apps need to hard-code which slots are available on
> different targets and different qemu versions, or restrictions on which
> devices can use which slots, or knowledge that some devices can be
> multi-function, or ... anything like that is just lame.
>    

You can't abstract these things away.  If you can't put a NIC in slot 4, 
and you have 7 slots, then you cannot have 7 NICs.  Having qemu allocate 
the slot numbers does not absolve management from knowing this 
limitation and preventing the user from creating a machine with 7 slots.

Likewise, management will have to know which devices are multi-function, 
since that affects their hotpluggability.  Ditto if some slot if faster 
than others, if you want to make use of this information you have to let 
the upper layers know.

It could be done using an elaborate machine description that qemu 
exposes to management coupled with a constraint solver that optimizes 
the machine layout according to user specifications and hardware 
limitations.  Or we could take the view that real life is not perfect 
(especially where computers are involved), add some machine specific 
knowledge, and spend the rest of the summer at the beach.

-- 
Do not meddle in the internals of kernels, for they are subtle and quick to panic.
