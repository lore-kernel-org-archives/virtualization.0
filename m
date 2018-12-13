From: jiangyiwen <jiangyiwen@huawei.com>
Subject: Re: [PATCH v2 2/5] VSOCK: support fill data to mergeable rx buffer in
	host
Date: Thu, 13 Dec 2018 11:08:04 +0800
Message-ID: <5C11CD14.3040809@huawei.com>
References: <5C10D4FB.6070009@huawei.com>
	<20181212103138-mutt-send-email-mst@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20181212103138-mutt-send-email-mst@kernel.org>
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
Cc: netdev@vger.kernel.org, kvm@vger.kernel.org, Stefan Hajnoczi <stefanha@redhat.com>, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On 2018/12/12 23:37, Michael S. Tsirkin wrote:
> On Wed, Dec 12, 2018 at 05:29:31PM +0800, jiangyiwen wrote:
>> When vhost support VIRTIO_VSOCK_F_MRG_RXBUF feature,
>> it will merge big packet into rx vq.
>>
>> Signed-off-by: Yiwen Jiang <jiangyiwen@huawei.com>
> 
> I feel this approach jumps into making interface changes for
> optimizations too quickly. For example, what prevents us
> from taking a big buffer, prepending each chunk
> with the header and writing it out without
> host/guest interface changes?
> 
> This should allow optimizations such as vhost_add_used_n
> batching.
> 
> I realize a header in each packet does have a cost,
> but it also has advantages such as improved robustness,
> I'd like to see more of an apples to apples comparison
> of the performance gain from skipping them.
> 
> 

Hi Michael,

I don't fully understand what you mean, do you want to
see a performance comparison that before performance and
only use batching?

In my opinion, guest don't fill big buffer in rx vq because
the balance performance and guest memory pressure, add
mergeable feature can improve big packets performance,
as for small packets, I try to find out the reason, may be
the fluctuation of test results, or in mergeable mode, when
Host send a 4k packet to Guest, we should call vhost_get_vq_desc()
twice in host(hdr + 4k data), and in guest we also should call
virtqueue_get_buf() twice.

Thanks,
Yiwen.

>> ---
>>  drivers/vhost/vsock.c             | 111 ++++++++++++++++++++++++++++++--------
>>  include/linux/virtio_vsock.h      |   1 +
>>  include/uapi/linux/virtio_vsock.h |   5 ++
>>  3 files changed, 94 insertions(+), 23 deletions(-)
>>
>> diff --git a/drivers/vhost/vsock.c b/drivers/vhost/vsock.c
>> index 34bc3ab..dc52b0f 100644
>> --- a/drivers/vhost/vsock.c
>> +++ b/drivers/vhost/vsock.c
>> @@ -22,7 +22,8 @@
>>  #define VHOST_VSOCK_DEFAULT_HOST_CID	2
>>
>>  enum {
>> -	VHOST_VSOCK_FEATURES = VHOST_FEATURES,
>> +	VHOST_VSOCK_FEATURES = VHOST_FEATURES |
>> +			(1ULL << VIRTIO_VSOCK_F_MRG_RXBUF),
>>  };
>>
>>  /* Used to track all the vhost_vsock instances on the system. */
>> @@ -80,6 +81,69 @@ static struct vhost_vsock *vhost_vsock_get(u32 guest_cid)
>>  	return vsock;
>>  }
>>
>> +/* This segment of codes are copied from drivers/vhost/net.c */
>> +static int get_rx_bufs(struct vhost_virtqueue *vq,
>> +		struct vring_used_elem *heads, int datalen,
>> +		unsigned *iovcount, unsigned int quota)
>> +{
>> +	unsigned int out, in;
>> +	int seg = 0;
>> +	int headcount = 0;
>> +	unsigned d;
>> +	int ret;
>> +	/*
>> +	 * len is always initialized before use since we are always called with
>> +	 * datalen > 0.
>> +	 */
>> +	u32 uninitialized_var(len);
>> +
>> +	while (datalen > 0 && headcount < quota) {
>> +		if (unlikely(seg >= UIO_MAXIOV)) {
>> +			ret = -ENOBUFS;
>> +			goto err;
>> +		}
>> +
>> +		ret = vhost_get_vq_desc(vq, vq->iov + seg,
>> +				ARRAY_SIZE(vq->iov) - seg, &out,
>> +				&in, NULL, NULL);
>> +		if (unlikely(ret < 0))
>> +			goto err;
>> +
>> +		d = ret;
>> +		if (d == vq->num) {
>> +			ret = 0;
>> +			goto err;
>> +		}
>> +
>> +		if (unlikely(out || in <= 0)) {
>> +			vq_err(vq, "unexpected descriptor format for RX: "
>> +					"out %d, in %d\n", out, in);
>> +			ret = -EINVAL;
>> +			goto err;
>> +		}
>> +
>> +		heads[headcount].id = cpu_to_vhost32(vq, d);
>> +		len = iov_length(vq->iov + seg, in);
>> +		heads[headcount].len = cpu_to_vhost32(vq, len);
>> +		datalen -= len;
>> +		++headcount;
>> +		seg += in;
>> +	}
>> +
>> +	heads[headcount - 1].len = cpu_to_vhost32(vq, len + datalen);
>> +	*iovcount = seg;
>> +
>> +	/* Detect overrun */
>> +	if (unlikely(datalen > 0)) {
>> +		ret = UIO_MAXIOV + 1;
>> +		goto err;
>> +	}
>> +	return headcount;
>> +err:
>> +	vhost_discard_vq_desc(vq, headcount);
>> +	return ret;
>> +}
>> +
>>  static void
>>  vhost_transport_do_send_pkt(struct vhost_vsock *vsock,
>>  			    struct vhost_virtqueue *vq)
>> @@ -87,22 +151,34 @@ static struct vhost_vsock *vhost_vsock_get(u32 guest_cid)
>>  	struct vhost_virtqueue *tx_vq = &vsock->vqs[VSOCK_VQ_TX];
>>  	bool added = false;
>>  	bool restart_tx = false;
>> +	int mergeable;
>> +	size_t vsock_hlen;
>>
>>  	mutex_lock(&vq->mutex);
>>
>>  	if (!vq->private_data)
>>  		goto out;
>>
>> +	mergeable = vhost_has_feature(vq, VIRTIO_VSOCK_F_MRG_RXBUF);
>> +	/*
>> +	 * Guest fill page for rx vq in mergeable case, so it will not
>> +	 * allocate pkt structure, we should reserve size of pkt in advance.
>> +	 */
>> +	if (likely(mergeable))
>> +		vsock_hlen = sizeof(struct virtio_vsock_pkt);
>> +	else
>> +		vsock_hlen = sizeof(struct virtio_vsock_hdr);
>> +
>>  	/* Avoid further vmexits, we're already processing the virtqueue */
>>  	vhost_disable_notify(&vsock->dev, vq);
>>
>>  	for (;;) {
>>  		struct virtio_vsock_pkt *pkt;
>>  		struct iov_iter iov_iter;
>> -		unsigned out, in;
>> +		unsigned out = 0, in = 0;
>>  		size_t nbytes;
>>  		size_t len;
>> -		int head;
>> +		s16 headcount;
>>
>>  		spin_lock_bh(&vsock->send_pkt_list_lock);
>>  		if (list_empty(&vsock->send_pkt_list)) {
>> @@ -116,16 +192,9 @@ static struct vhost_vsock *vhost_vsock_get(u32 guest_cid)
>>  		list_del_init(&pkt->list);
>>  		spin_unlock_bh(&vsock->send_pkt_list_lock);
>>
>> -		head = vhost_get_vq_desc(vq, vq->iov, ARRAY_SIZE(vq->iov),
>> -					 &out, &in, NULL, NULL);
>> -		if (head < 0) {
>> -			spin_lock_bh(&vsock->send_pkt_list_lock);
>> -			list_add(&pkt->list, &vsock->send_pkt_list);
>> -			spin_unlock_bh(&vsock->send_pkt_list_lock);
>> -			break;
>> -		}
>> -
>> -		if (head == vq->num) {
>> +		headcount = get_rx_bufs(vq, vq->heads, vsock_hlen + pkt->len,
>> +				&in, likely(mergeable) ? UIO_MAXIOV : 1);
>> +		if (headcount <= 0) {
>>  			spin_lock_bh(&vsock->send_pkt_list_lock);
>>  			list_add(&pkt->list, &vsock->send_pkt_list);
>>  			spin_unlock_bh(&vsock->send_pkt_list_lock);
>> @@ -133,24 +202,20 @@ static struct vhost_vsock *vhost_vsock_get(u32 guest_cid)
>>  			/* We cannot finish yet if more buffers snuck in while
>>  			 * re-enabling notify.
>>  			 */
>> -			if (unlikely(vhost_enable_notify(&vsock->dev, vq))) {
>> +			if (!headcount && unlikely(vhost_enable_notify(&vsock->dev, vq))) {
>>  				vhost_disable_notify(&vsock->dev, vq);
>>  				continue;
>>  			}
>>  			break;
>>  		}
>>
>> -		if (out) {
>> -			virtio_transport_free_pkt(pkt);
>> -			vq_err(vq, "Expected 0 output buffers, got %u\n", out);
>> -			break;
>> -		}
>> -
>>  		len = iov_length(&vq->iov[out], in);
>>  		iov_iter_init(&iov_iter, READ, &vq->iov[out], in, len);
>>
>> -		nbytes = copy_to_iter(&pkt->hdr, sizeof(pkt->hdr), &iov_iter);
>> -		if (nbytes != sizeof(pkt->hdr)) {
>> +		if (likely(mergeable))
>> +			pkt->mrg_rxbuf_hdr.num_buffers = cpu_to_le16(headcount);
>> +		nbytes = copy_to_iter(&pkt->hdr, vsock_hlen, &iov_iter);
>> +		if (nbytes != vsock_hlen) {
>>  			virtio_transport_free_pkt(pkt);
>>  			vq_err(vq, "Faulted on copying pkt hdr\n");
>>  			break;
>> @@ -163,7 +228,7 @@ static struct vhost_vsock *vhost_vsock_get(u32 guest_cid)
>>  			break;
>>  		}
>>
>> -		vhost_add_used(vq, head, sizeof(pkt->hdr) + pkt->len);
>> +		vhost_add_used_n(vq, vq->heads, headcount);
>>  		added = true;
>>
>>  		if (pkt->reply) {
>> diff --git a/include/linux/virtio_vsock.h b/include/linux/virtio_vsock.h
>> index bf84418..da9e1fe 100644
>> --- a/include/linux/virtio_vsock.h
>> +++ b/include/linux/virtio_vsock.h
>> @@ -50,6 +50,7 @@ struct virtio_vsock_sock {
>>
>>  struct virtio_vsock_pkt {
>>  	struct virtio_vsock_hdr	hdr;
>> +	struct virtio_vsock_mrg_rxbuf_hdr mrg_rxbuf_hdr;
>>  	struct work_struct work;
>>  	struct list_head list;
>>  	/* socket refcnt not held, only use for cancellation */
>> diff --git a/include/uapi/linux/virtio_vsock.h b/include/uapi/linux/virtio_vsock.h
>> index 1d57ed3..2292f30 100644
>> --- a/include/uapi/linux/virtio_vsock.h
>> +++ b/include/uapi/linux/virtio_vsock.h
>> @@ -63,6 +63,11 @@ struct virtio_vsock_hdr {
>>  	__le32	fwd_cnt;
>>  } __attribute__((packed));
>>
>> +/* It add mergeable rx buffers feature */
>> +struct virtio_vsock_mrg_rxbuf_hdr {
>> +	__le16  num_buffers;    /* number of mergeable rx buffers */
>> +} __attribute__((packed));
>> +
>>  enum virtio_vsock_type {
>>  	VIRTIO_VSOCK_TYPE_STREAM = 1,
>>  };
>> -- 
>> 1.8.3.1
>>
> 
> .
> 
