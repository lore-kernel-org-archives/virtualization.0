From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH] vhost: force spec specified alignment on types
Date: Mon, 6 Apr 2020 09:55:25 -0400
Message-ID: <20200406095424-mutt-send-email-mst@kernel.org>
References: <20200406124931.120768-1-mst@redhat.com>
 <045c84ed-151e-a850-9c72-5079bd2775e6@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <045c84ed-151e-a850-9c72-5079bd2775e6@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jason Wang <jasowang@redhat.com>
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org, netdev@vger.kernel.org
List-Id: virtualization@lists.linuxfoundation.org

On Mon, Apr 06, 2020 at 09:34:00PM +0800, Jason Wang wrote:
> 
> On 2020/4/6 下午8:50, Michael S. Tsirkin wrote:
> > The ring element addresses are passed between components with different
> > alignments assumptions. Thus, if guest/userspace selects a pointer and
> > host then gets and dereferences it, we might need to decrease the
> > compiler-selected alignment to prevent compiler on the host from
> > assuming pointer is aligned.
> > 
> > This actually triggers on ARM with -mabi=apcs-gnu - which is a
> > deprecated configuration, but it seems safer to handle this
> > generally.
> > 
> > I verified that the produced binary is exactly identical on x86.
> > 
> > Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> > ---
> > 
> > This is my preferred way to handle the ARM incompatibility issues
> > (in preference to kconfig hacks).
> > I will push this into next now.
> > Comments?
> 
> 
> I'm not sure if it's too late to fix. It would still be still problematic
> for the userspace that is using old uapi headers?
> 
> Thanks

It's not a problem in userspace. The problem is when
userspace/guest uses 2 byte alignment and passes it to kernel
assuming 8 byte alignment. The fix is for host not to
make these assumptions.

> 
> > 
> >   drivers/vhost/vhost.h            |  6 ++---
> >   include/uapi/linux/virtio_ring.h | 41 ++++++++++++++++++++++++--------
> >   2 files changed, 34 insertions(+), 13 deletions(-)
> > 
> > diff --git a/drivers/vhost/vhost.h b/drivers/vhost/vhost.h
> > index cc82918158d2..a67bda9792ec 100644
> > --- a/drivers/vhost/vhost.h
> > +++ b/drivers/vhost/vhost.h
> > @@ -74,9 +74,9 @@ struct vhost_virtqueue {
> >   	/* The actual ring of buffers. */
> >   	struct mutex mutex;
> >   	unsigned int num;
> > -	struct vring_desc __user *desc;
> > -	struct vring_avail __user *avail;
> > -	struct vring_used __user *used;
> > +	vring_desc_t __user *desc;
> > +	vring_avail_t __user *avail;
> > +	vring_used_t __user *used;
> >   	const struct vhost_iotlb_map *meta_iotlb[VHOST_NUM_ADDRS];
> >   	struct vhost_desc *descs;
> > diff --git a/include/uapi/linux/virtio_ring.h b/include/uapi/linux/virtio_ring.h
> > index 559f42e73315..cd6e0b2eaf2f 100644
> > --- a/include/uapi/linux/virtio_ring.h
> > +++ b/include/uapi/linux/virtio_ring.h
> > @@ -118,16 +118,6 @@ struct vring_used {
> >   	struct vring_used_elem ring[];
> >   };
> > -struct vring {
> > -	unsigned int num;
> > -
> > -	struct vring_desc *desc;
> > -
> > -	struct vring_avail *avail;
> > -
> > -	struct vring_used *used;
> > -};
> > -
> >   /* Alignment requirements for vring elements.
> >    * When using pre-virtio 1.0 layout, these fall out naturally.
> >    */
> > @@ -164,6 +154,37 @@ struct vring {
> >   #define vring_used_event(vr) ((vr)->avail->ring[(vr)->num])
> >   #define vring_avail_event(vr) (*(__virtio16 *)&(vr)->used->ring[(vr)->num])
> > +/*
> > + * The ring element addresses are passed between components with different
> > + * alignments assumptions. Thus, we might need to decrease the compiler-selected
> > + * alignment, and so must use a typedef to make sure the __aligned attribute
> > + * actually takes hold:
> > + *
> > + * https://gcc.gnu.org/onlinedocs//gcc/Common-Type-Attributes.html#Common-Type-Attributes
> > + *
> > + * When used on a struct, or struct member, the aligned attribute can only
> > + * increase the alignment; in order to decrease it, the packed attribute must
> > + * be specified as well. When used as part of a typedef, the aligned attribute
> > + * can both increase and decrease alignment, and specifying the packed
> > + * attribute generates a warning.
> > + */
> > +typedef struct vring_desc __attribute__((aligned(VRING_DESC_ALIGN_SIZE)))
> > +	vring_desc_t;
> > +typedef struct vring_avail __attribute__((aligned(VRING_AVAIL_ALIGN_SIZE)))
> > +	vring_avail_t;
> > +typedef struct vring_used __attribute__((aligned(VRING_USED_ALIGN_SIZE)))
> > +	vring_used_t;
> > +
> > +struct vring {
> > +	unsigned int num;
> > +
> > +	vring_desc_t *desc;
> > +
> > +	vring_avail_t *avail;
> > +
> > +	vring_used_t *used;
> > +};
> > +
> >   static inline void vring_init(struct vring *vr, unsigned int num, void *p,
> >   			      unsigned long align)
> >   {
