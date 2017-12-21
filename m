From: weiping zhang <zhangweiping@didichuxing.com>
Subject: [PATCH v5 0/4] use put_device to cleanup resource
Date: Thu, 21 Dec 2017 20:38:48 +0800
Message-ID: <cover.1513825904.git.zhangweiping@didichuxing.com>
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
To: cohuck@redhat.com, mst@redhat.com, jasowang@redhat.com
Cc: virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

Hi,

The main change is split device_register into 2 sperate calls:
device_initalize() and device_add, and then the caller can use
put_device safety when fail to register_virtio_device.

v4->v5:
 * virtio: correct some comments
 * virtio_remoteproc: use put_device directly, not use temp reg_dev

v3->v4:
 * split device_register into device_initialize and devicea_add that
   the caller can always use put_device when fail to register virtio
   device.

v2->v3:
 * virtio: add new helper do get device's status then determine use
   put_device or kfree.

v1->v2:
 * virtio_pci: add comments in commit message for why using put_device
 * virtio_vop: also use put_device int _vop_remove_device

weiping zhang (4):
  virtio: split device_register into device_initialize and device_add
  virtio_pci: don't kfree device on register failure
  virtio_vop: don't kfree device on register failure
  virtio_remoteproc: correct put_device virtio_device.dev

 drivers/misc/mic/vop/vop_main.c        | 20 +++++++++++++-------
 drivers/remoteproc/remoteproc_virtio.c |  2 +-
 drivers/virtio/virtio.c                | 18 +++++++++++++++---
 drivers/virtio/virtio_pci_common.c     |  8 ++++++--
 4 files changed, 35 insertions(+), 13 deletions(-)

-- 
2.9.4
