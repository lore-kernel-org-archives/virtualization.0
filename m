From: Tiwei Bie <tiwei.bie@intel.com>
Subject: [RFC v3 0/5] virtio: support packed ring
Date: Wed, 25 Apr 2018 13:15:45 +0800
Message-ID: <20180425051550.24342-1-tiwei.bie__17499.8381095522$1524633221$gmane$org@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: mst@redhat.com, jasowang@redhat.com, virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Cc: wexu@redhat.com
List-Id: virtualization@lists.linuxfoundation.org

Hello everyone,

This RFC implements packed ring support in virtio driver.

Some simple functional tests have been done with Jason's
packed ring implementation in vhost:

https://lkml.org/lkml/2018/4/23/12

Both of ping and netperf worked as expected (with EVENT_IDX
disabled). But there are below known issues:

1. Reloading the guest driver will break the Tx/Rx;
2. Zeroing the flags when detaching a used desc will
   break the guest -> host path.

Some simple functional tests have also been done with
Wei's packed ring implementation in QEMU:

http://lists.nongnu.org/archive/html/qemu-devel/2018-04/msg00342.html

Both of ping and netperf worked as expected (with EVENT_IDX
disabled). Reloading the guest driver also worked as expected.

TODO:
- Refinements (for code and commit log) and bug fixes;
- Discuss/fix/test EVENT_IDX support;
- Test devices other than net;

RFC v2 -> RFC v3:
- Split into small patches (Jason);
- Add helper virtqueue_use_indirect() (Jason);
- Just set id for the last descriptor of a list (Jason);
- Calculate the prev in virtqueue_add_packed() (Jason);
- Fix/improve desc suppression code (Jason/MST);
- Refine the code layout for XXX_split/packed and wrappers (MST);
- Fix the comments and API in uapi (MST);
- Remove the BUG_ON() for indirect (Jason);
- Some other refinements and bug fixes;

RFC v1 -> RFC v2:
- Add indirect descriptor support - compile test only;
- Add event suppression supprt - compile test only;
- Move vring_packed_init() out of uapi (Jason, MST);
- Merge two loops into one in virtqueue_add_packed() (Jason);
- Split vring_unmap_one() for packed ring and split ring (Jason);
- Avoid using '%' operator (Jason);
- Rename free_head -> next_avail_idx (Jason);
- Add comments for virtio_wmb() in virtqueue_add_packed() (Jason);
- Some other refinements and bug fixes;

Thanks!

Tiwei Bie (5):
  virtio: add packed ring definitions
  virtio_ring: support creating packed ring
  virtio_ring: add packed ring support
  virtio_ring: add event idx support in packed ring
  virtio_ring: enable packed ring

 drivers/virtio/virtio_ring.c       | 1271 ++++++++++++++++++++++++++++--------
 include/linux/virtio_ring.h        |    8 +-
 include/uapi/linux/virtio_config.h |   12 +-
 include/uapi/linux/virtio_ring.h   |   36 +
 4 files changed, 1049 insertions(+), 278 deletions(-)

-- 
2.11.0
