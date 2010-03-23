From: Amit Shah <amit.shah@redhat.com>
Subject: [PATCH 0/7] virtio: console: Fixes,
	new flexible way of discovering ports
Date: Tue, 23 Mar 2010 14:27:53 +0530
Message-ID: <1269334680-1369-1-git-send-email-amit.shah@redhat.com>
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
To: virtualization@lists.linux-foundation.org
Cc: Amit Shah <amit.shah@redhat.com>, mst@redhat.com
List-Id: virtualization@lists.linuxfoundation.org

Hello all,

This new patchset switches over to using the control queue for port
discovery so that we can stay in sync with the host for port
enumeration and also don't use bitmaps to limit us to config space
sizes.

This changes the ABI, so it would be better to merge this for 2.6.34
so that we don't have to worry about released kernels with the older
ABI.

Amit Shah (7):
  MAINTAINERS: Put the virtio-console entry in correct alphabetical
    order
  virtio: console: Remove config work handler
  virtio: console: Add a __send_control_msg() that can send messages
    without a valid port
  virtio: console: Move code around for future patches
  virtio: console: Use a control message to add ports
  virtio: console: Don't always create a port 0 if using multiport
  virtio: console: Return -EPIPE if port on the host isn't connected

 MAINTAINERS                    |   13 +-
 drivers/char/virtio_console.c  |  418 +++++++++++++++++-----------------------
 include/linux/virtio_console.h |   18 +-
 3 files changed, 191 insertions(+), 258 deletions(-)
