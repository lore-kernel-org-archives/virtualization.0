From: "Li, Liang Z" <liang.z.li@intel.com>
Subject: RE: [RFC qemu 2/4] virtio-balloon: Add a new feature to balloon device
Date: Fri, 4 Mar 2016 02:38:29 +0000
Message-ID: <F2CBF3009FA73547804AE4C663CAB28E03770FC5@SHSMSX101.ccr.corp.intel.com>
References: <1457001868-15949-1-git-send-email-liang.z.li@intel.com>
	<1457001868-15949-3-git-send-email-liang.z.li@intel.com>
	<20160303132334.5e4565df.cornelia.huck@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20160303132334.5e4565df.cornelia.huck@de.ibm.com>
Content-Language: en-US
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Cornelia Huck <cornelia.huck@de.ibm.com>
Cc: "ehabkost@redhat.com" <ehabkost@redhat.com>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "mst@redhat.com" <mst@redhat.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>, "amit.shah@redhat.com" <amit.shah@redhat.com>, "pbonzini@redhat.com" <pbonzini@redhat.com>, "akpm@linux-foundation.org" <akpm@linux-foundation.org>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, "dgilbert@redhat.com" <dgilbert@redhat.com>, "rth@twiddle.net" <rth@twiddle.net>
List-Id: virtualization@lists.linuxfoundation.org

> On Thu,  3 Mar 2016 18:44:26 +0800
> Liang Li <liang.z.li@intel.com> wrote:
> 
> > Extend the virtio balloon device to support a new feature, this new
> > feature can help to get guest's free pages information, which can be
> > used for live migration optimzation.
> 
> Do you have a spec for this, e.g. as a patch to the virtio spec?

Not yet.
> 
> >
> > Signed-off-by: Liang Li <liang.z.li@intel.com>
> > ---
> >  balloon.c                                       | 30 ++++++++-
> >  hw/virtio/virtio-balloon.c                      | 81 ++++++++++++++++++++++++-
> >  include/hw/virtio/virtio-balloon.h              | 17 +++++-
> >  include/standard-headers/linux/virtio_balloon.h |  1 +
> >  include/sysemu/balloon.h                        | 10 ++-
> >  5 files changed, 134 insertions(+), 5 deletions(-)
> 
> > +static int virtio_balloon_free_pages(void *opaque,
> > +                                     unsigned long *free_pages_bitmap,
> > +                                     unsigned long *free_pages_count)
> > +{
> > +    VirtIOBalloon *s = opaque;
> > +    VirtIODevice *vdev = VIRTIO_DEVICE(s);
> > +    VirtQueueElement *elem = s->free_pages_vq_elem;
> > +    int len;
> > +
> > +    if (!balloon_free_pages_supported(s)) {
> > +        return -1;
> > +    }
> > +
> > +    if (s->req_status == NOT_STARTED) {
> > +        s->free_pages_bitmap = free_pages_bitmap;
> > +        s->req_status = STARTED;
> > +        s->mem_layout.low_mem =
> > + pc_get_lowmem(PC_MACHINE(current_machine));
> 
> Please don't leak pc-specific information into generic code.

I have already notice that and just leave it here in this  initial RFC version,  
the hard part of this solution is how to handle different architecture ...

Thanks!

Liang
