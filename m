From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH net-next v2 0/5] virtio: support packed ring
Date: Mon, 27 Aug 2018 17:00:40 +0300
Message-ID: <20180827170005-mutt-send-email-mst__28578.0398444787$1535378323$gmane$org@kernel.org>
References: <20180711022711.7090-1-tiwei.bie@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20180711022711.7090-1-tiwei.bie@intel.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Tiwei Bie <tiwei.bie@intel.com>
Cc: virtio-dev@lists.oasis-open.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, wexu@redhat.com
List-Id: virtualization@lists.linuxfoundation.org

Are there still plans to test the performance with vost pmd?
vhost doesn't seem to show a performance gain ...


On Wed, Jul 11, 2018 at 10:27:06AM +0800, Tiwei Bie wrote:
> Hello everyone,
> 
> This patch set implements packed ring support in virtio driver.
> 
> Some functional tests have been done with Jason's
> packed ring implementation in vhost:
> 
> https://lkml.org/lkml/2018/7/3/33
> 
> Both of ping and netperf worked as expected.
> 
> v1 -> v2:
> - Use READ_ONCE() to read event off_wrap and flags together (Jason);
> - Add comments related to ccw (Jason);
> 
> RFC (v6) -> v1:
> - Avoid extra virtio_wmb() in virtqueue_enable_cb_delayed_packed()
>   when event idx is off (Jason);
> - Fix bufs calculation in virtqueue_enable_cb_delayed_packed() (Jason);
> - Test the state of the desc at used_idx instead of last_used_idx
>   in virtqueue_enable_cb_delayed_packed() (Jason);
> - Save wrap counter (as part of queue state) in the return value
>   of virtqueue_enable_cb_prepare_packed();
> - Refine the packed ring definitions in uapi;
> - Rebase on the net-next tree;
> 
> RFC v5 -> RFC v6:
> - Avoid tracking addr/len/flags when DMA API isn't used (MST/Jason);
> - Define wrap counter as bool (Jason);
> - Use ALIGN() in vring_init_packed() (Jason);
> - Avoid using pointer to track `next` in detach_buf_packed() (Jason);
> - Add comments for barriers (Jason);
> - Don't enable RING_PACKED on ccw for now (noticed by Jason);
> - Refine the memory barrier in virtqueue_poll();
> - Add a missing memory barrier in virtqueue_enable_cb_delayed_packed();
> - Remove the hacks in virtqueue_enable_cb_prepare_packed();
> 
> RFC v4 -> RFC v5:
> - Save DMA addr, etc in desc state (Jason);
> - Track used wrap counter;
> 
> RFC v3 -> RFC v4:
> - Make ID allocation support out-of-order (Jason);
> - Various fixes for EVENT_IDX support;
> 
> RFC v2 -> RFC v3:
> - Split into small patches (Jason);
> - Add helper virtqueue_use_indirect() (Jason);
> - Just set id for the last descriptor of a list (Jason);
> - Calculate the prev in virtqueue_add_packed() (Jason);
> - Fix/improve desc suppression code (Jason/MST);
> - Refine the code layout for XXX_split/packed and wrappers (MST);
> - Fix the comments and API in uapi (MST);
> - Remove the BUG_ON() for indirect (Jason);
> - Some other refinements and bug fixes;
> 
> RFC v1 -> RFC v2:
> - Add indirect descriptor support - compile test only;
> - Add event suppression supprt - compile test only;
> - Move vring_packed_init() out of uapi (Jason, MST);
> - Merge two loops into one in virtqueue_add_packed() (Jason);
> - Split vring_unmap_one() for packed ring and split ring (Jason);
> - Avoid using '%' operator (Jason);
> - Rename free_head -> next_avail_idx (Jason);
> - Add comments for virtio_wmb() in virtqueue_add_packed() (Jason);
> - Some other refinements and bug fixes;
> 
> Thanks!
> 
> Tiwei Bie (5):
>   virtio: add packed ring definitions
>   virtio_ring: support creating packed ring
>   virtio_ring: add packed ring support
>   virtio_ring: add event idx support in packed ring
>   virtio_ring: enable packed ring
> 
>  drivers/s390/virtio/virtio_ccw.c   |   14 +
>  drivers/virtio/virtio_ring.c       | 1365 ++++++++++++++++++++++------
>  include/linux/virtio_ring.h        |    8 +-
>  include/uapi/linux/virtio_config.h |    3 +
>  include/uapi/linux/virtio_ring.h   |   43 +
>  5 files changed, 1157 insertions(+), 276 deletions(-)
> 
> -- 
> 2.18.0
