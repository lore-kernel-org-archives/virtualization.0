From: "Nicholas A. Bellinger" <nab@linux-iscsi.org>
Subject: [RFC 0/9] vhost-scsi: Add support for host virtualized target
Date: Tue, 24 Jul 2012 22:33:57 +0000
Message-ID: <1343169246-17636-1-git-send-email-nab@linux-iscsi.org>
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
Cc: Jens Axboe <axboe@kernel.dk>, Stefan Hajnoczi <stefanha@linux.vnet.ibm.com>, kvm-devel <kvm@vger.kernel.org>, "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel <qemu-devel@nongnu.org>, Zhi Yong Wu <wuzhy@cn.ibm.com>, Anthony Liguori <aliguori@linux.vnet.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>, lf-virt <virtualization@lists.linux-foundation.org>, Christoph Hellwig <hch@lst.de>
List-Id: virtualization@lists.linuxfoundation.org

From: Nicholas Bellinger <nab@linux-iscsi.org>

Hi Anthony + QEMU storage folks,

The following is a reviewable RFC series of vhost-scsi against yesterday's
QEMU.git/master @ commit 401a66357d.

The series is available directly from:

  git://git.kernel.org/pub/scm/virt/kvm/nab/qemu-kvm.git vhost-scsi-merge

It contains the squashed + re-ordered patches from Stefan -> Zhi's QEMU
original work into a updated series against recent QEMU code.

As mentioned recently on qemu-devel here:

  http://lists.gnu.org/archive/html/qemu-devel/2012-07/msg03280.html

the 'vhost-scsi-merge' branch is currently failing with vhost/virtio
errors using the latest HEAD.  Stefan + myself are currently working through
the 1.1.0 regressions, and will be posting incremental patches against this
working tree as individual progress is made..

Please have a look.

--nab

P.S:

Also, for folks who are interested in trying out a working virtio-scsi <-> tcm_vhost
setup, check out using branch 'vhost-scsi' with the last pre-regression
commit from upstream QEMU that appears to be performing very well.

This along with target-pending.git/for-next-merge for KVM host + a virtio-scsi
SCSI LLD bugfix for KVM guest that's headed into 3.6-rc1 here should be enough
to get up and running:

virtio-scsi: Add vdrv->scan for post VIRTIO_CONFIG_S_DRIVER_OK LUN scanning
http://git.kernel.org/?p=linux/kernel/git/jejb/scsi.git;a=commitdiff;h=59057fbc37178f10a196ab7ec170b80273f75a47;hp=0b1017aab197271a78169fde3d7e487bb721997c

Thanks!

Nicholas Bellinger (1):
  virtio-scsi: Set max_target=0 during vhost-scsi operation

Stefan Hajnoczi (8):
  notifier: add validity check and notify function
  virtio-pci: support host notifiers in TCG mode
  virtio-pci: check that event notification worked
  vhost: Pass device path to vhost_dev_init()
  virtio-scsi: Add wwpn and tgpt properties
  virtio-scsi: Open and initialize /dev/vhost-scsi
  virtio-scsi: Start/stop vhost
  vhost-scsi: add -vhost-scsi host device

 configure            |   10 +++
 event_notifier.c     |   21 ++++++
 event_notifier.h     |    4 +
 hw/Makefile.objs     |    1 +
 hw/qdev-properties.c |   32 +++++++++
 hw/qdev.h            |    3 +
 hw/vhost-scsi.c      |  173 ++++++++++++++++++++++++++++++++++++++++++++++++++
 hw/vhost-scsi.h      |   50 ++++++++++++++
 hw/vhost.c           |    5 +-
 hw/vhost.h           |    3 +-
 hw/vhost_net.c       |    2 +-
 hw/virtio-pci.c      |   28 +++++++-
 hw/virtio-scsi.c     |   59 +++++++++++++++++-
 hw/virtio-scsi.h     |    1 +
 hw/virtio.c          |    7 ++
 qemu-common.h        |    1 +
 qemu-config.c        |   16 +++++
 qemu-options.hx      |    4 +
 vl.c                 |   18 +++++
 19 files changed, 430 insertions(+), 8 deletions(-)
 create mode 100644 hw/vhost-scsi.c
 create mode 100644 hw/vhost-scsi.h

-- 
1.7.2.5
