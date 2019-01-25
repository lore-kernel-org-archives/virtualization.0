From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH net-next V4 5/5] vhost: access vq metadata through kernel
	virtual address
Date: Thu, 24 Jan 2019 22:00:27 -0500
Message-ID: <20190124215912-mutt-send-email-mst__26711.9216661499$1548385239$gmane$org@kernel.org>
References: <20190123095557.30168-1-jasowang@redhat.com>
	<20190123095557.30168-6-jasowang@redhat.com>
	<20190123085821-mutt-send-email-mst@kernel.org>
	<335ba55b-087f-4b35-6311-540070b9647f@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <335ba55b-087f-4b35-6311-540070b9647f@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Jason Wang <jasowang@redhat.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Thu, Jan 24, 2019 at 12:07:54PM +0800, Jason Wang wrote:
> > Meanwhile, could you pls post data comparing this last patch with the
> > below?  This removes the speculation barrier replacing it with a
> > (useless but at least more lightweight) data dependency.
> 
> 
> SMAP off
> 
> Your patch: 7.2MPPs
> 
> vmap: 7.4Mpps

OK so while we keep looking into vmap, why don't we merge something like
the below?  Seems quite straight forward ...


> I don't test SMAP on, since it will be much slow for sure.
> 
> Thanks
> 
> 
> > 
> > Thanks!
> > 
> > 
> > diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
> > index bac939af8dbb..352ee7e14476 100644
> > --- a/drivers/vhost/vhost.c
> > +++ b/drivers/vhost/vhost.c
> > @@ -739,7 +739,7 @@ static int vhost_copy_to_user(struct vhost_virtqueue *vq, void __user *to,
> >   	int ret;
> >   	if (!vq->iotlb)
> > -		return __copy_to_user(to, from, size);
> > +		return copy_to_user(to, from, size);
> >   	else {
> >   		/* This function should be called after iotlb
> >   		 * prefetch, which means we're sure that all vq
> > @@ -752,7 +752,7 @@ static int vhost_copy_to_user(struct vhost_virtqueue *vq, void __user *to,
> >   				     VHOST_ADDR_USED);
> >   		if (uaddr)
> > -			return __copy_to_user(uaddr, from, size);
> > +			return copy_to_user(uaddr, from, size);
> >   		ret = translate_desc(vq, (u64)(uintptr_t)to, size, vq->iotlb_iov,
> >   				     ARRAY_SIZE(vq->iotlb_iov),
> > @@ -774,7 +774,7 @@ static int vhost_copy_from_user(struct vhost_virtqueue *vq, void *to,
> >   	int ret;
> >   	if (!vq->iotlb)
> > -		return __copy_from_user(to, from, size);
> > +		return copy_from_user(to, from, size);
> >   	else {
> >   		/* This function should be called after iotlb
> >   		 * prefetch, which means we're sure that vq
> > @@ -787,7 +787,7 @@ static int vhost_copy_from_user(struct vhost_virtqueue *vq, void *to,
> >   		struct iov_iter f;
> >   		if (uaddr)
> > -			return __copy_from_user(to, uaddr, size);
> > +			return copy_from_user(to, uaddr, size);
> >   		ret = translate_desc(vq, (u64)(uintptr_t)from, size, vq->iotlb_iov,
> >   				     ARRAY_SIZE(vq->iotlb_iov),
> > @@ -855,13 +855,13 @@ static inline void __user *__vhost_get_user(struct vhost_virtqueue *vq,
> >   ({ \
> >   	int ret = -EFAULT; \
> >   	if (!vq->iotlb) { \
> > -		ret = __put_user(x, ptr); \
> > +		ret = put_user(x, ptr); \
> >   	} else { \
> >   		__typeof__(ptr) to = \
> >   			(__typeof__(ptr)) __vhost_get_user(vq, ptr,	\
> >   					  sizeof(*ptr), VHOST_ADDR_USED); \
> >   		if (to != NULL) \
> > -			ret = __put_user(x, to); \
> > +			ret = put_user(x, to); \
> >   		else \
> >   			ret = -EFAULT;	\
> >   	} \
> > @@ -872,14 +872,14 @@ static inline void __user *__vhost_get_user(struct vhost_virtqueue *vq,
> >   ({ \
> >   	int ret; \
> >   	if (!vq->iotlb) { \
> > -		ret = __get_user(x, ptr); \
> > +		ret = get_user(x, ptr); \
> >   	} else { \
> >   		__typeof__(ptr) from = \
> >   			(__typeof__(ptr)) __vhost_get_user(vq, ptr, \
> >   							   sizeof(*ptr), \
> >   							   type); \
> >   		if (from != NULL) \
> > -			ret = __get_user(x, from); \
> > +			ret = get_user(x, from); \
> >   		else \
> >   			ret = -EFAULT; \
> >   	} \
