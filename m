From: Asias He <asias@redhat.com>
Subject: [PATCH V2 WIP 0/2] vhost-scsi: new device supporting the tcm_vhost
	Linux kernel module
Date: Tue, 12 Mar 2013 14:29:40 +0800
Message-ID: <1363069782-10735-1-git-send-email-asias@redhat.com>
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
To: qemu-devel@nongnu.org
Cc: kvm@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>, virtualization@lists.linux-foundation.org, target-devel@vger.kernel.org, Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

This is on top of Paolo and Nick's work.

Current status:
Works now (guest boots fine, no hang any more) with seabios's virtio-scsi disabled.
Rebased to latest qemu.org/master
Change details are in commit log.

TODO:
Make seabios happy.

Paolo Bonzini (2):
  virtio-scsi: create VirtIOSCSICommon
  vhost-scsi: new device supporting the tcm_vhost Linux kernel module

 hw/Makefile.objs           |   5 +-
 hw/s390x/s390-virtio-bus.c |  35 +++++++
 hw/vhost-scsi.c            | 242 +++++++++++++++++++++++++++++++++++++++++++++
 hw/vhost-scsi.h            |  64 ++++++++++++
 hw/virtio-pci.c            |  59 +++++++++++
 hw/virtio-scsi.c           | 199 +++++++++----------------------------
 hw/virtio-scsi.h           | 129 ++++++++++++++++++++++++
 include/qemu/osdep.h       |   4 +
 8 files changed, 586 insertions(+), 151 deletions(-)
 create mode 100644 hw/vhost-scsi.c
 create mode 100644 hw/vhost-scsi.h

-- 
1.8.1.4
