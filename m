From: Rusty Russell <rusty@rustcorp.com.au>
Subject: [PULL] virtio-next
Date: Mon, 11 Aug 2014 11:58:50 +0930
Message-ID: <87vbpzahel.fsf@rustcorp.com.au>
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
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Arnd Bergmann <arnd@arndb.de>, LKML <linux-kernel@vger.kernel.org>, virtualization@lists.linux-foundation.org, Fabian Frederick <fabf@skynet.be>, Benoit Taine <benoit.taine@lip6.fr>, Amit Shah <amit.shah@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

The following changes since commit 15ba2236f3556fc01b9ca91394465152b5ea74b6:

  Merge git://git.kernel.org/pub/scm/linux/kernel/git/davem/net (2014-07-21 22:46:01 -0700)

are available in the git repository at:


  git://git.kernel.org/pub/scm/linux/kernel/git/rusty/linux.git tags/virtio-next-for-linus

for you to fetch changes up to eeec626366ffe558fc3d5685bd2b49a962acf57d:

  Revert "hwrng: virtio - ensure reads happen after successful probe" (2014-07-27 21:07:20 +0930)

----------------------------------------------------------------
Cheers,
Rusty.

----------------------------------------------------------------
Amit Shah (4):
      virtio: rng: remove unused struct element
      virtio: rng: re-arrange struct elements for better packing
      virtio: rng: delay hwrng_register() till driver is ready
      Revert "hwrng: virtio - ensure reads happen after successful probe"

Benoit Taine (1):
      virtio: Replace DEFINE_PCI_DEVICE_TABLE macro use

Fabian Frederick (1):
      virtio: console: remove unnecessary null test before debugfs_remove_recursive

 drivers/char/hw_random/core.c       |  6 ------
 drivers/char/hw_random/virtio-rng.c | 39 ++++++++++++++++---------------------
 drivers/char/virtio_console.c       |  6 ++----
 drivers/virtio/virtio_pci.c         |  2 +-
 4 files changed, 20 insertions(+), 33 deletions(-)
