From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PULL] virtio, vhost: features, fixes, cleanups
Date: Wed, 2 Jan 2019 16:23:23 -0500
Message-ID: <20190102162323-mutt-send-email-mst@kernel.org>
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
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: kvm@vger.kernel.org, mst@redhat.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, stefanha@redhat.com, pbonzini@redhat.com, changpeng.liu@intel.com, wangyan122@huawei.com
List-Id: virtualization@lists.linuxfoundation.org

The following changes since commit 7566ec393f4161572ba6f11ad5171fd5d59b0fbd:

  Linux 4.20-rc7 (2018-12-16 15:46:55 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git tags/for_linus

for you to fetch changes up to a691ffb46edd7cb12a17ff0965ab59dbc95f48de:

  vhost: correct the related warning message (2018-12-19 18:23:50 -0500)

----------------------------------------------------------------
virtio, vhost: features, fixes, cleanups

discard in virtio blk
misc fixes and cleanups

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

----------------------------------------------------------------
Changpeng Liu (1):
      virtio_blk: add discard and write zeroes support

Dongli Zhang (1):
      virtio: remove deprecated VIRTIO_PCI_CONFIG()

Michael S. Tsirkin (1):
      virtio: fix test build after uio.h change

Paolo Bonzini (1):
      vhost: split structs into a separate header file

Stefan Hajnoczi (1):
      vhost/vsock: switch to a mutex for vhost_vsock_hash

wangyan (1):
      vhost: correct the related warning message

 drivers/block/virtio_blk.c         |  83 +++++++++++++++++++++++-
 drivers/vhost/scsi.c               |   4 +-
 drivers/vhost/vsock.c              |  16 ++---
 drivers/virtio/virtio_pci_legacy.c |   6 +-
 include/uapi/linux/vhost.h         | 113 +-------------------------------
 include/uapi/linux/vhost_types.h   | 128 +++++++++++++++++++++++++++++++++++++
 include/uapi/linux/virtio_blk.h    |  54 ++++++++++++++++
 tools/virtio/linux/kernel.h        |   4 ++
 8 files changed, 283 insertions(+), 125 deletions(-)
 create mode 100644 include/uapi/linux/vhost_types.h
