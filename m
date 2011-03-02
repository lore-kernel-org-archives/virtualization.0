From: Amit Shah <amit.shah@redhat.com>
Subject: [PATCH 0/2] Fix hot-unplug: device removal while port in use
Date: Wed,  2 Mar 2011 13:53:06 +0530
Message-ID: <cover.1299054025.git.amit.shah@redhat.com>
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
Cc: Amit Shah <amit.shah@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

A crash was observed when a device gets removed while a port is in
use.  When the port gets removed, we tried to free vq buffers.  The vq
no longer exists at this stage, just ensure we don't access it.

The second patch fixes a warning where the pci region is already
freed.  I'm not sure what or how the region gets freed, any clues
there will be helpful.

Thanks,
		Amit

Amit Shah (2):
  virtio: console: Don't access vqs if device was unplugged
  virtio: console: Don't call device_destroy() on port device

 drivers/char/virtio_console.c |   10 +++++++++-
 1 files changed, 9 insertions(+), 1 deletions(-)

-- 
1.7.4
