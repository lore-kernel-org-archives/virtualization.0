From: Rusty Russell <rusty@rustcorp.com.au>
Subject: [PULL] virtio (console and one block)
Date: Thu, 21 Oct 2010 17:52:27 +1030
Message-ID: <201010211752.27742.rusty@rustcorp.com.au>
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
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Amit Shah <amit.shah@redhat.com>, Christoph Hellwig <hch@lst.de>, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

The following changes since commit f6f94e2ab1b33f0082ac22d71f66385a60d8157f:

  Linux 2.6.36 (2010-10-20 13:30:22 -0700)

are available in the git repository at:
  ssh://master.kernel.org/pub/scm/linux/kernel/git/rusty/linux-2.6-for-linus.git virtio

Amit Shah (18):
      virtio: console: Reset vdev before removing device
      virtio: console: Remove control vq data only if using multiport support
      virtio: console: Check if portdev is valid in send_control_msg()
      virtio: console: Un-block reads on chardev close
      virtio: console: Unblock poll on port hot-unplug
      virtio: console: Make read() return -ENODEV on hot-unplug
      virtio: console: Make write() return -ENODEV on hot-unplug
      virtio: console: remove_port() should return void
      virtio: console: open: Use a common path for error handling
      virtio: console: Add a list of portdevs that are active
      virtio: console: Add a find_port_by_devt() function
      virtio: console: Use cdev_alloc() instead of cdev_init()
      virtio: console: Add reference counting for port struct
      virtio: console: Reference counting portdev structs is not needed
      virtio: console: Send SIGIO to processes that request it for host events
      virtio: console: Send SIGIO on new data arrival on ports
      virtio: console: Send SIGIO in case of port unplug
      virtio: console: Disable lseek(2) for port file operations

Christoph Hellwig (1):
      virtio_blk: remove BKL leftovers

 drivers/block/virtio_blk.c    |   17 +---
 drivers/char/virtio_console.c |  240 +++++++++++++++++++++++++++++++++++------
 2 files changed, 209 insertions(+), 48 deletions(-)
