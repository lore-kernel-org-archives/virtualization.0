From: Amit Shah <amit.shah@redhat.com>
Subject: [RFC PATCH 0/3] hw_random: support for delayed init randomness
	requests
Date: Mon, 14 Jul 2014 10:05:18 +0530
Message-ID: <cover.1405277045.git.amit.shah@redhat.com>
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
To: linux-kernel@vger.kernel.org
Cc: jason@lakedaemon.net, keescook@chromium.org, Virtualization List <virtualization@lists.linux-foundation.org>, Amit Shah <amit.shah@redhat.com>, herbert@gondor.apana.org.au
List-Id: virtualization@lists.linuxfoundation.org

Hello,

This series introduces a way to allow devices to contribute to initial
system randomness after a certain delay.  Specifically, the virtio-rng
device can contribute initial randomness only after a successful
probe().

A delayed workqueue item is queued in the system queue to fetch this
randomness if the device indicates it's capable of contributing only
after a delay, via the new HWRNG_DELAY_READ_AT_INIT flag.

This series is intended for the next merge window.  I've marked it as
RFC because the last revert doesn't yet have a linux.git sha1.  I'll
re-post when the previous series gets committed.

Please review,

Amit Shah (3):
  hw_random: allow RNG devices to give early randomness after a delay
  virtio: rng: only accept delayed early randomness requests
  Revert "virtio: rng: ensure reads happen after successful probe"

 drivers/char/hw_random/core.c       | 26 +++++++++++++++++++-------
 drivers/char/hw_random/virtio-rng.c | 11 +----------
 include/linux/hw_random.h           |  8 ++++++++
 3 files changed, 28 insertions(+), 17 deletions(-)

-- 
1.9.3
