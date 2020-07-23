From: Stefano Garzarella <sgarzare@redhat.com>
Subject: Re: Interesting qemu/virt-manager bug about the "rotational"
 attribute on virtio-blk disks
Date: Thu, 23 Jul 2020 13:15:14 +0200
Message-ID: <20200723111514.eobzyktmpxi3fsez@steredhat.lan>
References: <20200716080614.GA18456@redhat.com>
 <20200716093344.7molwklwco4sdtvs@steredhat>
 <20200723103239.GD186372@stefanha-x1.localdomain>
 <20200723104056.GN3888@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20200723104056.GN3888@redhat.com>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
 <mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
 <mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>
To: "Richard W.M. Jones" <rjones@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, virtualization@lists.linux-foundation.org, qemu-discuss@nongnu.org
List-Id: virtualization@lists.linuxfoundation.org

On Thu, Jul 23, 2020 at 11:40:56AM +0100, Richard W.M. Jones wrote:
> On Thu, Jul 23, 2020 at 11:32:39AM +0100, Stefan Hajnoczi wrote:
> > On Thu, Jul 16, 2020 at 11:33:44AM +0200, Stefano Garzarella wrote:
> > > +Cc Michael, Stefan, virtualization@lists.linux-foundation.org
> > > 
> > > On Thu, Jul 16, 2020 at 09:06:14AM +0100, Richard W.M. Jones wrote:
> > > > 
> > > > https://bugzilla.redhat.com/show_bug.cgi?id=1857515
> > > > 
> > > > A virtio-blk disk which is backed by a raw file on an SSD,
> > > > inside the guest shows rotational = 1.
> > > > 
> > > > I assumed that qemu must have a "rotational" property for disks and
> > > > this would be communicated by virtio to the guest, but qemu and virtio
> > > > don't seem to have this.  Pretty surprising!  Is it called something
> > > > other than "rotational"?
> > > > 
> > > 
> > > I'm not sure if we need to add this property in QEMU, but in Linux
> > > I found these flags (include/linux/blkdev.h) for the block queues:
> > > 
> > >     #define QUEUE_FLAG_NONROT	6	/* non-rotational device (SSD) */
> > >     #define QUEUE_FLAG_VIRT		QUEUE_FLAG_NONROT /* paravirt device */
> > > 
> > > xen-blkfront driver is the only one that sets the QUEUE_FLAG_VIRT,
> > > should we do the same in the virtio-blk driver regardless of the backend?
> > 
> > The ability to control this flag would be interesting for performance
> > experiments.
> 
> I expect there's a pretty strong interaction between this feature and
> the shared guest io_uring stuff isn't there?  I'm not sure if it'll be
> a positive or negative effect though.

Yeah, it could be! I'll try it out in the next days.

> 
> Rich.
> 
> > The problem with changing the default is that regressions can be
> > expected. Certain workloads benefit while others regress.
> > 
> > I suggest:
> > 1. Make it controllable so that QUEUE_FLAG_NONROT can be set or clear
> >    (not hardcoded to a single value).
> > 2. The device can communicate the optimal setting from the host. The
> >    SCSI protocol already conveys this information. Virtio-blk needs a
> >    feature bit and possibly config space field.
> > 3. Make it migration-safe. It needs to be configured explicitly so the
> >    value doesn't change suddenly across migration.

Thanks for the suggestions.

I'll spend some time on this.

Stefano
