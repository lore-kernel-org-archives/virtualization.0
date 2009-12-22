From: Amit Shah <amit.shah@redhat.com>
Subject: [PATCH 00/31] virtio: console: Fixes,
	multiple devices and generic ports
Date: Tue, 22 Dec 2009 20:04:10 +0530
Message-ID: <1261492481-19817-1-git-send-email-amit.shah@redhat.com>
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

This series adds support for generic ports with each port getting two
vqs: one for input and one for output. The host notifies us via the
config space of the max. number of ports that can be added for a
particular device.

As a result of that change, the buffer management for find_readbufs
and send_bufs is moved to the vqs. Only one outbuf per port is used
so we bide away some time in the send_buf routine if output data spans
multiple pages.

There are a few things which aren't done, they can be built upon this
series once it's accepted. One of them is maintaining a list of the
pages that are fed into the virtqueues. This list will be needed when
those buffers have to be freed.

I've passed each patch through an automated test suite that tests for
all the functionality here (caching, throttling, hotplug, hot-unplug,
console IO) twice: once with a qemu that supports this functionality
and once without, to test for backward compat. It all works fine.

The testsuite tests for:
* the 'name' attribute and the symlinks that get created via udev
  scripts in /dev/virtio-ports
* caching
* throttling
* console - with running 'find /' in the guest
* open/close of chardevs
* read/write/poll
* sending a large file (> 100 MB) in either direction and matching
  sha1sums.

Please review.

Thanks,
		Amit

Amit Shah (25):
  hvc_console: Remove __devinit annotation from hvc_alloc
  virtio: console: We support only one device at a time
  virtio: console: encapsulate buffer information in a struct
  virtio: console: ensure add_inbuf can work for multiple ports as well
  virtio: console: introduce a get_inbuf helper to fetch bufs from
    in_vq
  virtio: console: don't assume a single console port.
  virtio: console: struct ports for multiple ports per device.
  virtio: console: ensure console size is updated on hvc open
  virtio: console: Separate out console-specific data into a separate
    struct
  virtio: console: Separate out console init into a new function
  virtio: console: Separate out find_vqs operation into a different
    function
  virtio: console: Buffer data that comes from the host
  virtio: console: Introduce a send_buf function for a common path for
    sending data to host
  virtio: console: Introduce a 'header' for each buffer towards
    supporting multiport
  virtio: console: Add a new MULTIPORT feature, support for generic
    ports
  virtio: console: Prepare for writing to / reading from userspace
    buffers
  virtio: console: Associate each port with a char device
  virtio: console: Add file operations to ports for
    open/read/write/poll
  virtio: console: Ensure only one process can have a port open at a
    time
  virtio: console: Register with sysfs and create a 'name' attribute
    for ports
  virtio: console: Add throttling support to prevent flooding ports
  virtio: console: Add option to remove cached buffers on port close
  virtio: console: Handle port hot-plug
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
 drivers/char/hvc_console.c     |    9 +-
 drivers/char/hvc_console.h     |    9 +-
 drivers/char/hvc_iseries.c     |    2 +-
 drivers/char/hvc_iucv.c        |    2 +-
 drivers/char/hvc_rtas.c        |    2 +-
 drivers/char/hvc_udbg.c        |    2 +-
 drivers/char/hvc_vio.c         |    2 +-
 drivers/char/hvc_xen.c         |    2 +-
 drivers/char/virtio_console.c  | 1575 ++++++++++++++++++++++++++++++++++++----
 include/linux/virtio_console.h |   44 ++-
 12 files changed, 1498 insertions(+), 161 deletions(-)
