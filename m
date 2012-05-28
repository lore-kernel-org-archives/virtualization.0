From: Amit Shah <amit.shah@redhat.com>
Subject: [PATCH 0/5] virtio: rng: fixes
Date: Mon, 28 May 2012 12:18:38 +0530
Message-ID: <cover.1338187342.git.amit.shah@redhat.com>
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
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: Amit Shah <amit.shah@redhat.com>, Virtualization List <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

Hi Rusty,

These are a few fixes for the virtio-rng driver.  These were tested
using the not-yet-upstream virtio-rng device patch to qemu:

http://thread.gmane.org/gmane.comp.emulators.qemu/152668

Please apply.

Amit Shah (5):
  virtio ids: fix comment for virtio-rng
  virtio: rng: allow tasks to be killed that are waiting for rng input
  virtio: rng: don't wait on host when module is going away
  virtio: rng: split out common code in probe / remove for s3/s4 ops
  virtio: rng: s3/s4 support

 drivers/char/hw_random/virtio-rng.c |   37 ++++++++++++++++++++++++++++++++--
 include/linux/virtio_ids.h          |    2 +-
 2 files changed, 35 insertions(+), 4 deletions(-)

-- 
1.7.7.6
