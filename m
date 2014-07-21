From: Amit Shah <amit.shah@redhat.com>
Subject: [PATCH v2 2/4] virtio: rng: re-arrange struct elements for better
	packing
Date: Mon, 21 Jul 2014 17:15:50 +0530
Message-ID: <9ffa7e1b77b9d6fd5b5e736bc02a2e2db62aede1.1405942162.git.amit.shah@redhat.com>
References: <cover.1405942162.git.amit.shah@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <cover.1405942162.git.amit.shah@redhat.com>
In-Reply-To: <cover.1405942162.git.amit.shah@redhat.com>
References: <cover.1405942162.git.amit.shah@redhat.com>
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

Re-arrange the elements of the virtrng_info struct to pack it better.

Signed-off-by: Amit Shah <amit.shah@redhat.com>
---
 drivers/char/hw_random/virtio-rng.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/char/hw_random/virtio-rng.c b/drivers/char/hw_random/virtio-rng.c
index d8ffebd..a156284 100644
--- a/drivers/char/hw_random/virtio-rng.c
+++ b/drivers/char/hw_random/virtio-rng.c
@@ -30,11 +30,11 @@ static DEFINE_IDA(rng_index_ida);
 struct virtrng_info {
 	struct hwrng hwrng;
 	struct virtqueue *vq;
-	unsigned int data_avail;
 	struct completion have_data;
-	bool busy;
 	char name[25];
+	unsigned int data_avail;
 	int index;
+	bool busy;
 };
 
 static bool probe_done;
-- 
1.9.3
