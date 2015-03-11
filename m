From: Greg Kurz <gkurz@linux.vnet.ibm.com>
Subject: Re: [Qemu-ppc] [PATCH] virtio-pci: fix host notifiers on bi-endian
	architectures
Date: Wed, 11 Mar 2015 23:52:13 +0100
Message-ID: <20150311235213.6967e39c@bahia.local>
References: <20150311180212.8119.14734.stgit@bahia.local>
	<20150311210322-mutt-send-email-mst@redhat.com>
	<20150311230314.08e51843@bahia.local>
	<1426112318.17565.60.camel@kernel.crashing.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1426112318.17565.60.camel@kernel.crashing.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Cedric Le Goater <clg@fr.ibm.com>, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, virtualization@lists.linux-foundation.org, "Michael S. Tsirkin" <mst@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

On Thu, 12 Mar 2015 09:18:38 +1100
Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:

> On Wed, 2015-03-11 at 23:03 +0100, Greg Kurz wrote:
> 
> > /* The host notifier will be swapped in adjust_endianness() according to the
> >  * target default endianness. We need to negate this swap if the device uses
> >  * an endianness that is not the default (ppc64le for example).
> >  */
> > 
> > > > +static uint16_t cpu_to_host_notifier16(VirtIODevice *vdev, uint16_t val)
> > > > +{
> > > > +    return virtio_is_big_endian(vdev) ? val : bswap16(val);
> > > > +}
> 
> But but but ... The above ... won't it do things like break x86 ? Ie,
> shouldn't we swap only if TARGET_BIG_ENDIAN and !virtio_is_big_endian ?
> Or better, "fixed target endian" ^ "virtio endian" to cover all cases ?
> 

Yeah you're right, it's a mess :)

To avoid virtio-pci.o being built per target, we can use virtio_default_endian()
instead (to be exported from virtio.c):

return vdev->device_endian() != virtio_default_endian() ? val : bswap16(val);

I shall test on x86 and post a v2.

Thanks.

--
G

> Cheers,
> Ben.
> 
> > > >  static int virtio_pci_set_host_notifier_internal(VirtIOPCIProxy *proxy,
> > > >                                                   int n, bool assign, bool set_handler)
> > > >  {
> > > > @@ -150,10 +155,12 @@ static int virtio_pci_set_host_notifier_internal(VirtIOPCIProxy *proxy,
> > > >          }
> > > >          virtio_queue_set_host_notifier_fd_handler(vq, true, set_handler);
> > > >          memory_region_add_eventfd(&proxy->bar, VIRTIO_PCI_QUEUE_NOTIFY, 2,
> > > > -                                  true, n, notifier);
> > > > +                                  true, cpu_to_host_notifier16(vdev, n),
> > > > +                                  notifier);
> > > >      } else {
> > > >          memory_region_del_eventfd(&proxy->bar, VIRTIO_PCI_QUEUE_NOTIFY, 2,
> > > > -                                  true, n, notifier);
> > > > +                                  true, cpu_to_host_notifier16(vdev, n),
> > > > +                                  notifier);
> > > >          virtio_queue_set_host_notifier_fd_handler(vq, false, false);
> > > >          event_notifier_cleanup(notifier);
> > > >      }
> > > 
> > 
> 
> 
