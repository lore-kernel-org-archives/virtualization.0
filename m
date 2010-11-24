From: Rusty Russell <rusty@rustcorp.com.au>
Subject: [PULL] virtio fixes (and one trivial module cleanup)
Date: Wed, 24 Nov 2010 15:28:06 +1030
Message-ID: <201011241528.06934.rusty__49381.4077265144$1290574865$gmane$org@rustcorp.com.au>
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
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Anders Kaseorg <andersk@ksplice.com>, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, Stephen Hemminger <shemminger@vyatta.com>, Jiri Slaby <jslaby@suse.cz>
List-Id: virtualization@lists.linuxfoundation.org

(lguest is currently broken, but timed out chasing it; expect a patch next
 week once I get back).

The following changes since commit 3561d43fd289f590fdae672e5eb831b8d5cf0bf6:

  Linux 2.6.37-rc3 (2010-11-21 15:18:56 -0800)

are available in the git repository at:
  ssh://master.kernel.org/pub/scm/linux/kernel/git/rusty/linux-2.6-for-linus.git master

Anders Kaseorg (1):
      module: Update prototype for ref_module (formerly use_module)

Jiri Slaby (1):
      Char: virtio_console, fix memory leak

Michael S. Tsirkin (1):
      virtio: return correct capacity to users

Stephen Hemminger (1):
      virtio: fix format of sysfs driver/vendor files

 drivers/char/virtio_console.c |   37 +++++++++----------------------------
 drivers/virtio/virtio.c       |    6 +++---
 drivers/virtio/virtio_ring.c  |    3 ---
 include/linux/module.h        |    2 +-
 4 files changed, 13 insertions(+), 35 deletions(-)
