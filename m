From: Jason Wang <jasowang@redhat.com>
Subject: [RFC PATCH V2 0/5] vhost: accelerate metadata access through vmap()
Date: Wed,  6 Mar 2019 02:18:07 -0500
Message-ID: <1551856692-3384-1-git-send-email-jasowang@redhat.com>
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
To: jasowang@redhat.com, mst@redhat.com, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: aarcange@redhat.com, linux-mm@kvack.org
List-Id: virtualization@lists.linuxfoundation.org

This series tries to access virtqueue metadata through kernel virtual
address instead of copy_user() friends since they had too much
overheads like checks, spec barriers or even hardware feature
toggling. This is done through setup kernel address through vmap() and
resigter MMU notifier for invalidation.

Test shows about 24% improvement on TX PPS. TCP_STREAM doesn't see
obvious improvement.

Thanks

Changes from V4:
- use invalidate_range() instead of invalidate_range_start()
- track dirty pages
Changes from V3:
- don't try to use vmap for file backed pages
- rebase to master
Changes from V2:
- fix buggy range overlapping check
- tear down MMU notifier during vhost ioctl to make sure invalidation
  request can read metadata userspace address and vq size without
  holding vq mutex.
Changes from V1:
- instead of pinning pages, use MMU notifier to invalidate vmaps and
  remap duing metadata prefetch
- fix build warning on MIPS

Jason Wang (5):
  vhost: generalize adding used elem
  vhost: fine grain userspace memory accessors
  vhost: rename vq_iotlb_prefetch() to vq_meta_prefetch()
  vhost: introduce helpers to get the size of metadata area
  vhost: access vq metadata through kernel virtual address

 drivers/vhost/net.c   |   6 +-
 drivers/vhost/vhost.c | 434 ++++++++++++++++++++++++++++++++++++++++++++------
 drivers/vhost/vhost.h |  18 ++-
 3 files changed, 407 insertions(+), 51 deletions(-)

-- 
1.8.3.1
