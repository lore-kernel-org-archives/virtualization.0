From: Anthony Liguori <anthony@codemonkey.ws>
Subject: Re: Configuration vs. compat hints [was Re: [Qemu-devel] [PATCHv3
	03/13] qemu: add routines to manage PCI capabilities]
Date: Mon, 15 Jun 2009 13:12:34 -0500
Message-ID: <4A368F12.2090504__2007.73179899461$1245089687$gmane$org@codemonkey.ws>
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
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1245083229.3222.103.camel@blaa>
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
Cc: Carsten Otte <cotte@de.ibm.com>, kvm@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>, Glauber Costa <glommer@redhat.com>, qemu-devel@nongnu.org, virtualization@lists.linux-foundation.org, Blue Swirl <blauwirbel@gmail.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Avi Kivity <avi@redhat.com>, Paul Brook <paul@codesourcery.com>
List-Id: virtualization@lists.linuxfoundation.org

Mark McLoughlin wrote:
> So long as the restrictions would be known to the management app via
> some "what slots are available" mechanism in qemu, that sounds fine.
>   

I'm not sure a "what slots are available" mechanism is as straight 
forward as has been claimed.  It doesn't matter though because it's 
orthogonal to the current proposal.

>>> I'm not at all arguing against pci_addr.  I'm arguing about how 
>>> libvirt should use it with respect to the "genesis" use-case where 
>>> libvirt has no specific reason to choose one PCI slot over another.  
>>> In that case, I'm merely advocating that we want to let QEMU make the 
>>> decision.
>>>       
>> However this may end up, isn't it offtopic?  Whatever we do we have to 
>> support both pci_addr= and default placement, so we can push this 
>> discussion to livirt-devel and bid them godspeed.
>>     
>
> Presumably you're not proposing that qemu-devel completely ignore the
> typical requirements of management apps?
>   

This is a happy case where the current proposals allow both usages to 
occur.  Which one libvirt chooses it up to it.

To summarize, I think we have:

1) Introduce addressing to all host device configurations
  - Either in the canonical form "pci_addr=bus:dev.fn or target=3,lun=1" 
or in flattened form "addr=bus:dev.fn or addr=target.lun".  I prefer the 
later form but I think either would be acceptable.

2) Whenever the default machine type changes in a guest-visible way, 
introduce a new machine type
  - Use explicit versions in name: pc-v1, pc-v2 or use more descriptive 
names pc-with-usb
  - Easily transitions to device config files

Regards,

Anthony Liguori
