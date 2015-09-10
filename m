From: "Xie, Huawei" <huawei.xie@intel.com>
Subject: Re: virtio optimization idea
Date: Thu, 10 Sep 2015 06:32:35 +0000
Message-ID: <C37D651A908B024F974696C65296B57B2BDC4012__29534.4231104993$1441866800$gmane$org@SHSMSX101.ccr.corp.intel.com>
References: <C37D651A908B024F974696C65296B57B2BDB8C06@SHSMSX101.ccr.corp.intel.com>
	<20150909073339.GA16849@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
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
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: "Venkatesan, Venky" <venky.venkatesan@intel.com>, Linhaifeng <haifeng.lin@huawei.com>, "dev@dpdk.org" <dev@dpdk.org>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, Tetsuya Mukawa <mukawa@igel.co.jp>, "Ouyang,
	Changchun" <changchun.ouyang@intel.com>, Thomas Monjalon <thomas.monjalon@6wind.com>, "Rogers,
	Gerald" <gerald.rogers@intel.com>
List-Id: virtualization@lists.linuxfoundation.org

On 9/9/2015 3:34 PM, Michael S. Tsirkin wrote:
> On Fri, Sep 04, 2015 at 08:25:05AM +0000, Xie, Huawei wrote:
>> Hi:
>>
>> Recently I have done one virtio optimization proof of concept. The
>> optimization includes two parts:
>> 1) avail ring set with fixed descriptors
>> 2) RX vectorization
>> With the optimizations, we could have several times of performance boost
>> for purely vhost-virtio throughput.
> Thanks!
> I'm very happy to see people work on the virtio ring format
> optimizations.
>
> I think it's best to analyze each optimization separately,
> unless you see a reason why they would only give benefit when applied
> together.
 
Agree. Will split the patch to see each change's benefit. Of course it
is also very common two give much more gain than the sum of individual.
 
>
> Also ideally, we'd need a unit test to show the performance impact.
> We've been using the tests in tools/virtio/ under linux,
> feel free to enhance these to simulate more workloads, or
> to suggest something else entirely.
If possible, we would provide perf test case under tools/virtio.
I am interested  if the optimization could help kernel virtio-net driver
performance, if not the other is the bottleneck.
>
> Avail ring is initialized with fixed descriptor and is never changed,
> i.e, the index value of the nth avail ring entry is always n, which
> means virtio PMD is actually refilling desc ring only, without having to
> change avail ring.
> When vhost fetches avail ring, if not evicted, it is always in its first
> level cache.
>
> When RX receives packets from used ring, we use the used->idx as the
> desc idx. This requires that vhost processes and returns descs from
> avail ring to used ring in order, which is true for both current dpdk
> vhost and kernel vhost implementation. In my understanding, there is no
> necessity for vhost net to process descriptors OOO. One case could be
> zero copy, for example, if one descriptor doesn't meet zero copy
> requirment, we could directly return it to used ring, earlier than the
> descriptors in front of it.
> To enforce this, i want to use a reserved bit to indicate in order
> processing of descriptors.
> So what's the point in changing the idx for the used ring?
> You need to communicate the length to the guest anyway, don't you?
For guest virtio driver, we only use the length field in the entry of
the used ring and don't use the index in the entry. Instead, use
used->idx & 255 as the desc idx for RX, and used->idx & 127 as the desc
idx for TX.
For vhost driver, as it couldn't assume fixed ring layout(to support
legacy virtio), it needs to update the idx in the used ring entry.
>
>> For tx ring, the arrangement is like below. Each transmitted mbuf needs
>> a desc for virtio_net_hdr, so actually we have only 128 free slots.
> Just fix this one. Support ANY_LAYOUT and then you can put data
> linearly. And/or support INDIRECT_DESC and then you can
> use an indirect descriptor.
Would check those two features.
>
>>                            
>>
> This one came out corrupted.
Actually i ever replied to the original mail and fixed it. Copy it here
again.

                            ++                                                           
                            ||                                                           
                            ||                                                           
   +-----+-----+-----+--------------+------+------+------+                               
   |  0  |  1  | ... |  127 || 128  | 129  | ...  | 255  |   avail ring                  
   +--+--+--+--+-----+---+------+---+--+---+------+--+---+                               
      |     |            |  ||  |      |             |                                   
      v     v            v  ||  v      v             v                                   
   +--+--+--+--+-----+---+------+---+--+---+------+--+---+                               
   | 127 | 128 | ... |  255 || 127  | 128  | ...  | 255  |   desc ring for virtio_net_hdr
   +--+--+--+--+-----+---+------+---+--+---+------+--+---+                               
      |     |            |  ||  |      |             |                                   
      v     v            v  ||  v      v             v                                   
   +--+--+--+--+-----+---+------+---+--+---+------+--+---+                               
   |  0  |  1  | ... |  127 ||  0   |  1   | ...  | 127  |   desc ring for tx dat 
         

>>                      
>> /huawei
>
> Please Cc virtio related discussion more widely.
> I added the virtualization mailing list.
>
>
> So what you want to do is avoid changing the avail
> ring, isn't it enough to pre-format it and cache
> the values in the guest?
>
> Host can then keep using avail ring without changes, it will stay in cache.
> Something like the below for guest should do the trick (untested):

Good optimization to tackle the cache line transfer issue.
Your change could avoid changing avail ring if it points to same head
index. It could improve kernel virtio-net driver's performance if the
avail ring doesn't change in running.
We would also investigating applying this idea to DPDK virtio PMD slow path.
For the optimization i did, which i call fast path, the driver "knows"
in theory the avail ring willn't never get changed, so it doesn't a)
allocate and free descriptors b) care the avail ring.
Based on the fact the DPDK pmd is actually using the simple desc ring
below, we could directly map avail->idx and used->idx to  desc idx, and
use vector instruction to do parallel processing.

+-+--+-+--+-+-+---------+---+--+---+           
| 0  | 1  | 2 | ... |  254  | 255  |  rx desc ring
+----+----+---+-------------+------+           

 
>
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
>
> diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> index 096b857..9363b50 100644
> --- a/drivers/virtio/virtio_ring.c
> +++ b/drivers/virtio/virtio_ring.c
> @@ -91,6 +91,7 @@ struct vring_virtqueue {
>  	bool last_add_time_valid;
>  	ktime_t last_add_time;
>  #endif
> +	u16 *avail;
>  
>  	/* Tokens for callbacks. */
>  	void *data[];
> @@ -236,7 +237,10 @@ static inline int virtqueue_add(struct virtqueue *_vq,
>  	/* Put entry in available array (but don't update avail->idx until they
>  	 * do sync). */
>  	avail = virtio16_to_cpu(_vq->vdev, vq->vring.avail->idx) & (vq->vring.num - 1);
> -	vq->vring.avail->ring[avail] = cpu_to_virtio16(_vq->vdev, head);
> +	if (vq->avail[avail] != head) {
> +		vq->avail[avail] = head;
> +		vq->vring.avail->ring[avail] = cpu_to_virtio16(_vq->vdev, head);
> +	}
>  
>  	/* Descriptors and available array need to be set before we expose the
>  	 * new available array entries. */
> @@ -724,6 +728,11 @@ struct virtqueue *vring_new_virtqueue(unsigned int index,
>  	vq = kmalloc(sizeof(*vq) + sizeof(void *)*num, GFP_KERNEL);
>  	if (!vq)
>  		return NULL;
> +	vq->avail = kzalloc(sizeof (*vq->avail) * num, GFP_KERNEL);
> +	if (!va->avail) {
> +		kfree(vq);
> +		return NULL;
> +	}
>  
>  	vring_init(&vq->vring, num, pages, vring_align);
>  	vq->vq.callback = callback;
>
