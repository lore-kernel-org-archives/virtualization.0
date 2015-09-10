From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PATCH 0/4] vhost test fixes
Date: Thu, 10 Sep 2015 10:23:40 +0300
Message-ID: <1441869802-15847-1-git-send-email-mst__14909.3844499022$1441869859$gmane$org@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: linux-kernel@vger.kernel.org
Cc: "Xie, Huawei" <huawei.xie@intel.com>, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

This fixes up virtio tests, broken by recent changes
to core.

Michael S. Tsirkin (4):
  tools/virtio: fix build after 4.2 changes
  vhost: move features to core
  tools/virtio: propagate V=X to kernel build
  virtio: introduce avail cache

 drivers/vhost/vhost.h        |  4 +++-
 tools/virtio/asm/barrier.h   |  2 ++
 tools/virtio/linux/export.h  |  3 +++
 tools/virtio/linux/kernel.h  |  8 ++++++++
 drivers/vhost/net.c          |  3 +--
 drivers/vhost/scsi.c         |  4 +---
 drivers/vhost/test.c         |  3 +++
 drivers/virtio/virtio_ring.c | 11 ++++++++++-
 tools/virtio/Makefile        |  2 +-
 9 files changed, 32 insertions(+), 8 deletions(-)
 create mode 100644 tools/virtio/linux/export.h

-- 
MST
