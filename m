From: "Nicholas A. Bellinger" <nab@linux-iscsi.org>
Subject: [RFC-v3 0/5] vhost-scsi: Add support for host virtualized target
Date: Tue, 21 Aug 2012 20:52:06 +0000
Message-ID: <1345582331-22593-1-git-send-email-nab__32930.0481862903$1345582582$gmane$org@linux-iscsi.org>
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
Cc: Stefan Hajnoczi <stefanha@linux.vnet.ibm.com>, kvm-devel <kvm@vger.kernel.org>, "Michael S. Tsirkin" <mst@redhat.com>, Jan Kiszka <jan.kiszka@siemens.com>, qemu-devel <qemu-devel@nongnu.org>, Zhi Yong Wu <wuzhy@cn.ibm.com>, Anthony Liguori <aliguori@linux.vnet.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>, lf-virt <virtualization@lists.linux-foundation.org>, Christoph Hellwig <hch@lst.de>
List-Id: virtualization@lists.linuxfoundation.org

From: Nicholas Bellinger <nab@linux-iscsi.org>

Hi folks,

This is the third RFC for vhost-scsi patches against mainline QEMU v1.1
to support the upstream tcm_vhost host virtualized target driver now
available in v3.6-rc kernel code.  This series is based upon last week's
commit 346fe0c4c0b, and is aiming for a future QEMU v1.3 merge.

The patch series is available directly from:

   git://git.kernel.org/pub/scm/virt/kvm/nab/qemu-kvm.git vhost-scsi-merge-v3

This -v3 series contains further review changes based upon feedback from
MST, Paolo, and Blue.  It also contains the changes to function against
the changes in target-pending/master -> headed for v3.6-rc3 code.

Changes from v3 -> v2:

 - Move qdev_prop_vhost_scsi + DEFINE_PROP_VHOST_SCSI defs into vhost-scsi.[c,h]
   (reported by MST)
 - Add enum vhost_scsi_vq_list for VHostSCSI->vqs[] enumeration (reported by MST)
 - Add missing braces around single like if statement to following QEMU
   style (reported by Blue Swirl)
 - Change vhost_scsi_target->vhost_wwpn to char *, in order to drop casts to
   pstrcpy in vhost_scsi_start() + vhost_scsi_stop() (reported by Blue Swirl)
 - Change VHOST_SCSI_GET_ABI_VERSION to 'int' type (MST)
 - Add vhost-scsi.h include for DEFINE_PROP_VHOST_SCSI (mst + nab)
 - Move vhost-scsi related struct members ahead of *cmd_vqs[0] within
   VirtIOSCSI definition.  (paolo + nab)
 - Fix 4 byte alignment of vhost_scsi_target (MST)
 - Convert fprintf(stderr, ...) usage to -> error_report() (reported by MST)
 - Do explict memset of backend before calling VHOST_SCSI_CLEAR_ENDPOINT
   in vhost_scsi_stop() (reported by MST)
 - Add support for vhostfd passing in vhost_scsi_add() (reported by MST)
 - Move net_handle_fd_param() -> monitor_handle_fd_param() for generic
   usage by net/ + vhost-scsi (reported by MST)
 - Change vhost_scsi_add() to use monitor_handle_fd_param() (reported by MST)

Changes from v1 -> v2:

 - Expose ABI version via VHOST_SCSI_GET_ABI_VERSION + use Rev 0 as
   starting point for v3.6-rc code (Stefan + ALiguori + nab)
 - Fix upstream qemu conflict in hw/qdev-properties.c
 - Make GET_ABI_VERSION use int (nab + mst)
 - Drop unnecessary event-notifier changes (nab)
 - Fix vhost-scsi case lables in configure (reported by paolo)
 - Convert qdev_prop_vhost_scsi to use ->get() + ->set() following
   qdev_prop_netdev (reported by paolo)
 - Fix typo in qemu-options.hx definition of vhost-scsi (reported by paolo)
 - Squash virtio-scsi: use the vhost-scsi host device from stefan (nab)
 - Fix up virtio_scsi_properties[] conflict w/ upstream qemu (nab)
 - Drop usage of to_virtio_scsi() in virtio_scsi_set_status()
      (reported by paolo)
 - Use modern VirtIOSCSIConf define in virtio-scsi.h (reported by paolo)
 - Use s->conf->vhost_scsi instead of proxyconf->vhost_scsi in
   virtio_scsi_init() (reported by paolo)
 - Only register QEMU SCSI bus is vhost-scsi is not active (reported by paolo)
 - Fix incorrect VirtIOSCSI->cmd_vqs[0] definition (nab)

Thanks again to everyone who has been reviewing this series!

--nab

Nicholas Bellinger (2):
  monitor: Rename+move net_handle_fd_param -> monitor_handle_fd_param
  virtio-scsi: Set max_target=0 during vhost-scsi operation

Stefan Hajnoczi (3):
  vhost: Pass device path to vhost_dev_init()
  vhost-scsi: add -vhost-scsi host device for use with tcm-vhost
  virtio-scsi: Add start/stop functionality for vhost-scsi

 configure            |   10 +++
 hw/Makefile.objs     |    1 +
 hw/qdev-properties.c |   41 +++++++++++
 hw/vhost-scsi.c      |  190 ++++++++++++++++++++++++++++++++++++++++++++++++++
 hw/vhost-scsi.h      |   62 ++++++++++++++++
 hw/vhost.c           |    5 +-
 hw/vhost.h           |    3 +-
 hw/vhost_net.c       |    2 +-
 hw/virtio-pci.c      |    2 +
 hw/virtio-scsi.c     |   55 ++++++++++++++-
 hw/virtio-scsi.h     |    1 +
 monitor.c            |   18 +++++
 monitor.h            |    1 +
 net.c                |   18 -----
 net.h                |    2 -
 net/socket.c         |    2 +-
 net/tap.c            |    4 +-
 qemu-common.h        |    1 +
 qemu-config.c        |   19 +++++
 qemu-options.hx      |    4 +
 vl.c                 |   18 +++++
 21 files changed, 431 insertions(+), 28 deletions(-)
 create mode 100644 hw/vhost-scsi.c
 create mode 100644 hw/vhost-scsi.h

-- 
1.7.2.5
