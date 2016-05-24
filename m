From: "Li, Liang Z" <liang.z.li@intel.com>
Subject: RE: [PATCH RFC kernel] balloon: speed up inflating/deflating process
Date: Tue, 24 May 2016 07:48:49 +0000
Message-ID: <F2CBF3009FA73547804AE4C663CAB28E041A489A__328.555194619362$1464076186$gmane$org@shsmsx102.ccr.corp.intel.com>
References: <1463738386-30868-1-git-send-email-liang.z.li@intel.com>
	<20160520123243.59b91c00.cornelia.huck@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20160520123243.59b91c00.cornelia.huck@de.ibm.com>
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
Cc: "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "mst@redhat.com" <mst@redhat.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, "amit.shah@redhat.com" <amit.shah@redhat.com>, "pbonzini@redhat.com" <pbonzini@redhat.com>, "akpm@linux-foundation.org" <akpm@linux-foundation.org>, "dgilbert@redhat.com" <dgilbert@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

> On Fri, 20 May 2016 17:59:46 +0800
> Liang Li <liang.z.li@intel.com> wrote:
> 
> > The implementation of the current virtio-balloon is not very
> > efficient, Bellow is test result of time spends on inflating the
> > balloon to 3GB of a 4GB idle guest:
> >
> > a. allocating pages (6.5%, 103ms)
> > b. sending PFNs to host (68.3%, 787ms) c. address translation (6.1%,
> > 96ms) d. madvise (19%, 300ms)
> >
> > It takes about 1577ms for the whole inflating process to complete. The
> > test shows that the bottle neck is the stage b and stage d.
> >
> > If using a bitmap to send the page info instead of the PFNs, we can
> > reduce the overhead spends on stage b quite a lot. Furthermore, it's
> > possible to do the address translation and do the madvise with a bulk
> > of pages, instead of the current page per page way, so the overhead of
> > stage c and stage d can also be reduced a lot.
> >
> > This patch is the kernel side implementation which is intended to
> > speed up the inflating & deflating process by adding a new feature to
> > the virtio-balloon device. And now, inflating the balloon to 3GB of a
> > 4GB idle guest only takes 175ms, it's about 9 times as fast as before.
> >
> > TODO: optimize stage a by allocating/freeing a chunk of pages instead
> > of a single page at a time.
> 
> Not commenting on the approach, but...
> 
> >
> > Signed-off-by: Liang Li <liang.z.li@intel.com>
> > ---
> >  drivers/virtio/virtio_balloon.c     | 199
> ++++++++++++++++++++++++++++++++++--
> >  include/uapi/linux/virtio_balloon.h |   1 +
> >  mm/page_alloc.c                     |   6 ++
> >  3 files changed, 198 insertions(+), 8 deletions(-)
> >
> 
> >  static void tell_host(struct virtio_balloon *vb, struct virtqueue
> > *vq)  {
> > -	struct scatterlist sg;
> >  	unsigned int len;
> >
> > -	sg_init_one(&sg, vb->pfns, sizeof(vb->pfns[0]) * vb->num_pfns);
> > +	if (virtio_has_feature(vb->vdev,
> VIRTIO_BALLOON_F_PAGE_BITMAP)) {
> > +		u32 page_shift = PAGE_SHIFT;
> > +		unsigned long start_pfn, end_pfn, flags = 0, bmap_len;
> > +		struct scatterlist sg[5];
> > +
> > +		start_pfn = rounddown(vb->start_pfn, BITS_PER_LONG);
> > +		end_pfn = roundup(vb->end_pfn, BITS_PER_LONG);
> > +		bmap_len = (end_pfn - start_pfn) / BITS_PER_LONG *
> sizeof(long);
> > +
> > +		sg_init_table(sg, 5);
> > +		sg_set_buf(&sg[0], &flags, sizeof(flags));
> > +		sg_set_buf(&sg[1], &start_pfn, sizeof(start_pfn));
> > +		sg_set_buf(&sg[2], &page_shift, sizeof(page_shift));
> > +		sg_set_buf(&sg[3], &bmap_len, sizeof(bmap_len));
> > +		sg_set_buf(&sg[4], vb->page_bitmap +
> > +				 (start_pfn / BITS_PER_LONG), bmap_len);
> > +		virtqueue_add_outbuf(vq, sg, 5, vb, GFP_KERNEL);
> > +
> 
> ...you need to take care of the endianness of the data you put on the queue,
> otherwise virtio-1 on big endian won't work. (There's just been a patch for
> that problem.)

OK, thanks for your reminding.

Liang
