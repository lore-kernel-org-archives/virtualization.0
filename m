From: Wei Wang <wei.w.wang@intel.com>
Subject: [PATCH v7 kernel 0/5] Extend virtio-balloon for fast (de)inflating &
	fast live migration
Date: Fri,  3 Mar 2017 13:40:25 +0800
Message-ID: <1488519630-89058-1-git-send-email-wei.w.wang__3357.01229419119$1488519868$gmane$org@intel.com>
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
To: virtio-dev@lists.oasis-open.org, kvm@vger.kernel.org, qemu-devel@nongnu.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, linux-mm@kvack.org
Cc: Andrea Arcangeli <aarcange@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>, Amit Shah <amit.shah@redhat.com>, Liang Li <liliang324@gmail.com>, Dave Hansen <dave.hansen@intel.com>, Paolo Bonzini <pbonzini@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

Take over this work from Liang.

This patch series implements two optimizations: 1) transfer pages in chuncks
between the guest and host; 1) transfer the guest unused pages to the host so
that they can be skipped to migrate in live migration.

Please check patch 0003 for more details about optimization 1).

For an idle guest with 8GB RAM, optimization 2) can help shorten the total live
migration time from 2Sec to about 500ms in 10Gbps network
environment. For a guest with quite a lot of page cache and little
unused pages, it's possible to let the guest drop its page cache before
live migration, this case can benefit from this new feature too.

Cc: Michael S. Tsirkin <mst@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Cornelia Huck <cornelia.huck@de.ibm.com>
Cc: Amit Shah <amit.shah@redhat.com>
Cc: Dave Hansen <dave.hansen@intel.com>
Cc: Andrea Arcangeli <aarcange@redhat.com>
Cc: David Hildenbrand <david@redhat.com>
Cc: Liang Li <liliang324@gmail.com>
Cc: Wei Wang <wei.w.wang@intel.com>

Liang Li (5):
  virtio-balloon: rework deflate to add page to a list
  virtio-balloon: VIRTIO_BALLOON_F_CHUNK_TRANSFER
  virtio-balloon: implementation of VIRTIO_BALLOON_F_CHUNK_TRANSFER
  virtio-balloon: define flags and head for host request vq
  This patch contains two parts:

 drivers/virtio/virtio_balloon.c     | 510 ++++++++++++++++++++++++++++++++----
 include/linux/mm.h                  |   3 +
 include/uapi/linux/virtio_balloon.h |  34 +++
 mm/page_alloc.c                     | 120 +++++++++
 4 files changed, 620 insertions(+), 47 deletions(-)

-- 
2.7.4
