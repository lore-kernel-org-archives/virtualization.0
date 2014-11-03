From: Amos Kong <akong@redhat.com>
Subject: [PATCH v4 0/6] fix hw_random stuck
Date: Mon,  3 Nov 2014 23:56:20 +0800
Message-ID: <1415030186-18303-1-git-send-email-akong@redhat.com>
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
To: virtualization@lists.linux-foundation.org
Cc: herbert@gondor.apana.org.au, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, m@bues.ch, mpm@selenic.com, amit.shah@redhat.com, mb@bu3sch.de
List-Id: virtualization@lists.linuxfoundation.org

When I hotunplug a busy virtio-rng device or try to access
hwrng attributes in non-smp guest, it gets stuck.

My hotplug tests:

| test 0:
|   hotunplug rng device from qemu monitor
|
| test 1:
|   guest) # dd if=/dev/hwrng of=/dev/null &
|   hotunplug rng device from qemu monitor
|
| test 2:
|   guest) # dd if=/dev/random of=/dev/null &
|   hotunplug rng device from qemu monitor
|
| test 4:
|   guest) # dd if=/dev/hwrng of=/dev/null &
|   cat /sys/devices/virtual/misc/hw_random/rng_*
|
| test 5:
|   guest) # dd if=/dev/hwrng of=/dev/null
|   cancel dd process after 10 seconds
|   guest) # dd if=/dev/hwrng of=/dev/null &
|   hotunplug rng device from qemu monitor
|
| test 6:
|   use a fifo as rng backend, execute test 0 ~ 5 with no input of fifo


V4: update patch 4 to fix corrupt, decrease last reference for triggering
    the cleanup, fix unregister race pointed by Herbert
V3: initialize kref to 1
V2: added patch 2 to fix a deadlock, update current patch 3 to fix reference
    counting issue

Amos Kong (1):
  hw_random: move some code out mutex_lock for avoiding underlying
    deadlock

Rusty Russell (5):
  hw_random: place mutex around read functions and buffers.
  hw_random: use reference counts on each struct hwrng.
  hw_random: fix unregister race.
  hw_random: don't double-check old_rng.
  hw_random: don't init list element we're about to add to list.

 drivers/char/hw_random/core.c | 176 ++++++++++++++++++++++++++++++------------
 include/linux/hw_random.h     |   3 +
 2 files changed, 129 insertions(+), 50 deletions(-)

-- 
1.9.3
