From: Amit Shah <amit.shah@redhat.com>
Subject: [PATCH v2 0/2] hwrng, virtio-rng: init-time fixes
Date: Sat,  5 Jul 2014 11:04:51 +0530
Message-ID: <cover.1404538109.git.amit.shah@redhat.com>
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

v2:
 - this now separates both the patches; the virtio-rng fix is self-contained
 - re-work hwrng core to fetch randomness at device init time if
   ->init() is registered by the device, instead of not calling it at all.
 - virtio-rng: introduce a probe_done bool to ensure we don't ask host
   for data before successful probe

Hi,

When booting a recent kernel under KVM with the virtio-rng device
enabled, the boot process was stalling.  Bisect pointed to a commit
made during the 3.15 window to fetch randomness from newly-registered
devices in the hwrng core.  The details are in the patches.

Turns out there were two bugs: the initial randomness was being
fetched w/o the device being initialized in cases where the init
callback was registered and the device wasn't the first device being
added to the hwrng core.  The second bug is virtio can't communicate
with the host without the device probe is successfully completed.

Please review and apply if appropriate,

Amit Shah (2):
  hwrng: fetch randomness only after device init
  virtio: rng: ensure reads happen after successful probe

 drivers/char/hw_random/core.c       | 37 +++++++++++++++++++++++++++++++------
 drivers/char/hw_random/virtio-rng.c | 10 ++++++++++
 2 files changed, 41 insertions(+), 6 deletions(-)

-- 
1.9.3
