From: Wei Wang <wei.w.wang@intel.com>
Subject: [PATCH kernel v8 0/4] Extend virtio-balloon for fast (de)inflating &
	fast live migration
Date: Thu, 16 Mar 2017 15:08:43 +0800
Message-ID: <1489648127-37282-1-git-send-email-wei.w.wang__1935.36939700625$1489648395$gmane$org@intel.com>
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

Please read each patch commit log for details.

Changes:
v7->v8:
1) Use only one chunk format, instead of two.
2) re-write the virtio-balloon implementation patch.
3) commit changes
4) patch re-org

Liang Li (4):
  virtio-balloon: deflate via a page list
  virtio-balloon: VIRTIO_BALLOON_F_CHUNK_TRANSFER
  mm: add inerface to offer info about unused pages
  virtio-balloon: VIRTIO_BALLOON_F_HOST_REQ_VQ

 drivers/virtio/virtio_balloon.c     | 533 ++++++++++++++++++++++++++++++++----
 include/linux/mm.h                  |   3 +
 include/uapi/linux/virtio_balloon.h |  31 +++
 mm/page_alloc.c                     | 114 ++++++++
 4 files changed, 635 insertions(+), 46 deletions(-)

-- 
2.7.4
