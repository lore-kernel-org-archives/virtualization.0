From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PATCH post-squash 0/9] virtio 1.0: virtio-pci fixup
Date: Wed, 21 Jan 2015 17:05:08 +0200
Message-ID: <1421852670-23742-1-git-send-email-mst@redhat.com>
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

This is just repost of all patches with fixups squashed in - convenient
if you just want to remove old ones from queue and apply new ones.
I also tweaked commit log for patch
	"virtio_pci: modern driver"
I also included Gerd's tag:
Tested-by: Gerd Hoffmann <kraxel@redhat.com>

You can find it all before the rebase -i --autosquash in my tree:
        git://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git virtio-next
or after rebase -i --autosquash:
        git://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git vhost-next

Hope it helps!

Michael S. Tsirkin (7):
  virtio_pci: move probe/remove code to common
  virtio_pci: modern driver
  virtio_pci_modern: reduce number of mappings
  virtio_pci_modern: support devices with no config
  virtio_pci: add an option to disable legacy driver
  virtio_pci: add module param to force legacy mode
  virtio_pci_modern: drop an unused function

Rusty Russell (2):
  virtio-pci: define layout for virtio 1.0
  virtio_pci: macros for PCI layout offsets

 drivers/virtio/virtio_pci_common.h |  43 ++-
 include/uapi/linux/virtio_pci.h    |  89 +++++
 drivers/virtio/virtio_pci_common.c |  94 ++++-
 drivers/virtio/virtio_pci_legacy.c |  75 +---
 drivers/virtio/virtio_pci_modern.c | 695 +++++++++++++++++++++++++++++++++++++
 drivers/virtio/Kconfig             |  19 +
 drivers/virtio/Makefile            |   3 +-
 7 files changed, 942 insertions(+), 76 deletions(-)
 create mode 100644 drivers/virtio/virtio_pci_modern.c

-- 
MST
