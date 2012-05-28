From: Amit Shah <amit.shah@redhat.com>
Subject: [PATCH 2/5] virtio: rng: allow tasks to be killed that are waiting
	for rng input
Date: Mon, 28 May 2012 12:18:40 +0530
Message-ID: <f2cea033a2a2c5ea88f152e45345689cce7bdb2d.1338187342.git.amit.shah@redhat.com>
References: <cover.1338187342.git.amit.shah@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <cover.1338187342.git.amit.shah@redhat.com>
In-Reply-To: <cover.1338187342.git.amit.shah@redhat.com>
References: <cover.1338187342.git.amit.shah@redhat.com>
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

Use wait_for_completion_killable() instead of wait_for_completion() when
waiting for the host to send us entropy.  Without this,

  # cat /dev/hwrng
  ^C

just hangs.

Signed-off-by: Amit Shah <amit.shah@redhat.com>
---
 drivers/char/hw_random/virtio-rng.c |    5 ++++-
 1 files changed, 4 insertions(+), 1 deletions(-)

diff --git a/drivers/char/hw_random/virtio-rng.c b/drivers/char/hw_random/virtio-rng.c
index 723725b..c8a9350 100644
--- a/drivers/char/hw_random/virtio-rng.c
+++ b/drivers/char/hw_random/virtio-rng.c
@@ -55,6 +55,7 @@ static void register_buffer(u8 *buf, size_t size)
 
 static int virtio_read(struct hwrng *rng, void *buf, size_t size, bool wait)
 {
+	int ret;
 
 	if (!busy) {
 		busy = true;
@@ -65,7 +66,9 @@ static int virtio_read(struct hwrng *rng, void *buf, size_t size, bool wait)
 	if (!wait)
 		return 0;
 
-	wait_for_completion(&have_data);
+	ret = wait_for_completion_killable(&have_data);
+	if (ret < 0)
+		return ret;
 
 	busy = false;
 
-- 
1.7.7.6
