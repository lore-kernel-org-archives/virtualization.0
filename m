From: Amit Shah <amit.shah@redhat.com>
Subject: [PATCH v3 00/11] virtio: S4 support
Date: Thu, 17 Nov 2011 17:27:31 +0530
Message-ID: <cover.1321530505.git.amit.shah@redhat.com>
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
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: Amit Shah <amit.shah@redhat.com>, linux-kernel@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>, levinsasha928@gmail.com, Virtualization List <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

Hi,

These patches add support for S4 to virtio (pci) and all drivers.

For each driver, all vqs are removed before hibernation, and then
re-created after restore.  Some driver-specific uninit and init work
is also done in the freeze and restore functions.

All the drivers in testing work fine:

* virtio-blk is used for the only disk in the VM, IO works fine before
  and after.

* virtio-console: port IO keeps working fine before and after.
  * If a port is waiting for data from the host (blocking read(2)
    call), this works fine in both the cases: host-side connection is
    available or unavailable after resume.  In case the host-side
    connection isn't available, the blocking call is terminated.  If
    it is available, the call continues to remain in blocked state
    till further data arrives.

* virtio-net: ping remains active across S4.

* virtio-balloon: Works fine before and after.  Forgets the ballooned
  value across S4.  If it's desirable to maintain the ballooned value,
  a new config option can be created to do this.

All of these tests are run in parallel.

I have some more tests lined up on similar lines above.  I'll reply
here if something breaks.

Please review and apply if appropriate,

v3:
 - Reset vqs before deleting them (Sasha Levin)
 - Flush block queue before freeze (Rusty)
 - Detach netdev before freeze (Michael S. Tsirkin)

v2:
 - fix checkpatch errors/warnings

Amit Shah (11):
  virtio: pci: switch to new PM API
  virtio: pci: add PM notification handlers for restore, freeze, thaw,
    poweroff
  virtio: console: Move out vq and vq buf removal into separate
    functions
  virtio: console: Add freeze and restore handlers to support S4
  virtio: blk: Move out vq initialization to separate function
  virtio: blk: Add freeze, restore handlers to support S4
  virtio: net: Move out vq initialization into separate function
  virtio: net: Move out vq and vq buf removal into separate function
  virtio: net: Add freeze, restore handlers to support S4
  virtio: balloon: Move out vq initialization into separate function
  virtio: balloon: Add freeze, restore handlers to support S4

 drivers/block/virtio_blk.c      |   55 +++++++++++++++--
 drivers/char/virtio_console.c   |  126 ++++++++++++++++++++++++++++++---------
 drivers/net/virtio_net.c        |   99 ++++++++++++++++++++++--------
 drivers/virtio/virtio_balloon.c |   68 +++++++++++++++------
 drivers/virtio/virtio_pci.c     |   66 +++++++++++++++++++-
 include/linux/virtio.h          |    4 +
 6 files changed, 336 insertions(+), 82 deletions(-)

-- 
1.7.7.1
