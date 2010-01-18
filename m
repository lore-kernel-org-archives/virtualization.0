From: Amit Shah <amit.shah@redhat.com>
Subject: [PATCH 00/32] virtio: console: Fixes,
	multiple devices and generic ports
Date: Mon, 18 Jan 2010 19:14:54 +0530
Message-ID: <1263822326-24208-1-git-send-email-amit.shah@redhat.com>
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

In this version:
- Assume only one inbuf; no input buffering for ports
- Remove the START/END delimiters for outgoing buffers
- Remove the header that was sent along with each buffer
- Remove unused buffers in the vqs at port remove time
- Send a guest port open message to the host when a console port is
  attached
- Remove cached buffers when ports are closed / disconnected
- Send only one buffer in send_buf

As usual, this series is passed through the testsuite that tests for
the functionality given here.

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
  virtio: console: Introduce function to hand off data from host to
    readers
  virtio: console: Introduce a send_buf function for a common path for
    sending data to host
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
  virtio: console: Remove cached data on port close
  virtio: console: Handle port hot-plug
  virtio: console: Add ability to hot-unplug ports
  virtio: console: Add debugfs files for each port to expose debug info
  virtio: console: show error message if hvc_alloc fails for console
    ports

Rusty Russell (6):
  virtio: console: comment cleanup
  virtio: console: statically initialize virtio_cons
  hvc_console: make the ops pointer const.
  virtio: console: port encapsulation
  virtio: console: use vdev->priv to avoid accessing global var.
  virtio: console: remove global var

Shirley Ma (1):
  virtio: Add ability to detach unused buffers from vrings

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
 drivers/char/virtio_console.c  | 1559 ++++++++++++++++++++++++++++++++++++----
 drivers/virtio/virtio_ring.c   |   25 +
 include/linux/virtio.h         |    4 +
 include/linux/virtio_console.h |   31 +-
 14 files changed, 1496 insertions(+), 163 deletions(-)
