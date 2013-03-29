From: "Nicholas A. Bellinger" <nab@linux-iscsi.org>
Subject: [PATCH-v2 0/2] Add support for vhost-scsi-pci
Date: Fri, 29 Mar 2013 01:08:14 +0000
Message-ID: <1364519296-31883-1-git-send-email-nab@linux-iscsi.org>
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

Hi QEMU folks,

The following is the patch-v2 series to support vhost-scsi-pci within
the upstream QEMU tree.

This includes the refactoring of existing virtio-scsi code from Paolo
to allow a VirtIOSCSICommon structure that is shared amoungst existing
virtio-scsi-pci device and new vhost-scsi-pci device code.

Currently this code requires Asias's seabios bugfixes (commit 5a7730db5
and b44a7be17), and two other tcm_vhost patches to reset vq->last_used_idx
after seabios handoff and disable EVENT_IDX from GET_FEATURES that's
currently in flight for v3.9.0 kernel code.

There is a seperate issue with seabios virtio-scsi that's causing a failure
in vhost_verify_ring_mappings() is still being tracked down, but this series
should now be getting close to a merge minus this last outstanding item.

Changes in Patch-v2:
   - Move ->get_features() assignment to virtio_scsi_init() instead of
     virtio_scsi_init_common() (nab)
   - Add vhost_scsi_get_features() in order to determine feature bits
     supports by host kernel (mst + nab)
   - Re-enable usage of DEFINE_VIRTIO_COMMON_FEATURES, and allow
     EVENT_IDX to be disabled by host in vhost_scsi_get_features() (mst)
   - Drop unused hotplug bit in DEFINE_VHOST_SCSI_PROPERTIES (mst)
   - Drop vhost_verify_ring_mappings() enable-only hack (mst)

A big thanks to Paolo, Asias, MST, and Stefan for all of their efforts
on this series.

Thank you,

Paolo Bonzini (2):
  virtio-scsi: create VirtIOSCSICommon
  vhost-scsi: new device supporting the tcm_vhost Linux kernel module

 configure                  |   15 +++-
 hw/Makefile.objs           |    5 +-
 hw/s390x/s390-virtio-bus.c |   35 ++++++
 hw/vhost-scsi.c            |  264 ++++++++++++++++++++++++++++++++++++++++++++
 hw/vhost-scsi.h            |   64 +++++++++++
 hw/virtio-pci.c            |   62 ++++++++++
 hw/virtio-scsi.c           |  192 ++++++++------------------------
 hw/virtio-scsi.h           |  132 +++++++++++++++++++++-
 include/qemu/osdep.h       |    4 +
 9 files changed, 623 insertions(+), 150 deletions(-)
 create mode 100644 hw/vhost-scsi.c
 create mode 100644 hw/vhost-scsi.h

-- 
1.7.2.5
