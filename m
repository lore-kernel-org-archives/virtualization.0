From: Mark McLoughlin <markmc@redhat.com>
Subject: Re: Configuration vs. compat hints [was Re: [Qemu-devel] [PATCHv3
	03/13] qemu: add routines to manage PCI capabilities]
Date: Tue, 16 Jun 2009 13:14:11 +0100
Message-ID: <1245154451.11407.22.camel__43313.4340252311$1245154797$gmane$org@blaa>
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
	<4A368F12.2090504@codemonkey.ws>
Reply-To: Mark McLoughlin <markmc@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <4A368F12.2090504@codemonkey.ws>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Anthony Liguori <anthony@codemonkey.ws>
Cc: Carsten Otte <cotte@de.ibm.com>, kvm@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>, Glauber Costa <glommer@redhat.com>, qemu-devel@nongnu.org, virtualization@lists.linux-foundation.org, Blue Swirl <blauwirbel@gmail.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Avi Kivity <avi@redhat.com>, Paul Brook <paul@codesourcery.com>
List-Id: virtualization@lists.linuxfoundation.org

On Mon, 2009-06-15 at 13:12 -0500, Anthony Liguori wrote:
> Mark McLoughlin wrote:
> > So long as the restrictions would be known to the management app via
> > some "what slots are available" mechanism in qemu, that sounds fine.
> >   
> 
> I'm not sure a "what slots are available" mechanism is as straight 
> forward as has been claimed.

If qemu can't provide that information, then the management app does not
have sufficient information to do the slot allocation itself. In which
case, it must leave it up to qemu to do it.

> It doesn't matter though because it's orthogonal to the current proposal.

It is not orthogonal to solving the actual problem at hand, though -
i.e. how to allow management apps to provide stable PCI addresses.

> >>> I'm not at all arguing against pci_addr.  I'm arguing about how 
> >>> libvirt should use it with respect to the "genesis" use-case where 
> >>> libvirt has no specific reason to choose one PCI slot over another.  
> >>> In that case, I'm merely advocating that we want to let QEMU make the 
> >>> decision.
> >>>       
> >> However this may end up, isn't it offtopic?  Whatever we do we have to 
> >> support both pci_addr= and default placement, so we can push this 
> >> discussion to livirt-devel and bid them godspeed.
> >>     
> >
> > Presumably you're not proposing that qemu-devel completely ignore the
> > typical requirements of management apps?
> >   
> 
> This is a happy case where the current proposals allow both usages to 
> occur.  Which one libvirt chooses it up to it.
> 
> To summarize, I think we have:
> 
> 1) Introduce addressing to all host device configurations
>   - Either in the canonical form "pci_addr=bus:dev.fn or target=3,lun=1" 
> or in flattened form "addr=bus:dev.fn or addr=target.lun".  I prefer the 
> later form but I think either would be acceptable.

That helps, but it's not enough on its own.

The management app needs to figure out what addresses to pass either by:

   a) Initially allowing qemu to do the address allocation, and 
      thereafter using those addresses - this requires some way to query
      the addresses of devices

or b) Doing the initial address allocation itself - this requires some 
      way to query what slots are available.

> 2) Whenever the default machine type changes in a guest-visible way, 
> introduce a new machine type
>   - Use explicit versions in name: pc-v1, pc-v2 or use more descriptive 
> names pc-with-usb
>   - Easily transitions to device config files

To be clear - you're not proposing this is a solution to the "stable PCI
addresses" problem, are you? The main requirement is for the addresses
to stay stable even if the user adds/removes other devices.

This is a fine solution to the "stable guest ABI" problem ... assuming
there's some way of querying the current default machine type.

Cheers,
Mark.
