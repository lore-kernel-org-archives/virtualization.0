From: Amit Shah <amit.shah@redhat.com>
Subject: [PATCH 0/2] hwrng: don't fetch data before device init
Date: Wed,  2 Jul 2014 15:58:14 +0530
Message-ID: <cover.1404296679.git.amit.shah@redhat.com>
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

Hi,

When booting a recent kernel under KVM with the virtio-rng device
enabled, the boot process was stalling.  Bisect pointed to a commit
made during the 3.15 window to fetch randomness from newly-registered
devices in the hwrng core.  The details are in the patches.

I considered a couple of approaches, but basing on the init() function
being registered, as is done in patch 1 here, seems like the best idea,
since quite a few drivers need to initialize their devices before data
is fetched off them.

Please review and apply if appropriate,

Amit Shah (2):
  hwrng: don't fetch rng from sources without init
  virtio: rng: introduce an init fn for hwrng core

 drivers/char/hw_random/core.c       |  8 +++++---
 drivers/char/hw_random/virtio-rng.c | 11 +++++++++++
 2 files changed, 16 insertions(+), 3 deletions(-)

-- 
1.9.3
