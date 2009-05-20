From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PATCHv2-RFC 0/2] qemu-kvm: MSI-X support
Date: Wed, 20 May 2009 15:49:40 +0300
Message-ID: <20090520124940.GA12583__6997.95298646695$1242823971$gmane$org@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Christian Borntraeger <borntraeger@de.ibm.com>, Rusty Russell <rusty@rustcorp.com.au>, virtualization@lists.linux-foundation.org, Anthony Liguori <anthony@codemon>
List-Id: virtualization@lists.linuxfoundation.org

Here's a new version of MSI-X support patchset. I have completed
save/load support, and added a global option to disable MSI-X.

This is on top of qemu-kvm.git/queue

Todo: split patch up, support configurations without kernel irqchip,
apply to upstream qemu.git.

Anthony, please take a look at capability bit support that
I added in pci save/load. Does it look sane?
Simple version number is not sufficient for msi, because
user has an option to turn off msi even in new qemu.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>


Michael S. Tsirkin (2):
  qemu-kvm: add MSI-X support
  qemu-kvm: use common code for assigned msix

 Makefile.target        |    2 +-
 hw/device-assignment.c |  329 +++++++++--------------------------
 hw/device-assignment.h |    7 +-
 hw/msix.c              |  454 ++++++++++++++++++++++++++++++++++++++++++++++++
 hw/msix.h              |   38 ++++
 hw/pci.c               |  135 +++++++++++----
 hw/pci.h               |   72 +++++++-
 hw/virtio-balloon.c    |    2 +-
 hw/virtio-blk.c        |    3 +-
 hw/virtio-console.c    |    3 +-
 hw/virtio-net.c        |    3 +-
 hw/virtio.c            |  206 ++++++++++++++++++----
 hw/virtio.h            |    6 +-
 qemu-options.hx        |    2 +
 vl.c                   |    3 +
 15 files changed, 929 insertions(+), 336 deletions(-)
 create mode 100644 hw/msix.c
 create mode 100644 hw/msix.h
