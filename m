From: Amit Shah <amit.shah@redhat.com>
Subject: [RFC PATCH 0/8] virtio: Support for hibernation (S4)
Date: Thu, 28 Jul 2011 20:05:05 +0530
Message-ID: <cover.1311863438.git.amit.shah@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Virtualization List <virtualization@lists.linux-foundation.org>
Cc: Amit Shah <amit.shah@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

Hello,

These patches are an initial attempt at supporting hibernation for
virtio drivers.

The default configuration of event_index=on doesn't work; i.e. restore
from a hibernated image only works if the devices have event_index
support turned off.  I have not yet dug into this, but is most likely
due to some state not being sync'ed.  This could be related to the
hack that is patch 3.

Each virtio driver has to be modified to add support for the
freeze/restore callbacks to delete and then re-add the vqs just before
and after hibernation.

Testing:

I've not tested S3 (suspend).

For virtio-net, ping continues working across hibernate (lost one
packet in sole testing).

For virtio-blk, disk activity continues working.

For virtio-console, port IO continues working.


Amit Shah (8):
  virtio: pci: switch to new PM API
  virtio-pci: add PM notification handlers for restore, freeze, thaw,
    poweroff
  virtio-pci: save/restore config space across S4
  virtio: console: Ignore port name update request if name already set
  virtio: console: Use wait_event_freezable instead of _interruptible
  virtio: console: Add freeze and restore handlers to support S4
  virtio: block: Add freeze, restore handlers to support S4
  virtio: net: Add freeze, restore handlers to support S4

 drivers/block/virtio_blk.c    |   24 +++++++++++
 drivers/char/virtio_console.c |   87 +++++++++++++++++++++++++++++++++++++++--
 drivers/net/virtio_net.c      |   51 ++++++++++++++++++++++++
 drivers/virtio/virtio_pci.c   |   57 +++++++++++++++++++++++++--
 include/linux/virtio.h        |    4 ++
 5 files changed, 215 insertions(+), 8 deletions(-)

-- 
1.7.6
