From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH 0/3] Virtio: Fine-tuning for two function implementations
Date: Thu, 26 Jan 2017 22:44:44 +0100
Message-ID: <61829748-a13d-42e4-8f6c-103ee5ca2c88__33062.846461735$1485468227$gmane$org@users.sourceforge.net>
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
To: virtualization@lists.linux-foundation.org, Jason Wang <jasowang@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>
Cc: kernel-janitors@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
List-Id: virtualization@lists.linuxfoundation.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Thu, 26 Jan 2017 22:40:02 +0100

A few update suggestions were taken into account
from static source code analysis.

Markus Elfring (3):
  virtio_pci: Use kcalloc() in vp_request_msix_vectors()
  virtio_pci: Use kmalloc_array() in vp_request_msix_vectors()
  virtio_ring: Use kmalloc_array() in alloc_indirect()

 drivers/virtio/virtio_pci_common.c | 8 ++++----
 drivers/virtio/virtio_ring.c       | 3 +--
 2 files changed, 5 insertions(+), 6 deletions(-)

-- 
2.11.0
