From: Amit Shah <amit.shah@redhat.com>
Subject: [PATCH 0/5] virtio: S3 support, use PM API macro for init
Date: Thu, 29 Mar 2012 13:58:06 +0530
Message-ID: <cover.1333008576.git.amit.shah@redhat.com>
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
Cc: Linus Torvalds <torvalds@linux-foundation.org>, "Michael S. Tsirkin" <mst@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

Hello,

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

Please review and apply,

Thanks,

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

-- 
1.7.7.6
