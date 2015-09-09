From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: virtio optimization idea
Date: Wed, 9 Sep 2015 10:33:39 +0300
Message-ID: <20150909073339.GA16849__6639.96404405243$1441824576$gmane$org@redhat.com>
References: <C37D651A908B024F974696C65296B57B2BDB8C06@SHSMSX101.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <C37D651A908B024F974696C65296B57B2BDB8C06@SHSMSX101.ccr.corp.intel.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: "Xie, Huawei" <huawei.xie@intel.com>
Cc: "Venkatesan, Venky" <venky.venkatesan@intel.com>, Linhaifeng <haifeng.lin@huawei.com>, "dev@dpdk.org" <dev@dpdk.org>, virtualization@lists.linux-foundation.org, Tetsuya Mukawa <mukawa@igel.co.jp>, "Ouyang,
	Changchun" <changchun.ouyang@intel.com>, Thomas Monjalon <thomas.monjalon@6wind.com>, "Rogers,
	Gerald" <gerald.rogers@intel.com>
List-Id: virtualization@lists.linuxfoundation.org

On Fri, Sep 04, 2015 at 08:25:05AM +0000, Xie, Huawei wrote:
> Hi:
> 
> Recently I have done one virtio optimization proof of concept. The
> optimization includes two parts:
> 1) avail ring set with fixed descriptors
> 2) RX vectorization
> With the optimizations, we could have several times of performance boost
> for purely vhost-virtio throughput.

Thanks!
I'm very happy to see people work on the virtio ring format
optimizations.

I think it's best to analyze each optimization separately,
unless you see a reason why they would only give benefit when applied
together.

Also ideally, we'd need a unit test to show the performance impact.
We've been using the tests in tools/virtio/ under linux,
feel free to enhance these to simulate more workloads, or
to suggest something else entirely.


> Here i will only cover the first part, which is the prerequisite for the
> second part.
> Let us first take RX for example. Currently when we fill the avail ring
> with guest mbuf, we need
> a) allocate one descriptor(for non sg mbuf) from free descriptors
> b) set the idx of the desc into the entry of avail ring
> c) set the addr/len field of the descriptor to point to guest blank mbuf
> data area
> 
> Those operation takes time, and especially step b results in modifed (M)
> state of the cache line for the avail ring in the virtio processing
> core. When vhost processes the avail ring, the cache line transfer from
> virtio processing core to vhost processing core takes pretty much CPU
> cycles.
> To solve this problem, this is the arrangement of RX ring for DPDK
> pmd(for non-mergable case).
>    
>                     avail                      
>                     idx                        
>                     +                          
>                     |                          
> +----+----+---+-------------+------+           
> | 0  | 1  | 2 | ... |  254  | 255  |  avail ring
> +-+--+-+--+-+-+---------+---+--+---+           
>   |    |    |       |   |      |               
>   |    |    |       |   |      |               
>   v    v    v       |   v      v               
> +-+--+-+--+-+-+---------+---+--+---+           
> | 0  | 1  | 2 | ... |  254  | 255  |  desc ring
> +----+----+---+-------------+------+           
>                     |                          
>                     |                          
> +----+----+---+-------------+------+           
> | 0  | 1  | 2 |     |  254  | 255  |  used ring
> +----+----+---+-------------+------+           
>                     |                          
>                     +    
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

So what's the point in changing the idx for the used ring?
You need to communicate the length to the guest anyway, don't you?


> For tx ring, the arrangement is like below. Each transmitted mbuf needs
> a desc for virtio_net_hdr, so actually we have only 128 free slots.

Just fix this one. Support ANY_LAYOUT and then you can put data
linearly. And/or support INDIRECT_DESC and then you can
use an indirect descriptor.


> 
>                            
> ++                                                          
>                            
> ||                                                          
>                            
> ||                                                          
>   
> +-----+-----+-----+--------------+------+------+------+                              
> 
>    |  0  |  1  | ... |  127 || 128  | 129  | ...  | 255  |   avail ring
> with fixed descriptor                
>   
> +--+--+--+--+-----+---+------+---+--+---+------+--+---+                              
> 
>       |     |            |  ||  |      |            
> |                                  
>       v     v            v  ||  v      v            
> v                                  
>   
> +--+--+--+--+-----+---+------+---+--+---+------+--+---+                              
> 
>    | 127 | 128 | ... |  255 || 127  | 128  | ...  | 255  |   desc ring
> for virtio_net_hdr
>   
> +--+--+--+--+-----+---+------+---+--+---+------+--+---+                              
> 
>       |     |            |  ||  |      |            
> |                                  
>       v     v            v  ||  v      v            
> v                                  
>   
> +--+--+--+--+-----+---+------+---+--+---+------+--+---+                              
> 
>    |  0  |  1  | ... |  127 ||  0   |  1   | ...  | 127  |   desc ring
> for tx dat       
>   
> +-----+-----+-----+--------------+------+------+------+                        
> 

This one came out corrupted.

>                      
> /huawei


Please Cc virtio related discussion more widely.
I added the virtualization mailing list.


So what you want to do is avoid changing the avail
ring, isn't it enough to pre-format it and cache
the values in the guest?

Host can then keep using avail ring without changes, it will stay in cache.
Something like the below for guest should do the trick (untested):

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
index 096b857..9363b50 100644
--- a/drivers/virtio/virtio_ring.c
+++ b/drivers/virtio/virtio_ring.c
@@ -91,6 +91,7 @@ struct vring_virtqueue {
 	bool last_add_time_valid;
 	ktime_t last_add_time;
 #endif
+	u16 *avail;
 
 	/* Tokens for callbacks. */
 	void *data[];
@@ -236,7 +237,10 @@ static inline int virtqueue_add(struct virtqueue *_vq,
 	/* Put entry in available array (but don't update avail->idx until they
 	 * do sync). */
 	avail = virtio16_to_cpu(_vq->vdev, vq->vring.avail->idx) & (vq->vring.num - 1);
-	vq->vring.avail->ring[avail] = cpu_to_virtio16(_vq->vdev, head);
+	if (vq->avail[avail] != head) {
+		vq->avail[avail] = head;
+		vq->vring.avail->ring[avail] = cpu_to_virtio16(_vq->vdev, head);
+	}
 
 	/* Descriptors and available array need to be set before we expose the
 	 * new available array entries. */
@@ -724,6 +728,11 @@ struct virtqueue *vring_new_virtqueue(unsigned int index,
 	vq = kmalloc(sizeof(*vq) + sizeof(void *)*num, GFP_KERNEL);
 	if (!vq)
 		return NULL;
+	vq->avail = kzalloc(sizeof (*vq->avail) * num, GFP_KERNEL);
+	if (!va->avail) {
+		kfree(vq);
+		return NULL;
+	}
 
 	vring_init(&vq->vring, num, pages, vring_align);
 	vq->vq.callback = callback;

-- 
MST
