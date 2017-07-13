From: Wei Wang <wei.w.wang@intel.com>
Subject: Re: [PATCH v12 5/8] virtio-balloon: VIRTIO_BALLOON_F_SG
Date: Thu, 13 Jul 2017 15:42:35 +0800
Message-ID: <5967246B.9030804__32331.025604117$1499931617$gmane$org@intel.com>
References: <1499863221-16206-1-git-send-email-wei.w.wang@intel.com>
	<1499863221-16206-6-git-send-email-wei.w.wang@intel.com>
	<20170712160129-mutt-send-email-mst@kernel.org>
	<5966241C.9060503@intel.com>
	<20170712163746-mutt-send-email-mst@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20170712163746-mutt-send-email-mst@kernel.org>
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
Cc: aarcange@redhat.com, virtio-dev@lists.oasis-open.org, kvm@vger.kernel.org, qemu-devel@nongnu.org, amit.shah@redhat.com, liliang.opensource@gmail.com, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, linux-mm@kvack.org, yang.zhang.wz@gmail.com, quan.xu@aliyun.com, cornelia.huck@de.ibm.com, pbonzini@redhat.com, akpm@linux-foundation.org, mgorman@techsingularity.net
List-Id: virtualization@lists.linuxfoundation.org

On 07/12/2017 09:56 PM, Michael S. Tsirkin wrote:
>
> So the way I see it, there are several issues:
>
> - internal wait - forces multiple APIs like kick/kick_sync
>    note how kick_sync can fail but your code never checks return code
> - need to re-write the last descriptor - might not work
>    for alternative layouts which always expose descriptors
>    immediately

Probably it wasn't clear. Please let me explain the two functions here:

1) virtqueue_add_chain_desc(vq, head_id, prev_id,..):
grabs a desc from the vq and inserts it to the chain tail (which is 
indexed by
prev_id, probably better to call it tail_id). Then, the new added desc 
becomes
the tail (i.e. the last desc). The _F_NEXT flag is cleared for each desc 
when it's
added to the chain, and set when another desc comes to follow later.

2) virtqueue_add_chain(vq, head_id,..): expose the chain to the other end.

So, if people want to add a desc and immediately expose it to the other end,
i.e. build a single desc chain, they can just add and expose:

virtqueue_add_chain_desc(..);
virtqueue_add_chain(..,head_id);

Would you see any issues here?


> - some kind of iterator type would be nicer instead of
>    maintaining head/prev explicitly

Why would we need to iterate the chain? I think it would be simpler to use
a wrapper struct:

struct virtqueue_desc_chain {
     unsigned int head;  // head desc id of the chain
     unsigned int tail;     // tail desc id of the chain
}

The new desc will be put to desc[tail].next, and we don't need to walk
from the head desc[head].next when inserting a new desc to the chain, right?


>
> As for the use, it would be better to do
>
> if (!add_next(vq, ...)) {
> 	add_last(vq, ...)
> 	kick
> 	wait
> }

"!add_next(vq, ...)" means that the vq is full? If so, what would 
add_last() do then?


> Using VIRTQUEUE_DESC_ID_INIT seems to avoid a branch in the driver, but
> in fact it merely puts the branch in the virtio code.
>

Actually it wasn't intended to improve performance. It is used to 
indicate the "init" state
of the chain. So, when virtqueue_add_chain_desc(, head_id,..) finds head 
id=INIT, it will
assign the grabbed desc id to &head_id. In some sense, it is equivalent 
to add_first().

Do you have a different opinion here?

Best,
Wei
