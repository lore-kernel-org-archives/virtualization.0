From: Wei Wang <wei.w.wang@intel.com>
Subject: [PATCH v1 0/2] Virtio: fix some vq allocation issues
Date: Fri, 28 Dec 2018 10:26:24 +0800
Message-ID: <1545963986-11280-1-git-send-email-wei.w.wang__21225.5098428161$1545965968$gmane$org@intel.com>
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
To: virtio-dev@lists.oasis-open.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, kvm@vger.kernel.org, mst@redhat.com, cohuck@redhat.com
Cc: dgilbert@redhat.com, pbonzini@redhat.com
List-Id: virtualization@lists.linuxfoundation.org

Some vqs don't need to be allocated when the related feature bits are
disabled. Callers notice the vq allocation layer by setting the related
names[i] to be NULL.

This patch series fixes the find_vqs implementations to handle this case.

Wei Wang (2):
  virtio_pci: use queue idx instead of array idx to set up the vq
  virtio: don't allocate vqs when names[i] = NULL

 drivers/misc/mic/vop/vop_main.c        |  9 +++++++--
 drivers/remoteproc/remoteproc_virtio.c |  9 +++++++--
 drivers/s390/virtio/virtio_ccw.c       | 12 +++++++++---
 drivers/virtio/virtio_mmio.c           |  9 +++++++--
 drivers/virtio/virtio_pci_common.c     |  8 ++++----
 5 files changed, 34 insertions(+), 13 deletions(-)

-- 
2.7.4
