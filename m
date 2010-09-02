From: Amit Shah <amit.shah@redhat.com>
Subject: [PATCH 00/14] virtio: console: Hot-unplug fixes
Date: Thu,  2 Sep 2010 18:11:39 +0530
Message-ID: <cover.1283430900.git.amit.shah@redhat.com>
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
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: Amit Shah <amit.shah@redhat.com>, Virtualization List <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

Hey Rusty,

These are the patches that rework a few bits to make hot-unplug while
ports are open not crash apps (or kernels).

The problem is when hot-unplug is performed when a port is open, the
cdev struct is kept around by the file pointers and when the app later
does a 'close', things go boom-boom.

This patch series makes sure port as well as device hot-unplug is now
safe to perform at any time: when ports are open, not open, hvc
consoles are active, inactive, module removal, applications doing
blocking read/write/poll calls while port / devices are going away...

Ideally this patchset would be applicable for 2.6.36 as well as
2.6.35, but I'll let you decide as it's quite big.

Amit Shah (14):
  virtio: console: Reset vdev before removing device
  virtio: console: Remove control vq data only if using multiport
    support
  virtio: console: Check if portdev is valid in send_control_msg()
  virtio: console: Unblock reads on chardev close
  virtio: console: Unblock poll on port hot-unplug
  virtio: console: Make read() return -ENODEV on hot-unplug
  virtio: console: Make write() return -ENODEV on hot-unplug
  virtio: console: remove_port() should return void
  virtio: console: open: Use a common path for error handling
  virtio: console: Add a list of portdevs that are active
  virtio: console: Add a find_port_by_devt() function
  virtio: console: Use cdev_alloc() instead of cdev_init()
  virtio: console: Add reference counting for port struct
  virtio: console: Reference counting portdev structs is not needed

 drivers/char/virtio_console.c |  206 ++++++++++++++++++++++++++++++++++-------
 1 files changed, 173 insertions(+), 33 deletions(-)

-- 
1.7.2.2
