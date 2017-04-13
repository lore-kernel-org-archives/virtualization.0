From: Wei Wang <wei.w.wang@intel.com>
Subject: [PATCH v9 0/5] Extend virtio-balloon for fast (de)inflating & fast
	live migration
Date: Thu, 13 Apr 2017 17:35:03 +0800
Message-ID: <1492076108-117229-1-git-send-email-wei.w.wang__21166.1157817163$1492076413$gmane$org@intel.com>
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
To: virtio-dev@lists.oasis-open.org, linux-kernel@vger.kernel.org, qemu-devel@nongnu.org, virtualization@lists.linux-foundation.org, kvm@vger.kernel.org, linux-mm@kvack.org, mst@redhat.com, david@redhat.com, dave.hansen@intel.com, cornelia.huck@de.ibm.com, akpm@linux-foundation.org, mgorman@techsingularity.net, aarcange@redhat.com, amit.shah@redhat.com, pbonzini@redhat.com, wei.w.wang@intel.com, liliang.opensource@gmail.com
List-Id: virtualization@lists.linuxfoundation.org

This patch series implements two optimizations:
1) transfer pages in chuncks between the guest and host;
2) transfer the guest unused pages to the host so that they
can be skipped to migrate in live migration.

Changes:
v8->v9:
1) Split the two new features, VIRTIO_BALLOON_F_BALLOON_CHUNKS and
VIRTIO_BALLOON_F_MISC_VQ, which were mixed together in the previous
implementation;
2) Simpler function to get the free page block.

v7->v8:
1) Use only one chunk format, instead of two.
2) re-write the virtio-balloon implementation patch.
3) commit changes
4) patch re-org

Liang Li (1):
  virtio-balloon: deflate via a page list

Wei Wang (4):
  virtio-balloon: VIRTIO_BALLOON_F_BALLOON_CHUNKS
  mm: function to offer a page block on the free list
  mm: export symbol of next_zone and first_online_pgdat
  virtio-balloon: VIRTIO_BALLOON_F_MISC_VQ

 drivers/virtio/virtio_balloon.c     | 615 +++++++++++++++++++++++++++++++++---
 include/linux/mm.h                  |   3 +
 include/uapi/linux/virtio_balloon.h |  21 ++
 mm/mmzone.c                         |   2 +
 mm/page_alloc.c                     |  87 +++++
 5 files changed, 678 insertions(+), 50 deletions(-)

-- 
2.7.4
