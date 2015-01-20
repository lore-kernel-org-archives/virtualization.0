From: Cornelia Huck <cornelia.huck@de.ibm.com>
Subject: Re: [PATCH RFC v6 08/20] dataplane: allow virtio-1 devices
Date: Tue, 20 Jan 2015 13:56:07 +0100
Message-ID: <20150120135607.7b701bc3.cornelia.huck@de.ibm.com>
References: <1418304322-7546-1-git-send-email-cornelia.huck@de.ibm.com>
	<1418304322-7546-9-git-send-email-cornelia.huck@de.ibm.com>
	<20150120104331.GF17631@stefanha-thinkpad.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20150120104331.GF17631@stefanha-thinkpad.redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: thuth@linux.vnet.ibm.com, mst@redhat.com, qemu-devel@nongnu.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Tue, 20 Jan 2015 10:43:31 +0000
Stefan Hajnoczi <stefanha@gmail.com> wrote:

> On Thu, Dec 11, 2014 at 02:25:10PM +0100, Cornelia Huck wrote:
> > Handle endianness conversion for virtio-1 virtqueues correctly.
> > 
> > Note that dataplane now needs to be built per-target.
> > 
> > Signed-off-by: Cornelia Huck <cornelia.huck@de.ibm.com>
> > ---
> >  hw/block/dataplane/virtio-blk.c               |    4 +-
> >  hw/scsi/virtio-scsi-dataplane.c               |    2 +-
> >  hw/virtio/Makefile.objs                       |    2 +-
> >  hw/virtio/dataplane/Makefile.objs             |    2 +-
> >  hw/virtio/dataplane/vring.c                   |   86 ++++++++++++++-----------
> >  include/hw/virtio/dataplane/vring-accessors.h |   75 +++++++++++++++++++++
> >  include/hw/virtio/dataplane/vring.h           |   14 +---
> >  7 files changed, 131 insertions(+), 54 deletions(-)
> >  create mode 100644 include/hw/virtio/dataplane/vring-accessors.h
> 
> This patch is independent of VIRTIO 1.0 and can be merged separately
> (faster).

Yep, I've pulled it in front of my queue.

> 
> > diff --git a/hw/block/dataplane/virtio-blk.c b/hw/block/dataplane/virtio-blk.c
> > index 1222a37..2d8cc15 100644
> > --- a/hw/block/dataplane/virtio-blk.c
> > +++ b/hw/block/dataplane/virtio-blk.c
> > @@ -16,7 +16,9 @@
> >  #include "qemu/iov.h"
> >  #include "qemu/thread.h"
> >  #include "qemu/error-report.h"
> > +#include "hw/virtio/virtio-access.h"
> >  #include "hw/virtio/dataplane/vring.h"
> > +#include "hw/virtio/dataplane/vring-accessors.h"
> 
> I like your vring-accessors.h approach better than the inline
> virtio_ld/st_p() in my patch.  Nice.
> 
> > @@ -154,15 +157,18 @@ bool vring_should_notify(VirtIODevice *vdev, Vring *vring)
> >  }
> >  
> >  
> > -static int get_desc(Vring *vring, VirtQueueElement *elem,
> > +static int get_desc(VirtIODevice *vdev, Vring *vring, VirtQueueElement *elem,
> >                      struct vring_desc *desc)
> 
> Since we copy in struct vring_desc anyway, it's cleaner to byteswap the
> fields once instead of remembering to do it each time we need to access
> a field.  The copy_in_vring_desc() function is one thing I prefer I
> about my patch.

Agreed, that makes the code cleaner.

I've prepared a version of this patch using copy_in_vring_desc() and
I'll post it when it survives some light testing on my side.
