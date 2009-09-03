From: Juan Quintela <quintela@trasno.org>
Subject: Re: [PATCH 2/2] virtio-console: Add interface for generic guest-host
	communication
Date: Thu, 03 Sep 2009 16:06:54 +0200
Message-ID: <m3ab1c9l6p.fsf@neno.mitica>
References: <1251982412-11870-1-git-send-email-amit.shah@redhat.com>
	<1251982412-11870-2-git-send-email-amit.shah@redhat.com>
	<1251982412-11870-3-git-send-email-amit.shah@redhat.com>
	<1251982412-11870-4-git-send-email-amit.shah@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1251982412-11870-4-git-send-email-amit.shah@redhat.com> (Amit
	Shah's message of "Thu, 3 Sep 2009 18:23:32 +0530")
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
> This interface extends the virtio-console device to handle
> multiple ports that present a char device from which bits can
> be sent and read.
>
> Sample uses for such a device can be obtaining info from the
> guest like the file systems used, apps installed, etc. for
> offline usage and logged-in users, clipboard copy-paste, etc.
> for online usage.
>
> Each port is to be assigned a unique function, for example, the
> first 4 ports may be reserved for libvirt usage, the next 4 for
> generic streaming data and so on. This port-function mapping
> isn't finalised yet.
>
> For requirements, use-cases and some history see
>
>     http://www.linux-kvm.org/page/VMchannel_Requirements
>
> Signed-off-by: Amit Shah <amit.shah@redhat.com>
> ---
>  hw/pc.c             |   16 +-
>  hw/virtio-console.c |  594 ++++++++++++++++++++++++++++++++++++++++++++++-----
>  hw/virtio-console.h |   52 +++++
>  monitor.c           |    7 +
>  qemu-monitor.hx     |   10 +
>  qemu-options.hx     |    2 +-
>  sysemu.h            |   10 +-
>  vl.c                |   41 ++--
>  8 files changed, 652 insertions(+), 80 deletions(-)
>
> diff --git a/hw/pc.c b/hw/pc.c
> index 503feb0..0e60ecc 100644
> --- a/hw/pc.c
> +++ b/hw/pc.c
> @@ -1462,11 +1462,17 @@ static void pc_init1(ram_addr_t ram_size,
>      }
>  
>      /* Add virtio console devices */
> -    if (pci_enabled) {
> -        for(i = 0; i < MAX_VIRTIO_CONSOLES; i++) {
> -            if (virtcon_hds[i]) {
> -                pci_create_simple(pci_bus, -1, "virtio-console-pci");
> -            }
> +    if (pci_enabled && virtcon_nr_ports) {
> +        void *dev;
> +
> +        dev = pci_create_simple(pci_bus, -1, "virtio-console-pci");
> +        if (!dev) {
> +            fprintf(stderr, "qemu: could not create virtio console pci device\n");
> +            exit(1);
> +        }
> +
> +        for (i = 0; i < virtcon_nr_ports; i++) {
> +                virtio_console_new_port(dev, virtcon_idx[i]);
>          }
>      }
>  
> diff --git a/hw/virtio-console.c b/hw/virtio-console.c
> index 663c8b9..da590d2 100644
> --- a/hw/virtio-console.c
> +++ b/hw/virtio-console.c
> @@ -2,9 +2,11 @@
>   * Virtio Console Device
>   *
>   * Copyright IBM, Corp. 2008
> + * Copyright Red Hat, Inc. 2009
>   *
>   * Authors:
>   *  Christian Ehrhardt <ehrhardt@linux.vnet.ibm.com>
> + *  Amit Shah <amit.shah@redhat.com>
>   *
>   * This work is licensed under the terms of the GNU GPL, version 2.  See
>   * the COPYING file in the top-level directory.
> @@ -12,39 +14,263 @@
>   */
>  
>  #include "hw.h"
> +#include "monitor.h"
> +#include "pci.h"
> +#include "sys-queue.h"
>  #include "qemu-char.h"
>  #include "virtio.h"
>  #include "virtio-console.h"
>  
> -
>  typedef struct VirtIOConsole
>  {
>      VirtIODevice vdev;
> -    VirtQueue *ivq, *dvq;
> -    CharDriverState *chr;
> +    PCIDevice *dev;

Why do you need dev here?  VirtIODevice already have hidded somewhere
a PCIDevice (hidded is a good defenition).
virtio-blk and virtio-net are able to work with that pci device.

> +/* Readiness of the guest to accept data on a port */
> +static int vcon_can_read(void *opaque)
> +{
> +    VirtIOConsolePort *port = (VirtIOConsolePort *) opaque;

Cast is not needed here.

> +/* Send data from a char device over to the guest */
> +static void vcon_read(void *opaque, const uint8_t *buf, int size)
> +{
> +    VirtIOConsolePort *port = (VirtIOConsolePort *) opaque;

Cast is not needed here. (there are still more instances on the file)


> +        return;
> +    }
> +    send_control_event(port, &cpkt);
> +}
> +
> +static void virtio_console_set_port_active(uint32_t idx)
> +{
> +    int i = 0;
> +
> +    while (idx / 32) {
> +        i++;
> +        idx -= 32;
> +    }

It is just me, or you are doing a division + modulus in a very strange way?

   i = idx / 32;
   idx = idx % 32;

???

> +    virtcon_config.ports_map[i] |= 1U << idx;
> +}
> +
> +static bool virtio_console_is_port_active(uint32_t idx)
> +{
> +    int i = 0;
> +
> +    while (idx / 32) {
> +        i++;
> +        idx -= 32;
> +    }

Same comment about division.

>  static void virtio_console_save(QEMUFile *f, void *opaque)
>  {
>      VirtIOConsole *s = opaque;
> +    unsigned int i;
>  
> +    /* The virtio device */
>      virtio_save(&s->vdev, f);
> +    /* The PCI device */
> +    pci_device_save(s->dev, f);

If you don't use pci here, virtio_save() should save your pci stuff
here.  See the ->load_config() stuff.

Yeap, it can confuse anybody.

For the new table based vmstate, fields need to live in an struct, in
this case VirtIOConsole.

Can you move virtcon_config and virtcon_ports to VirtIOConsole.

> +    /* The config space */
> +    qemu_put_be16s(f, &virtcon_config.cols);
> +    qemu_put_be16s(f, &virtcon_config.rows);

> +    qemu_put_be32s(f, &virtcon_config.max_nr_ports);
> +    qemu_put_be32s(f, &virtcon_config.nr_active_ports);
> +    for (i = 0; i < (le32_to_cpu(virtcon_config.max_nr_ports) + 31) / 32; i++) {
> +        qemu_put_be32s(f, &virtcon_config.ports_map[i]);
> +    }

Don't even try to save a couple of bytes, please.

for (i = 0; i <  (MAX_VIRTIO_CONSOLES + 31) / 32; i++) {
    qemu_put_be32s(f, &virtcon_config.ports_map[i]);
}

Same for load, please.  Makes the translation to table based way easier.

> +    /* Items in struct VirtIOConsole */
> +    qemu_put_be32s(f, &virtio_console->guest_features);

here you mean s->guest_features, right?

> +    /* Items in struct VirtIOConsolePort */
> +    for (i = 0; i < le32_to_cpu(virtcon_config.max_nr_ports); i++) {
> +        qemu_put_byte(f, virtcon_ports[i].guest_connected);
> +    }

If you want to optimize saving of this field, it is possible that it is
a better idea to create another bitmap for it.  What do you think?

I can't see VMState adding support for bools any time soon, but arrays
of bool is a possibility.

> @@ -128,19 +610,29 @@ VirtIODevice *virtio_console_init(DeviceState *dev)
>      VirtIOConsole *s;
>      s = (VirtIOConsole *)virtio_common_init("virtio-console",
>                                              VIRTIO_ID_CONSOLE,
> -                                            0, sizeof(VirtIOConsole));
> +                                            sizeof(struct virtio_console_config),
> +                                            sizeof(VirtIOConsole));

Here, you mean:

VirtIODevice *d = virtio_common_init(....);
VirtIOConsole *s = DO_UPCAST(VirtIOConsole, vdev, d);

:)

Creation of VirtIODevice *d is not necesary, I found it easier to
understand  but it is up to you.

>      if (s == NULL)
>          return NULL;
>  

Once you are there, virtio_common_init() can't return NULL, fix it please.

>  
> -#define MAX_VIRTIO_CONSOLES 1
> +#define MAX_VIRTIO_CONSOLE_PORTS 64

Require that this number is a multiple of 32, and you can simplify all
the (foo + 31/32) staff.


Later, Juan.
