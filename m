From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PATCH 0/9] virtio_pci: split out legacy device support
Date: Mon, 8 Dec 2014 15:06:13 +0200
Message-ID: <1418043812-25753-1-git-send-email-mst@redhat.com>
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
Cc: virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

virtio 1.0 support for virtio-pci isn't ready yet.
Therefore, this patchset doesn't make any functional changes.
Instead, this simply refactors virtio-pci, splitting legacy
device support code out to a separate file: virtio_pci_legacy.c

For virtio 1.0, all that's left is to add virtio_pci_modern.c
supporting
	get_features
	finalize_features
	get (config)
	set (config)
	get_status
	set_status
	reset
	setup_vq
	del_vq
	probe
	remove

Most notably, tricky MSI-X vector probing logic stays
in common file: virtio_pci.c. version-specific only has
to code setup/del functions for individual vqs.

Note: this is on top of "virtio 1.0 enhancements"
that I sent earlier.

Michael S. Tsirkin (9):
  virtio_pci: add isr field
  virtio_pci: fix coding style for structs
  virtio_pci: free up vq->priv
  virtio_pci: use priv for vq notification
  virtio_pci: delete vqs indirectly
  virtio_pci: setup vqs indirectly
  virtio_pci: setup config vector indirectly
  virtio_pci: split out legacy device support
  virtio_pci: update file descriptions and copyright

 drivers/virtio/virtio_pci.h        | 136 ++++++++++++
 drivers/virtio/virtio_pci.c        | 430 ++++---------------------------------
 drivers/virtio/virtio_pci_legacy.c | 326 ++++++++++++++++++++++++++++
 drivers/virtio/Makefile            |   2 +-
 4 files changed, 507 insertions(+), 387 deletions(-)
 create mode 100644 drivers/virtio/virtio_pci.h
 create mode 100644 drivers/virtio/virtio_pci_legacy.c

-- 
MST
