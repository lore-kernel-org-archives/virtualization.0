From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PATCH 0/6] virtio_balloon: virtio 1 support
Date: Mon, 30 Mar 2015 19:37:08 +0200
Message-ID: <1427737006-23191-1-git-send-email-mst__35242.6670644947$1427737052$gmane$org@redhat.com>
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
Cc: virtio-dev@lists.oasis-open.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

Virtio 1.0 doesn't include a modern balloon device.
At some point we'll likely define an incompatible interface with a different
ID.  But for now, it's not a big change to support a transitional balloon
device: this has the advantage of supporting existing drivers, transparently.

The only issue is with the stats buffer, which has misaligned fields.
Seems easy to fix by prepending a 6 byte reserved field.

I'll post spec patch and qemu patches shortly.

Michael S. Tsirkin (6):
  virtio_balloon: transitional interface
  virtio: balloon might not be a legacy device
  virtio_ccw: support non-legacy balloon devices
  virtio_mmio: support non-legacy balloon devices
  virtio_pci: support non-legacy balloon devices
  virtio: drop virtio_device_is_legacy_only

 include/linux/virtio.h              |  2 --
 include/uapi/linux/virtio_balloon.h |  6 ++++++
 drivers/s390/kvm/virtio_ccw.c       | 10 +++-------
 drivers/virtio/virtio.c             |  6 ------
 drivers/virtio/virtio_balloon.c     |  8 ++++++--
 drivers/virtio/virtio_mmio.c        |  8 --------
 drivers/virtio/virtio_pci_modern.c  |  3 ---
 7 files changed, 15 insertions(+), 28 deletions(-)

-- 
MST
