From: Amit Shah <amit.shah@redhat.com>
Subject: [PATCH 0/3] virtio-rng: contribute to early randomness requests
Date: Mon, 21 Jul 2014 15:00:58 +0530
Message-ID: <cover.1405934853.git.amit.shah__20830.6910972626$1405935184$gmane$org@redhat.com>
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

This series enables virtio-rng to service the early randomness
requests made by the hwrng core (patch 2), with Herbert's idea of
using the scan routine.

Patch 3 reverts the previous restriction, which no longer applies, to
not send read requests to the host before successful probe.

Patch 1 is a minor cleanup.

Please review and apply,

Amit Shah (3):
  virtio: rng: remove unused struct element
  virtio: rng: delay hwrng_register() till driver is ready
  Revert "hwrng: virtio - ensure reads happen after successful probe"

 drivers/char/hw_random/core.c       |  6 ------
 drivers/char/hw_random/virtio-rng.c | 35 +++++++++++++++--------------------
 2 files changed, 15 insertions(+), 26 deletions(-)

-- 
1.9.3
