From: Jamie Lokier <jamie@shareable.org>
Subject: Re: Configuration vs. compat hints [was Re: [Qemu-devel] [PATCHv3
	03/13] qemu: add routines to manage PCI capabilities]
Date: Wed, 17 Jun 2009 12:58:41 +0100
Message-ID: <20090617115841.GD27947__4772.8271260441$1245240101$gmane$org@shareable.org>
References: <1245083229.3222.103.camel@blaa> <4A368F12.2090504@codemonkey.ws>
	<1245154451.11407.22.camel@blaa> <4A378FE5.5050303@redhat.com>
	<1245155992.30082.8.camel@blaa>
	<20090616184404.GJ11893@shareable.org>
	<1245227632.27028.29.camel@blaa> <4A38B147.1030207@redhat.com>
	<1245230283.27028.36.camel@blaa> <4A38B6CF.6000503@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <4A38B6CF.6000503@redhat.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Avi Kivity <avi@redhat.com>
Cc: Mark McLoughlin <markmc@redhat.com>, kvm@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>, Glauber Costa <glommer@redhat.com>, qemu-devel@nongnu.org, virtualization@lists.linux-foundation.org, Blue Swirl <blauwirbel@gmail.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Paul Brook <paul@codesourcery.com>, Carsten Otte <cotte@de.ibm.com>
List-Id: virtualization@lists.linuxfoundation.org

Avi Kivity wrote:
> >If management apps need to hard-code which slots are available on
> >different targets and different qemu versions, or restrictions on which
> >devices can use which slots, or knowledge that some devices can be
> >multi-function, or ... anything like that is just lame.
> >   
> 
> You can't abstract these things away.  If you can't put a NIC in slot 4, 
> and you have 7 slots, then you cannot have 7 NICs.  Having qemu allocate 
> the slot numbers does not absolve management from knowing this 
> limitation and preventing the user from creating a machine with 7 slots.
> 
> Likewise, management will have to know which devices are multi-function, 
> since that affects their hotpluggability.  Ditto if some slot if faster 
> than others, if you want to make use of this information you have to let 
> the upper layers know.
> 
> It could be done using an elaborate machine description that qemu 
> exposes to management coupled with a constraint solver that optimizes 
> the machine layout according to user specifications and hardware 
> limitations.  Or we could take the view that real life is not perfect 
> (especially where computers are involved), add some machine specific 
> knowledge, and spend the rest of the summer at the beach.

To be honest, an elaborate machine description is probably fine...

A fancy constraint solver is not required.  A simple one strikes me as
about as simple as what you'd hard-code anyway, but with fewer special
cases.

Note that the result can fail due to things like insufficient address
space for all the device BARs even when they _are_ in the right slots.
Especially if there are lots of slots, or bridges which can provide
unlimited slots.

That is arcane: device-dependent, CPU-dependent, machine-dependent,
RAM-size dependent (in a non-linear way), device-option-dependent and
probably QEMU-version-dependent too.

It would be nice if libvirt (et al) would prevent the user from
creating a VM with insufficient BAR space for that machine, but I'm
not sure how to do it sanely, without arcane knowledge getting about.

Maybe that idea of a .so shared by qemu and libvirt, to manipulate
device configurations, is a sane one after all.

-- Jamie
