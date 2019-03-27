From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH] MAiNTAINERS: add Paolo, Stefan for virtio blk/scsi
Date: Wed, 27 Mar 2019 11:36:47 -0400
Message-ID: <20190327113606-mutt-send-email-mst@kernel.org>
References: <20190327103254-mutt-send-email-mst@kernel.org>
	<1a5d4b76-e11d-3a12-4971-64581bffe636@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1a5d4b76-e11d-3a12-4971-64581bffe636@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: stefanha@redhat.com, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Wed, Mar 27, 2019 at 04:08:05PM +0100, Paolo Bonzini wrote:
> On 27/03/19 15:33, Michael S. Tsirkin wrote:
> > Jason doesn't really have the time to review blk/scsi
> > patches. Paolo and Setfan agreed to help out.
> > 
> > Thanks guys!
> > 
> > Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> > 
> > ---
> > 
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index 95a5ebecd04f..8326d19c1681 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -16247,7 +16247,7 @@ F:	drivers/char/virtio_console.c
> >  F:	include/linux/virtio_console.h
> >  F:	include/uapi/linux/virtio_console.h
> >  
> > -VIRTIO CORE, NET AND BLOCK DRIVERS
> > +VIRTIO CORE AND NET DRIVERS
> >  M:	"Michael S. Tsirkin" <mst@redhat.com>
> >  M:	Jason Wang <jasowang@redhat.com>
> >  L:	virtualization@lists.linux-foundation.org
> > @@ -16262,6 +16262,18 @@ F:	include/uapi/linux/virtio_*.h
> >  F:	drivers/crypto/virtio/
> >  F:	mm/balloon_compaction.c
> >  
> > +VIRTIO BLOCK AND SCSI DRIVERS
> > +M:	"Michael S. Tsirkin" <mst@redhat.com>
> > +M:	Paolo Bonzini <pbonzini@redhat.com>
> > +M:	Stefan Hajnoczi <stefanha@redhat.com>
> 
> Please make this R at least for me, so that it's clear that patches
> still flow through your and Jason's tree.  Not sure if you want to keep
> Jason as M.
> 
> Paolo

Not for block I think. He never reviews these.

> > +L:	virtualization@lists.linux-foundation.org
> > +S:	Maintained
> > +F:	drivers/block/virtio_blk.c
> > +F:	drivers/scsi/virtio_scsi.c
> > +F:	include/uapi/linux/virtio_blk.h
> > +F:	include/uapi/linux/virtio_scsi.h
> > +F:	drivers/vhost/scsi.c
> > +
> >  VIRTIO CRYPTO DRIVER
> >  M:	Gonglei <arei.gonglei@huawei.com>
> >  L:	virtualization@lists.linux-foundation.org
> > 
