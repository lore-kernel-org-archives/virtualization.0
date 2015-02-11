From: Rusty Russell <rusty@rustcorp.com.au>
Subject: [RFC 0/2] virtio_pci: patches never to apply.
Date: Wed, 11 Feb 2015 16:55:15 +1030
Message-ID: <1423635917-31282-1-git-send-email-rusty@rustcorp.com.au>
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
To: lkml <linux-kernel@vger.kernel.org>, lguest@lists.ozlabs.org, virtualization@lists.linux-foundation.org, "Michael S. Tsirkin" <mst@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

This should allow testing when QEMU gets VIRTIO_PCI_CAP_PCI_CFG support,
but I'm pretty sure we should never allow these patches upstream.

Tested with lguest (in virtio-next), which supports VIRTIO_PCI_CAP_PCI_CFG.

Rusty Russell (2):
  virtio_pci: abstract all MMIO accesses.
  virtio: Introducing virtio_pci.no_mmio, the worst boot option in
    history.

 drivers/virtio/virtio_pci_common.c |  70 +++++++-
 drivers/virtio/virtio_pci_common.h |  62 ++++++++
 drivers/virtio/virtio_pci_legacy.c |   1 +
 drivers/virtio/virtio_pci_modern.c | 317 ++++++++++++++++++++++++++++++-------
 4 files changed, 391 insertions(+), 59 deletions(-)

-- 
2.1.0
