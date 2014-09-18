From: Rusty Russell <rusty@rustcorp.com.au>
Subject: [PATCH 5/5] hw_random: don't init list element we're about to add to
	list.
Date: Thu, 18 Sep 2014 12:18:26 +0930
Message-ID: <1411008506-28349-5-git-send-email-rusty@rustcorp.com.au>
References: <87wq91odhf.fsf@rustcorp.com.au>
	<1411008506-28349-1-git-send-email-rusty@rustcorp.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1411008506-28349-1-git-send-email-rusty@rustcorp.com.au>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Amos Kong <akong@redhat.com>, virtualization@lists.linux-foundation.org, kvm@vger.kernel.org, herbert@gondor.apana.org.au, m@bues.ch, mb@bu3sch.de, mpm@selenic.com, amit.shah@redhat.com, linux-kernel@vger.kernel.org
List-Id: virtualization@lists.linuxfoundation.org

Another interesting anti-pattern.

Signed-off-by: Rusty Russell <rusty@rustcorp.com.au>
---
 drivers/char/hw_random/core.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/char/hw_random/core.c b/drivers/char/hw_random/core.c
index 6a34feca6b43..96fa06716e95 100644
--- a/drivers/char/hw_random/core.c
+++ b/drivers/char/hw_random/core.c
@@ -485,7 +485,6 @@ int hwrng_register(struct hwrng *rng)
 			goto out_unlock;
 		}
 	}
-	INIT_LIST_HEAD(&rng->list);
 	list_add_tail(&rng->list, &rng_list);
 
 	if (old_rng && !rng->init) {
-- 
1.9.1
