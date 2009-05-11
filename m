From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PATCH RFC 0/2] qemu-kvm: MSI-X support
Date: Tue, 12 May 2009 01:13:50 +0300
Message-ID: <20090511221350.GA22776__36926.7994458371$1242080182$gmane$org@redhat.com>
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

Here's a draft MSI-X support patch. Among missing features:
save/load support, and command-line flag to control the
feature. This is on top of qemu-kvm: msi-x is disabled
without kvm interrupt injection support for now.

Michael S. Tsirkin (2):
  qemu-kvm: add MSI-X support
  qemu-kvm: use common code for assigned msix

 Makefile.target        |    2 +-
 hw/device-assignment.c |  336 +++++++++++---------------------------------
 hw/device-assignment.h |    8 +-
 hw/msix.c              |  371 ++++++++++++++++++++++++++++++++++++++++++++++++
 hw/msix.h              |   33 +++++
 hw/pci.c               |   35 ++++--
 hw/pci.h               |   57 +++++++-
 hw/virtio-balloon.c    |    2 +-
 hw/virtio-blk.c        |    3 +-
 hw/virtio-console.c    |    3 +-
 hw/virtio-net.c        |    3 +-
 hw/virtio.c            |  167 +++++++++++++++++-----
 hw/virtio.h            |    4 +-
 13 files changed, 709 insertions(+), 315 deletions(-)
 create mode 100644 hw/msix.c
 create mode 100644 hw/msix.h
