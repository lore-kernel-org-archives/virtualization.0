From: Amit Shah <amit.shah@redhat.com>
Subject: [PATCH v3 0/9] virtio: console: fixes for bugs and races with unplug
Date: Thu, 25 Jul 2013 19:28:40 +0530
Message-ID: <cover.1374759439.git.amit.shah@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Virtualization List <virtualization@lists.linux-foundation.org>
Cc: Amit Shah <amit.shah@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

Hello,

This series fixes a few bugs and races with port unplug and the
various file operations: read(), write() and close().

I started coding up an alternative locking mechanism based on the
discussion earlier in this series, but some of what we already have
has to remain, and the new code is sufficiently different, so I'd
rather it bakes for a while, and I ensure there are no regressions wrt
the tests I have so far for a while as well.  Hopefully this will be
in time for the next merge window.

There's one use-after-free I spotted after sending the first two
versions: port_fops_release() calls send_control_msg(), which spins
till the host acknowledges receipt of the buffer.  While it's
spinning, if the device gets unplugged, the vqs go away, and the
spinning function never progresses, causing a softlockup.  This is
difficult to reproduce -- the host usually acknowledges the buffers
fast enough.  A couple of solutions for this case are possible:

1. Mark the control vq in use, and don't proceed with unplug till it's
   marked unused,
2. Similar to the various port-specific i and o vqs, don't spin, but
   queue the buffer and wait for the host to let us know it's done
   with it.

2nd is easier to implement, but 1st fits with the way I'm thinking of
restructuring the locking.  I'm not yet decided on which approach to
take, will think over it.

Other than that, this series does fix all the bugs I see with the
tests I have.  Indeed, the patches marked for stable@ fix all the bugs
too, and the other ones on top add locking where shared structures are
being used.

Please review and apply if appropriate,

v3
 * remove patch 5, "update private_data in struct file only on
   successful open" (Rusty)
 * remove patch 6, "fix race in port_fops_poll() and port unplug",
   (Rusty)
 * remove CC: stable from patches without reproducers

v2
 * add patch 11: Jason found a use-after-free in port unplug
 * patch 7 introduced a regression where the wake_up_interruptible was
   done before guest_connected and host_connected were set to false

Amit Shah (9):
  virtio: console: fix race with port unplug and open/close
  virtio: console: fix race in port_fops_open() and port unplug
  virtio: console: clean up port data immediately at time of unplug
  virtio: console: fix raising SIGIO after port unplug
  virtio: console: return -ENODEV on all read operations after unplug
  virtio: console: add locks around buffer removal in port unplug path
  virtio: console: add locking in port unplug path
  virtio: console: fix locking around send_sigio_to_port()
  virtio: console: prevent use-after-free of port name in port unplug

 drivers/char/virtio_console.c | 64 +++++++++++++++++++++++++++----------------
 1 file changed, 40 insertions(+), 24 deletions(-)

-- 
1.8.1.4
