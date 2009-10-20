From: Amit Shah <amit.shah@redhat.com>
Subject: [PATCH v9 0/1] virtio-console: Support for generic ports and multiple
	consoles
Date: Tue, 20 Oct 2009 11:24:54 +0530
Message-ID: <1256018095-19400-1-git-send-email-amit.shah__3152.69704810834$1256018220$gmane$org@redhat.com>
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
To: rusty@rustcorp.com.au
Cc: Amit Shah <amit.shah@redhat.com>, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

Hello all,

Here is a new iteration of the patch series that implements a
transport for guest and host communications.

I've tested for compatibility (old qemu & new kernel, new qemu & old
kernel, new qemu & new kernel) and it all works fine. To maintain
backward compatibility, the first port to be spawned (port at id 0) is
to be a console port, to be bound to hvc. This keeps new host, old
guest happy.

A testsuite is put up at the following site that has an interactive
test program that can be run in the guest. It also has an automated
test suite that tests the major functionalities presented here:

    http://fedorapeople.org/gitweb?p=amitshah/public_git/test-virtserial.git

This version passes all the automated tests there.

Christian has tested the console functionality on s390.

v9:
- Add debugfs files for each port to expose some port-specific information for
  easier debugging
- Port hotplug fix
- Disallow opening of console ports (open(/dev/vcon0) should fail)
- A couple of other minor fixes.

Please review and apply,
	Amit

Amit Shah (1):
  virtio_console: Add support for multiple ports for generic guest and
    host communication

 drivers/char/Kconfig           |    6 +
 drivers/char/virtio_console.c  | 1372 ++++++++++++++++++++++++++++++++++++----
 include/linux/virtio_console.h |   50 ++-
 3 files changed, 1292 insertions(+), 136 deletions(-)
