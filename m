From: Rusty Russell <rusty@rustcorp.com.au>
Subject: [PULL] lguest comments, virtio fix and final stop_machine_run() remove
Date: Tue, 26 Aug 2008 00:21:40 +1000
Message-ID: <200808260021.40455.rusty@rustcorp.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
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
Cc: Anthony Liguori <aliguori@us.ibm.com>, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

The following changes since commit 83097aca8567a0bd593534853b71fe0fa9a75d69:
  Arjan van de Ven (1):
        Fix oops in acer_wmi driver (acer_wmi_init)

are available in the git repository at:

  ssh://master.kernel.org/pub/scm/linux/kernel/git/rusty/linux-2.6-for-linus.git master

Anthony Liguori (1):
      virtio_balloon: fix towards_target when deflating balloon

Rusty Russell (3):
      stop_machine: wean Xen off stop_machine_run
      stop_machine: Remove deprecated stop_machine_run
      lguest: update commentry

 Documentation/lguest/lguest.c   |    8 ++++++++
 drivers/lguest/lguest_device.c  |    8 ++++++++
 drivers/virtio/virtio_balloon.c |    2 +-
 drivers/xen/manage.c            |    2 +-
 include/linux/stop_machine.h    |   19 +------------------
