From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [Qemu-devel] [PATCHv3 03/13] qemu: add routines to manage PCI
	capabilities
Date: Wed, 10 Jun 2009 18:01:29 +0300
Message-ID: <20090610150129.GC28601__35574.581687297$1244646433$gmane$org@redhat.com>
References: <cover.1244192535.git.mst@redhat.com>
	<20090605102315.GD26770@redhat.com>
	<20090609171114.GS11966@poweredge.glommer>
	<20090610095415.GE6844@redhat.com>
	<20090610145540.GI19375@poweredge.glommer>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20090610145540.GI19375@poweredge.glommer>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Glauber Costa <glommer@redhat.com>
Cc: Carsten Otte <cotte@de.ibm.com>, kvm@vger.kernel.org, qemu-devel@nongnu.org, virtualization@lists.linux-foundation.org, Blue Swirl <blauwirbel@gmail.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Paul Brook <paul@codesourcery.com>, Anthony Liguori <anthony@codemonkey.ws>, Avi Kivity <avi@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

On Wed, Jun 10, 2009 at 11:55:40AM -0300, Glauber Costa wrote:
> On Wed, Jun 10, 2009 at 12:54:15PM +0300, Michael S. Tsirkin wrote:
> > On Tue, Jun 09, 2009 at 02:11:14PM -0300, Glauber Costa wrote:
> > > On Fri, Jun 05, 2009 at 01:23:15PM +0300, Michael S. Tsirkin wrote:
> > > > Add routines to manage PCI capability list. First user will be MSI-X.
> > > > 
> > > > Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> > > > ---
> > > >  hw/pci.c |   98 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++------
> > > >  hw/pci.h |   18 +++++++++++-
> > > >  2 files changed, 106 insertions(+), 10 deletions(-)
> > > > 
> > > > diff --git a/hw/pci.c b/hw/pci.c
> > > > index 361d741..ed011b5 100644
> > > > --- a/hw/pci.c
> > > > +++ b/hw/pci.c
> > > > @@ -130,12 +130,13 @@ void pci_device_save(PCIDevice *s, QEMUFile *f)
> > > >      int version = s->cap_present ? 3 : 2;
> > > >      int i;
> > > >  
> > > > -    qemu_put_be32(f, version); /* PCI device version */
> > > > +    /* PCI device version and capabilities */
> > > > +    qemu_put_be32(f, version);
> > > > +    if (version >= 3)
> > > > +        qemu_put_be32(f, s->cap_present);
> > > >      qemu_put_buffer(f, s->config, 256);
> > > >      for (i = 0; i < 4; i++)
> > > >          qemu_put_be32(f, s->irq_state[i]);
> > > > -    if (version >= 3)
> > > > -        qemu_put_be32(f, s->cap_present);
> > > >  }
> > > What is it doing here?
> > > You should just do it right in the first patch, instead of doing in
> > > one way there, and fixing here.
> > > 
> > > >  
> > > >  int pci_device_load(PCIDevice *s, QEMUFile *f)
> > > > @@ -146,12 +147,6 @@ int pci_device_load(PCIDevice *s, QEMUFile *f)
> > > >      version_id = qemu_get_be32(f);
> > > >      if (version_id > 3)
> > > >          return -EINVAL;
> > > > -    qemu_get_buffer(f, s->config, 256);
> > > > -    pci_update_mappings(s);
> > > > -
> > > > -    if (version_id >= 2)
> > > > -        for (i = 0; i < 4; i ++)
> > > > -            s->irq_state[i] = qemu_get_be32(f);
> > > >      if (version_id >= 3)
> > > >          s->cap_present = qemu_get_be32(f);
> > > >      else
> > > ditto.
> > > > @@ -160,6 +155,18 @@ int pci_device_load(PCIDevice *s, QEMUFile *f)
> > > >      if (s->cap_present & ~s->cap_supported)
> > > >          return -EINVAL;
> > > >  
> > > > +    qemu_get_buffer(f, s->config, 256);
> > > > +    pci_update_mappings(s);
> > > > +
> > > > +    if (version_id >= 2)
> > > > +        for (i = 0; i < 4; i ++)
> > > > +            s->irq_state[i] = qemu_get_be32(f);
> > > > +    /* Clear wmask and used bits for capabilities.
> > > > +       Must be restored separately, since capabilities can
> > > > +       be placed anywhere in config space. */
> > > > +    memset(s->used, 0, PCI_CONFIG_SPACE_SIZE);
> > > > +    for (i = PCI_CONFIG_HEADER_SIZE; i < PCI_CONFIG_SPACE_SIZE; ++i)
> > > > +        s->wmask[i] = 0xff;
> > > >      return 0;
> > > >  }
> > > Sorry, I don't exactly understand it. Although it can be anywhere, what do we actually
> > > lose by keeping it at the same place in config space?
> > 
> > We lose the ability to let user control the capabilities exposed
> > by the device.
> > 
> > And generally, I dislike arbitrary limitations. The PCI spec says the
> > capability can be anywhere, implementing a linked list of caps is simple
> > enough to not invent abritrary restrictions.
> yes, but this is migration time, right?

I think so, yes.

> 
> caps can be anywhere, but we don't expect it to change during machine execution
> lifetime.
> 
> Or I am just confused by the name "pci_device_load" ?

Right. So I want to load an image and it has capability X at offset Y.
wmask has to match. I don't want to assume that we never change Y
for the device without breaking old images, so I clear wmask here
and set it up again after looking up capabilities that I loaded.

Maybe this explanation should go into the comment above?

-- 
MST
