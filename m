From: Amit Shah <amit.shah@redhat.com>
Subject: [PULL] virtio: S3 support, use PM API macro for init
Date: Sat, 31 Mar 2012 08:29:41 +0530
Message-ID: <20120331025941.GC9769@amit.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, linux-kernel@vger.kernel.org, Virtualization List <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

Linus,

Please pull for virtio-s3/s4 fixes.  I'm taking the liberty to send
this to you directly since Rusty's on vacation.

The patches were posted earlier at

http://www.spinics.net/lists/linux-virtualization/msg15781.html

and have been tested to work fine, here's the message from the
original submission:

Turns out S3 is not different from S4 for virtio devices: the device
is assumed to be reset, so the host and guest state are to be assumed
to be out of sync upon resume.  We handle the S4 case with exactly the
same scenario, so just point the suspend/resume routines to the
freeze/restore ones.

Once that is done, we also use the PM API's macro to initialise the
sleep functions.

A couple of cleanups are included: there's no need for special thaw
processing in the balloon driver, so that's addressed in patches 1 and
2.

Testing: both S3 and S4 support have been tested using these patches
using a similar method used earlier during S4 patch development: a
guest is started with virtio-blk as the only disk, a virtio network
card, a virtio-serial port and a virtio balloon device.  Ping from
guest to host, dd /dev/zero to a file on the disk, and IO from the
host on the virtio-serial port, all at once, while exercising S4 and
S3 (separately) were tested.  They all continue to work fine after
resume.  virtio balloon values too were tested by inflating and
deflating the balloon.

The following changes since commit fa2a4519cb6ad94224eb56a1341fff570fd44ea1:

  Merge git://git.kernel.org/pub/scm/linux/kernel/git/davem/sparc (2012-03-30 18:40:33 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/amit/virtio-console.git s3-for-3.4

Amit Shah (5):
      virtio: balloon: Allow stats update after restore from S4
      virtio: drop thaw PM operation
      virtio-pci: drop restore_common()
      virtio-pci: S3 support
      virtio-pci: switch to PM ops macro to initialise PM functions

 drivers/virtio/virtio_balloon.c |   14 -------
 drivers/virtio/virtio_pci.c     |   74 ++++----------------------------------
 include/linux/virtio.h          |    1 -
 3 files changed, 8 insertions(+), 81 deletions(-)

		Amit
