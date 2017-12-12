From: weiping zhang <zhangweiping@didichuxing.com>
Subject: [PATCH v2 0/3] fix cleanup for fail to register_virtio_device
Date: Tue, 12 Dec 2017 21:13:53 +0800
Message-ID: <cover.1513083885.git.zhangweiping@didichuxing.com>
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

This series fix the cleanup for the caller of register_virtio_device,
the main work is use put_device instead of kfree.

V1->V2:
 * virtio_pci: add comments for the reason use put_device
 * virtio vop: also use put_device in in _vop_remove_device()

weiping zhang (3):
  virtio_pci: use put_device instead of kfree
  virtio: use put_device instead of kfree
  virtio: put reference count of virtio_device.dev

 drivers/misc/mic/vop/vop_main.c        | 18 ++++++++++--------
 drivers/remoteproc/remoteproc_virtio.c |  2 +-
 drivers/virtio/virtio_pci_common.c     | 17 +++++++++--------
 3 files changed, 20 insertions(+), 17 deletions(-)

-- 
2.9.4
