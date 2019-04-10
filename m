From: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [RFC PATCH 07/12] virtio/s390: use DMA memory for ccw I/O
Date: Wed, 10 Apr 2019 18:21:21 +0200
Message-ID: <20190410182121.61fb89b6.cohuck@redhat.com>
References: <20190404231622.52531-1-pasic@linux.ibm.com>
	<20190404231622.52531-8-pasic@linux.ibm.com>
	<20190410104251.38fe7405.cohuck@redhat.com>
	<20190410164245.53f8b26d@oc2783563651>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20190410164245.53f8b26d@oc2783563651>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Halil Pasic <pasic@linux.ibm.com>
Cc: Vasily Gorbik <gor@linux.ibm.com>, linux-s390@vger.kernel.org, Eric Farman <farman@linux.ibm.com>, Claudio Imbrenda <imbrenda@linux.ibm.com>, kvm@vger.kernel.org, Sebastian Ott <sebott@linux.ibm.com>, Farhan Ali <alifm@linux.ibm.com>, virtualization@lists.linux-foundation.org, Martin Schwidefsky <schwidefsky@de.ibm.com>, Viktor Mihajlovski <mihajlov@linux.ibm.com>, Janosch Frank <frankja@linux.ibm.com>
List-Id: virtualization@lists.linuxfoundation.org

On Wed, 10 Apr 2019 16:42:45 +0200
Halil Pasic <pasic@linux.ibm.com> wrote:

> On Wed, 10 Apr 2019 10:42:51 +0200
> Cornelia Huck <cohuck@redhat.com> wrote:
> 
> > On Fri,  5 Apr 2019 01:16:17 +0200
> > Halil Pasic <pasic@linux.ibm.com> wrote:

> > > @@ -167,6 +170,28 @@ static struct virtio_ccw_device *to_vc_device(struct virtio_device *vdev)
> > >  	return container_of(vdev, struct virtio_ccw_device, vdev);
> > >  }
> > >  
> > > +#define vc_dma_decl_struct(type, field) \
> > > +	dma_addr_t field ## _dma_addr;  \
> > > +	struct type *field
> > > +
> > > +static inline void *__vc_dma_alloc(struct virtio_device *vdev, size_t size,
> > > +				   dma_addr_t *dma_handle)
> > > +{
> > > +	return dma_alloc_coherent(vdev->dev.parent, size, dma_handle,
> > > +				  GFP_DMA | GFP_KERNEL | __GFP_ZERO);
> > > +}
> > > +
> > > +static inline void __vc_dma_free(struct virtio_device *vdev, size_t size,
> > > +				 void *cpu_addr, dma_addr_t dma_handle)
> > > +{
> > > +	dma_free_coherent(vdev->dev.parent, size, cpu_addr, dma_handle);
> > > +}
> > > +
> > > +#define vc_dma_alloc_struct(vdev, ptr) \
> > > +	({ ptr = __vc_dma_alloc(vdev, (sizeof(*(ptr))), &(ptr ## _dma_addr)); })
> > > +#define vc_dma_free_struct(vdev, ptr) \
> > > +	__vc_dma_free(vdev, sizeof(*(ptr)), (ptr), (ptr ## _dma_addr))  
> > 
> > Not sure I'm a fan of those wrappers... I think they actually hurt
> > readability of the code.
> >   
> 
> By wrappers you mean just the macros or also the inline functions?

In particular, I dislike the macros.

> 
> If we agree to go with the cio DMA pool instead of using DMA API
> facilities for allocation (dma_alloc_coherent or maybe a per ccw-device
> dma_pool) I think I could just use cio_dma_zalloc() directly if you like.

If we go with the pool (I'm not familiar enough with the dma stuff to
be able to make a good judgment there), nice and obvious calls sound
good to me :)

> 
> I was quite insecure about how this gen_pool idea is going to be received
> here. That's why I decided to keep the dma_alloc_coherent() version in
> for the RFC.
> 
> If you prefer I can squash patches #7 #9 #10 and #11 together and
> pull #8 forward. Would you prefer that?

If that avoids multiple switches of the approach used, that sounds like
a good idea.

(Still would like to see some feedback from others.)
