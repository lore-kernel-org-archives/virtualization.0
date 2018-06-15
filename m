From: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [virtio-dev] Re: [Qemu-devel] [PATCH] qemu: Introduce
	VIRTIO_NET_F_STANDBY feature bit to virtio_net
Date: Fri, 15 Jun 2018 11:32:42 +0200
Message-ID: <20180615113242.799974f6.cohuck__42860.0102699876$1529055047$gmane$org@redhat.com>
References: <1525734594-11134-1-git-send-email-sridhar.samudrala@intel.com>
	<20180611202207-mutt-send-email-mst@kernel.org>
	<dc8b1669-b8b6-fb59-94e2-6e4de6b96572@redhat.com>
	<20180612051432-mutt-send-email-mst@kernel.org>
	<23fc4aa4-ec41-d6e2-3354-10cbfc13b7ec@intel.com>
	<20180612142557-mutt-send-email-mst@kernel.org>
	<b9c88515-cf41-2a9a-078e-9c9e5adbbf14@intel.com>
	<CADGSJ213f8tJpNXuOhv8qRew-Y5VZAwA+srNMrLZYnKdVGLdAA@mail.gmail.com>
	<20180614120231.0a72bd5f.cohuck@redhat.com>
	<20180615052743-mutt-send-email-mst@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20180615052743-mutt-send-email-mst@kernel.org>
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
Cc: Alexander Duyck <alexander.h.duyck@intel.com>, virtio-dev@lists.oasis-open.org, Jiri Pirko <jiri@resnulli.us>, Jakub Kicinski <kubakici@wp.pl>, "Samudrala,
	Sridhar" <sridhar.samudrala@intel.com>, qemu-devel@nongnu.org, virtualization@lists.linux-foundation.org, Siwei Liu <loseweigh@gmail.com>, Netdev <netdev@vger.kernel.org>, aaron.f.brown@intel.com
List-Id: virtualization@lists.linuxfoundation.org

On Fri, 15 Jun 2018 05:34:24 +0300
"Michael S. Tsirkin" <mst@redhat.com> wrote:

> On Thu, Jun 14, 2018 at 12:02:31PM +0200, Cornelia Huck wrote:

> > > > I am not all that familiar with how Qemu manages network devices. If we can
> > > > do all the
> > > > required management of the primary/standby devices within Qemu, that is
> > > > definitely a better
> > > > approach without upper layer involvement.    
> > > 
> > > Right. I would imagine in the extreme case the upper layer doesn't
> > > have to be involved at all if QEMU manages all hot plug/unplug logic.
> > > The management tool can supply passthrough device and virtio with the
> > > same group UUID, QEMU auto-manages the presence of the primary, and
> > > hot plug the device as needed before or after the migration.  
> > 
> > I do not really see how you can manage that kind of stuff in QEMU only.  
> 
> So right now failover is limited to pci passthrough devices only.
> The idea is to realize the vfio device but not expose it
> to guest. Have a separate command to expose it to guest.
> Hotunplug would also hide it from guest but not unrealize it.

So, this would not be real hot(un)plug, but 'hide it from the guest',
right? The concept of "we have it realized in QEMU, but the guest can't
discover and use it" should be translatable to non-pci as well (at
least for ccw).

> 
> This will help ensure that e.g. on migration failure we can
> re-expose the device without risk of running out of resources.

Makes sense.

Should that 'hidden' state be visible/settable from outside as well
(e.g. via a property)? I guess yes, so that management software has a
chance to see whether a device is visible. Settable may be useful if we
find another use case for hiding realized devices.
