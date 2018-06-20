From: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [virtio-dev] Re: [Qemu-devel] [PATCH] qemu: Introduce
	VIRTIO_NET_F_STANDBY feature bit to virtio_net
Date: Wed, 20 Jun 2018 11:53:59 +0200
Message-ID: <20180620115359.1a3bf6fb.cohuck@redhat.com>
References: <20180612051432-mutt-send-email-mst@kernel.org>
	<23fc4aa4-ec41-d6e2-3354-10cbfc13b7ec@intel.com>
	<20180612142557-mutt-send-email-mst@kernel.org>
	<b9c88515-cf41-2a9a-078e-9c9e5adbbf14@intel.com>
	<CADGSJ213f8tJpNXuOhv8qRew-Y5VZAwA+srNMrLZYnKdVGLdAA@mail.gmail.com>
	<20180614120231.0a72bd5f.cohuck@redhat.com>
	<CADGSJ23WnTmVKHezm3t0V6M2sWeHaOUoTjdXkmrvbO0EF83hMg@mail.gmail.com>
	<20180615134815.6613620e.cohuck@redhat.com>
	<CADGSJ208NRp=bjhSkzF2K5Ft94TwdRs73WfSp4h-_vXvEKwgiQ@mail.gmail.com>
	<20180619125453.2d2dfb2d.cohuck@redhat.com>
	<20180619233001-mutt-send-email-mst@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20180619233001-mutt-send-email-mst@kernel.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Alexander Duyck <alexander.h.duyck@intel.com>, virtio-dev@lists.oasis-open.org, Jiri Pirko <jiri@resnulli.us>, konrad.wilk@oracle.com, Jakub Kicinski <kubakici@wp.pl>, "Samudrala, Sridhar" <sridhar.samudrala@intel.com>, qemu-devel@nongnu.org, virtualization@lists.linux-foundation.org, Siwei Liu <loseweigh@gmail.com>, Venu Busireddy <venu.busireddy@oracle.com>, Netdev <netdev@vger.kernel.org>, boris.ostrovsky@oracle.com, aaron.f.brown@intel.com, Joao Martins <joao.m.martins@oracle.com>
List-Id: virtualization@lists.linuxfoundation.org

On Tue, 19 Jun 2018 23:32:06 +0300
"Michael S. Tsirkin" <mst@redhat.com> wrote:

> On Tue, Jun 19, 2018 at 12:54:53PM +0200, Cornelia Huck wrote:
> > Sorry about dragging mainframes into this, but this will only work for
> > homogenous device coupling, not for heterogenous. Consider my vfio-pci
> > + virtio-net-ccw example again: The guest cannot find out that the two
> > belong together by checking some group ID, it has to either use the MAC
> > or some needs-to-be-architectured property.
> > 
> > Alternatively, we could propose that mechanism as pci-only, which means
> > we can rely on mechanisms that won't necessarily work on non-pci
> > transports. (FWIW, I don't see a use case for using vfio-ccw to pass
> > through a network card anytime in the near future, due to the nature of
> > network cards currently in use on s390.)  
> 
> That's what it boils down to, yes.  If there's need to have this for
> non-pci devices, then we should put it in config space.
> Cornelia, what do you think?
> 

I think the only really useful config on s390 is the vfio-pci network
card coupled with a virtio-net-ccw device: Using an s390 network card
via vfio-ccw is out due to the nature of the s390 network cards, and
virtio-ccw is the default transport (virtio-pci is not supported on any
enterprise distro AFAIK).

For this, having a uuid in the config space could work (vfio-pci
devices have a config space by virtue of being pci devices, and
virtio-net-ccw devices have a config space by virtue of being virtio
devices -- ccw devices usually don't have that concept).
