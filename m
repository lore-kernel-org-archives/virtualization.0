From: Amit Shah <amit.shah@redhat.com>
Subject: [PATCH v10 0/1] virtio-console: Support for generic ports and
	multiple consoles
Date: Tue,  3 Nov 2009 22:08:38 +0530
Message-ID: <1257266319-24300-1-git-send-email-amit.shah__4617.19261152229$1257266515$gmane$org@redhat.com>
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
To: linux-kernel@vger.kernel.org, rusty@rustcorp.com.au
Cc: Amit Shah <amit.shah@redhat.com>, virtualization@linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

(Rusty, would it improve the chances of getting this patch in your
tree if this description were written with latex instead of without
it?)

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

v10:
- only one process can open a port in the guest
- minor fixes for throttling and caching cases


Please review and apply,
	Amit

Amit Shah (1):
  virtio_console: Add support for multiple ports for generic guest and
    host communication

 drivers/char/Kconfig           |    6 +
 drivers/char/virtio_console.c  | 1412 ++++++++++++++++++++++++++++++++++++----
 include/linux/virtio_console.h |   50 ++-
 3 files changed, 1332 insertions(+), 136 deletions(-)
