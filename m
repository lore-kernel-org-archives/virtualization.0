From: Tiwei Bie <tiwei.bie@intel.com>
Subject: Re: [RFC v2] virtio: support packed ring
Date: Sat, 14 Apr 2018 19:22:11 +0800
Message-ID: <20180414112211.pf6on4mzewb2d56c__9087.0774504312$1523704954$gmane$org@debian>
References: <20180401141216.8969-1-tiwei.bie@intel.com>
	<20180413181808-mutt-send-email-mst@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20180413181808-mutt-send-email-mst@kernel.org>
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
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, wexu@redhat.com
List-Id: virtualization@lists.linuxfoundation.org

On Fri, Apr 13, 2018 at 06:22:45PM +0300, Michael S. Tsirkin wrote:
> On Sun, Apr 01, 2018 at 10:12:16PM +0800, Tiwei Bie wrote:
> > +static inline bool more_used(const struct vring_virtqueue *vq)
> > +{
> > +	return vq->packed ? more_used_packed(vq) : more_used_split(vq);
> > +}
> > +
> > +void *virtqueue_get_buf_ctx_split(struct virtqueue *_vq, unsigned int *len,
> > +				  void **ctx)
> > +{
> > +	struct vring_virtqueue *vq = to_vvq(_vq);
> > +	void *ret;
> > +	unsigned int i;
> > +	u16 last_used;
> > +
> > +	START_USE(vq);
> > +
> > +	if (unlikely(vq->broken)) {
> > +		END_USE(vq);
> > +		return NULL;
> > +	}
> > +
> > +	if (!more_used(vq)) {
> > +		pr_debug("No more buffers in queue\n");
> > +		END_USE(vq);
> > +		return NULL;
> > +	}
> 
> So virtqueue_get_buf_ctx_split should only call more_used_split.

Yeah, you're right! Will fix this in the next version.

> 
> to avoid such issues I think we should lay out the code like this:
> 
> XXX_split
> 
> XXX_packed
> 
> XXX wrappers

I'll do it. Thanks for the suggestion!

> 
> > +/* The standard layout
> 
> I'd drop standard here.

Got it. I'll drop the word "standard".

> 
> > for the packed ring is a continuous chunk of memory
> > + * which looks like this.
> > + *
> > + * struct vring_packed
> > + * {
> 
> Can the opening bracket go on the prev line pls?

Sure.

> 
> > + *	// The actual descriptors (16 bytes each)
> > + *	struct vring_packed_desc desc[num];
> > + *
> > + *	// Padding to the next align boundary.
> > + *	char pad[];
> > + *
> > + *	// Driver Event Suppression
> > + *	struct vring_packed_desc_event driver;
> > + *
> > + *	// Device Event Suppression
> > + *	struct vring_packed_desc_event device;
> 
> Maybe that's how our driver does it but it's not based on spec
> so I don't think this belongs in the header.

I will move it to the place where vring_packed_init()
is defined.

> 
> > + * };
> > + */
> > +
> > +static inline unsigned vring_packed_size(unsigned int num, unsigned long align)
> > +{
> > +	return ((sizeof(struct vring_packed_desc) * num + align - 1)
> > +		& ~(align - 1)) + sizeof(struct vring_packed_desc_event) * 2;
> > +}
> > +
> 
> Cant say this API makes sense for me.

Hmm, do you have any suggestion? Also move it out of this header?

Thanks for the review! :)

Best regards,
Tiwei Bie

> 
> 
> >  #endif /* _UAPI_LINUX_VIRTIO_RING_H */
> > -- 
> > 2.11.0
