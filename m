From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH v12 5/8] virtio-balloon: VIRTIO_BALLOON_F_SG
Date: Wed, 12 Jul 2017 16:56:00 +0300
Message-ID: <20170712163746-mutt-send-email-mst__1314.6583726213$1499867776$gmane$org@kernel.org>
References: <1499863221-16206-1-git-send-email-wei.w.wang@intel.com>
	<1499863221-16206-6-git-send-email-wei.w.wang@intel.com>
	<20170712160129-mutt-send-email-mst@kernel.org>
	<5966241C.9060503@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <5966241C.9060503@intel.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Wei Wang <wei.w.wang@intel.com>
Cc: aarcange@redhat.com, virtio-dev@lists.oasis-open.org, kvm@vger.kernel.org, qemu-devel@nongnu.org, amit.shah@redhat.com, liliang.opensource@gmail.com, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, linux-mm@kvack.org, yang.zhang.wz@gmail.com, quan.xu@aliyun.com, cornelia.huck@de.ibm.com, pbonzini@redhat.com, akpm@linux-foundation.org, mgorman@techsingularity.net
List-Id: virtualization@lists.linuxfoundation.org

On Wed, Jul 12, 2017 at 09:29:00PM +0800, Wei Wang wrote:
> On 07/12/2017 09:06 PM, Michael S. Tsirkin wrote:
> > On Wed, Jul 12, 2017 at 08:40:18PM +0800, Wei Wang wrote:
> > > diff --git a/include/linux/virtio.h b/include/linux/virtio.h
> > > index 28b0e96..9f27101 100644
> > > --- a/include/linux/virtio.h
> > > +++ b/include/linux/virtio.h
> > > @@ -57,8 +57,28 @@ int virtqueue_add_sgs(struct virtqueue *vq,
> > >   		      void *data,
> > >   		      gfp_t gfp);
> > > +/* A desc with this init id is treated as an invalid desc */
> > > +#define VIRTQUEUE_DESC_ID_INIT UINT_MAX
> > > +int virtqueue_add_chain_desc(struct virtqueue *_vq,
> > > +			     uint64_t addr,
> > > +			     uint32_t len,
> > > +			     unsigned int *head_id,
> > > +			     unsigned int *prev_id,
> > > +			     bool in);
> > > +
> > > +int virtqueue_add_chain(struct virtqueue *_vq,
> > > +			unsigned int head,
> > > +			bool indirect,
> > > +			struct vring_desc *indirect_desc,
> > > +			void *data,
> > > +			void *ctx);
> > > +
> > >   bool virtqueue_kick(struct virtqueue *vq);
> > > +bool virtqueue_kick_sync(struct virtqueue *vq);
> > > +
> > > +bool virtqueue_kick_async(struct virtqueue *vq, wait_queue_head_t wq);
> > > +
> > >   bool virtqueue_kick_prepare(struct virtqueue *vq);
> > >   bool virtqueue_notify(struct virtqueue *vq);
> > I don't much care for this API. It does exactly what balloon needs,
> > but at cost of e.g. transparently busy-waiting. Unlikely to be
> > a good fit for anything else.
> 
> If you were referring to this API - virtqueue_add_chain_desc():
> 
> Busy waiting only happens when the vq is full (i.e. no desc left). If
> necessary, I think we can add an input parameter like
> "bool busywaiting", then the caller can decide to simply get a -ENOSPC
> or busy wait to add when no desc is available.

I think this just shows this API is too high level.
This policy should live in drivers.

> > 
> > If you don't like my original _first/_next/_last, you will
> > need to come up with something else.
> 
> I thought the above virtqueue_add_chain_des() performs the same
> functionality as _first/next/last, which are used to grab descs from the
> vq and chain them together. If not, could you please elaborate the
> usage of the original proposal?
> 
> Best,
> Wei
> 

So the way I see it, there are several issues:

- internal wait - forces multiple APIs like kick/kick_sync
  note how kick_sync can fail but your code never checks return code
- need to re-write the last descriptor - might not work
  for alternative layouts which always expose descriptors
  immediately
- some kind of iterator type would be nicer instead of
  maintaining head/prev explicitly


As for the use, it would be better to do

if (!add_next(vq, ...)) {
	add_last(vq, ...)
	kick
	wait
}

Using VIRTQUEUE_DESC_ID_INIT seems to avoid a branch in the driver, but
in fact it merely puts the branch in the virtio code.



-- 
MST
