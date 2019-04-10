From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PULL] virtio: fixes
Date: Wed, 10 Apr 2019 09:18:58 -0400
Message-ID: <20190410091858-mutt-send-email-mst__49662.7212547295$1554902370$gmane$org@kernel.org>
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
Cc: kvm@vger.kernel.org, mst@redhat.com, netdev@vger.kernel.org, cohuck@redhat.com, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, longpeng2@huawei.com
List-Id: virtualization@lists.linuxfoundation.org

The following changes since commit 15ade5d2e7775667cf191cf2f94327a4889f8b9d:

  Linux 5.1-rc4 (2019-04-07 14:09:59 -1000)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git tags/for_linus

for you to fetch changes up to cf94db21905333e610e479688add629397a4b384:

  virtio: Honour 'may_reduce_num' in vring_create_virtqueue (2019-04-08 17:05:52 -0400)

----------------------------------------------------------------
virtio: fixes, reviewers

Several fixes, add more reviewers to the list

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

----------------------------------------------------------------
Cornelia Huck (1):
      virtio: Honour 'may_reduce_num' in vring_create_virtqueue

Longpeng (1):
      virtio_pci: fix a NULL pointer reference in vp_del_vqs

Michael S. Tsirkin (1):
      MAiNTAINERS: add Paolo, Stefan for virtio blk/scsi

 MAINTAINERS                        | 15 ++++++++++++++-
 drivers/virtio/virtio_pci_common.c |  8 +++++---
 drivers/virtio/virtio_ring.c       |  2 ++
 include/linux/virtio_ring.h        |  2 +-
 4 files changed, 22 insertions(+), 5 deletions(-)
