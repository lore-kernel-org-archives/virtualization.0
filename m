From: Amit Shah <amit.shah@redhat.com>
Subject: [PATCH 00/11] (v6) virtio: console: Fixes,
	new way of discovering ports
Date: Thu,  8 Apr 2010 20:19:29 +0530
Message-ID: <1270738180-21170-1-git-send-email-amit.shah@redhat.com>
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
To: Virtualization List <virtualization@lists.linux-foundation.org>
Cc: Amit Shah <amit.shah@redhat.com>, Juan Quintela <quintela@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

Hello,

This series reworks the ABI to allow port discovery (only) via the
control queue and enable multiport again.

In addition, it adds support for non-blocking write() support, which
means no spinning. This works fine with the recent patches that are on
qemu-devel.

Also included is removal of hvc_remove() as removing one such console
port causes other console ports (registered with hvc) to stall. This
has to be debugged in the hvc_console.c file, I'll do that later, but
we have a nice workaround for this: returning -EPIPE on any hvc
operations will make the hvc console core perform any cleanups for the
removed ports. Looks like we don't lose much by removing hvc_remove().

New in this version:
- Locking for the out_vq. Slightly changed version compared to the
  diff I sent earlier in that I don't lock inside
  reclaim_used_buffers() now, letting us use spin_lock_irq() instead
  of spin_lock_irqsave() from non-irq contexts.
- Remove extra line spotted by Rusty

Rusty, please apply for -next if all is well.

Amit Shah (11):
  Revert "virtio: disable multiport console support."
  virtio: console: Add a __send_control_msg() that can send messages
    without a valid port
  virtio: console: Let host know of port or device add failures
  virtio: console: Return -EPIPE to hvc_console if we lost the
    connection
  virtio: console: Don't call hvc_remove() on unplugging console ports
  virtio: console: Remove config work handler
  virtio: console: Move code around for future patches
  virtio: console: Use a control message to add ports
  virtio: console: Don't always create a port 0 if using multiport
  virtio: console: Rename wait_is_over() to will_read_block()
  virtio: console: Add support for nonblocking write()s

 drivers/char/virtio_console.c  |  605 ++++++++++++++++++++--------------------
 include/linux/virtio_console.h |   25 ++
 2 files changed, 334 insertions(+), 296 deletions(-)
