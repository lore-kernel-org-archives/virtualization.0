From: "Nicholas A. Bellinger" <nab@linux-iscsi.org>
Subject: Re: [PATCH 3/3] vhost: Check+skip uninitialized VQs in
	vhost_verify_ring_mappings
Date: Mon, 01 Apr 2013 16:49:19 -0700
Message-ID: <1364860159.20769.65.camel__46031.0551374734$1364860195$gmane$org@haakon2.linux-iscsi.org>
References: <1364531592-8368-1-git-send-email-nab@linux-iscsi.org>
	<1364531592-8368-4-git-send-email-nab@linux-iscsi.org>
	<20130331074516.GC23484@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20130331074516.GC23484@redhat.com>
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
Cc: kvm-devel <kvm@vger.kernel.org>, qemu-devel <qemu-devel@nongnu.org>, lf-virt <virtualization@lists.linux-foundation.org>, Anthony Liguori <aliguori@linux.vnet.ibm.com>, target-devel <target-devel@vger.kernel.org>, Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

On Sun, 2013-03-31 at 10:45 +0300, Michael S. Tsirkin wrote:
> On Fri, Mar 29, 2013 at 04:33:12AM +0000, Nicholas A. Bellinger wrote:
> > From: Nicholas Bellinger <nab@linux-iscsi.org>
> > 
> > With the virtio_queue_valid() checks in place to skip uninitialized VQs
> > within virtio-pci code, go ahead and skip the same uninitialized VQs
> > during vhost_verify_ring_mappings().
> > 
> > Note this patch does not prevent vhost_virtqueue_start() from executing
> > by checking virtio_queue_valid(), as other logic during seabios ->
> > virtio-scsi LLD guest hand-off appears to depend upon this execution.
> 
> Weird.
> cpu_physical_memory_map only succeeds for PA==0 by chance,
> we really should not depend on this.
> So the right thing really should be to skip vhost_virtqueue_start IMHO,
> maybe add an explicit valid flag in vhost_virtqueue
> so vhost_verify_ring_mappings can check it.
> What exactly does it do that is needed?
> 

So the issue with virtio_queue_valid() preventing
vhost_virtqueue_start() execution in the original patch was that
vhost_virtqueue_stop() was missing a matching virtio_queue_valid() call,
which ended up triggering a bad ram pointer during subsequent
cpu_physical_memory_unmap() calls to non-existent virtio queue memory..

With the matching virtio_queue_valid() call in place preventing
vhost_virtqueue_stop() when vhost_virtqueue_start() is skipped for an
uninitialized VQ, a explicit valid flag should not be necessary.

--nab


> > 
> > Cc: Michael S. Tsirkin <mst@redhat.com>
> > Cc: Asias He <asias@redhat.com>
> > Cc: Paolo Bonzini <pbonzini@redhat.com>
> > Signed-off-by: Nicholas Bellinger <nab@linux-iscsi.org>
> > ---
> >  hw/vhost.c |    3 +++
> >  1 files changed, 3 insertions(+), 0 deletions(-)
> > 
> > diff --git a/hw/vhost.c b/hw/vhost.c
> > index 4d6aee3..3a71aee 100644
> > --- a/hw/vhost.c
> > +++ b/hw/vhost.c
> > @@ -314,6 +314,9 @@ static int vhost_verify_ring_mappings(struct vhost_dev *dev,
> >          hwaddr l;
> >          void *p;
> >  
> > +        if (!vq->ring_phys || !vq->ring_size) {
> > +            continue;
> > +        }
> >          if (!ranges_overlap(start_addr, size, vq->ring_phys, vq->ring_size)) {
> >              continue;
> >          }
> > -- 
> > 1.7.2.5
> --
> To unsubscribe from this list: send the line "unsubscribe target-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
