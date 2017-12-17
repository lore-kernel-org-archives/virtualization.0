From: weiping zhang <zwp10758@gmail.com>
Subject: [PATCH v3 0/5] proper cleanup if fail to register_virtio_device
Date: Sun, 17 Dec 2017 21:45:21 +0800
Message-ID: <cover.1513517240.git.zhangweiping@didichuxing.com>
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

Patch1 add a helper to get virtio_device's status which will be used
later.
Patch2~4: check virtio_device's status is RTIO_CONFIG_S_ACKNOWLEDGE
or not, if so use put_device otherwise use kfree.
Patch5: add comments for virtio_register_device help caller do a
proper cleanup if got failure.

weiping zhang (5):
  virtio: add helper virtio_get_status
  virtio_pci: don't kfree device on register failure
  virtio_vop: don't kfree device on register failure
  virtio_remoteproc: don't kfree device on register failure
  virtio: add comments for virtio_register_device

 drivers/misc/mic/vop/vop_main.c        | 17 +++++++++++------
 drivers/remoteproc/remoteproc_virtio.c | 10 +++++++++-
 drivers/virtio/virtio.c                | 19 +++++++++++++++++++
 drivers/virtio/virtio_pci_common.c     |  5 ++++-
 include/linux/virtio_config.h          |  2 ++
 5 files changed, 45 insertions(+), 8 deletions(-)

-- 
2.9.4
