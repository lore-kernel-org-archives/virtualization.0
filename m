From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH] virtio-pci: fix host notifiers on bi-endian architectures
Date: Thu, 12 Mar 2015 08:08:15 +0100
Message-ID: <20150312075922-mutt-send-email-mst@redhat.com>
References: <20150311180212.8119.14734.stgit@bahia.local>
	<20150311210322-mutt-send-email-mst@redhat.com>
	<20150311230314.08e51843@bahia.local>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20150311230314.08e51843@bahia.local>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Greg Kurz <gkurz@linux.vnet.ibm.com>
Cc: pbonzini@redhat.com, Cedric Le Goater <clg@fr.ibm.com>, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Wed, Mar 11, 2015 at 11:03:14PM +0100, Greg Kurz wrote:
> On Wed, 11 Mar 2015 21:06:05 +0100
> "Michael S. Tsirkin" <mst@redhat.com> wrote:
> =

> > On Wed, Mar 11, 2015 at 07:04:38PM +0100, Greg Kurz wrote:
> > > vhost is seriously broken with ppc64le guests, even in the supposedly
> > > supported case where the host is ppc64le and we don't need cross-endi=
an
> > > support.
> > > =

> > > The TX virtqueue fails to be handled by vhost and falls back to QEMU.
> > > Despite this unexpected scenario where RX is vhost and TX is QEMU, the
> > > guest runs well with reduced upload performances... until you reboot,
> > > migrate, managed save or in fact any operation that causes vhost_net
> > > to be re-started. Network connectivity is then permanantly lost for
> > > the guest.
> > > =

> > > TX falling back to QEMU is the result of a failed MMIO store emulation
> > > in KVM. Debugging shows that:
> > > =

> > > kvmppc_emulate_mmio()
> > >  |
> > >  +-> kvmppc_handle_store()
> > >       |
> > >       +-> kvm_io_bus_write()
> > >            |
> > >            +-> __kvm_io_bus_write() returns -EOPNOTSUPP
> > > =

> > > This happens because no matching device was found:
> > > =

> > > __kvm_io_bus_write()
> > >  |
> > >  +->kvm_iodevice_write()
> > >      |
> > >      +->ioeventfd_write()
> > >          |
> > >          +->ioeventfd_in_range() returns false for all registered vri=
ngs
> > > =

> > > Extra debugging shows that the TX vring number (16-bit) is supposed to
> > > be 0x0100 but QEMU passes 0x0001 to KVM... This happens *again* becau=
se
> > > QEMU still assumes powerpc is big endian (TARGET_WORDS_BIGENDIAN) by
> > > default.
> > > =

> > > This patch adds an extra swap in virtio_pci_set_host_notifier_interna=
l()
> > > to negate the one that is done in adjust_endianness(). Since this is =
not
> > > a hot path and we want to keep virtio-pci.o in common-obj, we don't c=
are
> > > whether the guest is bi-endian or not.
> > > =

> > > Reported-by: C=E9dric Le Goater <clg@fr.ibm.com>
> > > Suggested-by: Michael Roth <mdroth@linux.vnet.ibm.com>
> > > Signed-off-by: Greg Kurz <gkurz@linux.vnet.ibm.com>
> > =

> > I am confused.
> > The value that notifications use is always LE.
> =

> True but adjust_endianness() does swap unconditionally for ppc64
> because of TARGET_WORDS_BIGENDIAN.
> =

> > Can't we avoid multiple swaps?
> =

> That would mean adding an extra endianness argument down to
> memory_region_wrong_endianness()... not sure we want to do that.
> =

> > They make my head spin.
> > =

> =

> I understand that the current fixed target endianness paradigm
> is best suited for most architectures. Extra swaps in specific
> non-critical locations allows to support odd beasts like ppc64le
> and arm64be without trashing more common paths. Maybe I can add a
> comment for better clarity (see below).

But common header format is simple, it's always LE.
It does not depend on target.
To me this looks like a bug in memory_region_add_eventfd,
it should do the right thing depending on device
endian-ness.



> > > ---
> > > =

> > > I guess it is also a fix for virtio-1 but I didn't check.
> > > =

> > >  hw/virtio/virtio-pci.c |   11 +++++++++--
> > >  1 file changed, 9 insertions(+), 2 deletions(-)
> > > =

> > > diff --git a/hw/virtio/virtio-pci.c b/hw/virtio/virtio-pci.c
> > > index e7baf7b..62b04c9 100644
> > > --- a/hw/virtio/virtio-pci.c
> > > +++ b/hw/virtio/virtio-pci.c
> > > @@ -133,6 +133,11 @@ static int virtio_pci_load_queue(DeviceState *d,=
 int n, QEMUFile *f)
> > >      return 0;
> > >  }
> > >  =

> =

> /* The host notifier will be swapped in adjust_endianness() according to =
the
>  * target default endianness. We need to negate this swap if the device u=
ses
>  * an endianness that is not the default (ppc64le for example).
>  */
> =

> > > +static uint16_t cpu_to_host_notifier16(VirtIODevice *vdev, uint16_t =
val)
> > > +{
> > > +    return virtio_is_big_endian(vdev) ? val : bswap16(val);
> > > +}
> > > +
> > >  static int virtio_pci_set_host_notifier_internal(VirtIOPCIProxy *pro=
xy,
> > >                                                   int n, bool assign,=
 bool set_handler)
> > >  {
> > > @@ -150,10 +155,12 @@ static int virtio_pci_set_host_notifier_interna=
l(VirtIOPCIProxy *proxy,
> > >          }
> > >          virtio_queue_set_host_notifier_fd_handler(vq, true, set_hand=
ler);
> > >          memory_region_add_eventfd(&proxy->bar, VIRTIO_PCI_QUEUE_NOTI=
FY, 2,
> > > -                                  true, n, notifier);
> > > +                                  true, cpu_to_host_notifier16(vdev,=
 n),
> > > +                                  notifier);
> > >      } else {
> > >          memory_region_del_eventfd(&proxy->bar, VIRTIO_PCI_QUEUE_NOTI=
FY, 2,
> > > -                                  true, n, notifier);
> > > +                                  true, cpu_to_host_notifier16(vdev,=
 n),
> > > +                                  notifier);
> > >          virtio_queue_set_host_notifier_fd_handler(vq, false, false);
> > >          event_notifier_cleanup(notifier);
> > >      }
> > =
