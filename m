From: Avi Kivity <avi@redhat.com>
Subject: Re: Configuration vs. compat hints [was Re: [Qemu-devel] [PATCHv3
	03/13] qemu: add routines to manage PCI capabilities]
Date: Tue, 16 Jun 2009 15:28:21 +0300
Message-ID: <4A378FE5.5050303__29526.889723684$1245155524$gmane$org@redhat.com>
References: <1244821292.30522.56.camel@blaa>	
	<4A327E4A.7010300@codemonkey.ws>	<1244825303.26769.19.camel@blaa>	
	<20090614095016.GA7560@redhat.com>	<1245056916.6891.31.camel@blaa>	
	<4A3613EC.6030608@redhat.com>	<20090615103249.GB6351@redhat.com>	
	<4A363012.8050409@redhat.com>	<20090615114858.GG6351@redhat.com>	
	<4A3636FA.1040609@redhat.com>	<20090615124101.GH6351@redhat.com>	
	<4A364381.401@redhat.com>	<4A364401.6010500@codemonkey.ws>	
	<4A3647FB.9010808@redhat.com>	<4A364B53.9080007@codemonkey.ws>	
	<4A364FE0.40204@redhat.com> <4A3651EB.3070204@codemonkey.ws>	
	<4A36555A.4090303@redhat.com> <4A3659A0.3050108@codemonkey.ws>	
	<4A366348.1030202@redhat.com> <1245083229.3222.103.camel@blaa>	
	<4A368F12.2090504@codemonkey.ws> <1245154451.11407.22.camel@blaa>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1245154451.11407.22.camel@blaa>
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
Cc: Carsten Otte <cotte@de.ibm.com>, kvm@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>, Glauber Costa <glommer@redhat.com>, qemu-devel@nongnu.org, virtualization@lists.linux-foundation.org, Blue Swirl <blauwirbel@gmail.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Paul Brook <paul@codesourcery.com>, Anthony Liguori <anthony@codemonkey.ws>
List-Id: virtualization@lists.linuxfoundation.org

On 06/16/2009 03:14 PM, Mark McLoughlin wrote:
> On Mon, 2009-06-15 at 13:12 -0500, Anthony Liguori wrote:
>    
>> Mark McLoughlin wrote:
>>      
>>> So long as the restrictions would be known to the management app via
>>> some "what slots are available" mechanism in qemu, that sounds fine.
>>>
>>>        
>> I'm not sure a "what slots are available" mechanism is as straight
>> forward as has been claimed.
>>      
>
> If qemu can't provide that information, then the management app does not
> have sufficient information to do the slot allocation itself. In which
> case, it must leave it up to qemu to do it.
>    

A given -M machine will have well-known open slots (since it's an ABI), 
same as it has rtl8139 and ne2000 cards.  Worst case we hardcode those 
numbers (gasp, faint).

>> It doesn't matter though because it's orthogonal to the current proposal.
>>      
>
> It is not orthogonal to solving the actual problem at hand, though -
> i.e. how to allow management apps to provide stable PCI addresses.
>    

It's part of the solution, but hardly a difficult the most difficult part.

> This is a fine solution to the "stable guest ABI" problem ... assuming
> there's some way of querying the current default machine type.
>    

     $ qemu -print-default-machine

or maybe

     $ qemu -show default-machine
     $ qemu -show pci-bus
     $ qemu -show me a way out

-- 
error compiling committee.c: too many arguments to function
