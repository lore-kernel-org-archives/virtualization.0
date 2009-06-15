From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: Configuration vs. compat hints [was Re: [Qemu-devel] [PATCHv3
	03/13] qemu: add routines to manage PCI capabilities]
Date: Mon, 15 Jun 2009 14:34:39 +0300
Message-ID: <20090615113439.GF6351__45476.7014169649$1245065960$gmane$org@redhat.com>
References: <1244825303.26769.19.camel@blaa> <20090614095016.GA7560@redhat.com>
	<1245056916.6891.31.camel@blaa> <4A3613EC.6030608@redhat.com>
	<20090615103249.GB6351@redhat.com>
	<20090615104456.GM19508@redhat.com>
	<20090615104653.GD6351@redhat.com>
	<20090615105213.GN19508@redhat.com>
	<20090615110753.GE6351@redhat.com>
	<20090615111415.GO19508@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20090615111415.GO19508@redhat.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Gleb Natapov <gleb@redhat.com>
Cc: Mark McLoughlin <markmc@redhat.com>, kvm@vger.kernel.org, Carsten Otte <cotte@de.ibm.com>, Glauber Costa <glommer@redhat.com>, Jamie Lokier <jamie@shareable.org>, qemu-devel@nongnu.org, virtualization@lists.linux-foundation.org, Blue Swirl <blauwirbel@gmail.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Avi Kivity <avi@redhat.com>, Anthony Liguori <anthony@codemonkey.ws>, Paul Brook <paul@codesourcery.com>
List-Id: virtualization@lists.linuxfoundation.org

On Mon, Jun 15, 2009 at 02:14:15PM +0300, Gleb Natapov wrote:
> On Mon, Jun 15, 2009 at 02:07:53PM +0300, Michael S. Tsirkin wrote:
> > On Mon, Jun 15, 2009 at 01:52:13PM +0300, Gleb Natapov wrote:
> > > On Mon, Jun 15, 2009 at 01:46:53PM +0300, Michael S. Tsirkin wrote:
> > > > On Mon, Jun 15, 2009 at 01:44:56PM +0300, Gleb Natapov wrote:
> > > > > On Mon, Jun 15, 2009 at 01:32:49PM +0300, Michael S. Tsirkin wrote:
> > > > > > > You do need to export available slot numbers from qemu.
> > > > > > 
> > > > > > Why would a slot be unavailable?
> > > > > > 
> > > > > Because it does not exist?
> > > > 
> > > > We can create a slot with any number, can't we?
> > > What do you mean? If the mobo has 4 slots you can't create fifth.
> > > KVM describes 32 slots in the BIOS.
> > 
> > Do you mean the KVM kernel module here? I don't know much about the
> No I don't mean KVM kernel module here.
> 
> > BIOS. Can't qemu control the number of slots declared?
> > 
> Qemu represents HW, BIOS drives this HW. They should be in sync on such
> important issues like pci slot configuration.

As a simple solution, let's stick to 32 slots per bus. That's the
maximum that the PCI spec allows, anyway.

> Even if QEMU can control the number of slots declared (which it can't
> easily do), it will be able to do it only on startup (before BIOS
> runs).

That's OK - this is when the machine description is read.

> The way to have dynamic
> number of slots may be pci bridge emulation. Not sure what is needed
> from BIOS for that.

Since bridge can be hot-plugged, probably nothing?
But we don't necessarily need dynamic number of slots IMO.

> 
> --
> 			Gleb.

-- 
MST
