From: Juan Quintela <quintela@trasno.org>
Subject: Re: [PATCH 2/2] virtio-console: Add interface for generic guest-host
	communication
Date: Thu, 03 Sep 2009 17:20:44 +0200
Message-ID: <m3my5c6omr.fsf__13351.8389463008$1251991365$gmane$org@neno.mitica>
References: <1251982412-11870-1-git-send-email-amit.shah@redhat.com>
	<1251982412-11870-2-git-send-email-amit.shah@redhat.com>
	<1251982412-11870-3-git-send-email-amit.shah@redhat.com>
	<1251982412-11870-4-git-send-email-amit.shah@redhat.com>
	<m3ab1c9l6p.fsf@neno.mitica>
	<20090903142605.GB8613@amit-x200.redhat.com>
	<20090903144255.GB13361@amit-x200.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20090903144255.GB13361@amit-x200.redhat.com> (Amit Shah's
	message of "Thu, 3 Sep 2009 20:12:55 +0530")
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Amit Shah <amit.shah@redhat.com>
Cc: qemu-devel@nongnu.org, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

Amit Shah <amit.shah@redhat.com> wrote:

Hi

>> > > +static void virtio_console_set_port_active(uint32_t idx)
>> > > +{
>> > > +    int i = 0;
>> > > +
>> > > +    while (idx / 32) {
>> > > +        i++;
>> > > +        idx -= 32;
>> > > +    }
>> > 
>> > It is just me, or you are doing a division + modulus in a very strange way?
>> > 
>> >    i = idx / 32;
>> >    idx = idx % 32;
>> > 
>> > ???
>
> Er, sorry I left this out.
>
> That won't work for MAX_PORTS > 32.

Why not?

idx = 42
i = 42 / 32 = 1
new_idx = 42 % 32 = 10

virtcon_config.ports_map[i] & (1U<< new_idx)

it gives exactly the same same result than before.

What you are hardcoding is a "very" complex way of doing a division with
remainder, or have I lost something?

> But I guess I can just do
>
> i = idx / MAX_VIRTIO_CONSOLE_PORTS;
> idx = idx % MAX_VIRTIO_CONSOLE_PORTS;
>
>> > >  static void virtio_console_save(QEMUFile *f, void *opaque)
>> > >  {
>> > >      VirtIOConsole *s = opaque;
>> > > +    unsigned int i;
>> > >  
>> > > +    /* The virtio device */
>> > >      virtio_save(&s->vdev, f);
>> > > +    /* The PCI device */
>> > > +    pci_device_save(s->dev, f);
>> > 
>> > If you don't use pci here, virtio_save() should save your pci stuff
>> > here.  See the ->load_config() stuff.
>> > 
>> > Yeap, it can confuse anybody.
>> 
>> Actually no. Since virtio rides on top of pci, I'd expect virtio_save to
>> save pci state too :-)
>> 
>> I'll check this too.
>> 
>> > For the new table based vmstate, fields need to live in an struct, in
>> > this case VirtIOConsole.
>> > 
>> > Can you move virtcon_config and virtcon_ports to VirtIOConsole.
>> 
>> In that case VirtIOConsole has to become a static (instead of being
>> allocated via the call to virtio_common_init. Doable.
>> 
>> > > +    /* The config space */
>> > > +    qemu_put_be16s(f, &virtcon_config.cols);
>> > > +    qemu_put_be16s(f, &virtcon_config.rows);
>> > 
>> > > +    qemu_put_be32s(f, &virtcon_config.max_nr_ports);
>> > > +    qemu_put_be32s(f, &virtcon_config.nr_active_ports);
>> > > +    for (i = 0; i < (le32_to_cpu(virtcon_config.max_nr_ports) + 31) / 32; i++) {
>> > > +        qemu_put_be32s(f, &virtcon_config.ports_map[i]);
>> > > +    }
>> > 
>> > Don't even try to save a couple of bytes, please.
>> 
>> Sorry, don't understand this.
>> 
>> > 
>> > for (i = 0; i <  (MAX_VIRTIO_CONSOLES + 31) / 32; i++) {
>> >     qemu_put_be32s(f, &virtcon_config.ports_map[i]);
>> > }
>> > 
>> > Same for load, please.  Makes the translation to table based way easier.
>> 
>> OK, maybe I now get it. You're asking me not to le32_to_cpu() here,
>> correct?
>> 
>> I do it this way because we could be migrated from a host that supports
>> 64 max ports to a host that supports 128 max ports and then back to the
>> one that supports 64 max ports. :-)
>> 
>> > > +    /* Items in struct VirtIOConsole */
>> > > +    qemu_put_be32s(f, &virtio_console->guest_features);
>> > 
>> > here you mean s->guest_features, right?
>> 
>> Right!
>> 
>> > > +    /* Items in struct VirtIOConsolePort */
>> > > +    for (i = 0; i < le32_to_cpu(virtcon_config.max_nr_ports); i++) {
>> > > +        qemu_put_byte(f, virtcon_ports[i].guest_connected);
>> > > +    }
>> > 
>> > If you want to optimize saving of this field, it is possible that it is
>> > a better idea to create another bitmap for it.  What do you think?
>> 
>> Yes, I wanted to do that as well. The same functions that compute the
>> modulo/division earlier can give us this thing as well. But it'll only
>> be used for loadvm/savevm. I expect the bool to continue to reside in
>> this struct for normal operation.
>> 
>> > I can't see VMState adding support for bools any time soon, but arrays
>> > of bool is a possibility.
>> 
>> Consider the RFE filed :-)
>> 
>> > > @@ -128,19 +610,29 @@ VirtIODevice *virtio_console_init(DeviceState *dev)
>> > >      VirtIOConsole *s;
>> > >      s = (VirtIOConsole *)virtio_common_init("virtio-console",
>> > >                                              VIRTIO_ID_CONSOLE,
>> > > -                                            0, sizeof(VirtIOConsole));
>> > > +                                            sizeof(struct virtio_console_config),
>> > > +                                            sizeof(VirtIOConsole));
>> > 
>> > Here, you mean:
>> > 
>> > VirtIODevice *d = virtio_common_init(....);
>> > VirtIOConsole *s = DO_UPCAST(VirtIOConsole, vdev, d);
>> > 
>> > :)
>> 
>> Again original code, not my contributions :-)
>> 
>> > Creation of VirtIODevice *d is not necesary, I found it easier to
>> > understand  but it is up to you.
>> 
>> For virtio-serial, I statically allocated VirtIOSerial and had a vdev
>> pointer inside it which virtio_common_init gave me. I can do the same
>> here.
>> 
>> > >      if (s == NULL)
>> > >          return NULL;
>> > >  
>> > 
>> > Once you are there, virtio_common_init() can't return NULL, fix it please.
>> 
>> Original code. But I will take it.
>> 
>> > > -#define MAX_VIRTIO_CONSOLES 1
>> > > +#define MAX_VIRTIO_CONSOLE_PORTS 64
>> > 
>> > Require that this number is a multiple of 32, and you can simplify all
>> > the (foo + 31/32) staff.
>> 
>> Sure, but it's better to be careful in a couple of places just because
>> we can be. Does (foo+31)/32 make it very difficult to read?
>> 
>> 		Amit
>> -- 
>> http://log.amitshah.net/
>> 
>> 
>
> 		Amit
