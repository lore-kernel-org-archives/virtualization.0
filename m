From: "Nicholas A. Bellinger" <nab@linux-iscsi.org>
Subject: [PATCH-v2 0/3] virtio/vhost: Add checks for uninitialized VQs
Date: Mon,  1 Apr 2013 23:58:21 +0000
Message-ID: <1364860704-11896-1-git-send-email-nab@linux-iscsi.org>
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
To: target-devel <target-devel@vger.kernel.org>
Cc: kvm-devel <kvm@vger.kernel.org>, "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel <qemu-devel@nongnu.org>, lf-virt <virtualization@lists.linux-foundation.org>, Anthony Liguori <aliguori@linux.vnet.ibm.com>, Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

From: Nicholas Bellinger <nab@linux-iscsi.org>

Hi folks,

This series adds a virtio_queue_valid() for use by virtio-pci code in
order to prevent opreations upon uninitialized VQs, which is currently
expected to occur during seabios setup of virtio-scsi with in-flight
vhost-scsi-pci device code.

On the vhost side, it also adds virtio_queue_valid() sanity checks in
vhost_virtqueue_[start,stop]() and vhost_verify_ring_mappings() in order
to skip the same uninitialized VQs.

Changes from v1:
  - Remove now unnecessary virtio_queue_get_num() calls in virtio-pci.c
  - Add virtio_queue_valid() calls in vhost_virtqueue_[start,stop]()

Please review.

--nab

Michael S. Tsirkin (1):
  virtio: add API to check that ring is setup

Nicholas Bellinger (2):
  virtio-pci: Add virtio_queue_valid checks ahead of
    virtio_queue_get_num
  vhost: Skip uninitialized VQs in vhost_virtqueue_[start,stop]

 hw/vhost.c      |   12 ++++++++++++
 hw/virtio-pci.c |   34 +++++++++++++++-------------------
 hw/virtio.c     |    5 +++++
 hw/virtio.h     |    1 +
 4 files changed, 33 insertions(+), 19 deletions(-)

-- 
1.7.2.5
