From: Amit Shah <amit.shah@redhat.com>
Subject: [PATCH 0/3] virtio: console: Handle multiple console port resizes
Date: Thu,  6 May 2010 02:05:06 +0530
Message-ID: <1273091709-19963-1-git-send-email-amit.shah@redhat.com>
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

Hello,

This series adds resize support for multiple console ports. The size
for each console is stored in its structure and the host informs the
guest about size changes via the VIRTIO_CONSOLE_RESIZE control
message.

This is easily tested by the qemu patches provided by Kusanagi Kouichi
with some updates, which I will shortly send to the qemu-devel list.

Please apply,

	Amit.

Amit Shah (3):
  virtio: console: Resize console port 0 on config intr only if
    multiport is off
  virtio: console: Store each console's size in the console structure
  virtio: console: Accept console size along with resize control
    message

 drivers/char/virtio_console.c |   71 ++++++++++++++++++++++++++++++-----------
 1 files changed, 52 insertions(+), 19 deletions(-)
