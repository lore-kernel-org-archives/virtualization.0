From: Rusty Russell <rusty@rustcorp.com.au>
Subject: [PULL] lguest and virtio.
Date: Thu, 20 Jan 2011 21:43:31 +1030
Message-ID: <201101202143.32012.rusty__47139.2166022726$1295522157$gmane$org@rustcorp.com.au>
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
Cc: lguest <lguest@ozlabs.org>, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

The following changes since commit 8a335bc631ac9c43675821580c26ebf95a3044ba:

  Merge branch 'for-linus' of git://git.kernel.org/pub/scm/linux/kernel/git/nab/scsi-post-merge-2.6 (2011-01-16 15:06:43 -0800)

are available in the git repository at:

  ssh://master.kernel.org/pub/scm/linux/kernel/git/rusty/linux-2.6-for-linus.git master

Christoph Lameter (1):
      lguest: Use this_cpu_ops

Milton Miller (1):
      virtio: remove virtio-pci root device

Philip Sanderson (3):
      lguest: --username and --chroot options
      lguest: example launcher to use guard pages, drop PROT_EXEC, fix limit logic
      lguest: document --rng in example Launcher

Randy Dunlap (1):
      LGUEST_GUEST: fix unmet direct dependencies (VIRTUALIZATION && VIRTIO)

Rusty Russell (1):
      lguest: compile fixes

 Documentation/lguest/lguest.c   |   73 ++++++++++++++++++++++++++++++++++----
 Documentation/lguest/lguest.txt |    5 +++
 arch/x86/lguest/Kconfig         |    1 +
 arch/x86/lguest/boot.c          |    2 +-
 drivers/lguest/page_tables.c    |    2 +-
 drivers/lguest/x86/core.c       |    4 +-
 drivers/virtio/virtio_pci.c     |   20 +---------
 7 files changed, 77 insertions(+), 30 deletions(-)
