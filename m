From: Amit Shah <amit.shah@redhat.com>
Subject: [PATCH 0/6] virtio: console: Fixes
Date: Fri, 12 Feb 2010 10:32:13 +0530
Message-ID: <1265950939-12359-1-git-send-email-amit.shah@redhat.com>
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

Here are a few fixes for virtio and virtio_console.

The first patch ensures the data elements of vqs are properly
initialised at allocation-time so that we don't trigger BUG_ONs. I found
this when hot-unplugging ports and there was just one unused buffer.
detach_unused_buffers() kept returning pointers that were invalid. I
didn't catch this earlier as I had the in_vq filled completely.

Patches 2, 4 and 5 can be folded into the series as they are bugfixes
for the functionality present there.

About patch 5: When running a test that transfers a 260M file from the
host to the guest, qemu-kvm.git takes 17m with a single outstanding
buffer in the in_vq vs. 1m when the entire in_vq is filled. This is a
bug in qemu-kvm.git's scheduling, but since it's a big difference and
not much change involved, we could merge this now.

Comments?

If these patches are favourable, I could send you a tarball in private
so that the bugfixes are folded in the series and just patches 1, 3 and
6 are added.

Thanks,

		Amit.

Amit Shah (6):
  virtio: Initialize vq->data entries to NULL
  virtio: console: Ensure no memleaks in case of unused buffers
  virtio: console: Add ability to remove module
  virtio: console: Error out if we can't allocate buffers for control
    queue
  virtio: console: Fill ports' entire in_vq with buffers
  Add MAINTAINERS entry for virtio_console

 MAINTAINERS                   |    6 ++
 drivers/char/virtio_console.c |  132 +++++++++++++++++++++++++++++++---------
 drivers/virtio/virtio_ring.c  |    5 +-
 3 files changed, 112 insertions(+), 31 deletions(-)
