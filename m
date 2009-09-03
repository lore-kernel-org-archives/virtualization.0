From: Amit Shah <amit.shah@redhat.com>
Subject: Re: [PATCH 2/2] virtio-console: Add interface for generic
	guest-host communication
Date: Thu, 3 Sep 2009 19:56:05 +0530
Message-ID: <20090903142605.GB8613__27924.9247666032$1251988183$gmane$org@amit-x200.redhat.com>
References: <1251982412-11870-1-git-send-email-amit.shah@redhat.com>
	<1251982412-11870-2-git-send-email-amit.shah@redhat.com>
	<1251982412-11870-3-git-send-email-amit.shah@redhat.com>
	<1251982412-11870-4-git-send-email-amit.shah@redhat.com>
	<m3ab1c9l6p.fsf@neno.mitica>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <m3ab1c9l6p.fsf@neno.mitica>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Juan Quintela <quintela@trasno.org>
Cc: qemu-devel@nongnu.org, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

Hi Juan,

On (Thu) Sep 03 2009 [16:06:54], Juan Quintela wrote:
> > diff --git a/hw/virtio-console.c b/hw/virtio-console.c
> > index 663c8b9..da590d2 100644
> > --- a/hw/virtio-console.c
> > +++ b/hw/virtio-console.c
> >  
> >  #include "hw.h"
> > +#include "monitor.h"
> > +#include "pci.h"
> > +#include "sys-queue.h"
> >  #include "qemu-char.h"
> >  #include "virtio.h"
> >  #include "virtio-console.h"
> >  
> > -
> >  typedef struct VirtIOConsole
> >  {
> >      VirtIODevice vdev;
> > -    VirtQueue *ivq, *dvq;
> > -    CharDriverState *chr;
> > +    PCIDevice *dev;
> 
> Why do you need dev here?  VirtIODevice already have hidded somewhere
> a PCIDevice (hidded is a good defenition).
> virtio-blk and virtio-net are able to work with that pci device.

Let me check that; I need pci device while initialising a new port (and
it's slightly different when done at init and when done at hot-add
time).

> > +/* Readiness of the guest to accept data on a port */
> > +static int vcon_can_read(void *opaque)
> > +{
> > +    VirtIOConsolePort *port = (VirtIOConsolePort *) opaque;
> 
> Cast is not needed here.

This is original code that I've not modified (just moved around).

But you're right; I could do that in this patch itself.

> > +static void virtio_console_set_port_active(uint32_t idx)
> > +{
> > +    int i = 0;
> > +
> > +    while (idx / 32) {
> > +        i++;
> > +        idx -= 32;
> > +    }
> 
> It is just me, or you are doing a division + modulus in a very strange way?
> 
>    i = idx / 32;
>    idx = idx % 32;
> 
> ???



> >  static void virtio_console_save(QEMUFile *f, void *opaque)
> >  {
> >      VirtIOConsole *s = opaque;
> > +    unsigned int i;
> >  
> > +    /* The virtio device */
> >      virtio_save(&s->vdev, f);
> > +    /* The PCI device */
> > +    pci_device_save(s->dev, f);
> 
> If you don't use pci here, virtio_save() should save your pci stuff
> here.  See the ->load_config() stuff.
> 
> Yeap, it can confuse anybody.

Actually no. Since virtio rides on top of pci, I'd expect virtio_save to
save pci state too :-)

I'll check this too.

> For the new table based vmstate, fields need to live in an struct, in
> this case VirtIOConsole.
> 
> Can you move virtcon_config and virtcon_ports to VirtIOConsole.

In that case VirtIOConsole has to become a static (instead of being
allocated via the call to virtio_common_init. Doable.

> > +    /* The config space */
> > +    qemu_put_be16s(f, &virtcon_config.cols);
> > +    qemu_put_be16s(f, &virtcon_config.rows);
> 
> > +    qemu_put_be32s(f, &virtcon_config.max_nr_ports);
> > +    qemu_put_be32s(f, &virtcon_config.nr_active_ports);
> > +    for (i = 0; i < (le32_to_cpu(virtcon_config.max_nr_ports) + 31) / 32; i++) {
> > +        qemu_put_be32s(f, &virtcon_config.ports_map[i]);
> > +    }
> 
> Don't even try to save a couple of bytes, please.

Sorry, don't understand this.

> 
> for (i = 0; i <  (MAX_VIRTIO_CONSOLES + 31) / 32; i++) {
>     qemu_put_be32s(f, &virtcon_config.ports_map[i]);
> }
> 
> Same for load, please.  Makes the translation to table based way easier.

OK, maybe I now get it. You're asking me not to le32_to_cpu() here,
correct?

I do it this way because we could be migrated from a host that supports
64 max ports to a host that supports 128 max ports and then back to the
one that supports 64 max ports. :-)

> > +    /* Items in struct VirtIOConsole */
> > +    qemu_put_be32s(f, &virtio_console->guest_features);
> 
> here you mean s->guest_features, right?

Right!

> > +    /* Items in struct VirtIOConsolePort */
> > +    for (i = 0; i < le32_to_cpu(virtcon_config.max_nr_ports); i++) {
> > +        qemu_put_byte(f, virtcon_ports[i].guest_connected);
> > +    }
> 
> If you want to optimize saving of this field, it is possible that it is
> a better idea to create another bitmap for it.  What do you think?

Yes, I wanted to do that as well. The same functions that compute the
modulo/division earlier can give us this thing as well. But it'll only
be used for loadvm/savevm. I expect the bool to continue to reside in
this struct for normal operation.

> I can't see VMState adding support for bools any time soon, but arrays
> of bool is a possibility.

Consider the RFE filed :-)

> > @@ -128,19 +610,29 @@ VirtIODevice *virtio_console_init(DeviceState *dev)
> >      VirtIOConsole *s;
> >      s = (VirtIOConsole *)virtio_common_init("virtio-console",
> >                                              VIRTIO_ID_CONSOLE,
> > -                                            0, sizeof(VirtIOConsole));
> > +                                            sizeof(struct virtio_console_config),
> > +                                            sizeof(VirtIOConsole));
> 
> Here, you mean:
> 
> VirtIODevice *d = virtio_common_init(....);
> VirtIOConsole *s = DO_UPCAST(VirtIOConsole, vdev, d);
> 
> :)

Again original code, not my contributions :-)

> Creation of VirtIODevice *d is not necesary, I found it easier to
> understand  but it is up to you.

For virtio-serial, I statically allocated VirtIOSerial and had a vdev
pointer inside it which virtio_common_init gave me. I can do the same
here.

> >      if (s == NULL)
> >          return NULL;
> >  
> 
> Once you are there, virtio_common_init() can't return NULL, fix it please.

Original code. But I will take it.

> > -#define MAX_VIRTIO_CONSOLES 1
> > +#define MAX_VIRTIO_CONSOLE_PORTS 64
> 
> Require that this number is a multiple of 32, and you can simplify all
> the (foo + 31/32) staff.

Sure, but it's better to be careful in a couple of places just because
we can be. Does (foo+31)/32 make it very difficult to read?

		Amit
-- 
http://log.amitshah.net/
