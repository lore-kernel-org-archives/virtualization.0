From: Rusty Russell <rusty@rustcorp.com.au>
Subject: [PULL] lguest and virtio fixes
Date: Mon, 12 Nov 2007 14:32:50 +1100
Message-ID: <200711121432.50976.rusty__28956.4422135756$1194838506$gmane$org@rustcorp.com.au>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: lguest <lguest@ozlabs.org>, linux-kernel@vger.kernel.org, Anthony Liguori <anthony@codemonkey.ws>, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

The following changes since commit 6e800af233e0bdf108efb7bd23c11ea6fa34cdeb:
  Jerome Pinot (1):
        ACPI: add documentation for deprecated /proc/acpi/battery in ACPI_PROCFS

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rusty/linux-2.6-virtio.git for-linus

Anthony Liguori (3):
      virtio: fix vring_init for 64 bits
      virtio: Fix used_idx wrap-around
      lguest: Fix lguest virtio-blk backend size computation

Rusty Russell (2):
      virtio: more fallout from scatterlist changes.
      virtio: Force use of power-of-two for descriptor ring sizes

 Documentation/lguest/lguest.c  |   17 +++++++++--------
 drivers/lguest/lguest_device.c |    3 ++-
 drivers/net/virtio_net.c       |    3 +++
 drivers/virtio/virtio_ring.c   |   10 ++++++++--
 include/linux/virtio_ring.h    |   21 ++++++++++++---------
 5 files changed, 34 insertions(+), 20 deletions(-)
