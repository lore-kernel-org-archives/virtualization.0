From: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH] virtio-spec: add field for scsi command size
Date: Thu, 20 Jun 2013 11:26:21 +0200
Message-ID: <51C2CABD.70000@redhat.com>
References: <20130314111020.GA18050@redhat.com> <5141E990.7070609@redhat.com>
	<20130314173918.GB29411@redhat.com>
	<87k3lyzknl.fsf@rustcorp.com.au>
	<20130613080259.GA11175@redhat.com>
	<20130613081047.GA11269@redhat.com>
	<20130617063746.GA5693@redhat.com> <87r4fyn1wx.fsf@rustcorp.com.au>
	<20130619082417.GA2558@redhat.com>
	<51C16BC2.2060302@redhat.com> <8761x9mrmk.fsf@rustcorp.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <8761x9mrmk.fsf@rustcorp.com.au>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: virtualization@lists.linux-foundation.org, "Michael S. Tsirkin" <mst@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

Il 20/06/2013 04:40, Rusty Russell ha scritto:
> Paolo Bonzini <pbonzini@redhat.com> writes:
>> Il 19/06/2013 10:24, Michael S. Tsirkin ha scritto:
>>>>> 2) We introduce VIRTIO_NET_F_ANY_LAYOUT and VIRTIO_BLK_F_ANY_LAYOUT
>>>>>    specifically for net and block (note the new names).
>>
>> So why not a transport feature?  Is it just because the SCSI commands
>> for virtio-blk also require a config space field?  Sorry if I missed
>> this upthread.
> 
> Mainly because I'm not sure that *all* devices are now safe.  Are they?

virtio-scsi's implementation in QEMU is not safe (been delaying that for
too long, sorry), but the spec is safe.

Paolo

> I had a stress test half-written for this, pasted below.
> 
> Otherwise I'd be happy to do both: use feature 25 for
> VIRTIO_F_ANY_LAYOUT and another feature bit for the virtio-blk layout
> change.
> 
> Cheers,
> Rusty.
> 
> virtio: CONFIG_VIRTIO_DEVICE_TORTURE
> 
> Virtio devices are not supposed to depend on the framing of the scatter-gather
> lists, but various implementations did.  Safeguard this in future by adding
> an option to deliberately create perverse descriptors.
> 
> Signed-off-by: Rusty Russell <rusty@rustcorp.com.au>
> 
> diff --git a/drivers/virtio/Kconfig b/drivers/virtio/Kconfig
> index 8d5bddb..99c0187 100644
> --- a/drivers/virtio/Kconfig
> +++ b/drivers/virtio/Kconfig
> @@ -5,6 +5,22 @@ config VIRTIO
>  	  bus, such as CONFIG_VIRTIO_PCI, CONFIG_VIRTIO_MMIO, CONFIG_LGUEST,
>  	  CONFIG_RPMSG or CONFIG_S390_GUEST.
>  
> +config VIRTIO_TORTURE
> +	bool "Virtio torture debugging"
> +	depends on VIRTIO && DEBUG_KERNEL
> +	help
> +
> +	  This makes the virtio_ring implementation stress-test
> +	  devices.  In particularly, creatively change the format of
> +	  requests to make sure that devices are properly implemented,
> +	  as well as implement various checks to ensure drivers are
> +	  correct.  This will make your virtual machine slow *and*
> +	  unreliable!  Say N.
> +
> +	  Put virtio_ring.device_torture to your boot commandline to
> +	  torture devices (otherwise only simply sanity checks are
> +	  done).
> +
>  menu "Virtio drivers"
>  
>  config VIRTIO_PCI
> diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> index e82821a..6e5271c 100644
> --- a/drivers/virtio/virtio_ring.c
> +++ b/drivers/virtio/virtio_ring.c
> @@ -45,35 +45,6 @@
>  #define virtio_wmb(vq) wmb()
>  #endif
>  
> -#ifdef DEBUG
> -/* For development, we want to crash whenever the ring is screwed. */
> -#define BAD_RING(_vq, fmt, args...)				\
> -	do {							\
> -		dev_err(&(_vq)->vq.vdev->dev,			\
> -			"%s:"fmt, (_vq)->vq.name, ##args);	\
> -		BUG();						\
> -	} while (0)
> -/* Caller is supposed to guarantee no reentry. */
> -#define START_USE(_vq)						\
> -	do {							\
> -		if ((_vq)->in_use)				\
> -			panic("%s:in_use = %i\n",		\
> -			      (_vq)->vq.name, (_vq)->in_use);	\
> -		(_vq)->in_use = __LINE__;			\
> -	} while (0)
> -#define END_USE(_vq) \
> -	do { BUG_ON(!(_vq)->in_use); (_vq)->in_use = 0; } while(0)
> -#else
> -#define BAD_RING(_vq, fmt, args...)				\
> -	do {							\
> -		dev_err(&_vq->vq.vdev->dev,			\
> -			"%s:"fmt, (_vq)->vq.name, ##args);	\
> -		(_vq)->broken = true;				\
> -	} while (0)
> -#define START_USE(vq)
> -#define END_USE(vq)
> -#endif
> -
>  struct indirect_cache {
>  	unsigned int max;
>  	struct vring_desc *cache;
> @@ -109,7 +80,7 @@ struct vring_virtqueue
>  	/* How to notify other side. FIXME: commonalize hcalls! */
>  	void (*notify)(struct virtqueue *vq);
>  
> -#ifdef DEBUG
> +#ifdef CONFIG_VIRTIO_TORTURE
>  	/* They're supposed to lock for us. */
>  	unsigned int in_use;
>  
> @@ -134,6 +105,200 @@ static inline struct indirect_cache *indirect_cache(struct vring_virtqueue *vq)
>  	return (struct indirect_cache *)&vq->data[vq->vring.num];
>  }
>  
> +#ifdef CONFIG_VIRTIO_TORTURE
> +/* For development, we want to crash whenever the ring is screwed. */
> +#define BAD_RING(_vq, fmt, args...)				\
> +	do {							\
> +		dev_err(&(_vq)->vq.vdev->dev,			\
> +			"%s:"fmt, (_vq)->vq.name, ##args);	\
> +		BUG();						\
> +	} while (0)
> +/* Caller is supposed to guarantee no reentry. */
> +#define START_USE(_vq)						\
> +	do {							\
> +		if ((_vq)->in_use)				\
> +			panic("%s:in_use = %i\n",		\
> +			      (_vq)->vq.name, (_vq)->in_use);	\
> +		(_vq)->in_use = __LINE__;			\
> +	} while (0)
> +#define END_USE(_vq) \
> +	do { BUG_ON(!(_vq)->in_use); (_vq)->in_use = 0; } while(0)
> +
> +static bool device_torture;
> +module_param(device_torture, bool, 0644);
> +
> +struct torture {
> +	unsigned int orig_out, orig_in;
> +	void *orig_data;
> +	struct scatterlist sg[4];
> +	struct scatterlist orig_sg[];
> +};
> +
> +static unsigned tot_len(struct scatterlist sg[], unsigned num)
> +{
> +	unsigned len, i;
> +
> +	for (len = 0, i = 0; i < num; i++)
> +		len += sg[i].length;
> +
> +	return len;
> +}
> +
> +static void copy_sg_data(const struct scatterlist *dst, unsigned dnum,
> +			 const struct scatterlist *src, unsigned snum)
> +{
> +	unsigned len;
> +	struct scatterlist s, d;
> +
> +	s = *src;
> +	d = *dst;
> +
> +	while (snum && dnum) {
> +		len = min(s.length, d.length);
> +		memcpy(sg_virt(&d), sg_virt(&s), len);
> +		d.offset += len;
> +		d.length -= len;
> +		s.offset += len;
> +		s.length -= len;
> +		if (!s.length) {
> +			BUG_ON(snum == 0);
> +			src++;
> +			snum--;
> +			s = *src;
> +		}
> +		if (!d.length) {
> +			BUG_ON(dnum == 0);
> +			dst++;
> +			dnum--;
> +			d = *dst;
> +		}
> +	}
> +}
> +
> +static bool torture_replace(struct scatterlist **sg,
> +			     unsigned int *out,
> +			     unsigned int *in,
> +			     void **data,
> +			     gfp_t gfp)
> +{
> +	static size_t seed;
> +	struct torture *t;
> +	unsigned long outlen, inlen, ourseed, len1;
> +	void *buf;
> +
> +	if (!device_torture)
> +		return true;
> +
> +	outlen = tot_len(*sg, *out);
> +	inlen = tot_len(*sg + *out, *in);
> +
> +	/* This will break horribly on large block requests. */
> +	t = kmalloc(sizeof(*t) + (*out + *in) * sizeof(t->orig_sg[1])
> +		    + outlen + 1 + inlen + 1, gfp);
> +	if (!t)
> +		return false;
> +
> +	sg_init_table(t->sg, 4);
> +	buf = &t->orig_sg[*out + *in];
> +
> +	memcpy(t->orig_sg, *sg, sizeof(**sg) * (*out + *in));
> +	t->orig_out = *out;
> +	t->orig_in = *in;
> +	t->orig_data = *data;
> +	*data = t;
> +
> +	ourseed = ACCESS_ONCE(seed);
> +	seed++;
> +
> +	*sg = t->sg;
> +	if (outlen) {
> +		/* Split outbuf into two parts, one byte apart. */
> +		*out = 2;
> +		len1 = ourseed % (outlen + 1);
> +		sg_set_buf(&t->sg[0], buf, len1);
> +		buf += len1 + 1;
> +		sg_set_buf(&t->sg[1], buf, outlen - len1);
> +		buf += outlen - len1;
> +		copy_sg_data(t->sg, *out, t->orig_sg, t->orig_out);
> +	}
> +
> +	if (inlen) {
> +		/* Split inbuf into two parts, one byte apart. */
> +		*in = 2;
> +		len1 = ourseed % (inlen + 1);
> +		sg_set_buf(&t->sg[*out], buf, len1);
> +		buf += len1 + 1;
> +		sg_set_buf(&t->sg[*out + 1], buf, inlen - len1);
> +		buf += inlen - len1;
> +	}
> +	return true;
> +}
> +
> +static void *torture_done(struct torture *t)
> +{
> +	void *data;
> +
> +	if (!device_torture)
> +		return t;
> +
> +	if (t->orig_in)
> +		copy_sg_data(t->orig_sg + t->orig_out, t->orig_in,
> +			     t->sg + (t->orig_out ? 2 : 0), 2);
> +
> +	data = t->orig_data;
> +	kfree(t);
> +	return data;
> +}
> +
> +static unsigned long tot_inlen(struct virtqueue *vq, unsigned int i)
> +{
> +	struct vring_desc *desc;
> +	unsigned long len = 0;
> +
> +	if (vq->vring.desc[i].flags & VRING_DESC_F_INDIRECT) {
> +		unsigned int num = vq->vring.desc[i].len / sizeof(*desc);
> +		desc = phys_to_virt(vq->vring.desc[i].addr);
> +
> +		for (i = 0; i < num; i++) {
> +			if (desc[i].flags & VRING_DESC_F_WRITE)
> +				len += desc[i].flags.len;
> +		}
> +	} else {
> +		desc = vq->vring.desc;
> +		while (desc[i].flags & VRING_DESC_F_NEXT) {
> +			if (desc[i].flags & VRING_DESC_F_WRITE)
> +				len += desc[i].flags.len;
> +			i = desc[i].next;
> +		}
> +	}
> +
> +	return len;
> +}
> +#else
> +static bool torture_replace(struct scatterlist **sg,
> +			     unsigned int *out,
> +			     unsigned int *in,
> +			     void **data,
> +			     gfp_t gfp)
> +{
> +	return true;
> +}
> +
> +static void *torture_done(void *data)
> +{
> +	return data;
> +}
> +
> +#define BAD_RING(_vq, fmt, args...)				\
> +	do {							\
> +		dev_err(&_vq->vq.vdev->dev,			\
> +			"%s:"fmt, (_vq)->vq.name, ##args);	\
> +		(_vq)->broken = true;				\
> +	} while (0)
> +#define START_USE(vq)
> +#define END_USE(vq)
> +#endif /* CONFIG_VIRTIO_TORTURE */
> +
>  /* Set up an indirect table of descriptors and add it to the queue. */
>  static int vring_add_indirect(struct vring_virtqueue *vq,
>  			      struct scatterlist sg[],
> @@ -228,7 +393,10 @@ int virtqueue_add_buf(struct virtqueue *_vq,
>  
>  	BUG_ON(data == NULL);
>  
> -#ifdef DEBUG
> +	if (!torture_replace(&sg, &out, &in, &data, gfp))
> +		return -ENOMEM;
> +
> +#ifdef CONFIG_VIRTIO_TORTURE
>  	{
>  		ktime_t now = ktime_get();
>  
> @@ -261,6 +429,7 @@ int virtqueue_add_buf(struct virtqueue *_vq,
>  		if (out)
>  			vq->notify(&vq->vq);
>  		END_USE(vq);
> +		torture_done(data);
>  		return -ENOSPC;
>  	}
>  
> @@ -341,7 +510,7 @@ bool virtqueue_kick_prepare(struct virtqueue *_vq)
>  	new = vq->vring.avail->idx;
>  	vq->num_added = 0;
>  
> -#ifdef DEBUG
> +#ifdef CONFIG_VIRTIO_TORTURE
>  	if (vq->last_add_time_valid) {
>  		WARN_ON(ktime_to_ms(ktime_sub(ktime_get(),
>  					      vq->last_add_time)) > 100);
> @@ -474,6 +643,14 @@ void *virtqueue_get_buf(struct virtqueue *_vq, unsigned int *len)
>  		return NULL;
>  	}
>  
> +#ifdef CONFIG_VIRTIO_TORTURE
> +	if (unlikely(tot_inlen(vq, i) < *len)) {
> +		BAD_RING(vq, "id %u: %u > %u used!\n",
> +			 i, *len, tot_inlen(vq, i));
> +		return NULL;
> +	}
> +#endif
> +
>  	/* detach_buf clears data, so grab it now. */
>  	ret = vq->data[i];
>  	detach_buf(vq, i);
> @@ -486,12 +663,14 @@ void *virtqueue_get_buf(struct virtqueue *_vq, unsigned int *len)
>  		virtio_mb(vq);
>  	}
>  
> -#ifdef DEBUG
> +#ifdef CONFIG_VIRTIO_TORTURE
>  	vq->last_add_time_valid = false;
> +	BUG_ON(*len > 
> +
>  #endif
>  
>  	END_USE(vq);
> -	return ret;
> +	return torture_done(ret);
>  }
>  EXPORT_SYMBOL_GPL(virtqueue_get_buf);
>  
> @@ -683,7 +862,7 @@ struct virtqueue *vring_new_virtqueue(unsigned int index,
>  	vq->last_used_idx = 0;
>  	vq->num_added = 0;
>  	list_add_tail(&vq->vq.list, &vdev->vqs);
> -#ifdef DEBUG
> +#ifdef CONFIG_VIRTIO_TORTURE
>  	vq->in_use = false;
>  	vq->last_add_time_valid = false;
>  #endif
> 
