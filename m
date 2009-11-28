From: Amit Shah <amit.shah@redhat.com>
Subject: [PATCH 00/28] virtio: console: Fixes, support for generic ports
Date: Sat, 28 Nov 2009 12:20:23 +0530
Message-ID: <1259391051-7752-1-git-send-email-amit.shah@redhat.com>
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
Cc: Amit Shah <amit.shah@redhat.com>, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

Hey Rusty,

This is a respin of my patches on top of the series you posted.

I've taken the liberty to modify your patches for style consistency
and comments where needed, keeping the authorship info intact.

I've had to update a few of your patches for functional changes, I've
changed the authorship info on those patches. The (only) major
functional change is to have a list for ports instead of an array
created at device probe time since we will have hotplug support where
we'll need to add new ports anyway.

I've incorporated some of your comments in this series. My
justifications to a few things that differ (some of this may be a
repeat from my previous mails):

* Only one write buffer: to write entire chunks of a write request, we
  have to have some buffer pool. Entire chunks are needed to be
  written in case of vnc copy/paste buffers as vnc clients only use
  the data in the first buffer otherwise. Better than spinning. Also,
  we can't sleep on the output path since we can be called from irq
  context (from hvc).
  
* One vq per port: We have to pre-declare the number of vqs needed at
  probe-time as a result of the MSI support; port hot-plug becomes
  difficult then.

I've passed each patch through an automated test suite that tests for
all the functionality here (caching, throttling, hotplug, hot-unplug,
console IO) twice: once with a qemu that supports this functionality
and once without. It all works fine.

I've also tested with -smp 2 (though looks like qemu's chardevs
rearrange some buffers in case of fast transfers -- there's a race
somewhere there; I've confirmed the kernel sends out all the data in
proper sequence and that the host virtio device queues it up for the
chardevs in proper sequence as well).

The testsuite tests for:
* the 'name' attribute and the symlinks that get created via udev
  scripts in /dev/virtio-ports
* caching
* throttling
* console - with running 'find /'
* open/close of chardevs
* read/write/poll
* sending a large file (> 100 MB) in either direction and matching
  sha1sums.

Since you pointed out that we need not add new feature bits for each
new functionality here, splitting became easier and I've now come up
with even more (but smaller) patches :-)

Please review.

Thanks,
		Amit

Amit Shah (22):
  virtio: console: We support only one device at a time
  virtio: console: don't assume a single console port.
  virtio: console: struct ports for multiple ports per device.
  virtio: console: ensure console size is updated on hvc open
  virtio: console: Introduce a workqueue for handling host->guest
    notifications
  virtio: console: Buffer data that comes in from the host
  virtio: console: Create a buffer pool for sending data to host
  virtio: console: Separate out console-specific data into a separate
    struct
  virtio: console: Separate out console init into a new function
  virtio: console: Introduce a 'header' for each buffer towards
    supporting multiport
  virtio: console: Add a new MULTIPORT feature, support for generic
    ports
  virtio: console: Associate each port with a char device
  virtio: console: Prepare for writing to / reading from userspace
    buffers
  virtio: console: Add file operations to ports for
    open/read/write/poll
  virtio: console: Ensure only one process can have a port open at a
    time
  virtio: console: Register with sysfs and create a 'name' attribute
    for ports
  virtio: console: Add throttling support to prevent flooding ports
  virtio: console: Add option to remove cached buffers on port close
  virtio: console: Handle port hot-plug
  hvc_console: Export (GPL'ed) hvc_remove
  virtio: console: Add ability to hot-unplug ports
  virtio: console: Add debugfs files for each port to expose debug info

Rusty Russell (6):
  virtio: console: comment cleanup
  virtio: console: statically initialize virtio_cons
  hvc_console: make the ops pointer const.
  virtio: console: port encapsulation
  virtio: console: use vdev->priv to avoid accessing global var.
  virtio: console: remove global var

 drivers/char/Kconfig           |    8 +
 drivers/char/hvc_beat.c        |    2 +-
 drivers/char/hvc_console.c     |    8 +-
 drivers/char/hvc_console.h     |    7 +-
 drivers/char/hvc_iseries.c     |    2 +-
 drivers/char/hvc_iucv.c        |    2 +-
 drivers/char/hvc_rtas.c        |    2 +-
 drivers/char/hvc_udbg.c        |    2 +-
 drivers/char/hvc_vio.c         |    2 +-
 drivers/char/hvc_xen.c         |    2 +-
 drivers/char/virtio_console.c  | 1500 ++++++++++++++++++++++++++++++++++++----
 include/linux/virtio_console.h |   46 ++-
 12 files changed, 1415 insertions(+), 168 deletions(-)
