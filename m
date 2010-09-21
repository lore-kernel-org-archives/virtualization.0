From: Rusty Russell <rusty@rustcorp.com.au>
Subject: [PULL] virtio console fixes and lguest comment fix
Date: Tue, 21 Sep 2010 10:56:34 +0930
Message-ID: <201009211056.37323.rusty__8039.85839379511$1285032528$gmane$org@rustcorp.com.au>
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
Cc: Amit Shah <amit.shah@redhat.com>, Eviatar Khen <eviatarkhen@gmail.com>, linux-kernel@vger.kernel.org, Virtualization List <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

The following changes since commit 2422084a94fcd5038406261b331672a13c92c050:
  Linus Torvalds (1):
        Merge branch 'for-linus' of git://git.kernel.org/.../mattst88/alpha-2.6

are available in the git repository at:

  ssh://master.kernel.org/pub/scm/linux/kernel/git/rusty/linux-2.6-for-linus.git master

Amit Shah (1):
      virtio: console: Prevent userspace from submitting NULL buffers

Hans de Goede (1):
      virtio: console: Fix poll blocking even though there is data to read

Rusty Russell (1):
      lguest: update comments to reflect LHCALL_LOAD_GDT_ENTRY.

 arch/x86/lguest/boot.c        |   13 ++++++++-----
 drivers/char/virtio_console.c |    6 +++++-
 2 files changed, 13 insertions(+), 6 deletions(-)
