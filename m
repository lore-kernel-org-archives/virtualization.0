From: Tiwei Bie <tiwei.bie@intel.com>
Subject: [RFC v5 0/5] virtio: support packed ring
Date: Tue, 22 May 2018 16:16:43 +0800
Message-ID: <20180522081648.14768-1-tiwei.bie__48550.2097326846$1526976921$gmane$org@intel.com>
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
packed ring implementation in vhost (RFC v4):

https://lkml.org/lkml/2018/5/16/501

Both of ping and netperf worked as expected w/ EVENT_IDX
disabled. Ping worked as expected w/ EVENT_IDX enabled,
but netperf didn't (A hack has been added in the driver
to make netperf test pass in this case. The hack can be
found by `grep -rw XXX` in the code).

TODO:
- Refinements (for code and commit log);
- More tests;
- Bug fixes;

RFC v4 -> RFC v5:
- Save DMA addr, etc in desc state (Jason);
- Track used wrap counter;

RFC v3 -> RFC v4:
- Make ID allocation support out-of-order (Jason);
- Various fixes for EVENT_IDX support;

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

 drivers/virtio/virtio_ring.c       | 1354 ++++++++++++++++++++++------
 include/linux/virtio_ring.h        |    8 +-
 include/uapi/linux/virtio_config.h |    5 +-
 include/uapi/linux/virtio_ring.h   |   36 +
 4 files changed, 1125 insertions(+), 278 deletions(-)

-- 
2.17.0
